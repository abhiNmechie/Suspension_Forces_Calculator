function [result] = frontknuckle(gen, geo)
    
    %braking forces:
    geo.wheelbase=((geo.wheelbase)/1000);
    gen.h=((gen.h)/1000);
    result.Fw=(gen.Mf)*((gen.g)/2);
    result.delta_F=(gen.M)*(gen.deacc)*((gen.h)/(2*(geo.wheelbase)));
    result.total_front_load=((result.Fw)+(result.delta_F));
    result.friction=(gen.mu)*(result.total_front_load);
    result.Front_LWF_brake=(((result.friction)*(gen.loaded_radius-geo.upphubsep_front))/(geo.upphubsep_front+geo.lowhubsep_front));
    result.Front_UWF_brake=(result.friction+result.Front_LWF_brake);