Main:
    OUT     RESETPOS
    LOADI   10
    OUT     CTIMER
    SEI     &B0010
    LOAD    MASK4
    ADD     MASK5
    ADD     MASK6
    OUT     SONAREN
    LOAD    STATE
    SUB     STATE
    STORE   STATE
    JUMP    SONAR_READ
    
DRIVE_THERE_1:
    IN      XPOS
    SUB     Leg1
    JPOS    BIG_TURN_LEFT
    IN      DIST4
    SUB     MAX
    JNEG    TURN_LEFT
    IN      DIST6
    SUB     MAX     
    JNEG    TURN_RIGHT
    IN      DIST5
    SUB     MAX
    JZERO   TURN_RIGHT
    IN      DIST5
    ADDI    -190
    JNEG    TURN_LEFT
    IN      DIST5
    ADDI    -210
    JPOS    TURN_RIGHT
    LOADI   0
    STORE   DTheta
    LOAD    FFast
    STORE   DVel
    JUMP    SONAR_READ
    
DRIVE_THERE_2:
    IN      XPOS
    SUB     Leg2
    JPOS    TURN_AROUND_BACK
    IN      DIST4
    SUB     MAX
    JNEG    TURN_LEFT
    IN      DIST6
    SUB     MAX     
    JNEG    TURN_RIGHT
    IN      DIST5
    SUB     MAX
    JZERO   TURN_RIGHT
    IN      DIST5
    ADDI    -190
    JNEG    TURN_LEFT
    IN      DIST5
    ADDI    -210
    JPOS    TURN_RIGHT
    LOADI   0
    STORE   DTheta
    LOAD    FFast
    STORE   DVel
    JUMP    SONAR_READ

DRIVE_BACK_2:
    IN      XPOS
    SUB     Leg2
    JPOS    BIG_TURN_RIGHT
    IN      DIST7
    SUB     MAX
    JNEG    TURN_LEFT
    IN      DIST1
    SUB     MAX     
    JNEG    TURN_RIGHT
    IN      DIST0
    SUB     MAX
    JZERO   TURN_LEFT
    IN      DIST0
    ADDI    -190
    JNEG    TURN_LEFT
    IN      DIST0
    ADDI    -210
    JPOS    TURN_RIGHT
    LOADI   0
    STORE   DTheta
    LOAD    FFast
    STORE   DVel
    JUMP    SONAR_READ

DRIVE_BACK_1:
    IN      XPOS
    SUB     Leg1
    JPOS    TURN_AROUND_THERE
    IN      DIST7
    SUB     MAX
    JNEG    TURN_LEFT
    IN      DIST1
    SUB     MAX     
    JNEG    TURN_RIGHT
    IN      DIST0
    SUB     MAX
    JZERO   TURN_LEFT
    IN      DIST0
    ADDI    -190
    JNEG    TURN_LEFT
    IN      DIST0
    ADDI    -210
    JPOS    TURN_RIGHT
    LOADI   0
    STORE   DTheta
    LOAD    FFast
    STORE   DVel
    JUMP    SONAR_READ
    
TURN_LEFT:
    LOADI   -5
    STORE   DTheta
    LOAD    FFast
    STORE   Dvel
    JUMP    SONAR_READ
TURN_RIGHT:
    LOADI   5
    STORE   DTheta
    LOAD    FFast
    STORE   Dvel
    JUMP    SONAR_READ

TURN_AROUND_BACK:
    OUT     RESETPOS
    LOADI   180
    STORE   DTheta
TURN_AROUND_BACK_LOOP:
    IN      Theta
    ADDI    -180
    CALL    Abs
    ADDI    -3
    JPOS    TURN_AROUND_BACK_LOOP
    LOAD    STATE
    ADDI    1
    STORE   STATE
    ; Switch sonars being used
    LOAD    MASK0
    ADD     MASK1
    ADD     MASK7
    OUT     SONAREN
    OUT     RESETPOS
    JUMP    SONAR_READ    

TURN_AROUND_THERE:
    OUT     RESETPOS
    LOADI   -180
    STORE   DTheta
TURN_AROUND_THERE_LOOP:
    IN      Theta
    ADDI    180
    CALL    Abs
    ADDI    -3
    JPOS    TURN_AROUND_THERE_LOOP
    LOAD    STATE
    SUB     STATE
    STORE   STATE
    ; Switch sonars being used
    LOAD    MASK4
    ADD     MASK5
    ADD     MASK6
    OUT     SONAREN
    OUT     RESETPOS
    JUMP    SONAR_READ    
    
BIG_TURN_LEFT:
    OUT     RESETPOS
    LOADI   90
    STORE   DTheta
BIG_TURN_LEFT_LOOP:
    IN      Theta
    ADDI    -90
    CALL    Abs
    ADDI    -3
    JPOS    BIG_TURN_LEFT_LOOP
    LOAD    STATE
    ADDI    1
    STORE   STATE
    OUT     RESETPOS
    JUMP    SONAR_READ  
    
BIG_TURN_RIGHT:
    OUT     RESETPOS
    LOADI   -90
    STORE   DTheta
BIG_TURN_RIGHT_LOOP:
    IN      Theta
    ADDI    90
    CALL    Abs
    ADDI    -3
    JPOS    BIG_TURN_RIGHT_LOOP
    LOAD    STATE
    ADDI    1
    STORE   STATE
    OUT     RESETPOS
    JUMP    SONAR_READ  

SONAR_READ:
    IN      SWITCHES
    AND     MASK0
    JZERO   SW_1
    IN      DIST0
    OUT     LCD
    JUMP    SWITCH_STATE
SW_1:
    IN      SWITCHES
    AND     MASK1
    JZERO   SW_4
    IN      DIST1
    OUT     LCD
    JUMP    SWITCH_STATE
SW_4:
    IN      SWITCHES
    AND     MASK4
    JZERO   SW_5
    IN      DIST4
    OUT     LCD
    JUMP    SWITCH_STATE
SW_5:
    IN      SWITCHES
    AND     MASK5
    JZERO   SW_6
    IN      DIST5
    OUT     LCD
    JUMP    SWITCH_STATE
SW_6:
    IN      SWITCHES
    AND     MASK6
    JZERO   SW_7
    IN      DIST6
    OUT     LCD
    JUMP    SWITCH_STATE   
SW_7:
    IN      SWITCHES
    AND     MASK7
    JZERO   DIST_DBG
    IN      DIST7
    OUT     LCD
    JUMP    SWITCH_STATE
DIST_DBG:
    IN      SWITCHES
    AND     MASK2
    JZERO   SWITCH_STATE
    IN      XPOS 
    OUT     LCD
    JUMP    SWITCH_STATE

SWITCH_STATE:
    LOAD    STATE
    JZERO   DRIVE_THERE_1
    ADDI    -1
    JZERO   DRIVE_THERE_2
    ADDI    -1
    JZERO   DRIVE_BACK_2
    ADDI    -1
    JZERO   DRIVE_BACK_1
    
