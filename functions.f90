module functions
    implicit none
    
    contains

    subroutine lyapunov(lypnv, x0, y0, k, a, gamma, t_end, t_trans)
        implicit none
        real(8), intent(in) :: x0, y0
        real(8), intent(in) :: k
        real(8), intent(in) :: a
        real(8), intent(in) :: gamma
        integer, intent(in) :: t_end, t_trans
        real(8), intent(out) :: lypnv
        real(8), parameter :: pi = dacos(-1.0d0)
        integer :: j
        real(8) :: x, y
        real(8) :: beta, beta0
        real(8) :: J11, J12, J21, J22
        real(8) :: T11

        ! Initial conditions
        x = x0
        y = y0
        ! Initial angle of the rotation matrix
        beta0 = 0
        ! Initialize the sum variable
        lypnv = 0
        do j = 1, t_trans
            ! Iterate the map
            y = (1 - gamma)*y + k*(dsin(x) + a*dsin(2*x + pi/2))
            x = modulo(x + y, 2*pi)
        end do
        do j = 1, int(t_end - t_trans)
            ! Iterate the map
            y = (1 - gamma)*y + k*(dsin(x) + a*dsin(2*x + pi/2))
            x = modulo(x + y, 2*pi)
            ! Jacobian
            J11 = 1.0d0 + k*(dcos(x) + 2*a*dcos(2*x + pi/2))
            J12 = 1.0d0 - gamma
            J21 = k*(dcos(x) + 2*a*dcos(2*x + pi/2))
            J22 = 1.0d0 - gamma
            ! New angle that rotates the Jacobian
            beta = datan((-J21*dcos(beta0) + J22*dsin(beta0))/(J11*dcos(beta0) - J12*dsin(beta0)))
            ! Eigenvalue of the upper triangular matrix
            T11 = dcos(beta0)*(J11*dcos(beta) - J21*dsin(beta)) - dsin(beta0)*(J12*dcos(beta) - J22*dsin(beta))
            ! Add to the sum variable
            lypnv = lypnv + dlog(dabs(T11))/dlog(2.0d0)
            ! Update the rotation angle
            beta0 = beta
        end do

        lypnv = lypnv/(t_end - t_trans)

    end subroutine lyapunov

end module functions