KERNEL_MODULES=$(lspci -v | grep -i ethernet -A 11 | grep -E 'Kernel modules' | sed -n 's/.*Kernel modules: //p')


sed -i "s/kernelModules = \"[^\"]*\"/kernelModules = \"$KERNEL_MODULES/" file
                                                                                               
                                                                                               
                                                                                               

