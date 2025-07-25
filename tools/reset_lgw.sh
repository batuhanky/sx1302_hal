SX1302_RESET_PIN=17     # SX1302 reset
#SX1302_POWER_EN_PIN=18  # SX1302 power enable
SX1261_RESET_PIN=18     # SX1261 reset (LBT / Spectral Scan)


WAIT_GPIO() {
    sleep 0.1
}

reset() {
    echo "CoreCell reset through GPIO$SX1302_RESET_PIN..."
    echo "SX1261 reset through GPIO$SX1261_RESET_PIN..."
    #echo "CoreCell power enable through GPIO$SX1302_POWER_EN_PIN..."

    # write output for SX1302 CoreCell power_enable and reset
    #gpioset gpiochip0 $SX1302_POWER_EN_PIN=1; WAIT_GPIO
    
    gpioset gpiochip0 $SX1302_RESET_PIN=1; WAIT_GPIO
    gpioset gpiochip0 $SX1302_RESET_PIN=0; WAIT_GPIO

    gpioset gpiochip0 $SX1261_RESET_PIN=0; WAIT_GPIO
    gpioset gpiochip0 $SX1261_RESET_PIN=1; WAIT_GPIO
}

case "$1" in
    start)
    reset
    ;;
    stop)
    reset
    ;;
    *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac

exit 0