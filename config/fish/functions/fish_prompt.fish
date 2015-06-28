function fish_prompt
    set soon \U1f51c
    set hamburger \U1f354
    set poo \U1f4a9
    set tengu \U1f47a
    set watermelon \U1f349
    set beginner \U1f530
    set cyclone \U1f300

    switch (date +%H)
    case 0 1 2 3 4 5 6 7
        set symbol $watermelon
    case 8 9 10
        set symbol $tengu
    case 11 12
        set symbol $hamburger
    case '*'
        set symbol $poo
    end

    # set choices \
    #     $soon \
    #     $hamburger \
    #     $poo \
    #     $tengu \
    #     $watermelon \
    #     $beginner \
    #     $cyclone
    # set n (math (random)%(count $choices))
    # set m (math $n + 1)
    # set symbol $choices[$m]

    set_color normal
    echo
    echo -n $symbol
    echo -n "  "
end
