!-------------------------------------------------------------------------------
! Copyright (c) 2019 FrontISTR Commons
! This software is released under the MIT License, see LICENSE.txt
!-------------------------------------------------------------------------------

module m_child_matrix

  use hecmw_util
  use m_irjc_matrix

  type child_matrix

    integer(kind=kint) :: ndeg    ! same for A and C
    integer(kind=kint) :: ista_c  ! begining index of row of C
    integer(kind=kint) :: neqns_t ! total number of equations.

    ! A region
    type(irjc_square_matrix) :: a

    ! C region
    type(irjc_mn_matrix) :: c

  end type child_matrix
end module m_child_matrix
