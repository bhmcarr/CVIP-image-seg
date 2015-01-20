function [idx] = segmentImg(I, k)
% function idx = segmentImage(img)
% Returns the logical image containing the segment ids obtained from 
%   segmenting the input image
%
% INPUTS
% I - The input image contining textured foreground objects to be segmented
%     out.
% k - The number of segments to compute (also the k-means parameter).
%
% OUTPUTS
% idx - The logical image (same dimensions as the input image) contining 
%       the segment ids after segmentation. The maximum value of idx is k.
%          

    % 1. Create your bank of filters using the given alogrithm; 
    % 2. Compute the filter responses by convolving your input image with  
    %     each of the num_filters in the bank of filters F.
    %     responses(:,:,i)=conv2(I,F(:,:,i),'same')
    %     NOTE: we suggest to use 'same' instead of 'full' or 'valid'.
    % 3. Remember to take the absolute value of the filter responses (no
    %     negative values should be used).
    % 4. Construct a matrix X of the points to be clustered, where 
    %     the rows of X = the total number of pixels in I (rows*cols); and
    %     the columns of X = num_filters;
    %     i.e. each pixel is transformed into a num_filters-dimensional
    %     vector.
    % 5. Run kmeans to cluster the pixel features into k clusters,
    %     returning a vector IDX of labels.
    % 6. Reshape IDX into an image with same dimensionality as I and return
    %     the reshaped index image.
    %
    I = double(rgb2gray(I)); I = I(:,:,1);
    F=makeLMfilters;
    [~,~,num_filters] = size(F);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        m = size(I, 1);
        n = size(I, 2);
        
        % Compute filter responses
        responses = zeros(m,n,num_filters);
        
        % convolve filter bank with image and store results
        for i=1:48
           responses(:,:,i)=conv2(I,F(:,:,i),'same');
        end
        
        % get rid of negative values
        responses = abs(responses);
        
        % create X
        m = size(I, 1);
        n = size(I, 2);
        num_pixels = m*n;
        X = zeros(num_pixels,num_filters);
        
        counter = 1;
        
        % for every pixel in responses
        for i=1:m
           for j=1:n
               % form a 48 dimensional vector
               res_vec = responses(i,j,:);
               X(counter,:) = res_vec;
               counter = counter+1;
           end
        end
        
        % k-means clustering
        idx = KMeansClustering(X, k);
        
        % reshape idx into an index image
        temp_idx = zeros(m,n);
        counter = 1;
        
        for i=1:m
           for j=1:n
               temp_idx(i,j) = idx(counter,1);
               counter = counter+1;
           end
        end
        
        idx = temp_idx;

     
% everything below here was supposed to be used to determine the foreground
% vector automatically. It ALMOST works.. but there are enough kinks in it
% that I don't want to hassle the graders with it. Also, it's kind of a
% mess.


    %% 
%     width = size(idx,2);
%     height = size(idx,1);
% 
%     countvec = zeros(k,1);
%     border1 = idx(1,1:width); %top
%     border2 = idx(2:height,1); %left
%     border3 = idx(2:height-1,width); %right
%     border4 = idx(height,2:width); %bottom
% 
%     count_inc = zeros(k,1);
%     %% 
%     
%     %%
%     
%     for i=1:k
%         count_inc(i,1) = 1;
%         %check top and bottom borders for i
%         for j=1:width-1
%             if border1(1,j) == i
%                 %increment counter vec
%                 countvec(i,1) = countvec(i,1) + count_inc(i,1);
%             end
% 
%             if border4(1,j) == i
%                 %increment counter vec
%                 countvec(i,1) = countvec(i,1) + count_inc(i,1);
%             end
%         end
% 
%         %check left and right borders for i
%         for j=1:height-2
%             if border2(j,1) == i
%                 countvec(i,1) = countvec(i,1) + count_inc(i,1);
%             end
% 
%             if border3(j,1) == i
%                 countvec(i,1) = countvec(i,1) + count_inc(i,1);
%             end
%         end
%         count_inc(i,1) = 0;
%    end
    %% 
    

    % determine which element of countvec is the highest, then construct a new vector without it

    %% 
%     fg_vec = zeros(k-1,1); %size k-1 - only removing one segment
% 
%     vec_max = max(countvec);
%     
%     fg_vec = find(countvec < vec_max);

    %reconstruct the vector skipping the max
%     counter = 1;
%     fg_counter = 1;
%     while fg_vec(k-1,1) == 0
%         if(countvec(counter,1) ~= vec_max)
%             fg_vec(fg_counter,1) = countvec(counter,1);
%             fg_counter = fg_counter+1;
%         end
%         counter = counter+1;
%     end
    %% 

    

        
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
