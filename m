Return-Path: <kumar.ugesh003@yahoo.com>
Received: from sonic301-19.consmr.mail.sg3.yahoo.com
	(sonic301-19.consmr.mail.sg3.yahoo.com [106.10.242.82])
	by mail.openembedded.org (Postfix) with ESMTP id 41FA2751A2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2018 06:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1525935241; bh=TwTmnz7bvaswdfvsQAhvFoPJdmz2eZktc2D+pD/W90w=;
	h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject;
	b=P52yJzuXoIMN35vHYvdhejyP1nEytSRUKSAAetduuIfrQ8+XoWkVn9RKp+O1dNrRgXiuZPAUslxf5mIegtyP1IvULcGjlRsnsheo3me8cfYFiZ2fsKHTTjJrdUiyscjLHijkyZc/694YwP0wPK4/wCV580pBfPRexJwibTiSQsowS8U/Buqx+/HM4vfRG99z4EI3+dKpXY+1rK/It5c2m2714KJeJ2sbKbnnxG4pp8LFe34HUuuqqwjZzq3KypC+W2pIXIcFonVvSYUSu+9wKG8aW1hHD78/vBzn6lLMq9WZQJ3Esl834lX+GL9Qz5VECgQ7rS3h+AL/tQ3fAtSLTg==
X-YMail-OSG: QBLr_PoVM1lprb9Ov61ElZ7CBddf4wmOGHm_PfdEkTU5nvpNlLgRRd1pvzP72iT
	bGYXj9OT0m85VRgQXY.CWi.Rpv81NFFOdNUA_IuuD91T53EoJjGaJ8DA99j3tkuN9THayPEd15nO
	I3u.fu1VkYoUQg9ALnQ.cBYvJlWYwIytw5D4H8uPKQn.8vpVLqK.v2XZIc3q7pl_LgSJAubLbjS_
	YEbmbqgZgkiRtFIH9wKzCMx7FDn8h85UyFdsUMdYp7OIfaBXs7mPJz5NucfZ7sVxJSCKrFpxhbBF
	N3B3TI7DM0scc12n_aNZgsIe3npOxoDU4OFgDsc410zMX7iRh4dD.Eo8r_OgqpxXiZAKuNrRVCxD
	cNg1gXVdnnpBnNR7XVUA4awVFhURrWY_3CPt8eIrcBvknJZkXki4LgjrtPp5E662Ibb3tHv4kwmC
	Re8kvZ24T08L5Kr7JNHtoENjl0I8M8PqjsbbZKNmp9lbP1jppciMNmJfJDnZQp_mp9U7z.dGqiVT
	iOrY9PzbS1OFvYELnZ8fIOLmi2sM0g0hJfe9EIN2TYxeZrkeytYNKkgExDAavHROb.sTgSpguNzg
	jlDvCH_.OSdlLu57OwrZ9AA4rmbHZTCqNzJ7U4jP54NiyALMuKUdnTA--
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic301.consmr.mail.sg3.yahoo.com with HTTP;
	Thu, 10 May 2018 06:54:01 +0000
Date: Thu, 10 May 2018 06:53:52 +0000 (UTC)
From: Ugesh Reddy <kumar.ugesh003@yahoo.com>
Reply-To: "kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>
To: "armccurdy@gmail.com" <armccurdy@gmail.com>
Message-ID: <628795431.1912899.1525935232611@mail.yahoo.com>
In-Reply-To: <CAJ86T=VW2yODWtD_Fx+3436GKQYwuFL2jnHoy3xpsQ1SA4Mk3A@mail.gmail.com>
References: <1184471455.1381374.1525832300014.ref@mail.yahoo.com>
	<1184471455.1381374.1525832300014@mail.yahoo.com>
	<CAJTo0LZGEBwiZr7csd3vxYaThN7-fTjexeRfkT+1ksX-AerbvA@mail.gmail.com>
	<838865895.1728045.1525881582620@mail.yahoo.com>
	<CAJ86T=VW2yODWtD_Fx+3436GKQYwuFL2jnHoy3xpsQ1SA4Mk3A@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: WebService/1.1.11848 YahooMailAndroidMobile YMobile/1.0
	(com.yahoo.mobile.client.android.mail/5.24.8; Android/6.0;
	MPB24.65-34-3; titan_umtsds; motorola; XT1068; 4.69; 1184x720; )
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
X-List-Received-Date: Thu, 10 May 2018 06:54:02 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_1912898_314466092.1525935232606"

------=_Part_1912898_314466092.1525935232606
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks a lot for the reference manual.

=C2=A0

I have created example recipe.

=C2=A0

The content of the .bb file:

=C2=A0

#

# This file was derived from the 'Hello World!' example recipe in the

# Yocto Project Development Manual.

#

=C2=A0

DESCRIPTION =3D "Simple helloworld application"

SECTION =3D "examples"

DEPENDS =3D ""

LICENSE =3D "MIT"

#LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D0835ade698e0bcf8506ecda2f7b4f3=
02"

LIC_FILES_CHKSUM =3D "file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0b=
cf8506ecda2f7b4f302"

#FILESEXTRAPATHS_prepend :=3D "${THISDIR}/${PN}-${PV}:"

=C2=A0

SRCREV =3D "4ec84957442182f36351f94c0626560ec3ffd487"

#SRC_URI =3D "https://github.com/DynamicDevices/bbexample.git"

SRC_URI =3D "file://bbexample-0.1.tar.gz"

S =3D "${WORKDIR}/bbexample"

=C2=A0

do_configure_prepend () {

=C2=A0 ${S}/autogen.sh

}

inherit autotools

=C2=A0

Sources

=C2=A0

-rwxr-xr-x 1 umn5cob umn5cob=C2=A0=C2=A0 294 May 10 01:41 autogen.sh

-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 274 May 10 01:41 bbexample.c

-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 259 May 10 01:41 bbexample.h

-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 374 May 10 01:41 bbexamplelib.c

-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 659 May 10 01:41 configure.ac

-rw-r--r-- 1 umn5cob umn5cob=C2=A0=C2=A0 303 May 10 01:41 Makefile.am

-rw-rw-r-- 1 umn5cob umn5cob 30416 May 10 02:02 Makefile.in

=C2=A0

Error:

NOTE: Preparing RunQueue

NOTE: Executing SetScene Tasks

NOTE: Executing RunQueue Tasks

ERROR: Function failed: do_configure (log file is located at /home/umn5cob=
/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do=
_configure.24121)

ERROR: Logfile of failure stored in: /home/umn5cob/yocto/poky/build/tmp/wo=
rk/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do_configure.24121

Log data follows:

| DEBUG: Executing python function sysroot_cleansstate

| DEBUG: Python function sysroot_cleansstate finished

| DEBUG: SITE files ['endian-little', 'common-linux', 'common-glibc', 'bit=
-64', 'x86_64-linux', 'common']

| DEBUG: Executing shell function autotools_preconfigure

| Previously configured separate build directory detected, cleaning /home/=
umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/buil=
d

| DEBUG: Shell function autotools_preconfigure finished

| DEBUG: Executing python function autotools_copy_aclocals

| DEBUG: SITE files ['endian-little', 'common-linux', 'common-glibc', 'bit=
-64', 'x86_64-linux', 'common']

| DEBUG: Python function autotools_copy_aclocals finished

| DEBUG: Executing shell function do_configure

| Generating configure files... may take a while.

| autoreconf: 'configure.ac' or 'configure.in' is required

| WARNING: exit code 1 from a shell command.

| ERROR: Function failed: do_configure (log file is located at /home/umn5c=
ob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.=
do_configure.24121)

ERROR: Task 5 (/home/umn5cob/yocto/poky/meta-yocto-bsp/recipes-bbexample_1=
.0/bbexample/bbexample_1.0.bb, do_configure) failed with exit code '1'

NOTE: Tasks Summary: Attempted 533 tasks of which 532 didn't need to be re=
run and 1 failed.

No currently running tasks (510 of 543)

=C2=A0

Summary: 1 task failed:

=C2=A0 /home/umn5cob/yocto/poky/meta-yocto-bsp/recipes-bbexample_1.0/bbexa=
mple/bbexample_1.0.bb, do_configure

Summary: There was 1 WARNING message shown.

Summary: There was 1 ERROR message shown, returning a non-zero exit code.

=C2=A0

Someone please guide me what is missed and error?

=C2=A0
  On Thu, 10 May 2018 at 5:59 a.m., Andre McCurdy<armccurdy@gmail.com> wro=
te:   On Wed, May 9, 2018 at 8:59 AM, Ugesh Reddy via bitbake-devel <bitbak=
e-devel@lists.openembedded.org> wrote:

Hello,=C2=A0The devtool hides out the information and trying to learn bitb=
ake and wanted understand each entry in the .BB files.So I would to write i=
t instead of tool.
Could you guide me?

How to write a recipe is well documented:

=C2=A0 https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.h=
tml#new-recipe-writing-a-new-recipe
=C2=A0 https://www.yoctoproject.org/docs/current/mega-manual/mega-manual.h=
tml#new-recipe-autotooled-package

You can also learn a lot by reviewing and understanding the recipes in oe-=
core.

  

------=_Part_1912898_314466092.1525935232606
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,<div id=3D"yMail_cursorElementTracker_1525935014276"><br id=3D"yMail_=
cursorElementTracker_1525934931905"><p class=3D"yiv7612199202MsoNormal" sty=
le=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"o=
verflow-wrap: break-word; font-size: 10pt;">Thanks a lot for the reference =
manual.</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wra=
p: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: brea=
k-word; font-size: 10pt;">&nbsp;</span></p><p class=3D"yiv7612199202MsoNorm=
al" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span sty=
le=3D"overflow-wrap: break-word; font-size: 10pt;">I have created example r=
ecipe.</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap=
: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break=
-word; font-size: 10pt;">&nbsp;</span></p><p class=3D"yiv7612199202MsoNorma=
l" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><b style=
=3D"overflow-wrap: break-word;"><u style=3D"overflow-wrap: break-word;"><s=
pan style=3D"overflow-wrap: break-word; font-size: 10pt;">The content of th=
e .bb file:</span></u></b></p><p class=3D"yiv7612199202MsoNormal" style=3D"=
overflow-wrap: break-word; font-family: sans-serif;"><b style=3D"overflow-w=
rap: break-word;"><u style=3D"overflow-wrap: break-word;"><span style=3D"ov=
erflow-wrap: break-word; font-size: 10pt;"><span style=3D"overflow-wrap: br=
eak-word; text-decoration-line: none;">&nbsp;</span></span></u></b></p><p c=
lass=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-fa=
mily: sans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10p=
t;">#</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap:=
 break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-=
word; font-size: 10pt;"># This file was derived from the 'Hello World!' exa=
mple recipe in the</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"o=
verflow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow=
-wrap: break-word; font-size: 10pt;"># Yocto Project Development Manual.</s=
pan></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-w=
ord; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; fo=
nt-size: 10pt;">#</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"ov=
erflow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-=
wrap: break-word; font-size: 10pt;">&nbsp;</span></p><p class=3D"yiv7612199=
202MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"=
><span style=3D"overflow-wrap: break-word; font-size: 10pt;">DESCRIPTION =
=3D "Simple helloworld application"</span></p><p class=3D"yiv7612199202Mso=
Normal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span=
 style=3D"overflow-wrap: break-word; font-size: 10pt;">SECTION =3D "example=
s"</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: br=
eak-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-wor=
d; font-size: 10pt;">DEPENDS =3D ""</span></p><p class=3D"yiv7612199202MsoN=
ormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span =
style=3D"overflow-wrap: break-word; font-size: 10pt;">LICENSE =3D "MIT"</sp=
an></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-wo=
rd; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; fon=
t-size: 10pt;">#LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D0835ade698e0bcf8=
506ecda2f7b4f302"</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"ov=
erflow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-=
wrap: break-word; font-size: 10pt;">LIC_FILES_CHKSUM =3D "file://${COMMON_L=
ICENSE_DIR}/MIT;md5=3D0835ade698e0bcf8506ecda2f7b4f302"</span></p><p class=
=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-famil=
y: sans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;"=
>#FILESEXTRAPATHS_prepend :=3D "${THISDIR}/${PN}-${PV}:"</span></p><p class=
=
=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-famil=
y: sans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;"=
>&nbsp;</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wra=
p: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: brea=
k-word; font-size: 10pt;">SRCREV =3D "4ec84957442182f36351f94c0626560ec3ffd=
487"</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: =
break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-w=
ord; font-size: 10pt;">#SRC_URI =3D "https://github.com/DynamicDevices/bbex=
ample.git"</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-=
wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: b=
reak-word; font-size: 10pt;">SRC_URI =3D "file://bbexample-0.1.tar.gz"</spa=
n></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-wor=
d; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; font=
-size: 10pt;">S =3D "${WORKDIR}/bbexample"</span></p><p class=3D"yiv7612199=
202MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"=
><span style=3D"overflow-wrap: break-word; font-size: 10pt;">&nbsp;</span><=
/p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; =
font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; font-si=
ze: 10pt;">do_configure_prepend () {</span></p><p class=3D"yiv7612199202Mso=
Normal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span=
 style=3D"overflow-wrap: break-word; font-size: 10pt;">&nbsp; ${S}/autogen.=
sh</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: br=
eak-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-wor=
d; font-size: 10pt;">}</span></p><p class=3D"yiv7612199202MsoNormal" style=
=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"ov=
erflow-wrap: break-word; font-size: 10pt;">inherit autotools</span></p><p c=
lass=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-fa=
mily: sans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10p=
t;">&nbsp;</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-=
wrap: break-word; font-family: sans-serif;"><b style=3D"overflow-wrap: brea=
k-word;"><u style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wr=
ap: break-word; font-size: 10pt;">Sources</span></u></b></p><p class=3D"yiv=
7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-=
serif;"><b style=3D"overflow-wrap: break-word;"><u style=3D"overflow-wrap: =
break-word;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;"><s=
pan style=3D"overflow-wrap: break-word; text-decoration-line: none;">&nbsp;=
</span></span></u></b></p><p class=3D"yiv7612199202MsoNormal" style=3D"over=
flow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-wr=
ap: break-word; font-size: 10pt;">-rwxr-xr-x 1 umn5cob umn5cob&nbsp;&nbsp; =
294 May 10 01:41 autogen.sh</span></p><p class=3D"yiv7612199202MsoNormal" s=
tyle=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D=
"overflow-wrap: break-word; font-size: 10pt;">-rw-r--r-- 1 umn5cob umn5cob&=
nbsp;&nbsp; 274 May 10 01:41 bbexample.c</span></p><p class=3D"yiv761219920=
2MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><=
span style=3D"overflow-wrap: break-word; font-size: 10pt;">-rw-r--r-- 1 umn=
5cob umn5cob&nbsp;&nbsp; 259 May 10 01:41 bbexample.h</span></p><p class=3D=
"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: s=
ans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;">-rw=
-r--r-- 1 umn5cob umn5cob&nbsp;&nbsp; 374 May 10 01:41 bbexamplelib.c</span=
></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word=
; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; font-=
size: 10pt;">-rw-r--r-- 1 umn5cob umn5cob&nbsp;&nbsp; 659 May 10 01:41 conf=
igure.ac</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wr=
ap: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: bre=
ak-word; font-size: 10pt;">-rw-r--r-- 1 umn5cob umn5cob&nbsp;&nbsp; 303 May=
 10 01:41 Makefile.am</span></p><p class=3D"yiv7612199202MsoNormal" style=
=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"ov=
erflow-wrap: break-word; font-size: 10pt;">-rw-rw-r-- 1 umn5cob umn5cob 304=
16 May 10 02:02 Makefile.in</span></p><p class=3D"yiv7612199202MsoNormal" s=
tyle=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D=
"overflow-wrap: break-word; font-size: 10pt;">&nbsp;</span></p><p class=3D"=
yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: sa=
ns-serif;"><b style=3D"overflow-wrap: break-word;"><u style=3D"overflow-wra=
p: break-word;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;"=
>Error:</span></u></b></p><p class=3D"yiv7612199202MsoNormal" style=3D"over=
flow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-wr=
ap: break-word; font-size: 10pt;">NOTE: Preparing RunQueue</span></p><p cla=
ss=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-fami=
ly: sans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;=
">NOTE: Executing SetScene Tasks</span></p><p class=3D"yiv7612199202MsoNorm=
al" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span sty=
le=3D"overflow-wrap: break-word; font-size: 10pt;">NOTE: Executing RunQueue=
 Tasks</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap=
: break-word; font-family: sans-serif;"><b style=3D"overflow-wrap: break-wo=
rd;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;">ERROR: Fun=
ction failed: do_configure (log file is located at /home/umn5cob/yocto/poky=
/build/tmp/work/core2-64-poky-linux/bbexample/1.0-r0/temp/log.do_configure.=
24121)</span></b></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-=
wrap: break-word; font-family: sans-serif;"><b style=3D"overflow-wrap: brea=
k-word;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;">ERROR:=
 Logfile of failure stored in: /home/umn5cob/yocto/poky/build/tmp/work/core=
2-64-poky-linux/bbexample/1.0-r0/temp/log.do_configure.24121</span></b></p>=
<p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; fon=
t-family: sans-serif;"><span style=3D"overflow-wrap: break-word; font-size:=
 10pt;">Log data follows:</span></p><p class=3D"yiv7612199202MsoNormal" sty=
le=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"o=
verflow-wrap: break-word; font-size: 10pt;">| DEBUG: Executing python funct=
ion sysroot_cleansstate</span></p><p class=3D"yiv7612199202MsoNormal" style=
=
=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"ov=
erflow-wrap: break-word; font-size: 10pt;">| DEBUG: Python function sysroot=
_cleansstate finished</span></p><p class=3D"yiv7612199202MsoNormal" style=
=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"ov=
erflow-wrap: break-word; font-size: 10pt;">| DEBUG: SITE files ['endian-lit=
tle', 'common-linux', 'common-glibc', 'bit-64', 'x86_64-linux', 'common']</=
span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-=
word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; f=
ont-size: 10pt;">| DEBUG: Executing shell function autotools_preconfigure</=
span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-=
word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; f=
ont-size: 10pt;">| Previously configured separate build directory detected,=
 cleaning /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bbexa=
mple/1.0-r0/build</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"ov=
erflow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-=
wrap: break-word; font-size: 10pt;">| DEBUG: Shell function autotools_preco=
nfigure finished</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"ove=
rflow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-w=
rap: break-word; font-size: 10pt;">| DEBUG: Executing python function autot=
ools_copy_aclocals</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"o=
verflow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow=
-wrap: break-word; font-size: 10pt;">| DEBUG: SITE files ['endian-little', =
'common-linux', 'common-glibc', 'bit-64', 'x86_64-linux', 'common']</span><=
/p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; =
font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; font-si=
ze: 10pt;">| DEBUG: Python function autotools_copy_aclocals finished</span>=
</p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word;=
 font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; font-s=
ize: 10pt;">| DEBUG: Executing shell function do_configure</span></p><p cla=
ss=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-fami=
ly: sans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;=
">| Generating configure files... may take a while.</span></p><p class=3D"y=
iv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: san=
s-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;">| aut=
oreconf: 'configure.ac' or 'configure.in' is required</span></p><p class=3D=
"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: s=
ans-serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;">| W=
ARNING: exit code 1 from a shell command.</span></p><p class=3D"yiv76121992=
02MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;">=
<b style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap: break=
-word; font-size: 10pt;">| ERROR: Function failed: do_configure (log file i=
s located at /home/umn5cob/yocto/poky/build/tmp/work/core2-64-poky-linux/bb=
example/1.0-r0/temp/log.do_configure.24121)</span></b></p><p class=3D"yiv76=
12199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-se=
rif;"><b style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap:=
 break-word; font-size: 10pt;">ERROR: Task 5 (/home/umn5cob/yocto/poky/meta=
-yocto-bsp/recipes-bbexample_1.0/bbexample/bbexample_1.0.bb, do_configure) =
failed with exit code '1'</span></b></p><p class=3D"yiv7612199202MsoNormal"=
 style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=
=3D"overflow-wrap: break-word; font-size: 10pt;">NOTE: Tasks Summary: Atte=
mpted 533 tasks of which 532 didn't need to be rerun and 1 failed.</span></=
p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break-word; f=
ont-family: sans-serif;"><span style=3D"overflow-wrap: break-word; font-siz=
e: 10pt;">No currently running tasks (510 of 543)</span></p><p class=3D"yiv=
7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-=
serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;">&nbsp;<=
/span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap: break=
-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word; =
font-size: 10pt;">Summary: 1 task failed:</span></p><p class=3D"yiv76121992=
02MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;">=
<span style=3D"overflow-wrap: break-word; font-size: 10pt;">&nbsp; /home/um=
n5cob/yocto/poky/meta-yocto-bsp/recipes-bbexample_1.0/bbexample/bbexample_1=
.0.bb, do_configure</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"=
overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflo=
w-wrap: break-word; font-size: 10pt;">Summary: There was 1 WARNING message =
shown.</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"overflow-wrap=
: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break=
-word; font-size: 10pt;">Summary: There was 1 ERROR message shown, returnin=
g a non-zero exit code.</span></p><p class=3D"yiv7612199202MsoNormal" style=
=
=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=3D"ov=
erflow-wrap: break-word; font-size: 10pt;">&nbsp;</span></p><p class=3D"yiv=
7612199202MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-=
serif;"><span style=3D"overflow-wrap: break-word; font-size: 10pt;" id=3D"y=
Mail_cursorElementTracker_1525935034512">Someone please guide me what is mi=
ssed and error?</span></p><p class=3D"yiv7612199202MsoNormal" style=3D"over=
flow-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-wr=
ap: break-word; font-size: 10pt;" id=3D"yMail_cursorElementTracker_15259350=
29175">&nbsp;</span></p><div id=3D"ymail_android_signature"><a href=3D"http=
s://overview.mail.yahoo.com/mobile/?.src=3DAndroid"></a></div> <br> <blockq=
uote style=3D"margin: 0 0 20px 0;"> <div style=3D"font-family:Roboto, sans-=
serif; color:#6D00F6;"> <div>On Thu, 10 May 2018 at 5:59 a.m., Andre McCurd=
y</div><div>&lt;armccurdy@gmail.com&gt; wrote:</div> </div> <div style=3D"p=
adding: 10px 0 0 20px; margin: 10px 0 0 0; border-left: 1px solid #6D00F6;"=
> <div id=3D"yiv1290272822"><div><div class=3D"yiv1290272822yqt9330019662 y=
QTDBase" id=3D"yiv1290272822yqtfd04591"><div dir=3D"ltr">On Wed, May 9, 201=
8 at 8:59 AM, Ugesh Reddy via bitbake-devel <span dir=3D"ltr">&lt;<a rel=3D=
"nofollow" shape=3D"rect" ymailto=3D"mailto:bitbake-devel@lists.openembedde=
d.org" target=3D"_blank" href=3D"mailto:bitbake-devel@lists.openembedded.or=
g">bitbake-devel@lists.openembedded.org</a>&gt;</span> wrote:<br clear=3D"n=
one"><div class=3D"yiv1290272822gmail_extra"><div class=3D"yiv1290272822gma=
il_quote"><blockquote class=3D"yiv1290272822gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex;">H=
ello,<div id=3D"yiv1290272822gmail-m_-2798005002225837817yMail_cursorElemen=
tTracker_1525881354960">&nbsp;The devtool hides out the information and try=
ing to learn bitbake and wanted understand each entry in the .BB files.So I=
 would to write it instead of tool.</div><div id=3D"yiv1290272822gmail-m_-2=
798005002225837817yMail_cursorElementTracker_1525881480048"><br clear=3D"no=
ne"></div><div id=3D"yiv1290272822gmail-m_-2798005002225837817yMail_cursorE=
lementTracker_1525881480127">Could you guide me?</div></blockquote><div><br=
 clear=3D"none"></div><div>How to write a recipe is well documented:<br cle=
ar=3D"none"></div><div><br clear=3D"none">&nbsp; <a rel=3D"nofollow" shape=
=3D"rect" target=3D"_blank" href=3D"https://www.yoctoproject.org/docs/curr=
ent/mega-manual/mega-manual.html#new-recipe-writing-a-new-recipe">https://w=
ww.yoctoproject.org/docs/current/mega-manual/mega-manual.html#new-recipe-wr=
iting-a-new-recipe</a><br clear=3D"none">&nbsp; <a rel=3D"nofollow" shape=
=3D"rect" target=3D"_blank" href=3D"https://www.yoctoproject.org/docs/curr=
ent/mega-manual/mega-manual.html#new-recipe-autotooled-package">https://www=
.yoctoproject.org/docs/current/mega-manual/mega-manual.html#new-recipe-auto=
tooled-package</a><br clear=3D"none"><br clear=3D"none"></div><div>You can =
also learn a lot by reviewing and understanding the recipes in oe-core.<br =
clear=3D"none"></div><div><br clear=3D"none"></div></div></div></div></div>=
</div></div> </div> </blockquote></div>

------=_Part_1912898_314466092.1525935232606--
