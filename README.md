```
The executable that PyInstaller builds is not fully static, in that it still
depends on the system libc. Under Linux, the ABI of GLIBC is backward
compatible, but not forward compatible. So if you link against a newer GLIBC,
you can't run the resulting executable on an older system. The supplied binary
bootloader should work with older GLIBC. However, the libpython.so and other
dynamic libraries still depends on the newer GLIBC. The solution is to compile
the Python interpreter with its modules (and also probably bootloader) on the
oldest system you have around, so that it gets linked with the oldest version
of GLIBC.
```
