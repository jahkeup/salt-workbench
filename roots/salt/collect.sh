#!/bin/bash
operative_word=awesome

function collect_from_dir {
    local dir=$1
    local kind=$2
    local pys=$(ls $dir/*.py 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        echo "No $operative_word states in dir $dir."
        return
    fi
    for py in $pys; do
        echo "gathering $operative_word"s" - $py -> $kind"
        cp $py $kind
    done
}

function clear_kind {
    local kind=$1
    if [[ "$PWD" =~ roots/salt$ ]] || [[ "$PWD" = "/srv/salt" ]]; then
        rm -rf $PWD/$kind/*
        mkdir -p $PWD/$kind
        touch $PWD/$kind/.gitkeep
    else
        echo "You are not in the top level of the root."
        echo "You're in '$PWD'"
        printf "I refuse to run $operative_word"ly". Change to 'roots/salt' "
        echo "then come back."
        exit 1
    fi
}

for kind in _states _modules; do
    clear_kind $kind
    dirs=$(find . -name $kind)
    echo "Collecting $operative_word for $kind..."
    echo "Found $(echo $dirs | wc -l) dirs to work on."
    for dir in $dirs; do
        collect_from_dir $dir ./$kind
    done
done
echo
sync=
if [[ $1 = "-u" ]]; then
    which salt 2>&1>/dev/null
    if [[ $? -ne 0 ]]; then
	pre_cmd="salt-call"
    else
	pre_cmd="salt '*'"
    fi
    $pre_cmd saltutil.sync_states
    $pre_cmd saltutil.sync_modules
    sync=" and synced"
fi
echo
echo "Your $operative_word states and modules have been gathered$sync, now go."
