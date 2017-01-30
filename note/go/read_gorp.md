[gorpを読む]
===================

SetUniqueTogether(fieldNames ...string)

```
// SetUniqueTogether lets you specify uniqueness constraints across multiple
// columns on the table. Each call adds an additional constraint for the
// specified columns.
//
// Automatically calls ResetSql() to ensure SQL statements are regenerated.
//
// Panics if fieldNames length < 2.
//
```
なるほど。複数カラムでの unique も設定できるらしい

optimistic lock も version カラムを宣言するとできるぽいな。

```
type bindPlan struct {
	query             string
	argFields         []string
	keyFields         []string
	versField         string
	autoIncrIdx       int
	autoIncrFieldName string
}
```

なんぞや

query の実行計画てきな？

```
type bindInstance struct {
	query             string
	args              []interface{}
	keys              []interface{}
	existingVersion   int64
	versField         string
	autoIncrIdx       int
	autoIncrFieldName string
}
```

てのもあるな。。。

bindPlan をもとに bindInstance で 実体化させるみたいな？

bindInsert とか bindUpdate みたいなメソッドがある？
でもこれは *TableMap に生えてるな。
それぞれ bindIntance を返している。。


ちなみに以下が insert の実際の処理
ながい

```
func insert(m *DbMap, exec SqlExecutor, list ...interface{}) error {
	for _, ptr := range list {
		table, elem, err := m.tableForPointer(ptr, false)
		if err != nil {
			return err
		}

		eval := elem.Addr().Interface()
		if v, ok := eval.(HasPreInsert); ok {
			err := v.PreInsert(exec)
			if err != nil {
				return err
			}
		}

		bi, err := table.bindInsert(elem)
		if err != nil {
			return err
		}

		if bi.autoIncrIdx > -1 {
			f := elem.FieldByName(bi.autoIncrFieldName)
			switch inserter := m.Dialect.(type) {
			case IntegerAutoIncrInserter:
				id, err := inserter.InsertAutoIncr(exec, bi.query, bi.args...)
				if err != nil {
					return err
				}
				k := f.Kind()
				if (k == reflect.Int) || (k == reflect.Int16) || (k == reflect.Int32) || (k == reflect.Int64) {
					f.SetInt(id)
				} else if (k == reflect.Uint) || (k == reflect.Uint16) || (k == reflect.Uint32) || (k == reflect.Uint64) {
					f.SetUint(uint64(id))
				} else {
					return fmt.Errorf("gorp: Cannot set autoincrement value on non-Int field. SQL=%s  autoIncrIdx=%d autoIncrFieldName=%s", bi.query, bi.autoIncrIdx, bi.autoIncrFieldName)
				}
			case TargetedAutoIncrInserter:
				err := inserter.InsertAutoIncrToTarget(exec, bi.query, f.Addr().Interface(), bi.args...)
				if err != nil {
					return err
				}
			default:
				return fmt.Errorf("gorp: Cannot use autoincrement fields on dialects that do not implement an autoincrementing interface")
			}
		} else {
			_, err := exec.Exec(bi.query, bi.args...)
			if err != nil {
				return err
			}
		}

		if v, ok := eval.(HasPostInsert); ok {
			err := v.PostInsert(exec)
			if err != nil {
				return err
			}
		}
	}
	return nil
}
```

```
func (m *DbMap) tableForPointer(ptr interface{}, checkPK bool) (*TableMap, reflect.Value, error) {
	ptrv := reflect.ValueOf(ptr)
	if ptrv.Kind() != reflect.Ptr {
		e := fmt.Sprintf("gorp: passed non-pointer: %v (kind=%v)", ptr,
			ptrv.Kind())
		return nil, reflect.Value{}, errors.New(e)
	}
	elem := ptrv.Elem()
	etype := reflect.TypeOf(elem.Interface())
	t, err := m.TableFor(etype, checkPK)
	if err != nil {
		return nil, reflect.Value{}, err
	}

	return t, elem, nil
}
```

ptr には 実際にinsertしたりする modelのインスタンスがくる
( u *User ) みたいなやつ。

reflect の Elem() てなんやっけ?
とおもたけど これ は reflect.Value をそのままコピるだけか？

```
func (Value) Elem

func (v Value) Elem() Value
Elem returns the value that the interface v contains or that
the pointer v points to. It panics if v's Kind is not Interface or Ptr.
It returns the zero Value if v is nil.
```

と書いてある
??
とにかく, tableForに渡しているな

こんなやつ

```
// TableFor returns the *TableMap corresponding to the given Go Type
// If no table is mapped to that type an error is returned.
// If checkPK is true and the mapped table has no registered PKs, an error is returned.
func (m *DbMap) TableFor(t reflect.Type, checkPK bool) (*TableMap, error) {
	table := tableOrNil(m, t)
	if table == nil {
		return nil, errors.New(fmt.Sprintf("No table found for type: %v", t.Name()))
	}

	if checkPK && len(table.keys) < 1 {
		e := fmt.Sprintf("gorp: No keys defined for table: %s",
			table.TableName)
		return nil, errors.New(e)
	}

	return table, nil
}
```

最初にセットした tableMap を引数の型から判別して返す感じか


```
		eval := elem.Addr().Interface()
    // 実際の値を取得したやつが eval ?
    // でそれが interface(HasPreInsert) をみたすかどうか
		if v, ok := eval.(HasPreInsert); ok {
			err := v.PreInsert(exec)
			if err != nil {
				return err
			}
		}
```

```
func (Value) Addr

func (v Value) Addr() Value
Addr returns a pointer value representing the address of v.
It panics if CanAddr() returns false.
Addr is typically used to obtain a pointer to a struct field or
slice element in order to call a method that requires a pointer receiver.
```

ちな

func (v Value) Interface() (i interface{})
Interface returns v's current value as an interface{}. It is equivalent to:

である。

table.bindInsert(elem)

いよいよこれか。

なんかなかで普通に文字列結合とかしながら query くんでるな？

t.insertPlan

てかそもそこれなに
bindPlan てなんやねん。これの説明をかけよ！


bindInsert の最後に

return plan.createBindInstance(elem, t.dbmap.TypeConverter)

これをしているな。
さっぱりじゃ

あ、そうか。

さきに "?" をつかって sql を組んでそれに bind する instaceを
create するってことか

createBindInstance のなかで ToDB してるな
ToDbメソッドのなかで 型から 判別して クオートするとかしないとか
Null とか time とかを変換してるぽいな

Inserter と SqlExecutor がおる???


