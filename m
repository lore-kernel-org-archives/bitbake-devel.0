Return-Path: <waynli329@gmail.com>
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
	[209.85.166.51])
	by mail.openembedded.org (Postfix) with ESMTP id BB3856022F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 21:21:23 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id q83so20591710iod.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 13:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3COkdFDkOFjtUdPczKdwpFz/Hbdmg/itaFCfjhV5TWU=;
	b=rKpF4pv1tg0PedXCh3vYKOaaF6YRHla7FDSef4YGmASI+v3W/wA/cSuBjz8L6sJewD
	UAp8/+SkhhTXq7DkAiYyvGUoQPEdzZfYH1dKJ8ed87ry9N2eeKybttWHKSoQLohjlThz
	+kB/GACOSJLdK9xoA1yN/8RDRY8NbS10lDlQDxHxZtreQpevkGYBKrqNHN32gZ/8UUfd
	1oQwm1MvRXtba+lS1ubEVlDjwuLnW1x06cqgIwKNcI4M6kj8QAcwg3ymEqciHcBtWOja
	3lc3NcwBfzx3kUXwRZzUIb06xhQ5fvPddmFsC9BjOGlhXE7NnxtouE/KtuOG4ppsBOW+
	HLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3COkdFDkOFjtUdPczKdwpFz/Hbdmg/itaFCfjhV5TWU=;
	b=TSE/0dqmlvFsYvGJ36qelxn3ERqMNg/gKiIw+czykciuk0oB0gG9b0fryr/8OPTxX2
	Nci51T4iOox0foWwZz1XYclFhiFliOzG+rslel/mDXnQXguiss9fIPRepFOlS7krCfYI
	xDHE/1g/muz6D9oqSpfim7bim/5quNgxyzb4IgeNaU+Z/H4wYqoOXGfB4vtknonMsQ3m
	Sx4+0AuYLi9/YuDPP3y7EN2/tqX+wvXThrbE9T1lcBWsSjhhbm66g4MV/qF63X9aBXTS
	93bNhzL4/8NKVG9AQhCMImfuAB+AHYCcbDfadl+X6ZKft/4txSOfbfq3ussrXjIOdBri
	kVQw==
X-Gm-Message-State: APjAAAX5aE+v7iGdwsOe7iFnFEu9oWQ9jQaOQzENZoOxhKLv89ntYjQS
	pSdBREzSuelMWY52Bk+U9hqhwSe2uPoqSdWVORw=
X-Google-Smtp-Source: APXvYqxSKm3/Nx/cHlKIPZL9o0UINeNr+xAMXoT28wzFHeFD66azxbVHBqp6ZdBkwacwqx5EJ7QfhVcBRN3NRX557MY=
X-Received: by 2002:a5d:8855:: with SMTP id t21mr16131683ios.138.1574112084473;
	Mon, 18 Nov 2019 13:21:24 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com>
	<6bec080c-c289-c808-3618-19206694468c@3mdeb.com>
In-Reply-To: <6bec080c-c289-c808-3618-19206694468c@3mdeb.com>
From: Wayne Li <waynli329@gmail.com>
Date: Mon, 18 Nov 2019 15:21:12 -0600
Message-ID: <CAM2K0norrBF6HEcxqC8tvsh745W+0RaCv9_9MC2eKwPOA=q5bA@mail.gmail.com>
To: Maciej Pijanowski <maciej.pijanowski@3mdeb.com>
Cc: Yocto Project Discussion <yocto@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] KVM kernel modules missing from Yocto kernel
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
X-List-Received-Date: Mon, 18 Nov 2019 21:21:24 -0000
Content-Type: multipart/alternative; boundary="000000000000a1bda70597a587c5"

--000000000000a1bda70597a587c5
Content-Type: text/plain; charset="UTF-8"

So it looks like KVM is built in (at least it's supposed to be).  I'm
pretty sure that is the case after looking at my kernel configuration file:

https://gist.github.com/WayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1

I then changed the CONFIG_KVM=y line to CONFIG_KVM=m and also added the
IMAGE_INSTALL += "kernel-modules" line to my local.conf file.
Unfortunately, again nothing seemed to have changed and there are no new
KVM-related .ko files in the image.  However, this does bring up some
questions.  I have a kernel loaded onto the SD card from that was built
right after we added the content from the KVM .config file to the kernel
configuration file. This kernel is currently up and running on my T4240 RDB
board.  The KVM kernel module doesn't show up when I run lsmod nor does it
show up in the file /lib/modules/4.1.8-rt8+gdb51baf/modules.builtin (a file
that is supposed to list all built-in modules).  However, if I go into the
/sys/module folder, there is a kvm folder in there.  So I guess this means
the kvm module can potentially be built into the system but for whatever
reason it isn't being built in?

On Mon, Nov 18, 2019 at 1:12 PM Maciej Pijanowski <
maciej.pijanowski@3mdeb.com> wrote:

>
> On 18.11.2019 19:22, Wayne Li wrote:
>
> Dear Yocto Developers,
>
> I'm trying to incorporate KVM into a Yocto kernel me and my coworker build
> for a T4240 RDB (which has a PowerPC CPU).  The problem is, no matter what
> I do the KVM kernel module (I'm expecting a kvm.ko or any .ko file along
> those lines) is not present in the image.
>
> First I tried adding the content of the .config file generated when
> configuring the kernel for KVM support into the kernel configuration file.
> This resulted in KVM source directories appearing in the kernel but no KVM
> related kernel modules are present.  I explain this in more detail in a
> previous email conversation I had with the Yocto community (saved in a
> Github gist for readability):
>
> What is your kenel config? Is KVM built-in (y) or built as module (m)?
>
>
> https://gist.github.com/WayneZhenLi/d5d7a5e8c30e6d4b7cd4541d0c24cab5
>
> Since then I've tried a few things.  First, I added the following lines to
> the local.conf file (found in build_t4240rdb-64b/conf folder):
>
> MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS += "kernel-modules"
> MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS += "kvm-image-minimal"
>
> I din't know which image you are building. Those variables are tricky,
> since
> they only applies when basing on the packagegroup-core-boot packagegroup.
> Please refer to the documentation.
>
>
> But that didn't seem to work as there weren't any new .ko files in the
> final image.  Next I tried adding the following lines to the same
> local.conf file:
>
> CORE_IMAGE_EXTRA_INSTALL += "kernel-modules"
> CORE_IMAGE_EXTRA_INSTALL += "kvm-image-minimal"
>
> Why trying to install the image into image? kvm-image-minimal is not a
> package, it is image recipe.
> The build can definitely break in this case.
>
> This time I get an error saying "ERROR: kvm-image-minimal not found in the
> base feeds (t4240rdb-64b ppc64e6500 powerpc64 noarch any all)".  Also if
> just run a "ERROR: bitbake kvm-image-minimal" to see what's going on with
> that particular recipe I get an error saying "kernel-module-kvm-intel" not
> found in the base feeds (t4240rdb-64b ppc64e6500 powerpc64 noarch any all).
>
> Would I have to write recipes for the packages listed in kvm-image-minimal
> such as kernel-module-kvm-intel or kernel-module-kvm?  Note that I'm not
> even building the image for intel; I'm building it for PowerPC.  Anyway, I
> just feel like writing recipes for the KVM kernel modules isn't the correct
> step.  Like maybe I just messed up my with my configuration somehow?  What
> are your thoughts?
>
> IMHO: Simply use IMAGE_INSTALL += "kernel-modules" (IMAGE_INSTALL +=
> "kernel-module-kvm" will likely install just the KVM module)
> in your local.conf to install all built kernel modules. If KVM module
> won't be present in the rootfs, it means it was not built.
>
> Please inspect your kernel work dir (packages-split dir) to find out which
> packages were produced by
> the kernel recipe. It will be something like
> build/tmp/work/XX/linux-yocto/XX/packages-split
>
>
> -Thanks!, Wayne Li
>
>
> --
> Maciej Pijanowski
> Embedded Systems Engineerhttps://3mdeb.com | @3mdeb_com
>
>

--000000000000a1bda70597a587c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>So it looks like KVM is built in (at least it&#39;s s=
upposed to be).=C2=A0 I&#39;m pretty sure that is the case after looking at=
 my kernel configuration file:</div><div><br></div><div><a href=3D"https://=
gist.github.com/WayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1">https://gist.=
github.com/WayneZhenLi/4172cd4a819b71a11b85fc5aaa57ebd1</a></div><div><br><=
/div><div>I then changed the CONFIG_KVM=3Dy line to CONFIG_KVM=3Dm and also=
 added the IMAGE_INSTALL +=3D &quot;kernel-modules&quot; line to my local.c=
onf file.=C2=A0 Unfortunately, again nothing seemed to have changed and the=
re are no new KVM-related .ko files in the image.=C2=A0 However, this does =
bring up some questions.=C2=A0 I have a kernel loaded onto the SD card from=
 that was built right after we=20
added the content from the KVM .config file to the kernel configuration fil=
e. This kernel is currently up and running on my T4240 RDB board.=C2=A0 The=
 KVM kernel module doesn&#39;t show up when I run lsmod nor does it show up=
 in the file /lib/modules/4.1.8-rt8+gdb51baf/modules.builtin (a file that i=
s supposed to list all built-in modules).=C2=A0 However, if I go into the /=
sys/module folder, there is a kvm folder in there.=C2=A0 So I guess this me=
ans the kvm module can potentially be built into the system but for whateve=
r reason it isn&#39;t being built in?</div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 18, 2019 at 1:12 PM =
Maciej Pijanowski &lt;<a href=3D"mailto:maciej.pijanowski@3mdeb.com">maciej=
.pijanowski@3mdeb.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 18.11.2019 19:22, Wayne Li wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>Dear Yocto Developers,</div>
        <div><br>
        </div>
        <div>I&#39;m trying to incorporate KVM into a Yocto kernel me and m=
y
          coworker build for a T4240 RDB (which has a PowerPC CPU).=C2=A0 T=
he
          problem is, no matter what I do the KVM kernel module (I&#39;m
          expecting a kvm.ko or any .ko file along those lines) is not
          present in the image.</div>
        <div><br>
        </div>
        <div>First I tried adding the content of the .config file
          generated when configuring the kernel for KVM support into the
          kernel configuration file.=C2=A0 This resulted in KVM source
          directories appearing in the kernel but no KVM related kernel
          modules are present.=C2=A0 I explain this in more detail in a
          previous email conversation I had with the Yocto community
          (saved in a Github gist for readability):</div>
      </div>
    </blockquote>
    What is your kenel config? Is KVM built-in (y) or built as module
    (m)?<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div><a href=3D"https://gist.github.com/WayneZhenLi/d5d7a5e8c30e6d4=
b7cd4541d0c24cab5" target=3D"_blank">https://gist.github.com/WayneZhenLi/d5=
d7a5e8c30e6d4b7cd4541d0c24cab5</a></div>
        <div><br>
        </div>
        <div>Since then I&#39;ve tried a few things.=C2=A0 First, I added t=
he
          following lines to the local.conf file (found in
          build_t4240rdb-64b/conf folder):</div>
        <div><br>
        </div>
        <div>
          MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS +=3D &quot;kernel-modules&quo=
t;<br>
          MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS +=3D &quot;kvm-image-minimal&=
quot;
          <br>
        </div>
      </div>
    </blockquote>
    I din&#39;t know which image you are building. Those variables are
    tricky, since<br>
    they only applies when basing on the packagegroup-core-boot
    packagegroup.<br>
    Please refer to the documentation.<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>But that didn&#39;t seem to work as there weren&#39;t any new =
.ko
          files in the final image.=C2=A0 Next I tried adding the following
          lines to the same local.conf file:</div>
        <div><br>
        </div>
        <div>
          CORE_IMAGE_EXTRA_INSTALL +=3D &quot;kernel-modules&quot;<br>
          CORE_IMAGE_EXTRA_INSTALL +=3D &quot;kvm-image-minimal&quot;</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    Why trying to install the image into image? kvm-image-minimal is not
    a package, it is image recipe.<br>
    The build can definitely break in this case.<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>This time I get an error saying &quot;ERROR: kvm-image-minimal
          not found in the base feeds (t4240rdb-64b ppc64e6500 powerpc64
          noarch any all)&quot;.=C2=A0 Also if just run a &quot;ERROR: bitb=
ake
          kvm-image-minimal&quot; to see what&#39;s going on with that part=
icular
          recipe I get an error saying &quot;kernel-module-kvm-intel&quot; =
not
          found in the base feeds (t4240rdb-64b ppc64e6500 powerpc64
          noarch any all).</div>
        <div><br>
        </div>
        <div>Would I have to write recipes for the packages listed in
          kvm-image-minimal such as kernel-module-kvm-intel or
          kernel-module-kvm?=C2=A0 Note that I&#39;m not even building the =
image
          for intel; I&#39;m building it for PowerPC.=C2=A0 Anyway, I just =
feel
          like writing recipes for the KVM kernel modules isn&#39;t the
          correct step.=C2=A0 Like maybe I just messed up my with my
          configuration somehow?=C2=A0 What are your thoughts?</div>
      </div>
    </blockquote>
    IMHO: Simply use IMAGE_INSTALL +=3D &quot;kernel-modules&quot; (IMAGE_I=
NSTALL +=3D
    &quot;kernel-module-kvm&quot; will likely install just the KVM module)<=
br>
    in your local.conf to install all built kernel modules. If KVM
    module won&#39;t be present in the rootfs, it means it was not built.<b=
r>
    <br>
    Please inspect your kernel work dir (packages-split dir) to find out
    which packages were produced by<br>
    the kernel recipe. It will be something like
    build/tmp/work/XX/linux-yocto/XX/packages-split<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>-Thanks!, Wayne Li<br>
        </div>
        <div><br>
        </div>
      </div>
      <br>
      <fieldset></fieldset>
    </blockquote>
    <pre cols=3D"72">--=20
Maciej Pijanowski
Embedded Systems Engineer
<a href=3D"https://3mdeb.com" target=3D"_blank">https://3mdeb.com</a> | @3m=
deb_com</pre>
  </div>

</blockquote></div>

--000000000000a1bda70597a587c5--
