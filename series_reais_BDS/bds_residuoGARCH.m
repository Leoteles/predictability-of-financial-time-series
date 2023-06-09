close all;
clear all;
clc;

%Teste BDS com as s�ries reais

%Modelagem GARCH e teste BDS com seus res�duos

carrega_series;

Nsur = 50;

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_bds_resGARCH_';



for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};

    %Estima modelo garch
    spec = garchset();
    spec.Comment
    [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,serie);
    
    Coeff.ARCH
    Coeff.GARCH
    
    %Calcula s�rie passada por filtro GARCH estimado
    serie = (Innovations./Sigmas);

    
    tic
    [estrutura, prev] = analiseBDS(serie,Nsur);
    est(i) = estrutura;
    disp('PREV(serie)');prev
    toc
    str = strcat(strfig,series_str{i});
    print('-depsc',str);

end


%Testa normalidade dos sub-rogados gerados
for i = 1:size(series,2)
    resultados = testanormal(est(i).w_sur);
    normalidade(i,:) = resultados;%Resultados da s�rie i para o teste kolmogorov-smirnov
end
%resultado da rejei��o | valor da estatistica | valor limite
normalidade
% 
% normalidade =
% 
%          0    0.0950    0.1884
%          0    0.1230    0.1884
%          0    0.1284    0.1884
%          0    0.0887    0.1884
%     1.0000    0.1896    0.1884
%          0    0.0720    0.1884
%          0    0.0770    0.1884

% Resultados
% w2
% djia 0.234336
% sp500 1.60184
% ibov 4.80123
% peto 3.26605
% peth 7.83592
% petl 5.93951
% petc 4.35754

% prev
% djia    0.3499
% sp500    1.3965
% ibov    5.9439
% peto    3.6253
% peth    8.6057
% petl    5.6522
% petc    4.9322



% % % 
% % % djia
% % % 
% % % ans =
% % % 
% % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % 
% % % 
% % % ____________________________________________________________
% % %    Diagnostic Information
% % % 
% % % Number of variables: 4
% % % 
% % % Functions 
% % %  Objective:                            internal.econ.garchllfn
% % %  Gradient:                             finite-differencing
% % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % %  Nonlinear constraints:                armanlc
% % %  Gradient of nonlinear constraints:    finite-differencing
% % % 
% % % Constraints
% % %  Number of nonlinear inequality constraints: 0
% % %  Number of nonlinear equality constraints:   0
% % %  
% % %  Number of linear inequality constraints:    1
% % %  Number of linear equality constraints:      0
% % %  Number of lower bound constraints:          4
% % %  Number of upper bound constraints:          4
% % % 
% % % Algorithm selected
% % %    medium-scale: SQP, Quasi-Newton, line-search
% % % 
% % % 
% % % ____________________________________________________________
% % %    End diagnostic information
% % % 
% % %                                 Max     Line search  Directional  First-order 
% % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % %     0      5     -91369.6  -1.322e-005                                         
% % %     1     25     -91376.3  -1.322e-005    3.05e-005   -6.24e+004    6.64e+005   
% % %     2     32     -92738.7  -9.918e-006         0.25   -2.19e+004    2.86e+008   
% % %     3     38       -92873  -4.959e-006          0.5   -3.45e+003    1.56e+008   
% % %     4     47     -92974.3  -5.594e-006       0.0625   -9.12e+003    6.59e+007   
% % %     5     52     -93422.6   2.118e-022            1   -3.46e+003    5.43e+008   
% % %     6     61       -93439            0       0.0625    -7.2e+004     3.7e+008   
% % %     7     72     -93495.7  -1.526e-006       0.0156   -1.13e+004    1.99e+008   
% % %     8     81     -93552.9  -2.168e-006       0.0625   -3.17e+003    8.95e+007   
% % %     9     86     -93567.3   -1.11e-016            1   -2.45e+003    1.43e+007   
% % %    10     96     -93568.9  -7.702e-007       0.0313   -2.23e+003    3.83e+007   
% % %    11    106     -93574.5  -1.754e-006       0.0313   -2.02e+003    4.76e+007   
% % %    12    114     -93579.9  -1.535e-006        0.125         -944    5.78e+006   
% % %    13    120     -93591.5   -1.04e-006          0.5   -1.81e+003    3.51e+007   
% % %    14    130     -93595.2  -1.065e-006       0.0313   -2.56e+003    7.73e+006   
% % %    15    136     -93595.5   -1.08e-006          0.5         -226    3.86e+006   
% % %    16    143     -93595.6  -1.055e-006         0.25         -151    1.67e+006   
% % %    17    150     -93595.6  -1.048e-006         0.25        -81.3    1.26e+006   
% % %    18    169     -93595.6  -1.048e-006    -6.1e-005        -60.4    1.26e+006   
% % %    19    175     -93595.6  -1.043e-006          0.5        -55.5    4.37e+005   
% % % 
% % % Local minimum possible. Constraints satisfied.
% % % 
% % % fmincon stopped because the predicted change in the objective function
% % % is less than the selected value of the function tolerance and constraints 
% % % were satisfied to within the selected value of the constraint tolerance.
% % % 
% % % <stopping criteria details>
% % % 
% % % No active inequalities.
% % % 
% % % ans =
% % % 
% % %     0.0886
% % % 
% % % 
% % % ans =
% % % 
% % %     0.9040
% % % 
% % % Calculando BDS para sub-rogados... 20% concluido
% % % Calculando BDS para sub-rogados... 40% concluido
% % % Calculando BDS para sub-rogados... 60% concluido
% % % Calculando BDS para sub-rogados... 80% concluido
% % % Calculando BDS para sub-rogados... 100% concluido
% % % Calculando BDS para s�rie original.
% % % PREV(serie)
% % % 
% % % prev =
% % % 
% % %     0.3499
% % % 
% % % Elapsed time is 1985.452364 seconds.
% % % sp500
% % % 
% % % ans =
% % % 
% % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % 
% % % 
% % % ____________________________________________________________
% % %    Diagnostic Information
% % % 
% % % Number of variables: 4
% % % 
% % % Functions 
% % %  Objective:                            internal.econ.garchllfn
% % %  Gradient:                             finite-differencing
% % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % %  Nonlinear constraints:                armanlc
% % %  Gradient of nonlinear constraints:    finite-differencing
% % % 
% % % Constraints
% % %  Number of nonlinear inequality constraints: 0
% % %  Number of nonlinear equality constraints:   0
% % %  
% % %  Number of linear inequality constraints:    1
% % %  Number of linear equality constraints:      0
% % %  Number of lower bound constraints:          4
% % %  Number of upper bound constraints:          4
% % % 
% % % Algorithm selected
% % %    medium-scale: SQP, Quasi-Newton, line-search
% % % 
% % % 
% % % ____________________________________________________________
% % %    End diagnostic information
% % % 
% % %                                 Max     Line search  Directional  First-order 
% % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % %     0      5       -51718  -9.183e-006                                         
% % %     1     25     -51718.9  -9.183e-006    3.05e-005   -3.33e+004    3.39e+005   
% % %     2     32     -52225.7  -6.887e-006         0.25   -9.88e+003    2.08e+008   
% % %     3     44     -52227.3  -7.302e-006      0.00781         -432     3.3e+007   
% % %     4     52     -52285.2  -6.389e-006        0.125   -2.63e+003    6.88e+007   
% % %     5     58     -52377.6  -3.195e-006          0.5   -1.49e+003    1.91e+008   
% % %     6     65     -52509.3  -4.155e-006         0.25   -7.98e+003    9.13e+007   
% % %     7     74     -52513.1  -4.857e-006       0.0625         -899    5.86e+007   
% % %     8     83     -52530.1  -4.553e-006       0.0625    -5.3e+003     2.7e+007   
% % %     9     88       -52643   2.118e-022            1      -2e+003    4.06e+008   
% % %    10     95     -52683.1            0         0.25   -1.69e+004    1.65e+008   
% % %    11    105     -52697.7  -1.423e-006       0.0313   -2.35e+003     5.5e+007   
% % %    12    112     -52701.3  -1.067e-006         0.25         -724    2.04e+007   
% % %    13    119     -52711.8  -9.255e-007         0.25   -2.41e+003     2.3e+007   
% % %    14    125     -52718.5  -4.702e-007          0.5         -761    9.74e+006   
% % %    15    137     -52726.9  -5.093e-007      0.00781   -2.39e+003     7.1e+005   
% % %    16    142     -52728.3  -4.486e-007            1         -816    3.29e+006   
% % %    17    147     -52728.7  -5.393e-007            1         -129    3.01e+006   
% % %    18    153     -52728.8  -5.194e-007          0.5         -127     1.7e+006   
% % %    19    172     -52728.8  -5.194e-007    -6.1e-005        -68.6     1.7e+006   
% % %    20    191     -52728.8  -5.194e-007    -6.1e-005        -46.1     1.7e+006   
% % %    21    210     -52728.8  -5.195e-007    -6.1e-005        -46.2    1.97e+006   
% % %    22    229     -52728.8  -5.195e-007    -6.1e-005        -53.7     1.7e+006   
% % %    23    248     -52728.8  -5.195e-007    -6.1e-005          -49    8.86e+005   
% % %    24    267     -52728.8  -5.195e-007    -6.1e-005        -47.3    1.71e+006   
% % %    25    286     -52728.8  -5.195e-007    -6.1e-005        -64.5    1.71e+006   
% % %    26    305     -52728.8  -5.195e-007    -6.1e-005          -58    1.71e+006   
% % %    27    324     -52728.8  -5.195e-007    -6.1e-005        -72.2    1.71e+006   
% % %    28    329     -52728.8  -5.175e-007            1         -373    1.11e+006  Hessian modified twice  
% % % 
% % % Local minimum possible. Constraints satisfied.
% % % 
% % % fmincon stopped because the predicted change in the objective function
% % % is less than the selected value of the function tolerance and constraints 
% % % were satisfied to within the selected value of the constraint tolerance.
% % % 
% % % <stopping criteria details>
% % % 
% % % No active inequalities.
% % % 
% % % ans =
% % % 
% % %     0.0795
% % % 
% % % 
% % % ans =
% % % 
% % %     0.9151
% % % 
% % % Calculando BDS para sub-rogados... 20% concluido
% % % Calculando BDS para sub-rogados... 40% concluido
% % % Calculando BDS para sub-rogados... 60% concluido
% % % Calculando BDS para sub-rogados... 80% concluido
% % % Calculando BDS para sub-rogados... 100% concluido
% % % Calculando BDS para s�rie original.
% % % PREV(serie)
% % % 
% % % prev =
% % % 
% % %     1.3965
% % % 
% % % Elapsed time is 589.900391 seconds.
% % % ibov
% % % 
% % % ans =
% % % 
% % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % 
% % % 
% % % ____________________________________________________________
% % %    Diagnostic Information
% % % 
% % % Number of variables: 4
% % % 
% % % Functions 
% % %  Objective:                            internal.econ.garchllfn
% % %  Gradient:                             finite-differencing
% % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % %  Nonlinear constraints:                armanlc
% % %  Gradient of nonlinear constraints:    finite-differencing
% % % 
% % % Constraints
% % %  Number of nonlinear inequality constraints: 0
% % %  Number of nonlinear equality constraints:   0
% % %  
% % %  Number of linear inequality constraints:    1
% % %  Number of linear equality constraints:      0
% % %  Number of lower bound constraints:          4
% % %  Number of upper bound constraints:          4
% % % 
% % % Algorithm selected
% % %    medium-scale: SQP, Quasi-Newton, line-search
% % % 
% % % 
% % % ____________________________________________________________
% % %    End diagnostic information
% % % 
% % %                                 Max     Line search  Directional  First-order 
% % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % %     0      5     -24536.7  -7.294e-005                                         
% % %     1     23     -24539.9  -7.293e-005     0.000122   -1.31e+004     1.2e+005   
% % %     2     29     -24581.1  -3.646e-005          0.5    -9.2e+003    3.93e+007   
% % %     3     35     -24619.2   -0.0001912          0.5   -8.58e+003     6.6e+005   
% % %     4     41     -24822.3  -9.996e-005          0.5   -1.14e+003    7.12e+006   
% % %     5     50     -24948.2   -0.0001083       0.0625   -9.07e+003    9.32e+006   
% % %     6     58     -25010.9   -0.0001368        0.125   -1.84e+003    6.01e+006   
% % %     7     64     -25342.7  -6.842e-005          0.5   -6.63e+003    2.66e+005   
% % %     8     71     -25365.2  -5.132e-005         0.25         -982    5.67e+006   
% % %     9     78     -25398.4  -3.849e-005         0.25   -3.06e+003    5.51e+006   
% % %    10     84     -25467.9  -1.924e-005          0.5   -4.46e+003    1.25e+007   
% % %    11     93     -25499.6  -2.595e-005       0.0625   -9.23e+003    1.72e+006   
% % %    12     98     -25547.1   1.906e-021            1   -1.33e+003    6.16e+007   
% % %    13    106     -25585.1   -1.11e-016        0.125    -1.9e+004    1.92e+007   
% % %    14    117     -25604.5  -7.408e-006       0.0156   -4.14e+003    8.84e+006   
% % %    15    125     -25657.3  -1.158e-005        0.125   -1.64e+003    3.05e+006   
% % %    16    130     -25671.5            0            1         -673    7.75e+005   
% % %    17    139     -25673.1  -7.957e-006       0.0625         -273    7.31e+005   
% % %    18    145     -25673.2  -8.139e-006          0.5        -40.8    4.58e+005   
% % %    19    150     -25673.2  -8.081e-006            1        -29.5    4.23e+005   
% % %    20    155     -25673.2   -7.95e-006            1        -26.3    2.54e+005   
% % %    21    160     -25673.2  -7.891e-006            1        -42.2    5.33e+004   
% % %    22    165     -25673.2  -7.882e-006            1        -14.6    1.09e+003   
% % %    23    170     -25673.2  -7.888e-006            1       -0.993       1e+003   
% % % 
% % % Local minimum possible. Constraints satisfied.
% % % 
% % % fmincon stopped because the predicted change in the objective function
% % % is less than the selected value of the function tolerance and constraints 
% % % were satisfied to within the selected value of the constraint tolerance.
% % % 
% % % <stopping criteria details>
% % % 
% % % No active inequalities.
% % % 
% % % ans =
% % % 
% % %     0.1452
% % % 
% % % 
% % % ans =
% % % 
% % %     0.8506
% % % 
% % % Calculando BDS para sub-rogados... 20% concluido
% % % Calculando BDS para sub-rogados... 40% concluido
% % % Calculando BDS para sub-rogados... 60% concluido
% % % Calculando BDS para sub-rogados... 80% concluido
% % % Calculando BDS para sub-rogados... 100% concluido
% % % Calculando BDS para s�rie original.
% % % PREV(serie)
% % % 
% % % prev =
% % % 
% % %     5.9439
% % % 
% % % Elapsed time is 281.987752 seconds.
% % % peto
% % % 
% % % ans =
% % % 
% % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % 
% % % 
% % % ____________________________________________________________
% % %    Diagnostic Information
% % % 
% % % Number of variables: 4
% % % 
% % % Functions 
% % %  Objective:                            internal.econ.garchllfn
% % %  Gradient:                             finite-differencing
% % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % %  Nonlinear constraints:                armanlc
% % %  Gradient of nonlinear constraints:    finite-differencing
% % % 
% % % Constraints
% % %  Number of nonlinear inequality constraints: 0
% % %  Number of nonlinear equality constraints:   0
% % %  
% % %  Number of linear inequality constraints:    1
% % %  Number of linear equality constraints:      0
% % %  Number of lower bound constraints:          4
% % %  Number of upper bound constraints:          4
% % % 
% % % Algorithm selected
% % %    medium-scale: SQP, Quasi-Newton, line-search
% % % 
% % % 
% % % ____________________________________________________________
% % %    End diagnostic information
% % % 
% % %                                 Max     Line search  Directional  First-order 
% % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % %     0      5      -6725.4   -0.0002476                                         
% % %     1     25     -6725.55   -0.0002476    3.05e-005         -778    3.63e+003   
% % %     2     32     -6990.69   -0.0001857         0.25   -3.32e+003    2.84e+006   
% % %     3     41     -6997.04   -0.0002607       0.0625         -490    3.52e+004   
% % %     4     48     -7008.64   -0.0001955         0.25         -219     1.2e+005   
% % %     5     54     -7023.41  -9.775e-005          0.5         -153    4.84e+005   
% % %     6     64     -7023.51   -0.0001082       0.0313         -184    4.04e+005   
% % %     7     69     -7025.73   -1.11e-016            1         -291    7.26e+004   
% % %     8     82     -7026.26    -4.4e-005      0.00391         -355    3.95e+005   
% % %     9     89      -7027.5  -5.402e-005         0.25         -371    1.92e+005   
% % %    10     98     -7032.73   -7.87e-005       0.0625         -239    2.98e+005   
% % %    11    103     -7034.26  -7.124e-005            1         -198    7.17e+004   
% % %    12    108     -7034.32  -6.923e-005            1        -44.7          225   
% % %    13    113     -7034.33      -7e-005            1        -8.24    6.71e+003   
% % %    14    118     -7034.33  -7.025e-005            1        -2.16    3.39e+003   
% % %    15    123     -7034.33  -7.036e-005            1        -1.23          259  Hessian modified  
% % %    16    128     -7034.33  -7.036e-005            1       -0.253         36.9  Hessian modified  
% % % 
% % % Local minimum possible. Constraints satisfied.
% % % 
% % % fmincon stopped because the size of the current search direction is less than
% % % twice the selected value of the step size tolerance and constraints were 
% % % satisfied to within the selected value of the constraint tolerance.
% % % 
% % % <stopping criteria details>
% % % 
% % % No active inequalities.
% % % 
% % % ans =
% % % 
% % %     0.1324
% % % 
% % % 
% % % ans =
% % % 
% % %     0.8445
% % % 
% % % Calculando BDS para sub-rogados... 20% concluido
% % % Calculando BDS para sub-rogados... 40% concluido
% % % Calculando BDS para sub-rogados... 60% concluido
% % % Calculando BDS para sub-rogados... 80% concluido
% % % Calculando BDS para sub-rogados... 100% concluido
% % % Calculando BDS para s�rie original.
% % % PREV(serie)
% % % 
% % % prev =
% % % 
% % %     3.6253
% % % 
% % % Elapsed time is 43.732174 seconds.
% % % peth
% % % 
% % % ans =
% % % 
% % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % 
% % % 
% % % ____________________________________________________________
% % %    Diagnostic Information
% % % 
% % % Number of variables: 4
% % % 
% % % Functions 
% % %  Objective:                            internal.econ.garchllfn
% % %  Gradient:                             finite-differencing
% % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % %  Nonlinear constraints:                armanlc
% % %  Gradient of nonlinear constraints:    finite-differencing
% % % 
% % % Constraints
% % %  Number of nonlinear inequality constraints: 0
% % %  Number of nonlinear equality constraints:   0
% % %  
% % %  Number of linear inequality constraints:    1
% % %  Number of linear equality constraints:      0
% % %  Number of lower bound constraints:          4
% % %  Number of upper bound constraints:          4
% % % 
% % % Algorithm selected
% % %    medium-scale: SQP, Quasi-Newton, line-search
% % % 
% % % 
% % % ____________________________________________________________
% % %    End diagnostic information
% % % 
% % %                                 Max     Line search  Directional  First-order 
% % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % %     0      5      -7563.1   -0.0001558                                         
% % %     1     25     -7563.31   -0.0001558    3.05e-005   -1.16e+003    7.99e+003   
% % %     2     32     -7607.33   -0.0001168         0.25   -2.79e+003    5.16e+006   
% % %     3     39     -7642.22   -0.0002996         0.25   -1.26e+003    1.62e+005   
% % %     4     47     -7642.79   -0.0003534        0.125         -163    1.64e+004   
% % %     5     54     -7653.31   -0.0002756         0.25         -213    1.59e+005   
% % %     6     60      -7657.4   -0.0002548          0.5         -210    5.17e+005   
% % %     7     67     -7671.28   -0.0002414         0.25         -780    7.09e+005   
% % %     8     76     -7672.99   -0.0002586       0.0625        -88.9    4.49e+005   
% % %     9     82     -7711.64   -0.0001347          0.5         -348    1.31e+005   
% % %    10     88     -7728.15  -6.737e-005          0.5         -263    1.33e+006   
% % %    11     94     -7743.75  -3.369e-005          0.5         -295    2.79e+006   
% % %    12    100     -7761.78  -2.138e-005          0.5         -664    2.32e+006   
% % %    13    106      -7766.8  -2.294e-005          0.5         -475    8.01e+005   
% % %    14    118     -7768.03  -2.794e-005      0.00781         -406    2.87e+005   
% % %    15    125     -7768.51  -2.409e-005         0.25        -86.3    1.85e+005   
% % %    16    131     -7768.62  -2.153e-005          0.5         -320    3.48e+005   
% % %    17    136     -7768.74  -2.291e-005            1         -155    6.87e+004   
% % %    18    141     -7768.75  -2.264e-005            1        -28.7    9.04e+003   
% % %    19    148     -7768.75  -2.262e-005         0.25         -3.8    6.63e+003   
% % %    20    156     -7768.75  -2.261e-005        0.125        -6.18    2.36e+003  Hessian modified twice  
% % % 
% % % Local minimum possible. Constraints satisfied.
% % % 
% % % fmincon stopped because the predicted change in the objective function
% % % is less than the selected value of the function tolerance and constraints 
% % % were satisfied to within the selected value of the constraint tolerance.
% % % 
% % % <stopping criteria details>
% % % 
% % % No active inequalities.
% % % 
% % % ans =
% % % 
% % %     0.0681
% % % 
% % % 
% % % ans =
% % % 
% % %     0.9217
% % % 
% % % Calculando BDS para sub-rogados... 20% concluido
% % % Calculando BDS para sub-rogados... 40% concluido
% % % Calculando BDS para sub-rogados... 60% concluido
% % % Calculando BDS para sub-rogados... 80% concluido
% % % Calculando BDS para sub-rogados... 100% concluido
% % % Calculando BDS para s�rie original.
% % % PREV(serie)
% % % 
% % % prev =
% % % 
% % %     8.6057
% % % 
% % % Elapsed time is 43.804831 seconds.
% % % petl
% % % 
% % % ans =
% % % 
% % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % 
% % % 
% % % ____________________________________________________________
% % %    Diagnostic Information
% % % 
% % % Number of variables: 4
% % % 
% % % Functions 
% % %  Objective:                            internal.econ.garchllfn
% % %  Gradient:                             finite-differencing
% % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % %  Nonlinear constraints:                armanlc
% % %  Gradient of nonlinear constraints:    finite-differencing
% % % 
% % % Constraints
% % %  Number of nonlinear inequality constraints: 0
% % %  Number of nonlinear equality constraints:   0
% % %  
% % %  Number of linear inequality constraints:    1
% % %  Number of linear equality constraints:      0
% % %  Number of lower bound constraints:          4
% % %  Number of upper bound constraints:          4
% % % 
% % % Algorithm selected
% % %    medium-scale: SQP, Quasi-Newton, line-search
% % % 
% % % 
% % % ____________________________________________________________
% % %    End diagnostic information
% % % 
% % %                                 Max     Line search  Directional  First-order 
% % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % %     0      5      -6914.8   -0.0002282                                         
% % %     1     25      -6914.9   -0.0002281    3.05e-005         -639    3.88e+003   
% % %     2     32     -7194.36   -0.0001711         0.25   -3.56e+003    3.13e+006   
% % %     3     42     -7198.47    -0.000207       0.0313         -377    1.39e+005   
% % %     4     49     -7201.49   -0.0001552         0.25         -547    4.21e+005   
% % %     5     55     -7238.82  -7.761e-005          0.5         -542    1.13e+006   
% % %     6     65     -7246.74   -0.0001072       0.0313   -1.02e+003    1.08e+005   
% % %     7     71     -7260.74  -5.359e-005          0.5         -196    9.27e+005   
% % %     8     78     -7266.11  -5.468e-005         0.25   -1.63e+003    7.26e+005   
% % %     9     83     -7268.82    1.11e-016            1         -370    4.87e+005   
% % %    10     88     -7270.01            0            1         -123    1.94e+004   
% % %    11     98        -7271  -4.712e-005       0.0313         -369    3.15e+005   
% % %    12    107     -7271.12  -4.905e-005       0.0625        -29.6    2.72e+005   
% % %    13    118     -7271.24  -4.992e-005       0.0156         -121    1.59e+005   
% % %    14    123     -7271.35  -4.674e-005            1        -91.7    4.14e+004   
% % %    15    128     -7271.41  -4.478e-005            1          -25    2.66e+004   
% % %    16    133     -7271.43  -4.637e-005            1        -16.6       1e+004   
% % %    17    138     -7271.44  -4.612e-005            1           -9          664   
% % %    18    143     -7271.44  -4.612e-005            1       -0.897         82.1   
% % % 
% % % Local minimum possible. Constraints satisfied.
% % % 
% % % fmincon stopped because the predicted change in the objective function
% % % is less than the selected value of the function tolerance and constraints 
% % % were satisfied to within the selected value of the constraint tolerance.
% % % 
% % % <stopping criteria details>
% % % 
% % % No active inequalities.
% % % 
% % % ans =
% % % 
% % %     0.1278
% % % 
% % % 
% % % ans =
% % % 
% % %     0.8625
% % % 
% % % Calculando BDS para sub-rogados... 20% concluido
% % % Calculando BDS para sub-rogados... 40% concluido
% % % Calculando BDS para sub-rogados... 60% concluido
% % % Calculando BDS para sub-rogados... 80% concluido
% % % Calculando BDS para sub-rogados... 100% concluido
% % % Calculando BDS para s�rie original.
% % % PREV(serie)
% % % 
% % % prev =
% % % 
% % %     5.6522
% % % 
% % % Elapsed time is 43.529497 seconds.
% % % petc
% % % 
% % % ans =
% % % 
% % % Mean: ARMAX(0,0,?); Variance: GARCH(1,1) 
% % % 
% % % 
% % % ____________________________________________________________
% % %    Diagnostic Information
% % % 
% % % Number of variables: 4
% % % 
% % % Functions 
% % %  Objective:                            internal.econ.garchllfn
% % %  Gradient:                             finite-differencing
% % %  Hessian:                              finite-differencing (or Quasi-Newton)
% % %  Nonlinear constraints:                armanlc
% % %  Gradient of nonlinear constraints:    finite-differencing
% % % 
% % % Constraints
% % %  Number of nonlinear inequality constraints: 0
% % %  Number of nonlinear equality constraints:   0
% % %  
% % %  Number of linear inequality constraints:    1
% % %  Number of linear equality constraints:      0
% % %  Number of lower bound constraints:          4
% % %  Number of upper bound constraints:          4
% % % 
% % % Algorithm selected
% % %    medium-scale: SQP, Quasi-Newton, line-search
% % % 
% % % 
% % % ____________________________________________________________
% % %    End diagnostic information
% % % 
% % %                                 Max     Line search  Directional  First-order 
% % %  Iter F-count        f(x)   constraint   steplength   derivative   optimality Procedure 
% % %     0      5     -7170.26   -0.0001933                                         
% % %     1     25     -7170.28   -0.0001932    3.05e-005         -457    3.25e+003   
% % %     2     32     -7258.34   -0.0001449         0.25   -2.98e+003    4.03e+006   
% % %     3     40     -7287.02   -0.0002659        0.125   -1.11e+003    8.05e+004   
% % %     4     46     -7314.46   -0.0001457          0.5         -347    1.12e+006   
% % %     5     57     -7315.51   -0.0001563       0.0156         -201    9.42e+005   
% % %     6     67     -7345.83   -0.0001514       0.0313   -2.75e+003     7.4e+005   
% % %     7     73      -7371.6  -9.473e-005          0.5         -259    1.33e+005   
% % %     8     79     -7375.89  -4.736e-005          0.5   -1.26e+003    2.25e+006   
% % %     9     91     -7376.55  -5.168e-005      0.00781         -162    1.44e+006   
% % %    10     98     -7396.26  -4.729e-005         0.25         -851     5.2e+005   
% % %    11    105     -7397.12  -3.619e-005         0.25         -111    6.48e+005   
% % %    12    114     -7397.56  -3.393e-005       0.0625         -927     4.2e+004   
% % %    13    120     -7399.22  -2.725e-005          0.5         -633    2.42e+005   
% % %    14    125     -7399.39  -3.318e-005            1         -122     6.5e+004   
% % %    15    130     -7399.51  -3.071e-005            1        -43.7    3.25e+004   
% % %    16    135     -7399.51  -3.039e-005            1        -22.5    4.81e+003   
% % %    17    140     -7399.51  -3.044e-005            1        -3.17         42.6   
% % % 
% % % Local minimum possible. Constraints satisfied.
% % % 
% % % fmincon stopped because the size of the current search direction is less than
% % % twice the selected value of the step size tolerance and constraints were 
% % % satisfied to within the selected value of the constraint tolerance.
% % % 
% % % <stopping criteria details>
% % % 
% % % No active inequalities.
% % % 
% % % ans =
% % % 
% % %     0.0771
% % % 
% % % 
% % % ans =
% % % 
% % %     0.9113
% % % 
% % % Calculando BDS para sub-rogados... 20% concluido
% % % Calculando BDS para sub-rogados... 40% concluido
% % % Calculando BDS para sub-rogados... 60% concluido
% % % Calculando BDS para sub-rogados... 80% concluido
% % % Calculando BDS para sub-rogados... 100% concluido
% % % Calculando BDS para s�rie original.
% % % PREV(serie)
% % % 
% % % prev =
% % % 
% % %     4.9322
% % % 
% % % Elapsed time is 44.796172 seconds.
% % % 
% % % 
% % % 
% % % 
% % % 
