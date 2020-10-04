f = imread('cameraman.tif');
I0 = double(f(33:96,81:144));
%disp(I0);

rng(2000);
M = false(64);
ind = randperm(64*64);
M(ind(1:64*64/2)) = true;
%disp(M)
% 
m=64;n=64;

cvx_begin
    obj = 0;
    variable I(m,n)
    for i=2:64
        for j=2:64
            obj = obj + abs(I(i,j)-I(i-1,j));
            obj = obj + abs(I(i,j)-I(i,j-1));
        end
    end
    minimize(obj)
    subject to
        for i=1:64
            for j=1:64
                if M(i,j)
                    I(i,j)== I0(i,j);
                end
            end
        end

cvx_end      
 
%cvx_begin
%     obj = 0;
%     variable I(m,n)
%     for i=2:64
%         for j=2:64
%             temp = (I(i,j)-I(i-1,j));
%             obj = obj + pow_abs(temp,2);
%             temp1 = (I(i,j)-I(i,j-1));
%             obj = obj + temp1^2;
%         end
%     end
%     minimize(obj)
%     subject to
%         for i=1:64
%             for j=1:64
%                 if M(i,j)
%                     I(i,j)== I0(i,j);
%                 end
%             end
%         end
% cvx_end

imagesc(I)
axis square
colormap gray
    
    