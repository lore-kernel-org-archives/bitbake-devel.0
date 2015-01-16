Return-Path: <lover0107@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id E25C672332
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 12:08:08 +0000 (UTC)
Received: by mail-pa0-f43.google.com with SMTP id kx10so24002011pab.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 04:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=KrMW8b+3tAZID3LE8QiVC5hPOSrzf3GywYKuIBFVDy0=;
	b=O70xNh4TzjeT/z7KLW9KOFsAXWSd7XnN+PP7uLcwTj+y73JremlDRcqo3XGN/Wwe9G
	TNcRQGDrqJGvU3L2fuZqCF5vV+yGaRO/T1b0XTqX1unocPBLYLwnB+M4b87rQM4f3NLf
	zVF+eDm6t8Lniyknbc89dRdjE7ACPKS9moA81/OTQshfsY737D2nqDaxdSavn9lW6K7T
	Hz4MGJ1s2326hQjVOhSVERhTeZbqeqxxbmOaC9MwDp61Ppae3jaVDVX2CJUVkgNe6htY
	uJ5mMXQzaMv7/tOZLo+8HvUkd3XlXvUbJh5znAHqCeODtEwDOaVOsiwatXCprVPvRN/K
	5tZA==
MIME-Version: 1.0
X-Received: by 10.70.135.165 with SMTP id pt5mr21620470pdb.37.1421410088559;
	Fri, 16 Jan 2015 04:08:08 -0800 (PST)
Received: by 10.70.136.163 with HTTP; Fri, 16 Jan 2015 04:08:08 -0800 (PST)
In-Reply-To: <CAJWMM++SrMcy6=2E2y-9OsATGGvbQTyOteDhojDwrr1hC6dgAQ@mail.gmail.com>
References: <CAJWMM++Vqvsui6V5y_04zSWxr2MeKFo-Et5NEWY89FjYwkGvbg@mail.gmail.com>
	<CAP9ODKot2Kf5PLRcwQ5PniNDA__WNZ93zta5ot-WXfid-BEHJw@mail.gmail.com>
	<CAJWMM++SrMcy6=2E2y-9OsATGGvbQTyOteDhojDwrr1hC6dgAQ@mail.gmail.com>
Date: Fri, 16 Jan 2015 20:08:08 +0800
Message-ID: <CAJWMM++QiDANUpfv+p3qtVCJjr2DChVw7qA7RzvMS0ot9_Jmpw@mail.gmail.com>
From: =?UTF-8?B?5p6X56yo6YGU?= <lover0107@gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Thu, 29 Jan 2015 22:13:57 +0000
Subject: Re: meta qt5 dizzy configure issue
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
X-List-Received-Date: Fri, 16 Jan 2015 12:08:15 -0000
Content-Type: multipart/alternative; boundary=001a1133468a68ab3c050cc3d30d

--001a1133468a68ab3c050cc3d30d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi All,
I try to bitbake with meta-qt5 layer.



meta-qt5          =3D
"(detachedfrom5.2.1+origin/release):818cc2d11b02ceb02ac27401fedcaf1e1db91d3=
6"

bitbake bitbake fsl-image-multimedia-full

Some problem occur as below message.
Build Configuration:
BB_VERSION        =3D "1.24.0"
BUILD_SYS         =3D "x86_64-linux"
NATIVELSBSTRING   =3D "Ubuntu-12.04"
TARGET_SYS        =3D "arm-poky-linux-gnueabi"
MACHINE           =3D "imx6slevk"
DISTRO            =3D "poky"
DISTRO_VERSION    =3D "1.7.1"
TUNE_FEATURES     =3D "arm armv7a vfp neon callconvention-hard cortexa9"
TARGET_FPU        =3D "vfp-neon"
meta
meta-yocto        =3D "(nobranch):e13f2681b75fd83aa3a1c823ad1c09faed0d6ae3"
meta-oe
meta-multimedia   =3D "(nobranch):200f6cafc878d4c26871fc56d21ecc8eaa9aa61b"
meta-fsl-arm      =3D "(nobranch):b74e5e690d8d4e149ea9de3f0fcca37bad93935f"
meta-fsl-arm-extra =3D "(nobranch):b32528c10caac5e85f2b5efe0e5b95322dd68ace=
"
meta-fsl-demos    =3D "(nobranch):48cb0bcdd226d2e7eee1fdc222713e1dff93342c"
meta-qt5          =3D
"(detachedfrom5.2.1+origin/release):818cc2d11b02ceb02ac27401fedcaf1e1db91d3=
6"
meta-ruby
meta-multimedia   =3D "(nobranch):200f6cafc878d4c26871fc56d21ecc8eaa9aa61b"

NOTE: Preparing runqueue
NOTE: Executing SetScene Tasks
NOTE: Executing RunQueue Tasks
ERROR: Function failed: do_configure (log file is located at
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/temp/log.do_configure.22437)
ERROR: Logfile of failure stored in:
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/temp/log.do_configure.22437
Log data follows:
| DEBUG: Executing python function sysroot_cleansstate
| DEBUG: Python function sysroot_cleansstate finished
| DEBUG: Executing shell function qmake5_base_preconfigure
| DEBUG: Shell function qmake5_base_preconfigure finished
| DEBUG: Executing shell function do_configure
| NOTE: qmake prevar substitution: ' CONFIG+=3DOE_QTXMLPATTERNS_ENABLED'
| Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/
src.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/qml/
qml.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/qml]
| <srcbase> =3D
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1
| <outbase> =3D
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/build
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/plugins/
plugins.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/plugins]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/plugins/qmltooling/
qmltooling.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/plugins/qmltooling]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/plugins/qmltooling/qmldbg_tcp/
qmldbg_tcp.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/plugins/qmltooling/qmldbg=
_tcp]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/imports/
imports.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/imports/folderlistmodel/
folderlistmodel.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports/folderlistmodel]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/imports/localstorage/
localstorage.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports/localstorage]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/imports/models/
models.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports/models]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/imports/settings/
settings.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports/settings]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/imports/xmllistmodel/
xmllistmodel.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports/xmllistmodel]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/s=
rc/qmldevtools/
qmldevtools.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/qmldevtools]
| Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ools/
tools.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ools/qmlmin/
qmlmin.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools/qmlmin]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ools/qmlimportscanner/
qmlimportscanner.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools/qmlimportscanner]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ools/qml/
qml.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools/qml]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ools/qmlprofiler/
qmlprofiler.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools/qmlprofiler]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ools/qmlbundle/
qmlbundle.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools/qmlbundle]
| Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/
examples.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/
qml.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/qmlextensionplugins/
qmlextensionplugins.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/qmlextensionplug=
ins]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/
referenceexamples.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/adding/
adding.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/adding]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/attached/
attached.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/attached]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/binding/
binding.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/binding]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/coercion/
coercion.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/coercion]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/default/
default.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/default]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/grouped/
grouped.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/grouped]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/properties/
properties.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/properties]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/signal/
signal.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/signal]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/valuesource/
valuesource.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/valuesource]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/methods/
methods.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/methods]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/extended/
extended.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexample=
s/extended]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/shell/
shell.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/shell]
| Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/
tests.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests]
|  Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/
auto.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto]
|   Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/qml/
qml.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/qml/parserstress/
parserstress.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/parserstress]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/qml/qjsvalueiterator/
qjsvalueiterator.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/qjsvalueiterat=
or]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/qml/qjsonbinding/
qjsonbinding.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/qjsonbinding]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/qml/qmlmin/
qmlmin.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/qmlmin]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/qml/qmlplugindump/
qmlplugindump.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/qmlplugindump]
|    Reading
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/t=
ests/auto/qml/qqmlcomponent/
qqmlcomponent.pro
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/qqmlcomponent]
| Project ERROR: Unknown module(s) in QT: quick-private
| ERROR: Error calling
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/sysroots/x86_64-linux/usr/bi=
n/qt5/qmake
-makefile -o Makefile  -r  CONFIG+=3DOE_QTXMLPATTERNS_ENABLED
 /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/
qtdeclarative.pro
| WARNING: exit code 1 from a shell command.
| ERROR: Function failed: do_configure (log file is located at
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/temp/log.do_configure.22437)
ERROR: Task 752
(/mnt_IB1000/evanQT/fsl-community-bsp/sources/meta-qt5/recipes-qt/qt5/
qtdeclarative_5.2.1.bb, do_configure) failed with exit code '1'
NOTE: Tasks Summary: Attempted 1850 tasks of which 1846 didn't need to be
rerun and 1 failed.
Waiting for 0 running tasks to finish:



Does any one can figure out the problem for me ?

Regards,
Evan Lin



2015-01-16 19:47 GMT+08:00 =E6=9E=97=E7=AC=A8=E9=81=94 <lover0107@gmail.com=
>:

> Hi Otavio
> I am new to open source project.
> Could you guide me where I can find more people to send this mail to them=
?
>
> Sincerely Yours,
>
>
> 2015-01-16 19:45 GMT+08:00 Otavio Salvador <otavio@ossystems.com.br>:
>
>> On Fri, Jan 16, 2015 at 12:47 AM, =E6=9E=97=E7=AC=A8=E9=81=94 <lover0107=
@gmail.com> wrote:
>> > The attachment is the log file when I try to do configure QT5.2.3.r0 i=
n
>> > yocto.
>> > Could you help me figure out the problem ?
>>
>> Please send this to the mailing list so more people can reply to it,
>> and eventually benefit when someone answer it.
>>
>> Best Regards,
>>
>> --
>> Otavio Salvador                             O.S. Systems
>> http://www.ossystems.com.br        http://code.ossystems.com.br
>> Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
>>
>
>

--001a1133468a68ab3c050cc3d30d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<br>I try to bitbake with meta-qt5 layer.<div><br><=
/div><div><br><div><br><div>meta-qt5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
&quot;(detachedfrom5.2.1+origin/release):818cc2d11b02ceb02ac27401fedcaf1e1d=
b91d36&quot;</div><div><br></div><div>bitbake bitbake fsl-image-multimedia-=
full<br></div><div><br>Some problem occur as below message.<br><div>Build C=
onfiguration:</div><div>BB_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;1.2=
4.0&quot;</div><div>BUILD_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;x86_64-=
linux&quot;</div><div>NATIVELSBSTRING =C2=A0 =3D &quot;Ubuntu-12.04&quot;</=
div><div>TARGET_SYS =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;arm-poky-linux-gnu=
eabi&quot;</div><div>MACHINE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;i=
mx6slevk&quot;</div><div>DISTRO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &quot;poky&quot;</div><div>DISTRO_VERSION =C2=A0 =C2=A0=3D &quot;1.7.1&=
quot;</div><div>TUNE_FEATURES =C2=A0 =C2=A0 =3D &quot;arm armv7a vfp neon c=
allconvention-hard cortexa9&quot;</div><div>TARGET_FPU =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D &quot;vfp-neon&quot;</div><div>meta =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0</div><div>meta-yocto =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &q=
uot;(nobranch):e13f2681b75fd83aa3a1c823ad1c09faed0d6ae3&quot;</div><div>met=
a-oe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div>meta-multimedia =C2=
=A0 =3D &quot;(nobranch):200f6cafc878d4c26871fc56d21ecc8eaa9aa61b&quot;</di=
v><div>meta-fsl-arm =C2=A0 =C2=A0 =C2=A0=3D &quot;(nobranch):b74e5e690d8d4e=
149ea9de3f0fcca37bad93935f&quot;</div><div>meta-fsl-arm-extra =3D &quot;(no=
branch):b32528c10caac5e85f2b5efe0e5b95322dd68ace&quot;</div><div>meta-fsl-d=
emos =C2=A0 =C2=A0=3D &quot;(nobranch):48cb0bcdd226d2e7eee1fdc222713e1dff93=
342c&quot;</div><div>meta-qt5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;(=
detachedfrom5.2.1+origin/release):818cc2d11b02ceb02ac27401fedcaf1e1db91d36&=
quot;</div><div>meta-ruby =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div>meta-=
multimedia =C2=A0 =3D &quot;(nobranch):200f6cafc878d4c26871fc56d21ecc8eaa9a=
a61b&quot;</div><div><br></div><div>NOTE: Preparing runqueue</div><div>NOTE=
: Executing SetScene Tasks</div><div>NOTE: Executing RunQueue Tasks</div><d=
iv>ERROR: Function failed: do_configure (log file is located at /mnt_IB1000=
/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnu=
eabi/qtdeclarative/5.2.1-r0/temp/log.do_configure.22437)</div><div>ERROR: L=
ogfile of failure stored in: /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp=
/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/temp/lo=
g.do_configure.22437</div><div>Log data follows:</div><div>| DEBUG: Executi=
ng python function sysroot_cleansstate</div><div>| DEBUG: Python function s=
ysroot_cleansstate finished</div><div>| DEBUG: Executing shell function qma=
ke5_base_preconfigure</div><div>| DEBUG: Shell function qmake5_base_preconf=
igure finished</div><div>| DEBUG: Executing shell function do_configure</di=
v><div>| NOTE: qmake prevar substitution: &#39; CONFIG+=3DOE_QTXMLPATTERNS_=
ENABLED&#39;</div><div>| Reading /mnt_IB1000/evanQT/fsl-community-bsp/build=
/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtd=
eclarative-opensource-src-5.2.1/src/<a href=3D"http://src.pro">src.pro</a> =
[/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src]</div><div>| =C2=A0Readin=
g /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-p=
oky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1=
/src/qml/<a href=3D"http://qml.pro">qml.pro</a> [/mnt_IB1000/evanQT/fsl-com=
munity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarat=
ive/5.2.1-r0/build/src/qml]</div><div>| &lt;srcbase&gt; =3D /mnt_IB1000/eva=
nQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi=
/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1</div><div>| &lt;=
outbase&gt; =3D /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa=
9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build</div><div>| =
=C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9h=
f-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensour=
ce-src-5.2.1/src/plugins/<a href=3D"http://plugins.pro">plugins.pro</a> [/m=
nt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-=
linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/plugins]</div><div>| =C2=A0 =
Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src=
-5.2.1/src/plugins/qmltooling/<a href=3D"http://qmltooling.pro">qmltooling.=
pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp=
-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/plugins/qmltoolin=
g]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/bu=
ild/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/=
qtdeclarative-opensource-src-5.2.1/src/plugins/qmltooling/qmldbg_tcp/<a hre=
f=3D"http://qmldbg_tcp.pro">qmldbg_tcp.pro</a> [/mnt_IB1000/evanQT/fsl-comm=
unity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarati=
ve/5.2.1-r0/build/src/plugins/qmltooling/qmldbg_tcp]</div><div>| =C2=A0Read=
ing /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon=
-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2=
.1/src/imports/<a href=3D"http://imports.pro">imports.pro</a> [/mnt_IB1000/=
evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnue=
abi/qtdeclarative/5.2.1-r0/build/src/imports]</div><div>| =C2=A0 Reading /m=
nt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-=
linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/src=
/imports/folderlistmodel/<a href=3D"http://folderlistmodel.pro">folderlistm=
odel.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9h=
f-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports/fold=
erlistmodel]</div><div>| =C2=A0 Reading /mnt_IB1000/evanQT/fsl-community-bs=
p/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1=
-r0/qtdeclarative-opensource-src-5.2.1/src/imports/localstorage/<a href=3D"=
http://localstorage.pro">localstorage.pro</a> [/mnt_IB1000/evanQT/fsl-commu=
nity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarativ=
e/5.2.1-r0/build/src/imports/localstorage]</div><div>| =C2=A0 Reading /mnt_=
IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-lin=
ux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/src/im=
ports/models/<a href=3D"http://models.pro">models.pro</a> [/mnt_IB1000/evan=
QT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/=
qtdeclarative/5.2.1-r0/build/src/imports/models]</div><div>| =C2=A0 Reading=
 /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-po=
ky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/=
src/imports/settings/<a href=3D"http://settings.pro">settings.pro</a> [/mnt=
_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-li=
nux-gnueabi/qtdeclarative/5.2.1-r0/build/src/imports/settings]</div><div>| =
=C2=A0 Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9=
hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensou=
rce-src-5.2.1/src/imports/xmllistmodel/<a href=3D"http://xmllistmodel.pro">=
xmllistmodel.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/c=
ortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/src/impo=
rts/xmllistmodel]</div><div>| =C2=A0Reading /mnt_IB1000/evanQT/fsl-communit=
y-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5=
.2.1-r0/qtdeclarative-opensource-src-5.2.1/src/qmldevtools/<a href=3D"http:=
//qmldevtools.pro">qmldevtools.pro</a> [/mnt_IB1000/evanQT/fsl-community-bs=
p/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1=
-r0/build/src/qmldevtools]</div><div>| Reading /mnt_IB1000/evanQT/fsl-commu=
nity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarativ=
e/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/tools/<a href=3D"http://tools=
.pro">tools.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/co=
rtexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools]</d=
iv><div>| =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work=
/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarativ=
e-opensource-src-5.2.1/tools/qmlmin/<a href=3D"http://qmlmin.pro">qmlmin.pr=
o</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-n=
eon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools/qmlmin]</div><div=
>| =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortex=
a9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opens=
ource-src-5.2.1/tools/qmlimportscanner/<a href=3D"http://qmlimportscanner.p=
ro">qmlimportscanner.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tm=
p/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/=
tools/qmlimportscanner]</div><div>| =C2=A0Reading /mnt_IB1000/evanQT/fsl-co=
mmunity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclara=
tive/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/tools/qml/<a href=3D"http:=
//qml.pro">qml.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work=
/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tools/=
qml]</div><div>| =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/t=
mp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdec=
larative-opensource-src-5.2.1/tools/qmlprofiler/<a href=3D"http://qmlprofil=
er.pro">qmlprofiler.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp=
/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/t=
ools/qmlprofiler]</div><div>| =C2=A0Reading /mnt_IB1000/evanQT/fsl-communit=
y-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5=
.2.1-r0/qtdeclarative-opensource-src-5.2.1/tools/qmlbundle/<a href=3D"http:=
//qmlbundle.pro">qmlbundle.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/bu=
ild/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/=
build/tools/qmlbundle]</div><div>| Reading /mnt_IB1000/evanQT/fsl-community=
-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.=
2.1-r0/qtdeclarative-opensource-src-5.2.1/examples/<a href=3D"http://exampl=
es.pro">examples.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/wo=
rk/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/exam=
ples]</div><div>| =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/=
tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtde=
clarative-opensource-src-5.2.1/examples/qml/<a href=3D"http://qml.pro">qml.=
pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp=
-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml]</div><d=
iv>| =C2=A0 Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cor=
texa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-op=
ensource-src-5.2.1/examples/qml/qmlextensionplugins/<a href=3D"http://qmlex=
tensionplugins.pro">qmlextensionplugins.pro</a> [/mnt_IB1000/evanQT/fsl-com=
munity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarat=
ive/5.2.1-r0/build/examples/qml/qmlextensionplugins]</div><div>| =C2=A0 Rea=
ding /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neo=
n-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.=
2.1/examples/qml/referenceexamples/<a href=3D"http://referenceexamples.pro"=
>referenceexamples.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/=
work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/ex=
amples/qml/referenceexamples]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/=
evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnue=
abi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/examples/qml/=
referenceexamples/adding/<a href=3D"http://adding.pro">adding.pro</a> [/mnt=
_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-li=
nux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexamples/add=
ing]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/=
build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r=
0/qtdeclarative-opensource-src-5.2.1/examples/qml/referenceexamples/attache=
d/<a href=3D"http://attached.pro">attached.pro</a> [/mnt_IB1000/evanQT/fsl-=
community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdecla=
rative/5.2.1-r0/build/examples/qml/referenceexamples/attached]</div><div>| =
=C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/co=
rtexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-o=
pensource-src-5.2.1/examples/qml/referenceexamples/binding/<a href=3D"http:=
//binding.pro">binding.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/=
tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/buil=
d/examples/qml/referenceexamples/binding]</div><div>| =C2=A0 =C2=A0Reading =
/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-pok=
y-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/e=
xamples/qml/referenceexamples/coercion/<a href=3D"http://coercion.pro">coer=
cion.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9h=
f-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/ref=
erenceexamples/coercion]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQ=
T/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/q=
tdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/examples/qml/refer=
enceexamples/default/<a href=3D"http://default.pro">default.pro</a> [/mnt_I=
B1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linu=
x-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexamples/defau=
lt]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/b=
uild/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0=
/qtdeclarative-opensource-src-5.2.1/examples/qml/referenceexamples/grouped/=
<a href=3D"http://grouped.pro">grouped.pro</a> [/mnt_IB1000/evanQT/fsl-comm=
unity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarati=
ve/5.2.1-r0/build/examples/qml/referenceexamples/grouped]</div><div>| =C2=
=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/corte=
xa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-open=
source-src-5.2.1/examples/qml/referenceexamples/properties/<a href=3D"http:=
//properties.pro">properties.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/=
build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r=
0/build/examples/qml/referenceexamples/properties]</div><div>| =C2=A0 =C2=
=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-v=
fp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-=
src-5.2.1/examples/qml/referenceexamples/signal/<a href=3D"http://signal.pr=
o">signal.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cort=
exa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qm=
l/referenceexamples/signal]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/ev=
anQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueab=
i/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/examples/qml/re=
ferenceexamples/valuesource/<a href=3D"http://valuesource.pro">valuesource.=
pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp=
-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenc=
eexamples/valuesource]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/=
fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtd=
eclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/examples/qml/referen=
ceexamples/methods/<a href=3D"http://methods.pro">methods.pro</a> [/mnt_IB1=
000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-=
gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/referenceexamples/methods=
]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/bui=
ld/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/q=
tdeclarative-opensource-src-5.2.1/examples/qml/referenceexamples/extended/<=
a href=3D"http://extended.pro">extended.pro</a> [/mnt_IB1000/evanQT/fsl-com=
munity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarat=
ive/5.2.1-r0/build/examples/qml/referenceexamples/extended]</div><div>| =C2=
=A0 Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-=
vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource=
-src-5.2.1/examples/qml/shell/<a href=3D"http://shell.pro">shell.pro</a> [/=
mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky=
-linux-gnueabi/qtdeclarative/5.2.1-r0/build/examples/qml/shell]</div><div>|=
 Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp=
-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-sr=
c-5.2.1/tests/<a href=3D"http://tests.pro">tests.pro</a> [/mnt_IB1000/evanQ=
T/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/q=
tdeclarative/5.2.1-r0/build/tests]</div><div>| =C2=A0Reading /mnt_IB1000/ev=
anQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueab=
i/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/tests/auto/<a h=
ref=3D"http://auto.pro">auto.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/=
build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r=
0/build/tests/auto]</div><div>| =C2=A0 Reading /mnt_IB1000/evanQT/fsl-commu=
nity-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarativ=
e/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/tests/auto/qml/<a href=3D"htt=
p://qml.pro">qml.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/wo=
rk/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/test=
s/auto/qml]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-communi=
ty-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/=
5.2.1-r0/qtdeclarative-opensource-src-5.2.1/tests/auto/qml/parserstress/<a =
href=3D"http://parserstress.pro">parserstress.pro</a> [/mnt_IB1000/evanQT/f=
sl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtde=
clarative/5.2.1-r0/build/tests/auto/qml/parserstress]</div><div>| =C2=A0 =
=C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9h=
f-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensour=
ce-src-5.2.1/tests/auto/qml/qjsvalueiterator/<a href=3D"http://qjsvalueiter=
ator.pro">qjsvalueiterator.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/bu=
ild/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/=
build/tests/auto/qml/qjsvalueiterator]</div><div>| =C2=A0 =C2=A0Reading /mn=
t_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-l=
inux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/test=
s/auto/qml/qjsonbinding/<a href=3D"http://qjsonbinding.pro">qjsonbinding.pr=
o</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-n=
eon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/qjsonbin=
ding]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp=
/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-=
r0/qtdeclarative-opensource-src-5.2.1/tests/auto/qml/qmlmin/<a href=3D"http=
://qmlmin.pro">qmlmin.pro</a> [/mnt_IB1000/evanQT/fsl-community-bsp/build/t=
mp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/build=
/tests/auto/qml/qmlmin]</div><div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT=
/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qt=
declarative/5.2.1-r0/qtdeclarative-opensource-src-5.2.1/tests/auto/qml/qmlp=
lugindump/<a href=3D"http://qmlplugindump.pro">qmlplugindump.pro</a> [/mnt_=
IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-lin=
ux-gnueabi/qtdeclarative/5.2.1-r0/build/tests/auto/qml/qmlplugindump]</div>=
<div>| =C2=A0 =C2=A0Reading /mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/=
work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclar=
ative-opensource-src-5.2.1/tests/auto/qml/qqmlcomponent/<a href=3D"http://q=
qmlcomponent.pro">qqmlcomponent.pro</a> [/mnt_IB1000/evanQT/fsl-community-b=
sp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2.=
1-r0/build/tests/auto/qml/qqmlcomponent]</div><div>| Project ERROR: Unknown=
 module(s) in QT: quick-private</div><div>| ERROR: Error calling /mnt_IB100=
0/evanQT/fsl-community-bsp/build/tmp/sysroots/x86_64-linux/usr/bin/qt5/qmak=
e -makefile -o Makefile =C2=A0-r =C2=A0CONFIG+=3DOE_QTXMLPATTERNS_ENABLED =
=C2=A0/mnt_IB1000/evanQT/fsl-community-bsp/build/tmp/work/cortexa9hf-vfp-ne=
on-poky-linux-gnueabi/qtdeclarative/5.2.1-r0/qtdeclarative-opensource-src-5=
.2.1/<a href=3D"http://qtdeclarative.pro">qtdeclarative.pro</a></div><div>|=
 WARNING: exit code 1 from a shell command.</div><div>| ERROR: Function fai=
led: do_configure (log file is located at /mnt_IB1000/evanQT/fsl-community-=
bsp/build/tmp/work/cortexa9hf-vfp-neon-poky-linux-gnueabi/qtdeclarative/5.2=
.1-r0/temp/log.do_configure.22437)</div><div>ERROR: Task 752 (/mnt_IB1000/e=
vanQT/fsl-community-bsp/sources/meta-qt5/recipes-qt/qt5/<a href=3D"http://q=
tdeclarative_5.2.1.bb">qtdeclarative_5.2.1.bb</a>, do_configure) failed wit=
h exit code &#39;1&#39;</div><div>NOTE: Tasks Summary: Attempted 1850 tasks=
 of which 1846 didn&#39;t need to be rerun and 1 failed.</div><div>Waiting =
for 0 running tasks to finish:</div><div><br></div><br><div><br></div></div=
><div>Does any one can figure out the problem for me ?<br><br>Regards,</div=
><div>Evan Lin=C2=A0<br><br></div><div><br></div></div></div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-01-16 19:47 GMT+08:0=
0 =E6=9E=97=E7=AC=A8=E9=81=94 <span dir=3D"ltr">&lt;<a href=3D"mailto:lover=
0107@gmail.com" target=3D"_blank">lover0107@gmail.com</a>&gt;</span>:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Otavio=C2=A0<div>I am new =
to open source project.</div><div>Could you guide me where I can find more =
people to send this mail to them?<br><br></div><div>Sincerely Yours,<br><br=
></div></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">2015-01-16 19:45 GMT+08:00 Otavio Salva=
dor <span dir=3D"ltr">&lt;<a href=3D"mailto:otavio@ossystems.com.br" target=
=3D"_blank">otavio@ossystems.com.br</a>&gt;</span>:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span>On Fri, Jan 16, 2015 at 12:47 AM, =E6=9E=97=E7=AC=A8=E9=81=
=94 &lt;<a href=3D"mailto:lover0107@gmail.com" target=3D"_blank">lover0107@=
gmail.com</a>&gt; wrote:<br>
&gt; The attachment is the log file when I try to do configure QT5.2.3.r0 i=
n<br>
&gt; yocto.<br>
&gt; Could you help me figure out the problem ?<br>
<br>
</span>Please send this to the mailing list so more people can reply to it,=
<br>
and eventually benefit when someone answer it.<br>
<br>
Best Regards,<br>
<span><font color=3D"#888888"><br>
--<br>
Otavio Salvador=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0O.S. Systems<br>
<a href=3D"http://www.ossystems.com.br" target=3D"_blank">http://www.ossyst=
ems.com.br</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://code.ossystems.=
com.br" target=3D"_blank">http://code.ossystems.com.br</a><br>
Mobile: <a href=3D"tel:%2B55%20%2853%29%209981-7854" value=3D"+555399817854=
" target=3D"_blank">+55 (53) 9981-7854</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Mobile: <a href=3D"tel:%2B1%20%28347%29%20903-9750" value=3D"+13=
479039750" target=3D"_blank">+1 (347) 903-9750</a><br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a1133468a68ab3c050cc3d30d--
