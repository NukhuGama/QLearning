%% Tugas 3 Simiao Salvador da Gama /1301163617
%% Kelas : IF-40-12
%% Mata Kuliah : Machine Learning

clc;
clear all;

Data = importdata('DataTugas3ML2019.txt');
% s = qMatrix;
[barData, kolData] = size(Data);

% Menukar isi baris ke 15 baris 1 dan baris 1 ke 15
for i=1:barData 
    k = 15;
    for j=1:kolData
        qMatrix(j,:) = Data(k,:);
        k = k-1;
    end 
end; 

[barqMatrix, kolqMatrix] = size(qMatrix);

% Membuat ddalam bentuk 1 dimensi 
goal = barqMatrix * kolqMatrix;

n = barqMatrix; 

figure('name','Sebelum menepatkan jalur');

imagesc(qMatrix)
colormap(summer)

for i=1:barqMatrix
    for j=1:kolqMatrix
        if qMatrix(i,j)==min(qMatrix) 
            % Jika terdapat reward yang terkecil maka kasih tanda (X) 
            text(j,i,'X','HorizontalAlignment','center','Color','Red')
        end
    end
end
% 
text(1,1,'START','HorizontalAlignment','center','BackGround','Yellow')
text(barqMatrix,kolqMatrix,'GOAL','HorizontalAlignment','center','BackGround','Yellow')

fprintf('goal State berada di : %d',goal)


reward = zeros(barqMatrix*kolqMatrix)

for i=1:goal
    reward(i,:)=reshape(qMatrix',1,goal);
end

% Menentukan nilai reward ketika berpindah ke atas,bawah,kiri dan kanan
reward = function_Move(goal,reward,n)

% Algoritma QLearning
% Menentukan nilai discount(gamma) dan learnning rate(alpha)
q = randn(size(reward));
gamma = 0.9;
alpha = 0.3;
iterasi = 100;

for i=1:iterasi
    
    % Mulai dari state Start   
    currentState=1;
    
    % Perulangan sampai mencapai goal state
    while(currentState~=goal)
        
            % Kemungkinan actionextState untuk state terpilih 
            %(-4 tidak masuk karena dia adalah reward , jadi tak terpilih)
            n_actionextState = find(reward(currentState,:)>=-3);

            % Pilih aksi dimana dipilih secara random dari next state
            nextState = n_actionextState(randi([1 length(n_actionextState)],1,1));
       
            % Mencari semua kemungkinan untuk actionextState dari state
            % yang dipilih
            n_actionextState = find(reward(nextState,:)>=-3);
            
            % Mencari nilai maximum q-value dimana ambil nilai max q dari next state 
            maxQ = 0;
            for j=1:length(n_actionextState)
                maxQ = max(maxQ,q(nextState,n_actionextState(j)));
            end
            
            % Menggunakan  Bellman's equation untuk mengupdate nilai q
            q(currentState,nextState)=reward(currentState,nextState)+gamma*maxQ;
                        
            % Set current state dengan next state
            currentState=nextState;
    end
end

%Menentukan Jalur Optimal yang dilalui 
% * Mulai state pertama (Posisi Pertama)
jal = function_Jalur(goal ,q)

%% Plot Matrix yang ada 
function_Plot(qMatrix, n, jal)

% Ubah jalur 1 dimensi ke dua dimensi 
for i=1:29
   bar = floor((jal(i)/15)+1)
   kol = mod(jal(i),15);
   if bar>=15
       bar = bar-1
       kol = kol+15
   end;
 
   bar = num2str(bar);
   kol = num2str(kol)
   jalur{i} = strcat(bar,',',kol)
    
end;

% jalur = jalur{:}
% Jalur Optimal antara Start State dan Goal State 
disp('Jalur Optimum yang dilalui' )
fprintf(' %8s ',jalur{:})
disp('  ');
disp(' ');
fprintf('Total Langkah Optimum : %d',length(jal));
disp(' ');





