function fish_prompt
    set E
    set E $E \U1F51C # soon
    set E $E \U1F354 # hamburger
    set E $E \U1F4A9 # poo
    set E $E \U1F47A # tengu
    set E $E \U1F349 # watermelon
    set E $E \U1F300 # cyclone
    set E $E \U1F37A # beer
    set E $E \U1F382 # cake
    set E $E \U1F369 # donut
    set E $E \U1F344 # mushroom
    set E $E \U2615  # coffee
    set E $E \U1F35C # ramen
    set E $E \U1F363 # sushi
    set E $E \U1F36A # cookie
    set E $E \U1F36B # chocolate
    set E $E \U1F371 # bento
    set E $E \U1F411 # sheep
    set E $E \U1F525 # fire

    set n (math (random)%(count $E))
    set m (math $n+1)
    set symbol $E[$m]

    set_color normal
    echo
    echo -n $symbol
    echo -n "  "
end
