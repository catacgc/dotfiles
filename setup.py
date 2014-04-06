from sh import curl, ln, rm
import shutil
import os

def setup():
    # vimrc
    download(".vimrc")
    download(".gitconfig")
    copy(".vimrc", "~/.vimrc")

    # path settings
    bashrc_config = [
      "source " + fullpath("./env/bin/activate")
    ]
    write_config("~/.bashrc", bashrc_config, "Auto setup-up. DONT't change")
    
    

def describe(f):
    def _d(*args, **kwargs):
        print "%s %s %s" % (f.__name__.capitalize(), ", ".join([str(arg) for arg in args]), kwargs)
        return f(*args, **kwargs)
    return _d

def furl(f):
    return 'https://raw.githubusercontent.com/catacgc/dotfiles/master/%s' % f

def fullpath(f):
    return os.path.realpath(os.path.expanduser(f))

@describe
def download(f):
    curl(furl(f), "-sO")

def copy(source, dest):
    describe(shutil.copy)(fullpath(source), fullpath(dest))

@describe
def write_config(fname, config, label, sep=' ### '):
    result = []
    with open(fullpath(fname), 'r+') as f:
        for line in f.readlines():
            if line.find(sep + label) == -1:
                result.append(line)

        config  = [line + sep + label + "\n" for line in config]
        result.extend(config)
        f.seek(0)
        f.writelines(result)
        
if __name__ == '__main__':
    setup()
    
