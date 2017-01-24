function num_heads = coin_flip()
%This function works for simulating tossing a fair coin 50 times

coin_result = rand(1,50);
coin_result(coin_result >= 0.5) = 1;%Heads
coin_result(coin_result < 0.5) = 0;%Tails
num_heads = sum(coin_result);