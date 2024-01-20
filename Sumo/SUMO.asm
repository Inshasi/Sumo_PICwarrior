
_main:

;SUMO.c,17 :: 		void main() {
;SUMO.c,18 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;SUMO.c,19 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;SUMO.c,20 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;SUMO.c,21 :: 		TRISC = 0b10001000;
	MOVLW      136
	MOVWF      TRISC+0
;SUMO.c,22 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;SUMO.c,23 :: 		PWM_Init();
	CALL       _PWM_Init+0
;SUMO.c,24 :: 		Bluetooth_Init(9600);
	MOVLW      128
	MOVWF      FARG_Bluetooth_Init_baud_rate+0
	MOVLW      37
	MOVWF      FARG_Bluetooth_Init_baud_rate+1
	CLRF       FARG_Bluetooth_Init_baud_rate+2
	CLRF       FARG_Bluetooth_Init_baud_rate+3
	CALL       _Bluetooth_Init+0
;SUMO.c,25 :: 		ADC_Init();
	CALL       _ADC_Init+0
;SUMO.c,26 :: 		Adc_value = ADC_Read_0();
	CALL       _ADC_Read_0+0
	MOVF       R0+0, 0
	MOVWF      _Adc_value+0
	MOVF       R0+1, 0
	MOVWF      _Adc_value+1
;SUMO.c,27 :: 		ourDelay(10);
	MOVLW      10
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      0
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,28 :: 		if(Adc_value < 750) {Adc_value = 800;}
	MOVLW      2
	SUBWF      _Adc_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVLW      238
	SUBWF      _Adc_value+0, 0
L__main80:
	BTFSC      STATUS+0, 0
	GOTO       L_main0
	MOVLW      32
	MOVWF      _Adc_value+0
	MOVLW      3
	MOVWF      _Adc_value+1
L_main0:
;SUMO.c,29 :: 		while(1){
L_main1:
;SUMO.c,30 :: 		while (!(PORTC & 0b00001000)) {
L_main3:
	BTFSC      PORTC+0, 3
	GOTO       L_main4
;SUMO.c,31 :: 		while ((PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
L_main5:
	BTFSS      PORTB+0, 5
	GOTO       L_main6
	BTFSS      PORTB+0, 4
	GOTO       L_main6
	BTFSC      PORTC+0, 3
	GOTO       L_main6
L__main78:
;SUMO.c,32 :: 		while ((PORTB & 0b00000100) && (PORTB & 0b00000001) && (PORTB & 0b00000010) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
L_main9:
	BTFSS      PORTB+0, 2
	GOTO       L_main10
	BTFSS      PORTB+0, 0
	GOTO       L_main10
	BTFSS      PORTB+0, 1
	GOTO       L_main10
	BTFSS      PORTB+0, 5
	GOTO       L_main10
	BTFSS      PORTB+0, 4
	GOTO       L_main10
	BTFSC      PORTC+0, 3
	GOTO       L_main10
L__main77:
;SUMO.c,33 :: 		moveForward(750,750);
	MOVLW      238
	MOVWF      FARG_moveForward_speed1+0
	MOVLW      2
	MOVWF      FARG_moveForward_speed1+1
	MOVLW      238
	MOVWF      FARG_moveForward_speed2+0
	MOVLW      2
	MOVWF      FARG_moveForward_speed2+1
	CALL       _moveForward+0
;SUMO.c,34 :: 		Adc_value = ADC_Read_0();
	CALL       _ADC_Read_0+0
	MOVF       R0+0, 0
	MOVWF      _Adc_value+0
	MOVF       R0+1, 0
	MOVWF      _Adc_value+1
;SUMO.c,35 :: 		ourDelay(10);
	MOVLW      10
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      0
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,36 :: 		if(Adc_value < 750) {Adc_value = 800;}
	MOVLW      2
	SUBWF      _Adc_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main81
	MOVLW      238
	SUBWF      _Adc_value+0, 0
L__main81:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
	MOVLW      32
	MOVWF      _Adc_value+0
	MOVLW      3
	MOVWF      _Adc_value+1
L_main13:
;SUMO.c,37 :: 		}
	GOTO       L_main9
L_main10:
;SUMO.c,39 :: 		while ((!(PORTB & 0b00000001) || (!(PORTB & 0b00000010) && !(PORTB & 0b00000100))) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
L_main14:
	BTFSS      PORTB+0, 0
	GOTO       L__main75
	BTFSC      PORTB+0, 1
	GOTO       L__main76
	BTFSC      PORTB+0, 2
	GOTO       L__main76
	GOTO       L__main75
L__main76:
	GOTO       L_main15
L__main75:
	BTFSS      PORTB+0, 5
	GOTO       L_main15
	BTFSS      PORTB+0, 4
	GOTO       L_main15
	BTFSC      PORTC+0, 3
	GOTO       L_main15
L__main74:
;SUMO.c,40 :: 		moveForward(Adc_value,Adc_value);
	MOVF       _Adc_value+0, 0
	MOVWF      FARG_moveForward_speed1+0
	MOVF       _Adc_value+1, 0
	MOVWF      FARG_moveForward_speed1+1
	MOVF       _Adc_value+0, 0
	MOVWF      FARG_moveForward_speed2+0
	MOVF       _Adc_value+1, 0
	MOVWF      FARG_moveForward_speed2+1
	CALL       _moveForward+0
;SUMO.c,41 :: 		Adc_value = ADC_Read_0();
	CALL       _ADC_Read_0+0
	MOVF       R0+0, 0
	MOVWF      _Adc_value+0
	MOVF       R0+1, 0
	MOVWF      _Adc_value+1
;SUMO.c,42 :: 		ourDelay(10);
	MOVLW      10
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      0
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,43 :: 		if(Adc_value < 750) {Adc_value = 800;}
	MOVLW      2
	SUBWF      _Adc_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main82
	MOVLW      238
	SUBWF      _Adc_value+0, 0
L__main82:
	BTFSC      STATUS+0, 0
	GOTO       L_main22
	MOVLW      32
	MOVWF      _Adc_value+0
	MOVLW      3
	MOVWF      _Adc_value+1
L_main22:
;SUMO.c,44 :: 		}
	GOTO       L_main14
L_main15:
;SUMO.c,46 :: 		while (!(PORTB & 0b00000100) && (PORTB & 0b00000001) && (PORTB & 0b00000010) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
L_main23:
	BTFSC      PORTB+0, 2
	GOTO       L_main24
	BTFSS      PORTB+0, 0
	GOTO       L_main24
	BTFSS      PORTB+0, 1
	GOTO       L_main24
	BTFSS      PORTB+0, 5
	GOTO       L_main24
	BTFSS      PORTB+0, 4
	GOTO       L_main24
	BTFSC      PORTC+0, 3
	GOTO       L_main24
L__main73:
;SUMO.c,47 :: 		moveLeft(Adc_value,Adc_value);
	MOVF       _Adc_value+0, 0
	MOVWF      FARG_moveLeft_speed1+0
	MOVF       _Adc_value+1, 0
	MOVWF      FARG_moveLeft_speed1+1
	MOVF       _Adc_value+0, 0
	MOVWF      FARG_moveLeft_speed2+0
	MOVF       _Adc_value+1, 0
	MOVWF      FARG_moveLeft_speed2+1
	CALL       _moveLeft+0
;SUMO.c,48 :: 		Adc_value = ADC_Read_0();
	CALL       _ADC_Read_0+0
	MOVF       R0+0, 0
	MOVWF      _Adc_value+0
	MOVF       R0+1, 0
	MOVWF      _Adc_value+1
;SUMO.c,49 :: 		ourDelay(10);
	MOVLW      10
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      0
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,50 :: 		if(Adc_value < 750) {Adc_value = 800;}
	MOVLW      2
	SUBWF      _Adc_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main83
	MOVLW      238
	SUBWF      _Adc_value+0, 0
L__main83:
	BTFSC      STATUS+0, 0
	GOTO       L_main27
	MOVLW      32
	MOVWF      _Adc_value+0
	MOVLW      3
	MOVWF      _Adc_value+1
L_main27:
;SUMO.c,51 :: 		}
	GOTO       L_main23
L_main24:
;SUMO.c,53 :: 		while (!(PORTB & 0b00000010) && (PORTB & 0b00000001) && (PORTB & 0b00000100) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
L_main28:
	BTFSC      PORTB+0, 1
	GOTO       L_main29
	BTFSS      PORTB+0, 0
	GOTO       L_main29
	BTFSS      PORTB+0, 2
	GOTO       L_main29
	BTFSS      PORTB+0, 5
	GOTO       L_main29
	BTFSS      PORTB+0, 4
	GOTO       L_main29
	BTFSC      PORTC+0, 3
	GOTO       L_main29
L__main72:
;SUMO.c,54 :: 		moveRight(Adc_value,Adc_value);
	MOVF       _Adc_value+0, 0
	MOVWF      FARG_moveRight_speed1+0
	MOVF       _Adc_value+1, 0
	MOVWF      FARG_moveRight_speed1+1
	MOVF       _Adc_value+0, 0
	MOVWF      FARG_moveRight_speed2+0
	MOVF       _Adc_value+1, 0
	MOVWF      FARG_moveRight_speed2+1
	CALL       _moveRight+0
;SUMO.c,55 :: 		Adc_value = ADC_Read_0();
	CALL       _ADC_Read_0+0
	MOVF       R0+0, 0
	MOVWF      _Adc_value+0
	MOVF       R0+1, 0
	MOVWF      _Adc_value+1
;SUMO.c,56 :: 		ourDelay(10);
	MOVLW      10
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      0
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,57 :: 		if(Adc_value < 750) {Adc_value = 800;}
	MOVLW      2
	SUBWF      _Adc_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
	MOVLW      238
	SUBWF      _Adc_value+0, 0
L__main84:
	BTFSC      STATUS+0, 0
	GOTO       L_main32
	MOVLW      32
	MOVWF      _Adc_value+0
	MOVLW      3
	MOVWF      _Adc_value+1
L_main32:
;SUMO.c,58 :: 		}
	GOTO       L_main28
L_main29:
;SUMO.c,59 :: 		}
	GOTO       L_main5
L_main6:
;SUMO.c,61 :: 		while (!(PORTB & 0b00100000) && !(PORTB & 0b00010000) && !(PORTC & 0b00001000)){
L_main33:
	BTFSC      PORTB+0, 5
	GOTO       L_main34
	BTFSC      PORTB+0, 4
	GOTO       L_main34
	BTFSC      PORTC+0, 3
	GOTO       L_main34
L__main71:
;SUMO.c,62 :: 		moveBackward(900,900);
	MOVLW      132
	MOVWF      FARG_moveBackward_speed1+0
	MOVLW      3
	MOVWF      FARG_moveBackward_speed1+1
	MOVLW      132
	MOVWF      FARG_moveBackward_speed2+0
	MOVLW      3
	MOVWF      FARG_moveBackward_speed2+1
	CALL       _moveBackward+0
;SUMO.c,63 :: 		ourDelay(1000);
	MOVLW      232
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      3
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,64 :: 		moveRight(900,900);
	MOVLW      132
	MOVWF      FARG_moveRight_speed1+0
	MOVLW      3
	MOVWF      FARG_moveRight_speed1+1
	MOVLW      132
	MOVWF      FARG_moveRight_speed2+0
	MOVLW      3
	MOVWF      FARG_moveRight_speed2+1
	CALL       _moveRight+0
;SUMO.c,65 :: 		ourDelay(500);
	MOVLW      244
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      1
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,66 :: 		}
	GOTO       L_main33
L_main34:
;SUMO.c,68 :: 		while (!(PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)){
L_main37:
	BTFSC      PORTB+0, 5
	GOTO       L_main38
	BTFSS      PORTB+0, 4
	GOTO       L_main38
	BTFSC      PORTC+0, 3
	GOTO       L_main38
L__main70:
;SUMO.c,69 :: 		moveRight(900,900);
	MOVLW      132
	MOVWF      FARG_moveRight_speed1+0
	MOVLW      3
	MOVWF      FARG_moveRight_speed1+1
	MOVLW      132
	MOVWF      FARG_moveRight_speed2+0
	MOVLW      3
	MOVWF      FARG_moveRight_speed2+1
	CALL       _moveRight+0
;SUMO.c,70 :: 		ourDelay(500);
	MOVLW      244
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      1
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,71 :: 		}
	GOTO       L_main37
L_main38:
;SUMO.c,73 :: 		while ((PORTB & 0b00100000) && !(PORTB & 0b00010000) && !(PORTC & 0b00001000)){
L_main41:
	BTFSS      PORTB+0, 5
	GOTO       L_main42
	BTFSC      PORTB+0, 4
	GOTO       L_main42
	BTFSC      PORTC+0, 3
	GOTO       L_main42
L__main69:
;SUMO.c,74 :: 		moveLeft(900,900);
	MOVLW      132
	MOVWF      FARG_moveLeft_speed1+0
	MOVLW      3
	MOVWF      FARG_moveLeft_speed1+1
	MOVLW      132
	MOVWF      FARG_moveLeft_speed2+0
	MOVLW      3
	MOVWF      FARG_moveLeft_speed2+1
	CALL       _moveLeft+0
;SUMO.c,75 :: 		ourDelay(500);
	MOVLW      244
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      1
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,76 :: 		}
	GOTO       L_main41
L_main42:
;SUMO.c,77 :: 		}
	GOTO       L_main3
L_main4:
;SUMO.c,78 :: 		Park();
	CALL       _Park+0
;SUMO.c,79 :: 		while ((PORTC & 0b00001000)) {
L_main45:
	BTFSS      PORTC+0, 3
	GOTO       L_main46
;SUMO.c,80 :: 		if (UART1_Data_Ready()) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main47
;SUMO.c,81 :: 		received_data = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _received_data+0
;SUMO.c,83 :: 		switch (received_data) {
	GOTO       L_main48
;SUMO.c,84 :: 		case 'F':
L_main50:
;SUMO.c,85 :: 		moveForward(bluetoothSpeed,bluetoothSpeed);
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveForward_speed1+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveForward_speed1+1
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveForward_speed2+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveForward_speed2+1
	CALL       _moveForward+0
;SUMO.c,86 :: 		break;
	GOTO       L_main49
;SUMO.c,87 :: 		case 'B':
L_main51:
;SUMO.c,88 :: 		moveBackward(bluetoothSpeed,bluetoothSpeed);
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveBackward_speed1+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveBackward_speed1+1
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveBackward_speed2+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveBackward_speed2+1
	CALL       _moveBackward+0
;SUMO.c,89 :: 		break;
	GOTO       L_main49
;SUMO.c,90 :: 		case 'R':
L_main52:
;SUMO.c,91 :: 		moveRight(bluetoothSpeed,bluetoothSpeed);
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveRight_speed1+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveRight_speed1+1
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveRight_speed2+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveRight_speed2+1
	CALL       _moveRight+0
;SUMO.c,92 :: 		break;
	GOTO       L_main49
;SUMO.c,93 :: 		case 'L':
L_main53:
;SUMO.c,94 :: 		moveLeft(bluetoothSpeed,bluetoothSpeed);
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveLeft_speed1+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveLeft_speed1+1
	MOVF       _bluetoothSpeed+0, 0
	MOVWF      FARG_moveLeft_speed2+0
	MOVF       _bluetoothSpeed+1, 0
	MOVWF      FARG_moveLeft_speed2+1
	CALL       _moveLeft+0
;SUMO.c,95 :: 		break;
	GOTO       L_main49
;SUMO.c,96 :: 		case 'S':
L_main54:
;SUMO.c,97 :: 		Park();
	CALL       _Park+0
;SUMO.c,98 :: 		break;
	GOTO       L_main49
;SUMO.c,99 :: 		case '1':
L_main55:
;SUMO.c,100 :: 		bluetoothSpeed = 600;
	MOVLW      88
	MOVWF      _bluetoothSpeed+0
	MOVLW      2
	MOVWF      _bluetoothSpeed+1
;SUMO.c,101 :: 		break;
	GOTO       L_main49
;SUMO.c,102 :: 		case '2':
L_main56:
;SUMO.c,103 :: 		bluetoothSpeed = 650;
	MOVLW      138
	MOVWF      _bluetoothSpeed+0
	MOVLW      2
	MOVWF      _bluetoothSpeed+1
;SUMO.c,104 :: 		break;
	GOTO       L_main49
;SUMO.c,105 :: 		case '3':
L_main57:
;SUMO.c,106 :: 		bluetoothSpeed = 700;
	MOVLW      188
	MOVWF      _bluetoothSpeed+0
	MOVLW      2
	MOVWF      _bluetoothSpeed+1
;SUMO.c,107 :: 		break;
	GOTO       L_main49
;SUMO.c,108 :: 		case '4':
L_main58:
;SUMO.c,109 :: 		bluetoothSpeed = 750;
	MOVLW      238
	MOVWF      _bluetoothSpeed+0
	MOVLW      2
	MOVWF      _bluetoothSpeed+1
;SUMO.c,110 :: 		break;
	GOTO       L_main49
;SUMO.c,111 :: 		case '5':
L_main59:
;SUMO.c,112 :: 		bluetoothSpeed = 800;
	MOVLW      32
	MOVWF      _bluetoothSpeed+0
	MOVLW      3
	MOVWF      _bluetoothSpeed+1
;SUMO.c,113 :: 		break;
	GOTO       L_main49
;SUMO.c,114 :: 		case '6':
L_main60:
;SUMO.c,115 :: 		bluetoothSpeed = 850;
	MOVLW      82
	MOVWF      _bluetoothSpeed+0
	MOVLW      3
	MOVWF      _bluetoothSpeed+1
;SUMO.c,116 :: 		break;
	GOTO       L_main49
;SUMO.c,117 :: 		case '7':
L_main61:
;SUMO.c,118 :: 		bluetoothSpeed = 900;
	MOVLW      132
	MOVWF      _bluetoothSpeed+0
	MOVLW      3
	MOVWF      _bluetoothSpeed+1
;SUMO.c,119 :: 		break;
	GOTO       L_main49
;SUMO.c,120 :: 		case '8':
L_main62:
;SUMO.c,121 :: 		bluetoothSpeed = 950;
	MOVLW      182
	MOVWF      _bluetoothSpeed+0
	MOVLW      3
	MOVWF      _bluetoothSpeed+1
;SUMO.c,122 :: 		break;
	GOTO       L_main49
;SUMO.c,123 :: 		case '9':
L_main63:
;SUMO.c,124 :: 		bluetoothSpeed = 1000;
	MOVLW      232
	MOVWF      _bluetoothSpeed+0
	MOVLW      3
	MOVWF      _bluetoothSpeed+1
;SUMO.c,125 :: 		break;
	GOTO       L_main49
;SUMO.c,126 :: 		default:
L_main64:
;SUMO.c,127 :: 		Park();
	CALL       _Park+0
;SUMO.c,128 :: 		break;
	GOTO       L_main49
;SUMO.c,129 :: 		}
L_main48:
	MOVF       _received_data+0, 0
	XORLW      70
	BTFSC      STATUS+0, 2
	GOTO       L_main50
	MOVF       _received_data+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_main51
	MOVF       _received_data+0, 0
	XORLW      82
	BTFSC      STATUS+0, 2
	GOTO       L_main52
	MOVF       _received_data+0, 0
	XORLW      76
	BTFSC      STATUS+0, 2
	GOTO       L_main53
	MOVF       _received_data+0, 0
	XORLW      83
	BTFSC      STATUS+0, 2
	GOTO       L_main54
	MOVF       _received_data+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_main55
	MOVF       _received_data+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_main56
	MOVF       _received_data+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_main57
	MOVF       _received_data+0, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L_main58
	MOVF       _received_data+0, 0
	XORLW      53
	BTFSC      STATUS+0, 2
	GOTO       L_main59
	MOVF       _received_data+0, 0
	XORLW      54
	BTFSC      STATUS+0, 2
	GOTO       L_main60
	MOVF       _received_data+0, 0
	XORLW      55
	BTFSC      STATUS+0, 2
	GOTO       L_main61
	MOVF       _received_data+0, 0
	XORLW      56
	BTFSC      STATUS+0, 2
	GOTO       L_main62
	MOVF       _received_data+0, 0
	XORLW      57
	BTFSC      STATUS+0, 2
	GOTO       L_main63
	GOTO       L_main64
L_main49:
;SUMO.c,130 :: 		}
L_main47:
;SUMO.c,131 :: 		}
	GOTO       L_main45
L_main46:
;SUMO.c,132 :: 		}
	GOTO       L_main1
;SUMO.c,133 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_PWM_Init:

;SUMO.c,135 :: 		void PWM_Init() {
;SUMO.c,136 :: 		PR2 = 255;
	MOVLW      255
	MOVWF      PR2+0
;SUMO.c,137 :: 		CCP1CON = 0b00001100;
	MOVLW      12
	MOVWF      CCP1CON+0
;SUMO.c,138 :: 		CCP2CON = 0b00001100;
	MOVLW      12
	MOVWF      CCP2CON+0
;SUMO.c,139 :: 		CCPR1L = 0;
	CLRF       CCPR1L+0
;SUMO.c,140 :: 		CCPR2L = 0;
	CLRF       CCPR2L+0
;SUMO.c,141 :: 		TMR2 = 0;
	CLRF       TMR2+0
;SUMO.c,142 :: 		T2CON = 0b00000100;
	MOVLW      4
	MOVWF      T2CON+0
;SUMO.c,143 :: 		}
L_end_PWM_Init:
	RETURN
; end of _PWM_Init

_PWM_Duty:

;SUMO.c,145 :: 		void PWM_Duty(unsigned int duty1, unsigned int duty2) {
;SUMO.c,146 :: 		CCPR1L = duty1 >> 2;
	MOVF       FARG_PWM_Duty_duty1+0, 0
	MOVWF      R0+0
	MOVF       FARG_PWM_Duty_duty1+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      CCPR1L+0
;SUMO.c,147 :: 		CCP1CON &= 0b11001111;
	MOVLW      207
	ANDWF      CCP1CON+0, 1
;SUMO.c,148 :: 		CCP1CON |= (0b00000011 & duty1) << 4;
	MOVLW      3
	ANDWF      FARG_PWM_Duty_duty1+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      CCP1CON+0, 1
;SUMO.c,150 :: 		CCPR2L = duty2 >> 2;
	MOVF       FARG_PWM_Duty_duty2+0, 0
	MOVWF      R0+0
	MOVF       FARG_PWM_Duty_duty2+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      CCPR2L+0
;SUMO.c,151 :: 		CCP2CON &= 0b11001111;
	MOVLW      207
	ANDWF      CCP2CON+0, 1
;SUMO.c,152 :: 		CCP2CON |= (0b00000011 & duty2) << 4;
	MOVLW      3
	ANDWF      FARG_PWM_Duty_duty2+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      CCP2CON+0, 1
;SUMO.c,154 :: 		CCP1CON |= 0b00000001;
	BSF        CCP1CON+0, 0
;SUMO.c,155 :: 		CCP2CON |= 0b00000001;
	BSF        CCP2CON+0, 0
;SUMO.c,156 :: 		}
L_end_PWM_Duty:
	RETURN
; end of _PWM_Duty

_moveForward:

;SUMO.c,158 :: 		void moveForward(unsigned int speed1, unsigned int speed2) {
;SUMO.c,159 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveForward_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveForward_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveForward_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveForward_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;SUMO.c,160 :: 		PORTD = 0b00000101;
	MOVLW      5
	MOVWF      PORTD+0
;SUMO.c,161 :: 		}
L_end_moveForward:
	RETURN
; end of _moveForward

_moveBackward:

;SUMO.c,163 :: 		void moveBackward(unsigned int speed1, unsigned int speed2) {
;SUMO.c,164 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveBackward_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveBackward_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveBackward_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveBackward_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;SUMO.c,165 :: 		PORTD = 0b00001010;
	MOVLW      10
	MOVWF      PORTD+0
;SUMO.c,166 :: 		}
L_end_moveBackward:
	RETURN
; end of _moveBackward

_moveRight:

;SUMO.c,168 :: 		void moveRight(unsigned int speed1, unsigned int speed2) {
;SUMO.c,169 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveRight_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveRight_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveRight_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveRight_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;SUMO.c,170 :: 		PORTD = 0b00001001;
	MOVLW      9
	MOVWF      PORTD+0
;SUMO.c,171 :: 		}
L_end_moveRight:
	RETURN
; end of _moveRight

_moveLeft:

;SUMO.c,173 :: 		void moveLeft(unsigned int speed1, unsigned int speed2) {
;SUMO.c,174 :: 		PWM_Duty(speed1, speed2);
	MOVF       FARG_moveLeft_speed1+0, 0
	MOVWF      FARG_PWM_Duty_duty1+0
	MOVF       FARG_moveLeft_speed1+1, 0
	MOVWF      FARG_PWM_Duty_duty1+1
	MOVF       FARG_moveLeft_speed2+0, 0
	MOVWF      FARG_PWM_Duty_duty2+0
	MOVF       FARG_moveLeft_speed2+1, 0
	MOVWF      FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;SUMO.c,175 :: 		PORTD = 0b00000110;
	MOVLW      6
	MOVWF      PORTD+0
;SUMO.c,176 :: 		}
L_end_moveLeft:
	RETURN
; end of _moveLeft

_Park:

;SUMO.c,178 :: 		void Park() {
;SUMO.c,179 :: 		PWM_Duty(0,0);
	CLRF       FARG_PWM_Duty_duty1+0
	CLRF       FARG_PWM_Duty_duty1+1
	CLRF       FARG_PWM_Duty_duty2+0
	CLRF       FARG_PWM_Duty_duty2+1
	CALL       _PWM_Duty+0
;SUMO.c,180 :: 		PORTD = 0b00000000;
	CLRF       PORTD+0
;SUMO.c,181 :: 		}
L_end_Park:
	RETURN
; end of _Park

_Bluetooth_Init:

;SUMO.c,183 :: 		void Bluetooth_Init(const long baud_rate) {
;SUMO.c,184 :: 		UART1_Init(9600);
	MOVLW      64
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;SUMO.c,185 :: 		ourDelay(100);
	MOVLW      100
	MOVWF      FARG_ourDelay_microSeconds+0
	MOVLW      0
	MOVWF      FARG_ourDelay_microSeconds+1
	CALL       _ourDelay+0
;SUMO.c,186 :: 		}
L_end_Bluetooth_Init:
	RETURN
; end of _Bluetooth_Init

_ourDelay:

;SUMO.c,188 :: 		void ourDelay(unsigned int microSeconds) {
;SUMO.c,189 :: 		counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
;SUMO.c,190 :: 		while (counter < microSeconds){counter++;}
L_ourDelay65:
	MOVF       FARG_ourDelay_microSeconds+1, 0
	SUBWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ourDelay94
	MOVF       FARG_ourDelay_microSeconds+0, 0
	SUBWF      _counter+0, 0
L__ourDelay94:
	BTFSC      STATUS+0, 0
	GOTO       L_ourDelay66
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
	GOTO       L_ourDelay65
L_ourDelay66:
;SUMO.c,191 :: 		}
L_end_ourDelay:
	RETURN
; end of _ourDelay

_ADC_Init:

;SUMO.c,193 :: 		void ADC_Init() {
;SUMO.c,194 :: 		ADCON1 = 0xC0;
	MOVLW      192
	MOVWF      ADCON1+0
;SUMO.c,195 :: 		ADCON0 = 0x41;
	MOVLW      65
	MOVWF      ADCON0+0
;SUMO.c,197 :: 		}
L_end_ADC_Init:
	RETURN
; end of _ADC_Init

_ADC_Read_0:

;SUMO.c,199 :: 		unsigned int ADC_Read_0(void) {
;SUMO.c,200 :: 		ADCON0 = 0x41;
	MOVLW      65
	MOVWF      ADCON0+0
;SUMO.c,201 :: 		ADCON0 = ADCON0 | 0x04;
	BSF        ADCON0+0, 2
;SUMO.c,202 :: 		while (ADCON0 & 0x04);
L_ADC_Read_067:
	BTFSS      ADCON0+0, 2
	GOTO       L_ADC_Read_068
	GOTO       L_ADC_Read_067
L_ADC_Read_068:
;SUMO.c,203 :: 		return ((ADRESH << 8) | ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;SUMO.c,204 :: 		}
L_end_ADC_Read_0:
	RETURN
; end of _ADC_Read_0
