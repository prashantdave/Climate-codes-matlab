function [Weighted_correlation_matrix,W_LL, W_LO, data] = Weighted_Correlation(data)
%Incidence matrix has 0, 1 or 2 as entries, where
%0 = Weight matrix Land-Land
%1 = Weight matrix Land-Ocean
%2 = Weight matrix Ocean-Ocean
    [m,n] = size(data);
    mean_data = mean(data);
    std_data = std(data);

    for i=1:n
        data(:,i) = (data(:,i)-mean_data(i))./std_data(i);
    end

    Incidence_matrix = zeros(11,11);
    %nelement = floor(1+120*rand(5,5));
    %Incidence_matrix(nelement) = 1;

    W_LL = ones(667,667);
    W_LL(1:493,494:667) = 0;
    W_LL(494:667,1:174) = 0;

    W_LO = zeros(667,667);
    W_LO(1:493,494:667) = 1;
    W_LO(494:667,1:174) = 1;

    Weighted_correlation_matrix = zeros(n,n);
    for i=1:n
        for j=1:n
            if Incidence_matrix(i,j) == 0
                Weighted_correlation_matrix(i,j) = corr(W_LL*data(:,i),W_LL*data(:,j));
            else
                Weighted_correlation_matrix(i,j) = corr(W_LL*data(:,i),W_LO*data(:,j));
            end
            %Weighted_correlation_matrix(i,j) = corr(data(:,i),data(:,j));
        end
    end
