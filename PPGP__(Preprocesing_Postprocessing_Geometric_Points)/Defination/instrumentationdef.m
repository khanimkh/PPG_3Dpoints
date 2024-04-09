function instrum=instrumentationdef

% This specify some external knowledge about the DVD data. The
% instrumented levels and the position of the apical vertebrae.
%
% By: Xavier Glorot July 2008
% xavier.glorot@cpe.fr
                                                                                                                                                                                                                                                                                                                                                                                                                               % last apex not good (TTL) % last apex not good (TTL)                                                                                                                                                 % last apex not good (TTL)                                                                                                                              % last apex not good (TTL)                        
names=  [ {'1457368'}           {'1644329'}          {'1650495'}          {'1667499'}           {'1683214'}          {'1709222'}          {'1711617'}           {'1718455'}           {'1736375'}           {'1744419'}           {'1792684'}           {'1793421'}           {'1802958'}          {'1808213'}           {'1867728'}           {'1876417'}          {'1901531'}           {'1910794'}           {'1980660'}           {'2053405'}          {'2060925'}           {'2080728'}           {'2080729'}          {'2107738'}           {'2201262'}            {'2203892'}           {'2207843'}          {'2213982'}           {'2229793'}           {'2235370'}           {'2235394'}           {'2242130'}           {'2248562'}           {'2248916'}          {'2253762'}          {'2255015'}           {'2256421'}           {'1260257'}           {'1292955'}           {'1331204'}           {'1331550'}           {'1390754'}           {'1446694'}           {'1466948'}           {'1547556'}           {'1631377'}          {'1657168'}           {'1667370'}           {'1732817'}           {'1736753'}           {'1780481'}           {'1788759'}           {'1803425'}           {'1828665'}           {'1853817'}           {'1900667'}           {'1910616'}           {'1911690'}           {'1946602'}            {'1975407'}           {'2082033'}           {'2090163'}            {'2106126'}           {'2132932'}           {'2138529'}           {'2138603'}           {'2158293'}           {'2160986'}           {'2164465'}];
niveaux=[ 1:24<=22 & 1:24>=10 ; 1:24<=20 & 1:24>=9 ; 1:24<=19 & 1:24>=9 ; 1:24<=20 & 1:24>=10 ; 1:24<=20 & 1:24>=9 ; 1:24<=23 & 1:24>=9 ; 1:24<=22 & 1:24>=10 ; 1:24<=20 & 1:24>=10 ; 1:24<=19 & 1:24>=10 ; 1:24<=19 & 1:24>=11 ; 1:24<=23 & 1:24>=9 ;  1:24<=20 & 1:24>=11 ; 1:24<=21 & 1:24>=9 ; 1:24<=22 & 1:24>=11 ; 1:24<=19 & 1:24>=10 ; 1:24<=21 & 1:24>=9 ; 1:24<=20 & 1:24>=10 ; 1:24<=19 & 1:24>=10 ; 1:24<=20 & 1:24>=10 ; 1:24<=21 & 1:24>=8 ; 1:24<=20 & 1:24>=10 ; 1:24<=22 & 1:24>=9 ;  1:24<=22 & 1:24>=9 ; 1:24<=19 & 1:24>=10 ; 1:24<=22 & 1:24>=10 ;  1:24<=22 & 1:24>=9 ;  1:24<=21 & 1:24>=9 ; 1:24<=20 & 1:24>=11 ; 1:24<=21 & 1:24>=10 ; 1:24<=23 & 1:24>=10 ; 1:24<=20 & 1:24>=10 ; 1:24<=21 & 1:24>=11 ; 1:24<=23 & 1:24>=10 ; 1:24<=19 & 1:24>=9 ; 1:24<=21 & 1:24>=9 ; 1:24<=22 & 1:24>=13 ; 1:24<=19 & 1:24>=11 ; 1:24<=20 & 1:24>=11 ; 1:24<=23 & 1:24>=14 ; 1:24<=20 & 1:24>=12 ; 1:24<=21 & 1:24>=10 ; 1:24<=22 & 1:24>=11 ; 1:24<=23 & 1:24>=13 ; 1:24<=23 & 1:24>=13 ; 1:24<=20 & 1:24>=10 ; 1:24<=21 & 1:24>=9 ; 1:24<=24 & 1:24>=11 ; 1:24<=23 & 1:24>=12 ; 1:24<=23 & 1:24>=12 ; 1:24<=22 & 1:24>=12 ; 1:24<=23 & 1:24>=10 ; 1:24<=24 & 1:24>=11 ; 1:24<=21 & 1:24>=11 ; 1:24<=21 & 1:24>=11 ; 1:24<=21 & 1:24>=11 ; 1:24<=22 & 1:24>=11 ; 1:24<=22 & 1:24>=15 ; 1:24<=23 & 1:24>=14 ; 1:24<=23 & 1:24>=11 ;  1:24<=22 & 1:24>=12 ; 1:24<=23 & 1:24>=12 ; 1:24<=22 & 1:24>=16 ;  1:24<=22 & 1:24>=12 ; 1:24<=20 & 1:24>=11 ; 1:24<=20 & 1:24>=12 ; 1:24<=23 & 1:24>=11 ; 1:24<=22 & 1:24>=12 ; 1:24<=23 & 1:24>=13 ; 1:24<=20 & 1:24>=12];
apex=   [ {'10 15 20'}          {'9 15 21'}          {'9 14 20'}          {'10 16 21'}          {'10 15 21'}         {'10 15 20'}         {'11 18 23'}          {'10 16 21'}          {'10 16 21'}          {'11 16 21'}          {'9 15 21'}           {'11 16 21'}          {'12 18 22'}         {'10 16 21'}          {'10 15 21'}          {'10 16 22'}         {'10 16 21'}          {'10 15 20'}          {'10 16 22'}          {'12 18 23'}         {'18 22'}             {'15 21'}             {'15 21'}            {'10 16 21'}          {'10 16 21'}           {'22'}                {'12 18 22'}         {'10 16 21'}          {'11 17 22'}          {'15 20'}             {'11 16 21'}          {'9 15 21'}           {'11 15 21'}          {'10 15 21'}         {'10 17 22'}         {'12 19 23'}          {'10 15 20'}          {'10 15 21'}          {'10 15 20'}          {'10 16 22'}          {'10 16 22'}          {'11 16 21'}          {'11 16 20'}          {'10 16 21'}          {'11 17 22'}          {'13 19 23'}         {'10 15 21'}          {'14 19 23'}          {'10 15 20'}          {'10 16 22'}          {''}                 {'14 20'}             {'10 16 22'}          {'10 16 22'}          {'11 17 22'}          {'11 16 21'}          {'14 20'}             {'11 15 20'}          {'10 15 21'}           {'12 18 22'}          {'13 19 23'}          {'15 20'}              {'12 19 23'}          {'9 15 21'}           {'10 16 21'}          {'10 15 21'}          {'10 15 20'}          {'14 21'}             {'10 16 22'}];

    
for j=1:length(names)
    instrum(j).name=cell2mat(names(j));
    instrum(j).niv=niveaux(j,:);
    
    % apex
    apextemp=str2num(cell2mat(apex(j))); %#ok<ST2NM>
    if length(apextemp)>2
        apextemp=apextemp(end-1:end);
    end
    apexvect=25*ones(1,24);
    apexvect(apextemp)=0;
    while ~isempty(find(apexvect==25,1)) && ~isempty(apextemp)
        apexsave=apexvect;
        for i=1:length(apexvect)
            if apexvect(i)==25 && ( (i<24 && apexvect(i+1)~=25) || (i>1 && apexvect(i-1)~=25) )
                if i<24 && i>1
                    if apexvect(i+1)~=25 && apexvect(i-1)~=25
                        apexsave(i)=min(apexvect(i+1)-1,apexvect(i-1)+1);
                    else
                        if apexvect(i+1)~=25
                            apexsave(i)=apexvect(i+1)-1;
                        end
                        if apexvect(i-1)~=25
                            apexsave(i)=apexvect(i-1)+1;
                        end
                    end
                else
                    if i==24
                        if apexvect(i-1)~=25
                            apexsave(i)=apexvect(i-1)+1;
                        end
                    end
                    if i==1
                        if apexvect(i+1)~=25
                            apexsave(i)=apexvect(i+1)-1;
                        end
                    end
                end
            end
        end
        apexvect=apexsave;
    end
    instrum(j).apex=apexvect;
end

% for j=1:length(names)
%     disp(instrum(j).name)
%     disp(1:24)
%     disp(instrum(j).niv)
%     disp(instrum(j).apex)
% end