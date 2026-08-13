function [hp_front, hp_rear] = excelreader(input,loaded_radius)

    data_front=readmatrix(input,'Range','A3:C18');
    hp_front=struct('LF',zeros(1,3),'LA',zeros(1,3),'LBJ',zeros(1,3),'UF',zeros(1,3),'UA',zeros(1,3),'UBJ',zeros(1,3),'PRO',zeros(1,3),'PRI',zeros(1,3),'TRO',zeros(1,3),'TRI',zeros(1,3),'DC',zeros(1,3),'RD',zeros(1,3),'WSP',zeros(1,3),'WC',zeros(1,3),'RPA1',zeros(1,3),'RPA2',zeros(1,3));
    keys=fieldnames(hp_front);
    for i = 1:numel(keys)
        hp_front.(keys{i})=(data_front(i,:) .* 0.001);
        hp_rear.(keys{j})(3)=(hp_rear.(keys{j})(3)-loaded_radius);
    end

    data_rear=readmatrix(input,'Range','A23:C38');
    hp_rear=struct('LF',zeros(1,3),'LA',zeros(1,3),'LBJ',zeros(1,3),'UF',zeros(1,3),'UA',zeros(1,3),'UBJ',zeros(1,3),'PRO',zeros(1,3),'PRI',zeros(1,3),'TRO',zeros(1,3),'TRI',zeros(1,3),'DC',zeros(1,3),'RD',zeros(1,3),'WSP',zeros(1,3),'WC',zeros(1,3),'RPA1',zeros(1,3),'RPA2',zeros(1,3));
    key=fieldnames(hp_rear);
    for j = 1:numel(key)
        hp_rear.(key{j})=(data_rear(j,:) .* 0.001);
        hp_rear.(key{j})(3)=(hp_rear.(key{j})(3)-loaded_radius);
    end
     
end