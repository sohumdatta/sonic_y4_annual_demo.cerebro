% visualizeAM.m: sampling and plotting routine for high-dimensional spaces, by Miles

function proj_vects = visualizeAM( langAM )
	L_keys = langAM.keys;
	num_vects = length(L_keys);
	dim = length(langAM(L_keys{1}));
	L_vects = zeros(num_vects,dim);

	for i=1:num_vects
   		L_vects(i,:) = langAM(L_keys{i});
    	L_vects(i,:) = L_vects(i,:)/norm(L_vects(i,:));
	end

	figure(1)
	%replace L_vects' with prediction vector to see distances between a single
	%prediction and the AM
	imagesc(L_vects*L_vects') 
	colorbar

	% proj_vects = tsne(L_vects,[],2,num_vects)
	%generate random basis
	basis = zeros(2,dim);
	for i = 1:2
	%     basis(i,:) = 2*randi([0,1],1,dim)-1;
    	basis(i,:) = randi([0,1],1,dim);
	end
	proj_vects = (basis*L_vects')'

	size = 200; %determines the size of plotted points
	figure(2)
	hold on
	for i=1:num_vects
		scatter(proj_vects(i,1),proj_vects(i,2), size)
	end
	
	a = [1:num_vects]'; b = num2str(a); c = cellstr(b);
	dx = 0;% size/3; 
	dy = 0;%-size/3; % displacement so the text does not overlay the data points
	text(proj_vects(:,1)+dx, proj_vects(:,2)+dy, c);
	% legend('1','2','3','4','5')
	hold off
end
