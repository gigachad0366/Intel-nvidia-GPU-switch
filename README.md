A one click bash script for GPU switch on linux laptops with hybrid graphics, it checks for power source and the GPU in use to decide if you should switch or not.

It requires ```nvidia-prime``` to be installed (it is automatically installed with the nvidia driver), if not, install it by running ```sudo apt install nvidia-prime```.

1.Download ```wget https://raw.githubusercontent.com/gigachad0366/Intel-nvidia-GPU-switch/refs/heads/main/GPUswitch.sh```
2.Give the file permission to execute ```chmod +x GPUswitch.sh```
3.Run ```./GPUswitch.sh```

Why would you need to switch to intel GPU ? it significantly increases battery life by completely turning off the nvidia driver, and i found it useful for compatibility on some apps.
