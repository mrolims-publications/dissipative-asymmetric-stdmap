PROGRAM STABILITY
  IMPLICIT NONE
  REAL*8::x0,y0,xn,yn,a,gamma,K
  REAL*8:: x1,y1,x2,y2
  INTEGER::i,j,ii,n,NP
  REAL*8, PARAMETER:: pi=4.0*ATAN(1.0),THS=1E-3
  INTEGER, PARAMETER:: NFINAL=1E3, NMAX=5E2
  !------------------------------------------------------------------------------
  OPEN(1,FILE='Data/FixedPoints.dat', STATUS='OLD')
  OPEN(2,FILE='Data/BasinStability.dat', STATUS='UNKNOWN') 
  !------------------------------------------------------------------------------
  gamma=0.8
  DO ii=1,44
     READ(1,*) a,K,x1,y1,x2,y2
     IF(x1.EQ.0.0.AND.y1.EQ.0.0) THEN
        NP=0
     ELSE IF(x1.EQ.1.0.AND.y1.EQ.1.0) THEN
        NP=NMAX**2
     ELSE
        NP=0
        CIx: DO i=1,NMAX
           CIy: DO j=1,NMAX
              x0=2.0*pi*i/(1.0*NMAX)
              y0=200.0*j/(1.0*NMAX)
           !
              TIME: DO n=1,NFINAL
                 yn=(1.0-gamma)*y0+K*(SIN(x0)+a*SIN(2.0*x0+pi/2.0))
                 xn=MOD(x0+yn, 2.0*pi)
                 !
                 IF(xn.LT.0.0) xn=xn+2.0*pi
                 IF(ABS(xn-x1).LT.THS.AND.ABS(yn-y1).LT.THS) THEN
                    NP=NP+1 
                    EXIT
                 ELSE IF(ABS(xn-x2).LT.THS.AND.ABS(yn-y2).LT.THS) THEN
                    NP=NP+1
                    EXIT
                 END IF
                 x0=xn;y0=yn
              END DO TIME
           END DO CIy
        END DO CIx
     END IF
     WRITE(2,*) a,K,NP/(1.0*NMAX*NMAX),1.0-NP/(1.0*NMAX*NMAX)
  END DO
END PROGRAM STABILITY
