# coreboot for Lenovo L420

This is a patch that was submitted to coreboot to support Lenovo L420 laptop.
Lenovo L421 and L520 laptops should also work if using the IT8518 embedded 
controller. Thus, this is not yet official in coreboot tree, but *working*.
Currently, the version 4.20 of coreboot is to be used.

**WARNING: this was tested on my L420 laptop. The FIRST thing to do is to
save the content of your actual BIOS chip before flashing another one.**


### How to build coreboot for the L420

* make an empty directory named, for example, "l420"

```
mkdir l420; cd l420
```

* download the 4.20 release of coreboot and uncompress it into this directory
such as you have now the l420/coreboot-4.20 subdirectory

```
tar xfz coreboot-4.20.tar.gz
```

* copy the content of this repository into l420/coreboot-4.20

```
git clone https://github.com/n-p-soft/coreboot-l420.git
cp -R coreboot-l420-master/src l420
```

* you need two external files to achieve the build:
  - me.bin: the Intel Management Engine binary blob
  - descriptor.bin: the blob describing the content of the ROM using 
     Intel Flash Descriptor format

  Put them into the folder "l420". You can extract them from an official Lenovo
  BIOS file using the tool "ifdtool" provided by coreboot in the "util/ifdtool"
  folder. The best way is to save the content of the BIOS of your motherboard
  using flashrom (see below for details) and to apply ifdtool on it:

```
make -C coreboot-4.20/util/ifdtool
flashrom -p your_programmer_type -r bios.sav
coreboot-4.20/util/ifdtool/ifdtool -x bios.sav
```

* cd into l420/coreboot-4.20, configure and build coreboot:

```
cd l420
make menuconfig
make
```

  Alternatively, you can use my configuration file:

```
cd l420
cp ../coreboot-l420-master/config ./.config
make
```

* on success, the file build/coreboot.rom will be the one to flash into the
  SPI chip of the motherboard, which should be a Winbond W25Q32 (do not
  confuse with the SPI chip for the embedded controller). It is located near
  the back-bottom of the motherboard. To flash the file, use an external
  programmer that can bring enough current to the motherboard, such as the
  CH341 one (the Minipro TL866 will not work). You also need the special clip
  that is plugged onto the chip (e.g. Pomona clip) and the soft "flashrom":

```
flashrom -p ch341a_spi -w build/coreboot.rom
```

### Notes for building coreboot

  The compiler used to build coreboot must be a x86 (not x86_64) one. So
there are two cases:

1. you are running a i386/i686 version of Linux: then you can use the
   native compiler presently in your distribution, provided that you also
   selected the option "use any toolchain" under the "general" menu of
   coreboot configuration. I used Microknoppix live DVD which works well.
   You may have to install extra packages such as bison, flex, ncurses,
   acpica.. For Knoppix, which is Debian-based:
```
sudo apt-get install ncurses-dev bison flex acpica-tools
sudo ln -s /usr/bin/python3 /usr/bin/python
```

2. you are running, for example, an x86-64 (amd64) Linux distribution:
   you will have to download an compile the coreboot cross-toolchain, or
   install one x86 cross-compiler (gcc).


### Supported hardware

  Read the file src/mainboard/lenovo/l420/status.txt to see which components
of the L420 are supported or not.

