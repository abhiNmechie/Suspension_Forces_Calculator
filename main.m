clear; clc; close all;
format long g;
[gen] = generalinputs();
[hp_front,hp_rear]=excelreader("C:\MechX VD\force calculator\hardpoints.csv",234.80);
[geo]=geometry(hp_front,hp_rear);
[result]=frontknuckle(gen,geo);
disp(result.F_UWF_brake);
disp(result.F_LWF_brake);