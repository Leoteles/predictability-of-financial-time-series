close all;
clear all;
clc;

%Teste BDS com as séries reais

%Modelagem AR-GARCH e teste BDS com seus resíduos

carrega_series;

Nsur = 50;

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_bds_resARGARCH_';


% % % series = {ribov};
% % % series_str = {'ibov'};
% % % 
% % % serie = rdjia;




for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};
    %Estima modelo AR para a série real i
    modelo = estimaModeloAR(serie);
    disp('Ordem do modelo AR:');disp(modelo.k);
    %A nova série a ser analisada será a dos resíduos do modelo AR(k)
    serie = modelo.residuos;

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
    str = strcat(strfig,series_str{i});
    print('-depsc',str);

end


%Testa normalidade dos sub-rogados gerados
for i = 1:size(series,2)
    resultados = testanormal(est(i).w_sur);
    normalidade(i,:) = resultados;%Resultados da série i para o teste kolmogorov-smirnov
end
%resultado da rejeição | valor da estatistica | valor limite
normalidade

% 
% normalidade =
% 
%          0    0.1403    0.1884
%          0    0.1558    0.1884
%          0    0.1479    0.1884
%          0    0.1011    0.1884
%          0    0.1805    0.1884
%          0    0.0917    0.1884
%          0    0.0729    0.1884



% Resultados
% w2
% djia 0.210291
% sp500 0.906226
% ibov -0.148517
% peto 3.5177
% peth 6.27579
% petl 3.94734
% petc 3.44633

% prev
% djia 0.2658
% sp500 1.1415
% ibov 0.3673
% peto 3.3199
% peth 5.5479
% petl 4.5841
% petc 3.6434

% Ordens AR
% djia 6
% sp500 15
% ibov 15
% peto 3
% peth 2
% petl 6
% petc 3


%Resultados mostrados:

% % % % 
% % % % djia
% % % % Ordem do modelo AR:
% % % %      6
% % % % 
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
% % % %     0      5       -91384  -1.319e-005                                         
% % % %     1     25     -91390.2  -1.319e-005    3.05e-005   -6.08e+004    6.26e+005   
% % % %     2     32     -92750.1  -9.895e-006         0.25   -2.19e+004    2.87e+008   
% % % %     3     38     -92882.4  -4.947e-006          0.5   -3.49e+003    1.56e+008   
% % % %     4     47     -92951.3  -5.864e-006       0.0625   -1.02e+004    4.92e+007   
% % % %     5     52     -93443.3   2.118e-022            1   -3.61e+003    5.61e+008   
% % % %     6     62       -93560            0       0.0313    -8.9e+004    8.64e+007   
% % % %     7     73     -93565.2  -1.123e-006       0.0156   -7.38e+003     3.8e+007   
% % % %     8     83     -93580.5  -1.413e-006       0.0313   -2.07e+003    7.35e+007   
% % % %     9     88     -93593.3   -1.11e-016            1   -2.74e+003    5.21e+007   
% % % %    10    102     -93595.4  -5.827e-007      0.00195   -3.48e+003    4.96e+007   
% % % %    11    111       -93596  -6.043e-007       0.0625         -418    2.16e+007   
% % % %    12    122     -93611.1  -1.048e-006       0.0156   -2.63e+003    1.53e+007   
% % % %    13    127     -93613.7  -9.905e-007            1   -2.29e+003    1.81e+007   
% % % %    14    132     -93613.9  -9.749e-007            1         -247    6.95e+006   
% % % %    15    137       -93614  -9.848e-007            1         -212    3.09e+006   
% % % %    16    142     -93614.1  -9.984e-007            1        -61.5    1.34e+005   
% % % %    17    147     -93614.1      -1e-006            1        -8.23    8.82e+003   
% % % %    18    152     -93614.1  -1.001e-006            1        -3.22    9.04e+004  Hessian modified twice  
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
% % % %     0.0875
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.9054
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
% % % %     0.2658
% % % % 
% % % % Elapsed time is 2029.941501 seconds.
% % % % sp500
% % % % Ordem do modelo AR:
% % % %     15
% % % % 
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
% % % %     0      5     -51704.3  -9.131e-006                                         
% % % %     1     25     -51705.3  -9.131e-006    3.05e-005   -3.41e+004    3.61e+005   
% % % %     2     32     -52212.6  -6.848e-006         0.25   -9.89e+003    2.09e+008   
% % % %     3     43     -52212.7  -7.675e-006       0.0156         -449    2.44e+007   
% % % %     4     51     -52273.1  -6.715e-006        0.125   -2.48e+003    5.84e+007   
% % % %     5     57     -52356.3  -3.358e-006          0.5   -1.47e+003    1.86e+008   
% % % %     6     64       -52485  -4.226e-006         0.25   -7.58e+003    8.23e+007   
% % % %     7     73     -52488.5  -4.956e-006       0.0625         -878    5.51e+007   
% % % %     8     81     -52495.6  -4.336e-006        0.125   -7.52e+003       6e+007   
% % % %     9     86     -52644.1   2.118e-022            1   -2.07e+003    3.76e+008   
% % % %    10     94     -52697.8    1.11e-016        0.125   -1.12e+004     7.8e+007   
% % % %    11    105     -52707.6   -7.92e-007       0.0156   -1.97e+003    2.54e+007   
% % % %    12    114     -52708.3  -7.452e-007       0.0625         -255    2.47e+007   
% % % %    13    121     -52709.7  -6.961e-007         0.25   -2.04e+003     1.9e+007   
% % % %    14    127     -52713.4  -4.968e-007          0.5   -1.05e+003    2.32e+007   
% % % %    15    138     -52714.4  -5.567e-007       0.0156   -1.36e+003    1.44e+007   
% % % %    16    143     -52714.5  -5.035e-007            1         -893    3.34e+006   
% % % %    17    149     -52714.5  -5.017e-007          0.5        -60.9    1.75e+006   
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
% % % %     0.0790
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.9158
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
% % % %     1.1415
% % % % 
% % % % Elapsed time is 592.336945 seconds.
% % % % ibov
% % % % Ordem do modelo AR:
% % % %     15
% % % % 
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
% % % %     0      5     -24679.1  -7.042e-005                                         
% % % %     1     25     -24680.4  -7.041e-005    3.05e-005   -7.15e+003    6.04e+004   
% % % %     2     31     -24700.2  -3.521e-005          0.5   -9.14e+003    4.19e+007   
% % % %     3     37     -24735.2   -0.0001905          0.5   -8.38e+003    7.83e+005   
% % % %     4     43       -24953   -0.0001233          0.5    -1.5e+003    8.81e+006   
% % % %     5     55     -24957.2   -0.0001223      0.00781   -2.09e+003    6.95e+006   
% % % %     6     62     -25268.5   -0.0001061         0.25   -5.23e+003    4.12e+006   
% % % %     7     68     -25409.9  -5.304e-005          0.5   -3.33e+003    4.06e+006   
% % % %     8     75     -25421.2  -3.978e-005         0.25         -587    9.31e+006   
% % % %     9     81     -25575.8  -3.345e-005          0.5    -2.2e+003    1.25e+007   
% % % %    10     87     -25745.7  -1.673e-005          0.5   -1.04e+004    2.98e+006   
% % % %    11     93       -25778  -8.363e-006          0.5   -2.31e+003    9.01e+006   
% % % %    12    102     -25780.6  -9.321e-006       0.0625         -615    2.65e+006   
% % % %    13    107     -25781.8   -1.11e-016            1   -1.29e+003    3.11e+006   
% % % %    14    112     -25782.9            0            1   -1.93e+003    3.62e+006   
% % % %    15    122     -25783.9   -7.76e-006       0.0313         -566    2.82e+006   
% % % %    16    132       -25784  -8.548e-006       0.0313        -70.1    1.62e+006   
% % % %    17    137       -25785  -8.346e-006            1         -208    6.33e+005   
% % % %    18    142     -25785.2  -6.881e-006            1         -562     1.2e+005   
% % % %    19    147       -25786  -7.805e-006            1         -303    7.17e+004   
% % % %    20    152       -25786   -7.72e-006            1        -18.4    3.22e+004   
% % % %    21    158       -25786  -7.713e-006          0.5         -8.3    1.62e+004   
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
% % % %     0.1423
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.8533
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
% % % %     0.3673
% % % % 
% % % % Elapsed time is 279.120847 seconds.
% % % % peto
% % % % Ordem do modelo AR:
% % % %      3
% % % % 
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
% % % %     0      5     -6991.73   -0.0002132                                         
% % % %     1     25     -6991.78   -0.0002132    3.05e-005         -517    3.49e+003   
% % % %     2     32     -7174.42   -0.0001599         0.25   -3.18e+003    3.18e+006   
% % % %     3     40     -7181.59   -0.0003044        0.125         -890     2.1e+005   
% % % %     4     46     -7191.83    -0.000162          0.5         -143    1.19e+006   
% % % %     5     53     -7209.47   -0.0001215         0.25         -833    2.28e+005   
% % % %     6     63     -7210.35    -0.000136       0.0313        -64.5    3.58e+005   
% % % %     7     72     -7214.13   -0.0001796       0.0625         -650     1.9e+005   
% % % %     8     78     -7226.24  -8.978e-005          0.5         -268    9.63e+005   
% % % %     9     87     -7227.77   -0.0001011       0.0625         -154    4.75e+005   
% % % %    10     93     -7230.13  -6.888e-005          0.5         -122    7.16e+005   
% % % %    11    100     -7230.64   -6.39e-005         0.25         -283    7.33e+005   
% % % %    12    110     -7230.87  -8.253e-005       0.0313        -56.7    7.09e+005   
% % % %    13    116     -7235.07  -7.127e-005          0.5         -639    7.98e+004   
% % % %    14    121     -7235.18   -6.87e-005            1        -73.5    2.28e+004   
% % % %    15    126      -7235.2  -7.065e-005            1        -27.8    8.63e+003   
% % % %    16    131      -7235.2  -7.041e-005            1        -3.58    1.66e+003   
% % % %    17    136      -7235.2  -7.047e-005            1        -1.13         63.1   
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
% % % %     0.1309
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.8440
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
% % % %     3.3199
% % % % 
% % % % Elapsed time is 42.286651 seconds.
% % % % peth
% % % % Ordem do modelo AR:
% % % %      2
% % % % 
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
% % % %     0      5     -7593.66   -0.0001516                                         
% % % %     1     25     -7593.79   -0.0001516    3.05e-005         -924    5.78e+003   
% % % %     2     32     -7625.65   -0.0001137         0.25    -2.7e+003    5.29e+006   
% % % %     3     39     -7668.35   -0.0002879         0.25   -1.28e+003    1.08e+005   
% % % %     4     46     -7679.66   -0.0002329         0.25         -146    5.76e+005   
% % % %     5     57     -7681.75    -0.000236       0.0156         -406    4.99e+005   
% % % %     6     63     -7690.56   -0.0002487          0.5         -210    4.79e+005   
% % % %     7     72     -7696.72   -0.0002519       0.0625         -267    1.68e+005   
% % % %     8     78     -7732.05   -0.0001259          0.5         -278    4.57e+005   
% % % %     9     84     -7748.47  -6.297e-005          0.5         -216    1.66e+006   
% % % %    10     90     -7773.63  -3.149e-005          0.5         -356    2.34e+006   
% % % %    11     99     -7779.57  -3.571e-005       0.0625   -1.82e+003    4.59e+005   
% % % %    12    105     -7780.55  -2.576e-005          0.5         -186    6.01e+005   
% % % %    13    113     -7781.23  -2.254e-005        0.125         -160     1.7e+005   
% % % %    14    121     -7781.34  -2.516e-005        0.125        -52.4    8.82e+004   
% % % %    15    126     -7781.38  -2.423e-005            1         -308    1.64e+005   
% % % %    16    131     -7781.45  -2.465e-005            1         -209     1.8e+004   
% % % %    17    136     -7781.45  -2.456e-005            1        -6.13    3.82e+003   
% % % %    18    141     -7781.46  -2.457e-005            1        -7.05          521   
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
% % % %     0.0651
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.9218
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
% % % %     5.5479
% % % % 
% % % % Elapsed time is 44.095740 seconds.
% % % % petl
% % % % Ordem do modelo AR:
% % % %      6
% % % % 
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
% % % %     0      5     -7270.16   -0.0001855                                         
% % % %     1     25     -7270.44   -0.0001855    3.05e-005   -1.31e+003    8.91e+003   
% % % %     2     32     -7434.58   -0.0001391         0.25   -3.27e+003    3.73e+006   
% % % %     3     40     -7438.06   -0.0002663        0.125         -894    2.62e+005   
% % % %     4     46     -7479.11   -0.0001339          0.5         -191    1.29e+006   
% % % %     5     52     -7505.71  -6.694e-005          0.5         -400     4.3e+005   
% % % %     6     62     -7510.32   -6.96e-005       0.0313         -332    7.76e+005   
% % % %     7     68     -7512.51  -5.741e-005          0.5    -1.2e+003    3.01e+005   
% % % %     8     73     -7515.03            0            1         -856    1.53e+006   
% % % %     9     84     -7518.47  -3.196e-005       0.0156         -639    3.21e+005   
% % % %    10     99     -7518.47  -3.214e-005     0.000977        -18.7     3.8e+005   
% % % %    11    109     -7524.97    -4.8e-005       0.0313   -1.19e+003    1.97e+005   
% % % %    12    114     -7526.49  -4.641e-005            1         -547    1.24e+005   
% % % %    13    119     -7526.58  -4.739e-005            1        -49.5     6.3e+004   
% % % %    14    124     -7526.61  -4.863e-005            1        -22.3    1.18e+004   
% % % %    15    129     -7526.62    -4.9e-005            1        -7.97          479   
% % % %    16    134     -7526.62  -4.905e-005            1        -2.78          323   
% % % %    17    139     -7526.62  -4.905e-005            1       -0.303         98.3  Hessian modified  
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
% % % %     0.1207
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.8631
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
% % % %     4.5841
% % % % 
% % % % Elapsed time is 41.610238 seconds.
% % % % petc
% % % % Ordem do modelo AR:
% % % %      3
% % % % 
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
% % % %     0      5     -7191.44   -0.0001882                                         
% % % %     1     25     -7191.49   -0.0001882    3.05e-005         -562    3.07e+003   
% % % %     2     32     -7269.34   -0.0001411         0.25   -2.82e+003    3.97e+006   
% % % %     3     40     -7297.09   -0.0002565        0.125   -1.04e+003    9.88e+004   
% % % %     4     46      -7336.1   -0.0001475          0.5         -252    1.14e+006   
% % % %     5     52     -7388.42  -7.375e-005          0.5         -510    7.08e+004   
% % % %     6     60     -7389.53  -6.997e-005        0.125         -252     3.2e+005   
% % % %     7     66      -7396.5  -3.499e-005          0.5         -219    1.52e+006   
% % % %     8     73     -7399.98  -3.532e-005         0.25         -948     5.8e+005   
% % % %     9     87     -7399.99  -3.669e-005      0.00195        -19.7    5.69e+005   
% % % %    10     95     -7402.21  -3.331e-005        0.125   -2.45e+003    2.25e+005   
% % % %    11    102     -7402.31  -2.879e-005         0.25        -73.8    1.49e+005   
% % % %    12    109     -7402.34  -2.993e-005         0.25        -92.1    1.93e+005   
% % % %    13    114     -7402.45  -3.094e-005            1         -423    8.71e+003   
% % % %    14    119     -7402.45  -3.064e-005            1        -4.38          691   
% % % %    15    124     -7402.45  -3.066e-005            1       -0.685         91.9   
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
% % % %     0.0738
% % % % 
% % % % 
% % % % ans =
% % % % 
% % % %     0.9134
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
% % % %     3.6434
% % % % 
% % % % Elapsed time is 42.368907 seconds.

