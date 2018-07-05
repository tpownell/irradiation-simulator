
y = 0:10; % establising a reasonable range of values for the initial concentrations
x = 0:20; % this range is large but possibly not reasonable

bch_Al = 0.8022.*y - 7.4959; % these equations are derived from the data trends located in file [RIS_Data]
ach_Cr = -0.36.*x + 6.85; % that file is accessible in the NanoHub project titled [Irradiation Segregation Simulator]

subplot(1,2,1)
plot (y, bch_Al); 
xlim([4 8])
ylim([-6 0])

xlabel ("Initial Grain Boundary Concentration");
ylabel ("RIS");
title ("Aluminum RIS vs. Initial Aluminum");

subplot(1,2,2)
plot (x, ach_Cr); 
xlim([9 15])
ylim([0 6])

xlabel ("Initial Grain Boundary Concentration");
ylabel ("RIS");
title ("Chromium RIS vs. Initial Chromium");

disp('These lines are restricted to the prediction ranges that have been determined to be valid.')

% x is the initial concentration in integer values of rounded weight percentage for the sake of argument
disp('These charts should help you visualize the relationships that have been derived for direct variance of RIS values by weight percentage changes.');

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

firstCrRIS_Cr = ach_Cr;
firstAlRIS_Cr = ach_Al;
firstFeRIS_Cr = ach_Fe;

firstCrRIS_Al = bch_Cr;
firstAlRIS_Al = bch_Al;
firstFeRIS_Al = bch_Fe; % storing results for later comparison to other prediction

x = -10:0.1:10;

ya = (Cr + ((1)./((x.^2)+(1./((ach_Cr).^2).^(1/2))))); % these equations are what drives the graphs

za = (Al - ((1)./((x.^2)+(1./((ach_Al).^2).^(1/2))))); % note that the RIS variable has to be squared and then square rooted to 
 
va = (Fe + ((1)./((x.^2)+(1./((ach_Fe).^2).^(1/2))))); % get the absolute value. Otherwise the denominator will hit zero

yb = (Cr + ((1)./((x.^2)+(1./((bch_Cr).^2).^(1/2))))); % I have accounted for the negative values by simply changing the

zb = (Al - ((1)./((x.^2)+(1./((bch_Al).^2).^(1/2))))); % sign of the operator which dictates RIS for aluminum. (See the - after AL)

vb = (Fe + ((1)./((x.^2)+(1./((bch_Fe).^2).^(1/2)))));

%plot (x, ya, x, za, x, va, x, yb, x, zb, x, vb);

subplot(2,1,1)
plot (x, yb, x, zb, x, vb);
xlabel ("Displacement from Grain Boundary [nm]");
ylabel ("Weight %");
title ("RIS predicted by Initial Aluminum");

subplot(2,1,2)
plot (x, ya, x, za, x, va);
xlabel ("Displacement from Grain Boundary [nm]");
ylabel ("Weight %");
title ("RIS predicted by Initial Chromium");

fprintf('\nBased on Chromium input the simulation estimates...\n RIS for Chromium: %f\n RIS for Aluminum: %f\n RIS for Iron: %f\n', ach_Cr, ach_Al, ach_Fe); 

fprintf('\nBased on Aluminum input the simulation estimates...\n RIS for Chromium: %f\n RIS for Aluminum: %f\n RIS for Iron: %f\n', bch_Cr, bch_Al, bch_Fe); 

disp('These charts give you a visual representation of the predictions derived from our data.')


% Now I am applying polynomial predictive equations

ach_Cr = -0.0527*Cr^2 + 0.8508*Cr; 
ach_Al = -0.04*Cr - 1.65;  % these final two are identical to the first graphs
ach_Fe = 0.707*Cr - 8.98; 

bch_Cr = 0.4791*Al^2 - 6.7155*Al + 25.197;   
bch_Al = 0.2023*Al^2 - 1.6796*Al - 0.0179;  % this and the following are derived from data sets obtained over an Al wt % of 5, 6, and 7.
bch_Fe = 0.1608*Al^2 - 1.7558*Al + 4.9625; 

x = -10:0.1:10;
secondCrRIS_Cr = ach_Cr;
secondAlRIS_Cr = ach_Al;
secondFeRIS_Cr = ach_Fe;

secondCrRIS_Al = bch_Cr;
secondAlRIS_Al = bch_Al;
secondFeRIS_Al = bch_Fe; % storing results for later comparison

ya = (Cr + ((1)./((x.^2)+(1./((ach_Cr).^2).^(1/2))))); % these equations are what drives the graphs

za = (Al - ((1)./((x.^2)+(1./((ach_Al).^2).^(1/2))))); % note that the RIS variable has to be squared and then square rooted to 
 
va = (Fe + ((1)./((x.^2)+(1./((ach_Fe).^2).^(1/2))))); % get the absolute value. Otherwise the denominator will hit zero

yb = (Cr + ((1)./((x.^2)+(1./((bch_Cr).^2).^(1/2))))); % I have accounted for the negative values by simply changing the

zb = (Al - ((1)./((x.^2)+(1./((bch_Al).^2).^(1/2))))); % sign of the operator which dictates RIS for aluminum. (See the - after AL)

vb = (Fe + ((1)./((x.^2)+(1./((bch_Fe).^2).^(1/2)))));

%plot (x, ya, x, za, x, va, x, yb, x, zb, x, vb);

subplot(2,1,1)
plot (x, yb, x, zb, x, vb);
xlabel ("Displacement from Grain Boundary [nm]");
ylabel ("Weight %");
title ("RIS predicted by Initial Aluminum");

subplot(2,1,2)
plot (x, ya, x, za, x, va);
xlabel ("Displacement from Grain Boundary [nm]");
ylabel ("Weight %");
title ("RIS predicted by Initial Chromium");

fprintf('\nBased on Chromium input the simulation estimates...\n RIS for Chromium: %f\n RIS for Aluminum: %f\n RIS for Iron: %f\n', ach_Cr, ach_Al, ach_Fe); 

fprintf('\nBased on Aluminum input the simulation estimates...\n RIS for Chromium: %f\n RIS for Aluminum: %f\n RIS for Iron: %f\n', bch_Cr, bch_Al, bch_Fe); 

disp('These charts give you a visual representation of the predictions derived from our data.')

subplot(1,2,1)
CrdepRIS = [firstFeRIS_Cr secondFeRIS_Cr; firstAlRIS_Cr secondAlRIS_Cr; firstCrRIS_Cr secondCrRIS_Cr];
bar(CrdepRIS)

ylabel ("Change in Weight %");
title ("RIS predicted by Initial Chromium");


subplot(1,2,2)
AldepRIS = [firstFeRIS_Al secondFeRIS_Al; firstAlRIS_Al secondAlRIS_Al; firstCrRIS_Al secondCrRIS_Al];
bar(AldepRIS)

ylabel ("Change in Weight %");
title ("RIS predicted by Initial Aluminum");
