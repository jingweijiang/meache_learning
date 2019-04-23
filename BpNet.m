clc,clear

trainfile = 'trainData.txt';
testfile = 'test.txt';
[in1,in2,out] = textread(trainfile,'%f%f%f'); 
[tin1,tin2,tout] = textread(testfile,'%f%f%f');

h = 2;
k = 0;

W1 = rand(2,3);
W2 = rand(1,3);

a0(3) = -1;
a1(3) = -1;
for loop = 1:100000
    for k = 1:14
        err =0;
        a0(1) = in1(k);
        a0(2) = in2(k);

        u1(1) = W1(1,1)*a0(1)+W1(1,2)*a0(2)+W1(1,3)*a0(3);
        u1(2) = W1(2,1)*a0(1)+W1(2,2)*a0(2)+W1(2,3)*a0(3);
        for i = 1:2
            a1(i) = 1/(1+exp(-u1(i)));
        end

        u2(1) = W2(1,1)*a1(1)+W2(1,2)*a1(2)+W2(1,3)*a1(3);
        a2(1) = 1/(1+exp(-u2(1)));

        delta2(1) = (out(k)-a2(1))*exp(-u2(1))/(1+exp(-u2(1)))^2;

        Iota =0.1;
        for j = 1:3
            W2(1,j) = W2(1,j)+Iota*delta2(1)*a1(j);
        end
        for i = 1:2
    %         delta1(i) = (delta2(1)*W2(1,i))*exp(-u2(1))/(1+exp(-u2(1)))^2;
            delta1(i) = a1(i)*(1-a1(i))*delta2(1)*W2(1,i);
            for j = 1:3
                W1(i,j) = W1(i,j)+Iota*delta1(i)*a0(j);
            end
        end
        err = err+0.5*(out(1)-a2(1))^2;
    end
    if err<0.1
        break;
    end
end

a0(1) = tin1(1);
a0(2) = tin2(1);

u1(1) = W1(1,1)*a0(1)+W1(1,2)*a0(2)+W1(1,3)*a0(3);
u1(2) = W1(2,1)*a0(1)+W1(2,2)*a0(2)+W1(2,3)*a0(3);
for i = 1:2
    a1(i) = 1/(1+exp(-u1(i)));
end

u2(1) = W2(1,1)*a1(1)+W2(1,2)*a1(2)+W2(1,3)*a1(3);
a2(1) = 1/(1+exp(-u2(1)));
 if (a2(1)-0.1)>(a2(1)-0.9)
     a2(1) = 0.9
 else
     a2(1) = 0.1
 end
