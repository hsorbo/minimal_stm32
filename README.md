# A minimal working STM32 project

Inspired by https://interrupt.memfault.com/blog/zero-to-main-1 this is a minimal STM32 firmware.
There is no HW-init, just vector-table/reset-handler/c-init and then `main()`

## MacOS
```
brew install --cask gcc-arm-embedded
git clone https://github.com/hsorbo/minimal_stm32.git
cd minimal_stm32
make
```