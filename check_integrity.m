% check_integrity.m: check if the processed stream data and batch data are within an error always
function status = check_integrity(rawData, streamFilteredData)
	if(~isequal(size(rawData), size(streamFilteredData)))
		error('check_integrity: rawData and streamFilteredData must have same size');
	end
	num_channels = size(rawData, 2);
	disp('Preprocessing raw data in batch mode....');
	for i = 1:num_channels
		ybatch(:,i) = preprocessing_batch(rawData(:,i));
	end
	disp('Done');
	ystream = streamFilteredData;

	tolerance = 1e-10
	status = true;
	for i = 1:num_channels
		diff = abs(ybatch(:,i) - ystream(:,i));
		if(~all(diff < tolerance))
			disp(sprintf('Channel %d integrity check failed, max error %d',...
				 i, max(diff)));
			status = false;
		end
	end %for

	if(status)
		disp('PASSED integrity of stream filtering');
	else
		disp('FAILED integrity of stream filtering');
	end		
end %check_integrity
