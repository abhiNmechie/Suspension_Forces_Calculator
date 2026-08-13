function [geo] = geometry(hp_front, hp_rear, gen)
    geo.wheelbase=(hp_rear.WC(1)-hp_front.WC(1));

    geo.trackwidth_front=(2*(hp_front.WC(2)));
    geo.trackwidth_rear=(2*(hp_rear.WC(1)));
    
    %dist of front ubj, lbj from ground 
    geo.h1_front=((hp_front.UBJ));
    geo.h2_front=((hp_front.LBJ));
    geo.sep_front=(geo.h1_front-geo.h2_front);
    
    %dist of rear ubj, lbj from ground 
    geo.h1_rear=((hp_rear.UBJ));
    geo.h2_rear=((hp_rear.LBJ));
    geo.sep_rear=(geo.h1_rear-geo.h2_rear);

    %force upper, lower split ratio:

    geo.uppratio_front=((geo.h2_front)/(geo.h1_front-geo.h2_front));
    geo.lowratio_front=((geo.h1_front)/(geo.h1_front-geo.h2_front));

    geo.uppratio_rear=((geo.h2_rear)/(geo.h1_rear-geo.h2_rear));
    geo.lowratio_rear=((geo.h1_rear)/(geo.h1_rear-geo.h2_rear));
    
    %dist of WC from ubj and lbj for front/rear: note ts doesn't match with
    %report, it uses a=b=110.9mm while direct derivation from lotus
    %geometry is different

    geo.upphubsep_front=(hp_front.UBJ(3)-hp_front.WC(3));
    geo.lowhubsep_front=(hp_front.WC(3)-hp_front.LBJ(3));

    geo.upphubsep_rear=(hp_rear.UBJ(3)-hp_rear.WC(3));
    geo.lowhubsep_rear=(hp_rear.WC(3)-hp_rear.LBJ(3));

    %kingpin axis front/rear

    geo.kp_front=((hp_front.UBJ-hp_front.LBJ)/norm(hp_front.UBJ-hp_front.LBJ));
    geo.kp_rear=((hp_rear.UBJ-hp_rear.LBJ)/norm(hp_rear.UBJ-hp_rear.LBJ));

    %kpi

    geo.kpi_front=atan2d(geo.kp_front(3),-geo.kp_front(2));
    geo.kpi_rear=atan2d(geo.kp_rear(3),-geo.kp_rear(2));