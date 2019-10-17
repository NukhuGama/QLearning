function [r] = function_Move(goal,reward,n)
    % Fungsi ini akan menentukan kemana  dia pindah (atas,bawah,kiri dan kanan) 
    
    %% Membuat Reward Matrix untuk qMatrix
    % Kemungkinan Aksi:
    for i=1:goal
    %     atas= i-n;
    %     bawah = i+n;
    %     kiri = i-1;
    %     kanan = i+1;
    %     

        for j=1:goal
            % Jika tidak menuju kiri, kanan , atas dan bawah maka reward
            % diisi dengan nilai yang terlalu kecil (-1000)
            if j~=i-n  && j~=i+n  && j~=i-1 && j~=i+1 
                reward(i,j)=-1000;
            end 

    %           if (bawah>=atas) && (bawah>=kanan) & (bawah>=kiri)
    %               reward(i,atas) = -1000;
    %               reward(i,kanan) = -1000; 
    %               reward(i,kiri) = -1000;
    %           end;
        end
    end
    % Mengignore ketika berpindah ke state secara diagonal (kiri,kanan, atas , bawah)
    for i=1:n:goal
        for j=1:i+n
            if j==i+n-1 || j==i-1 || j==i-n-1
                reward(i,j)=-1000;
                reward(j,i)=-1000;
            end
        end
    end
    
    r = reward;