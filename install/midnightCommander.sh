#MidnightCommander
install_mc () {
    apt install mc
    echo "Do you want set mcedit as default editor?"
    PS3="Select operation: "
    select yn in Yes No; do
        case $yn in
            Yes ) install_mcedit;break;;
            No ) break;;
        esac
    done
    read -p "$(echo -e $Green"Finish install MidnightCommander"$Color_Off. Press enter to continue)"
}

install_mcedit () {
    update-alternatives --config editor
    select-editor
    read -p "$(echo -e $Green"Finish install mcedit"$Color_Off. Press enter to continue)"
}