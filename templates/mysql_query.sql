-- where 狙いのインデックスと order by 狙いのインデックス
--   http://www.slideshare.net/yoku0825/whereorder-by
-- explainについて
--   http://nippondanji.blogspot.jp/2009/03/mysqlexplain.html

-- ### create table
CREATE TABLE IF NOT EXISTS `a_db`.`sample` (
  -- INTEGER と INT は同じ
  -- max = 2147483647, unsigned なら max = 4294967295
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'コメント',
  -- max = 9223372036854775807, unsigned なら max = 18446744073709551615
  `big_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'コメント',
  `c1` VARCHAR(255) NOT NULL DEFAULT 'hoge' COMMENT 'コメント',
  -- DECIMAL(全体桁数, 小数点以下桁数)
  `c2` DECIMAL(6,3) NOT NULL DEFAULT '0.001',
  `c_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  -- PRIMARY KEY (t1ID, t2ID) composit key
  UNIQUE KEY `c1` (`c1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='コメント'

-- ### alter table add column
ALTER TABLE `sample` ADD c100 VARCHAR(255) AFTER `already_exists_column`;
ALTER TABLE `sample` ADD c100 VARCHAR(255) FIRST; -- 先頭に追加
ALTER TABLE `sample` ADD (c100 VARCHAR(255), c101 INT); -- 複数も可能

-- ### alter table rename table
ALTER TABLE `sample` RENAME TO `sample2`;

-- ### alter table change column
-- ALTER TABLE <テーブル名>
--   CHANGE COLUMN <既存の列名> <新しい列名> <型名> <制約>;
ALTER TABLE `sample`
  CHANGE COLUMN author_name author VARCHAR(32) NOT NULL;

-- ### alter table modify column
-- ALTER TABLE <テーブル名>
--   MODIFY COLUMN <既存の列名> <新しいデータ型名> [<制約>];
ALTER TABLE book_list MODIFY COLUMN title VARCHAR(128) NOT NULL;

-- ### alter table drop column
-- ALTER TABLE <テーブル名> DROP COLUMN <対象の列名>;
ALTER TABLE book_list DROP COLUMN title;

-- ### alter table add index (and unique)
ALTER TABLE book_list ADD INDEX `ix_title` (`title`);
ALTER TABLE book_list ADD UNIQUE INDEX `ix_title_id` (`title_id`);

-- ### alter table rename index (and unique)
ALTER TABLE book_list RENAME INDEX `ix_title` TO `new_ix_title`;

-- ### insert on duplicate key update
-- aがpk だった場合にa=1のレコードがすでにある場合はcを3でupdateする
INSERT INTO table (a,b,c) VALUES (1,2,3) ON DUPLICATE KEY UPDATE c=VALUES(c);
-- aがpk だった場合にa=1のレコードがすでにある場合はcを既存のcの値+1とする
INSERT INTO table (a,b,c) VALUES (1,2,3) ON DUPLICATE KEY UPDATE c=c+1;
