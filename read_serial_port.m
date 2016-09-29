function [channels] = read_serial_port(buffer)

    nbytes=length(buffer);
    data=zeros(22,1);
    
    ch1=0; ch2=0; ch3=0; ch4=0;
    ch5=0; ch6=0; ch7=0; ch8=0;
	channels = zeros(1,8);
       
    byte1=0; byte2=0; 
    byte3=0; byte4=0; 
    byte5=0; byte6=0;
    byte7=0; byte8=0;
    byte9=0; byte10=0;
    byte11=0; byte12=0;
    byte13=0; byte14=0;
    byte15=0; byte16=0;
    byte17=0; byte18=0;
    byte19=0; byte20=0;
    byte21=0; byte22=0;
    
%
%	nbytes = get(s,'BytesAvailable');
%    %display(nbytes);
%
%%	if nbytes > 0
%    	[buffer, count, warmsg] = fread (s, s.InputBufferSize, 'uint8');
%		if( ~isempty(warmsg))
%			disp(strcat('Warning: fread:', warmsg));
%		end
%		disp(sprintf('INFO: fread: read %d bytes from input buffer.\n', count)); 
%%	end
%
	i = 1;	% pointer to the current byte, where we check the HEADER

	%for i = 1:1:nbytes-22

	% Note: The packet is 22 bytes total including HEADER, FOOTER and CHECKSUM
	% We do not processes the CHECKSUM here. [TODO: This could lead to corrput data processed]
	% Therefore, the iterator i must go to the header of the possible last packet.
	while(i <= nbytes - 21)
        %data = circshift (data, 1);
        %data(1) = buffer(i);
		data = buffer(i : i+21);

        if data(1) == 32 
                byte4=double(data(4));
                byte5=double(typecast(uint8(data(5)),'int8'));
                byte6=double(data(6));
                byte7=double(typecast(uint8(data(7)),'int8'));
                byte8=double(data(8));
                byte9=double(typecast(uint8(data(9)),'int8'));
                byte10=double(data(10));
                byte11=double(typecast(uint8(data(11)),'int8'));
                byte12=double(data(12));
                byte13=double(typecast(uint8(data(13)),'int8'));
                byte14=double(data(14));
                byte15=double(typecast(uint8(data(15)),'int8'));
                byte16=double(data(16));
                byte17=double(typecast(uint8(data(17)),'int8'));
                byte18=double(data(18));
                byte19=double(typecast(uint8(data(19)),'int8'));
                byte20=double(data(20));
                byte21=double(data(21));
    			%disp('got header');

                if byte20==0 && byte21==0
				% setup the channel values if the FOOTER also matches at the correct places
                    ch1=byte4+byte5*256;
                    ch2=byte6+byte7*256;
                    ch3=byte8+byte9*256;
                    ch4=byte10+byte11*256;
                    ch5=byte12+byte13*256;
                    ch6=byte14+byte15*256;
                    ch7=byte16+byte17*256;
                    ch8=byte18+byte19*256;
					currentPack = [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8];
					channels = [channels; currentPack];
    				%disp('got one packet');
                end   %if byte20==0 && byte21==0

				i = i + 22;	% jump directly to the next packet interface
		else 	%if data(1) == 32 
			i = i + 1;	% if HEADER not found bump the pointer
        end %if data(1) == 32  
    end 	%while(i <= nbytes - 22)
%ch1 = c1(1);
%ch2 = c2(1);
%ch3 = c3(1);
%ch4 = c4(1);
%ch5 = c5(1);
%ch6 = c6(1);
%ch7 = c7(1);
%ch8 = c8(1);
%channels = [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8];
channels(1,:) = [];

