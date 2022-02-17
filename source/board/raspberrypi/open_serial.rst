树莓派3B串口与IIC
================

打开串口
--------------

.. code:: shell

   # 查看串口默认映射关系
   $ ls -l /dev |grep serial
   > lrwxrwxrwx 1 root root           5 Jul 21 11:03 serial1 -> ttyAMA0

   # 打开 mini com 
   $ sudo raspi-config
   # Interface Options -> Serial Port -> No -> Yes

   # 查看开启后映射关系
   $ ls -l /dev |grep serial
   > lrwxrwxrwx 1 root root           5 Jul 21 11:03 serial1 -> ttyAMA0
   > lrwxrwxrwx 1 root root           5 Jul 21 11:03 serial0 -> ttyS0

修改映射关系
---------------

.. code:: shell

   # 查看 /boot/overlays/README 文件
   $ grep "bt" /boot/overlays/README

   >         krnbt                   Set to "on" to enable autoprobing of Bluetooth
   >                                 driver without need of hciattach/btattach
   >         krnbt_baudrate          Set the baudrate of the PL011 UART when used
   >                                 with krnbt=on
   >         See: github.com/notro/fbtft/wiki/FBTFT-on-Raspian
   > Name:   disable-bt
   > Load:   dtoverlay=disable-bt
   > Name:   miniuart-bt
   > Load:   dtoverlay=miniuart-bt,<param>=<val>
   > Params: krnbt                   Set to "on" to enable autoprobing of Bluetooth
   >                                 driver without need of hciattach/btattach
   > Name:   pi3-disable-bt
   > Info:   This overlay has been renamed disable-bt, keeping pi3-disable-bt as an
   > Name:   pi3-miniuart-bt
   > Info:   This overlay has been renamed miniuart-bt, keeping pi3-miniuart-bt as
   > Info:   Overlay for SH1106 OLED via SPI using fbtft staging driver.
   > Info:   Overlay for SSD1306 OLED via SPI using fbtft staging driver.
   > Info:   Overlay for SSD1351 OLED via SPI using fbtft staging driver.

   # 其中 disable-bt Load: dtoverlay=miniuart-bt 为加载文件说明
   # 查看 /boot/overlays/ 目录中是否存在该文件(miniuart-bt.dtbo)
   # 如果没有 可能是: pi3-miniuart-bt-overlay, pi3-miniuart-bt

   # !!! 根据文件名修改 /boot/config.txt 配置, 在文件末尾添加:
   dtoverlay=miniuart-bt
   # !!! miniuart-bt 是刚刚确认过的文件
   # 配置效果如下
          ...
          ...
          ...
   [all]
   #dtoverlay=vc4-fkms-v3d
   dtoverlay=miniuart-bt
   enable_uart=1

查看修改后的映射关系
-----------------------

.. code:: shell

   $ ls -l /dev |grep serial
   > lrwxrwxrwx 1 root root           7 Jul 21 11:03 serial0 -> ttyAMA0
   > lrwxrwxrwx 1 root root           5 Jul 21 11:03 serial1 -> ttyS0

查看GPIO
-----------

.. note::
  
  先决条件： ``sudo apt-get install wiringpi``

  查看命令：``gpio readall``

.. code:: shell

  +-----+-----+---------+------+---+---Pi 3B--+---+------+---------+-----+-----+
  | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
  +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
  |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
  |   2 |   8 |   SDA.1 | ALT0 | 1 |  3 || 4  |   |      | 5v      |     |     |
  |   3 |   9 |   SCL.1 | ALT0 | 1 |  5 || 6  |   |      | 0v      |     |     |
  |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | ALT0 | TxD     | 15  | 14  |
  |     |     |      0v |      |   |  9 || 10 | 1 | ALT0 | RxD     | 16  | 15  |
  |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
  |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
  |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
  |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
  |  10 |  12 |    MOSI |   IN | 0 | 19 || 20 |   |      | 0v      |     |     |
  |   9 |  13 |    MISO |   IN | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
  |  11 |  14 |    SCLK |   IN | 0 | 23 || 24 | 1 | IN   | CE0     | 10  | 8   |
  |     |     |      0v |      |   | 25 || 26 | 1 | IN   | CE1     | 11  | 7   |
  |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
  |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
  |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 0 | IN   | GPIO.26 | 26  | 12  |
  |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
  |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 0 | IN   | GPIO.27 | 27  | 16  |
  |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
  |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  |
  +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
  | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
  +-----+-----+---------+------+---+---Pi 3B--+---+------+---------+-----+-----+


打开IIC
----------

.. code:: shell

  # 打开IIC
  sudo raspi-config
   ... 

  # 安装工具
  sudo apt-get install i2c-tools
  sudo apt-get install wiringpi

  # 查看IIC
  i2cdetect -y 1



测试
-------

.. note::

  可用usb转ttl工具连接电脑测试,注: 连接GND，RT反接，
  也可以用跳帽短接引脚 ``8``, ``10`` 两脚。
  安装串口测试工具 ``sudo apt-getinstall minicom``
  串口测试 ``minicom -D /dev/ttyAMA0 -b 9600``

