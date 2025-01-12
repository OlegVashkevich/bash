#Git
install_git () {
    apt install git -y
    git --version
    read -p "$(echo -e $Green"Finish install Git"$Color_Off. Press enter to continue)"
}