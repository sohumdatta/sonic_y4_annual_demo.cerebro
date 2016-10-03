% cosAngle.m: returns cosine angle between two vectors
function cosAngle = cosAngle (u, v)
    cosAngle = dot(u,v)/(norm(u)*norm(v));
end


