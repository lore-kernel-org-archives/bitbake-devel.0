Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
	[209.85.218.49])
	by mail.openembedded.org (Postfix) with ESMTP id 024CA73D8C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 04:09:43 +0000 (UTC)
Received: by oihb142 with SMTP id b142so22839228oih.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 21:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=Q7pByaCWqAvxACdNIL357H0XgGK4XGfNisvwK38upyI=;
	b=msd25YXGIHUrPiRxKDn8crOfu9e3Bp4qq43ZUwtHkfFkMLK7TFUmwGrUFbBdxkYxgH
	nCs14+3Rtbe0ljE+lN2SP1D5SHFWt19wKDsGgtlIIJBW0PHVPLQn445LF1dtuPEk7nzn
	Lzg7Rrc4MpDTpkgBdR6PK4A8OV6KytXLeBOkXkcXLxmFlyd25EIBZ1M3YyVW+MlR7tqh
	QsOd6xsEjjDzODme5jqLnA4bpIDFWyYRUjgofjoN42G8hsFFdfCEIo97cWWLMUovreHL
	sbtfPlLXzFz0KHkhKnrvqSFLEYqI8yLowoDimVoIxvL2YqRIjYkA2hm8+S+RjWM7wroR
	dSLA==
X-Received: by 10.202.108.84 with SMTP id h81mr21246120oic.5.1433390984357;
	Wed, 03 Jun 2015 21:09:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Wed, 3 Jun 2015 21:09:23 -0700 (PDT)
In-Reply-To: <CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
	<CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
	<CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
	<CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Thu, 4 Jun 2015 09:39:23 +0530
Message-ID: <CADL-HDgmuxA-c8akyLge14DKFDC9Z7L1JkvCT19Wf9d9fGwiOw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Thu, 04 Jun 2015 04:09:44 -0000
Content-Type: multipart/alternative; boundary=001a1142eb76726bb80517a95840

--001a1142eb76726bb80517a95840
Content-Type: text/plain; charset=UTF-8

Hi,

The library for which I passed -module and and -avoid-version in
Makefile.am is not going to rootfs.

libgstfl_la_LDFLAGS = -module -avoid-version

library is installed if I add this line to Makefile.am

libdir = /lib/gstreamer-0.10

and these to bb file

FILES_${PN} += "/lib/gstreamer-0.10"
FILES_${PN}-dbg += "/lib/gstreamer-0.10/.debug"
INSANE_SKIP_${PN} += "dev-so

Is this correct to use INSANE_SKIP or is it not recommended?

Should I consider not to inherit autotools?  I have seen a lot of packages
doing that. In this case whattever path I assign here in FILES variable ,
my library is installed to that path but with autotools I have to use
INSANE_SKIP option.

Thanks,
Yogesh



On Thu, Jun 4, 2015 at 3:17 AM, Burton, Ross <ross.burton@intel.com> wrote:

>
> On 3 June 2015 at 20:24, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:
>
>> ERROR: QA Issue: non -dev/-dbg/-nativesdk package contains symlink .so:
>> gst-plugin-linux-user path
>> '/work/core2-32-poky-linux/gst-plugin-linux-user/git+master-r0/packages-split/gst-plugin-linux-user/lib/gstreamer-0.10/libgstfl.so'
>> ERROR: QA run found fatal errors. Please consider fixing them.
>>
>
> That QA test is over-keen and that's a false-positive, but the real fix is
> in your makefile.  Pass -module -avoid-version to libtool as you're
> building modules, not libraries.
>
> Ross
>

--001a1142eb76726bb80517a95840
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>The library for which I passed -mod=
ule and and -avoid-version in Makefile.am is not going to rootfs.</div><div=
><br></div><div>libgstfl_la_LDFLAGS =3D -module -avoid-version<br></div><di=
v><br></div><div>library is installed if I add this line to Makefile.am</di=
v><div><br></div><div><span class=3D"" style=3D"color:rgb(0,0,0);font-famil=
y:monospace;font-size:12px;white-space:pre">libdir </span><span class=3D"" =
style=3D"color:rgb(102,102,0);font-family:monospace;font-size:12px;white-sp=
ace:pre">=3D</span><span class=3D"" style=3D"color:rgb(0,0,0);font-family:m=
onospace;font-size:12px;white-space:pre"> </span>/lib/gstreamer-0.10</div><=
div><br></div><div>and these to bb file</div><div><br>FILES_${PN} +=3D &quo=
t;/lib/gstreamer-0.10&quot;</div><div>FILES_${PN}-dbg +=3D &quot;/lib/gstre=
amer-0.10/.debug&quot;<br>INSANE_SKIP_${PN} +=3D &quot;dev-so<br><br>Is thi=
s correct to use INSANE_SKIP or is it not recommended?</div><div><br></div>=
<div>Should I consider not to inherit autotools?=C2=A0 I have seen a lot of=
 packages doing that. In this case whattever path I assign here in FILES va=
riable , my library is installed to that path but with autotools I have to =
use INSANE_SKIP option.</div><div><br></div><div><span style=3D"color:rgb(0=
,0,0);font-family:monospace;font-size:12px;white-space:pre">Thanks,</span><=
/div><div><span style=3D"color:rgb(0,0,0);font-family:monospace;font-size:1=
2px;white-space:pre">Yogesh</span></div><div><br></div><div><br></div></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jun 4, 2=
015 at 3:17 AM, Burton, Ross <span dir=3D"ltr">&lt;<a href=3D"mailto:ross.b=
urton@intel.com" target=3D"_blank">ross.burton@intel.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote"><span class=3D"">On 3 June 2015 at 20=
:24, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mailto:yogesh.bit2006@gm=
ail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div>ERROR: QA Issue: non -dev/-dbg/-nativ=
esdk package contains symlink .so: gst-plugin-linux-user path &#39;/work/co=
re2-32-poky-linux/gst-plugin-linux-user/git+master-r0/packages-split/gst-pl=
ugin-linux-user/lib/gstreamer-0.10/libgstfl.so&#39;</div><div>ERROR: QA run=
 found fatal errors. Please consider fixing them.</div></blockquote><div><b=
r></div></span><div>That QA test is over-keen and that&#39;s a false-positi=
ve, but the real fix is in your makefile.=C2=A0 Pass -module -avoid-version=
 to libtool as you&#39;re building modules, not libraries.</div><span class=
=3D"HOEnZb"><font color=3D"#888888"><div><br></div><div>Ross=C2=A0<br></div=
></font></span></div></div></div>
</blockquote></div><br></div>

--001a1142eb76726bb80517a95840--
