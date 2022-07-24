del auto_spy.so_x86_64
del auto_spy.so_aarch64
del auto_spy.so_x86_64_2
copy .\plugins\x86\auto_spy.cpython-38-x86_64-linux-gnu.so auto_spy.so_x86_64
copy .\plugins\arm\auto_spy.cpython-36m-aarch64-linux-gnu.so auto_spy.so_aarch64
copy .\plugins\x86_tx\auto_spy.cpython-36m-x86_64-linux-gnu.so auto_spy.so_x86_64_2
del .\plugins\x86\auto_spy.cpython-38-x86_64-linux-gnu.so
del .\plugins\arm\auto_spy.cpython-36m-aarch64-linux-gnu.so
del .\plugins\x86_tx\auto_spy.cpython-36m-x86_64-linux-gnu.so
