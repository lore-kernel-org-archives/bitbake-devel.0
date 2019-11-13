Return-Path: <waynli329@gmail.com>
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
	[209.85.166.49])
	by mail.openembedded.org (Postfix) with ESMTP id E4B1F7F7C1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 17:51:53 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id i11so3485471iol.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3fVxO7IxIDotPZSYtqYDLZpqDeu5fqt9F+q4tzaPSOU=;
	b=H1hXn46Ti4HSs6Txukd0l8Z6jtoEoI82F8CVmsWceizlK41hs/D+EL5rT7qo42PgHu
	BQEayzX0nuhf9zGnJJMyJkQ0DH3K8UvNA3sU0cFfMULiKJvOrYijxm+mUgmrKwKaj+6Q
	yfvGoyA08KzpXkJ+UJejuL7wlFGkzqXYBzgr9jn7QnYI4jExVbprCoRuxkKXUsp1y0jU
	6v98LyWyxGsYkAtwxj/H/xrViaz3MGWXtxbbHSnFEZXN2lPwvYnDRJ8nsCX32YMaZH72
	DuPgjWJKvo7CNAbh6G28Flp1k0Jhj3e3gNIWoevShyVW4gsGo7NSsq+ZlgVumF7jCGIx
	CJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3fVxO7IxIDotPZSYtqYDLZpqDeu5fqt9F+q4tzaPSOU=;
	b=eXgcjXfNgQ1J49QsgADq6aXMmKtWUxm7x4YMpXy8Jlvc5ZvaQQ5qp+LfpkgjXPqiW6
	PlJxYkg6vqTAas+CXEniS8a1Fk2QnZebHlXdgRoLBsrrO++uVNwwyLtWzhlSZnfxa5Fk
	ZEKLR5++GCQgywjz79eMvIgUNTT6jnszICloopYOQAEGbLr+l6z548LUsfexP4rYV72n
	wHo85JcjW7/Zqo9rlm2oxC57ZA7MOtGo+BVsyuWIj6BTLgjGIsb+OAL7HyMbAqhnnBVs
	l5NBGnwFOPBcZYMfhTbl4SVPyRFfIF1rh6vSSHuoZ3ERElAjGIYMBm4fz19V223yOWFS
	ybqQ==
X-Gm-Message-State: APjAAAX0xsXv1qQjOkpnseS0p+5vekHNEa+I1fGJcnkGt4R21qKYGmlX
	Dzi9yavX93BWPCYD1nV/O4l+979gHb+xpZhU3JM=
X-Google-Smtp-Source: APXvYqyCppbkqIVZjRhZBB/FmfmRNc5guL1p+Im75OZC3de+Nr6mth66OT7cKETCb9XQ+rAlP0Nxpx3LJ4Rgokcj4bw=
X-Received: by 2002:a5e:a70e:: with SMTP id b14mr4829340iod.166.1573667514619; 
	Wed, 13 Nov 2019 09:51:54 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nqA0QGCcaN8z=qvtVu-U_aHswjqKTbZJ0YoCXE6OsvzQw@mail.gmail.com>
	<20191113083317.GA7340@localhost>
	<83ee3505594a6b5cb00eb643ece131c85aedeea0.camel@gmail.com>
In-Reply-To: <83ee3505594a6b5cb00eb643ece131c85aedeea0.camel@gmail.com>
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 13 Nov 2019 11:51:43 -0600
Message-ID: <CAM2K0nr_gPrDtx5QLz6x74a2CnDb8kERKcYu5bMJi8sg5PE62A@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
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
X-List-Received-Date: Wed, 13 Nov 2019 17:51:54 -0000
Content-Type: multipart/alternative; boundary="000000000000341d6c05973e0548"

--000000000000341d6c05973e0548
Content-Type: text/plain; charset="UTF-8"

So after further investigation, I'm fairly sure awk is actually present in
the target image.  Here are my reasons why I feel that this is the case:

-I looked at the busybox menuconfig GUI that comes up when I run "bitbake
-c menuconfig busybox" and it says awk is built-in.
-I looked at various def-config files I found by just doing a "grep -rn
"CONFIG_AWK"" and found that CONFIG_AWK seems to have been enabled
throughout the project (there was the line CONFIG_AWK=y uncommented in the
various def-config files I mentioned).
-I have an older version of the target image that my coworker (who has
since left the company) created.  I just need to rebuild this image because
I am trying to add some kernel modules to the image.  When I run the
command "awk" in the console for the T4240 RDB when the older version of
the image is loaded, I do see the gawk help info come up. This shows awk is
present in the older image.

But looking at what Khem Raj mentioned, perhaps bitbake is just not finding
the awk because it's actually in /usr/bin when bitbake expects it to be in
/bin?  Though I am a little confused about the link you sent, Khem Raj.
How do exactly do I apply this patch?  I'm assuming we have to change the
file ver_linux?  I did a "find . -name "ver_linux"" and I see multiple
results:

bash-4.2$ find . -name "ver_linux"
./build_t4240rdb-64b/tmp/work/ppc64e6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
./build_t4240rdb-64b/tmp/work/ppce6500-fslmllib32-linux/lib32-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/package/usr/src/kernel/scripts/ver_linux
./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel/scripts/ver_linux
./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/packages-split/kernel-devsrc/usr/src/kernel/scripts/ver_linux
./build_t4240rdb-64b/tmp/work-shared/t4240rdb-64b/kernel-source/scripts/ver_linux
./build_t4240rdb/tmp/work/ppc64e6500-fslmllib64-linux/lib64-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
./build_t4240rdb/tmp/work/ppce6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
./build_t4240rdb/tmp/work-shared/t4240rdb/kernel-source/scripts/ver_linux

Now the build I'm working on is build_t4240rdb-64b so the last three
results in that search probably don't matter.  Though there are still six
more results for when I search ver_linux.  So I'm not sure which one I need
to change.  Moreover, all of the ver_linux files I found more or less look
like the following:

https://gist.github.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677

Which seems to be very different from the ver_linux file mentioned in the
patch.  This further confuses me on how to apply the patch.

Or maybe do you guys think maybe the patch isn't the solution here?  Maybe
there's some other reason bitbake isn't finding the awk?

-Thanks!, Wayne Li

On Wed, Nov 13, 2019 at 10:57 AM Khem Raj <raj.khem@gmail.com> wrote:

> On Wed, 2019-11-13 at 10:33 +0200, Adrian Bunk wrote:
> > On Tue, Nov 12, 2019 at 04:08:48PM -0600, Wayne Li wrote:
> > > Dear Yocto Developers,
> > >
> > > I'm trying to to build a Yocto kernel for a T4240 RDB.  When I run
> > > "bitbake
> > > fsl-image-full" to build the entire linux image, I get an error
> > > that says
> > > "Can't install kernel-devsrc-1.0-r0@t4240rdb_64b: no package
> > > provides
> > > /bin/awk".  Here's the entire error print that I see:
> > >
> > > https://gist.github.com/WayneZhenLi/e35f65081092cf1f24df29ec369c701c
> > >
> > > Anyway I'm confused about this error because /bin/awk does
> > > exist.  Like if
> > > I run "/bin/awk" in the console I see help info come up describing
> > > how to
> > > use a program called "gawk".  Why can't bitbake find /bin/awk
> > > then?  Or am
> > > I misunderstanding what this error is trying to say?  I mean I'm
> > > assuming
> > > it's just not able to find /bin/awk but maybe the error means
> > > something
> > > else?  Or maybe /bin/awk is actually relative to some path?  Let me
> > > know
> > > your thoughts.
> >
> > /bin/awk is missing on your target image that will run on the T4240
> > RDB.
> >
> > The smallest implementation is to enable CONFIG_AWK in your busybox
> > config.
> >
>
> import something like below patch into your kernel will help too
>
>
> https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=8af11c1cdd8fa08217e702b57cf96e9030db52b2
>
> > > -Thanks!, Wayne Li
> >
> > cu
> > Adrian
> >
> > --
> >
> >        "Is there not promise of rain?" Ling Tan asked suddenly out
> >         of the darkness. There had been need of rain for many days.
> >        "Only a promise," Lao Er said.
> >                                        Pearl S. Buck - Dragon Seed
> >
>
>

--000000000000341d6c05973e0548
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>So after further investigation, I&#39;m fairly sure a=
wk is actually present in the target image.=C2=A0 Here are my reasons why I=
 feel that this is the case:</div><div><br></div><div>-I looked at the busy=
box menuconfig GUI that comes up when I run &quot;bitbake -c menuconfig bus=
ybox&quot; and it says awk is built-in.=C2=A0 <br></div><div>-I looked at v=
arious def-config files I found by just doing a &quot;grep -rn &quot;CONFIG=
_AWK&quot;&quot; and found that CONFIG_AWK seems to have been enabled throu=
ghout the project (there was the line CONFIG_AWK=3Dy uncommented in the var=
ious def-config files I mentioned).=C2=A0 <br></div><div>-I have an older v=
ersion of the target image that my coworker (who has since left the company=
) created.=C2=A0 I just need to rebuild this image because I am trying to a=
dd some kernel modules to the image.=C2=A0 When I run the command &quot;awk=
&quot; in the console for the T4240 RDB when the older version of the image=
 is loaded, I do see the gawk help info come up. This shows awk is present =
in the older image.</div><div><br></div><div>But looking at what Khem Raj m=
entioned, perhaps bitbake is just not finding the awk because it&#39;s actu=
ally in /usr/bin when bitbake expects it to be in /bin?=C2=A0 Though I am a=
 little confused about the link you sent, Khem Raj.=C2=A0 How do exactly do=
 I apply this patch?=C2=A0 I&#39;m assuming we have to change the file ver_=
linux?=C2=A0 I did a &quot;find . -name &quot;ver_linux&quot;&quot; and I s=
ee multiple results:</div><div><br></div><div>
bash-4.2$ find . -name &quot;ver_linux&quot;<br>./build_t4240rdb-64b/tmp/wo=
rk/ppc64e6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_lin=
ux<br>./build_t4240rdb-64b/tmp/work/ppce6500-fslmllib32-linux/lib32-linux-l=
ibc-headers/4.1-r0/linux-4.1/scripts/ver_linux<br>./build_t4240rdb-64b/tmp/=
work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/package/usr/src/kernel/scr=
ipts/ver_linux<br>./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kern=
el-devsrc/1.0-r0/image/usr/src/kernel/scripts/ver_linux<br>./build_t4240rdb=
-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/packages-split/ke=
rnel-devsrc/usr/src/kernel/scripts/ver_linux<br>./build_t4240rdb-64b/tmp/wo=
rk-shared/t4240rdb-64b/kernel-source/scripts/ver_linux<br>./build_t4240rdb/=
tmp/work/ppc64e6500-fslmllib64-linux/lib64-linux-libc-headers/4.1-r0/linux-=
4.1/scripts/ver_linux<br>./build_t4240rdb/tmp/work/ppce6500-fsl-linux/linux=
-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux<br>./build_t4240rdb/tmp/wo=
rk-shared/t4240rdb/kernel-source/scripts/ver_linux <br></div><div><br></div=
><div>Now the build I&#39;m working on is=20
build_t4240rdb-64b so the last three results in that search probably don&#3=
9;t matter.=C2=A0 Though there are still six more results for when I search=
 ver_linux.=C2=A0 So I&#39;m not sure which one I need to change.=C2=A0 Mor=
eover, all of the ver_linux files I found more or less look like the follow=
ing:</div><div><br></div><div><a href=3D"https://gist.github.com/WayneZhenL=
i/c7475cf382a80bfd2de31e82c40c1677">https://gist.github.com/WayneZhenLi/c74=
75cf382a80bfd2de31e82c40c1677</a></div><div><br></div><div>Which seems to b=
e very different from the ver_linux file mentioned in the patch.=C2=A0 This=
 further confuses me on how to apply the patch.=C2=A0 <br></div><div><br></=
div><div>Or maybe do you guys think maybe the patch isn&#39;t the solution =
here?=C2=A0 Maybe there&#39;s some other reason bitbake isn&#39;t finding t=
he awk?<br></div><div><br></div><div>-Thanks!, Wayne Li<br></div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, No=
v 13, 2019 at 10:57 AM Khem Raj &lt;<a href=3D"mailto:raj.khem@gmail.com">r=
aj.khem@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Wed, 2019-11-13 at 10:33 +0200, Adrian Bunk wrote:<br>
&gt; On Tue, Nov 12, 2019 at 04:08:48PM -0600, Wayne Li wrote:<br>
&gt; &gt; Dear Yocto Developers,<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m trying to to build a Yocto kernel for a T4240 RDB.=C2=A0 =
When I run<br>
&gt; &gt; &quot;bitbake<br>
&gt; &gt; fsl-image-full&quot; to build the entire linux image, I get an er=
ror<br>
&gt; &gt; that says<br>
&gt; &gt; &quot;Can&#39;t install kernel-devsrc-1.0-r0@t4240rdb_64b: no pac=
kage<br>
&gt; &gt; provides<br>
&gt; &gt; /bin/awk&quot;.=C2=A0 Here&#39;s the entire error print that I se=
e:<br>
&gt; &gt; <br>
&gt; &gt; <a href=3D"https://gist.github.com/WayneZhenLi/e35f65081092cf1f24=
df29ec369c701c" rel=3D"noreferrer" target=3D"_blank">https://gist.github.co=
m/WayneZhenLi/e35f65081092cf1f24df29ec369c701c</a><br>
&gt; &gt; <br>
&gt; &gt; Anyway I&#39;m confused about this error because /bin/awk does<br=
>
&gt; &gt; exist.=C2=A0 Like if<br>
&gt; &gt; I run &quot;/bin/awk&quot; in the console I see help info come up=
 describing<br>
&gt; &gt; how to<br>
&gt; &gt; use a program called &quot;gawk&quot;.=C2=A0 Why can&#39;t bitbak=
e find /bin/awk<br>
&gt; &gt; then?=C2=A0 Or am<br>
&gt; &gt; I misunderstanding what this error is trying to say?=C2=A0 I mean=
 I&#39;m<br>
&gt; &gt; assuming<br>
&gt; &gt; it&#39;s just not able to find /bin/awk but maybe the error means=
<br>
&gt; &gt; something<br>
&gt; &gt; else?=C2=A0 Or maybe /bin/awk is actually relative to some path?=
=C2=A0 Let me<br>
&gt; &gt; know<br>
&gt; &gt; your thoughts.<br>
&gt; <br>
&gt; /bin/awk is missing on your target image that will run on the T4240<br=
>
&gt; RDB.<br>
&gt; <br>
&gt; The smallest implementation is to enable CONFIG_AWK in your busybox<br=
>
&gt; config.<br>
&gt; <br>
<br>
import something like below patch into your kernel will help too<br>
<br>
<a href=3D"https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?i=
d=3D8af11c1cdd8fa08217e702b57cf96e9030db52b2" rel=3D"noreferrer" target=3D"=
_blank">https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=
=3D8af11c1cdd8fa08217e702b57cf96e9030db52b2</a><br>
<br>
&gt; &gt; -Thanks!, Wayne Li<br>
&gt; <br>
&gt; cu<br>
&gt; Adrian<br>
&gt; <br>
&gt; -- <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Is there not promise of rain?&quot; L=
ing Tan asked suddenly out<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of the darkness. There had been need =
of rain for many days.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Only a promise,&quot; Lao Er said.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Pearl=
 S. Buck - Dragon Seed<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000341d6c05973e0548--
