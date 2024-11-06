fmri_4d_signal = zeros(182, 218, 182, 314);
for frame_idx = 0: 314
    func_name = sprintf('sub-control01_task-music_run_concatenated_std_vol%04d_smoothed-6mm.nii.gz', frame_idx);
    fmri_4d_signal(:, :, :, frame_idx+1) = spm_read_vols(spm_vol(func_name));
end
Hdr3d = spm_vol('sub-control01_task-music_run_concatenated_std_vol0000_smoothed-6mm.nii.gz');
nii4dw(fmri_4d_signal, Hdr3d, 'sub-control01_task-music_run_concatenated_moco_std_smoothed-6mm-MNI152');


function nii4dw(V4d,Hdr,fname)
    % write 4d nii file  
    
    nfrs = size(V4d,4);  
    
    cmd = ['fslmerge -t ',fname]; 
    for ifr = 1:nfrs  
        Hdr.fname = [fname, '_', num2str(ifr, '%04d'), '.nii'];  
        spm_write_vol(Hdr,V4d(:,:,:,ifr));  
        cmd = [cmd, ' ', fname, '_', num2str(ifr, '%04d'), '.nii'];  
    end  
    
    system(cmd);  
    
    for ifr = 1:nfrs  
        delete([fname, '_', num2str(ifr, '%04d'), '.nii*'])  
    end  
end


