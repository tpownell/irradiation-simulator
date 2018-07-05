
%%This notebook is the rough draft for my Nano-hub tool that will simulate the Radiation Induced Segregation of Fe-Cr-Al
%alloys at a static temperature of 364 degrees C and a dpa of 1.8-1.9.

do

Cr = input("Enter the concentration of Chromium: ")

if ( Cr>=20 || Cr<=0 )
% I will display a warning to the user if they fail to meet the criterion
disp('This percentage must be between 0 and 20.')
endif

until ( Cr<20 && Cr>0 )
% this ensures that the concentration is valid
% Once we have a valid value for chromium we ask for aluminum

do

Al = input("Enter the concentration of Aluminium: ")

if ( Al>=20 || Al<=0 )
% displaying warning as in the chromium loop
disp('This percentage must be between 0 and 20.')
endif

until ( Al<20 && Al>0 )

% now we have two valid concentrations

Fe = 100.000 - Cr - Al;

ach_Cr = -0.36*Cr + 6.85; 
ach_Al = -0.04*Cr - 1.65;  % this and the following are derived from data sets obtained over a Cr wt % of 10 and 13.
ach_Fe = 0.707*Cr - 8.98; 

bch_Cr = -0.97*Al + 8.27;   
bch_Al = 0.8022*Al - 7.4959;  % this and the following are derived from data sets obtained over an Al wt % of 5, 6, and 7.
bch_Fe = 0.1736*Al - 0.7165; 

x = -10:0.1:10;

ya = (Cr + ((1)./((x.^2)+(1./((ach_Cr).^2).^(1/2))))); % these equations are what drives the graphs

za = (Al - ((1)./((x.^2)+(1./((ach_Al).^2).^(1/2))))); % note that the RIS variable has to be squared and then square rooted to 
 
va = (Fe + ((1)./((x.^2)+(1./((ach_Fe).^2).^(1/2))))); % get the absolute value. Otherwise the denominator will hit zero

yb = (Cr + ((1)./((x.^2)+(1./((bch_Cr).^2).^(1/2))))); % I have accounted for the negative values by simply changing the

zb = (Al - ((1)./((x.^2)+(1./((bch_Al).^2).^(1/2))))); % sign of the operator which dictates RIS for aluminum. (See the - after AL)

vb = (Fe + ((1)./((x.^2)+(1./((bch_Fe).^2).^(1/2)))));

%plot (x, ya, x, za, x, va, x, yb, x, zb, x, vb);
plot (x, yb, x, zb, x, vb);
xlabel ("Displacement from Grain Boundary [nm]");
ylabel ("Weight %");
title ("RIS in Fe-Cr-Al");


fprintf('\nBased on Chromium input the simulation estimates...\n RIS for Chromium: %f\n RIS for Aluminum: %f\n RIS for Iron: %f\n', ach_Cr, ach_Al, ach_Fe); 

fprintf('\nBased on Aluminum input the simulation estimates...\n RIS for Chromium: %f\n RIS for Aluminum: %f\n RIS for Iron: %f\n', bch_Cr, bch_Al, bch_Fe); 


x = 0:20;

bch_Al = 0.8022.*x - 7.4959;
ach_Cr = -0.36.*x + 6.85;

subplot(1,2,1)
plot (x, bch_Al); 
xlim([0 20])
ylim([-10 10])

xlabel ("Initial Grain Boundary Concentration");
ylabel ("RIS");
title ("Aluminum RIS vs. Initial Aluminum");

subplot(1,2,2)
plot (x, ach_Cr); 
xlim([0 20])
ylim([-2.5 7.5])

xlabel ("Initial Grain Boundary Concentration");
ylabel ("RIS");
title ("Chromium RIS vs. Initial Chromium");

disp('Please note that these trend lines depict large RIS values even when the initial concentration is zero.')

% x is the initial concentration in integer values of rounded weight percentage for the sake of argument


% We need to derive an equation for the Ris values of an element based on inputs of Al and Cr concentrations.

Cr = 1:20;
Al = 1:20;
Fe = 100 -(Cr + Al);

Cr = Cr(:);
Al = Al(:);

ach_Cr = -0.36*Cr + 6.85; % this and the following are derived from data sets obtained over an Al wt % of 5, 6, and 7.
ach_Al = (-0.04*Al - 1.65); 
ach_Fe = 0.707*Fe - 8.98; 

bch_Cr = -0.97*Cr + 8.27;    % this and the following are derived from data sets obtained over a Cr wt % of 10 and 13.
bch_Al = (.8022*Al - 7.4959); 
bch_Fe = 0.1736*Fe - 0.7165; 
%{

Al = Cr = 1:20;
[xx, yy] = meshgrid (Al, Cr);
z = sqrt ((.8022*Al - 7.4959) + (-0.04*Al - 1.65)) + eps;

mesh (Al, Cr, z);
%}
Al = Cr = 1:20;
[xx, yy] = meshgrid (Al, Cr);

ach_Cr = 0.36*xx + 6.85;
bch_Cr = 0.97*yy + 8.27;

z = (ach_Cr + bch_Cr);
mesh (Al, Cr, z);

ach_Al = (.8022*xx - 7.4959);
bch_Al = (-0.04*yy - 1.65); 

z = (ach_Al + bch_Al);
mesh (Al, Cr, z);


ach_Al = -0.04*Al - 1.65; 

y = -15:15;
x = -15:15;

x = x(:);

b = (Cr - ((1)./((x.^2)+(1./((ach_Al).^2).^(1/2)))));


z = meshgrid(b,x);


figure
surf(y, x, z)
colormap winter
