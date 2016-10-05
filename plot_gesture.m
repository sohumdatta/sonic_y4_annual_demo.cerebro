function [figure_handle] = plot_gesture(gesture_id)
    switch gesture_id
        case 0
            I = imread('img/fist.jpg');
        case 1
            I = imread('img/hand_down.jpg');
        case 2
            I = imread('img/hand_flat.jpg');
        case 3
            I = imread('img/hand_up.jpg');
        case 4
            I = imread('img/pointing.jpg');
        case 5
            I = imread('img/rest.png');
        otherwise
            return
    figure_handle = image(I);
end %function
    
