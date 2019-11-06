Return-Path: <bruce.ashfield@gmail.com>
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
	[209.85.208.49])
	by mail.openembedded.org (Postfix) with ESMTP id 88AE17F882
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Nov 2019 16:40:54 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id s10so4920189edi.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Nov 2019 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=86dpPayaQxviQrKkc4lxQISX+9PApifAYUM8ql+HG2U=;
	b=bnqhCojmPMnx49qdGqL48iNQOeusjOW2ytHEFknpKTtOHN3P7W7mPQFF3botpdf/qE
	w0sGOqJT2E+ZC1f6bBBUwm/TLfNsnk3YyPKw4D7q+Ik9Wq7GYP+MnNfMk9t5aO7UoGOh
	zcBXWxaYQpb+ocTRGs08vAgTnfiWongfn1SyI6kQZAwPmMw+qofmgSPPrZu2v6RezzZW
	0HA+gU/Co8EaXGyKr6GzB/LPlufVIDJqeYVhAH7sPLlmul5yOgs8b46O21jqIn+lBq56
	2ueoQUj5jMTDyUcA/P4qapdZNSS47Apr8C75lTLS5xycs+dBz7PY+GwjrJlDt1CosRH1
	fJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=86dpPayaQxviQrKkc4lxQISX+9PApifAYUM8ql+HG2U=;
	b=HZz2Nu6txT9M85qdNNOOKcQjQ3edsguEhIYkrMNmwEm7mLDQJLxF8ff3hFYWonIrBN
	pDdjMCM7JOFxCRakwxVlPSBOQ3UfkFaT+lwusAhCj1hSKRYMD731UHfLuiXOBM9MEVkO
	2aq8YZ/hgQApjHccw7BJ2Wn1+iBD+gFFOKB4WXUe2fr7b32Sp6TmzzUUG0BgEsnLXUrP
	5EkwL1BirNxep1V7WRC/7/Cu95qkoToNEjZBX+GULqrqSSZ9GIhoy7jYWhRjD3C1Mj6r
	/EaN9hDmCTKDnBWbg7IFGbSj22j8bd0bACJGBtMW29D2a4se97eFt67ZUwwFWOv4KhoF
	mV7g==
X-Gm-Message-State: APjAAAXlQIUGakV0VEiDCnQu/UIOcyKxOe0KHhY5r0aUiwTJ3aq3KTEB
	bl7fzRodom6bBjXf5BG/N4fgNVq/+vKKKU2vW6Y=
X-Google-Smtp-Source: APXvYqzFjVKtWxPLsOJBDjCgICxhVW6EmO60gk6KWvOHHMS87OeYWfk1+jT4TGjUbfqMNJKut5y3XdtkmPiZFYsV1tE=
X-Received: by 2002:a17:906:4bcb:: with SMTP id
	x11mr36268012ejv.9.1573058455036; 
	Wed, 06 Nov 2019 08:40:55 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0np6XuF7kQfzr8guexucFNqWMg=CY5sAL+LS7BTWTStaUg@mail.gmail.com>
In-Reply-To: <CAM2K0np6XuF7kQfzr8guexucFNqWMg=CY5sAL+LS7BTWTStaUg@mail.gmail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 6 Nov 2019 11:40:44 -0500
Message-ID: <CADkTA4MMf4YJEdqGzCcA2uYT1qEujVrJY8U7TpZ2xi9zoHnQXg@mail.gmail.com>
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
X-List-Received-Date: Wed, 06 Nov 2019 16:40:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2019 at 11:30 AM Wayne Li <waynli329@gmail.com> wrote:
>
> Dear Yocto Developers,
>
> I'm trying to get KVM added and working on a Yocto kernel I built up for =
a T4240 RDB (has a PowerPC CPU).  KVM isn't working and the reason why it i=
sn't working seems to be I'm missing the necessary kernel modules.  More sp=
ecifically, I don't seem to have a kvm.ko file that I can load.  Here's how=
 I attempted to add KVM to the kernel.
>
> I went to the SDK install folder and ran ". fsl-setup-env -m t4240rdb-64b=
" and then "bitbake virtual/kernel -c menuconfig".  After the GUI comes up,=
 I went to Virtualization -> KVM support for PowerPC E500MC/E5500/E6500 pro=
cessors and hit "Save" to save the configuration.  I then went and copied t=
he content of the .config file created by this into the kernel configuratio=
n file specified by the following path; "build_t4240rdb-64b/virt1.config". =
 This path was specified by the variable KERNEL_DEFCONFIG in sources/meta_f=
reescale/conf/machine/t4240rdb-64b.conf.  Here's what I currently have in t=
he kernel configuration file (i.e. the virt1.config file I mentioned above)=
:
>
> https://gist.github.com/WayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1
>
> After this, I built the kernel by running "bitbake -c compile -f virtual/=
kernel" and rebuilt the full linux image.  I re-added everything to the SD =
card and booted up the T4240 RDB with the newly modified Yocto kernel.  At =
this point if I run lsmod, only the following two kernel modules show up:
>
> Module                  Size  Used by
> nfsd                  100940  11
> exportfs                6723  1 nfsd
>
> But if I do a "find . -name "kvm"" I get the following:
>
> ./usr/src/kernel/Documentation/virtual/kvm
> ./usr/src/kernel/arch/arm/kvm
> ./usr/src/kernel/arch/arm64/kvm
> ./usr/src/kernel/arch/mips/kvm
> ./usr/src/kernel/arch/powerpc/kvm
> ./usr/src/kernel/arch/s390/kvm
> ./usr/src/kernel/arch/tile/kvm
> ./usr/src/kernel/arch/x86/kvm
> ./usr/src/kernel/drivers/s390/kvm
> ./usr/src/kernel/include/config/kvm
> ./usr/src/kernel/include/config/have/kvm
> ./usr/src/kernel/include/kvm
> ./usr/src/kernel/virt/kvm
> ./dev/kvm
> ./sys/devices/virtual/misc/kvm
> ./sys/class/misc/kvm
> ./sys/kernel/debug/kvm
> ./sys/module/kvm
>
> So it does look like kvm-related files were added to the Yocto kernel bec=
ause of the changes I made to the kernel configuration file.  But there is =
no kvm.ko (or any .ko file related to kvm) anywhere in the file system.

Is the image you are building installing the specific kernel modules
you need, or the generic meta package "kernel-modules" ? Without
something like that, you can build the support, but the modules won't
be present on the image.

Bruce

>
> Is there something I'm doing wrong here?  Am I missing important lines in=
 my kernel configuration file?  Let me know your thoughts.
>
> -Thanks!, Wayne Li
> --
> _______________________________________________
> yocto mailing list
> yocto@yoctoproject.org
> https://lists.yoctoproject.org/listinfo/yocto



--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

