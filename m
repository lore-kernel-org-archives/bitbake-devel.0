Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f182.google.com (mail-yb0-f182.google.com
	[209.85.213.182])
	by mail.openembedded.org (Postfix) with ESMTP id 335EC751DC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2018 10:58:16 +0000 (UTC)
Received: by mail-yb0-f182.google.com with SMTP id 140-v6so504324ybc.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2018 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hZ2sQv4XbBLCmjzlNJiI0chT9i90GGHDjNBIF88zx2A=;
	b=bStxvIF6gGY6CaV5EdGltVKDwx+1+2ieRaXDMx2uJXnlo/Dzr+04VsloCRAo5XMegf
	UdnzECu98ownpu4Yjgqfgc9B834CV9HH/U6rUvhAbYpLXUxbLnoFKx5rThUmHlpXXnih
	V4aLHoBdrazvSMh6GhcrScn21mrSCCSpMCTIwKxJUBWlemrBY8kSKr8ZkLiDqKr+Ba8g
	Iqpb1A4PMim9q+tNHBwkMarPUZ+oImxPhoe0qrPBW70D6BEJ1ncGxIDTkCWtBOvRqz+O
	fKPUnWgqkWLJZtJ1MsGMZ2AzDmUr7/hbdTSs6EpX4DHZkCtZ1zNOtymChRfAlPqmN7gt
	7jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hZ2sQv4XbBLCmjzlNJiI0chT9i90GGHDjNBIF88zx2A=;
	b=ZE8npCXcA41JdyYDQZczb3/aZkr62OcbPuqrgFqdGTuEyU0tmpA6tRGLrKCDlhJwPQ
	wisB/emJrmGnYSddr6PQSYKC0eSb9xLpyVr9GL+J29ztiD0cHl4eEXlVWaJFbhWOeHXi
	fyJqmmj4/l3+Q24VWzz1cfh+ghpXShQOELhUXbegSqQZgGZfhsFhtXtFY8n1Mj3zk0sa
	62/foUiw31v6gvUlPWwGgjaBrFVB/Dx11Cxjxozd/n8pdOpZ/IC5Oi9dGS+CU0VZJFfq
	fQgCs5GRz3GaEfV4cCiZPWgq+7HpbM6IBsk6cjfXUCdB97NnYWBPejesxO4t6yqL/BVz
	Sxbg==
X-Gm-Message-State: ALKqPwfOCxdoF/HqI6bcIj5FRLn5F45b/NA7D5tecXxs3dJyoR5MZ1p9
	qfHeg2jv7p6EHCzB6nRE6uVUg2QpNJfJA0GiiXI=
X-Google-Smtp-Source: AB8JxZpMKrAaNVx8JDDo/d7K3x3lCEeKBjNp7WHwhzNu8pimtnwsXBHiyt6roL4TgdxD3CPMX7smdAMaDPU6gkw+S2w=
X-Received: by 2002:a25:b3cc:: with SMTP id
	x12-v6mr411617ybf.181.1525949897359; 
	Thu, 10 May 2018 03:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <1184471455.1381374.1525832300014.ref@mail.yahoo.com>
	<1184471455.1381374.1525832300014@mail.yahoo.com>
	<CAJTo0LZGEBwiZr7csd3vxYaThN7-fTjexeRfkT+1ksX-AerbvA@mail.gmail.com>
	<838865895.1728045.1525881582620@mail.yahoo.com>
	<CAJ86T=VW2yODWtD_Fx+3436GKQYwuFL2jnHoy3xpsQ1SA4Mk3A@mail.gmail.com>
	<628795431.1912899.1525935232611@mail.yahoo.com>
In-Reply-To: <628795431.1912899.1525935232611@mail.yahoo.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Thu, 10 May 2018 10:58:06 +0000
Message-ID: <CAJgxT3_3bnkUzoBfy8R9EuudyYF-1zm1DNP0B=qC68xD4sxfkA@mail.gmail.com>
To: "kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: .bb script file for auto tools
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
X-List-Received-Date: Thu, 10 May 2018 10:58:17 -0000
Content-Type: multipart/alternative; boundary="00000000000093c8c0056bd7e5d2"

--00000000000093c8c0056bd7e5d2
Content-Type: text/plain; charset="UTF-8"

On Thu, May 10, 2018 at 01:54 Ugesh Reddy via bitbake-devel <
bitbake-devel@lists.openembedded.org> wrote:

> Hello,
>
> Thanks a lot for the reference manual.
>
>
>
> I have created example recipe.
>
>
>
> *The content of the .bb file:*
>
>
>
> #
>
> # This file was derived from the 'Hello World!' example recipe in the
>
> # Yocto Project Development Manual.
>
> #
>
>
>
> DESCRIPTION = "Simple helloworld application"
>
> SECTION = "examples"
>
> DEPENDS = ""
>
> LICENSE = "MIT"
>
> #LIC_FILES_CHKSUM = "file://LICENSE;md5=0835ade698e0bcf8506ecda2f7b4f302"
>
> LIC_FILES_CHKSUM =
> "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
>
> #FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"
>
>
>
> SRCREV = "4ec84957442182f36351f94c0626560ec3ffd487"
>
> #SRC_URI = "https://github.com/DynamicDevices/bbexample.git"
>
> SRC_URI = "file://bbexample-0.1.tar.gz"
>
> S = "${WORKDIR}/bbexample"
>
>
>
> do_configure_prepend () {
>
>   ${S}/autogen.sh
>
> }
>

The equivalent of autogen.sh is already done for you in autotools.bbclass's
do_configure(). I'd suggest removing this.

inherit autotools
>
>
>
> *Sources*
>
>
>
> -rwxr-xr-x 1 umn5cob umn5cob   294 May 10 01:41 autogen.sh
>
> -rw-r--r-- 1 umn5cob umn5cob   274 May 10 01:41 bbexample.c
>
> -rw-r--r-- 1 umn5cob umn5cob   259 May 10 01:41 bbexample.h
>
> -rw-r--r-- 1 umn5cob umn5cob   374 May 10 01:41 bbexamplelib.c
>
> -rw-r--r-- 1 umn5cob umn5cob   659 May 10 01:41 configure.ac
>
> -rw-r--r-- 1 umn5cob umn5cob   303 May 10 01:41 Makefile.am
>
> -rw-rw-r-- 1 umn5cob umn5cob 30416 May 10 02:02 Makefile.in
>
>
>
> *Error:*
>
> NOTE: Preparing RunQueue
>
> NOTE: Executing SetScene Tasks
>
> NOTE: Executing RunQueue Tasks
>
> *ERROR: Function failed: do_configure (log file is located at
> /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do_configure.24121)*
>
> *ERROR: Logfile of failure stored in:
> /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do_configure.24121*
>
> Log data follows:
>
> | DEBUG: Executing python function sysroot_cleansstate
>
> | DEBUG: Python function sysroot_cleansstate finished
>
> | DEBUG: SITE files ['endian-little', 'common-linux', 'common-glibc',
> 'bit-64', 'x86_64-linux', 'common']
>
> | DEBUG: Executing shell function autotools_preconfigure
>
> | Previously configured separate build directory detected, cleaning
> /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/build
>
> | DEBUG: Shell function autotools_preconfigure finished
>
> | DEBUG: Executing python function autotools_copy_aclocals
>
> | DEBUG: SITE files ['endian-little', 'common-linux', 'common-glibc',
> 'bit-64', 'x86_64-linux', 'common']
>
> | DEBUG: Python function autotools_copy_aclocals finished
>
> | DEBUG: Executing shell function do_configure
>
> | Generating configure files... may take a while.
>
> | autoreconf: 'configure.ac' or 'configure.in' is required
>
> | WARNING: exit code 1 from a shell command.
>
> *| ERROR: Function failed: do_configure (log file is located at
> /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do_configure.24121)*
>
> *ERROR: Task 5
> (/home/umn5cob/yocto/poky/meta-yocto-bsp/recipes-bbexample_1.0/bbexample/bbexample_1.0.bb
> <http://bbexample_1.0.bb>, do_configure) failed with exit code '1'*
>
> NOTE: Tasks Summary: Attempted 533 tasks of which 532 didn't need to be
> rerun and 1 failed.
>
> No currently running tasks (510 of 543)
>
>
>
> Summary: 1 task failed:
>
>   /home/umn5cob/yocto/poky/meta-yocto-bsp/recipes-bbexample_1.0/bbexample/
> bbexample_1.0.bb, do_configure
>
> Summary: There was 1 WARNING message shown.
>
> Summary: There was 1 ERROR message shown, returning a non-zero exit code.
>
>
>
> Someone please guide me what is missed and error?
>
>
> Sent from Yahoo Mail on Android
> <https://overview.mail.yahoo.com/mobile/?.src=Android>
>
> On Thu, 10 May 2018 at 5:59 a.m., Andre McCurdy
> <armccurdy@gmail.com> wrote:
> On Wed, May 9, 2018 at 8:59 AM, Ugesh Reddy via bitbake-devel <
> bitbake-devel@lists.openembedded.org> wrote:
>
> Hello,
>  The devtool hides out the information and trying to learn bitbake and
> wanted understand each entry in the .BB files.So I would to write it
> instead of tool.
>
> Could you guide me?
>
>
> How to write a recipe is well documented:
>
>
> https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#new-recipe-writing-a-new-recipe
>
> https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#new-recipe-autotooled-package
>
> You can also learn a lot by reviewing and understanding the recipes in
> oe-core.
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000093c8c0056bd7e5d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div dir=3D"auto">On Thu, May 10, 2018 =
at 01:54 Ugesh Reddy via bitbake-devel &lt;<a href=3D"mailto:bitbake-devel@=
lists.openembedded.org">bitbake-devel@lists.openembedded.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Hello,<div id=3D"m_-16292309023387=
40653yMail_cursorElementTracker_1525935014276"><br id=3D"m_-162923090233874=
0653yMail_cursorElementTracker_1525934931905"><p class=3D"m_-16292309023387=
40653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span style=
=3D"font-size:10pt">Thanks a lot for the reference manual.</span></p><p cl=
ass=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:s=
ans-serif"><span style=3D"font-size:10pt">=C2=A0</span></p><p class=3D"m_-1=
629230902338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif">=
<span style=3D"font-size:10pt">I have created example recipe.</span></p><p =
class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family=
:sans-serif"><span style=3D"font-size:10pt">=C2=A0</span></p><p class=3D"m_=
-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif=
"><b><u><span style=3D"font-size:10pt">The content of the .bb file:</span><=
/u></b></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=
=3D"font-family:sans-serif"><b><u><span style=3D"font-size:10pt"><span sty=
le=3D"text-decoration-line:none">=C2=A0</span></span></u></b></p><p class=
=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:san=
s-serif"><span style=3D"font-size:10pt">#</span></p><p class=3D"m_-16292309=
02338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span s=
tyle=3D"font-size:10pt"># This file was derived from the &#39;Hello World!&=
#39; example recipe in the</span></p><p class=3D"m_-1629230902338740653yiv7=
612199202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-si=
ze:10pt"># Yocto Project Development Manual.</span></p><p class=3D"m_-16292=
30902338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><spa=
n style=3D"font-size:10pt">#</span></p><p class=3D"m_-1629230902338740653yi=
v7612199202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-=
size:10pt">=C2=A0</span></p><p class=3D"m_-1629230902338740653yiv7612199202=
MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">=
DESCRIPTION =3D &quot;Simple helloworld application&quot;</span></p><p clas=
s=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:san=
s-serif"><span style=3D"font-size:10pt">SECTION =3D &quot;examples&quot;</s=
pan></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"=
font-family:sans-serif"><span style=3D"font-size:10pt">DEPENDS =3D &quot;&q=
uot;</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" st=
yle=3D"font-family:sans-serif"><span style=3D"font-size:10pt">LICENSE =3D &=
quot;MIT&quot;</span></p><p class=3D"m_-1629230902338740653yiv7612199202Mso=
Normal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">#LI=
C_FILES_CHKSUM =3D &quot;file://LICENSE;md5=3D0835ade698e0bcf8506ecda2f7b4f=
302&quot;</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNorma=
l" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">LIC_FILE=
S_CHKSUM =3D &quot;file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0bcf85=
06ecda2f7b4f302&quot;</span></p><p class=3D"m_-1629230902338740653yiv761219=
9202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10=
pt">#FILESEXTRAPATHS_prepend :=3D &quot;${THISDIR}/${PN}-${PV}:&quot;</span=
></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"fon=
t-family:sans-serif"><span style=3D"font-size:10pt">=C2=A0</span></p><p cla=
ss=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:sa=
ns-serif"><span style=3D"font-size:10pt">SRCREV =3D &quot;4ec84957442182f36=
351f94c0626560ec3ffd487&quot;</span></p><p class=3D"m_-1629230902338740653y=
iv7612199202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font=
-size:10pt">#SRC_URI =3D &quot;<a href=3D"https://github.com/DynamicDevices=
/bbexample.git" target=3D"_blank">https://github.com/DynamicDevices/bbexamp=
le.git</a>&quot;</span></p><p class=3D"m_-1629230902338740653yiv7612199202M=
soNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">S=
RC_URI =3D &quot;file://bbexample-0.1.tar.gz&quot;</span></p><p class=3D"m_=
-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif=
"><span style=3D"font-size:10pt">S =3D &quot;${WORKDIR}/bbexample&quot;</sp=
an></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"f=
ont-family:sans-serif"><span style=3D"font-size:10pt">=C2=A0</span></p><p c=
lass=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:=
sans-serif"><span style=3D"font-size:10pt">do_configure_prepend () {</span>=
</p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font=
-family:sans-serif"><span style=3D"font-size:10pt">=C2=A0 ${S}/autogen.sh</=
span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D=
"font-family:sans-serif"><span style=3D"font-size:10pt">}</span></p></div><=
/blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">The equivalent of=
 autogen.sh is already done for you in autotools.bbclass&#39;s do_configure=
(). I&#39;d suggest removing this.</div><div dir=3D"auto"><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div id=3D"m_-1629230902338740653yMail_cursorElemen=
tTracker_1525935014276"><p class=3D"m_-1629230902338740653yiv7612199202MsoN=
ormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt"></sp=
an></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"f=
ont-family:sans-serif"><span style=3D"font-size:10pt">inherit autotools</sp=
an></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"f=
ont-family:sans-serif"><span style=3D"font-size:10pt">=C2=A0</span></p><p c=
lass=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:=
sans-serif"><b><u><span style=3D"font-size:10pt">Sources</span></u></b></p>=
<p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-fam=
ily:sans-serif"><b><u><span style=3D"font-size:10pt"><span style=3D"text-de=
coration-line:none">=C2=A0</span></span></u></b></p><p class=3D"m_-16292309=
02338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span s=
tyle=3D"font-size:10pt">-rwxr-xr-x 1 umn5cob umn5cob=C2=A0=C2=A0 294 May 10=
 01:41 autogen.sh</span></p><p class=3D"m_-1629230902338740653yiv7612199202=
MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">=
-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 274 May 10 01:41 bbexample.c</span=
></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"fon=
t-family:sans-serif"><span style=3D"font-size:10pt">-rw-r--r-- 1 umn5cob um=
n5cob=C2=A0=C2=A0 259 May 10 01:41 bbexample.h</span></p><p class=3D"m_-162=
9230902338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><s=
pan style=3D"font-size:10pt">-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 374 M=
ay 10 01:41 bbexamplelib.c</span></p><p class=3D"m_-1629230902338740653yiv7=
612199202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-si=
ze:10pt">-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 659 May 10 01:41 <a href=
=3D"http://configure.ac" target=3D"_blank">configure.ac</a></span></p><p c=
lass=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:=
sans-serif"><span style=3D"font-size:10pt">-rw-r--r-- 1 umn5cob umn5cob=C2=
=A0=C2=A0 303 May 10 01:41 Makefile.am</span></p><p class=3D"m_-1629230902=
338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span sty=
le=3D"font-size:10pt">-rw-rw-r-- 1 umn5cob umn5cob 30416 May 10 02:02 Makef=
ile.in</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" =
style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">=C2=A0</spa=
n></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"fo=
nt-family:sans-serif"><b><u><span style=3D"font-size:10pt">Error:</span></u=
></b></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D=
"font-family:sans-serif"><span style=3D"font-size:10pt">NOTE: Preparing Run=
Queue</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" s=
tyle=3D"font-family:sans-serif"><span style=3D"font-size:10pt">NOTE: Execut=
ing SetScene Tasks</span></p><p class=3D"m_-1629230902338740653yiv761219920=
2MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt"=
>NOTE: Executing RunQueue Tasks</span></p><p class=3D"m_-162923090233874065=
3yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><b><span style=3D=
"font-size:10pt">ERROR: Function failed: do_configure (log file is located =
at /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.=
0-r0/temp/log.do_configure.24121)</span></b></p><p class=3D"m_-162923090233=
8740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><b><span st=
yle=3D"font-size:10pt">ERROR: Logfile of failure stored in: /home/umn5cob/y=
octo/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do_c=
onfigure.24121</span></b></p><p class=3D"m_-1629230902338740653yiv761219920=
2MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt"=
>Log data follows:</span></p><p class=3D"m_-1629230902338740653yiv761219920=
2MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt"=
>| DEBUG: Executing python function sysroot_cleansstate</span></p><p class=
=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:san=
s-serif"><span style=3D"font-size:10pt">| DEBUG: Python function sysroot_cl=
eansstate finished</span></p><p class=3D"m_-1629230902338740653yiv761219920=
2MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt"=
>| DEBUG: SITE files [&#39;endian-little&#39;, &#39;common-linux&#39;, &#39=
;common-glibc&#39;, &#39;bit-64&#39;, &#39;x86_64-linux&#39;, &#39;common&#=
39;]</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" st=
yle=3D"font-family:sans-serif"><span style=3D"font-size:10pt">| DEBUG: Exec=
uting shell function autotools_preconfigure</span></p><p class=3D"m_-162923=
0902338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span=
 style=3D"font-size:10pt">| Previously configured separate build directory =
detected, cleaning /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-li=
nux/bbexample/1.0-r0/build</span></p><p class=3D"m_-1629230902338740653yiv7=
612199202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-si=
ze:10pt">| DEBUG: Shell function autotools_preconfigure finished</span></p>=
<p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-fam=
ily:sans-serif"><span style=3D"font-size:10pt">| DEBUG: Executing python fu=
nction autotools_copy_aclocals</span></p><p class=3D"m_-1629230902338740653=
yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"fon=
t-size:10pt">| DEBUG: SITE files [&#39;endian-little&#39;, &#39;common-linu=
x&#39;, &#39;common-glibc&#39;, &#39;bit-64&#39;, &#39;x86_64-linux&#39;, &=
#39;common&#39;]</span></p><p class=3D"m_-1629230902338740653yiv7612199202M=
soNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">|=
 DEBUG: Python function autotools_copy_aclocals finished</span></p><p class=
=
=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:san=
s-serif"><span style=3D"font-size:10pt">| DEBUG: Executing shell function d=
o_configure</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNor=
mal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">| Gene=
rating configure files... may take a while.</span></p><p class=3D"m_-162923=
0902338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span=
 style=3D"font-size:10pt">| autoreconf: &#39;<a href=3D"http://configure.ac=
" target=3D"_blank">configure.ac</a>&#39; or &#39;<a href=3D"http://configu=
re.in" target=3D"_blank">configure.in</a>&#39; is required</span></p><p cla=
ss=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font-family:sa=
ns-serif"><span style=3D"font-size:10pt">| WARNING: exit code 1 from a shel=
l command.</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNorm=
al" style=3D"font-family:sans-serif"><b><span style=3D"font-size:10pt">| ER=
ROR: Function failed: do_configure (log file is located at /home/umn5cob/yo=
cto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do_co=
nfigure.24121)</span></b></p><p class=3D"m_-1629230902338740653yiv761219920=
2MsoNormal" style=3D"font-family:sans-serif"><b><span style=3D"font-size:10=
pt">ERROR: Task 5 (/home/umn5cob/yocto/poky/meta-yocto-bsp/recipes-bbexampl=
e_1.0/bbexample/<a href=3D"http://bbexample_1.0.bb" target=3D"_blank">bbexa=
mple_1.0.bb</a>, do_configure) failed with exit code &#39;1&#39;</span></b>=
</p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"font=
-family:sans-serif"><span style=3D"font-size:10pt">NOTE: Tasks Summary: Att=
empted 533 tasks of which 532 didn&#39;t need to be rerun and 1 failed.</sp=
an></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal" style=3D"f=
ont-family:sans-serif"><span style=3D"font-size:10pt">No currently running =
tasks (510 of 543)</span></p><p class=3D"m_-1629230902338740653yiv761219920=
2MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt"=
>=C2=A0</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNormal"=
 style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">Summary: 1=
 task failed:</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoN=
ormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">=C2=
=A0 /home/umn5cob/yocto/poky/meta-yocto-bsp/recipes-bbexample_1.0/bbexampl=
e/<a href=3D"http://bbexample_1.0.bb" target=3D"_blank">bbexample_1.0.bb</a=
>, do_configure</span></p><p class=3D"m_-1629230902338740653yiv7612199202Ms=
oNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt">Su=
mmary: There was 1 WARNING message shown.</span></p><p class=3D"m_-16292309=
02338740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span s=
tyle=3D"font-size:10pt">Summary: There was 1 ERROR message shown, returning=
 a non-zero exit code.</span></p><p class=3D"m_-1629230902338740653yiv76121=
99202MsoNormal" style=3D"font-family:sans-serif"><span style=3D"font-size:1=
0pt">=C2=A0</span></p><p class=3D"m_-1629230902338740653yiv7612199202MsoNor=
mal" style=3D"font-family:sans-serif"><span style=3D"font-size:10pt" id=3D"=
m_-1629230902338740653yMail_cursorElementTracker_1525935034512">Someone ple=
ase guide me what is missed and error?</span></p><p class=3D"m_-16292309023=
38740653yiv7612199202MsoNormal" style=3D"font-family:sans-serif"><span styl=
e=3D"font-size:10pt" id=3D"m_-1629230902338740653yMail_cursorElementTracker=
_1525935029175">=C2=A0</span></p><div id=3D"m_-1629230902338740653ymail_and=
roid_signature"><a href=3D"https://overview.mail.yahoo.com/mobile/?.src=3DA=
ndroid" target=3D"_blank"></a></div> <br> <blockquote style=3D"margin:0 0 2=
0px 0"> <div style=3D"font-family:Roboto,sans-serif;color:#6d00f6"> <div>On=
 Thu, 10 May 2018 at 5:59 a.m., Andre McCurdy</div><div>&lt;<a href=3D"mail=
to:armccurdy@gmail.com" target=3D"_blank">armccurdy@gmail.com</a>&gt; wrote=
:</div> </div> <div style=3D"padding:10px 0 0 20px;margin:10px 0 0 0;border=
-left:1px solid #6d00f6"> <div id=3D"m_-1629230902338740653yiv1290272822"><=
div><div class=3D"m_-1629230902338740653yiv1290272822yqt9330019662 m_-16292=
30902338740653yQTDBase" id=3D"m_-1629230902338740653yiv1290272822yqtfd04591=
"><div>On Wed, May 9, 2018 at 8:59 AM, Ugesh Reddy via bitbake-devel <span>=
&lt;<a rel=3D"nofollow" shape=3D"rect" href=3D"mailto:bitbake-devel@lists.o=
penembedded.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a>=
&gt;</span> wrote:<br clear=3D"none"><div class=3D"m_-1629230902338740653yi=
v1290272822gmail_extra"><div class=3D"m_-1629230902338740653yiv1290272822gm=
ail_quote"><blockquote class=3D"m_-1629230902338740653yiv1290272822gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hello,<div id=3D"m_-1629230902338740653yiv1290272822gm=
ail-m_-2798005002225837817yMail_cursorElementTracker_1525881354960">=C2=A0T=
he devtool hides out the information and trying to learn bitbake and wanted=
 understand each entry in the .BB files.So I would to write it instead of t=
ool.</div><div id=3D"m_-1629230902338740653yiv1290272822gmail-m_-2798005002=
225837817yMail_cursorElementTracker_1525881480048"><br clear=3D"none"></div=
><div id=3D"m_-1629230902338740653yiv1290272822gmail-m_-2798005002225837817=
yMail_cursorElementTracker_1525881480127">Could you guide me?</div></blockq=
uote><div><br clear=3D"none"></div><div>How to write a recipe is well docum=
ented:<br clear=3D"none"></div><div><br clear=3D"none">=C2=A0 <a rel=3D"nof=
ollow" shape=3D"rect" href=3D"https://www.yoctoproject.org/docs/current/meg=
a-manual/mega-manual.html#new-recipe-writing-a-new-recipe" target=3D"_blank=
">https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#ne=
w-recipe-writing-a-new-recipe</a><br clear=3D"none">=C2=A0 <a rel=3D"nofoll=
ow" shape=3D"rect" href=3D"https://www.yoctoproject.org/docs/current/mega-m=
anual/mega-manual.html#new-recipe-autotooled-package" target=3D"_blank">htt=
ps://www.yoctoproject.org/docs/current/mega-manual/mega-manual.html#new-rec=
ipe-autotooled-package</a><br clear=3D"none"><br clear=3D"none"></div><div>=
You can also learn a lot by reviewing and understanding the recipes in oe-c=
ore.<br clear=3D"none"></div><div><br clear=3D"none"></div></div></div></di=
v></div></div></div> </div> </blockquote></div>-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">=
bitbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" r=
el=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/l=
istinfo/bitbake-devel</a><br>
</blockquote></div></div>

--00000000000093c8c0056bd7e5d2--
