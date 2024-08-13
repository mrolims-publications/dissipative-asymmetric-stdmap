PROGRAM MAIN
  IMPLICIT NONE
  REAL*8::K,x0,y0,xn,yn,a,gamma
  INTEGER::i,ii,n,j
  REAL*8, PARAMETER:: pi=4.0*ATAN(1.0)
  INTEGER,PARAMETER:: NFINAL=1E4, NTOTAL=1E4, TRANSIENT=NFINAL-50
  REAL*8, DIMENSION(NTOTAL):: veca,veck
  !--------------------------------------------------------------------
  !--------------------------------------------------------------------
  !Parameters
  DO i=1,4
     IF(i.EQ.1) THEN
        gamma=0.8
        OPEN(1,FILE='Data/Fig7a.dat', STATUS='UNKNOWN')
        OPEN(2,FILE='Data/parameters_gamma_0-80.dat', STATUS='OLD')
     ELSE IF(i.EQ.2) THEN
        gamma=0.85
        OPEN(1,FILE='Data/Fig7b.dat', STATUS='UNKNOWN')
        OPEN(2,FILE='Data/parameters_gamma_0-85.dat', STATUS='OLD')
     ELSE IF(i.EQ.3) THEN
        gamma=0.90
        OPEN(1,FILE='Data/Fig7c.dat', STATUS='UNKNOWN')
        OPEN(2,FILE='Data/parameters_gamma_0-90.dat', STATUS='OLD')
     ELSE IF(i.EQ.4) THEN
        gamma=0.95
        OPEN(1,FILE='Data/Fig7d.dat', STATUS='UNKNOWN')
        OPEN(2,FILE='Data/parameters_gamma_0-95.dat', STATUS='OLD')
     END IF
     ! Initial conditions
     x0=0.0
     y0=0.0
     ! Vector of parameters
     DO ii=1,NTOTAL
        READ(2,*) veca(ii),veck(ii)
     END DO
     ! Bifurcation Diagram
     DO j=1,2
        PARAM: DO ii=0,NTOTAL-1
           IF(j.EQ.1) THEN
              !Direction of increasing K
              K=veck(ii+1)
              a=veca(ii+1)
           ELSE IF(j.EQ.2) THEN
              !Direcion of decreasing K
              K=veck(NTOTAL-ii)
              a=veca(NTOTAL-ii)
           END IF
           ! Iteration
           TIME: DO n=1,NFINAL
              yn=(1.0-gamma)*y0+K*(SIN(x0)+a*SIN(2.0*x0+pi/2.0))
              xn=MOD(x0+yn, 2.0*pi)
              !
              IF(xn.LT.0.0) xn=xn+2.0*pi
              !-----------------------------          
              IF(n.GE.TRANSIENT) WRITE(1,*) K,yn,j,xn
              x0=xn;y0=yn
           END DO TIME
        END DO PARAM
     END DO
     CLOSE (1);CLOSE(2)
  END DO
END PROGRAM MAIN
           
  
