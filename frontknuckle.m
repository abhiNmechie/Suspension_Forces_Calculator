function [result] = frontknuckle (gen, geo)
    
    L=(geo.wheelbase/1000);
    h=(gen.h/1000);
    a=(geo.upphubsep_front/1000);
    b=(geo.lowhubsep_front/1000);
    r=(gen.loaded_radius/1000);

    %braking
    result.static_frontload=(gen.Mf)*((gen.g)/2);
    result.front_WT_brake=((gen.M)*(gen.deacc)*(h))/(2*L);
    result.front_total_brake=(result.static_frontload+result.front_WT_brake);
    result.friction_front_brake=((gen.mu)*(result.front_total_brake));

    result.UWF_brake=((result.friction_front_brake*b-result.friction_front_brake*r)/(a+b));
    result.LWF_brake=(result.friction_front_brake-result.UWF_brake);
end
