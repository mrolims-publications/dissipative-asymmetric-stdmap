program lyapunov_k_vs_a
    use functions
    implicit none
    ! --- Parameters --- !
    integer, parameter :: t_end = 1e5                   ! Total time of simulation
    integer, parameter :: t_trans = int(5e4)            ! Transient time
    integer, parameter :: sample_size = t_end - t_trans ! Number of samples
    ! --- Variables --- !
    integer :: j, jj                           ! General integers
    integer :: grid                            ! Size of the grid
    real(8) :: k, k_ini, k_end                 ! Parameter k and its bounds
    real(8) :: gamma                           ! Parameter gamma
    real(8) :: a, a_ini, a_end                 ! Parameter a and its bounds
    real(8) :: x, p                            ! State variables
    real(8) :: lypnv                           ! Largest Lyapunov exponent
    character :: path*80, datafile*300, arg*15 ! Strings to format the file name and to get the input arguments

    ! Path to where the data will be stored. Make sure to create
    ! Data/ or modify the variable path accordingly
    path = "Data/"
    ! Get the input arguments
    call getarg(1, arg)
    read(arg, *)gamma
    call getarg(2, arg)
    read(arg, *)k_ini
    call getarg(3, arg)
    read(arg, *)k_end
    call getarg(4, arg)
    read(arg, *)a_ini
    call getarg(5, arg)
    read(arg, *)a_end
    call getarg(6, arg)
    read(arg, *)grid
    ! Name of the file where the data will be stored
    910 format(a, "lyapunov_k_vs_a_gamma=", f0.5, "_k0=", f0.5, "_k1=", f0.5, "_a0=", f0.5, "_a1=", f0.5, "_T=", i0, "_t=", i0, "_grid=", i0, ".dat")
    write(unit=datafile, fmt=910)trim(path), gamma, k_ini, k_end, a_ini, a_end, t_end, t_trans, grid
    ! Print in the screen the information of the simulation
    write(*, "(a, a)")"path = ", trim(path)
    write(*, "(a, a)")"datafile = ", trim(datafile)
    write(*, "(a, f0.5)")"gamma = ", gamma
    write(*, "(a, f0.5)")"k_ini = ", k_ini
    write(*, "(a, f0.5)")"k_end = ", k_end
    write(*, "(a, f0.5)")"a_ini = ", a_ini
    write(*, "(a, f0.5)")"a_end = ", a_end
    write(*, "(a, i0)")"grid = ", grid
    ! Open the file
    open(10, file=trim(datafile))
    ! Calculate the Lyapunov exponent
    do j = 0, grid
        ! Update the parameter k
        k = k_ini + (k_end - k_ini) * j / grid
        !$omp parallel do ordered schedule(dynamic) private(x, p, a, lypnv)
        do jj = 0, grid
            ! Make sure we are using the same initial condition for every (a, k)
            x = 1.78d0
            p = 0.0d0
            ! Update the parameter a
            a = a_ini + (a_end - a_ini) * jj / grid
            ! Calculate the Lyapunov exponent
            call lyapunov(lypnv, x, p, k, a, gamma, t_end, t_trans)
            !$omp ordered
            ! Write on the file
            write(10, "(*(f30.16))")k, a, lypnv
            !$omp end ordered
        end do
        !$omp end parallel do
        ! Add a blank line in order to plot the data in Gnuplot, if it is the case
        write(10, *)""
    end do
    ! Close the file
    close(10)    
end program lyapunov_k_vs_a