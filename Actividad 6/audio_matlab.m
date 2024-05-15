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


%--------------------(pitch shifting)---------------------------------
factor_vel = 0.8; % Factor de velocidad
                               % Interpolar la funcion: 
f_pitch_shifting = interp1(t, f, t * factor_vel);
% Reajuste del largo de la señal respecto a su pitch
f_pitch_shifting = f_pitch_shifting(1:length(f));
%---------------------------------------------------------------------

%---------------------- Efecto de Delay -------------------------------
delay_gain = 0.5; % Factor de amplitud de el efecto delay
delay_time = 0.2;    % Valor del delay en segundos(s)

delay = [zeros(round(delay_time*fs),1); f];% Crear la parte que se repetira en el tiempo
delay = delay(1:length(f)).*delay_gain;    % Ajustar la longitud y aplicar el factor de atenuación
f_con_delay = f + delay;                   % Funcion delay
%-----------------------------------------------------------------------

%-------------------Efecto de cambio de amplitud(AM)----------------------------

f_mod_am = 2;          % Frecuencia de la modulación (Hz)
amplitud_mod = 0.5; % Amplitud de la modulación (-)

% Se crea el vector que contiene a la señal modulada
mod_am = amplitud_mod*sin(2*pi*f_mod_am*t);
% Se obtiene la señal modulada
f_mod_am = bsxfun(@times, f, (1 + mod_am'));% Este comando sirve
                                                        % para aplicar la
                                                        % funcion sin
                                                        % utilizar un
                                                        % vector muy pesado
%------------------------------------------------------------------------------



%---------------------Grafico de señal con pitch shifting----------------------
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
%-----------------------------------------------------------------------------

%---------------------Grafico de señal con delay-------------------------------
figure
subplot(2,1,1)
plot(t, f)
grid on
title("Señal original")
xlabel("Tiempo (s)")
ylabel("Amplitud de la señal")

subplot(2,1,2)
plot(t, f_con_delay)
grid on
title("Señal con delay")
xlabel("Tiempo (s)")
ylabel("Amplitud de la señal")
sgtitle("Señal original y señal con delay")
%-------------------------------------------------------------------------------

%----------------------Grafico de señal con modulacion am-----------------------
figure
subplot(2,1,1)
plot(t, f)
title("Señal original")
xlabel("Tiempo (s)")
ylabel("Amplitud de la señal")
grid on

subplot(2,1,2)
plot(t, f_mod_am)
title("Señal con modulación de amplitud")
xlabel("Tiempo (s)")
ylabel("Amplitud de la señal")
grid on

sgtitle("Señal original y señal con modulación de amplitud")
%-------------------------------------------------------------------------------