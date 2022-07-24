import os.path
import platform
import shutil
import sys

systype = "x86"

if os.path.exists("auto_spy.so"):
    os.remove("auto_spy.so")

sysver = platform.uname()
print("sys info:" + str(sysver))
if "aarch64" in sysver:
    print("系统为 arm")
    shutil.copy("auto_spy.so_aarch64", "auto_spy.so")
    systype = "arm"
else:
    shutil.copy("auto_spy.so_x86_64", "auto_spy.so")
    systype = "x86"
try:
    from auto_spy import main
    print("系统为 x86")
except:
    os.remove("auto_spy.so")
    shutil.copy("auto_spy.so_x86_64_2", "auto_spy.so")
    print("系统为 x86_tx")
    systype = "x86_tx"
from auto_spy import main
main(systype)

