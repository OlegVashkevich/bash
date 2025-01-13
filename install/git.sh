#Git
install_git () {
    apt install git -y
    git --version
    [ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
    read -p "Enter email ex.:[you@example.com]: " email
    email=${email:-you@example.com}
    sudo -u $user git config --global user.email "$email"
    read -p "Enter name ex.:[Your Name]: " name
    name=${name:-Your Name}
    sudo -u $user git config --global user.name "$name"
    read -p "$(echo -e $Green"Finish install Git"$Color_Off. Press enter to continue)"
}