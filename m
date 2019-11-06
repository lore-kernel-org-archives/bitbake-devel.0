Return-Path: <waynli329@gmail.com>
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
	[209.85.208.182])
	by mail.openembedded.org (Postfix) with ESMTP id BA6457F821
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Nov 2019 16:28:50 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id l20so8159146lje.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Nov 2019 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=gmpb9jaE0x/H9Ur6GdoFTWLej/z04IfCzKw/EuukeSY=;
	b=STswLMy7NBuoTfS5WZHGtUokWbSyVUGOgBZMn0YhLxfzatQi7xxWr905y34eyohxJI
	t8g5PirH+C8sAgqu7GI3oh4i/qMNGci9PnACy/BomkrGccG2G0Vyd94s6KMNIK5Zh+Mr
	g/KXKrNmv5DUao3JeCaBYsJBXucyOhUasfRhzyrzjTmsObrhftIR/fbyN5Oi2DAIeyP8
	dJl1uxjCv1xYuuAjQjoDh3tPV2XLOBnMUJZYqzjv3HA7LGpt7aJUZutId5kdU+GLLV+v
	xBit+PbdKEnbF3Iw6+7cfqypGJQVXML2TWncuqI1SUfncemR0w17Shgji+z0mJXSbeKK
	ox/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=gmpb9jaE0x/H9Ur6GdoFTWLej/z04IfCzKw/EuukeSY=;
	b=YnlH7u1JUqQCtDXOhllShmTyBvqfL9RB32HlpTl7V4D0r4SAW3zfkLeCfj7cXPDLvB
	QwsVhmlhOqf8u2qLhKJIfgYPFFOrUgWQkl5YUOurNyJm4ELMoS9ZgOu4Gx9agqoufoDH
	8IODyJazHo1oF5YgEj2dNA9gvsiTu/gr6ZDvvlWSqBiDXViQS3wxmQpbRyd4pwRTFudH
	IA5oZ67mjcOGTrSZMECHL/oo6pn7ThT1N9mMG5GgcHbnwC2qLaoXScMdZwBlLau/pDaJ
	de1Er0NDagLh9dk1FeEPe/JmENep7//cBNE0UrYxZUb4NrbGCkZseGP3NDHHxPlr3cWN
	EV/A==
X-Gm-Message-State: APjAAAXHfYQ8dwZYc7dAUFqERd1oCrYLKezaCkDkDsgjPcll8Wv9CyXy
	Yo+3uC1z8isGuV+/HJ0qb8Kwqtp51iT/eaSnLb0dd3fp
X-Google-Smtp-Source: APXvYqxhDdXFbtBurmF78hpLlRg56h+QAA1ZB+mluc/0OTJy2eXuMArOOVoo4DV8iTLJJzRTQJq3gcy6ZL21rWCjLGE=
X-Received: by 2002:a2e:93d7:: with SMTP id p23mr2670928ljh.102.1573057730400; 
	Wed, 06 Nov 2019 08:28:50 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 6 Nov 2019 10:28:38 -0600
Message-ID: <CAM2K0np6XuF7kQfzr8guexucFNqWMg=CY5sAL+LS7BTWTStaUg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org, yocto@yoctoproject.org
Subject: Adding KVM kernel modules to Yocto Kernel
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
X-List-Received-Date: Wed, 06 Nov 2019 16:28:51 -0000
Content-Type: multipart/alternative; boundary="0000000000003b55d20596b00b16"

--0000000000003b55d20596b00b16
Content-Type: text/plain; charset="UTF-8"

Dear Yocto Developers,

I'm trying to get KVM added and working on a Yocto kernel I built up for a
T4240 RDB (has a PowerPC CPU).  KVM isn't working and the reason why it
isn't working seems to be I'm missing the necessary kernel modules.  More
specifically, I don't seem to have a kvm.ko file that I can load.  Here's
how I attempted to add KVM to the kernel.

I went to the SDK install folder and ran ". fsl-setup-env -m t4240rdb-64b"
and then "bitbake virtual/kernel -c menuconfig".  After the GUI comes up, I
went to Virtualization -> KVM support for PowerPC E500MC/E5500/E6500
processors and hit "Save" to save the configuration.  I then went and
copied the content of the .config file created by this into the kernel
configuration file specified by the following path;
"build_t4240rdb-64b/virt1.config".  This path was specified by the variable
KERNEL_DEFCONFIG in sources/meta_freescale/conf/machine/t4240rdb-64b.conf.
Here's what I currently have in the kernel configuration file (i.e. the
virt1.config file I mentioned above):

https://gist.github.com/WayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1

After this, I built the kernel by running "bitbake -c compile -f
virtual/kernel" and rebuilt the full linux image.  I re-added everything to
the SD card and booted up the T4240 RDB with the newly modified Yocto
kernel.  At this point if I run lsmod, only the following two kernel
modules show up:

Module                  Size  Used by
nfsd                  100940  11
exportfs                6723  1 nfsd

But if I do a "find . -name "kvm"" I get the following:

./usr/src/kernel/Documentation/virtual/kvm
./usr/src/kernel/arch/arm/kvm
./usr/src/kernel/arch/arm64/kvm
./usr/src/kernel/arch/mips/kvm
./usr/src/kernel/arch/powerpc/kvm
./usr/src/kernel/arch/s390/kvm
./usr/src/kernel/arch/tile/kvm
./usr/src/kernel/arch/x86/kvm
./usr/src/kernel/drivers/s390/kvm
./usr/src/kernel/include/config/kvm
./usr/src/kernel/include/config/have/kvm
./usr/src/kernel/include/kvm
./usr/src/kernel/virt/kvm
./dev/kvm
./sys/devices/virtual/misc/kvm
./sys/class/misc/kvm
./sys/kernel/debug/kvm
./sys/module/kvm

So it does look like kvm-related files were added to the Yocto kernel
because of the changes I made to the kernel configuration file.  But there
is no kvm.ko (or any .ko file related to kvm) anywhere in the file system.

Is there something I'm doing wrong here?  Am I missing important lines in
my kernel configuration file?  Let me know your thoughts.

-Thanks!, Wayne Li

--0000000000003b55d20596b00b16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear Yocto Developers,</div><div><br></div><div>I&#39=
;m trying to get KVM added and working on a Yocto kernel I built up for a T=
4240 RDB (has a PowerPC CPU).=C2=A0 KVM isn&#39;t working and the reason wh=
y it isn&#39;t working seems to be I&#39;m missing the necessary kernel mod=
ules.=C2=A0 More specifically, I don&#39;t seem to have a kvm.ko file that =
I can load.=C2=A0 Here&#39;s how I attempted to add KVM to the kernel.</div=
><div><br></div><div>I went to the SDK install folder and ran &quot;. fsl-s=
etup-env -m t4240rdb-64b&quot; and then &quot;bitbake virtual/kernel -c men=
uconfig&quot;.=C2=A0 After the GUI comes up, I went to Virtualization -&gt;=
 KVM support for PowerPC E500MC/E5500/E6500 processors and hit &quot;Save&q=
uot; to save the configuration.=C2=A0 I then went and copied the content of=
 the .config file created by this into the kernel configuration file specif=
ied by the following path; &quot;build_t4240rdb-64b/virt1.config&quot;.=C2=
=A0 This path was specified by the variable KERNEL_DEFCONFIG in sources/met=
a_freescale/conf/machine/t4240rdb-64b.conf.=C2=A0 Here&#39;s what I current=
ly have in the kernel configuration file (i.e. the virt1.config file I ment=
ioned above):</div><div><br></div><div><a href=3D"https://gist.github.com/W=
ayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1" target=3D"_blank">https://gist=
.github.com/WayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1</a></div><div><br>=
</div><div>After this, I built the kernel by running &quot;bitbake -c compi=
le -f virtual/kernel&quot; and rebuilt the full linux image.=C2=A0 I re-add=
ed everything to the SD card and booted up the T4240 RDB with the newly mod=
ified Yocto kernel.=C2=A0 At this point if I run lsmod, only the following =
two kernel modules show up:</div><div><br>Module =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Size =C2=A0Used by<br>nfsd =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0100940 =C2=A011<br>expo=
rtfs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06723 =C2=A01 nf=
sd</div><div><br></div><div>But if I do a=20
&quot;find . -name &quot;kvm&quot;&quot; I get the following: <br></div><di=
v><br></div><div>
<div>./usr/src/kernel/Documentation/virtual/kvm<br>./usr/src/kernel/arch/ar=
m/kvm<br>./usr/src/kernel/arch/arm64/kvm<br>./usr/src/kernel/arch/mips/kvm<=
br>./usr/src/kernel/arch/powerpc/kvm<br>./usr/src/kernel/arch/s390/kvm<br>.=
/usr/src/kernel/arch/tile/kvm<br>./usr/src/kernel/arch/x86/kvm<br>./usr/src=
/kernel/drivers/s390/kvm<br>./usr/src/kernel/include/config/kvm<br>./usr/sr=
c/kernel/include/config/have/kvm<br>./usr/src/kernel/include/kvm<br>./usr/s=
rc/kernel/virt/kvm<br>./dev/kvm</div><div>./sys/devices/virtual/misc/kvm<br=
>./sys/class/misc/kvm<br>./sys/kernel/debug/kvm<br>./sys/module/kvm</div><d=
iv><br></div><div>So it does look like kvm-related files were added to the =
Yocto kernel because of the changes I made to the kernel configuration file=
.=C2=A0 But there is no kvm.ko (or any .ko file related to kvm) anywhere in=
 the file system.</div><div><br></div><div>Is there something I&#39;m doing=
 wrong here?=C2=A0 Am I missing important lines in my kernel configuration =
file?=C2=A0 Let me know your thoughts.</div><div><br></div><div>-Thanks!, W=
ayne Li<br></div>

</div></div>

--0000000000003b55d20596b00b16--
