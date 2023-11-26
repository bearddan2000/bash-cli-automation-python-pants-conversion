#! /bin/bash
function normalize_entrypoint(){
    local dir=$1
    
    if [[ -e $dir/bin/app.py ]]; then
      mv $dir/bin/app.py $dir/bin/main.py
    elif [[ -e $dir/py-srv/bin/app.py ]]; then
      mv $dir/py-srv/bin/app.py $dir/py-srv/bin/main.py
    fi
}

function replace_Dockerfile(){
    local dir=$1

    if [[ -e $dir/Dockerfile ]]; then
        rm -f $dir/Dockerfile
        case $dir in
            *web* )
                cp .src/Dockerfile $dir;;
            *desktop* )
                cp .src/Dockerfile-desktop $dir;;
            *cli* )
                cp .src/Dockerfile $dir;;
        esac
    else
        rm -f $dir/py-srv/Dockerfile
        case $dir in
            *web* )
                cp .src/Dockerfile $dir/py-srv;;
            *desktop* )
                cp .src/Dockerfile-desktop $dir/py-srv;;
            *cli* )
                cp .src/Dockerfile $dir/py-srv;;
        esac
    fi
}

function replace_install(){
    local dir=$1

    if [[ -e $dir/docker-compose.yml ]]; then
        exit 0
    fi

    case $dir in
        *web* )
            rm -f $dir/install.sh &&
            cp .src/install-web.sh $dir/install.sh;;
        *desktop* )
            rm -f $dir/install.sh &&
            cp .src/install-desktop.sh $dir/install.sh;;
        *cli* )
            rm -f $dir/install.sh &&
            cp .src/install-cli.sh $dir/install.sh;;
    esac
}

function build_pants(){
  local dir=$1

  #copy BUILD file from src folder
  cp .src/BUILD $dir

  cp .src/pants.toml $dir
  
}

d=$1
e=$d/bin
f=$d/py-srv/bin

if [[ -e $e ]]; then
  build_pants $e
else
  build_pants $f
fi

if [[ -e $d/Dockerfile ]]; then
  rm -f $d/Dockerfile
  case $d in
    *web* )
      cp .src/Dockerfile $d;;
    *desktop* )
      cp .src/Dockerfile-desktop $d;;
    *cli* )
      cp .src/Dockerfile $d;;
  esac
else
  rm -f $d/py-srv/Dockerfile
  case $d in
    *web* )
      cp .src/Dockerfile $d/py-srv;;
    *desktop* )
      cp .src/Dockerfile-desktop $d/py-srv;;
    *cli* )
      cp .src/Dockerfile $d/py-srv;;
  esac
fi

if [[ -e $d/docker-compose.yml ]]; then
  exit 0
fi

case $d in
  *web* )
    rm -f $d/install.sh &&
    cp .src/install-web.sh $d/install.sh;;
  *desktop* )
    rm -f $d/install.sh &&
    cp .src/install-desktop.sh $d/install.sh;;
  *cli* )
    rm -f $d/install.sh &&
    cp .src/install-cli.sh $d/install.sh;;
esac