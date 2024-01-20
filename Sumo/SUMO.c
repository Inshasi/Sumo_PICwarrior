unsigned int Adc_value;
void PWM_Init();
void PWM_Duty(unsigned int duty1, unsigned int duty2);
void moveForward(unsigned int speed1, unsigned int speed2);
void moveBackward(unsigned int speed1, unsigned int speed2);
void moveLeft(unsigned int speed1, unsigned int speed2);
void moveRight(unsigned int speed1, unsigned int speed2);
void Bluetooth_Init(const long baud_rate);
void ourDelay(unsigned int microSeconds);
void ADC_Init();
unsigned int ADC_Read_0(void);
void Park();
unsigned char received_data;
unsigned int counter;
int bluetoothSpeed = 600;

void main() {
    TRISD = 0x00;
    TRISA = 0xFF;
    TRISB = 0xFF;
    TRISC = 0b10001000;
    PORTD = 0x00;
    PWM_Init();
    Bluetooth_Init(9600);
    ADC_Init();
    Adc_value = ADC_Read_0();
    ourDelay(10);
    if(Adc_value < 750) {Adc_value = 800;}
    while(1){
      while (!(PORTC & 0b00001000)) {
           while ((PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
            while ((PORTB & 0b00000100) && (PORTB & 0b00000001) && (PORTB & 0b00000010) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
              moveForward(750,750);
              Adc_value = ADC_Read_0();
              ourDelay(10);
              if(Adc_value < 750) {Adc_value = 800;}
            }

            while ((!(PORTB & 0b00000001) || (!(PORTB & 0b00000010) && !(PORTB & 0b00000100))) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
              moveForward(Adc_value,Adc_value);
              Adc_value = ADC_Read_0();
              ourDelay(10);
              if(Adc_value < 750) {Adc_value = 800;}
            }

            while (!(PORTB & 0b00000100) && (PORTB & 0b00000001) && (PORTB & 0b00000010) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
              moveLeft(Adc_value,Adc_value);
              Adc_value = ADC_Read_0();
              ourDelay(10);
              if(Adc_value < 750) {Adc_value = 800;}
            }

            while (!(PORTB & 0b00000010) && (PORTB & 0b00000001) && (PORTB & 0b00000100) && (PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)) {
              moveRight(Adc_value,Adc_value);
              Adc_value = ADC_Read_0();
              ourDelay(10);
              if(Adc_value < 750) {Adc_value = 800;}
            }
        }

        while (!(PORTB & 0b00100000) && !(PORTB & 0b00010000) && !(PORTC & 0b00001000)){
          moveBackward(900,900);
          ourDelay(1000);
          moveRight(900,900);
          ourDelay(500);
        }

        while (!(PORTB & 0b00100000) && (PORTB & 0b00010000) && !(PORTC & 0b00001000)){
          moveRight(900,900);
          ourDelay(500);
        }

        while ((PORTB & 0b00100000) && !(PORTB & 0b00010000) && !(PORTC & 0b00001000)){
          moveLeft(900,900);
          ourDelay(500);
        }
      }
      Park();
      while ((PORTC & 0b00001000)) {
             if (UART1_Data_Ready()) {
            received_data = UART1_Read();

            switch (received_data) {
                case 'F':
                    moveForward(bluetoothSpeed,bluetoothSpeed);
                    break;
                case 'B':
                    moveBackward(bluetoothSpeed,bluetoothSpeed);
                    break;
                case 'R':
                    moveRight(bluetoothSpeed,bluetoothSpeed);
                    break;
                case 'L':
                    moveLeft(bluetoothSpeed,bluetoothSpeed);
                    break;
                case 'S':
                    Park();
                    break;
                case '1':
                    bluetoothSpeed = 600;
                    break;
                case '2':
                    bluetoothSpeed = 650;
                    break;
                case '3':
                    bluetoothSpeed = 700;
                    break;
                case '4':
                    bluetoothSpeed = 750;
                    break;
                case '5':
                    bluetoothSpeed = 800;
                    break;
                case '6':
                    bluetoothSpeed = 850;
                    break;
                case '7':
                    bluetoothSpeed = 900;
                    break;
                case '8':
                    bluetoothSpeed = 950;
                    break;
                case '9':
                    bluetoothSpeed = 1000;
                    break;
                default:
                    Park();
                    break;
            }
        }
      }
  }
}

void PWM_Init() {
    PR2 = 255;
    CCP1CON = 0b00001100;
    CCP2CON = 0b00001100;
    CCPR1L = 0;
    CCPR2L = 0;
    TMR2 = 0;
    T2CON = 0b00000100;
}

void PWM_Duty(unsigned int duty1, unsigned int duty2) {
    CCPR1L = duty1 >> 2;
    CCP1CON &= 0b11001111;
    CCP1CON |= (0b00000011 & duty1) << 4;

    CCPR2L = duty2 >> 2;
    CCP2CON &= 0b11001111;
    CCP2CON |= (0b00000011 & duty2) << 4;

    CCP1CON |= 0b00000001;
    CCP2CON |= 0b00000001;
}

void moveForward(unsigned int speed1, unsigned int speed2) {
     PWM_Duty(speed1, speed2);
     PORTD = 0b00000101;
}

void moveBackward(unsigned int speed1, unsigned int speed2) {
     PWM_Duty(speed1, speed2);
     PORTD = 0b00001010;
}

void moveRight(unsigned int speed1, unsigned int speed2) {
     PWM_Duty(speed1, speed2);
     PORTD = 0b00001001;
}

void moveLeft(unsigned int speed1, unsigned int speed2) {
     PWM_Duty(speed1, speed2);
     PORTD = 0b00000110;
}

void Park() {
     PWM_Duty(0,0);
     PORTD = 0b00000000;
}

void Bluetooth_Init(const long baud_rate) {
    UART1_Init(9600);
    ourDelay(100);
}

void ourDelay(unsigned int microSeconds) {
  counter = 0;
  while (counter < microSeconds){counter++;}
}

void ADC_Init() {
    ADCON1 = 0xC0;
    ADCON0 = 0x41;

}

unsigned int ADC_Read_0(void) {
    ADCON0 = 0x41;
    ADCON0 = ADCON0 | 0x04;
    while (ADCON0 & 0x04);
    return ((ADRESH << 8) | ADRESL);
}