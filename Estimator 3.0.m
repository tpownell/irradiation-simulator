
y = 0:10; % establising a reasonable range of values for the initial concentrations
x = 0:20; % this range is large but possibly not reasonable

bch_Al = 0.8022.*y - 7.4959; % these equations are derived from the data trends located in file [RIS_Data]
ach_Cr = -0.36.*x + 6.85; % that file is accessible in the NanoHub project titled [Irradiation Segregation Simulator]

subplot(1,2,1)
plot (y, bch_Al); 
xlim([4 8]) % Dr Janelle Wharry and Timothy Pownell (Undergrad code author) determined these as reasonable ranges
ylim([-6 0])

xlabel ("Initial Grain Boundary Concentration");
ylabel ("RIS");
title ("Aluminum RIS vs. Initial Aluminum");

subplot(1,2,2)
plot (x, ach_Cr); 
xlim([9 15]) % Dr Janelle Wharry and Timothy Pownell (Undergrad code author) determined these as reasonable ranges
ylim([0 6]) % We based this conclusion on the data trends seen in linear fitted lines along the data points.
            % Please see the Powerpoint presentation on this subject for more info. It is located in project files

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

if ( Cr>=14 || Cr<=9 )
% I will display a warning to the user if they fail to meet the criterion
disp('This percentage must be between 0 and 20.')
endif

until ( Cr<=14& Cr>=9)
% this ensures that the concentration is valid
% Once we have a valid value for chromium we ask for aluminum

do

Al = input("Enter the concentration of Aluminium: ")

if ( Al>=8|| Al<=4 )
% displaying warning as in the chromium loop
disp('This percentage must be between 0 and 20.')
endif

until ( Al<=8 && Al>=4)

% now we have two valid concentrations

Fe = 100.000 - Cr - Al;

ach_Cr = -0.36*Cr + 6.85; 
ach_Al = -0.04*Cr - 1.65;  % this and the following are derived from data sets obtained over a Cr wt % of 10 and 13.

ach_Fe = 100 - (Fe + Al + ach_Al + Cr + ach_Cr); % The Iron RIS must make the sum equal to 100

bch_Cr = -0.97*Al + 8.27;   
bch_Al = 0.8022*Al - 7.4959;  % this and the following are derived from data sets obtained over an Al wt % of 5, 6, and 7.

bch_Fe = 100 - (Fe + Al + bch_Al + Cr + bch_Cr);

A = bch_Fe + Fe + (Al + bch_Al + Cr + bch_Cr);

if (A != 100)
% this is just a check to make sure our RIS values are actually legitimate. Altered concentrations must still sum to 100
disp('The calculated RIS values are not valid. Here is the graph.')
endif

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


Aluminum = 4:0.5:8;
Chromium = linspace(9,14,numel(Aluminum));


%___________DATA________________%
% Creating a plot of possible Aluminum RIS values
%
Sample_Point1 = [6 13 -2.18]; 

Sample_Point2 = [6 10 -2.06];

Sample_Point3 = [7 13 -2.12];

% Data has been taken from the excel sheet containing the generalized trend data
%
%_______________________________%

Vector1 = Sample_Point3 - Sample_Point1; 
% This vector is defined by subtracting point 1 from point 3 to get distance between

Vector2 = Sample_Point2 - Sample_Point1;
% This vector is defined by subtracting point 1 from point 2 to get distance between

Normal = cross(Vector1,Vector2)
% The cross product of two vectors gives an orthogonal vector to both

AL_RIS = Sample_Point1(1, 3) + (Normal(1, 1).*(Chromium - Sample_Point1(1, 1)) + Normal(1, 2).*(Aluminum(:) - Sample_Point1(1, 2))) ./ Normal(1, 3);

% I have used the concepts of Calc 2 to define a plane that includes all three of our sample points. Due to the linear nature of our data trends, this is valid.

%___________DATA________________%
% Creating a plot of possible Chromium RIS values
%
Sample_Point1 = [6 13 2.15]; 

Sample_Point2 = [6 10 3.24];

Sample_Point3 = [7 13 1.67];

% Data has been taken from the excel sheet containing the generalized trend data
%
%_______________________________%

Vector1 = Sample_Point3 - Sample_Point1; 
% This vector is defined by subtracting point 1 from point 3 to get distance between

Vector2 = Sample_Point2 - Sample_Point1;
% This vector is defined by subtracting point 1 from point 2 to get distance between

Normal = cross(Vector1,Vector2)
% The cross product of two vectors gives an orthogonal vector to both

CR_RIS = Sample_Point1(1, 3) + (Normal(1, 1).*(Chromium - Sample_Point1(1, 1)) + Normal(1, 2).*(Aluminum(:) - Sample_Point1(1, 2))) ./ Normal(1, 3);

% I have used the concepts of Calc 2 to define a plane that includes all three of our sample points. Due to the linear nature of our data trends, this is valid.


surf(Chromium, Aluminum(:), CR_RIS) % Plot the surface
colormap winter
xlabel ("Chromium Wt %");
ylabel ("Aluminum Wt %");
zlabel ("Chromium RIS");
title ("RIS of Chromium Based on Both Inputs");


surf(Chromium, Aluminum(:), AL_RIS) % Plot the surface
colormap autumn 
xlabel ("Chromium Wt %");
ylabel ("Aluminum Wt %");
zlabel ("Aluminum RIS");
title ("RIS of Aluminum Based on Both Inputs");
