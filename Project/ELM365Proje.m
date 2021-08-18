%Hazirlayan: Abdullah MEMISOGLU
%Ogrenci No: 171024001
% ELM365 - MATLAB ODEVI 

% %%Esit Olasýlýklý Bitler Icin:

%Sistem Baslatma
clc;
close all;
clear all;

% Her SNR degeri icin uretilecek bit miktari N = 50.000.000
% * En az 10.000.000 
N=5*10^7;  

% rand("state", N); random sayi üretecini N deðerine gore ayarlamaktadir.
rand("state",100);  

% randn("state", N); random sayi üretecini N deðerine gore ayarlamaktadir.
randn("state",200);  

% N/2 adet x < 0.5, N/2 adet x > 0.5 sayi uretmeyi saglayan yapi.
ip = rand(1,N)>0.5;


% a1 ve a2 kararlarinin olusturuldugu yapi.
% 1 gelirse a1 = 2, 0 gelirse a2 = -4/3
ai=(10/3)*ip-(4/3);  


% Analitik olarak hesaplanan varyans degerinin N0 bagimli yazilisi. 
n=sqrt(5)/sqrt(3)*[randn(1,N)+1i*randn(1,N)]; 


% Analitik olarak hesaplanan gama degerinin yazilisi.  
gama = (1/3);

% Ilgili cizimde x eksenini belirleyen Eb/No oraninin tanimlanmasi
Eb_No_dB=[-4:14];  

for  i=1:length(Eb_No_dB)
  % z = ai + n0 iþleminin yazýlmasi
  % Eb = 1, 10log10(1/N0) = [-4:14] 
  z=ai+10^(-Eb_No_dB(i)/20)*n;
  
  % Karar bolgesi
  ipHat=real(z)>(gama);
  
  
  % Hata hesabi 
  nErr(i)=size(find ([ip-ipHat]),2);
end

% Simulasyon sonucu 
simBError=nErr/N;

% Teorik Sonuc 
% Analitik cikarimlarda elde edilen Pb icin katsayi icermektedir.
TheoricBError=0.5*erfc(sqrt(5)/sqrt(6)*sqrt(10.^(Eb_No_dB/10)));  

% plot
figure
semilogy(Eb_No_dB,TheoricBError, "bo-");
hold on
semilogy(Eb_No_dB,simBError, "rx-");
axis([-4 14 10^-5 0.5]);
grid on
legend("Theoric","Simulation");
xlabel("Eb/ No (dB)");
ylabel(" Bit Error Rate ");
title("Eþit Olasýlýklý Durumun Grafiði");



% % P(0) = 4/5, P(1) = 1/5 için
% 

% Her SNR degeri icin uretilecek bit miktari N = 50.000.000
% * En az 10.000.000 
N2=5*10^7;  
 
% N/2 adet x < 0.5, N/2 adet x > 0.5 sayi uretmeyi saglayan yapi.
ip2 = rand(1,N2)>0.5;


% a1 ve a2 kararlarinin olusturuldugu yapi.
% 1 gelirse a1 = 2, 0 gelirse a2 = -4/3
ai2=(25/6)*ip2-(5/3);  


% Analitik olarak hesaplanan varyans degerinin N0 bagimli yazilisi. 
n2=sqrt(25)/sqrt(12)*[randn(1,N2)+1i*randn(1,N2)]; 

% Ilgili cizimde x eksenini belirleyen Eb/No oraninin tanimlanmasi
Eb_No_dB2 = [-4:14];  

for  i=1:length(Eb_No_dB2)
  % Bu kisimda gama N0 bagimli oldugundan
  % for dongusu icerisinde deger atamasi yapilmistir.
  N02 = 1/(10.^(Eb_No_dB2(i)/10));
  gama2 = (0.6931*N02 + 0.4166);
  
  % z = ai + n0 iþleminin yazýlmasi
  % Eb = 1, 10log10(1/N0) = [-4:14] 
  z2=ai2+10^(-Eb_No_dB2(i)/20)*n2;
  
  % Karar bolgesi
  ipHat2=real(z2)>(gama2);
  
  
  % Hata hesabi 
  nErr2(i)=size(find ([ip2-ipHat2]),2);
end

% Simulasyon sonucu 
simBError2=nErr2/N2;

% Teorik Sonuc 
% Analitik cikarimlarda elde edilen Pb icin katsayi icermektedir.
TheoricBError2=0.5*erfc(sqrt(25)/sqrt(24)*sqrt(10.^(Eb_No_dB2/10)));  

% Esit Olasilkli Olmayan Durum icin Cizdirme Ýslemleri
figure
semilogy(Eb_No_dB2,TheoricBError2, "bo-");
hold on
semilogy(Eb_No_dB2,simBError2, "rx-");
axis([-4 14 10^-5 0.5]);
grid on
legend("Theoric","Simulation");
xlabel("Eb/ No (dB)");
ylabel(" Bit Error Rate ");
title("P(0)=4/5, P(1)=1/5 Durumu Grafiði");

% Iki durumun kiyaslanmasi icin Cizdirme Ýslemleri
figure
semilogy(Eb_No_dB,simBError, "bo-");
hold on
semilogy(Eb_No_dB2,simBError2, "rx-");
axis([-4 14 10^-5 0.5]);
grid on
legend("Eþit Olasýlýklý","P(0)=4/5, P(1)=1/5");
xlabel("Eb/ No (dB)");
ylabel(" Bit Error Rate ");
title("Ýki Durumun Kýyaslanmasý Grafiði");














