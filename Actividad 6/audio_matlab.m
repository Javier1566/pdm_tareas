clear;
clc;

% Se lee el audio en la ruta especificada
[f,fs]=audioread("C:\Users\Jav\Documents\Matlab_pruebas\Baracuda_1977.wav");
% Este comando devuelve 2 variables: f = señal del audio
%                                    fs = Frecuencia de muestreo

f= reshape(f, [], 1);
% Se toma el primer vector del audio
T=1/fs;      % Periodo de muestreo
L=length(f); % Obtiene el largo del vector f
t=(0:L-1)*T; % Genera el vector(t) para graficar

% Al igual que en numpy, se utilizaran comandos parecidos
figure    % Pero sin el plt.
plot(t,f) % Grafica la señal
grid on % Al igual que plt.grid(True), agrega cuadricula al grafico
title("Señal de entrada audio f(t)")% Agrega el titulo al grafico
xlabel("Tiempo (s)")                % Etiqueta del eje x
ylabel("Amplitud de la señal")      % Etiqueta del eje y


%--------------------(pitch shifting)------------------------------
factor_vel = 0.8; % Factor de velocidad
                               % Interpolar la funcion: 
f_pitch_shifting = interp1(t, f, t * factor_vel);
% Reajuste del largo de la señal respecto a su pitch
f_pitch_shifting = f_pitch_shifting(1:length(f));
%---------------Graficos------------------------------------------
figure           % Similar a plt.figure()

subplot(2,1,1)   % Crea un subplot de matriz 2x1 en posicion 1
plot(t, f)       % Grafico original

title("Señal original")
xlabel("Tiempo (s)")
ylabel("Amplitud de la señal")
grid on

subplot(2,1,2)            % Posicion 2 en matriz 2x1
plot(t, f_pitch_shifting) % Grafico de señal procesada

title("Señal con cambio de velocidad")
xlabel("Tiempo (s)")
ylabel("Amplitud de la señal")
grid on
%            Agrega titulo al subplot
sgtitle("Señal original y señal con pitch shifting")
%---------------------------------------------------------------




