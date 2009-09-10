# ZenPack Development Helpers
ZENPACKSOURCES="
--source=$ZENHOME/core-zenpacks
--source=$ZENHOME/enterprise-zenpacks
--source=$ZENHOME/customer-zenpacks
--source=$ZENHOME/community-zenpacks
--source=$ZENHOME/my-zenpacks
--source=$ZENHOME/cs-zenpacks
"

zp () {
    case "${1}" in
        cd)
            cd "$(zpt $ZENPACKSOURCES --match $2)"
            ;;
        cdr)
            cd "$(zpt $ZENPACKSOURCES --match $2 --rootdir)"
            ;;
        pushd)
            pushd "$(zpt $ZENPACKSOURCES --match $2)"
            ;;
        pushdr)
            pushd "$(zpt $ZENPACKSOURCES --match $2 --rootdir)"
            ;;
        mate)
            mate "$(zpt $ZENPACKSOURCES --match $2)"
            ;;
        mater)
            mate "$(zpt $ZENPACKSOURCES --match $2 --rootdir)"
            ;;
        install)
            installPath="$(zpt $ZENPACKSOURCES --match $2 --rootdir)"
            zenpack --link --install "${installPath}"
            ;;
        remove)
            zenpack --remove "$(zpt --match $2 --fullname)"
            ;;
        build)
            BEGINDIR=$(pwd)
            if cd "$(zpt $ZENPACKSOURCES --match $2 --rootdir)"
            then
                rm -rf dist
                python setup.py bdist_egg
                cp dist/* $BEGINDIR
                cd $BEGINDIR
            else
                echo "$2 not found."
            fi
            ;;
        *)
            echo "Valid commands:"
            echo "  cd, cdr, pushd, pushdr, mate, mater, install, remove, build"
            echo "  install, remove, build"
            return 1
    esac
}

_zp() {
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "${prev}" in
        cd|cdr|pushd|pushdr|mate|mater|install|build)
            workdirs=$(zpt $ZENPACKSOURCES --shortcuts)
            COMPREPLY=( $(compgen -W "${workdirs}" -- ${cur}) )
            return 0
            ;;
        remove)
            workdirs=$(zpt --shortcuts)
            COMPREPLY=( $(compgen -W "${workdirs}" -- ${cur}) )
            return 0
            ;;
        zp)
            commands="cd cdr pushd pushdr mate mater install remove build"
            COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
            return 0
            ;;
        *)
            return 0
            ;;
    esac
}
complete -F _zp zp
