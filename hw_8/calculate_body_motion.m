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

% Create a force matrix, need 3x the rows because each particle force has
% three components
forceMatrix = zeros(3, numberOfParticles);

% For each particle, need to calculate the forces from the other particles
% Once the force on particle A by B is calculated, don't want to
% recalculate the force on particle B by A. We know the magnitude is the
% same, just the direction is the opposite, so we can form an NxN matrix
% where the the i,j entry is the force on particle i by j.
for particleI = 1:numberOfParticles
    % Get the mass of particle I for later force calculation
    particleIMass = m(particleI);
    
    % Get the position of particle I; multiply by 6 because each particle
    % has 6 indices in x to describe all components in position and
    % velocity
    particleIStartingIndex = (particleI - 1) * 6 + 1;
    v_and_r_I_On = x(particleIStartingIndex:particleIStartingIndex + 5);
    r_I_On = v_and_r_I_On(1:3);
    
    for particleJ = 1:numberOfParticles
        if particleI == particleJ
            % the gravitational force of a particle on itself is always 0
            continue
        end

        % Get the position of particle J
        particleJStartingIndex = (particleJ - 1) * 6 + 1;
        r_J_On = x(particleJStartingIndex:particleJStartingIndex + 2);
        
        % Calculate the position vector from J to I
        % r_I_J = r_I_On + r_On_J
        r_I_J = r_I_On - r_J_On;
        
        % Calculate the distance between I and J
        particleSeparation = sqrt(sum(r_I_J.^2));
        
        % Calculate the force of from J on I
        F_I_J = -G*particleIMass*m(particleJ)/particleSeparation^3*r_I_J;
        
        % Put the force in the force matrix using 3 rows, and the j'th
        % column index 
        forceMatrix(:, particleJ) = F_I_J;
    end
    
    % Calculate the sum of row i to find the net force on particle I (note
    % that the net force should return a 3x1 vector)
    netForceOnI = [sum(forceMatrix(1, :)), sum(forceMatrix(2, :)), ...
        sum(forceMatrix(3, :))];
    
    % Take the force that was calculated and divide by the mass of particle I to
    % get the 3x1 acceleration vector of particle I
    particleIAcceleration = netForceOnI/particleIMass;
    
    % Take the velocity of particle I from x, append the acceleration vector,
    % and put the velocity-acceleration vector in x_dot
    v_I_On = v_and_r_I_On(4:end);

    x_dot(particleIStartingIndex:particleIStartingIndex + 5) = [v_I_On, particleIAcceleration'];
end

end