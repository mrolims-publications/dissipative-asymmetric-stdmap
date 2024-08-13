PROGRAM BASINS
  IMPLICIT NONE
  REAL*8::x00,y00,x0,y0,xn,yn,a,K,lambda
  REAL*8:: theta0,theta,somap,somaq,J11,J12,J21,J22,p,q
  REAL*8:: x1,y1,x2,y2,x3,y3
  INTEGER::i,j,n,ii
  REAL*8, PARAMETER:: pi=4.0*ATAN(1.0),THS=1E-3,gamma=0.8
  INTEGER, PARAMETER:: NFINAL=1E3, NMAX=1E3, TRANSIENT=2E2
  !REAL*8, DIMENSION(NMAX)::VEC1,VEC2
  !------------------------------------------------------------------------------
  OPEN(1,FILE='Data/BasinParameters.dat', STATUS='OLD')
  !------------------------------------------------------------------------------  
  DO ii=1,4
     READ(1,*) a,K,x1,y1,x2,y2
     IF(ii.EQ.1) OPEN(2,FILE='Data/Basin1.dat')
     IF(ii.EQ.2) OPEN(2,FILE='Data/Basin2.dat')
     IF(ii.EQ.3) OPEN(2,FILE='Data/Basin3.dat')
     IF(ii.EQ.4) OPEN(2,FILE='Data/Basin4.dat')     
     CIx: DO i=1,NMAX
        CIy: DO j=1,NMAX
           x00=2.0*pi*i/(1.0*NMAX)
           y00=200.0*j/(1.0*NMAX)
           !
           x0=x00;y0=y00
           !
           theta0=0.0;somap=0.0;somaq=0.0
           !
           TIME: DO n=1,NFINAL
              yn=(1.0-gamma)*y0+K*(SIN(x0)+a*SIN(2.0*x0+pi/2.0))
              xn=MOD(x0+yn, 2.0*pi)
           !
              IF(xn.LT.0.0) xn=xn+2.0*pi
              !
              IF(ABS(xn-x1).LT.THS.AND.ABS(yn-y1).LT.THS) THEN
                 WRITE(2,*) x00,y00,1
                 EXIT
              ELSE IF(ABS(xn-x2).LT.THS.AND.ABS(yn-y2).LT.THS) THEN
                 WRITE(2,*) x00,y00,2
                 EXIT
              END IF
              IF(n.GT.TRANSIENT) THEN
                 J11=1.0-gamma
                 J12=K*(COS(xn)+2.0*a*COS(2.0*xn+PI/2.0))
                 J21=1.0-gamma
                 J22=1.0+J12
              !
                 theta=ATAN((-J21*COS(theta0)+J22*SIN(theta0))/(J11*COS(theta0)-J12*SIN(theta0)))
              !
                 p=COS(theta0)*(J11*COS(theta)-J21*SIN(theta))-SIN(theta0)*(J12*COS(theta)-J22*SIN(theta))
              !
                 q=SIN(theta0)*(J11*SIN(theta)+J21*COS(theta))+COS(theta0)*(J12*SIN(theta)+J22*COS(theta))
              !
                 somap=somap+LOG(ABS(p))
                 somaq=somaq+LOG(ABS(q))
              !
                 theta0=theta
              END IF
              x0=xn;y0=yn
           END DO TIME
           lambda=somap/(1.0*NFINAL)           
77         IF(lambda.GT.0.001) WRITE(2,*) x00,y00,3
        END DO CIy
     END DO CIx
     CLOSE(2)
  END DO
END PROGRAM BASINS
