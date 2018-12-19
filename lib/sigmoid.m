function ans = sigmoid(x, dx)
  ans = 1.0 ./ (1 .+ exp(x/dx) ) ;
endfunction
