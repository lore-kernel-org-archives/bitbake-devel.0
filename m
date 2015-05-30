Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
	[209.85.214.180])
	by mail.openembedded.org (Postfix) with ESMTP id 2ABA27066B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 May 2015 02:38:11 +0000 (UTC)
Received: by obbea2 with SMTP id ea2so70411187obb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 May 2015 19:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=VWpVqAbuXk88sJzpv7CM/SDY7R1Nu96fYkZQnOkkbnk=;
	b=WynN5CsVLFwJ9TYdxbElpa4KpJ5ySwmjVlRg7WpheGHPKERrszyx7Elip+mnjRj868
	Zdp/oIXVOpHlEtcQNGcpzROZZ58/+rd+HWww+m/U/KQcV53VQBfABrTMBM00dhaDNsqI
	tN+HtGJGeyrWcb8u5Z7GTF8mp77FTZnufycdT55DFOieX+wCDGEGQLOpP1Ty5c0wb/YQ
	tybiDD9uO1JypLNRnqpbY+zkmJCxmgNiBsfeD9ngF+Qhs1r5air+wak/XWTUl9IM+iMN
	xLTRc79vkRBTs1ZjV2OsdkCB/oqBcQsv2MMtJCkOq9FiLQKmjRSCNvrKTgSbsK+NxyNr
	g6Cw==
X-Received: by 10.202.174.67 with SMTP id x64mr8912371oie.50.1432953492387;
	Fri, 29 May 2015 19:38:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Fri, 29 May 2015 19:37:52 -0700 (PDT)
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Sat, 30 May 2015 08:07:52 +0530
Message-ID: <CADL-HDjoBQNJggwu=T9UuSYYOqTd2424Yzoppyb+vkn4=3=AUw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: gst-plugin-scan Tainted error
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
X-List-Received-Date: Sat, 30 May 2015 02:38:14 -0000
Content-Type: multipart/alternative; boundary=001a113cefa4e4bfa90517437b7c

--001a113cefa4e4bfa90517437b7c
Content-Type: text/plain; charset=UTF-8

Hi,

On a development board when I am trying to run "gst-inspect" command , I
get this error:

CPU: 0 PID: 2683 Comm: gst-plugin-scan Tainted: G      D    O 3.12.17 #1

and kernel crash. Here is the log:


------------[ cut here ]------------
+master/drivers/core/buffer_manager.c:2117!
invalid opcode: 0000 [#18] PREEMPT SMP
Modules linked in: alsa_shim(O) snd_usb_audio snd_usbmidi_lib snd_rawmidi
snd_hwdep SiI9XXX(O) snd_seq_device snd_pcm snd_page_alloc snd_timer
vidcap_ce4X00(O) snd avcap_shim(O) soundcore vidrend(O) vidpproc(O)
remux(O) bufmon(O) audio(O) videnc(O) mux(O) viddec_v3(O) tsout(O)
demux_v3(O) pvrsrvkm(O) ces_viddec_mux(O) ces_vidparse_videnc(O)
ces_router(O) fw_manager(O) clock_recovery(O) pd_hdmi(O)
pd_inttvenc_comp(O) pd_inttvenc_cvbs(O) gdl_server(O) gen_timer(O) clock(O)
core(O) ioctl_module(O) mspod_drv(O) sec_kernel(O) pic_uart(O)
intel_ce_pm(O) clock_control(O) idl_spi(O) idl_i2c(O) ce5xx_spi_slv
i2c_pxa_pci spi_pxa2xx_platform i2c_pxa spi_pxa2xx_pci i2c_dev spidev
idl_smartcard(O) iosf_wrap(O) pwm(O) idl_gpio_shim(O) gpio_sch intelce_gpio
ce_flash(O) thermal(O) system_utils_linux(O) avcap_core(O) sven_linux(O)
cosai_soc_utils(O) osal_linux(O) cosai_irqproxy(O) devmem(O)
platform_config(O) pal_linux(O) idtsal_linux_driver(O)
CPU: 0 PID: 2683 Comm: gst-plugin-scan Tainted: G      D    O 3.12.17 #1
task: cc082d60 ti: caefe000 task.ti: caefe000
EIP: 0060:[<d754b85a>] EFLAGS: 00010202 CPU: 0
EIP is at buffer_manager_init+0x4ba/0x4e0 [core]
EAX: 00000010 EBX: 00000006 ECX: 00000005 EDX: 00000035
ESI: 00000000 EDI: bfe4ea8c EBP: cb912cc0 ESP: caeffce8
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
CR0: 8005003b CR2: b7157000 CR3: 0ac50000 CR4: 000007f0
Stack:
 d755c403 caeffd10 d7545008 00000004 d73da1d3 cc6fa4c0 00000001 cc6fa4c0
 c1829440 00000000 b73bb35d cc65ad88 00000000 ffffffff c1829c84 c1829468
 00000040 c10ab5c1 00000000 00000041 000033b5 cc7ca600 00000000 cc323c5c
Call Trace:
 [<d755c403>] ? core_init+0xd3/0x110 [core]
 [<d7545008>] ? init_unmarshal+0x8/0x10 [core]
 [<d73da1d3>] ? ioctl_driver_ioctl+0x63/0x100 [ioctl_module]
 [<c10ab5c1>] ? get_page_from_freelist+0x2d1/0x5a0
 [<c125d619>] ? __rb_insert_augmented+0x69/0x150
 [<c10357c0>] ? compute_subtree_max_end+0x60/0x60
 [<c1035a47>] ? rbt_memtype_check_insert+0x147/0x280
 [<c103e326>] ? walk_system_ram_range+0xb6/0x1c0
 [<c15e568d>] ? _raw_spin_unlock+0xd/0x30
 [<c1034283>] ? reserve_memtype+0x143/0x440
 [<c15e55ed>] ? _raw_spin_lock+0xd/0x30
 [<c159f3c2>] ? rpcauth_lookup_credcache+0x152/0x1f0
 [<c12294f0>] ? __devcgroup_check_permission+0x50/0x60
 [<c108526e>] ? try_module_get+0x2e/0x70
 [<c10e1a3d>] ? cdev_get+0x1d/0x40
 [<c108526e>] ? try_module_get+0x2e/0x70
 [<c10e1dd0>] ? chrdev_open+0x70/0x170
 [<c10e1d60>] ? cdev_put+0x20/0x20
 [<c10dc78a>] ? do_dentry_open.isra.17+0x17a/0x250
 [<c15e55ed>] ? _raw_spin_lock+0xd/0x30
 [<c15e568d>] ? _raw_spin_unlock+0xd/0x30
 [<c1058c54>] ? lg_local_lock+0x14/0x40
 [<c10f6d8f>] ? mntput_no_expire+0xf/0xf0
 [<c1058c9c>] ? lg_local_unlock+0x1c/0x40
 [<c10e9786>] ? do_last.isra.58+0x106/0xc70
 [<c10e7b1c>] ? link_path_walk+0x1dc/0x780
 [<c1273d00>] ? __percpu_counter_add+0x20/0xd0
 [<c10e0000>] ? kill_block_super+0x50/0x60
 [<c1058c54>] ? lg_local_lock+0x14/0x40
 [<c10f6d8f>] ? mntput_no_expire+0xf/0xf0
 [<c1058c9c>] ? lg_local_unlock+0x1c/0x40
 [<c10ea408>] ? path_openat+0x118/0x590
 [<c10eb397>] ? do_filp_open+0x27/0x70
 [<d73da270>] ? ioctl_driver_ioctl+0x100/0x100 [ioctl_module]
 [<d73da288>] ? unlocked_ioctl_driver+0x18/0x1d [ioctl_module]
 [<c10ed3ab>] ? do_vfs_ioctl+0x30b/0x510
 [<c10f5781>] ? __alloc_fd+0x81/0xf0
 [<c10d4ec6>] ? kmem_cache_free+0x76/0x120
 [<c10dd9c5>] ? do_sys_open+0x195/0x210
 [<c10dd9c5>] ? do_sys_open+0x195/0x210
 [<c10ed5ef>] ? SyS_ioctl+0x3f/0x70
 [<c15e5d99>] ? syscall_call+0x7/0xb
Code: 00 00 00 31 c0 be 04 00 00 00 c7 44 24 08 00 00 00 00 c7 44 24 04 00
00 00 00 c7 04 24 00 00 00 00 e8 4b 09 01 00 e9 17 fe ff ff <0f> 0b c7 44
24 04 64 08 00 00 be 04 00 00 00 c7 04 24 e4 9b 56
EIP: [<d754b85a>] buffer_manager_init+0x4ba/0x4e0 [core] SS:ESP
0068:caeffce8
---[ end trace c2b6b44ea4c8134e ]---


I am using yocto 1.6 in my project and I have added "gstreamer" and
"gst-base-plugin" packages to the packagegroup so these two packages are
going to rootfs.

I had to write a bbappend file with following line to install
gst-base-plugin libs to rootfs:

"FILES_${PN} += " ${libdir}/gstreamer-0.10/*.so""

Can somebody please provide some pointer to me to debug this issue further?

Thanks,
Yogesh

--001a113cefa4e4bfa90517437b7c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8000001907349px">Hi,</span><di=
v style=3D"font-size:12.8000001907349px"><br></div><div style=3D"font-size:=
12.8000001907349px">On a development board when I am trying to run &quot;gs=
t-inspect&quot; command , I get this error:</div><div style=3D"font-size:12=
.8000001907349px"><br></div><div style=3D"font-size:12.8000001907349px">CPU=
: 0 PID: 2683 Comm: gst-plugin-scan Tainted: G =C2=A0 =C2=A0 =C2=A0D =C2=A0=
 =C2=A0O 3.12.17 #1<br></div><div style=3D"font-size:12.8000001907349px"><b=
r></div><div style=3D"font-size:12.8000001907349px">and kernel crash. Here =
is the log:</div><div style=3D"font-size:12.8000001907349px"><br></div><div=
 style=3D"font-size:12.8000001907349px"><div><br></div><div>------------[ c=
ut here ]------------<br></div><div>+master/drivers/core/buffer_manager.c:2=
117!</div><div>invalid opcode: 0000 [#18] PREEMPT SMP=C2=A0</div><div>Modul=
es linked in: alsa_shim(O) snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_hw=
dep SiI9XXX(O) snd_seq_device snd_pcm snd_page_alloc snd_timer vidcap_ce4X0=
0(O) snd avcap_shim(O) soundcore vidrend(O) vidpproc(O) remux(O) bufmon(O) =
audio(O) videnc(O) mux(O) viddec_v3(O) tsout(O) demux_v3(O) pvrsrvkm(O) ces=
_viddec_mux(O) ces_vidparse_videnc(O) ces_router(O) fw_manager(O) clock_rec=
overy(O) pd_hdmi(O) pd_inttvenc_comp(O) pd_inttvenc_cvbs(O) gdl_server(O) g=
en_timer(O) clock(O) core(O) ioctl_module(O) mspod_drv(O) sec_kernel(O) pic=
_uart(O) intel_ce_pm(O) clock_control(O) idl_spi(O) idl_i2c(O) ce5xx_spi_sl=
v i2c_pxa_pci spi_pxa2xx_platform i2c_pxa spi_pxa2xx_pci i2c_dev spidev idl=
_smartcard(O) iosf_wrap(O) pwm(O) idl_gpio_shim(O) gpio_sch intelce_gpio ce=
_flash(O) thermal(O) system_utils_linux(O) avcap_core(O) sven_linux(O) cosa=
i_soc_utils(O) osal_linux(O) cosai_irqproxy(O) devmem(O) platform_config(O)=
 pal_linux(O) idtsal_linux_driver(O)</div><div>CPU: 0 PID: 2683 Comm: gst-p=
lugin-scan Tainted: G =C2=A0 =C2=A0 =C2=A0D =C2=A0 =C2=A0O 3.12.17 #1</div>=
<div>task: cc082d60 ti: caefe000 task.ti: caefe000</div><div>EIP: 0060:[&lt=
;d754b85a&gt;] EFLAGS: 00010202 CPU: 0</div><div>EIP is at buffer_manager_i=
nit+0x4ba/0x4e0 [core]</div><div>EAX: 00000010 EBX: 00000006 ECX: 00000005 =
EDX: 00000035</div><div>ESI: 00000000 EDI: bfe4ea8c EBP: cb912cc0 ESP: caef=
fce8</div><div>=C2=A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068</div><div=
>CR0: 8005003b CR2: b7157000 CR3: 0ac50000 CR4: 000007f0</div><div>Stack:</=
div><div>=C2=A0d755c403 caeffd10 d7545008 00000004 d73da1d3 cc6fa4c0 000000=
01 cc6fa4c0</div><div>=C2=A0c1829440 00000000 b73bb35d cc65ad88 00000000 ff=
ffffff c1829c84 c1829468</div><div>=C2=A000000040 c10ab5c1 00000000 0000004=
1 000033b5 cc7ca600 00000000 cc323c5c</div><div>Call Trace:</div><div>=C2=
=A0[&lt;d755c403&gt;] ? core_init+0xd3/0x110 [core]</div><div>=C2=A0[&lt;d7=
545008&gt;] ? init_unmarshal+0x8/0x10 [core]</div><div>=C2=A0[&lt;d73da1d3&=
gt;] ? ioctl_driver_ioctl+0x63/0x100 [ioctl_module]</div><div>=C2=A0[&lt;c1=
0ab5c1&gt;] ? get_page_from_freelist+0x2d1/0x5a0</div><div>=C2=A0[&lt;c125d=
619&gt;] ? __rb_insert_augmented+0x69/0x150</div><div>=C2=A0[&lt;c10357c0&g=
t;] ? compute_subtree_max_end+0x60/0x60</div><div>=C2=A0[&lt;c1035a47&gt;] =
? rbt_memtype_check_insert+0x147/0x280</div><div>=C2=A0[&lt;c103e326&gt;] ?=
 walk_system_ram_range+0xb6/0x1c0</div><div>=C2=A0[&lt;c15e568d&gt;] ? _raw=
_spin_unlock+0xd/0x30</div><div>=C2=A0[&lt;c1034283&gt;] ? reserve_memtype+=
0x143/0x440</div><div>=C2=A0[&lt;c15e55ed&gt;] ? _raw_spin_lock+0xd/0x30</d=
iv><div>=C2=A0[&lt;c159f3c2&gt;] ? rpcauth_lookup_credcache+0x152/0x1f0</di=
v><div>=C2=A0[&lt;c12294f0&gt;] ? __devcgroup_check_permission+0x50/0x60</d=
iv><div>=C2=A0[&lt;c108526e&gt;] ? try_module_get+0x2e/0x70</div><div>=C2=
=A0[&lt;c10e1a3d&gt;] ? cdev_get+0x1d/0x40</div><div>=C2=A0[&lt;c108526e&gt=
;] ? try_module_get+0x2e/0x70</div><div>=C2=A0[&lt;c10e1dd0&gt;] ? chrdev_o=
pen+0x70/0x170</div><div>=C2=A0[&lt;c10e1d60&gt;] ? cdev_put+0x20/0x20</div=
><div>=C2=A0[&lt;c10dc78a&gt;] ? do_dentry_open.isra.17+0x17a/0x250</div><d=
iv>=C2=A0[&lt;c15e55ed&gt;] ? _raw_spin_lock+0xd/0x30</div><div>=C2=A0[&lt;=
c15e568d&gt;] ? _raw_spin_unlock+0xd/0x30</div><div>=C2=A0[&lt;c1058c54&gt;=
] ? lg_local_lock+0x14/0x40</div><div>=C2=A0[&lt;c10f6d8f&gt;] ? mntput_no_=
expire+0xf/0xf0</div><div>=C2=A0[&lt;c1058c9c&gt;] ? lg_local_unlock+0x1c/0=
x40</div><div>=C2=A0[&lt;c10e9786&gt;] ? do_last.isra.58+0x106/0xc70</div><=
div>=C2=A0[&lt;c10e7b1c&gt;] ? link_path_walk+0x1dc/0x780</div><div>=C2=A0[=
&lt;c1273d00&gt;] ? __percpu_counter_add+0x20/0xd0</div><div>=C2=A0[&lt;c10=
e0000&gt;] ? kill_block_super+0x50/0x60</div><div>=C2=A0[&lt;c1058c54&gt;] =
? lg_local_lock+0x14/0x40</div><div>=C2=A0[&lt;c10f6d8f&gt;] ? mntput_no_ex=
pire+0xf/0xf0</div><div>=C2=A0[&lt;c1058c9c&gt;] ? lg_local_unlock+0x1c/0x4=
0</div><div>=C2=A0[&lt;c10ea408&gt;] ? path_openat+0x118/0x590</div><div>=
=C2=A0[&lt;c10eb397&gt;] ? do_filp_open+0x27/0x70</div><div>=C2=A0[&lt;d73d=
a270&gt;] ? ioctl_driver_ioctl+0x100/0x100 [ioctl_module]</div><div>=C2=A0[=
&lt;d73da288&gt;] ? unlocked_ioctl_driver+0x18/0x1d [ioctl_module]</div><di=
v>=C2=A0[&lt;c10ed3ab&gt;] ? do_vfs_ioctl+0x30b/0x510</div><div>=C2=A0[&lt;=
c10f5781&gt;] ? __alloc_fd+0x81/0xf0</div><div>=C2=A0[&lt;c10d4ec6&gt;] ? k=
mem_cache_free+0x76/0x120</div><div>=C2=A0[&lt;c10dd9c5&gt;] ? do_sys_open+=
0x195/0x210</div><div>=C2=A0[&lt;c10dd9c5&gt;] ? do_sys_open+0x195/0x210</d=
iv><div>=C2=A0[&lt;c10ed5ef&gt;] ? SyS_ioctl+0x3f/0x70</div><div>=C2=A0[&lt=
;c15e5d99&gt;] ? syscall_call+0x7/0xb</div><div>Code: 00 00 00 31 c0 be 04 =
00 00 00 c7 44 24 08 00 00 00 00 c7 44 24 04 00 00 00 00 c7 04 24 00 00 00 =
00 e8 4b 09 01 00 e9 17 fe ff ff &lt;0f&gt; 0b c7 44 24 04 64 08 00 00 be 0=
4 00 00 00 c7 04 24 e4 9b 56</div><div>EIP: [&lt;d754b85a&gt;] buffer_manag=
er_init+0x4ba/0x4e0 [core] SS:ESP 0068:caeffce8</div><div>---[ end trace c2=
b6b44ea4c8134e ]---</div></div><div style=3D"font-size:12.8000001907349px">=
<br></div><div style=3D"font-size:12.8000001907349px"><br></div><div style=
=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.8000001907349=
px">I am using yocto 1.6 in my project and I have added &quot;gstreamer&quo=
t; and &quot;gst-base-plugin&quot; packages to the packagegroup so these tw=
o packages are going to rootfs.</span></div><div style=3D"font-size:12.8000=
001907349px"><span style=3D"font-size:12.8000001907349px"><br></span></div>=
<div style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.800=
0001907349px">I had to write a bbappend file with following line to install=
 gst-base-plugin libs to rootfs:</span></div><div style=3D"font-size:12.800=
0001907349px"><span style=3D"font-size:12.8000001907349px"><br></span></div=
><div style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.80=
00001907349px">&quot;</span><span style=3D"font-size:12.8000001907349px">FI=
LES_${PN} +=3D &quot; ${libdir}/gstreamer-0.10/*.so&quot;&quot;</span></div=
><div style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.80=
00001907349px"><br></span></div><div style=3D"font-size:12.8000001907349px"=
><span style=3D"font-size:12.8000001907349px">Can somebody please provide s=
ome pointer to me to debug this issue further?</span></div><div style=3D"fo=
nt-size:12.8000001907349px"><br></div><div style=3D"font-size:12.8000001907=
349px">Thanks,</div><div style=3D"font-size:12.8000001907349px">Yogesh=C2=
=A0</div></div>

--001a113cefa4e4bfa90517437b7c--
