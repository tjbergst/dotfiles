# --------------------------------- DOCKER ---------------------------------

alias docker='/mnt/c/"Program Files"/Docker/Docker/resources/bin/docker.exe'

# run wrapper 
function dkrun() {
    # args: $container, $shell='zsh'
    readonly container=${1:?"The container must be specified."}
    if [[ ! $2 ]] ; then cont_shell='zsh' ; else cont_shell=$2 ; fi 

    docker run -it --rm $container $cont_shell
}

# logs wrapper 
function dk-logs() {
    # args: $container, --tail=None
    readonly container=${1:?"The container must be specified."}

    if [[ ! -z $2 ]] 
        then docker logs --tail $2 -f $container 
    else 
        docker logs -f $container 
    fi 

}


function dki() {
    # args: $filter=None, $notfilter=None
    img_cmd="docker images --format 'table {{.ID}} : {{.Repository}}\t{{.CreatedSince}}\t{{.Size}}'"

    if [[ ! -z $1 ]] 
        then img_cmd="$img_cmd | grep -i --color=never $1"
    fi
    
    if [[ ! -z $2 ]] 
        then img_cmd="$img_cmd | grep -i --color=never -v $2"
    fi

    eval $img_cmd
}


function dkps() {
    # args: $filter=None, $notfilter=None
    img_cmd="docker ps -a --format 'table {{.ID}} : {{.Image}}\t{{.Command}}\t{{.Status}}\t{{.Names}}\t{{.Ports}}'"

    if [[ ! -z $1 ]] 
        then img_cmd="$img_cmd | grep -i --color=never $1"
    fi
    
    if [[ ! -z $2 ]] 
        then img_cmd="$img_cmd | grep -i --color=never -v $2"
    fi

    eval $img_cmd
}

function dk-tagpush() {
    docker tag $1 $2 && docker push $2
}


