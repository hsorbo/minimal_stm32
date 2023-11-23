#include "stdint.h"

extern uint32_t _sidata;
extern uint32_t _sdata; 
extern uint32_t _edata; 
extern uint32_t _sbss;  
extern uint32_t _ebss;  
extern uint32_t _estack;

extern void __libc_init_array();

void die(void) {
    while(1);
}

int main()
{

}

void Reset_Handler() {
    
    // data segment
    uint32_t *dataInit = &_sidata;
    uint32_t *data = &_sdata;
    while(data < &_edata) {
        *data++ = *dataInit++;
    }

    // bss segment
    uint32_t *bss = &_sbss;
    while(bss < &_ebss) {
        *bss++ = 0;
    }

    //SystemInit();

    __libc_init_array();
    main();
    die();
}

__attribute__((section(".isr_vector"), unused))
static const void (*VectorTable[])(void) = {
    (const void (*)(void)) &_estack,
    Reset_Handler,
    die, //NMI_Handler,
    die, //HardFault_Handler,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    die, //SVC_Handler,
    0,
    0,
    die, //PendSV_Handler,
    die, //SysTick_Handler,
    die, //WWDG_IRQHandler,                  
    die, //PVD_VDDIO2_IRQHandler,
    die, //RTC_IRQHandler,
    die, //FLASH_IRQHandler,
    die, //RCC_CRS_IRQHandler,
    die, //EXTI0_1_IRQHandler,
    die, //EXTI2_3_IRQHandler,
    die, //EXTI4_15_IRQHandler,
    die, //TSC_IRQHandler,
    die, //DMA1_Ch1_IRQHandler,
    die, //DMA1_Ch2_3_DMA2_Ch1_2_IRQHandler,
    die, //DMA1_Ch4_7_DMA2_Ch3_5_IRQHandler,
    die, //ADC1_COMP_IRQHandler,
    die, //TIM1_BRK_UP_TRG_COM_IRQHandler,
    die, //TIM1_CC_IRQHandler,
    die, //TIM2_IRQHandler,
    die, //TIM3_IRQHandler,
    die, //TIM6_DAC_IRQHandler,
    die, //TIM7_IRQHandler,
    die, //TIM14_IRQHandler,
    die, //TIM15_IRQHandler,
    die, //TIM16_IRQHandler,
    die, //TIM17_IRQHandler,
    die, //I2C1_IRQHandler,
    die, //I2C2_IRQHandler,
    die, //SPI1_IRQHandler,
    die, //SPI2_IRQHandler,
    die, //USART1_IRQHandler,
    die, //USART2_IRQHandler,
    die, //USART3_8_IRQHandler,
    die, //CEC_CAN_IRQHandler
};
