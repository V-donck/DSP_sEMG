function [Normalised_data] = MVC(Data,Measurement)
% read files
[header1, MVC_trapezius_links] = ReadFile(append("PP01/",Measurement ,"_MVC_trapezius_links.txt"));
[header2, MVC_trapezius_rechts] = ReadFile('PP01/'+Measurement + '_MVC_trapezius_rechts.txt');
[header3, MVC_delt_links] = ReadFile('PP01/'+Measurement + '_MVC_delt_links.txt');
[header4, MVC_delt_rechts] = ReadFile('PP01/'+Measurement + '_MVC_delt_rechts.txt');
[header5, MVC_ECR_rechts] = ReadFile('PP01/'+Measurement + '_MVC_ECR_rechts.txt');

%take right colum
MVC_trapezius_links=abs(MVC_trapezius_links(:,1));
MVC_trapezius_rechts=MVC_trapezius_rechts(:,2);
MVC_delt_links=MVC_delt_links(:,3);
MVC_delt_rechts=MVC_delt_rechts(:,4);
MVC_ECR_rechts=MVC_ECR_rechts(:,5);

%transform to mV + abs value
MVC_trapezius_links=abs(transformTo_mV(MVC_trapezius_links,header1.resolution));
MVC_trapezius_rechts=abs(transformTo_mV(MVC_trapezius_rechts,header2.resolution));
MVC_delt_links=abs(transformTo_mV(MVC_delt_links,header3.resolution));
MVC_delt_rechts=abs(transformTo_mV(MVC_delt_rechts, header4.resolution));
MVC_ECR_rechts=abs(transformTo_mV(MVC_ECR_rechts, header5.resolution));

%take maximum value
MVC_trapezius_links=max(MVC_trapezius_links);
MVC_trapezius_rechts=max(MVC_trapezius_rechts);
MVC_delt_links=max(MVC_delt_links);
MVC_delt_rechts=max(MVC_delt_rechts);
MVC_ECR_rechts=max(MVC_ECR_rechts);


%Normalise data
Normalised_data(:,1)=Data(:,1)/MVC_trapezius_links;
Normalised_data(:,2)=Data(:,2)/MVC_trapezius_rechts;
Normalised_data(:,3)=Data(:,3)/MVC_delt_links;
Normalised_data(:,4)=Data(:,4)/MVC_delt_rechts;
Normalised_data(:,5)=Data(:,5)/MVC_ECR_rechts;

end

