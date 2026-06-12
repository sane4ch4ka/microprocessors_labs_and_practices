#include <8051.h>

void delay(unsigned int count) {
    unsigned int i;
    for (i = 0; i < count; i++);
}

void lcd_cmd(unsigned char cmd) {
    P0 = cmd;                    
    P2 = P2 & 0xF9;              // RS=0, RW=0
    P2 = P2 | 0x01;              // E=1
    P2 = P2 & 0xFE;              // E=0
}

void lcd_data(unsigned char dat) {
    P0 = dat;                    
    P2 = P2 | 0x02;              // RS=1
    P2 = P2 & 0xFB;              // RW=0
    P2 = P2 | 0x01;              // E=1
    P2 = P2 & 0xFE;              // E=0
}

void lcd_init(void) {
    delay(100);                  
    lcd_cmd(0x38);               
    lcd_cmd(0x0E);               
    lcd_cmd(0x06);               
    lcd_cmd(0x01);               
    delay(50);                   
}

void lcd_print_rus(unsigned char *str, unsigned char len) {
    unsigned char i;
    for(i = 0; i < len; i++) {
        lcd_data(str[i]);
    }
}

void main(void) {
    unsigned int i, start;
    
    unsigned char word1[] = {0xB2, 0xA0, 0xAE, 0xA5, 0xB8, 0xAB, 0xA0};
    unsigned char word2[] = "sane4ka";
    
    lcd_init();
    
    lcd_cmd(0x87);                
    for(i = 0; i < 7; i++) {
        lcd_data(word1[i]);
    }
    
    start = 0;
    while(1) {
        lcd_cmd(0xC0);
        
        for(i = 0; i < 16; i++) {
            int pos = start + i;
            if(pos >= 16) {
                pos = pos - 16;
            }
            if(pos < 7) {
                lcd_data(word2[pos]);
            } else {
                lcd_data(' ');
            }
        }
        
        start++;
        if(start >= 16) start = 0;
        
        delay(10);
    }
}

