Return-Path: <waynli329@gmail.com>
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
	[209.85.166.51])
	by mail.openembedded.org (Postfix) with ESMTP id 3B75C7F7B7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 18:14:29 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id 1so3639148iou.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=DLIMlGtct6o6yhG/+wl9N7RnFazZl5uWLT9p57hfc4A=;
	b=WulQoLQRSkFc1bf5TkQsjLBP4CFqaYtfeRzAZ+5a0kIagyShNHENAho4SjBzss99R3
	XC9Iocg9jEwRGH13ewkx06qg3cuUJdKAjPsNifITLsdP7kqp4SLXb6r9dYDNEKyqoRD0
	oOH9Uafx5RXMzENvjn8fOKBd6pwn+JHlS5g4wBF2/jmFcm2l/c1EmBk7Jzpr1kZMWx23
	4SreRTPZyLuINrYX+cJj8GtovXaumMwwy1ua14RaesppKFrIY+dk1PRMhZi2VoGSIe9Z
	nu7V/K4EiBmpJbt0IOAgs6o3m+3dH/rpEThL/iazZn+y7cJFH5rbDM/s5gKsj5HizfKL
	hOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=DLIMlGtct6o6yhG/+wl9N7RnFazZl5uWLT9p57hfc4A=;
	b=JFCF6Xyu+RYvmctcasAfIjBXaW8+Pvxx6RTx8BJqOvbs6IeQDHq2NZW2IlYw7LlZQO
	1fpKNQRXTMm2V1NR9FRSdgkE23XztPY3QF70yuTAk38iprac5hXfaVOAkCC8Y2GyRk24
	7A9xGqvdHYLATXWFESUkJcFLGP8q/ervgNqpFMgUWCIC9gj5Y7CWU48sNfEBXM4ir0XK
	PCAIpd+iVUN5QXjGoZBcP1yN6HxmDrQbRgziJV18xKphjyMeGSnQBPMzg2G058qEaPip
	tGbg5ijb8ynU+Zw7zcjg3a/U0kcSHjaiOO5Mhig+ddZZnngYMU/Se3n98rKB3+oirbc0
	GF8A==
X-Gm-Message-State: APjAAAXmoQkh0wRdmAt+G0PK7CBuNdW+bc9hLpD9RixCzAXl5oX3pxxw
	1USpJYcTJaRMEijjyhKXVzkpIoyzURYira6d6fg=
X-Google-Smtp-Source: APXvYqyY3t7d2rumPIQF3982JzsLPEWnF50JyJvm+0bLi6xh7fW5mJuNPvXp0ZXPyOk090JZp6Zth8GHyZ6xBTiFNNw=
X-Received: by 2002:a5e:9741:: with SMTP id h1mr4519416ioq.143.1573668870111; 
	Wed, 13 Nov 2019 10:14:30 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nqA0QGCcaN8z=qvtVu-U_aHswjqKTbZJ0YoCXE6OsvzQw@mail.gmail.com>
	<20191113083317.GA7340@localhost>
	<83ee3505594a6b5cb00eb643ece131c85aedeea0.camel@gmail.com>
	<CAM2K0nr_gPrDtx5QLz6x74a2CnDb8kERKcYu5bMJi8sg5PE62A@mail.gmail.com>
	<CAM2K0nrhK-z1M9uFzxVOrsk0s4+npm3KX0rDh6dx+SOs6sn_gQ@mail.gmail.com>
In-Reply-To: <CAM2K0nrhK-z1M9uFzxVOrsk0s4+npm3KX0rDh6dx+SOs6sn_gQ@mail.gmail.com>
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 13 Nov 2019 12:14:18 -0600
Message-ID: <CAM2K0npPofZEYUSjBvUXUN8TjpE_JaHZFr7EAdE=i2wSQVCQ8Q@mail.gmail.com>
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
X-List-Received-Date: Wed, 13 Nov 2019 18:14:29 -0000
Content-Type: multipart/alternative; boundary="000000000000ff4e7e05973e553e"

--000000000000ff4e7e05973e553e
Content-Type: text/plain; charset="UTF-8"

On further inspection of the older image my coworker made, it looks like
awk is located at "/usr/bin/awk".  I see this by just doing a "which awk"
in the console of the T4240 RDB when the old image is loaded.  So it looks
like the most likely case is that Khem Raj is correct and that bitbake is
expecting awk to be in "/bin" when awk is actually in "/usr/bin".  In that
case, I need to know where the line telling bitbake to look for awk in the
"/bin" directory is.

On Wed, Nov 13, 2019 at 12:02 PM Wayne Li <waynli329@gmail.com> wrote:

> I'd like also like to mention that my main concern with the ver_linux
> files that I found in my project was that the shebang line was " #!/bin/sh"
> instead of "#!/bin/awk -f" which is the shebang line in the ver_linux file
> in the patch.  The patch wants to change the shebang line from "#!/bin/awk
> -f" to  "#!/usr/bin/awk -f" so I'm not sure how that change would translate
> when I'm working with the shebang line "#!/bin/sh".  Or perhaps Yocto has
> changed since that patch was posted and maybe the place /bin/awk is
> specified is different?
>
> On Wed, Nov 13, 2019 at 11:51 AM Wayne Li <waynli329@gmail.com> wrote:
>
>> So after further investigation, I'm fairly sure awk is actually present
>> in the target image.  Here are my reasons why I feel that this is the case:
>>
>> -I looked at the busybox menuconfig GUI that comes up when I run "bitbake
>> -c menuconfig busybox" and it says awk is built-in.
>> -I looked at various def-config files I found by just doing a "grep -rn
>> "CONFIG_AWK"" and found that CONFIG_AWK seems to have been enabled
>> throughout the project (there was the line CONFIG_AWK=y uncommented in the
>> various def-config files I mentioned).
>> -I have an older version of the target image that my coworker (who has
>> since left the company) created.  I just need to rebuild this image because
>> I am trying to add some kernel modules to the image.  When I run the
>> command "awk" in the console for the T4240 RDB when the older version of
>> the image is loaded, I do see the gawk help info come up. This shows awk is
>> present in the older image.
>>
>> But looking at what Khem Raj mentioned, perhaps bitbake is just not
>> finding the awk because it's actually in /usr/bin when bitbake expects it
>> to be in /bin?  Though I am a little confused about the link you sent, Khem
>> Raj.  How do exactly do I apply this patch?  I'm assuming we have to change
>> the file ver_linux?  I did a "find . -name "ver_linux"" and I see multiple
>> results:
>>
>> bash-4.2$ find . -name "ver_linux"
>>
>> ./build_t4240rdb-64b/tmp/work/ppc64e6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>>
>> ./build_t4240rdb-64b/tmp/work/ppce6500-fslmllib32-linux/lib32-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>>
>> ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/package/usr/src/kernel/scripts/ver_linux
>>
>> ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel/scripts/ver_linux
>>
>> ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/packages-split/kernel-devsrc/usr/src/kernel/scripts/ver_linux
>>
>> ./build_t4240rdb-64b/tmp/work-shared/t4240rdb-64b/kernel-source/scripts/ver_linux
>>
>> ./build_t4240rdb/tmp/work/ppc64e6500-fslmllib64-linux/lib64-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>>
>> ./build_t4240rdb/tmp/work/ppce6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>> ./build_t4240rdb/tmp/work-shared/t4240rdb/kernel-source/scripts/ver_linux
>>
>> Now the build I'm working on is build_t4240rdb-64b so the last three
>> results in that search probably don't matter.  Though there are still six
>> more results for when I search ver_linux.  So I'm not sure which one I need
>> to change.  Moreover, all of the ver_linux files I found more or less look
>> like the following:
>>
>> https://gist.github.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677
>>
>> Which seems to be very different from the ver_linux file mentioned in the
>> patch.  This further confuses me on how to apply the patch.
>>
>> Or maybe do you guys think maybe the patch isn't the solution here?
>> Maybe there's some other reason bitbake isn't finding the awk?
>>
>> -Thanks!, Wayne Li
>>
>> On Wed, Nov 13, 2019 at 10:57 AM Khem Raj <raj.khem@gmail.com> wrote:
>>
>>> On Wed, 2019-11-13 at 10:33 +0200, Adrian Bunk wrote:
>>> > On Tue, Nov 12, 2019 at 04:08:48PM -0600, Wayne Li wrote:
>>> > > Dear Yocto Developers,
>>> > >
>>> > > I'm trying to to build a Yocto kernel for a T4240 RDB.  When I run
>>> > > "bitbake
>>> > > fsl-image-full" to build the entire linux image, I get an error
>>> > > that says
>>> > > "Can't install kernel-devsrc-1.0-r0@t4240rdb_64b: no package
>>> > > provides
>>> > > /bin/awk".  Here's the entire error print that I see:
>>> > >
>>> > > https://gist.github.com/WayneZhenLi/e35f65081092cf1f24df29ec369c701c
>>> > >
>>> > > Anyway I'm confused about this error because /bin/awk does
>>> > > exist.  Like if
>>> > > I run "/bin/awk" in the console I see help info come up describing
>>> > > how to
>>> > > use a program called "gawk".  Why can't bitbake find /bin/awk
>>> > > then?  Or am
>>> > > I misunderstanding what this error is trying to say?  I mean I'm
>>> > > assuming
>>> > > it's just not able to find /bin/awk but maybe the error means
>>> > > something
>>> > > else?  Or maybe /bin/awk is actually relative to some path?  Let me
>>> > > know
>>> > > your thoughts.
>>> >
>>> > /bin/awk is missing on your target image that will run on the T4240
>>> > RDB.
>>> >
>>> > The smallest implementation is to enable CONFIG_AWK in your busybox
>>> > config.
>>> >
>>>
>>> import something like below patch into your kernel will help too
>>>
>>>
>>> https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=8af11c1cdd8fa08217e702b57cf96e9030db52b2
>>>
>>> > > -Thanks!, Wayne Li
>>> >
>>> > cu
>>> > Adrian
>>> >
>>> > --
>>> >
>>> >        "Is there not promise of rain?" Ling Tan asked suddenly out
>>> >         of the darkness. There had been need of rain for many days.
>>> >        "Only a promise," Lao Er said.
>>> >                                        Pearl S. Buck - Dragon Seed
>>> >
>>>
>>>

--000000000000ff4e7e05973e553e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On further inspection of the older image my coworker made,=
 it looks like awk is located at &quot;/usr/bin/awk&quot;.=C2=A0 I see this=
 by just doing a &quot;which awk&quot; in the console of the T4240 RDB when=
 the old image is loaded.=C2=A0 So it looks like the most likely case is th=
at Khem Raj is correct and that bitbake is expecting awk to be in &quot;/bi=
n&quot; when awk is actually in &quot;/usr/bin&quot;.=C2=A0 In that case, I=
 need to know where the line telling bitbake to look for awk in the &quot;/=
bin&quot; directory is.<br></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, Nov 13, 2019 at 12:02 PM Wayne Li &lt;<a=
 href=3D"mailto:waynli329@gmail.com">waynli329@gmail.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">I&=
#39;d like also like to mention that my main concern with the ver_linux fil=
es that I found in my project was that the shebang line was &quot;
<span><span>#!</span>/bin/sh&quot; instead of &quot;#!/bin/awk -f&quot; whi=
ch is the shebang line in the ver_linux file in the patch.=C2=A0 The patch =
wants to change the shebang line from &quot;#!/bin/awk -f&quot; to=C2=A0
&quot;#!/usr/bin/awk -f&quot; so I&#39;m not sure how that change would tra=
nslate when I&#39;m working with the shebang line &quot;<span><span>#!</spa=
n>/bin/sh&quot;</span>.=C2=A0 Or perhaps Yocto has changed since that patch=
 was posted and maybe the place /bin/awk</span> is specified is different?<=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Wed, Nov 13, 2019 at 11:51 AM Wayne Li &lt;<a href=3D"mailto:waynli32=
9@gmail.com" target=3D"_blank">waynli329@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>So =
after further investigation, I&#39;m fairly sure awk is actually present in=
 the target image.=C2=A0 Here are my reasons why I feel that this is the ca=
se:</div><div><br></div><div>-I looked at the busybox menuconfig GUI that c=
omes up when I run &quot;bitbake -c menuconfig busybox&quot; and it says aw=
k is built-in.=C2=A0 <br></div><div>-I looked at various def-config files I=
 found by just doing a &quot;grep -rn &quot;CONFIG_AWK&quot;&quot; and foun=
d that CONFIG_AWK seems to have been enabled throughout the project (there =
was the line CONFIG_AWK=3Dy uncommented in the various def-config files I m=
entioned).=C2=A0 <br></div><div>-I have an older version of the target imag=
e that my coworker (who has since left the company) created.=C2=A0 I just n=
eed to rebuild this image because I am trying to add some kernel modules to=
 the image.=C2=A0 When I run the command &quot;awk&quot; in the console for=
 the T4240 RDB when the older version of the image is loaded, I do see the =
gawk help info come up. This shows awk is present in the older image.</div>=
<div><br></div><div>But looking at what Khem Raj mentioned, perhaps bitbake=
 is just not finding the awk because it&#39;s actually in /usr/bin when bit=
bake expects it to be in /bin?=C2=A0 Though I am a little confused about th=
e link you sent, Khem Raj.=C2=A0 How do exactly do I apply this patch?=C2=
=A0 I&#39;m assuming we have to change the file ver_linux?=C2=A0 I did a &q=
uot;find . -name &quot;ver_linux&quot;&quot; and I see multiple results:</d=
iv><div><br></div><div>
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
i/c7475cf382a80bfd2de31e82c40c1677" target=3D"_blank">https://gist.github.c=
om/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677</a></div><div><br></div><di=
v>Which seems to be very different from the ver_linux file mentioned in the=
 patch.=C2=A0 This further confuses me on how to apply the patch.=C2=A0 <br=
></div><div><br></div><div>Or maybe do you guys think maybe the patch isn&#=
39;t the solution here?=C2=A0 Maybe there&#39;s some other reason bitbake i=
sn&#39;t finding the awk?<br></div><div><br></div><div>-Thanks!, Wayne Li<b=
r></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Wed, Nov 13, 2019 at 10:57 AM Khem Raj &lt;<a href=3D"mailto:raj=
.khem@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 2019-11-13 at =
10:33 +0200, Adrian Bunk wrote:<br>
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
</blockquote></div>
</blockquote></div>

--000000000000ff4e7e05973e553e--
