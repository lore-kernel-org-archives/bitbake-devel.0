Return-Path: <waynli329@gmail.com>
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com
	[209.85.166.45])
	by mail.openembedded.org (Postfix) with ESMTP id 170857E6EF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 19:43:57 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id j13so3966986ioe.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 11:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gZJYYavGSLnPHmi8xYT5E8QTDTeiwtEtL3ghZOE2bbc=;
	b=oIO57x5/Y0GzAJQ1vr332Q7A+5StkTgx/jOlDpA3OuNUPBOq3XQ/Ms92jeuh5HCWL5
	CKHPtifjaIHOCZeOBzXXojxD50ZRJIEd7/rjYfcIDlJuLjGaxDdzECdSjPs+alI8hcTU
	3RQa+ezX5zGco+v+tstVIwdm7nrOaVf6hroobXRCvIr0e6Mm+8DfUdkMReVYdj9+XohQ
	isQZrY5T7msf4ZE9EbZpcjoX/qt7JZWX2mQdAzCD2dUTREgkZPEacG3YF8Tvna4mpcn3
	kKwc9Fg6SXFYmgDqhp2b+/reQ+8UYeyCgggIZFj1Kc7tnUoUz8XDXIzgY0EOuXWOeE6h
	Twuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gZJYYavGSLnPHmi8xYT5E8QTDTeiwtEtL3ghZOE2bbc=;
	b=HqvFcD0ch/xCSn5EX5DhnxTu4kcp4cHr1xSG6eoDHsbqlxwo3bvfVv9EGPS05AEVli
	QYTzlG0tTr8zRDt8sYLNwTZ3j2hY5VBIQXAtlarJEwbTPSSpXRhvDd5SGQhDVtnOGg21
	/DGcIk6gqE/3G2NAuWUKXmQr4fdtW9t4if6EFJvinjGGZ0jjBQ/ZrrcgX6bR1m/DZvxq
	r1OGlWXDgCIzWVbPlnuftcJRsS22OZgBDbK3uQ8p6lf4aH56w40rHL0Qbj3uwdXx1bDP
	53fJEslweqax2X9q1EcuXG227lpxaSwrZMgowH2FRIfgFFKFx92OvcQHMRPZgXET0tkZ
	Nn7Q==
X-Gm-Message-State: APjAAAW10Wf9zx2JL13L9lFWp2AXVMWKRuoMYBEFJlAFLt3DdN0hlYpf
	RrmiGtx6r9ovVqhe6Q9J6lQrRZcHUM2ivCmqkh0=
X-Google-Smtp-Source: APXvYqxSz/2a2cTXb7ZENGmw1SRLXYftzIC0Y1weSocrGMhgkoyW+KZkaP1jntylYFMtHyatC48umLruwmZy4unpcP0=
X-Received: by 2002:a6b:f60f:: with SMTP id n15mr2874493ioh.263.1573674237998; 
	Wed, 13 Nov 2019 11:43:57 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nqA0QGCcaN8z=qvtVu-U_aHswjqKTbZJ0YoCXE6OsvzQw@mail.gmail.com>
	<20191113083317.GA7340@localhost>
	<83ee3505594a6b5cb00eb643ece131c85aedeea0.camel@gmail.com>
	<CAM2K0nr_gPrDtx5QLz6x74a2CnDb8kERKcYu5bMJi8sg5PE62A@mail.gmail.com>
	<CAM2K0nrhK-z1M9uFzxVOrsk0s4+npm3KX0rDh6dx+SOs6sn_gQ@mail.gmail.com>
	<CAM2K0npPofZEYUSjBvUXUN8TjpE_JaHZFr7EAdE=i2wSQVCQ8Q@mail.gmail.com>
	<698c95f2-4784-f7de-7a4b-2283a3b2f16e@kernel.crashing.org>
In-Reply-To: <698c95f2-4784-f7de-7a4b-2283a3b2f16e@kernel.crashing.org>
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 13 Nov 2019 13:43:46 -0600
Message-ID: <CAM2K0nrUOPhVTVi0r=ni=kN1YcgaEeiPKyW9q7KBqA-c8EfwxQ@mail.gmail.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: Yocto Project Discussion <yocto@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Adrian Bunk <bunk@stusta.de>
Subject: Re: [yocto] No Package Provides /bin/awk
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
X-List-Received-Date: Wed, 13 Nov 2019 19:43:58 -0000
Content-Type: multipart/alternative; boundary="000000000000f2bb8d05973f95c6"

--000000000000f2bb8d05973f95c6
Content-Type: text/plain; charset="UTF-8"

Sorry I am fairly new to bitbake.  How do I apply a patch?  Why do I have
to apply a patch as opposed to just editing corresponding files (I know
that is probably a dumb question but again I am very new to bitbake)?  Khem
Raj did mention a patch to fix the problem:

https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=8af11c1cdd8fa08217e702b57cf96e9030db52b2

Would I be able to somehow take the patch from that website and apply it to
my project?  Though I'd like to mention again it seems like that patch is
trying to change  "#!/bin/awk -f" to "#!/usr/bin/awk -f" in the ver_linux
file.  But the ver_linux files in my project look very different from the
ver_linux file in the patch (see example of my ver_linux file:
https://gist.github.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677) and
has "#!/bin/sh" for its #! line instead.  In that case, would the patch
Khem Raj mentioned even work for my project?  Again I'm new to bitbake so I
apologize for my questions being naive.

On Wed, Nov 13, 2019 at 12:31 PM Mark Hatle <mark.hatle@kernel.crashing.org>
wrote:

> Bitbake inspects the binaries and looks at the #! line.  You need to
> change the
> line itself (via a patch) to /usr/bin/awk, and then it will pick up the
> dependency automatically on a rebuild.
>
> --Mark
>
> On 11/13/19 12:14 PM, Wayne Li wrote:
> > On further inspection of the older image my coworker made, it looks like
> awk is
> > located at "/usr/bin/awk".  I see this by just doing a "which awk" in the
> > console of the T4240 RDB when the old image is loaded.  So it looks like
> the
> > most likely case is that Khem Raj is correct and that bitbake is
> expecting awk
> > to be in "/bin" when awk is actually in "/usr/bin".  In that case, I
> need to
> > know where the line telling bitbake to look for awk in the "/bin"
> directory is.
> >
> > On Wed, Nov 13, 2019 at 12:02 PM Wayne Li <waynli329@gmail.com
> > <mailto:waynli329@gmail.com>> wrote:
> >
> >     I'd like also like to mention that my main concern with the
> ver_linux files
> >     that I found in my project was that the shebang line was " #!/bin/sh"
> >     instead of "#!/bin/awk -f" which is the shebang line in the
> ver_linux file
> >     in the patch.  The patch wants to change the shebang line from
> "#!/bin/awk
> >     -f" to  "#!/usr/bin/awk -f" so I'm not sure how that change would
> translate
> >     when I'm working with the shebang line "#!/bin/sh".  Or perhaps
> Yocto has
> >     changed since that patch was posted and maybe the place /bin/awk is
> >     specified is different?
> >
> >     On Wed, Nov 13, 2019 at 11:51 AM Wayne Li <waynli329@gmail.com
> >     <mailto:waynli329@gmail.com>> wrote:
> >
> >         So after further investigation, I'm fairly sure awk is actually
> present
> >         in the target image.  Here are my reasons why I feel that this
> is the case:
> >
> >         -I looked at the busybox menuconfig GUI that comes up when I run
> >         "bitbake -c menuconfig busybox" and it says awk is built-in.
> >         -I looked at various def-config files I found by just doing a
> "grep -rn
> >         "CONFIG_AWK"" and found that CONFIG_AWK seems to have been
> enabled
> >         throughout the project (there was the line CONFIG_AWK=y
> uncommented in
> >         the various def-config files I mentioned).
> >         -I have an older version of the target image that my coworker
> (who has
> >         since left the company) created.  I just need to rebuild this
> image
> >         because I am trying to add some kernel modules to the image.
> When I run
> >         the command "awk" in the console for the T4240 RDB when the older
> >         version of the image is loaded, I do see the gawk help info come
> up.
> >         This shows awk is present in the older image.
> >
> >         But looking at what Khem Raj mentioned, perhaps bitbake is just
> not
> >         finding the awk because it's actually in /usr/bin when bitbake
> expects
> >         it to be in /bin?  Though I am a little confused about the link
> you
> >         sent, Khem Raj.  How do exactly do I apply this patch?  I'm
> assuming we
> >         have to change the file ver_linux?  I did a "find . -name
> "ver_linux""
> >         and I see multiple results:
> >
> >         bash-4.2$ find . -name "ver_linux"
> >
>  ./build_t4240rdb-64b/tmp/work/ppc64e6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
> >
>  ./build_t4240rdb-64b/tmp/work/ppce6500-fslmllib32-linux/lib32-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
> >
>  ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/package/usr/src/kernel/scripts/ver_linux
> >
>  ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel/scripts/ver_linux
> >
>  ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/packages-split/kernel-devsrc/usr/src/kernel/scripts/ver_linux
> >
>  ./build_t4240rdb-64b/tmp/work-shared/t4240rdb-64b/kernel-source/scripts/ver_linux
> >
>  ./build_t4240rdb/tmp/work/ppc64e6500-fslmllib64-linux/lib64-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
> >
>  ./build_t4240rdb/tmp/work/ppce6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
> >
>  ./build_t4240rdb/tmp/work-shared/t4240rdb/kernel-source/scripts/ver_linux
> >
> >         Now the build I'm working on is build_t4240rdb-64b so the last
> three
> >         results in that search probably don't matter.  Though there are
> still
> >         six more results for when I search ver_linux.  So I'm not sure
> which one
> >         I need to change.  Moreover, all of the ver_linux files I found
> more or
> >         less look like the following:
> >
> >
> https://gist.github.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677
> >
> >         Which seems to be very different from the ver_linux file
> mentioned in
> >         the patch.  This further confuses me on how to apply the patch.
> >
> >         Or maybe do you guys think maybe the patch isn't the solution
> here?
> >         Maybe there's some other reason bitbake isn't finding the awk?
> >
> >         -Thanks!, Wayne Li
> >
> >         On Wed, Nov 13, 2019 at 10:57 AM Khem Raj <raj.khem@gmail.com
> >         <mailto:raj.khem@gmail.com>> wrote:
> >
> >             On Wed, 2019-11-13 at 10:33 +0200, Adrian Bunk wrote:
> >             > On Tue, Nov 12, 2019 at 04:08:48PM -0600, Wayne Li wrote:
> >             > > Dear Yocto Developers,
> >             > >
> >             > > I'm trying to to build a Yocto kernel for a T4240 RDB.
> When I run
> >             > > "bitbake
> >             > > fsl-image-full" to build the entire linux image, I get
> an error
> >             > > that says
> >             > > "Can't install kernel-devsrc-1.0-r0@t4240rdb_64b: no
> package
> >             > > provides
> >             > > /bin/awk".  Here's the entire error print that I see:
> >             > >
> >             > >
> https://gist.github.com/WayneZhenLi/e35f65081092cf1f24df29ec369c701c
> >             > >
> >             > > Anyway I'm confused about this error because /bin/awk
> does
> >             > > exist.  Like if
> >             > > I run "/bin/awk" in the console I see help info come up
> describing
> >             > > how to
> >             > > use a program called "gawk".  Why can't bitbake find
> /bin/awk
> >             > > then?  Or am
> >             > > I misunderstanding what this error is trying to say?  I
> mean I'm
> >             > > assuming
> >             > > it's just not able to find /bin/awk but maybe the error
> means
> >             > > something
> >             > > else?  Or maybe /bin/awk is actually relative to some
> path?  Let me
> >             > > know
> >             > > your thoughts.
> >             >
> >             > /bin/awk is missing on your target image that will run on
> the T4240
> >             > RDB.
> >             >
> >             > The smallest implementation is to enable CONFIG_AWK in
> your busybox
> >             > config.
> >             >
> >
> >             import something like below patch into your kernel will help
> too
> >
> >
> https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=8af11c1cdd8fa08217e702b57cf96e9030db52b2
> >
> >             > > -Thanks!, Wayne Li
> >             >
> >             > cu
> >             > Adrian
> >             >
> >             > --
> >             >
> >             >        "Is there not promise of rain?" Ling Tan asked
> suddenly out
> >             >         of the darkness. There had been need of rain for
> many days.
> >             >        "Only a promise," Lao Er said.
> >             >                                        Pearl S. Buck -
> Dragon Seed
> >             >
> >
> >
>

--000000000000f2bb8d05973f95c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry I am fairly new to bitbake.=C2=A0 How do I appl=
y a patch?=C2=A0 Why do I have to apply a patch as opposed to just editing =
corresponding files (I know that is probably a dumb question but again I am=
 very new to bitbake)?=C2=A0 Khem Raj did mention a patch to fix the proble=
m:</div><div><br></div><div><a href=3D"https://git.yoctoproject.org/cgit/cg=
it.cgi/linux-yocto/commit/?id=3D8af11c1cdd8fa08217e702b57cf96e9030db52b2">h=
ttps://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=3D8af11c1c=
dd8fa08217e702b57cf96e9030db52b2</a></div><div><br></div><div>Would I be ab=
le to somehow take the patch from that website and apply it to my project?=
=C2=A0 Though I&#39;d like to mention again it seems like that patch is try=
ing to change=C2=A0
<span>&quot;#!/bin/awk -f&quot;</span> to=20
<span>&quot;#!/usr/bin/awk -f&quot; in the ver_linux file.=C2=A0 But the ve=
r_linux files in my project look very different from the ver_linux file in =
the patch (see example of my ver_linux file: <a href=3D"https://gist.github=
.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677">https://gist.github.com/=
WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677</a>) and has <span>&quot;<span=
><span>#!</span>/bin/sh&quot;</span></span> for its #! line instead.=C2=A0 =
In that case, would the patch Khem Raj mentioned even work for my project?=
=C2=A0 Again I&#39;m new to bitbake so I apologize for my questions being n=
aive.</span>

</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, Nov 13, 2019 at 12:31 PM Mark Hatle &lt;<a href=3D"mailto:mar=
k.hatle@kernel.crashing.org">mark.hatle@kernel.crashing.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Bitbake inspects=
 the binaries and looks at the #! line.=C2=A0 You need to change the<br>
line itself (via a patch) to /usr/bin/awk, and then it will pick up the<br>
dependency automatically on a rebuild.<br>
<br>
--Mark<br>
<br>
On 11/13/19 12:14 PM, Wayne Li wrote:<br>
&gt; On further inspection of the older image my coworker made, it looks li=
ke awk is<br>
&gt; located at &quot;/usr/bin/awk&quot;.=C2=A0 I see this by just doing a =
&quot;which awk&quot; in the<br>
&gt; console of the T4240 RDB when the old image is loaded.=C2=A0 So it loo=
ks like the<br>
&gt; most likely case is that Khem Raj is correct and that bitbake is expec=
ting awk<br>
&gt; to be in &quot;/bin&quot; when awk is actually in &quot;/usr/bin&quot;=
.=C2=A0 In that case, I need to<br>
&gt; know where the line telling bitbake to look for awk in the &quot;/bin&=
quot; directory is.<br>
&gt; <br>
&gt; On Wed, Nov 13, 2019 at 12:02 PM Wayne Li &lt;<a href=3D"mailto:waynli=
329@gmail.com" target=3D"_blank">waynli329@gmail.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:waynli329@gmail.com" target=3D"_blank">wa=
ynli329@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;d like also like to mention that my main conc=
ern with the ver_linux files<br>
&gt;=C2=A0 =C2=A0 =C2=A0that I found in my project was that the shebang lin=
e was &quot; #!/bin/sh&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead of &quot;#!/bin/awk -f&quot; which is the s=
hebang line in the ver_linux file<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the patch.=C2=A0 The patch wants to change the s=
hebang line from &quot;#!/bin/awk<br>
&gt;=C2=A0 =C2=A0 =C2=A0-f&quot; to=C2=A0 &quot;#!/usr/bin/awk -f&quot; so =
I&#39;m not sure how that change would translate<br>
&gt;=C2=A0 =C2=A0 =C2=A0when I&#39;m working with the shebang line &quot;#!=
/bin/sh&quot;.=C2=A0 Or perhaps Yocto has<br>
&gt;=C2=A0 =C2=A0 =C2=A0changed since that patch was posted and maybe the p=
lace /bin/awk is<br>
&gt;=C2=A0 =C2=A0 =C2=A0specified is different?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Wed, Nov 13, 2019 at 11:51 AM Wayne Li &lt;<a hr=
ef=3D"mailto:waynli329@gmail.com" target=3D"_blank">waynli329@gmail.com</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:waynli329@gmail.com" t=
arget=3D"_blank">waynli329@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0So after further investigation, I&#39=
;m fairly sure awk is actually present<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in the target image.=C2=A0 Here are m=
y reasons why I feel that this is the case:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-I looked at the busybox menuconfig G=
UI that comes up when I run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;bitbake -c menuconfig busybox&q=
uot; and it says awk is built-in.=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-I looked at various def-config files=
 I found by just doing a &quot;grep -rn<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;CONFIG_AWK&quot;&quot; and foun=
d that CONFIG_AWK seems to have been enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throughout the project (there was the=
 line CONFIG_AWK=3Dy uncommented in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the various def-config files I mentio=
ned).=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-I have an older version of the targe=
t image that my coworker (who has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0since left the company) created.=C2=
=A0 I just need to rebuild this image<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0because I am trying to add some kerne=
l modules to the image.=C2=A0 When I run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the command &quot;awk&quot; in the co=
nsole for the T4240 RDB when the older<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version of the image is loaded, I do =
see the gawk help info come up.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This shows awk is present in the olde=
r image.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0But looking at what Khem Raj mentione=
d, perhaps bitbake is just not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0finding the awk because it&#39;s actu=
ally in /usr/bin when bitbake expects<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it to be in /bin?=C2=A0 Though I am a=
 little confused about the link you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sent, Khem Raj.=C2=A0 How do exactly =
do I apply this patch?=C2=A0 I&#39;m assuming we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0have to change the file ver_linux?=C2=
=A0 I did a &quot;find . -name &quot;ver_linux&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and I see multiple results:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bash-4.2$ find . -name &quot;ver_linu=
x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb-64b/tmp/work/ppc64e6=
500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb-64b/tmp/work/ppce650=
0-fslmllib32-linux/lib32-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_li=
nux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb-64b/tmp/work/t4240rd=
b_64b-fsl-linux/kernel-devsrc/1.0-r0/package/usr/src/kernel/scripts/ver_lin=
ux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb-64b/tmp/work/t4240rd=
b_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel/scripts/ver_linux=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb-64b/tmp/work/t4240rd=
b_64b-fsl-linux/kernel-devsrc/1.0-r0/packages-split/kernel-devsrc/usr/src/k=
ernel/scripts/ver_linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb-64b/tmp/work-shared/=
t4240rdb-64b/kernel-source/scripts/ver_linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb/tmp/work/ppc64e6500-=
fslmllib64-linux/lib64-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linu=
x<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb/tmp/work/ppce6500-fs=
l-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./build_t4240rdb/tmp/work-shared/t424=
0rdb/kernel-source/scripts/ver_linux<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Now the build I&#39;m working on is b=
uild_t4240rdb-64b so the last three<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0results in that search probably don&#=
39;t matter.=C2=A0 Though there are still<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0six more results for when I search ve=
r_linux.=C2=A0 So I&#39;m not sure which one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I need to change.=C2=A0 Moreover, all=
 of the ver_linux files I found more or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0less look like the following:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://gist.github.com/Wa=
yneZhenLi/c7475cf382a80bfd2de31e82c40c1677" rel=3D"noreferrer" target=3D"_b=
lank">https://gist.github.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677<=
/a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Which seems to be very different from=
 the ver_linux file mentioned in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the patch.=C2=A0 This further confuse=
s me on how to apply the patch.=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Or maybe do you guys think maybe the =
patch isn&#39;t the solution here?=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Maybe there&#39;s some other reason b=
itbake isn&#39;t finding the awk?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Thanks!, Wayne Li<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Wed, Nov 13, 2019 at 10:57 AM Khem=
 Raj &lt;<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">raj.khem@g=
mail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:raj.khem=
@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Wed, 2019-11-13 at 1=
0:33 +0200, Adrian Bunk wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Tue, Nov 12, 20=
19 at 04:08:48PM -0600, Wayne Li wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; Dear Yocto De=
velopers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; I&#39;m tryin=
g to to build a Yocto kernel for a T4240 RDB.=C2=A0 When I run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; &quot;bitbake=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; fsl-image-ful=
l&quot; to build the entire linux image, I get an error<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; that says<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; &quot;Can&#39=
;t install kernel-devsrc-1.0-r0@t4240rdb_64b: no package<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; provides<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; /bin/awk&quot=
;.=C2=A0 Here&#39;s the entire error print that I see:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; <a href=3D"ht=
tps://gist.github.com/WayneZhenLi/e35f65081092cf1f24df29ec369c701c" rel=3D"=
noreferrer" target=3D"_blank">https://gist.github.com/WayneZhenLi/e35f65081=
092cf1f24df29ec369c701c</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; Anyway I&#39;=
m confused about this error because /bin/awk does<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; exist.=C2=A0 =
Like if<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; I run &quot;/=
bin/awk&quot; in the console I see help info come up describing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; how to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; use a program=
 called &quot;gawk&quot;.=C2=A0 Why can&#39;t bitbake find /bin/awk<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; then?=C2=A0 O=
r am<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; I misundersta=
nding what this error is trying to say?=C2=A0 I mean I&#39;m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; assuming<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; it&#39;s just=
 not able to find /bin/awk but maybe the error means<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; something<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; else?=C2=A0 O=
r maybe /bin/awk is actually relative to some path?=C2=A0 Let me<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; know<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; your thoughts=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; /bin/awk is missin=
g on your target image that will run on the T4240<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; RDB.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; The smallest imple=
mentation is to enable CONFIG_AWK in your busybox<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; config.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import something like b=
elow patch into your kernel will help too<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://git.=
yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=3D8af11c1cdd8fa08217e=
702b57cf96e9030db52b2" rel=3D"noreferrer" target=3D"_blank">https://git.yoc=
toproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=3D8af11c1cdd8fa08217e702=
b57cf96e9030db52b2</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &gt; -Thanks!, Way=
ne Li<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; cu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Adrian<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Is there not promise of rain?&quot; Ling Tan asked suddenl=
y out<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0of the darkness. There had been need of rain for many days=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Only a promise,&quot; Lao Er said.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Pearl S. Buck - Dragon See=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt; <br>
</blockquote></div>

--000000000000f2bb8d05973f95c6--
