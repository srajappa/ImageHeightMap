function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals


%% <<< fill in your code below >>>
%Creating Zeros of important variables
surface_normals = zeros(192,168,3);
G=zeros(3,1);
%------------------------------------

for i = 1:size(imarray,1)
    for j = 1:size(imarray,2)
        % Creating a 64 X 1 array for intensity for all images in image
        % stack for the pixel (i,j)-----------------BEGIN
        I=imarray(i,j,:);
        Ir = reshape(I,[64,1]);
        %-------------------------------------------END
        %Performing mldvide (Courtesy: Radhakrishna Dasari) in order to
        %retrieve the G matrix.---------------------BEGIN
        G= light_dirs\Ir;
        %-------------------------------------------END
        %Performing operations to get the absolute value of G at that point
        %to obtain the albedo_image intensity information.------BEGIN
        albedo_image(i,j) = norm(G);
        %-------------------------------------------END
        %Computing the surface normals info---------BEGIN
        surface_normals(i,j,1) = G(1,1)/norm(G);
        surface_normals(i,j,2) = G(2,1)/norm(G);
        surface_normals(i,j,3) = G(3,1)/norm(G);
        %Computing the surface normals info---------END;
    end
end
end

