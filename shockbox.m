%% Enter the path to the excel file here:
filename = 'timestamps.xlsx';
% The first column should be the timestamp (s), and the second column should be duration (s).
t = readtable(filename,'UseExcel',false);


%% Alternitivedly, enter the {time, duration} pairs here:
% t = {
%     1, .2
%     2, .2
%     3, 1
%     5, 1
%     10, 3
%     200, 1
%     };


%% Connect to the serial port
instrreset
ports = seriallist;
s = serial(ports(end),'BaudRate',9600)
fopen(s)


%% Print a preview of the times and durations
clc
fprintf(1,'\nFILE: %s\n\n',filename)
fprintf(1,'    *******************************************\n')
fprintf(1,'******** |Time (s) | Shock Duration (s)  | ********\n')
fprintf(1,'******** |---------|---------------------| ********\n')
for i = 1:size(t,1)
fprintf(1,'******** |%8.1f | %-5.3f               | ********\n',t{i,1},t{i,2})
end
fprintf(1,'    *******************************************\n')


%% Wait for the user to press enter, and begin
input(['\n\n\n',...
    '************************************************************************\n',...
    '----------------------Press control-c to cancel-------------------------\n',...
    '----------------------Press enter to start the program------------------\n'],'s');
fprintf(1,'\b************************************************************************\n\n\n\n')
fprintf(1,'RUNNING...\n\n')
fprintf(1,'     |Time (s) | Shock Duration (s)  |\n')
fprintf(1,'     |---------|---------------------|\n')


%% Send the duration in milliseconds to the arduino
beginTime = tic;
for i = 1:size(t,1)
    pause(t{i,1} - toc(beginTime))
    fprintf(s,num2str(t{i,2} * 1000,'%.0f'))
    fprintf(1,'     |%8.1f | %-5.3f               |\n',toc(beginTime),t{i,2})
end
fprintf(1,'     |---------|---------------------|\n')


fprintf(1,'\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n')
fprintf(1,'!!!!!!!!!!!!!!!!!!               FINISHED               !!!!!!!!!!!!!!!!!!\n')
fprintf(1,'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n')


fclose(s)
delete(s)
clear s
