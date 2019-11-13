Return-Path: <waynli329@gmail.com>
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
	[209.85.166.52])
	by mail.openembedded.org (Postfix) with ESMTP id 47A0C7F7C0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 18:02:32 +0000 (UTC)
Received: by mail-io1-f52.google.com with SMTP id 1so3596437iou.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=U4D/q+TJa96Hag8m/K31jO5MHAsnBJV+9lQxToCiu54=;
	b=HsMadmM53DQbq7+Wy223xlNg0HgV1OS7CyDG6/YVaE/whBFYEOxrtALpQjhU3Za4S4
	XTfHBIR9KsEuAkNfGGm1JfuysiVoKS3hLDKCtBKSXkKy9NEB8QssZssw2+ilrbbL3VQC
	Ob0xxXw0gfJuDoLmcLkthEpzkFNxHVKQTlEv1M80HQ67d5Xnyqxxrru4L1/zeSIOrwQQ
	spXtS/6dDbaRA9zC04UrU1L81n9J6Es9pF/iRKVFLhYg8XgevJxOc5JPLggAnK3LaIRF
	McqqDMRcHWfwbA45K8NXNcA+boHDADsukP3Z5GKQ8rk5fu58I33VAhT7OexpftAqOzlt
	VJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=U4D/q+TJa96Hag8m/K31jO5MHAsnBJV+9lQxToCiu54=;
	b=MAhrcv38dUtUsaTIy9FfmulMnAQ3P55s8GSkwYdF4ThVnK1mQYJZUrMTA0mEbL4yF1
	96IQU07JbrCxpqC++jxyqYDHu3VEpI79JRPsvEDFOYqyoroiF73uUJx7BKttRMXwHnk0
	acNOtFvDdz85kqev/nYGF2G7K6YMm+KNrrlEeyMR/dtnHAoiwcI2Nkq0zCxYcOczc6Kn
	xdCURJM8LGtyzBeR/V7bDmk9B3zH2ay9ESCCl/Dzo4S/NFOBibA777J7VjOQNqOwQqAl
	tk74o7ZKMYWTBrhM6CZnymLK9ptHNDN0CzWGQvNCH03yF201REkKMpjd0/QSeDXKkEMn
	FcsQ==
X-Gm-Message-State: APjAAAW6p7SYIRhFkgZO6bljAjVcRxAcf0alAzdNDFf+Or6pcDY13K59
	QSbSMWeOmB935zTdkiigvR/U034XK9XvWfhX0Lk=
X-Google-Smtp-Source: APXvYqwm3PwjG35F/+odmW77UVq6yyZFZQoEekKjQDkRStvS2QD3eXItaJp5aRBiNGz5ODy5asaOPMWO3pJ8U1qdYhY=
X-Received: by 2002:a5e:9741:: with SMTP id h1mr4466113ioq.143.1573668152937; 
	Wed, 13 Nov 2019 10:02:32 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nqA0QGCcaN8z=qvtVu-U_aHswjqKTbZJ0YoCXE6OsvzQw@mail.gmail.com>
	<20191113083317.GA7340@localhost>
	<83ee3505594a6b5cb00eb643ece131c85aedeea0.camel@gmail.com>
	<CAM2K0nr_gPrDtx5QLz6x74a2CnDb8kERKcYu5bMJi8sg5PE62A@mail.gmail.com>
In-Reply-To: <CAM2K0nr_gPrDtx5QLz6x74a2CnDb8kERKcYu5bMJi8sg5PE62A@mail.gmail.com>
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 13 Nov 2019 12:02:21 -0600
Message-ID: <CAM2K0nrhK-z1M9uFzxVOrsk0s4+npm3KX0rDh6dx+SOs6sn_gQ@mail.gmail.com>
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
X-List-Received-Date: Wed, 13 Nov 2019 18:02:32 -0000
Content-Type: multipart/alternative; boundary="00000000000040240e05973e2b10"

--00000000000040240e05973e2b10
Content-Type: text/plain; charset="UTF-8"

I'd like also like to mention that my main concern with the ver_linux files
that I found in my project was that the shebang line was " #!/bin/sh"
instead of "#!/bin/awk -f" which is the shebang line in the ver_linux file
in the patch.  The patch wants to change the shebang line from "#!/bin/awk
-f" to  "#!/usr/bin/awk -f" so I'm not sure how that change would translate
when I'm working with the shebang line "#!/bin/sh".  Or perhaps Yocto has
changed since that patch was posted and maybe the place /bin/awk is
specified is different?

On Wed, Nov 13, 2019 at 11:51 AM Wayne Li <waynli329@gmail.com> wrote:

> So after further investigation, I'm fairly sure awk is actually present in
> the target image.  Here are my reasons why I feel that this is the case:
>
> -I looked at the busybox menuconfig GUI that comes up when I run "bitbake
> -c menuconfig busybox" and it says awk is built-in.
> -I looked at various def-config files I found by just doing a "grep -rn
> "CONFIG_AWK"" and found that CONFIG_AWK seems to have been enabled
> throughout the project (there was the line CONFIG_AWK=y uncommented in the
> various def-config files I mentioned).
> -I have an older version of the target image that my coworker (who has
> since left the company) created.  I just need to rebuild this image because
> I am trying to add some kernel modules to the image.  When I run the
> command "awk" in the console for the T4240 RDB when the older version of
> the image is loaded, I do see the gawk help info come up. This shows awk is
> present in the older image.
>
> But looking at what Khem Raj mentioned, perhaps bitbake is just not
> finding the awk because it's actually in /usr/bin when bitbake expects it
> to be in /bin?  Though I am a little confused about the link you sent, Khem
> Raj.  How do exactly do I apply this patch?  I'm assuming we have to change
> the file ver_linux?  I did a "find . -name "ver_linux"" and I see multiple
> results:
>
> bash-4.2$ find . -name "ver_linux"
>
> ./build_t4240rdb-64b/tmp/work/ppc64e6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>
> ./build_t4240rdb-64b/tmp/work/ppce6500-fslmllib32-linux/lib32-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>
> ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/package/usr/src/kernel/scripts/ver_linux
>
> ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel/scripts/ver_linux
>
> ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/packages-split/kernel-devsrc/usr/src/kernel/scripts/ver_linux
>
> ./build_t4240rdb-64b/tmp/work-shared/t4240rdb-64b/kernel-source/scripts/ver_linux
>
> ./build_t4240rdb/tmp/work/ppc64e6500-fslmllib64-linux/lib64-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>
> ./build_t4240rdb/tmp/work/ppce6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
> ./build_t4240rdb/tmp/work-shared/t4240rdb/kernel-source/scripts/ver_linux
>
> Now the build I'm working on is build_t4240rdb-64b so the last three
> results in that search probably don't matter.  Though there are still six
> more results for when I search ver_linux.  So I'm not sure which one I need
> to change.  Moreover, all of the ver_linux files I found more or less look
> like the following:
>
> https://gist.github.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677
>
> Which seems to be very different from the ver_linux file mentioned in the
> patch.  This further confuses me on how to apply the patch.
>
> Or maybe do you guys think maybe the patch isn't the solution here?  Maybe
> there's some other reason bitbake isn't finding the awk?
>
> -Thanks!, Wayne Li
>
> On Wed, Nov 13, 2019 at 10:57 AM Khem Raj <raj.khem@gmail.com> wrote:
>
>> On Wed, 2019-11-13 at 10:33 +0200, Adrian Bunk wrote:
>> > On Tue, Nov 12, 2019 at 04:08:48PM -0600, Wayne Li wrote:
>> > > Dear Yocto Developers,
>> > >
>> > > I'm trying to to build a Yocto kernel for a T4240 RDB.  When I run
>> > > "bitbake
>> > > fsl-image-full" to build the entire linux image, I get an error
>> > > that says
>> > > "Can't install kernel-devsrc-1.0-r0@t4240rdb_64b: no package
>> > > provides
>> > > /bin/awk".  Here's the entire error print that I see:
>> > >
>> > > https://gist.github.com/WayneZhenLi/e35f65081092cf1f24df29ec369c701c
>> > >
>> > > Anyway I'm confused about this error because /bin/awk does
>> > > exist.  Like if
>> > > I run "/bin/awk" in the console I see help info come up describing
>> > > how to
>> > > use a program called "gawk".  Why can't bitbake find /bin/awk
>> > > then?  Or am
>> > > I misunderstanding what this error is trying to say?  I mean I'm
>> > > assuming
>> > > it's just not able to find /bin/awk but maybe the error means
>> > > something
>> > > else?  Or maybe /bin/awk is actually relative to some path?  Let me
>> > > know
>> > > your thoughts.
>> >
>> > /bin/awk is missing on your target image that will run on the T4240
>> > RDB.
>> >
>> > The smallest implementation is to enable CONFIG_AWK in your busybox
>> > config.
>> >
>>
>> import something like below patch into your kernel will help too
>>
>>
>> https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=8af11c1cdd8fa08217e702b57cf96e9030db52b2
>>
>> > > -Thanks!, Wayne Li
>> >
>> > cu
>> > Adrian
>> >
>> > --
>> >
>> >        "Is there not promise of rain?" Ling Tan asked suddenly out
>> >         of the darkness. There had been need of rain for many days.
>> >        "Only a promise," Lao Er said.
>> >                                        Pearl S. Buck - Dragon Seed
>> >
>>
>>

--00000000000040240e05973e2b10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;d like also like to mention that my main concern wit=
h the ver_linux files that I found in my project was that the shebang line =
was &quot;
<span class=3D"gmail-pl-c"><span class=3D"gmail-pl-c">#!</span>/bin/sh&quot=
; instead of &quot;#!/bin/awk -f&quot; which is the shebang line in the ver=
_linux file in the patch.=C2=A0 The patch wants to change the shebang line =
from &quot;#!/bin/awk -f&quot; to=C2=A0
&quot;#!/usr/bin/awk -f&quot; so I&#39;m not sure how that change would tra=
nslate when I&#39;m working with the shebang line &quot;<span class=3D"gmai=
l-pl-c"><span class=3D"gmail-pl-c">#!</span>/bin/sh&quot;</span>.=C2=A0 Or =
perhaps Yocto has changed since that patch was posted and maybe the place /=
bin/awk</span> is specified is different?<br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 13, 2019 at 11:51 =
AM Wayne Li &lt;<a href=3D"mailto:waynli329@gmail.com">waynli329@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div>So after further investigation, I&#39;m fairly sure aw=
k is actually present in the target image.=C2=A0 Here are my reasons why I =
feel that this is the case:</div><div><br></div><div>-I looked at the busyb=
ox menuconfig GUI that comes up when I run &quot;bitbake -c menuconfig busy=
box&quot; and it says awk is built-in.=C2=A0 <br></div><div>-I looked at va=
rious def-config files I found by just doing a &quot;grep -rn &quot;CONFIG_=
AWK&quot;&quot; and found that CONFIG_AWK seems to have been enabled throug=
hout the project (there was the line CONFIG_AWK=3Dy uncommented in the vari=
ous def-config files I mentioned).=C2=A0 <br></div><div>-I have an older ve=
rsion of the target image that my coworker (who has since left the company)=
 created.=C2=A0 I just need to rebuild this image because I am trying to ad=
d some kernel modules to the image.=C2=A0 When I run the command &quot;awk&=
quot; in the console for the T4240 RDB when the older version of the image =
is loaded, I do see the gawk help info come up. This shows awk is present i=
n the older image.</div><div><br></div><div>But looking at what Khem Raj me=
ntioned, perhaps bitbake is just not finding the awk because it&#39;s actua=
lly in /usr/bin when bitbake expects it to be in /bin?=C2=A0 Though I am a =
little confused about the link you sent, Khem Raj.=C2=A0 How do exactly do =
I apply this patch?=C2=A0 I&#39;m assuming we have to change the file ver_l=
inux?=C2=A0 I did a &quot;find . -name &quot;ver_linux&quot;&quot; and I se=
e multiple results:</div><div><br></div><div>
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

--00000000000040240e05973e2b10--
