!>
!! @file p_main.f90
!! @brief Contains program p_main

!> @brief This program takes care of setting up the initial condition and
!!              grid data for the multicomponent flow code.
program p_main

    use m_global_parameters     !< Global parameters for the code

    use m_start_up

    use m_nvtx

    implicit none

    integer :: i
    logical :: file_exists
    real(wp) :: start, finish, time_avg, time_final
    real(wp), allocatable, dimension(:) :: proc_time

    call random_seed()

    call nvtxStartRange("INIT_MPI")
    call s_initialize_mpi_domain()
    call nvtxEndRange

    ! Initialization of the MPI environment
    call nvtxStartRange("INIT_MPI")
    call s_initialize_modules()
    call nvtxEndRange

    call nvtxStartRange("READ_GRID")
    call s_read_grid()
    call nvtxEndRange

    allocate (proc_time(0:num_procs - 1))

    call nvtxStartRange("APPLY_INIT")
    call s_apply_initial_condition(start, finish, proc_time, time_avg, time_final, file_exists)
    call nvtxEndRange

    time_avg = abs(finish - start)
    call nvtxStartRange("SAVE_DATA")
    call s_save_data(proc_time, time_avg, time_final, file_exists)
    call nvtxEndRange

    deallocate (proc_time)
    call nvtxStartRange("FINAL_MODULE")
    call s_finalize_modules()
    call nvtxEndRange

end program p_main
