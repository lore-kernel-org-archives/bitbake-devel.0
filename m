Return-Path: <kumar.ugesh003@yahoo.com>
Received: from sonic305-20.consmr.mail.sg3.yahoo.com
	(sonic305-20.consmr.mail.sg3.yahoo.com [106.10.241.83])
	by mail.openembedded.org (Postfix) with ESMTP id AF6276C5D3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Nov 2018 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1543235063; bh=87GWSh+xE1/gv+0g2d836MDt0fGMInTpreMKq7htFrg=;
	h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject;
	b=aJbolOBA9amlqmfR5eV9BsflXb4oyVDHw0Xs7V0lV2w7hy5H6jRunzVLWE/sbTLW6zw1C7DU/9bQxTwqh34zgW3vQZHaZ1TJ4l9pq+8IT2zKq4stO3/5NcMb/XMBRwmVoBbj1gYjiKX15++aGmVtv8I3st9cqYR0brDggJ8OzBNotj6bT8M6ElJZuA35b274DRx9XMYV/SlhWQotO1dkb3E3ztwkwuY9SVmzftmdiVN+gFSkNiCYvSLPK4+NJ2H2UEqL/tQWAhZ1iVgyWvkHg7/APWfh5VG4Y22tAdxVkHNgBOK/zTzJwL0v+fvMPILP1KrNuKg8TKBgji9StgXzgw==
X-YMail-OSG: _yrIOfAVM1mD1FK7HpNcn9i8kyiDfjqvXP8Ayrcms62elE._jNh3r3bytJdMdK3
	pgX6OViHWvJJsNjxgaJZ8X64dhS3tcwluqtXT3qQfAkr.vFbTQkMoHEGwvjkusSF2K1iz7NCSccx
	XdG5CP1gcDCzEB6Amn1gh9Ej0j5VZ3S3XySNout8I4dJx6B3PaBBW82w38PcPPikJ6pwwPFfNK1c
	XM3JSGwiqMfziewjw1Y7gUN1cU_RtBPNQZb3g5lZVDSj0XWtUTdY5mwc8lIdpK1XrI3KM6cX.FAn
	P3EpPbBFVeM9XG1T0fVao7bOgN3syMMnaAnF4GLZ4rECvBNoyz7RaP3ygnFxDSlGD3W59TMii_rE
	p3D32oZQEL2CUH87dHw7AAW_bDOHy2ICYm53648myvxE7elqAs4Ec9WNELqW.OBhaqO_MMH6pUB7
	rsfGd_F7y8jmf6T2IRIvEYVafhofL8vthjTlEYw8A4D9I8Pyf860cp__PCWog0Sd2H7_JYMUWEk3
	UQWsnx9hsVmi.URIb9tW84sdYXbKB7B7B51iMavXnHziUglNWvBXM5stnWRtEXDY.ycQqL433DYA
	r78jkz2imFceyeL74WdavIm.Q54cddA9kz4ir9E9Gxr4GieiGttaWluvjeTBtMht8GmVNYr4wXqL
	mx70rIs3o1xJNfuQ2dkqrRDBWkNXqZZGZ6rOsQrXbQs4WPyjU4ZNZy3m7LRDTzSURQiM.s83W.ec
	0MTg0Mkb_aUHLgPyObFn3_kq_8KwIuAMTWNvg7b1_BNEoq8magXSLQSysu_uvJr8glY_uZNOGdFb
	XVIFgw34esBAFdXQ3QAH4dLiGXX7t7Yx3UFkDrMpgJ.qCgju_WHAfCYywCINtngChxH6ttmNWFhU
	MbpfdUCQaf1QAOlFnVydXEElLL_CzT_r6Ka0LJMSVDumb87pD2Gn1lw17diwVi5bcgEt4z6E5v8l
	jfq.AJ7skCOKJjIP1eSeXNvjQPuIkvUrIfrxFKFBPHxPmH360AtHBSRENo3A0c2byBVuArFqZI3t
	T1qoUK7AaEYN9TzGscj4qXmci.3AwDVow.oxp5H_hdaeUpx7d.a9JqtCh2fN6
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic305.consmr.mail.sg3.yahoo.com with HTTP;
	Mon, 26 Nov 2018 12:24:23 +0000
Date: Mon, 26 Nov 2018 12:24:20 +0000 (UTC)
From: Ugesh Reddy <kumar.ugesh003@yahoo.com>
Reply-To: "kumar.ugesh003@yahoo.com" <kumar.ugesh003@yahoo.com>
To: "awais_belal@mentor.com" <awais_belal@mentor.com>, 
	Bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <1262311103.6017978.1543235060710@mail.yahoo.com>
In-Reply-To: <5a9fde61-7134-2abf-4eae-18bb9ba4b8cb@mentor.com>
References: <119490492.5831423.1543217793985.ref@mail.yahoo.com>
	<119490492.5831423.1543217793985@mail.yahoo.com>
	<5a9fde61-7134-2abf-4eae-18bb9ba4b8cb@mentor.com>
MIME-Version: 1.0
X-Mailer: WebService/1.1.12729 YahooMailAndroidMobile YMobile/1.0
	(com.yahoo.mobile.client.android.mail/5.34.0; Android/8.1.0;
	OPM1.171019.011; beryllium; Xiaomi; POCO F1; 5.71; 2116x1080; )
Cc: "Ugesh Munirajulu \(RBEI\\/ECG-EP3\)" <ugesh.munirajulu@in.bosch.com>
Subject: Re: Copying the files to sysroot
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
X-List-Received-Date: Mon, 26 Nov 2018 12:24:24 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_6017977_254941919.1543235060706"

------=_Part_6017977_254941919.1543235060706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hello Awals,

If, I am correct the ${D} points to ${WORKDIR}/image

Where is the ${includedir} points too? by default it is /usr/ by GNU itsel=
f. is it somewhere redefined?

Please find the my .bb file

DESCRIPTION =3D "First Application"

SECTION =3D "MyLayer"

LICENSE =3D "MIT"

LIC_FILES_CHKSUM =3D "file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0b=
cf8506ecda2f7b4f302"

#LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3Dc00933139e794019cd555c2848de3d=
19"

PR =3D "r0"

SRC_URI =3D "file://component-0.1.tar.gz"

S =3D "${WORKDIR}/recipes-component-0.1/"

do_install_append() {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ ! -e $(include=
dir)/componentincludes ]; then

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -d ${D}${includedir}/co=
mponentincludes;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -m 644 ${S}=
/inc/*.h ${D}${includedir}/componentincludes

}

inherit autotools pkgconfig

inherit gettext

=C2=A0

local.conf:

=C2=A0

ACHINE ??=3D 'imx8mqevk'

DISTRO ?=3D 'fsl-imx-wayland'

PACKAGE_CLASSES ?=3D "package_rpm"

EXTRA_IMAGE_FEATURES ?=3D "debug-tweaks"

USER_CLASSES ?=3D "buildstats image-mklibs image-prelink"

PATCHRESOLVE =3D "noop"

BB_DISKMON_DIRS ??=3D "\

=C2=A0=C2=A0=C2=A0 STOPTASKS,${TMPDIR},1G,100K \

=C2=A0=C2=A0=C2=A0 STOPTASKS,${DL_DIR},1G,100K \

=C2=A0=C2=A0=C2=A0 STOPTASKS,${SSTATE_DIR},1G,100K \

=C2=A0=C2=A0=C2=A0 STOPTASKS,/tmp,100M,100K \

=C2=A0=C2=A0=C2=A0 ABORT,${TMPDIR},100M,1K \

=C2=A0=C2=A0=C2=A0 ABORT,${DL_DIR},100M,1K \

=C2=A0=C2=A0=C2=A0 ABORT,${SSTATE_DIR},100M,1K \

=C2=A0=C2=A0=C2=A0 ABORT,/tmp,10M,1K"

PACKAGECONFIG_append_pn-qemu-native =3D " sdl"

PACKAGECONFIG_append_pn-nativesdk-qemu =3D " sdl"

CONF_VERSION =3D "1"

=C2=A0

DL_DIR ?=3D "${BSPDIR}/downloads/"

ACCEPT_FSL_EULA =3D "1"

=C2=A0

With the above configuration the files are not copied to sysroot/usr/inclu=
de/componentincludes
  On Mon, 26 Nov 2018 at 5:22 PM, Awais Belal<awais_belal@mentor.com> wrot=
e:    
Hi Ugesh,
=20
>> 1. I want to copy the header includes to sysroot/usr/include/component
=20
Simply install the header files to ${D}${includedir}/component at the end =
of your 1st recipe's do_install.
=20
e.g.
=20
mkdir -p ${D}${includedir}/component
=20
install -m 0644 <HEADER_LOCATION>/<header>.h ${D}${includedir}/component/
=20
>> 2. Another recipe shall be able to refer the header from sysroot/usr/in=
clude/component
=20
Add your 1st recipe's package name in the DEPENDS of the recipe where you =
want to utilize these headers.
=20
 BR,
Awais On 26/11/18 12:36, Ugesh Reddy via bitbake-devel wrote:
  
=20
Hello All,=20
  =20
I have the yocto bsp for iMx8 eval board and compiled it successfully. I h=
ave introduced the new custom layer and written .bb file for my recipe and =
the component is compiled successfully and want to install the my include i=
n sysroot/usr/include/component at the end. I don't have the clue how to do=
 that . Could you please  some one guide me.
=20
=C2=A0
=20
I want the below to be achieved from .bb files.
=20
1. I want to copy the header includes to sysroot/usr/include/component
=20
2. Another recipe shall be able to refer the header from sysroot/usr/inclu=
de/component
=20

=20
=20
Regards,
=20
Ugesh
  
  
=20
  =20

------=_Part_6017977_254941919.1543235060706
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word; fon=
t-family: sans-serif;"><span style=3D"overflow-wrap: break-word;" id=3D"yMa=
il_cursorElementTracker_1543235019534">Hello Awals,</span></p><p class=3D"y=
iv0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: san=
s-serif;"><span style=3D"overflow-wrap: break-word;" id=3D"yMail_cursorElem=
entTracker_1543235026039">If, I am correct the ${D} points to ${WORKDIR}/im=
age</span></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: b=
reak-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-wo=
rd;" id=3D"yMail_cursorElementTracker_1543235031750">Where is the ${include=
dir} points too? by default it is /usr/ by GNU itself. is it somewhere rede=
fined?</span></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap=
: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break=
-word;" id=3D"yMail_cursorElementTracker_1543235033076">Please find the my =
.bb file</span></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wr=
ap: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: bre=
ak-word;">DESCRIPTION =3D "First Application"</span></p><p class=3D"yiv0972=
285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-seri=
f;"><span style=3D"overflow-wrap: break-word;">SECTION =3D "MyLayer"</span>=
</p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word;=
 font-family: sans-serif;"><span style=3D"overflow-wrap: break-word;">LICEN=
SE =3D "MIT"</span></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflo=
w-wrap: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap:=
 break-word;">LIC_FILES_CHKSUM =3D "file://${COMMON_LICENSE_DIR}/MIT;md5=3D=
0835ade698e0bcf8506ecda2f7b4f302"</span></p><p class=3D"yiv0972285134MsoNor=
mal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span st=
yle=3D"overflow-wrap: break-word;">#LIC_FILES_CHKSUM =3D "file://LICENSE;md=
5=3Dc00933139e794019cd555c2848de3d19"</span></p><p class=3D"yiv0972285134Ms=
oNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><spa=
n style=3D"overflow-wrap: break-word;">PR =3D "r0"</span></p><p class=3D"yi=
v0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans=
-serif;"><span style=3D"overflow-wrap: break-word;" id=3D"yMail_cursorEleme=
ntTracker_1543235040467">SRC_URI =3D "file://component-0.1.tar.gz"</span></=
p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word; f=
ont-family: sans-serif;"><span style=3D"overflow-wrap: break-word;" id=3D"y=
Mail_cursorElementTracker_1543235043272">S =3D "${WORKDIR}/recipes-componen=
t-0.1/"</span></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wra=
p: break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: brea=
k-word;">do_install_append() {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</s=
pan></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-w=
ord; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word;">&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ ! -e $(includedi=
r)/componentincludes ]; then</span></p><p class=3D"yiv0972285134MsoNormal" =
style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=
=3D"overflow-wrap: break-word;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
stall -d ${D}${includedir}/componentincludes;</span></p><p class=3D"yiv0972=
285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-seri=
f;"><span style=3D"overflow-wrap: break-word;">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; fi</span></p><p class=3D"yiv0972285134MsoNormal"=
 style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span style=
=3D"overflow-wrap: break-word;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; install -m 644 ${S}/inc/*.h ${D}${includedir}/componentinclude=
s</span></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: bre=
ak-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-word=
;">}</span></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: =
break-word; font-family: sans-serif;"><span style=3D"overflow-wrap: break-w=
ord;">inherit autotools pkgconfig</span></p><p class=3D"yiv0972285134MsoNor=
mal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><span st=
yle=3D"overflow-wrap: break-word;">inherit gettext</span></p><p class=3D"yi=
v0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans=
-serif;"><span style=3D"overflow-wrap: break-word;">&nbsp;</span></p><p cla=
ss=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-fami=
ly: sans-serif;"><u style=3D"overflow-wrap: break-word;"><span style=3D"ove=
rflow-wrap: break-word;">local.conf:</span></u></p><p class=3D"yiv097228513=
4MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><=
u style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap: break-=
word;">&nbsp;</span></u></p><p class=3D"yiv0972285134MsoNormal" style=3D"ov=
erflow-wrap: break-word; font-family: sans-serif;"><u style=3D"overflow-wra=
p: break-word;"><span style=3D"overflow-wrap: break-word;">ACHINE ??=3D 'im=
x8mqevk'</span></u></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflo=
w-wrap: break-word; font-family: sans-serif;"><u style=3D"overflow-wrap: br=
eak-word;"><span style=3D"overflow-wrap: break-word;">DISTRO ?=3D 'fsl-imx-=
wayland'</span></u></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflo=
w-wrap: break-word; font-family: sans-serif;"><u style=3D"overflow-wrap: br=
eak-word;"><span style=3D"overflow-wrap: break-word;">PACKAGE_CLASSES ?=3D =
"package_rpm"</span></u></p><p class=3D"yiv0972285134MsoNormal" style=3D"ov=
erflow-wrap: break-word; font-family: sans-serif;"><u style=3D"overflow-wra=
p: break-word;"><span style=3D"overflow-wrap: break-word;">EXTRA_IMAGE_FEAT=
URES ?=3D "debug-tweaks"</span></u></p><p class=3D"yiv0972285134MsoNormal" =
style=3D"overflow-wrap: break-word; font-family: sans-serif;"><u style=3D"o=
verflow-wrap: break-word;"><span style=3D"overflow-wrap: break-word;">USER_=
CLASSES ?=3D "buildstats image-mklibs image-prelink"</span></u></p><p class=
=
=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-famil=
y: sans-serif;"><u style=3D"overflow-wrap: break-word;"><span style=3D"over=
flow-wrap: break-word;">PATCHRESOLVE =3D "noop"</span></u></p><p class=3D"y=
iv0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: san=
s-serif;"><u style=3D"overflow-wrap: break-word;"><span style=3D"overflow-w=
rap: break-word;">BB_DISKMON_DIRS ??=3D "\</span></u></p><p class=3D"yiv097=
2285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-ser=
if;"><u style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap: =
break-word;">&nbsp;&nbsp;&nbsp; STOPTASKS,${TMPDIR},1G,100K \</span></u></p=
><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word; fo=
nt-family: sans-serif;"><u style=3D"overflow-wrap: break-word;"><span style=
=
=3D"overflow-wrap: break-word;">&nbsp;&nbsp;&nbsp; STOPTASKS,${DL_DIR},1G,=
100K \</span></u></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-=
wrap: break-word; font-family: sans-serif;"><u style=3D"overflow-wrap: brea=
k-word;"><span style=3D"overflow-wrap: break-word;">&nbsp;&nbsp;&nbsp; STOP=
TASKS,${SSTATE_DIR},1G,100K \</span></u></p><p class=3D"yiv0972285134MsoNor=
mal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><u style=
=
=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap: break-word;"=
>&nbsp;&nbsp;&nbsp; STOPTASKS,/tmp,100M,100K \</span></u></p><p class=3D"yi=
v0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans=
-serif;"><u style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wr=
ap: break-word;">&nbsp;&nbsp;&nbsp; ABORT,${TMPDIR},100M,1K \</span></u></p=
><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word; fo=
nt-family: sans-serif;"><u style=3D"overflow-wrap: break-word;"><span style=
=
=3D"overflow-wrap: break-word;">&nbsp;&nbsp;&nbsp; ABORT,${DL_DIR},100M,1K=
 \</span></u></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap=
: break-word; font-family: sans-serif;"><u style=3D"overflow-wrap: break-wo=
rd;"><span style=3D"overflow-wrap: break-word;">&nbsp;&nbsp;&nbsp; ABORT,${=
SSTATE_DIR},100M,1K \</span></u></p><p class=3D"yiv0972285134MsoNormal" sty=
le=3D"overflow-wrap: break-word; font-family: sans-serif;"><u style=3D"over=
flow-wrap: break-word;"><span style=3D"overflow-wrap: break-word;">&nbsp;&n=
bsp;&nbsp; ABORT,/tmp,10M,1K"</span></u></p><p class=3D"yiv0972285134MsoNor=
mal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><u style=
=
=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap: break-word;"=
>PACKAGECONFIG_append_pn-qemu-native =3D " sdl"</span></u></p><p class=3D"y=
iv0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: san=
s-serif;"><u style=3D"overflow-wrap: break-word;"><span style=3D"overflow-w=
rap: break-word;">PACKAGECONFIG_append_pn-nativesdk-qemu =3D " sdl"</span><=
/u></p><p class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-wo=
rd; font-family: sans-serif;"><u style=3D"overflow-wrap: break-word;"><span=
 style=3D"overflow-wrap: break-word;">CONF_VERSION =3D "1"</span></u></p><p=
 class=3D"yiv0972285134MsoNormal" style=3D"overflow-wrap: break-word; font-=
family: sans-serif;"><u style=3D"overflow-wrap: break-word;"><span style=3D=
"overflow-wrap: break-word;">&nbsp;</span></u></p><p class=3D"yiv0972285134=
MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><u=
 style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap: break-w=
ord;">DL_DIR ?=3D "${BSPDIR}/downloads/"</span></u></p><p class=3D"yiv09722=
85134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif=
;"><u style=3D"overflow-wrap: break-word;"><span style=3D"overflow-wrap: br=
eak-word;">ACCEPT_FSL_EULA =3D "1"</span></u></p><p class=3D"yiv0972285134M=
soNormal" style=3D"overflow-wrap: break-word; font-family: sans-serif;"><sp=
an style=3D"overflow-wrap: break-word;">&nbsp;</span></p><p class=3D"yiv097=
2285134MsoNormal" style=3D"overflow-wrap: break-word; font-family: sans-ser=
if;"><span style=3D"overflow-wrap: break-word;" id=3D"yMail_cursorElementTr=
acker_1543235014053">With the above configuration the files are not copied =
to sysroot/usr/include/componentincludes</span></p><br><div id=3D"ymail_and=
roid_signature"><a href=3D"https://go.onelink.me/107872968?pid=3DInProduct&=
amp;c=3DGlobal_Internal_YGrowth_AndroidEmailSig__AndroidUsers&amp;af_wl=3Dy=
m&amp;af_sub1=3DInternal&amp;af_sub2=3DGlobal_YGrowth&amp;af_sub3=3DEmailSi=
gnature"></a></div> <br> <blockquote style=3D"margin: 0 0 20px 0;"> <div st=
yle=3D"font-family:Roboto, sans-serif; color:#6D00F6;"> <div>On Mon, 26 Nov=
 2018 at 5:22 PM, Awais Belal</div><div>&lt;awais_belal@mentor.com&gt; wrot=
e:</div> </div> <div style=3D"padding: 10px 0 0 20px; margin: 10px 0 0 0; b=
order-left: 1px solid #6D00F6;"> <div id=3D"yiv9593560162"><div>
    <p><font face=3D"Tahoma">Hi Ugesh,</font></p>
    <p><font face=3D"Tahoma">&gt;&gt; 1. I want to copy the header
        includes to sysroot/usr/include/component</font></p>
    <p><font face=3D"Tahoma">Simply install the header files to
        ${D}${includedir}/component at the end of your 1st recipe's
        do_install.</font></p>
    <p><font face=3D"Tahoma">e.g.</font></p>
    <p><font face=3D"Tahoma">mkdir </font>-p ${D}${includedir}/component</=
p>
    <p>install -m 0644 &lt;HEADER_LOCATION&gt;/&lt;header&gt;.h
      ${D}${includedir}/component/</p>
    <p>&gt;&gt; 2. Another recipe shall be able to refer the header from
      sysroot/usr/include/component</p>
    <p>Add your 1st recipe's package name in the DEPENDS of the recipe
      where you want to utilize these headers.<br clear=3D"none">
    </p>
    <pre class=3D"yiv9593560162moz-signature">BR,
Awais</pre>
    <div class=3D"yiv9593560162yqt1266819837 yQTDBase" id=3D"yiv9593560162=
yqt19501"><div class=3D"yiv9593560162moz-cite-prefix">On 26/11/18 12:36, Ug=
esh Reddy via
      bitbake-devel wrote:<br clear=3D"none">
    </div>
    <blockquote type=3D"cite">
      </blockquote></div></div><div class=3D"yiv9593560162yqt1266819837 yQ=
TDBase" id=3D"yiv9593560162yqt45961"><div><div id=3D"yiv9593560162ymail_and=
roid_signature">Hello All,</div>
      <div id=3D"yiv9593560162yMail_cursorElementTracker_1543217671697"><b=
r clear=3D"none">
      </div>
      <div id=3D"yiv9593560162yMail_cursorElementTracker_1543217672288">
        <p id=3D"yiv9593560162yMail_cursorElementTracker_1543217680825" st=
yle=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-family:arial, =
helvetica,;">I have the yocto
          bsp for iMx8 eval board and compiled it successfully. I have
          introduced the new custom layer and written .bb file for my
          recipe and the component is compiled successfully and want to
          install the my include in sysroot/usr/include/component at the
          end. I don't have the clue how to do that . Could you please
          some one guide me.</p>
        <p style=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-=
family:arial, helvetica,;">&nbsp;</p>
        <p style=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-=
family:arial, helvetica,;">I want the below to be
          achieved from .bb files.</p>
        <p style=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-=
family:arial, helvetica,;">1. I want to copy the
          header includes to sysroot/usr/include/component</p>
        <p id=3D"yiv9593560162yMail_cursorElementTracker_1543217678730" st=
yle=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-family:arial, =
helvetica,;">2. Another
          recipe shall be able to refer the header from
          sysroot/usr/include/component</p>
        <p id=3D"yiv9593560162yMail_cursorElementTracker_1543217689960" st=
yle=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-family:arial, =
helvetica,;"><br clear=3D"none">
        </p>
        <p id=3D"yiv9593560162yMail_cursorElementTracker_1543217690540" st=
yle=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-family:arial, =
helvetica,;">Regards,</p>
        <p id=3D"yiv9593560162yMail_cursorElementTracker_1543217696559" st=
yle=3D"margin:0px;padding:0px;border:0px;font-size:15px;font-family:arial, =
helvetica,;">Ugesh</p>
      </div>
      <br clear=3D"none">
      <fieldset class=3D"yiv9593560162mimeAttachmentHeader"></fieldset>
      <br clear=3D"none">
    
    <br clear=3D"none">
  </div></div></div> </div> </blockquote>

------=_Part_6017977_254941919.1543235060706--
