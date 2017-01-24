function run = stat_run(seq)
%This function works for recording the run of heads

count = 0;
flag = 1;
run = zeros(1,length(seq));
while(count < length(seq))
    count = count + 1;
    if(seq(count) == 1)
        run(flag) = run(flag)+1;
    else
        flag = flag+1;
    end
end
