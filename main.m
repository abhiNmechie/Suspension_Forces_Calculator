clear; clc; close all;
format long g;
[gen] = generalinputs();
[hp_front,hp_rear]=excelreader("C:\MechX VD\force calculator\Suspension forces calculator\hardpoints.csv",234.80);
[geo]=geometry(hp_front,hp_rear);
[result]=frontknuckle(gen,geo);
disp(result.Front_UWF_brake);
disp(result.Front_LWF_brake);