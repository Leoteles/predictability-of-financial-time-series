close all;
clear all;
clc;

%Teste BDS com as séries reais

%Modelagem GARCH e teste BDS com seus resíduos

carrega_series;

Nsur = 50;

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_bds_resGARCH_';



%Parâmetros utilizados na previsão
Nval = 0.15;
Ntest = 0.15;
Ndelays = [2 3 3 5 6 1 1];%Obtido da dissertação (pg. 119)


for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};

    [xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays(i),Nval,Ntest);
    %Concatena ydtr e ydval, já que ambos participam do treinamento
    serie = [ydtr; ydval];

    %Estima modelo garch
    spec = garchset();
    spec.Comment
    [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,serie);
    
    Coeff.ARCH
    Coeff.GARCH
    
    %Calcula série passada por filtro GARCH estimado
    serie = (Innovations./Sigmas);

    
    tic
    [estrutura, prev] = analiseBDS(serie,Nsur);
    est(i) = estrutura;
    disp('PREV(serie)');prev
    toc
%     str = strcat(strfig,series_str{i});
%     print('-depsc',str);

end


%Testa normalidade dos sub-rogados gerados
for i = 1:size(series,2)
    resultados = testanormal(est(i).w_sur);
    normalidade(i,:) = resultados;%Resultados da série i para o teste kolmogorov-smirnov
end
%resultado da rejeição | valor da estatistica | valor limite
normalidade
% normalidade =
% 
%          0    0.0937    0.1884
%          0    0.0916    0.1884
%          0    0.1381    0.1884
%          0    0.1522    0.1884
%          0    0.0806    0.1884
%          0    0.1343    0.1884
%          0    0.1020    0.1884

% Resultados
% w2
% djia  1.926
% sp500 4.31697
% ibov  6.65256
% peto  3.54584
% peth  7.48543
% petl  6.66382
% petc  4.40369

% prev
% djia    2.0874
% sp500   4.0597
% ibov    6.5234
% peto    3.2136
% peth    7.2113
% petl    7.1236
% petc    4.6617


% % % % djia
% % % % 
% % % % ans =
% % % % 
% % % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    Diagnostic Information
% % % % 
% % % % Number of variables: 4
% % % % 
% % % % Functions 
% % % %  Objective:                            internal.econ.garchllfn
% % % %  Gradient:                             finite-differencing
% % % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % % %  Nonlinear constraints:                armanlc
% % % %  Gradient of nonlinear constraints:    finite-differencing
% % % % 
% % % % Constraints
% % % %  Number of nonlinear inequality constraints: 0
% % % %  Number of nonlinear equality constraints:   0
% % % %  
% % % %  Number of linear inequality constraints:    1
% % % %  Number of linear equality constraints:      0
% % % %  Number of lower bound constraints:          4
% % % %  Number of upper bound constraints:          4
% % % % 
% % % % Algorithm selected
% % % %    medium-scale: SQP, Quasi-Newton, line-search
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    End diagnostic information
% % % % 
% % % %                                 Max     Line search  Directional  First-order 
% % % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % % %     0      5       -77795  -1.315e-005                                         
% % % %     1     25     -77800.8  -1.315e-005    3.05e-005   -5.32e+004     5.4e+005   
% % % %     2     32     -79032.9  -9.865e-006         0.25   -1.91e+004    2.48e+008   
% % % %     3     38     -79121.2  -4.932e-006          0.5   -2.68e+003    1.36e+008   
% % % %     4     46       -79151  -5.807e-006        0.125   -7.02e+003    1.64e+007   
% % % %     5     51     -79543.4   2.118e-022            1   -3.41e+003    5.38e+008   
% % % %     6     61     -79621.1            0       0.0313   -1.43e+005    1.55e+008   
% % % %     7     72     -79638.9  -1.454e-006       0.0156   -6.11e+003     4.4e+007   
% % % %     8     81     -79660.4  -2.078e-006       0.0625   -2.04e+003    1.72e+007   
% % % %     9     91     -79662.7   -2.31e-006       0.0313   -2.46e+003    1.18e+007   
% % % %    10     96     -79684.2            0            1   -2.02e+003    5.22e+007   
% % % %    11    103       -79699   -1.01e-006         0.25   -1.31e+003    7.67e+007   
% % % %    12    114     -79704.2  -1.362e-006       0.0156   -1.09e+003    3.11e+007   
% % % %    13    121     -79704.2  -1.021e-006         0.25         -794     2.1e+007   
% % % %    14    129     -79708.2  -1.005e-006        0.125   -1.77e+003    3.71e+007   
% % % %    15    134     -79710.4  -1.082e-006            1   -1.21e+004    1.24e+006   
% % % %    16    140     -79710.4  -1.062e-006          0.5        -80.7    6.28e+005   
% % % %    17    159     -79710.4  -1.062e-006    -6.1e-005        -43.5    6.28e+005   
% % % %    18    178     -79710.4  -1.062e-006    -6.1e-005        -47.2    6.28e+005   
% % % %    19    197     -79710.4  -1.062e-006    -6.1e-005        -62.9    6.28e+005   
% % % %    20    216     -79710.4  -1.062e-006    -6.1e-005         -383    6.28e+005   
% % % %    21    235     -79710.4  -1.062e-006    -6.1e-005         -299    6.31e+005   
% % % % 
% % % % Local minimum possible. Constraints satisfied.
% % % % 
% % % % fmincon stopped because the predicted change in the objective function
% % % % is less than the selected value of the function tolerance and constraints 
% % % % were satisfied to within the selected value of the constraint tolerance.
% % % % 
% % % % <stopping criteria details>
% % % % 
% % % % No active inequalities.
% % % % 
% % % % ans =
% % % % 
% % % %     0.0902
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.9027
% % % % 
% % % % Calculando BDS para sub-rogados... 20% concluido
% % % % Calculando BDS para sub-rogados... 40% concluido
% % % % Calculando BDS para sub-rogados... 60% concluido
% % % % Calculando BDS para sub-rogados... 80% concluido
% % % % Calculando BDS para sub-rogados... 100% concluido
% % % % Calculando BDS para série original.
% % % % PREV(serie)
% % % % 
% % % % prev =
% % % % 
% % % %     2.0874
% % % % 
% % % % Elapsed time is 1525.502425 seconds.
% % % % sp500
% % % % 
% % % % ans =
% % % % 
% % % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    Diagnostic Information
% % % % 
% % % % Number of variables: 4
% % % % 
% % % % Functions 
% % % %  Objective:                            internal.econ.garchllfn
% % % %  Gradient:                             finite-differencing
% % % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % % %  Nonlinear constraints:                armanlc
% % % %  Gradient of nonlinear constraints:    finite-differencing
% % % % 
% % % % Constraints
% % % %  Number of nonlinear inequality constraints: 0
% % % %  Number of nonlinear equality constraints:   0
% % % %  
% % % %  Number of linear inequality constraints:    1
% % % %  Number of linear equality constraints:      0
% % % %  Number of lower bound constraints:          4
% % % %  Number of upper bound constraints:          4
% % % % 
% % % % Algorithm selected
% % % %    medium-scale: SQP, Quasi-Newton, line-search
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    End diagnostic information
% % % % 
% % % %                                 Max     Line search  Directional  First-order 
% % % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % % %     0      5     -44781.7  -7.533e-006                                         
% % % %     1     27     -44783.2  -7.533e-006    7.63e-006   -2.71e+004    2.65e+005   
% % % %     2     34       -45000   -5.65e-006         0.25   -6.88e+003       2e+008   
% % % %     3     43     -45009.1  -8.389e-006       0.0625   -1.42e+003     1.2e+007   
% % % %     4     49     -45245.1  -4.194e-006          0.5   -1.28e+003    4.46e+007   
% % % %     5     55     -45270.8  -2.097e-006          0.5   -1.53e+003    1.22e+008   
% % % %     6     66     -45277.3  -2.071e-006       0.0156         -867    1.13e+008   
% % % %     7     77     -45291.3  -3.546e-006       0.0156   -8.63e+003    6.55e+007   
% % % %     8     82     -45398.7            0            1   -1.62e+003    3.54e+007   
% % % %     9     95     -45399.8   -3.84e-007      0.00391         -838     6.6e+006   
% % % %    10    102     -45402.5   -2.88e-007         0.25   -1.04e+003    4.19e+007   
% % % %    11    114     -45405.4   -5.68e-007      0.00781   -1.05e+003    1.91e+006   
% % % %    12    127     -45405.4  -5.657e-007      0.00391        -28.8     1.4e+006   
% % % %    13    133     -45405.8  -4.735e-007          0.5         -556    2.98e+006   
% % % %    14    138     -45405.9   -4.76e-007            1         -368    4.98e+005   
% % % % 
% % % % Local minimum possible. Constraints satisfied.
% % % % 
% % % % fmincon stopped because the predicted change in the objective function
% % % % is less than the selected value of the function tolerance and constraints 
% % % % were satisfied to within the selected value of the constraint tolerance.
% % % % 
% % % % <stopping criteria details>
% % % % 
% % % % No active inequalities.
% % % % 
% % % % ans =
% % % % 
% % % %     0.0803
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.9148
% % % % 
% % % % Calculando BDS para sub-rogados... 20% concluido
% % % % Calculando BDS para sub-rogados... 40% concluido
% % % % Calculando BDS para sub-rogados... 60% concluido
% % % % Calculando BDS para sub-rogados... 80% concluido
% % % % Calculando BDS para sub-rogados... 100% concluido
% % % % Calculando BDS para série original.
% % % % PREV(serie)
% % % % 
% % % % prev =
% % % % 
% % % %     4.0597
% % % % 
% % % % Elapsed time is 420.874488 seconds.
% % % % ibov
% % % % 
% % % % ans =
% % % % 
% % % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    Diagnostic Information
% % % % 
% % % % Number of variables: 4
% % % % 
% % % % Functions 
% % % %  Objective:                            internal.econ.garchllfn
% % % %  Gradient:                             finite-differencing
% % % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % % %  Nonlinear constraints:                armanlc
% % % %  Gradient of nonlinear constraints:    finite-differencing
% % % % 
% % % % Constraints
% % % %  Number of nonlinear inequality constraints: 0
% % % %  Number of nonlinear equality constraints:   0
% % % %  
% % % %  Number of linear inequality constraints:    1
% % % %  Number of linear equality constraints:      0
% % % %  Number of lower bound constraints:          4
% % % %  Number of upper bound constraints:          4
% % % % 
% % % % Algorithm selected
% % % %    medium-scale: SQP, Quasi-Newton, line-search
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    End diagnostic information
% % % % 
% % % %                                 Max     Line search  Directional  First-order 
% % % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % % %     0      5     -20450.4  -7.889e-005                                         
% % % %     1     23     -20454.3  -7.888e-005     0.000122   -1.13e+004    1.12e+005   
% % % %     2     29       -20565  -3.944e-005          0.5   -7.75e+003    2.88e+007   
% % % %     3     35       -20592    -0.000214          0.5    -6.8e+003    9.78e+005   
% % % %     4     42     -20711.9   -0.0001605         0.25   -1.02e+003    1.79e+006   
% % % %     5     49     -20805.6     -0.00014         0.25   -1.53e+003    5.92e+006   
% % % %     6     57     -20817.9   -0.0001649        0.125   -1.01e+003     3.9e+006   
% % % %     7     63     -21006.9  -8.247e-005          0.5   -1.47e+003    2.33e+006   
% % % %     8     70     -21082.5  -6.185e-005         0.25   -1.83e+003    3.18e+006   
% % % %     9     76     -21266.6  -3.093e-005          0.5    -2.5e+003    5.36e+006   
% % % %    10     86       -21282  -4.048e-005       0.0313   -1.62e+003    4.26e+005   
% % % %    11     91     -21431.3    1.11e-016            1   -1.27e+003    1.17e+007   
% % % %    12     98       -21439  -9.675e-006         0.25         -779    3.52e+006   
% % % %    13    105     -21444.6  -1.423e-005         0.25         -677    2.97e+006   
% % % %    14    110     -21451.1    1.11e-016            1         -387     2.8e+006   
% % % %    15    119     -21452.1  -6.581e-006       0.0625         -879    1.64e+006   
% % % %    16    129     -21455.1  -9.701e-006       0.0313         -262    1.02e+006   
% % % %    17    134     -21456.8   -1.11e-016            1         -608    1.08e+005   
% % % %    18    139     -21456.8    1.11e-016            1        -31.3    1.46e+003   
% % % %    19    144     -21456.8            0            1         -118    1.72e+003   
% % % % 
% % % % Local minimum possible. Constraints satisfied.
% % % % 
% % % % fmincon stopped because the size of the current search direction is less than
% % % % twice the selected value of the step size tolerance and constraints were 
% % % % satisfied to within the selected value of the constraint tolerance.
% % % % 
% % % % <stopping criteria details>
% % % % 
% % % % Active inequalities (to within options.TolCon = 1e-007):
% % % %   lower      upper     ineqlin   ineqnonlin
% % % %                           1           
% % % %  
% % % % Boundary constraints active: standard errors may be inaccurate.
% % % % 
% % % % ans =
% % % % 
% % % %     0.1605
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.8395
% % % % 
% % % % Calculando BDS para sub-rogados... 20% concluido
% % % % Calculando BDS para sub-rogados... 40% concluido
% % % % Calculando BDS para sub-rogados... 60% concluido
% % % % Calculando BDS para sub-rogados... 80% concluido
% % % % Calculando BDS para sub-rogados... 100% concluido
% % % % Calculando BDS para série original.
% % % % PREV(serie)
% % % % 
% % % % prev =
% % % % 
% % % %     6.5234
% % % % 
% % % % Elapsed time is 203.310051 seconds.
% % % % peto
% % % % 
% % % % ans =
% % % % 
% % % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    Diagnostic Information
% % % % 
% % % % Number of variables: 4
% % % % 
% % % % Functions 
% % % %  Objective:                            internal.econ.garchllfn
% % % %  Gradient:                             finite-differencing
% % % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % % %  Nonlinear constraints:                armanlc
% % % %  Gradient of nonlinear constraints:    finite-differencing
% % % % 
% % % % Constraints
% % % %  Number of nonlinear inequality constraints: 0
% % % %  Number of nonlinear equality constraints:   0
% % % %  
% % % %  Number of linear inequality constraints:    1
% % % %  Number of linear equality constraints:      0
% % % %  Number of lower bound constraints:          4
% % % %  Number of upper bound constraints:          4
% % % % 
% % % % Algorithm selected
% % % %    medium-scale: SQP, Quasi-Newton, line-search
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    End diagnostic information
% % % % 
% % % %                                 Max     Line search  Directional  First-order 
% % % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % % %     0      5     -5767.77   -0.0002331                                         
% % % %     1     25     -5767.87   -0.0002331    3.05e-005         -594    2.75e+003   
% % % %     2     32     -5883.94   -0.0001748         0.25   -2.51e+003    2.67e+006   
% % % %     3     39     -5886.03    -0.000465         0.25         -931    2.19e+005   
% % % %     4     47     -5889.66   -0.0005483        0.125         -169    1.15e+005   
% % % %     5     53     -5908.09   -0.0002742          0.5         -180     3.2e+005   
% % % %     6     59     -5918.09   -0.0002253          0.5         -429     2.8e+005   
% % % %     7     69     -5922.45   -0.0002776       0.0313   -2.22e+003    3.04e+005   
% % % %     8     75     -5935.09   -0.0001388          0.5        -86.4     2.4e+005   
% % % %     9     85     -5937.82   -0.0001344       0.0313         -730    1.87e+005   
% % % %    10     93     -5938.02   -0.0001176        0.125        -23.4    1.34e+005   
% % % %    11    102     -5938.11   -0.0001314       0.0625         -151          472   
% % % %    12    112     -5938.15   -0.0001372       0.0313        -11.2    1.17e+004   
% % % %    13    117     -5938.46    -0.000125            1        -82.2    1.45e+003   
% % % %    14    122     -5938.48   -0.0001275            1        -15.8          365   
% % % %    15    127     -5938.48   -0.0001273            1       -0.582         15.9   
% % % % 
% % % % Local minimum possible. Constraints satisfied.
% % % % 
% % % % fmincon stopped because the predicted change in the objective function
% % % % is less than the selected value of the function tolerance and constraints 
% % % % were satisfied to within the selected value of the constraint tolerance.
% % % % 
% % % % <stopping criteria details>
% % % % 
% % % % No active inequalities.
% % % % 
% % % % ans =
% % % % 
% % % %     0.1479
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.8015
% % % % 
% % % % Calculando BDS para sub-rogados... 20% concluido
% % % % Calculando BDS para sub-rogados... 40% concluido
% % % % Calculando BDS para sub-rogados... 60% concluido
% % % % Calculando BDS para sub-rogados... 80% concluido
% % % % Calculando BDS para sub-rogados... 100% concluido
% % % % Calculando BDS para série original.
% % % % PREV(serie)
% % % % 
% % % % prev =
% % % % 
% % % %     3.2136
% % % % 
% % % % Elapsed time is 33.805982 seconds.
% % % % peth
% % % % 
% % % % ans =
% % % % 
% % % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    Diagnostic Information
% % % % 
% % % % Number of variables: 4
% % % % 
% % % % Functions 
% % % %  Objective:                            internal.econ.garchllfn
% % % %  Gradient:                             finite-differencing
% % % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % % %  Nonlinear constraints:                armanlc
% % % %  Gradient of nonlinear constraints:    finite-differencing
% % % % 
% % % % Constraints
% % % %  Number of nonlinear inequality constraints: 0
% % % %  Number of nonlinear equality constraints:   0
% % % %  
% % % %  Number of linear inequality constraints:    1
% % % %  Number of linear equality constraints:      0
% % % %  Number of lower bound constraints:          4
% % % %  Number of upper bound constraints:          4
% % % % 
% % % % Algorithm selected
% % % %    medium-scale: SQP, Quasi-Newton, line-search
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    End diagnostic information
% % % % 
% % % %                                 Max     Line search  Directional  First-order 
% % % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % % %     0      5     -6263.28   -0.0001635                                         
% % % %     1     27     -6263.29   -0.0001635    7.63e-006         -267    2.12e+003   
% % % %     2     35     -6341.39   -0.0001431        0.125   -1.95e+003    2.07e+006   
% % % %     3     46        -6342    -0.000161       0.0156         -180    1.08e+005   
% % % %     4     52     -6364.45  -8.048e-005          0.5         -172    1.97e+005   
% % % %     5     59     -6364.93  -6.036e-005         0.25         -182    7.62e+005   
% % % %     6     71     -6366.31  -6.197e-005      0.00781         -352    7.35e+005   
% % % %     7     77     -6370.65  -3.935e-005          0.5         -256    3.43e+005   
% % % %     8     90     -6371.01   -4.46e-005      0.00391         -334    2.58e+005   
% % % %     9    101     -6371.23  -5.245e-005       0.0156        -58.7    6.21e+004   
% % % %    10    106     -6371.37    -4.9e-005            1        -38.5    1.78e+004   
% % % %    11    111     -6371.37  -4.814e-005            1        -13.1    5.55e+003   
% % % %    12    116     -6371.37  -4.829e-005            1        -2.76    1.26e+003   
% % % %    13    121     -6371.37  -4.829e-005            1       -0.522         94.9  Hessian modified  
% % % % 
% % % % Local minimum possible. Constraints satisfied.
% % % % 
% % % % fmincon stopped because the size of the current search direction is less than
% % % % twice the selected value of the step size tolerance and constraints were 
% % % % satisfied to within the selected value of the constraint tolerance.
% % % % 
% % % % <stopping criteria details>
% % % % 
% % % % No active inequalities.
% % % % 
% % % % ans =
% % % % 
% % % %     0.0703
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.9012
% % % % 
% % % % Calculando BDS para sub-rogados... 20% concluido
% % % % Calculando BDS para sub-rogados... 40% concluido
% % % % Calculando BDS para sub-rogados... 60% concluido
% % % % Calculando BDS para sub-rogados... 80% concluido
% % % % Calculando BDS para sub-rogados... 100% concluido
% % % % Calculando BDS para série original.
% % % % PREV(serie)
% % % % 
% % % % prev =
% % % % 
% % % %     7.2113
% % % % 
% % % % Elapsed time is 34.560134 seconds.
% % % % petl
% % % % 
% % % % ans =
% % % % 
% % % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    Diagnostic Information
% % % % 
% % % % Number of variables: 4
% % % % 
% % % % Functions 
% % % %  Objective:                            internal.econ.garchllfn
% % % %  Gradient:                             finite-differencing
% % % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % % %  Nonlinear constraints:                armanlc
% % % %  Gradient of nonlinear constraints:    finite-differencing
% % % % 
% % % % Constraints
% % % %  Number of nonlinear inequality constraints: 0
% % % %  Number of nonlinear equality constraints:   0
% % % %  
% % % %  Number of linear inequality constraints:    1
% % % %  Number of linear equality constraints:      0
% % % %  Number of lower bound constraints:          4
% % % %  Number of upper bound constraints:          4
% % % % 
% % % % Algorithm selected
% % % %    medium-scale: SQP, Quasi-Newton, line-search
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    End diagnostic information
% % % % 
% % % %                                 Max     Line search  Directional  First-order 
% % % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % % %     0      5      -5927.7   -0.0002193                                         
% % % %     1     25     -5927.74   -0.0002193    3.05e-005         -419    3.03e+003   
% % % %     2     32     -6063.46   -0.0001645         0.25   -2.77e+003    2.89e+006   
% % % %     3     40     -6077.33   -0.0003051        0.125         -819    1.13e+005   
% % % %     4     46     -6096.72   -0.0001598          0.5         -131    8.97e+005   
% % % %     5     53     -6115.47   -0.0001199         0.25         -405    4.39e+005   
% % % %     6     60      -6124.6  -8.989e-005         0.25   -2.13e+003    3.47e+005   
% % % %     7     71     -6125.75   -0.0001069       0.0156         -258    1.84e+005   
% % % %     8     78     -6128.28   -8.02e-005         0.25         -108    3.43e+005   
% % % %     9     85     -6128.61  -8.356e-005         0.25         -275    1.01e+005   
% % % %    10     99     -6128.62  -8.531e-005      0.00195        -13.8    1.15e+005   
% % % %    11    106     -6129.44  -8.098e-005         0.25         -227    3.07e+004   
% % % %    12    111     -6129.49  -8.222e-005            1        -30.4    1.95e+004   
% % % %    13    116      -6129.5  -8.216e-005            1        -9.65    2.78e+003   
% % % %    14    121      -6129.5  -8.207e-005            1        -4.12          134   
% % % %    15    126      -6129.5  -8.208e-005            1       -0.143         4.22  Hessian modified  
% % % % 
% % % % Local minimum possible. Constraints satisfied.
% % % % 
% % % % fmincon stopped because the size of the current search direction is less than
% % % % twice the selected value of the step size tolerance and constraints were 
% % % % satisfied to within the selected value of the constraint tolerance.
% % % % 
% % % % <stopping criteria details>
% % % % 
% % % % No active inequalities.
% % % % 
% % % % ans =
% % % % 
% % % %     0.1259
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.8411
% % % % 
% % % % Calculando BDS para sub-rogados... 20% concluido
% % % % Calculando BDS para sub-rogados... 40% concluido
% % % % Calculando BDS para sub-rogados... 60% concluido
% % % % Calculando BDS para sub-rogados... 80% concluido
% % % % Calculando BDS para sub-rogados... 100% concluido
% % % % Calculando BDS para série original.
% % % % PREV(serie)
% % % % 
% % % % prev =
% % % % 
% % % %     7.1236
% % % % 
% % % % Elapsed time is 32.074341 seconds.
% % % % petc
% % % % 
% % % % ans =
% % % % 
% % % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    Diagnostic Information
% % % % 
% % % % Number of variables: 4
% % % % 
% % % % Functions 
% % % %  Objective:                            internal.econ.garchllfn
% % % %  Gradient:                             finite-differencing
% % % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % % %  Nonlinear constraints:                armanlc
% % % %  Gradient of nonlinear constraints:    finite-differencing
% % % % 
% % % % Constraints
% % % %  Number of nonlinear inequality constraints: 0
% % % %  Number of nonlinear equality constraints:   0
% % % %  
% % % %  Number of linear inequality constraints:    1
% % % %  Number of linear equality constraints:      0
% % % %  Number of lower bound constraints:          4
% % % %  Number of upper bound constraints:          4
% % % % 
% % % % Algorithm selected
% % % %    medium-scale: SQP, Quasi-Newton, line-search
% % % % 
% % % % 
% % % % ____________________________________________________________
% % % %    End diagnostic information
% % % % 
% % % %                                 Max     Line search  Directional  First-order 
% % % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % % %     0      5     -5928.84   -0.0002087                                         
% % % %     1     25     -5928.84   -0.0002087    3.05e-005         -302     2.5e+003   
% % % %     2     32     -5950.73   -0.0001566         0.25    -2.3e+003    3.41e+006   
% % % %     3     39     -5982.89   -0.0003984         0.25   -1.14e+003    3.71e+004   
% % % %     4     46      -6002.2   -0.0003235         0.25         -223    3.64e+005   
% % % %     5     55     -6005.27   -0.0003571       0.0625         -338     2.3e+005   
% % % %     6     61     -6028.15   -0.0002783          0.5         -289    3.36e+004   
% % % %     7     69     -6028.32   -0.0002499        0.125         -268    3.24e+005   
% % % %     8     76     -6034.56   -0.0001874         0.25         -115    6.02e+005   
% % % %     9     82     -6054.26   -0.0001258          0.5         -384    8.25e+005   
% % % %    10     88     -6070.66  -7.417e-005          0.5         -923    2.14e+005   
% % % %    11     95      -6070.8  -5.563e-005         0.25        -64.2    1.14e+005   
% % % %    12    108     -6070.97  -5.805e-005      0.00391         -115    2.53e+005   
% % % %    13    113     -6071.39  -6.726e-005            1         -177    5.84e+004   
% % % %    14    118     -6071.42  -6.573e-005            1         -114     6.1e+003   
% % % %    15    123     -6071.42  -6.489e-005            1        -9.45    3.88e+003   
% % % %    16    128     -6071.42  -6.511e-005            1        -1.58         93.9   
% % % % 
% % % % Local minimum possible. Constraints satisfied.
% % % % 
% % % % fmincon stopped because the predicted change in the objective function
% % % % is less than the selected value of the function tolerance and constraints 
% % % % were satisfied to within the selected value of the constraint tolerance.
% % % % 
% % % % <stopping criteria details>
% % % % 
% % % % No active inequalities.
% % % % 
% % % % ans =
% % % % 
% % % %     0.0864
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.8833
% % % % 
% % % % Calculando BDS para sub-rogados... 20% concluido
% % % % Calculando BDS para sub-rogados... 40% concluido
% % % % Calculando BDS para sub-rogados... 60% concluido
% % % % Calculando BDS para sub-rogados... 80% concluido
% % % % Calculando BDS para sub-rogados... 100% concluido
% % % % Calculando BDS para série original.
% % % % PREV(serie)
% % % % 
% % % % prev =
% % % % 
% % % %     4.6617
% % % % 
% % % % Elapsed time is 32.625768 seconds.
% % % % Warning: P is greater than the largest tabulated value,
% % % % returning 0.5. 
% % % % > In lillietest at 166
% % % %   In testanormal at 7
% % % %   In bds_residuoGARCH_dados_treinamento at 59
% % % % Warning: P is greater than the largest tabulated value,
% % % % returning 0.5. 
% % % % > In jbtest at 138
% % % %   In testanormal at 9
% % % %   In bds_residuoGARCH_dados_treinamento at 59
% % % % Warning: P is greater than the largest tabulated value,
% % % % returning 0.5. 
% % % % > In lillietest at 166
% % % %   In testanormal at 7
% % % %   In bds_residuoGARCH_dados_treinamento at 59
% % % % Warning: P is greater than the largest tabulated value,
% % % % returning 0.5. 
% % % % > In lillietest at 166
% % % %   In testanormal at 7
% % % %   In bds_residuoGARCH_dados_treinamento at 59
% % % % 
% % % % normalidade =
% % % % 
% % % %          0    0.0937    0.1884
% % % %          0    0.0916    0.1884
% % % %          0    0.1381    0.1884
% % % %          0    0.1522    0.1884
% % % %          0    0.0806    0.1884
% % % %          0    0.1343    0.1884
% % % %          0    0.1020    0.1884