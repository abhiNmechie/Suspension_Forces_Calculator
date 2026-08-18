function [result] = frontknuckle(gen, geo)
    
    %braking forces:
    geo.wheelbase=((geo.wheelbase)/1000);
    gen.h=((gen.h)/1000);
    result.Fw=(gen.Mf)*((gen.g)/2);
    result.delta_F=(gen.M)*(gen.deacc)*((gen.h)/(2*(geo.wheelbase)));
    result.total_front_load=((result.Fw)+(result.delta_F));
    result.friction=(gen.mu)*(result.total_front_load);
    result.Tb=(result.friction)*(gen.loaded_radius/1000);
    result.F_UWF_brake=(-1)*((result.friction)*(gen.loaded_radius-geo.upphubsep_front)/(geo.upphubsep_front+geo.lowhubsep_front));
    result.F_LWF_brake=(result.F_UWF_brake-result.friction);