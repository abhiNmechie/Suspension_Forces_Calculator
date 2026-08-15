function [geo] = geometry(hp_front, hp_rear)

    geo.wheelbase=(hp_rear.WC(1)-hp_front.WC(1));
    geo.trackwidth_front=(2*(hp_front.WC(2)));
    geo.trackwidth_rear=(2*(hp_rear.WC(2)));
    
    %dist of front ubj, lbj from ground 
    geo.h1_front=((hp_front.UBJ(3)));
    geo.h2_front=((hp_front.LBJ(3)));
    geo.sep_front=(geo.h1_front-geo.h2_front);
    
    %dist of rear ubj, lbj from ground 
    geo.h1_rear=((hp_rear.UBJ(3)));
    geo.h2_rear=((hp_rear.LBJ(3)));
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

    geo.kpi_front=atan2d(-geo.kp_front(2),geo.kp_front(3));
    geo.kpi_rear=atan2d(-geo.kp_rear(2),geo.kp_rear(3));

    %caster

    geo.caster_front=atan2d(-geo.kp_front(1),geo.kp_front(3));
    geo.caster_rear=atan2d(-geo.kp_rear(1),geo.kp_rear(3));

    %scrub radius
    %front

    c_front_sc=((hp_front.LBJ(2:3)-hp_front.UBJ(2:3))/norm(hp_front.LBJ(2:3)-hp_front.UBJ(2:3)));
    alpha_front=((-hp_front.LBJ(3))/(c_front_sc(2)));
    intercept_scrub1=((hp_front.LBJ(2))+alpha_front*(c_front_sc(1)));
    geo.scrub_front=(hp_front.WC(2)-(intercept_scrub1));
    
    %rear
    c_rear_sc=((hp_rear.LBJ(2:3)-hp_rear.UBJ(2:3))/norm(hp_rear.LBJ(2:3)-hp_rear.UBJ(2:3)));
    alpha_rear=((-hp_rear.LBJ(3))/(c_rear_sc(2)));
    intercept_scrub2=((hp_rear.LBJ(2))+alpha_rear*(c_rear_sc(1)));
    geo.scrub_rear=(hp_rear.WC(2)-(intercept_scrub2));

    %mechanical trail

    %front
    c_front_tr=((hp_front.LBJ([1 3])-hp_front.UBJ([1 3]))/norm(hp_front.LBJ([1 3])-hp_front.UBJ([1 3])));
    beta_front=((-hp_front.LBJ(3))/(c_front_tr(2)));
    intercept_trail1=((hp_front.LBJ(1))+beta_front*(c_front_tr(1)));
    geo.trail_front=(hp_front.WC(1)-(intercept_trail1));

    %rear
    c_rear_tr=((hp_rear.LBJ([1 3])-hp_rear.UBJ([1 3]))/norm(hp_rear.LBJ([1 3])-hp_rear.UBJ([1 3])));
    beta_rear=((-hp_rear.LBJ(3))/(c_rear_tr(2)));
    intercept_trail2=((hp_rear.LBJ(1))+beta_rear*(c_rear_tr(1)));
    geo.trail_rear=(hp_rear.WC(1)-(intercept_trail2));

    %steering axis:

    %front
    
    tierod_front=(hp_front.TRI-hp_front.TRO)/norm(hp_front.TRI-hp_front.TRO);
    kp_front=(hp_front.UBJ-hp_front.LBJ)/norm(hp_front.UBJ-hp_front.LBJ);
    geo.t_front=norm(dot(cross((hp_front.TRO-hp_front.LBJ),tierod_front),kp_front));

    %rear

    tierod_rear=(hp_rear.TRI-hp_rear.TRO)/norm(hp_rear.TRI-hp_rear.TRO);
    kp_rear=(hp_rear.UBJ-hp_rear.LBJ)/norm(hp_rear.UBJ-hp_rear.LBJ);
    geo.t_rear=norm(dot(cross((hp_rear.TRO-hp_rear.LBJ),tierod_rear),kp_rear));

    %A arms lengths

    %front
    geo.fore_upper_front=norm(hp_front.UBJ-hp_front.UF);
    geo.aft_upper_front=norm(hp_front.UBJ-hp_front.UA);
    geo.fore_lower_front=norm(hp_front.LBJ-hp_front.LF);
    geo.aft_lower_front=norm(hp_front.LBJ-hp_front.LA);
    
    %rear
    geo.fore_upper_rear=norm(hp_rear.UBJ-hp_rear.UF);
    geo.aft_upper_rear=norm(hp_rear.UBJ-hp_rear.UA);
    geo.fore_lower_rear=norm(hp_rear.LBJ-hp_rear.LF);
    geo.aft_lower_rear=norm(hp_rear.LBJ-hp_rear.LA);

    %A arm lever arms + pushrod levers:
    %front:
    axis_front_lower=(hp_front.LF-hp_front.LA)/norm(hp_front.LF-hp_front.LA);
    axis_front_upper=(hp_front.UF-hp_front.UA)/norm(hp_front.UF-hp_front.UA);

    v1=(hp_front.UBJ-hp_front.UF);
    v2=(hp_front.LBJ-hp_front.LF);
    
    w1=(hp_front.PRO-hp_front.LF);

    geo.Aarm_lever_front_upper=norm(v1-dot(v1,axis_front_upper)*axis_front_upper);
    geo.Aarm_lever_front_lower=norm(v2-dot(v2,axis_front_lower)*axis_front_lower);
    geo.pushrod_lever_front=norm((w1-dot(w1,axis_front_lower)*axis_front_lower));

    %rear
    axis_rear_lower=(hp_rear.LF-hp_rear.LA)/norm(hp_rear.LF-hp_rear.LA);
    axis_rear_upper=(hp_rear.UF-hp_rear.UA)/norm(hp_rear.UF-hp_rear.UA);

    v3=(hp_rear.UBJ-hp_rear.UF);
    v4=(hp_rear.LBJ-hp_rear.LF);

    w2=(hp_rear.PRO-hp_rear.UF);

    geo.Aarm_lever_rear_upper=norm(v3-dot(v3,axis_rear_upper)*axis_rear_upper);
    geo.Aarm_lever_rear_lower=norm(v4-dot(v4,axis_rear_lower)*axis_rear_lower);
    geo.pushrod_lever_rear=norm((w2-dot(w2,axis_rear_upper)*axis_rear_upper));

    %%
    %rocker geometry: 

    %rocker-chassis pivot axis
    %front
    geo.rocker_axis_front=(hp_front.RPA1-hp_front.RPA2)/norm(hp_front.RPA1-hp_front.RPA2);
    %rear:
    geo.rocker_axis_rear=(hp_rear.RPA1-hp_rear.RPA2)/norm(hp_rear.RPA1-hp_rear.RPA2);
    
    %arm vectors+arm lever: rpa1 and pri:
    %front
    geo.arm_pri_front=(hp_front.PRI-hp_front.RPA1);
    geo.armlever_pri_front=(geo.arm_pri_front-dot(geo.arm_pri_front,geo.rocker_axis_front)*geo.rocker_axis_front);

    %rear
    geo.arm_pri_rear=(hp_rear.PRI-hp_rear.RPA1);
    geo.armlever_pri_rear=(geo.arm_pri_rear-dot(geo.arm_pri_rear,geo.rocker_axis_rear)*geo.rocker_axis_rear);

    %arm vectors: rpa1 and rd:
    %front
    geo.arm_rd_front=(hp_front.RD-hp_front.RPA1);
    geo.armlever_rd_front=(geo.arm_rd_front-dot(geo.arm_rd_front,geo.rocker_axis_front)*geo.rocker_axis_front);

    %rear
    geo.arm_rd_rear=(hp_rear.RD-hp_rear.RPA1);
    geo.armlever_rd_rear=(geo.arm_rd_rear-dot(geo.arm_rd_rear,geo.rocker_axis_rear)*geo.rocker_axis_rear);
    
    %rocker-pushrod force directions:
    %front:
    geo.force_direc_rocker_pushrod_front=(hp_front.PRO-hp_front.PRI)/norm(hp_front.PRO-hp_front.PRI);
    %rear:
    geo.force_direc_rocker_pushrod_rear=(hp_rear.PRO-hp_rear.PRI)/norm(hp_rear.PRO-hp_rear.PRI);

    %rocker-damper force directions:
    %front:
    geo.force_direc_rocker_damper_front=(hp_front.RD-hp_front.DC)/norm(hp_front.RD-hp_front.DC);
    %rear:
    geo.force_direc_rocker_damper_rear=(hp_rear.RD-hp_rear.DC)/norm(hp_rear.RD-hp_rear.DC);

    %moment arms, pr and rocker:
    %front
    geo.momentarms_rocker_pr_front=abs(dot(cross(geo.armlever_pri_front,geo.force_direc_rocker_pushrod_front),geo.rocker_axis_front));
    %rear:
    geo.momentarms_rocker_pr_rear=abs(dot(cross(geo.armlever_pri_rear,geo.force_direc_rocker_pushrod_rear),geo.rocker_axis_rear));

    %moment arms, rocker and damper:
    %front
    geo.momentarms_rocker_damper_front=abs(dot(cross(geo.armlever_rd_front,geo.force_direc_rocker_damper_front),geo.rocker_axis_front));
    %rear
    geo.momentarms_rocker_damper_rear=abs(dot(cross(geo.armlever_rd_rear,geo.force_direc_rocker_damper_rear),geo.rocker_axis_rear));
    %%
    %pushrod and damper directions:
    geo.front_pushrod_length=norm(hp_front.PRI-hp_front.PRO);
    v_front=(hp_front.PRI-hp_front.PRO)/norm(hp_front.PRI-hp_front.PRO);
    geo.front_pushrod_angle=acosd(abs(v_front(3)));

    geo.rear_pushrod_length=norm(hp_rear.PRI-hp_rear.PRO);
    v_rear=(hp_rear.PRI-hp_rear.PRO)/norm(hp_rear.PRI-hp_rear.PRO);
    geo.rear_pushrod_angle=acosd(abs(v_rear(3)));

    geo.front_damper_length=norm(hp_front.RD-hp_front.DC);
    w_front=(hp_front.RD-hp_front.DC)/norm(hp_front.RD-hp_front.DC);
    geo.front_damper_angle=acosd(abs(w_front(3)));

    geo.rear_damper_length=norm(hp_rear.RD-hp_rear.DC);
    w_rear=(hp_rear.RD-hp_rear.DC)/norm(hp_rear.RD-hp_rear.DC);
    geo.rear_damper_angle=acosd(abs(w_rear(3)));

