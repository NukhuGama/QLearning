function [b] = function_Jalur(tujuan, q)
    % Fungsi ini akan menentukan jalur yang optimal/terpendek dengan reward
    % yang tinggi
    % %%  awal dari state awal 
    pindah = 0;
    awal = 1;
    jalur = awal;
    % % Mengiterasi sampai dapat tujuan State
    % 
    while(pindah~=tujuan)
        [~,pindah]=max(q(awal,:));

        % Menghapus looping yang bisa mengebabkan stuck  (Sampai order 4)  
        if ismember(pindah,jalur)
            [~,x]=sort(q(awal,:),'descend');
            pindah=x(2); 
            if ismember(pindah,jalur)
                [~,x]=sort(q(awal,:),'descend');
                pindah=x(3);
                if ismember(pindah,jalur)
                    [~,x]=sort(q(awal,:),'descend');
                    pindah=x(4);
                    if ismember(pindah,jalur)
                        [~,x]=sort(q(awal,:),'descend');
                        pindah=x(5);
                    end
                end
            end
        end

        % Appending state selanjutnya
       
        jalur=[jalur,pindah];
        awal=pindah;
        
    end
    b = jalur
    