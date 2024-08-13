PROGRAM MAIN
  IMPLICIT NONE
  INTEGER::i,j,NTOTAL
  REAL*8::KM,KF,K0,P
  !-------------------------------------------------------------
  !------------------------------------------------------------
  DO j=1,3
     IF(j.EQ.1) THEN
        OPEN(1, FILE='Data/Ks_g_0-80.dat', STATUS='OLD')
        OPEN(2, FILE='Data/Ratio_g_0-80.dat', STATUS='UNKNOWN')
        OPEN(3, FILE='Data/Centers_g_0-80.dat', STATUS='OLD')
        NTOTAL=28
     ELSE IF(j.EQ.2) THEN
        OPEN(1, FILE='Data/Ks_g_0-85.dat', STATUS='OLD')
        OPEN(2, FILE='Data/Ratio_g_0-85.dat', STATUS='UNKNOWN')
        OPEN(3, FILE='Data/Centers_g_0-85.dat', STATUS='OLD')
        NTOTAl=26
     ELSE IF(j.EQ.3) THEN
        OPEN(1, FILE='Data/Ks_g_0-90.dat', STATUS='OLD')
        OPEN(2, FILE='Data/Ratio_g_0-90.dat', STATUS='UNKNOWN')
        OPEN(3, FILE='Data/Centers_g_0-90.dat', STATUS='OLD')
        NTOTAL=24
     END IF
     DO i=1,NTOTAL
        READ(1,*) K0,KM,KF
        READ(3,*) P !Position k of the centers of each shrimp-shaped structure
        WRITE(2,*) P,(KM-K0)/(KF-K0)
     END DO
     CLOSE(1);CLOSE(2);CLOSE(3)
  END DO
END PROGRAM MAIN
