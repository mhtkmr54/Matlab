clear all;
clc;

%import the data %



Adverse=importdata('Alum.txt');
 x=Adverse.data(:,1);
 y=Adverse.data(:,2);
 x1=Adverse.data(1:20,1);
 y1=Adverse.data(1:20,2);
 
  %using polyfit function for calculating youngs_modulus%
 
 apol=polyfit(x1,y1,1);
 Youngs_Modulus=apol(1);
 display(Youngs_Modulus)
x4=0.002:0.0001:0.01;
 y2=apol(1)*x4-0.002*apol(1);
 
 i=1; 
while(y(i)>y2(i))
     i=i+1;
 end;
 
 x3=linspace(x(i),x(i-1),100000);
 y3=apol(1)*x3-0.002*apol(1);
 slope=(y(i)-y(i-1))/(x(i)-x(i-1));
 y4=slope*x3-slope*x(i)+y(i);
 j=1;
 while(y4(j)<=y3(j))
     j=j+1;
 end;
 Yield_Strength=y4(j);
 display(Yield_Strength)
  UTS=max(y);
 display(UTS);
  k=1;
   while(y(k)<UTS)
      k=k+1;
  end;
  m=1;
  while(Yield_Strength>=y(m))
      m=m+1;
  end;
   Plastic_strain=Adverse.data(m-1:k,1);
   Stress=Adverse.data(m-1:k,2);
   true_strain=log((Plastic_strain)+1);
   true_stress=Stress.*(Plastic_strain+1);
   q=log(true_strain);
   p=log(true_stress);
   t=polyfit(q,p,1);
   K=exp(t(2));
   strain_exponent=t(1);
   display(K)
   display(strain_exponent)
 hold on;
 plot(x,y,'r*');  
 plot(x4,y2,'b:');
 plot(x1,y1,'g*');
 plot(true_strain,true_stress,'y','LineWidth',3);
 axis('square');
 xlabel('Strain (\epsilon ) ','Fontsize',16);
ylabel('Stress (\sigma), MPa', 'Fontsize',16);
title('Engineering Stress Strain curve', 'Fontsize',14);
Ductility=x(length(x));
display(Ductility)

  