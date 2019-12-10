Return-Path: <waynli329@gmail.com>
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
	[209.85.166.41])
	by mail.openembedded.org (Postfix) with ESMTP id BAD2E7CDC0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2019 21:08:57 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id x1so20345352iop.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2019 13:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hh7wpWcxjHloxCDngpv5IIHsM5p6Ae22z1DuDLZckW4=;
	b=vhqO1ngy/Q4AbgKRhyun5IXhJppgqeKeKDZJ+WqPNoVyh9Vootsb0AuOWmC08Eb0tZ
	av3OIebE5h9EQCPItpBlsbNjIpknJ8kiF0A7GjINiAwJuCAjhDCcv4ywn7bbPoirQjh4
	C/BQ1O7zH0eenyCg7eANmYr1t6Kghj0N0cH9SleTKBlAzolDieaFZZ2Sl2N9YGScI9FC
	MtV/ozyi1ErCJQzs+AEM1Fmc0lS7QfN8vUsCn15n3o8zquX6pzX0LlJ8LsyCFScqBTdA
	AwM97EruswI47FOxIiK8VZuNfUo9tvat+sltUTq+T8oo/XcyQp5KzfQaLDY34bdrerhN
	xuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hh7wpWcxjHloxCDngpv5IIHsM5p6Ae22z1DuDLZckW4=;
	b=oDaUtNJTZ0jQ3ao9Q180wQR8QMNuU+3AUmuWYTN1hPlMpZugnX4jCyrnH7jjpgvfh9
	CgV2FuWcq4ahAViZFxeYz+pSCC0eJVCEB2iLfqD6zFfD1QwDDTEko4cg50CKJOeEfo4b
	VZv1ZEGBZAkWlXbXkgfWOU3HU5w9/1uf0vxKWl9EqCDSnpMQn6CQoxhK4Lz8KltnamKJ
	rd1Ydc4GoO6323APwethXaxE33YO6FXxSQkyflyP+HyOmV72kWlpQEUKBcXBnt4tFuSb
	v9FTvoFu/kf+OyQDzBcA8xXHtq0BEcUC2pdq+DafAwuASGUueGh5K2yzr3vl8Jecw0D3
	4HAQ==
X-Gm-Message-State: APjAAAWMIIe69TL1dlZIqe5bhDVyNkUCWmtFAZrt/Z0o6K+eLvd46XBN
	zIMYhWHMZWkIJdS0bsHFqbJz9fv+EnsbQpeyH94=
X-Google-Smtp-Source: APXvYqwdmglKgoMH8M/tAHhUIYGn+QQ4BpQKUGUjw4U5Gad9f0eBTF4hYf3wibK+lLdKYeqiiSlQXRPI8OjIMEBb8aM=
X-Received: by 2002:a02:aa10:: with SMTP id r16mr9643360jam.48.1576012138684; 
	Tue, 10 Dec 2019 13:08:58 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nr6suFCaV-Ne7zv7ukyiXh4BG5H0Y6S6UkS5h08x8aGAg@mail.gmail.com>
	<CS1PR8401MB0568A3D49346083E949FA11C825C0@CS1PR8401MB0568.NAMPRD84.PROD.OUTLOOK.COM>
	<CAM2K0nrFdGNsU=BxEDV9nPj0W0zqKTogq9RXoBofiQYKGGCuqA@mail.gmail.com>
	<CS1PR8401MB0568292C74FD3BC61A690DC3825B0@CS1PR8401MB0568.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB0568292C74FD3BC61A690DC3825B0@CS1PR8401MB0568.NAMPRD84.PROD.OUTLOOK.COM>
From: Wayne Li <waynli329@gmail.com>
Date: Tue, 10 Dec 2019 21:08:47 +0000
Message-ID: <CAM2K0nqnEyUMg_RBd1QY=4VACtdXogJg=5dq3n-GE=DK+39EEQ@mail.gmail.com>
To: "McKay, Sean" <sean.mckay@hpe.com>
Cc: Yocto Project Discussion <yocto@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [yocto] Question about shipping files to package.
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
X-List-Received-Date: Tue, 10 Dec 2019 21:08:57 -0000
Content-Type: multipart/alternative; boundary="000000000000b024f405995feb1f"

--000000000000b024f405995feb1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That makes a lot of sense.  The version I'm on is: PV=3D"4.1" (I just ran
bitbake -e virtual/kernel | grep "^PV").

On Tue, Dec 10, 2019 at 8:54 PM McKay, Sean <sean.mckay@hpe.com> wrote:

> If the issue were *just* that your FILES_* variables were set
> incorrectly, you=E2=80=99d at least end up with the .ko file somewhere in=
 your
> ${WORKDIR}/image (${D}) directory. You=E2=80=99d almost certainly find an=
other one
> in the build or source directory as well (depending on how your .bb/bbcla=
ss
> files define the location of the compilation).
>
>
>
> The fact that you don=E2=80=99t have one anywhere seems to indicate that =
your
> do_compile step isn=E2=80=99t actually generating the .ko that you expect=
 it to, so
> you=E2=80=99ll need to rewind your recipe creation to working on that ste=
p and
> debug there.
>
>
>
> Assuming you=E2=80=99re using poky as a base, what version are you on so =
I can go
> read the .bbclass you=E2=80=99re using?
>
>
>
> -Sean
>
>
>
> *From:* Wayne Li <waynli329@gmail.com>
> *Sent:* Tuesday, December 10, 2019 12:23 PM
> *To:* McKay, Sean <sean.mckay@hpe.com>
> *Cc:* bitbake-devel <bitbake-devel@lists.openembedded.org>; Yocto Project
> Discussion <yocto@yoctoproject.org>
> *Subject:* Re: [yocto] Question about shipping files to package.
>
>
>
> I did a find for any files with a kvm and a .ko in its name throughout my
> entire workspace and nothing came up.  But anyway, thanks for the
> explanation.  Could packaging the files wrong (i.e. setting the FILES
> variable wrong) cause the kvm.ko file to never show up at all?  I guess
> that couldn't be the case though because the .ko files are created first
> before it gets packaged up so if they were created in the first place a
> search through my entire workspace would turn them up.  Is that correct?
>
>
>
> On Thu, Dec 5, 2019 at 11:14 PM McKay, Sean <sean.mckay@hpe.com> wrote:
>
> I=E2=80=99m not an expert on compiling kernel modules, but I can at least=
 answer
> some of your questions to get started. I=E2=80=99m also not an actual exp=
ert, but
> just another user, so it=E2=80=99s entirely possible that someone more
> knowledgeable will come along and tell us that I=E2=80=99m wrong.
>
>
>
> With that said, first, I have to ask the simple stuff: when you say that
> no .ko is being created, where are you looking? If you=E2=80=99re not sur=
e where
> you should be looking, I=E2=80=99d recommend by doing a find inside of yo=
ur
> ${WORKDIR} to see whether or not you=E2=80=99ve got any .ko files. They w=
on=E2=80=99t quite
> be out in plain sight.
>
>
>
> In general (though again, I can=E2=80=99t speak for the module class),
> compilations take place in a build directory inside of the recipe=E2=80=
=99s workdir
> (${B} in bitbake parlance). The install process then copies the created
> files to a staging directory (${D} in bitbake parlance) that=E2=80=99s us=
ually
> ${WORKDIR}/image.
>
>
>
> Packaging is the process of taking those output files from ${D} and
> packaging them into one of a few well defined packaging formats. If you=
=E2=80=99re
> using the defaults, this would be RPM. A single recipe can (and often doe=
s)
> produce multiple packages. When bitbake moves onto the packaging step (I=
=E2=80=99m
> simplifying a bit), it creates directories for each package that=E2=80=99=
s going to
> be generated inside of ${WORKDIR}/packages-split. It then looks at the
> FILES variable for the particular package it=E2=80=99s working on and cop=
ies any
> files that match the patterns in that variable into that package=E2=80=99=
s
> directory in packages-split. When it=E2=80=99s done copying files, each o=
f those
> directories are turned into the appropriate package (probably .rpm) file.
>
> So, for a somewhat more concrete example, when you said =E2=80=98FILES_${=
PN} +=3D
> "/lib/modules/4.1.8-rt8+gbd51baf"=E2=80=99, you told bitbake that anythin=
g that
> matched /lib/modules/4.1.8-rt8+gbd51baf should get put in the ${PN} (main=
)
> package.
>
>
>
> In the context of the error message you were previously receiving,
> =E2=80=9Cinstalled=E2=80=9D is the do_install step, which is referring to=
 that staging
> process (analogous to running =E2=80=98make install=E2=80=99 on something=
 you just
> downloaded from the internet). Something is =E2=80=98shipped=E2=80=99 if =
it is packaged
> into one of the final rpm files.
>
>
>
> Cheers!
>
> -Sean McKay
>
>
>
> *From:* yocto@lists.yoctoproject.org <yocto@lists.yoctoproject.org> *On
> Behalf Of *Wayne Li
> *Sent:* Thursday, December 5, 2019 2:26 PM
> *To:* bitbake-devel <bitbake-devel@lists.openembedded.org>; Yocto Project
> Discussion <yocto@yoctoproject.org>
> *Subject:* [yocto] Question about shipping files to package.
>
>
>
> Dear Yocto Developers,
>
>
>
> So I created a bitbake recipe to integrate kvm into my image as an
> out-of-tree kernel module.  Here's my recipe right now:
>
>
>
> LICENSE =3D "GPLv2"
> LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dc616d0e7924e9e78ee192d99a3b26f=
bd"
>
> inherit module
>
> SRC_URI =3D "
> file:///homead/QorIQ-SDK-V2.0-20160527-yocto/sources/meta-virtualization/=
recipes-kernel/kvm-kmodule/kvm-kmod-3.10.21.tar.bz2
> "
>
> S =3D "${WORKDIR}/kvm-kmod-3.10.21"
>
> do_configure() {
>     ./configure --arch=3Dppc64
> --kerneldir=3D/homead/QorIQ-SDK-V2.0-20160527-yocto/build_t4240rdb-64b/tm=
p/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel
> }
>
> FILES_${PN} +=3D "/lib/modules/4.1.8-rt8+gbd51baf"
>
>
>
> Bitbaking this recipe completes with no problems but no kernel module is
> created (compiling the source code should create a kernel module file
> kvm.ko).  I was wondering if the problem might be because of what I set
> FILES_${PN} to be.  Before I set the FILES variable I was getting an erro=
r
> saying something along the lines of, "Files/directories were installed bu=
t
> not shipped."  Then I more or less just guessed a directory and set my
> FILES variable to it and then the recipe finished bitbaking with no error=
s.
>
>
>
> But now that the kvm.ko file isn't even being created, I am wondering if
> it might be because I set the FILES variable wrong?  What does the word
> "ship" mean?  And along those lines what exactly is a "package" in the
> setting of Yocto project?
>
>
>
> -Thanks!, Wayne Li
>
>

--000000000000b024f405995feb1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That makes a lot of sense.=C2=A0 The version I&#39;m on is=
: PV=3D&quot;4.1&quot; (I just ran bitbake -e virtual/kernel | grep &quot;^=
PV&quot;).<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Dec 10, 2019 at 8:54 PM McKay, Sean &lt;<a href=3D"=
mailto:sean.mckay@hpe.com">sean.mckay@hpe.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_-3875789674800328248WordSection1">
<p class=3D"MsoNormal">If the issue were <i>just</i> that your FILES_* vari=
ables were set incorrectly, you=E2=80=99d at least end up with the .ko file=
 somewhere in your ${WORKDIR}/image (${D}) directory. You=E2=80=99d almost =
certainly find another one in the build or source
 directory as well (depending on how your .bb/bbclass files define the loca=
tion of the compilation).<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">The fact that you don=E2=80=99t have one anywhere se=
ems to indicate that your do_compile step isn=E2=80=99t actually generating=
 the .ko that you expect it to, so you=E2=80=99ll need to rewind your recip=
e creation to working on that step and debug there.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Assuming you=E2=80=99re using poky as a base, what v=
ersion are you on so I can go read the .bbclass you=E2=80=99re using?<u></u=
><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">-Sean<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><b>From:</b> Wayne Li &lt;<a href=3D"mailto:waynli32=
9@gmail.com" target=3D"_blank">waynli329@gmail.com</a>&gt; <br>
<b>Sent:</b> Tuesday, December 10, 2019 12:23 PM<br>
<b>To:</b> McKay, Sean &lt;<a href=3D"mailto:sean.mckay@hpe.com" target=3D"=
_blank">sean.mckay@hpe.com</a>&gt;<br>
<b>Cc:</b> bitbake-devel &lt;<a href=3D"mailto:bitbake-devel@lists.openembe=
dded.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a>&gt;; Y=
octo Project Discussion &lt;<a href=3D"mailto:yocto@yoctoproject.org" targe=
t=3D"_blank">yocto@yoctoproject.org</a>&gt;<br>
<b>Subject:</b> Re: [yocto] Question about shipping files to package.<u></u=
><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">I did a find for any files with a kvm and a .ko in i=
ts name throughout my entire workspace and nothing came up.=C2=A0 But anywa=
y, thanks for the explanation.=C2=A0 Could packaging the files wrong (i.e. =
setting the FILES variable wrong) cause the
 kvm.ko file to never show up at all?=C2=A0 I guess that couldn&#39;t be th=
e case though because the .ko files are created first before it gets packag=
ed up so if they were created in the first place a search through my entire=
 workspace would turn them up.=C2=A0 Is that correct?<u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Thu, Dec 5, 2019 at 11:14 PM McKay, Sean &lt;<a h=
ref=3D"mailto:sean.mckay@hpe.com" target=3D"_blank">sean.mckay@hpe.com</a>&=
gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-color:currentcolor currentcolor currentcolor rg=
b(204,204,204);border-style:none none none solid;border-width:medium medium=
 medium 1pt;padding:0in 0in 0in 6pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal">I=E2=80=99m not an expert on compiling kernel module=
s, but I can at least answer some of your questions to get started. I=E2=80=
=99m also not an actual expert, but just another user, so it=E2=80=99s enti=
rely
 possible that someone more knowledgeable will come along and tell us that =
I=E2=80=99m wrong.<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">With that said, first, I have to ask the simple stuf=
f: when you say that no .ko is being created, where are you looking? If you=
=E2=80=99re not sure where you should be looking, I=E2=80=99d recommend
 by doing a find inside of your ${WORKDIR} to see whether or not you=E2=80=
=99ve got any .ko files. They won=E2=80=99t quite be out in plain sight.<u>=
</u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">In general (though again, I can=E2=80=99t speak for =
the module class), compilations take place in a build directory inside of t=
he recipe=E2=80=99s workdir (${B} in bitbake parlance). The install
 process then copies the created files to a staging directory (${D} in bitb=
ake parlance) that=E2=80=99s usually ${WORKDIR}/image.<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Packaging is the process of taking those output file=
s from ${D} and packaging them into one of a few well defined packaging for=
mats. If you=E2=80=99re using the defaults, this would be
 RPM. A single recipe can (and often does) produce multiple packages. When =
bitbake moves onto the packaging step (I=E2=80=99m simplifying a bit), it c=
reates directories for each package that=E2=80=99s going to be generated in=
side of ${WORKDIR}/packages-split. It then looks
 at the FILES variable for the particular package it=E2=80=99s working on a=
nd copies any files that match the patterns in that variable into that pack=
age=E2=80=99s directory in packages-split. When it=E2=80=99s done copying f=
iles, each of those directories are turned into the appropriate
 package (probably .rpm) file.<u></u><u></u></p>
<p class=3D"MsoNormal">So, for a somewhat more concrete example, when you s=
aid =E2=80=98FILES_${PN} +=3D &quot;/lib/modules/4.1.8-rt8+gbd51baf&quot;=
=E2=80=99, you told bitbake that anything that matched /lib/modules/4.1.8-r=
t8+gbd51baf
 should get put in the ${PN} (main) package.<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">In the context of the error message you were previou=
sly receiving, =E2=80=9Cinstalled=E2=80=9D is the do_install step, which is=
 referring to that staging process (analogous to running =E2=80=98make inst=
all=E2=80=99
 on something you just downloaded from the internet). Something is =E2=80=
=98shipped=E2=80=99 if it is packaged into one of the final rpm files.
<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Cheers!<u></u><u></u></p>
<p class=3D"MsoNormal">-Sean McKay<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal"><b>From:</b>
<a href=3D"mailto:yocto@lists.yoctoproject.org" target=3D"_blank">yocto@lis=
ts.yoctoproject.org</a> &lt;<a href=3D"mailto:yocto@lists.yoctoproject.org"=
 target=3D"_blank">yocto@lists.yoctoproject.org</a>&gt;
<b>On Behalf Of </b>Wayne Li<br>
<b>Sent:</b> Thursday, December 5, 2019 2:26 PM<br>
<b>To:</b> bitbake-devel &lt;<a href=3D"mailto:bitbake-devel@lists.openembe=
dded.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a>&gt;; Y=
octo Project Discussion &lt;<a href=3D"mailto:yocto@yoctoproject.org" targe=
t=3D"_blank">yocto@yoctoproject.org</a>&gt;<br>
<b>Subject:</b> [yocto] Question about shipping files to package.<u></u><u>=
</u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Dear Yocto Developers,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">So I created a bitbake recipe to integrate kvm into =
my image as an out-of-tree kernel module.=C2=A0 Here&#39;s my recipe right =
now:<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">LICENSE =3D &quot;GPLv2&quot;<br>
LIC_FILES_CHKSUM =3D &quot;<a>file://COPYING;md5=3Dc616d0e7924e9e78ee192d99=
a3b26fbd</a>&quot;<br>
<br>
inherit module<br>
<br>
SRC_URI =3D &quot;<a>file:///homead/QorIQ-SDK-V2.0-20160527-yocto/sources/m=
eta-virtualization/recipes-kernel/kvm-kmodule/kvm-kmod-3.10.21.tar.bz2</a>&=
quot;<br>
<br>
S =3D &quot;${WORKDIR}/kvm-kmod-3.10.21&quot;<br>
<br>
do_configure() {<br>
=C2=A0 =C2=A0 ./configure --arch=3Dppc64 --kerneldir=3D/homead/QorIQ-SDK-V2=
.0-20160527-yocto/build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel=
-devsrc/1.0-r0/image/usr/src/kernel<br>
}<br>
<br>
FILES_${PN} +=3D &quot;/lib/modules/4.1.8-rt8+gbd51baf&quot;<u></u><u></u><=
/p>
</div>
<div style=3D"margin-left:30pt">
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Bitbaking this recipe completes with no problems but=
 no kernel module is created (compiling the source code should create a ker=
nel module file kvm.ko).=C2=A0 I was wondering if the problem
 might be because of what I set FILES_${PN} to be.=C2=A0 Before I set the F=
ILES variable I was getting an error saying something along the lines of, &=
quot;Files/directories were installed but not shipped.&quot;=C2=A0 Then I m=
ore or less just guessed a directory and set my FILES
 variable to it and then the recipe finished bitbaking with no errors.<u></=
u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">But now that the kvm.ko file isn&#39;t even being cr=
eated, I am wondering if it might be because I set the FILES variable wrong=
?=C2=A0 What does the word &quot;ship&quot; mean?=C2=A0 And along those lin=
es
 what exactly is a &quot;package&quot; in the setting of Yocto project?<u><=
/u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">-Thanks!, Wayne Li<u></u><u></u></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>

</blockquote></div>

--000000000000b024f405995feb1f--
