# http://click.pocoo.org/5/

# -----------------------------------------------------------------
import click


@click.command()
@click.option('--count', default=1, help='Number of greetings.')
@click.option('--name', prompt='Your name',
              help='The person to greet.')
def hello(count, name):
    """Simple program that greets NAME for a total of COUNT times."""
    for x in range(count):
        click.echo('Hello %s!' % name)

# if __name__ == '__main__':
#     hello()


# -----------------------------------------------------------------
# ### flag

import sys


@click.command()
@click.option('--shout', is_flag=True)
def info(shout):
    rv = sys.platform
    if shout:
        rv = rv.upper() + '!!!!111'
    click.echo(rv)


# -----------------------------------------------------------------
# ### multi value


@click.command()
@click.option('--pos', nargs=2, type=float)
def findme(pos):
    click.echo('%s / %s' % pos)


# -----------------------------------------------------------------
# ### group 1


@click.group()
def cli():
    pass


@click.command()
def initdb():
    click.echo('Initialized the database')


@click.command()
def dropdb():
    click.echo('Dropped the database')


cli.add_command(initdb)
cli.add_command(dropdb)


# -----------------------------------------------------------------
# ### group 2

@click.group()
@click.option('--debug/--no-debug', default=False)
@click.pass_context
def cli(ctx, debug):
    ctx.obj['DEBUG'] = debug


@cli.command()
@click.pass_context
def sync(ctx):
    click.echo('Debug is %s' % (ctx.obj['DEBUG'] and 'on' or 'off'))

# if __name__ == '__main__':
#     cli(obj={})

# -----------------------------------------------------------------
# ### swhich

import sys


@click.command()
@click.option('--upper', 'transformation', flag_value='upper',
              default=True)
@click.option('--lower', 'transformation', flag_value='lower')
def info(transformation):
    click.echo(getattr(sys.platform, transformation)())


# -----------------------------------------------------------------
# ### choice

@click.command()
@click.option('--hash-type', type=click.Choice(['md5', 'sha1']))
def digest(hash_type):
    click.echo(hash_type)

# -----------------------------------------------------------------
# ### prompt


@click.command()
@click.option('--name', prompt=True)
def hello(name):
    click.echo('Hello %s!' % name)
