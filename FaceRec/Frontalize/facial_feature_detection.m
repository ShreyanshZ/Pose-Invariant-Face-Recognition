
switch detector
    case 'ZhuRamanan'   
        load model3DZhuRamanan Model3D 
        addpath(genpath('ZhuRamanan'))
        load('ZhuRamanan/face_p146_small.mat','model');
        model.interval = 5;
        model.thresh = min(-0.65, model.thresh);
        if length(model.components)==13 
            posemap = 90:-15:-90;
        elseif length(model.components)==18
            posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
        else
            error('Can not recognize this model');
        end
        
        I_Q_bs = detect(I_Q, model, model.thresh);
        I_Q_bs = clipboxes(I_Q, I_Q_bs);
        I_Q_bs = nms_face(I_Q_bs,0.3);

        if (isempty(I_Q_bs))
            return;
        end
        
        x1 = I_Q_bs(1).xy(:,1);
        y1 = I_Q_bs(1).xy(:,2);
        x2 = I_Q_bs(1).xy(:,3);
        y2 = I_Q_bs(1).xy(:,4);
        fidu_XY = [(x1+x2)/2,(y1+y2)/2];
        
        
        [sss,n] = size(fidu_XY);
        if sss < 68 
            %
            flipped = fidu_XY(11:39,:);
%             flipped = [(flipped(:,1)-10),flipped(:,(2:end))];
%           flipped = ones(68-sss,2);
%             flipped =flipped(1:end-10, :)

           fidu_XY = cat(1,fidu_XY,flipped);
%            fidu_XY(sss+1:68) = flipped(needed:end);
            
        end
        
end
    
    
    