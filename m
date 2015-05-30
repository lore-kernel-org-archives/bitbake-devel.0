Return-Path: <raj.khem@gmail.com>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
	[209.85.223.180])
	by mail.openembedded.org (Postfix) with ESMTP id 7108F728CB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 May 2015 18:04:23 +0000 (UTC)
Received: by iesa3 with SMTP id a3so84022424ies.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 May 2015 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=Kx06+mKGoic5nXd77S7byxJccUtHD8wfLIJCQlQAZe4=;
	b=rKkqh7xBJcGNSeTkAH6phLHLB1KVYj/qF0Xjyj1m0r6P5JBLVG0Vt7tBnEsdJzyUOD
	aWDPScPEP5fwXof7ZD/tALdSIMU66jI4PjkndCwCkToWxEmju1hpbHQKZwe28NeESU+x
	BTJt5l1nHUq4B4Fct3CGjy8nf7Dq2mFzQZO3sisM2G9npXUPa8NQj+s58DRMRCFHLd5H
	erQsu4jpFqGkUjKrut6AUXIb5rn9UxwE5ETMAI0dBcRDH/z56DOMXOv+ZU0LpxfzBS2f
	SV+m4UrkQugcn01b0QIFXJBf1eXtvDOH/QGX7YYBvS6IYOO1tbBWHDNmQLyFTRV42bEz
	G1CQ==
X-Received: by 10.107.10.89 with SMTP id u86mr17117059ioi.79.1433009064885;
	Sat, 30 May 2015 11:04:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.166 with HTTP; Sat, 30 May 2015 11:03:54 -0700 (PDT)
In-Reply-To: <CADL-HDjoBQNJggwu=T9UuSYYOqTd2424Yzoppyb+vkn4=3=AUw@mail.gmail.com>
References: <CADL-HDjoBQNJggwu=T9UuSYYOqTd2424Yzoppyb+vkn4=3=AUw@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Sat, 30 May 2015 11:03:54 -0700
Message-ID: <CAMKF1soJX6+FdhhWVjYEVGqqQrS9OjQh3pJ7V0eB8ZBce6Ofog@mail.gmail.com>
To: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: gst-plugin-scan Tainted error
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 30 May 2015 18:04:24 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, May 29, 2015 at 7:37 PM, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:
> Hi,
>
> On a development board when I am trying to run "gst-inspect" command , I get
> this error:
>
> CPU: 0 PID: 2683 Comm: gst-plugin-scan Tainted: G      D    O 3.12.17 #1
>
> and kernel crash. Here is the log:
>

I dont think bitbake ml is right one for kernel crashes. You might
find more interest for it in kernel mailing lists

>
> ------------[ cut here ]------------
> +master/drivers/core/buffer_manager.c:2117!
> invalid opcode: 0000 [#18] PREEMPT SMP
> Modules linked in: alsa_shim(O) snd_usb_audio snd_usbmidi_lib snd_rawmidi
> snd_hwdep SiI9XXX(O) snd_seq_device snd_pcm snd_page_alloc snd_timer
> vidcap_ce4X00(O) snd avcap_shim(O) soundcore vidrend(O) vidpproc(O) remux(O)
> bufmon(O) audio(O) videnc(O) mux(O) viddec_v3(O) tsout(O) demux_v3(O)
> pvrsrvkm(O) ces_viddec_mux(O) ces_vidparse_videnc(O) ces_router(O)
> fw_manager(O) clock_recovery(O) pd_hdmi(O) pd_inttvenc_comp(O)
> pd_inttvenc_cvbs(O) gdl_server(O) gen_timer(O) clock(O) core(O)
> ioctl_module(O) mspod_drv(O) sec_kernel(O) pic_uart(O) intel_ce_pm(O)
> clock_control(O) idl_spi(O) idl_i2c(O) ce5xx_spi_slv i2c_pxa_pci
> spi_pxa2xx_platform i2c_pxa spi_pxa2xx_pci i2c_dev spidev idl_smartcard(O)
> iosf_wrap(O) pwm(O) idl_gpio_shim(O) gpio_sch intelce_gpio ce_flash(O)
> thermal(O) system_utils_linux(O) avcap_core(O) sven_linux(O)
> cosai_soc_utils(O) osal_linux(O) cosai_irqproxy(O) devmem(O)
> platform_config(O) pal_linux(O) idtsal_linux_driver(O)
> CPU: 0 PID: 2683 Comm: gst-plugin-scan Tainted: G      D    O 3.12.17 #1
> task: cc082d60 ti: caefe000 task.ti: caefe000
> EIP: 0060:[<d754b85a>] EFLAGS: 00010202 CPU: 0
> EIP is at buffer_manager_init+0x4ba/0x4e0 [core]
> EAX: 00000010 EBX: 00000006 ECX: 00000005 EDX: 00000035
> ESI: 00000000 EDI: bfe4ea8c EBP: cb912cc0 ESP: caeffce8
>  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> CR0: 8005003b CR2: b7157000 CR3: 0ac50000 CR4: 000007f0
> Stack:
>  d755c403 caeffd10 d7545008 00000004 d73da1d3 cc6fa4c0 00000001 cc6fa4c0
>  c1829440 00000000 b73bb35d cc65ad88 00000000 ffffffff c1829c84 c1829468
>  00000040 c10ab5c1 00000000 00000041 000033b5 cc7ca600 00000000 cc323c5c
> Call Trace:
>  [<d755c403>] ? core_init+0xd3/0x110 [core]
>  [<d7545008>] ? init_unmarshal+0x8/0x10 [core]
>  [<d73da1d3>] ? ioctl_driver_ioctl+0x63/0x100 [ioctl_module]
>  [<c10ab5c1>] ? get_page_from_freelist+0x2d1/0x5a0
>  [<c125d619>] ? __rb_insert_augmented+0x69/0x150
>  [<c10357c0>] ? compute_subtree_max_end+0x60/0x60
>  [<c1035a47>] ? rbt_memtype_check_insert+0x147/0x280
>  [<c103e326>] ? walk_system_ram_range+0xb6/0x1c0
>  [<c15e568d>] ? _raw_spin_unlock+0xd/0x30
>  [<c1034283>] ? reserve_memtype+0x143/0x440
>  [<c15e55ed>] ? _raw_spin_lock+0xd/0x30
>  [<c159f3c2>] ? rpcauth_lookup_credcache+0x152/0x1f0
>  [<c12294f0>] ? __devcgroup_check_permission+0x50/0x60
>  [<c108526e>] ? try_module_get+0x2e/0x70
>  [<c10e1a3d>] ? cdev_get+0x1d/0x40
>  [<c108526e>] ? try_module_get+0x2e/0x70
>  [<c10e1dd0>] ? chrdev_open+0x70/0x170
>  [<c10e1d60>] ? cdev_put+0x20/0x20
>  [<c10dc78a>] ? do_dentry_open.isra.17+0x17a/0x250
>  [<c15e55ed>] ? _raw_spin_lock+0xd/0x30
>  [<c15e568d>] ? _raw_spin_unlock+0xd/0x30
>  [<c1058c54>] ? lg_local_lock+0x14/0x40
>  [<c10f6d8f>] ? mntput_no_expire+0xf/0xf0
>  [<c1058c9c>] ? lg_local_unlock+0x1c/0x40
>  [<c10e9786>] ? do_last.isra.58+0x106/0xc70
>  [<c10e7b1c>] ? link_path_walk+0x1dc/0x780
>  [<c1273d00>] ? __percpu_counter_add+0x20/0xd0
>  [<c10e0000>] ? kill_block_super+0x50/0x60
>  [<c1058c54>] ? lg_local_lock+0x14/0x40
>  [<c10f6d8f>] ? mntput_no_expire+0xf/0xf0
>  [<c1058c9c>] ? lg_local_unlock+0x1c/0x40
>  [<c10ea408>] ? path_openat+0x118/0x590
>  [<c10eb397>] ? do_filp_open+0x27/0x70
>  [<d73da270>] ? ioctl_driver_ioctl+0x100/0x100 [ioctl_module]
>  [<d73da288>] ? unlocked_ioctl_driver+0x18/0x1d [ioctl_module]
>  [<c10ed3ab>] ? do_vfs_ioctl+0x30b/0x510
>  [<c10f5781>] ? __alloc_fd+0x81/0xf0
>  [<c10d4ec6>] ? kmem_cache_free+0x76/0x120
>  [<c10dd9c5>] ? do_sys_open+0x195/0x210
>  [<c10dd9c5>] ? do_sys_open+0x195/0x210
>  [<c10ed5ef>] ? SyS_ioctl+0x3f/0x70
>  [<c15e5d99>] ? syscall_call+0x7/0xb
> Code: 00 00 00 31 c0 be 04 00 00 00 c7 44 24 08 00 00 00 00 c7 44 24 04 00
> 00 00 00 c7 04 24 00 00 00 00 e8 4b 09 01 00 e9 17 fe ff ff <0f> 0b c7 44 24
> 04 64 08 00 00 be 04 00 00 00 c7 04 24 e4 9b 56
> EIP: [<d754b85a>] buffer_manager_init+0x4ba/0x4e0 [core] SS:ESP
> 0068:caeffce8
> ---[ end trace c2b6b44ea4c8134e ]---
>
>
> I am using yocto 1.6 in my project and I have added "gstreamer" and
> "gst-base-plugin" packages to the packagegroup so these two packages are
> going to rootfs.
>
> I had to write a bbappend file with following line to install
> gst-base-plugin libs to rootfs:
>
> "FILES_${PN} += " ${libdir}/gstreamer-0.10/*.so""
>
> Can somebody please provide some pointer to me to debug this issue further?
>
> Thanks,
> Yogesh
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

