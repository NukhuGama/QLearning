function [] = function_Plot(qMatrix,n,jalur)
    % jalur mulai dari state awal
    % Membuat Jalur di Matrix
    jalurMatrix=zeros(n,n);

    [q, r]=quorem(sym(jalur),sym(n));
    q=double(q);r=double(r);
    q(r~=0)=q(r~=0)+1;r(r==0)=n;

    for i=1:length(q)
        jalurMatrix(q(i),r(i))=50;
    end 

    figure('name','jalur optimum yang dilalui')
    imagesc(jalurMatrix)
    colormap(summer)

    for i=1:n
        for j=1:n
            if qMatrix(i,j)==min(qMatrix)
                text(j,i,'X','HorizontalAlignment','center','Color','Red','FontSize',16) % Jika terdapat reward yang terkecil maka kasih tanda (X) 
            end
            if jalurMatrix(i,j)==50
                text(j,i,'\bullet','Color','green','FontSize',24)
                pause(0.5)
            end
        end
    end
    text(1,1,'START','HorizontalAlignment','center','BackGround','Yellow','FontSize',8)
    text(n,n,'GOAL','HorizontalAlignment','center','BackGround','White','FontSize',8)

    hold on
    imagesc(qMatrix,'AlphaData',0.1)
    colormap(summer)
    hold off
    axis off