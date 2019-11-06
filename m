Return-Path: <bruce.ashfield@gmail.com>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by mail.openembedded.org (Postfix) with ESMTP id C0F157F849
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Nov 2019 21:22:45 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id l25so59869edt.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Nov 2019 13:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=sDGxhfGb88xvNGaFhhYtUqZ9/AYKvhxQIRdUgRMki6M=;
	b=jq+b6/ItgxufWg0yDCIuPmphFAIt5YhGzrNyOA9jqxqyYAez/zlwuIsBCcJRIrq+OB
	gYDbcYD+rTrqFOCKeocD1a+OSduQRzhrddfeWUYY3dYDRbi1V7JBX9VwkDlFbusMV5HW
	ZLjgbOOA2eO3uDDUqWI1E5yv4CCQye7vBj0f2X3Mr05YuXg0XGA4GEJe19jL1GeYxoDu
	qawZM6Ua6HCqrtPPosNceVikeBMaEABImix0C7a64kgmWG01z12E+f41u/eAr6QRw3pM
	S6hpDN6zfoSFnTFQo84uMFGgqPIyhxKbuTF1R6ZNk/nWFKAMm874HlPIVMhbhFJ7+tQI
	QlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=sDGxhfGb88xvNGaFhhYtUqZ9/AYKvhxQIRdUgRMki6M=;
	b=VT/RyscdmQJVc4GKlPahrqdfzbM2FlPE9Ruoy1wrJOikCbAc6rtepSfErA7bVdg9pA
	NEhW/qzV4mYIisvd1NZ9Kpa9Wf6AAX7OAC6n/nSzzwaxrzUjBiJ9o9hDQaZCOyiJpl3F
	5SWUkyLIUEjtn3PT8e700oPgaw0L4jP92wg7o9ak3TSDy3pB3l+b363eSV7GvVcHaKa5
	V6p7ISZfzoq5vPUogG8zh+NSAk2QAuUEChrozKwBmQ8M2K+xyFWULdp/m+fS6Hq+AD8K
	1vKEE5HD8t2/dRcjIyGZTIaYkhNs9A0LTONgkQU7Atpo617pTmFeBs0TCb333avLkWRD
	kawg==
X-Gm-Message-State: APjAAAU1twApp9v0m+Ce6HSsgGejpjDV55xOLgwRuMvL8BxeT6iRZ+50
	b3hz3cKVaBMtmftnz0yh/Kmrctjga20rQS65xN8=
X-Google-Smtp-Source: APXvYqzYiUkvCv0gRTfS9R95WADJNnoMwTRdIoOH+tliqbgMv9gtDxty93FPTm9U94MtsClXc3ktI5zwXuvZ+nLbRCA=
X-Received: by 2002:aa7:d496:: with SMTP id b22mr5210527edr.122.1573075365953; 
	Wed, 06 Nov 2019 13:22:45 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0np6XuF7kQfzr8guexucFNqWMg=CY5sAL+LS7BTWTStaUg@mail.gmail.com>
	<CADkTA4MMf4YJEdqGzCcA2uYT1qEujVrJY8U7TpZ2xi9zoHnQXg@mail.gmail.com>
	<CAM2K0nq7kgsbnJRXhTJNc_6yhcvBdbpFE14=QYU0-Y2D5a1GiQ@mail.gmail.com>
In-Reply-To: <CAM2K0nq7kgsbnJRXhTJNc_6yhcvBdbpFE14=QYU0-Y2D5a1GiQ@mail.gmail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 6 Nov 2019 16:22:34 -0500
Message-ID: <CADkTA4M3iULXeNJeWyQVxDcmDs7K7zVvk0H14i5otxtgJgvtGQ@mail.gmail.com>
To: Wayne Li <waynli329@gmail.com>
Cc: Yocto Project Discussion <yocto@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] Adding KVM kernel modules to Yocto Kernel
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
X-List-Received-Date: Wed, 06 Nov 2019 21:22:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2019 at 11:56 AM Wayne Li <waynli329@gmail.com> wrote:
>
> The thing is I don't know how to pick specific kernel modules and add it =
to the system.  Me and my coworker were able to add missing TUN/TAP kernel =
modules using the same process I described (i.e. pulling up the GUI, saving=
 a .config file for TUN/TAP device driver support, and copying the .config =
file's content into the kernel configuration file).  And that worked and th=
e TUN module was added.  So I was just trying the same thing as that but fo=
r KVM.  I assumed that picking the right option in the GUI and using the ri=
ght .config file from there would build the right specific kernel modules i=
nto the kernel.

That will ensure the kernel is configured to build the modules, but
that doesn't mean they are installed to the image.

>
> I mean is there another way to specify specific kernel modules I want bui=
lt into the system?  What do you mean by the generic meta package "kernel-m=
odules".  Just so you know, my coworker was the one who did most of the wor=
k building the Yocto kernel.  But he's left the company so now I'm picking =
up the pieces.

The "kernel-modules" package is a meta package that installs all built
modules onto the system.

So unless you are really size constrained on the device, use it, and
you'll get everything that was configured and built as a module.

Bruce

>
> -Thanks!, Wayne Li
>
> On Wed, Nov 6, 2019 at 10:40 AM Bruce Ashfield <bruce.ashfield@gmail.com>=
 wrote:
>>
>> On Wed, Nov 6, 2019 at 11:30 AM Wayne Li <waynli329@gmail.com> wrote:
>> >
>> > Dear Yocto Developers,
>> >
>> > I'm trying to get KVM added and working on a Yocto kernel I built up f=
or a T4240 RDB (has a PowerPC CPU).  KVM isn't working and the reason why i=
t isn't working seems to be I'm missing the necessary kernel modules.  More=
 specifically, I don't seem to have a kvm.ko file that I can load.  Here's =
how I attempted to add KVM to the kernel.
>> >
>> > I went to the SDK install folder and ran ". fsl-setup-env -m t4240rdb-=
64b" and then "bitbake virtual/kernel -c menuconfig".  After the GUI comes =
up, I went to Virtualization -> KVM support for PowerPC E500MC/E5500/E6500 =
processors and hit "Save" to save the configuration.  I then went and copie=
d the content of the .config file created by this into the kernel configura=
tion file specified by the following path; "build_t4240rdb-64b/virt1.config=
".  This path was specified by the variable KERNEL_DEFCONFIG in sources/met=
a_freescale/conf/machine/t4240rdb-64b.conf.  Here's what I currently have i=
n the kernel configuration file (i.e. the virt1.config file I mentioned abo=
ve):
>> >
>> > https://gist.github.com/WayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1
>> >
>> > After this, I built the kernel by running "bitbake -c compile -f virtu=
al/kernel" and rebuilt the full linux image.  I re-added everything to the =
SD card and booted up the T4240 RDB with the newly modified Yocto kernel.  =
At this point if I run lsmod, only the following two kernel modules show up=
:
>> >
>> > Module                  Size  Used by
>> > nfsd                  100940  11
>> > exportfs                6723  1 nfsd
>> >
>> > But if I do a "find . -name "kvm"" I get the following:
>> >
>> > ./usr/src/kernel/Documentation/virtual/kvm
>> > ./usr/src/kernel/arch/arm/kvm
>> > ./usr/src/kernel/arch/arm64/kvm
>> > ./usr/src/kernel/arch/mips/kvm
>> > ./usr/src/kernel/arch/powerpc/kvm
>> > ./usr/src/kernel/arch/s390/kvm
>> > ./usr/src/kernel/arch/tile/kvm
>> > ./usr/src/kernel/arch/x86/kvm
>> > ./usr/src/kernel/drivers/s390/kvm
>> > ./usr/src/kernel/include/config/kvm
>> > ./usr/src/kernel/include/config/have/kvm
>> > ./usr/src/kernel/include/kvm
>> > ./usr/src/kernel/virt/kvm
>> > ./dev/kvm
>> > ./sys/devices/virtual/misc/kvm
>> > ./sys/class/misc/kvm
>> > ./sys/kernel/debug/kvm
>> > ./sys/module/kvm
>> >
>> > So it does look like kvm-related files were added to the Yocto kernel =
because of the changes I made to the kernel configuration file.  But there =
is no kvm.ko (or any .ko file related to kvm) anywhere in the file system.
>>
>> Is the image you are building installing the specific kernel modules
>> you need, or the generic meta package "kernel-modules" ? Without
>> something like that, you can build the support, but the modules won't
>> be present on the image.
>>
>> Bruce
>>
>> >
>> > Is there something I'm doing wrong here?  Am I missing important lines=
 in my kernel configuration file?  Let me know your thoughts.
>> >
>> > -Thanks!, Wayne Li
>> > --
>> > _______________________________________________
>> > yocto mailing list
>> > yocto@yoctoproject.org
>> > https://lists.yoctoproject.org/listinfo/yocto
>>
>>
>>
>> --
>> - Thou shalt not follow the NULL pointer, for chaos and madness await
>> thee at its end
>> - "Use the force Harry" - Gandalf, Star Trek II



--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

