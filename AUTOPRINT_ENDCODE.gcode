G1 X105 Y195 Z50 F3000 ; Move up and back

M300 S3520 P200 ; A7
M300 S4698.63 P200 ; D8
M300 S5274.04 P200 ; E8
M300 S6271.93 P200 ; G8

G1 X105 Y195 Z1 F3000 ; Lower
G1 X105 Y1 Z1 F2400 ; Remove Print
G1 X105 Y30 Z1 F8000 ; Shake it out
G1 X105 Y1 Z1 F8000 ; Shake it out
G1 X105 Y30 Z1 F8000 ; Shake it out

; G91 ;Relative positionning 
G1 E-2 F2700 ;Retract a bit 
; G1 E-2 Z0.2 F2400 ;Retract and raise Z 
; G1 X5 Y5 F3000 ;Wipe out 
; G1 Z5 ;Raise Z more 
; G90 ;Absolute positionning 
 
; G1 X2 Y218 F3000 ;Present print 
; M106 S0 ;Turn-off fan 
; M104 S0 ;Turn-off hotend 
; M140 S0 ;Turn-off bed 
 
; M84 X Y E ;Disable all steppers but Z
