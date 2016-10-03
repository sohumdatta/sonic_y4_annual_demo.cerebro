
function Ngram = computeNgram (buffer, CiM, D, N, percision, iM)
    %init
    ch1HV = zeros (1,D);
	ch2HV = zeros (1,D);
	ch3HV = zeros (1,D);
	ch4HV = zeros (1,D);
	record = zeros (1,D);
	Ngram = zeros (1,D);
	
	ch1HV = lookupItemMemeory (CiM, buffer(1, 1), D, percision);
	ch2HV = lookupItemMemeory (CiM, buffer(1, 2), D, percision);
	ch3HV = lookupItemMemeory (CiM, buffer(1, 3), D, percision);
	ch4HV = lookupItemMemeory (CiM, buffer(1, 4), D, percision);
	ch1HV = ch1HV .* iM(1);
	ch2HV = ch2HV .* iM(2);
	ch3HV = ch3HV .* iM(3);
	ch4HV = ch4HV .* iM(4);
	Ngram = ch1HV + ch2HV + ch3HV + ch4HV;
	
	for i = 2:1:N
		ch1HV = lookupItemMemeory (CiM, buffer(i, 1), D, percision);
		ch2HV = lookupItemMemeory (CiM, buffer(i, 2), D, percision);
		ch3HV = lookupItemMemeory (CiM, buffer(i, 3), D, percision);
		ch4HV = lookupItemMemeory (CiM, buffer(i, 4), D, percision);
		ch1HV = ch1HV .* iM(1);
		ch2HV = ch2HV .* iM(2);
		ch3HV = ch3HV .* iM(3);
		ch4HV = ch4HV .* iM(4);
		record = ch1HV + ch2HV + ch3HV + ch4HV;
		Ngram = circshift (Ngram, [1,1]) .* record;
	end
end

