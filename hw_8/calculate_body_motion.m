function x_dot = calculate_body_motion(t,x,m,G)
% CALCULATE_BODY_MOTION takes time, state, and parameters for an N-body
% system and returns state derivative.
%   input arguments:
%       -x = state at time t: N 3D positions and velocities (6Nx1)
%       -m = masses of the bodies (Nx1)
%       -G = Newtonian constant of gravitation (scalar)
%   output arguments:
%       -x_dot = state derivative at time t: N velocities and accels (6Nx1)


x_dot = zeros(size(x));

% x is a vector that contains the position and velocity of N particles in
% the N reference frame.
% Want to use force of gravity equation to solve for the acceleration of
% the N particles.
% The acceleration of the N particles are strictly caused by the
% gravitational forces of the particles on each other in this problem.
% For each particle, the force the particle feels from each other particle
% = -G*m_current_particle*m_other_particle/distance_between_particles_cubed
% *position_vector_from_other_particle_to_current_particle
numberOfParticles = length(m);

forceMatrix = zeros(numberOfParticles);
% For each particle, need to calculate the forces from the other particles
% Once the force on particle A by B is calculated, don't want to
% recalculate the force on particle B by A. We know the magnitude is the
% same, just the direction is the opposite, so we can form an NxN matrix
% where the the i,j entry is the force on particle i by j.
for particleI = 1:numberOfParticles
    % Get the mass of particle I for later force calculation
    particleIMass = mass(particleI);
    
    % Get the position and velocity of particle I
    
    for particleJ = (particleI+1):numberOfParticles
        % Get the position and velocity of particle J
        
        % Calculate the position vector from J to I
        
        % Calculate the magnitude of the position vector
        
        % Calculate the force of from J on I
        
        % Put the force in the force matrix in the i,j index (expecting 3x1
        % matrix in each index)
    end
end

% The jth column = - ith row because the force of gravity has the same
% magnitude but opposite direction
% For loop through the number of particles
% Set column j = -row i
% Calculate the sum of row i to find the net force on particle I (note that
% each index is a vector and the net force should return a 3x1 vector)
% Take the force that was calculated and divide by the mass of particle I to
% get the 3x1 acceleration vector of particle I
% Take the velocity of particle I from x, append the acceleration vector,
% and put the velocity-acceleraiton vector in x_dot

end
