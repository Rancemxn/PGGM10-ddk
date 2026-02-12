MODULE_NAME := kernelsu

# 检查 DDK 环境
ifeq ($(KDIR),)
    $(error Error: KDIR is not set. This Makefile is for DDK build environment.)
endif

# KernelSU 源码路径
KSU_DIR := KernelSU

# 编译参数：开启 LKM 模式，忽略部分警告
ccflags-y += -Wno-declaration-after-statement
ccflags-y += -Wno-unused-variable
ccflags-y += -Wno-int-conversion
ccflags-y += -Wno-unused-result
ccflags-y += -Wno-unused-function
ccflags-y += -Wno-builtin-macro-redefined -U__FILE__ -D__FILE__='""'
ccflags-y += -DCONFIG_KSU_LKM=1 -Wno-implicit-function-declaration -Wno-strict-prototypes
ccflags-y += -I$(src)/$(KSU_DIR)/kernel -I$(src)/$(KSU_DIR)/include

# 定义编译目标
obj-m += $(MODULE_NAME).o

# 列出 KernelSU 的所有源文件
$(MODULE_NAME)-y := \
    $(KSU_DIR)/kernel/allowlist.o \
    $(KSU_DIR)/kernel/apk_sign.o \
    $(KSU_DIR)/kernel/app_profile.o \
    $(KSU_DIR)/kernel/avc.o \
    $(KSU_DIR)/kernel/binder_hook.o \
    $(KSU_DIR)/kernel/core_hook.o \
    $(KSU_DIR)/kernel/fsutils.o \
    $(KSU_DIR)/kernel/ksu.o \
    $(KSU_DIR)/kernel/ksu_lkm.o \
    $(KSU_DIR)/kernel/module.o \
    $(KSU_DIR)/kernel/mount_handler.o \
    $(KSU_DIR)/kernel/perf.o \
    $(KSU_DIR)/kernel/profile.o \
    $(KSU_DIR)/kernel/selinux/rules.o \
    $(KSU_DIR)/kernel/selinux/sepolicy.o \
    $(KSU_DIR)/kernel/su.o \
    $(KSU_DIR)/kernel/sucompat.o \
    $(KSU_DIR)/kernel/throne.o \
    $(KSU_DIR)/kernel/uid_observer.o \
    $(KSU_DIR)/kernel/manager.o

# 如果后续编译报错提示缺文件，可能需要根据 KernelSU 版本增减上面的列表