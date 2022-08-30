plan(multisession,workers=4)
future_map(1:10000,~solve(.x^3+.x^2))
