Return-Path: <waynli329@gmail.com>
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id B024975E2D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2019 21:23:56 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id g12so1111839ild.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Dec 2019 13:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=CDEloTuG5cKJPNnBy3BfuP+tFFQQltdT8xd+UlR4RsQ=;
	b=HAvp62gNUIfEEPZMvJ2dDNYYnfW8KKwbJKat9FAD8pH0huakOgNvIMX4+w11J6WqSh
	49h2hJlpjC42ZGd8j0QvmOW054GtaDnWCRwRTWF+3B5xaiqLDYYAx/P0cE2r8Lyz9LU6
	Ldm2VFaSDTIr35K/iO8XCxUjqmIJ+YfepLP4kEqueh9gHMyvKm1AqTqkN8lDsZ+NZ1me
	M7Wrh39U5VMcURsmHIoeP7EyzkoIEUT3yDTdJ74YsrTcVxLqCP5qRgmMKbmP6SIQkP4N
	TKdBy3gfQQtDkQPFA+EwUxWcEC05wwJQLRmdUiq0p0mHa0d0IJp1g6bj2VbJpqQwOXQo
	FwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=CDEloTuG5cKJPNnBy3BfuP+tFFQQltdT8xd+UlR4RsQ=;
	b=QVCyiD/tqsGsY1Lha1TYn+uD8zr5OHEitq6x6gc52wavxUJmt8gpdiGBnupZyodoN8
	qrpqIjwRLV4L9tI66nYqwQ0Nptq60p9NDOy/Qqs4GHJl0S8VPActH/Hn61oqQHZUnds5
	R1P5G/LemOrh9rL0LjGH+B2yvPiKLPl84flyOu3G4R9xGEmwfImoqMDITrOwV8b9gEil
	3xT2YBfbRw3zobFUkioknfhj5X/+rajSyAJkfoBJJsqKptbpKOq0ok/i9iCsm/zulI9w
	JgXTIjay631vJy5ggQBCcfB3UK9ipemVfAJWpUrOZCq06HixHFuOoN/VTCPZFKDJ67qO
	7ivw==
X-Gm-Message-State: APjAAAVzOV4RMKtRDlxf5gIfdUxVemXB3tFUqzju+FJyn46XL7RbEZMw
	vzR8KNZqRBwWeoHysI69kPMdOB/X2wgKq8Zs0II=
X-Google-Smtp-Source: APXvYqzjWSuqPMAouNLIZ9gAs67J5MyJBTtRKaH/42aU3gbTuhVtGPjrDIIYR30EJGfoYiG7bXO8xtQ5JGHpH7Ss4oo=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr1056977ilq.306.1575321837537; 
	Mon, 02 Dec 2019 13:23:57 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Mon, 2 Dec 2019 21:23:46 +0000
Message-ID: <CAM2K0nqqNemNd0xoHQK164qjP2UwTJt4GS6A5PDyKN0GWmWkQg@mail.gmail.com>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto Project Discussion <yocto@yoctoproject.org>
Subject: KVM Kernel Module not being built for Yocto Kernel
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
X-List-Received-Date: Mon, 02 Dec 2019 21:23:56 -0000
Content-Type: multipart/alternative; boundary="000000000000888f870598bf32fe"

--000000000000888f870598bf32fe
Content-Type: text/plain; charset="UTF-8"

Dear KVM community,

First of all I'd like mention I've posted this question on the Yocto
mailing list as well as the KVM mailing list because my question has huge
ties to the bitbake process (a concept related to the Yocto project).
Though I believe I'm mainly addressing the KVM community because my problem
is more directly related to the intricacies of the KVM build process.

So I am trying to build the kvm-kmod from source and I'm running into an
issue where the compilation doesn't produce any kernel modules.  But before
I describe my issue and question any further, here's a little background
information on my current endeavour.

My goal right now is to get KVM to work on a T4240RDB running on a
Yocto-based kernel.  For those of you who don't know what a Yocto kernel
is, it is a kernel that you can build/customize yourself using a program
called bitbake.  Anyway, the KVM kernel modules are supposed to be included
in the Yocto kernel by default but they aren't there.  And no tweaking of
the configuration for the bitbake process to build the Yocto kernel has
made the KVM kernel modules appear in the kernel (I've tried pretty much
everything!  Just search my name in the Yocto mailing list archive
haha...).  So my final solution was to download the kvm-kmod source code
and write a custom recipe to bitbake it into the kernel module (in layman
terms this means I just download the code and write a "recipe" to tell
bitbake how to compile the kvm-kmod source code and insert the output files
into the kernel).  Here's the recipe that I wrote for this:

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=c616d0e7924e9e78ee192d99a3b26fbd"

inherit module

SRC_URI =
"file:///homead/QorIQ-SDK-V2.0-20160527-yocto/sources/meta-virtualization/recipes-kernel/kvm-kmodule/kvm-kmod-3.10.21.tar.bz2"

S = "${WORKDIR}/kvm-kmod-3.10.21"

do_configure() {
    ./configure --arch=ppc64
--kerneldir=/homead/QorIQ-SDK-V2.0-20160527-yocto/build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel
}

FILES_${PN} += "/lib/modules/4.1.8-rt8+gbd51baf"

Anyway when I run "bitbake kvm-kmod", it runs fine with no errors.  This
runs the recipe I wrote (I conveniently named my recipe kvm-kmod) which
runs the configure file present in the kvm-kmod source code and then runs
make.  In other words I ran make on the kvm-kmod source code with no
errors.  But the problem is there is no kvm.ko or anything like that
anywhere in my project code.

Compiling the kvm-kmod source code *is* supposed to produce kvm kernel
modules right?  I mean kvm-kmod literally stands for kvm kernel module?
Could I have forgotten to do something when building the kvm-kmod source
code?  Or maybe my problem has something to do with my recipe?  Let me know
your thoughts.

-Thanks!, Wayne Li

--000000000000888f870598bf32fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear KVM community,</div><div><br></div><div>First of=
 all I&#39;d like mention I&#39;ve posted this question on the Yocto mailin=
g list as well as the KVM mailing list because my question has huge ties to=
 the bitbake process (a concept related to the Yocto project).=C2=A0 Though=
 I believe I&#39;m mainly addressing the KVM community because my problem i=
s more directly related to the intricacies of the KVM build process.<br></d=
iv><div><br></div><div>So I am trying to build the kvm-kmod from source and=
 I&#39;m running into an issue where the compilation doesn&#39;t produce an=
y kernel modules.=C2=A0 But before I describe my issue and question any fur=
ther, here&#39;s a little background information on my current endeavour.</=
div><div><br></div><div>My goal right now is to get KVM to work on a T4240R=
DB running on a Yocto-based kernel.=C2=A0 For those of you who don&#39;t kn=
ow what a Yocto kernel is, it is a kernel that you can build/customize your=
self using a program called bitbake.=C2=A0 Anyway, the KVM kernel modules a=
re supposed to be included in the Yocto kernel by default but they aren&#39=
;t there.=C2=A0 And no tweaking of the configuration for the bitbake proces=
s to build the Yocto kernel has made the KVM kernel modules appear in the k=
ernel (I&#39;ve tried pretty much everything!=C2=A0 Just search my name in =
the Yocto mailing list archive haha...).=C2=A0 So my final solution was to =
download the kvm-kmod source code and write a custom recipe to bitbake it i=
nto the kernel module (in layman terms this means I just download the code =
and write a &quot;recipe&quot; to tell bitbake how to compile the kvm-kmod =
source code and insert the output files into the kernel).=C2=A0 Here&#39;s =
the recipe that I wrote for this:</div><div><br></div><div style=3D"margin-=
left:40px">LICENSE =3D &quot;GPLv2&quot;<br>LIC_FILES_CHKSUM =3D &quot;file=
://COPYING;md5=3Dc616d0e7924e9e78ee192d99a3b26fbd&quot;<br><br>inherit modu=
le<br><br>SRC_URI =3D &quot;file:///homead/QorIQ-SDK-V2.0-20160527-yocto/so=
urces/meta-virtualization/recipes-kernel/kvm-kmodule/kvm-kmod-3.10.21.tar.b=
z2&quot;<br><br>S =3D &quot;${WORKDIR}/kvm-kmod-3.10.21&quot;<br><br>do_con=
figure() {<br>=C2=A0 =C2=A0 ./configure --arch=3Dppc64 --kerneldir=3D/homea=
d/QorIQ-SDK-V2.0-20160527-yocto/build_t4240rdb-64b/tmp/work/t4240rdb_64b-fs=
l-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel<br>}<br><br>FILES_${PN} +=
=3D &quot;/lib/modules/4.1.8-rt8+gbd51baf&quot;</div><div style=3D"margin-l=
eft:40px"><br></div><div>Anyway when I run &quot;bitbake kvm-kmod&quot;, it=
 runs fine with no errors.=C2=A0 This runs the recipe I wrote (I convenient=
ly named my recipe kvm-kmod) which runs the configure file present in the k=
vm-kmod source code and then runs make.=C2=A0 In other words I ran make on =
the kvm-kmod source code with no errors.=C2=A0 But the problem is there is =
no kvm.ko or anything like that anywhere in my project code.</div><div><br>=
</div><div>Compiling the kvm-kmod source code <i>is</i> supposed to produce=
 kvm kernel modules right?=C2=A0 I mean kvm-kmod literally stands for kvm k=
ernel module?=C2=A0 Could I have forgotten to do something when building th=
e kvm-kmod source code?=C2=A0 Or maybe my problem has something to do with =
my recipe?=C2=A0 Let me know your thoughts.</div><div><br></div><div>-Thank=
s!, Wayne Li<br></div></div>

--000000000000888f870598bf32fe--
