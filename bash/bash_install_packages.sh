#!/bin/bash
verify_custom_functions_exists() {
    local functions_list function_name
    function_list=( "bash_logging" )
    for function_name in "${function_list[@]}" ; do
        if [[ $(type -t $function_name) != function ]]; then
            echo "\"$function_name\" function was not found. export the function and re-try" >&2
            exit 1
        fi
    fi
}

verify_linux_package_manager() {
    if [[ $(which apt) ]]; then
        bash_logging "\"apt\" package manager was found" DEBUG
        return 0
    else
        bash_logging "The supported package manager for Linux is \"apt\" only, which was not found. terminating" ERROR
        return 1
    fi
}

verify_mac_package_manager() {
    if [[ $(which brew) ]]; then
        bash_logging "\"brew\" package manager was found" DEBUG
        return 0
    else
        bash_logging "\"brew\" package manager was not found. Installing" DEBUG
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi   
}

verify_linux_package() {
    local package_name
    package_name="$1"
    bash_logging "Verify linux package \"$package_name\"" DEBUG
    dpkg -s $package_name &> /dev/null && \
    (bash_logging "Package: \"$package_name\" already installed" DEBUG && return 0) || \
    (bash_logging "Package: \"$package_name\" is not installed" DEBUG && return 1)
}

install_repository() {
    local package_name install_repo gpg_key_url
    package_name="$1"
    install_repo="$2"
    gpg_key_url="$3"
    if [[ $gpg_key_url ]]; then
        bash_logging "Adding gpg_key: $gpg_key_url and repo: $install_repo" DEBUG
        sudo curl -s "$gpg_key_url" | sudo apt-key add - || return 1
        sudo echo "deb $install_repo" | sudo tee "/etc/apt/sources.list.d/$package_name.list"
        sudo apt-get update -y && \
        (bash_logging "Repository for package: \"$package_name\" updated" DEBUG && return 0) || \
        (bash_logging "Repository for package: \"$package_name\" failed. terminating" ERROR && return 1)
    # This was for when I thought I can install without gpg, might be usefull
    # elif [[ $install_repo ]]; then
    #     bash_logging "Adding repo: $install_repo without gpg_key" DEBUG
    #     echo "deb $install_repo" | sudo tee "/etc/apt/sources.list.d/$package_name.list"
    #     sudo apt-get update -y && \
    #     (bash_logging "Repository for package: \"$package_name\" updated" DEBUG && return 0) || \
    #     (bash_logging "Repository for package: \"$package_name\" failed. terminating" ERROR && exit 1)
    else
        bash_logging "No gpg_key: $gpg_key_url or repo: $install_repo were supplied, continue to installation" DEBUG
    fi
}

install_linux_package() {
    local package_name
    package_name="$1"
    bash_logging "Installing linux package: \"$package_name\"" DEBUG
    sudo apt-get install -y "$package_name" && return 0 || return 1  
}

install_all_linux_packages() {
    local package_name cli_package_item install_repo gpg_key_url

    bash_logging "Updating apt" DEBUG
    sudo apt-get update -y

    for package_name in "${PACKAGES_PREREQUISITE[@]}" ; do
        verify_linux_package "$package_name" && continue
        install_linux_package "$package_name"
    done

    for cli_package_item in "${PACKAGES_CLI[@]}" ; do
        package_name=$(echo "$cli_package_item" | awk -F "---" '{print $1}')
        verify_linux_package "$package_name" && continue
        install_repo=$(echo "$cli_package_item" | awk -F "---" '{print $2}')
        gpg_key_url=$(echo "$cli_package_item" | awk -F "---" '{print $3}')
        install_repository "$package_name" "$install_repo" "$gpg_key_url" || exit 1
        install_linux_package "$package_name"
    done
}

verify_mac_package() {
    local package_name package_type verify_command brew_flag
    package_name="$1"
    package_type="$2"
    if [[ $package_type == "CLI" ]]; then
        bash_logging "Verify CLI mac package \"$package_name\"" DEBUG
        brew_flag="--formula"
    elif [[ $package_type == "GUI" ]]; then
        bash_logging "Verify GUI mac package \"$package_name\"" DEBUG
        brew_flag="--cask"
    else
        bash_logging "Verifying mac package failed. package_name: $package_name, package_type: $package_type. terminating" ERROR
        exit 1
    fi
    verify_command="brew list $brew_flag | grep \"$package_name\$\" &> /dev/null && \
                    (bash_logging \"Package: $package_name already installed\" DEBUG && return 0) || \
                    (bash_logging \"Package: $package_name is not installed\" DEBUG && return 1)"
    eval $verify_command
}

install_mac_package() {
    local package_name package_type verify_command brew_flag
    package_name="$1"
    package_type="$2"
    if [[ $package_type == "CLI" ]]; then
        bash_logging "Install CLI mac package \"$package_name\"" DEBUG
        brew_flag=""
    elif [[ $package_type == "GUI" ]]; then
        bash_logging "Install GUI mac package \"$package_name\"" DEBUG
        brew_flag=" --cask"
    else
        bash_logging "Installing mac package failed. package_name: \"$package_name\", package_type: \"$package_type\". terminating" ERROR
        exit 1
    fi
    verify_command="sudo brew install$brew_flag $package_type"
    eval $verify_command
}

install_all_mac_packages() {
    local package_item package_name install_repo gpg_key_url

    for package_item in "${PACKAGES_CLI[@]}" ; do
        package_name=$(echo "$package_item" | awk -F "---" '{print $1}')
        verify_mac_package "$package_name" "CLI" && continue
        install_mac_package "$package_name" "CLI"
    done

    for package_item in "${PACKAGES_MAC[@]}" ; do
        package_name=$(echo "$package_item" | awk -F "---" '{print $1}')
        verify_mac_package "$package_name" "CLI" && continue
        install_mac_package "$package_name" "CLI"
    done

    for package_name in "${PACKAGES_GUI[@]}" ; do
        verify_mac_package "$package_name" "GUI" && continue
        install_mac_package "$package_name" "GUI"
    done
}

main() {
    local os_type
    verify_custom_functions_exists
    os_type=$(uname | sed 's/[[:alnum:]]/\L&/g')
    if [[ $os_type == *linux* ]]; then
        bash_logging "we in linux" DEBUG
        verify_linux_package_manager
        install_all_linux_packages
    elif [[ $os_type == *darwin* ]]; then
        bash_logging "we in mac" DEBUG
        verify_mac_package_manager
        install_all_mac_packages
    else
        bash_logging "what is this OS? (os_type is $os_type)" ERROR
    fi
}


PACKAGES_PREREQUISITE=( "apt-transport-https"
                        "ca-certificates"
                        "curl" )
             # package_name---install_repo---gpg_key
PACKAGES_CLI=( "kubectl---https://apt.kubernetes.io/ kubernetes-xenial main---https://packages.cloud.google.com/apt/doc/apt-key.gpg"
                "helm---https://baltocdn.com/helm/stable/debian/ all main---https://baltocdn.com/helm/signing.asc"
                "jq"
                "shellcheck"
                "mysql-client" )
             # unsupported for linux ATM
             # install_name---filesystem_name
PACKAGES_GUI=( "microsoft-edge"
               "google-chrome"
               "firefox"
               "visual-studio-code"
               "iterm2" )
PACKAGES_MAC=( "lima"
               "docker" )

source bash_init_functions.sh

main
