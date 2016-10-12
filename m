Return-Path: <nitishjha16@gmail.com>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
	[209.85.220.182])
	by mail.openembedded.org (Postfix) with ESMTP id B627D6E64A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Oct 2016 11:40:22 +0000 (UTC)
Received: by mail-qk0-f182.google.com with SMTP id z190so25789035qkc.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Oct 2016 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=ijlhFM+prF/XO902jEv39CW33Jqj2j+2/KuAERL2VrY=;
	b=S/G9ksD+6DcKQzxV9UfxeQ//DjYcv9juQm+hnpy48twTB+m5FaoxCPuoIbnaxz+i29
	Gy0cu1RQWW69VMsypkVbXWlz1DsOoab1uOZXKpZINoUJyBn4qp+jvFZ4kJ1NY6SP/Xny
	gfoNel3sPVzXFZWU50aRq47FJtR3qZ2GxZg3taaB9+qjAaUia3q4TvEJWqEv43ozR6G/
	JHpntKR6lUTrszR4kIvdj3Okfs/E+0X6RAlfD831wg4tYeffMrUf5bM5HzPisesqvNTC
	g+e3XaJGtQ2z61zsDL7vc7QviaXd2pJsT7PJ4rSleN5DoQDHP5RXbLfHSpVSCN2Ej3zN
	WagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=ijlhFM+prF/XO902jEv39CW33Jqj2j+2/KuAERL2VrY=;
	b=hC/wJ5wTymiQNeNQwxAcUK9Z6t5aAF3KuTIeMcFPjNCZh5IZTv+oXyxNM+ou1kJpCW
	QCQBIVn+Ahkh0zoGzIjuKwfCVlxLbAYTvLJR2/q2ikUc9s7vcSb/+7goSBrYQWa8PayN
	nJFTKrlzHDt3hGCir5150t3Y02jfVgdA41n1kN5ABsVlpNqfXeY/vBumBkxaMEuwYx7E
	krTpa72gISmjgNh1FVV3xSNRGiZWKr0psSviSb2UYsmdHDrJptAFYVaalk2c4lezoXd+
	Yd6xBM+IeOTjXT5h0oNbNvibTtiBxxg+VRmkxXwMCBNps0RnXib8MzkdQcTEAu6RfkEa
	hptQ==
X-Gm-Message-State: AA6/9RmSJLyOCieEcBJO/dN/b5lvVwRw727JWkJ6b4tp4XG111ihr6CBGkiYbqu1yHva8I5NHhgOBFDPOg1pJA==
X-Received: by 10.194.65.5 with SMTP id t5mr848732wjs.100.1476272006511; Wed,
	12 Oct 2016 04:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.131.200 with HTTP; Wed, 12 Oct 2016 04:33:26 -0700 (PDT)
From: nitish jha <nitishjha16@gmail.com>
Date: Wed, 12 Oct 2016 13:33:26 +0200
Message-ID: <CABh+foZtU_KQ0+2WUC0J=oef-EcbKHH60Fc+yDqGtW79Jc7tBQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: changing content of configuration parameters of Cmakelist file from .bb file
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
X-List-Received-Date: Wed, 12 Oct 2016 11:40:23 -0000
Content-Type: multipart/alternative; boundary=047d7bfced328a4626053ea95c39

--047d7bfced328a4626053ea95c39
Content-Type: text/plain; charset=UTF-8

Hello All,

I want to change few configuration Parameters of default vsomeip
CMakelist.txt file from .bb file at runtime so that I can install vsome ip
using cmake from usr/lib to usr/lib64.

Contents of my .bb file:

DESCRIPTION = "A C++ SOME/IP implementation"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

#DEPENDS = "boost dlt-daemon"
DEPENDS = "boost"

SRC_URI = "\
    git://git.projects.genivi.org/vSomeIP.git;protocol=http;nobranch=1 \
    "

SRCREV = "2b7442a4c2452f8f3bd9e0f09f829478256d39af"
#SRC_URI += "file://0001-modified-cmakelists.patch"

S = "${WORKDIR}/git"

inherit cmake

do_configure_append() {
    cmake -INSTALL_LIB_DIR=/usr/lib64
}

PACKAGES += "${PN}-examples ${PN}-config"

FILES_${PN} = "${libdir}"
FILES_${PN}-examples = "${bindir}"
FILES_${PN}-dev += "${libdir}/cmake/vsomeip/*"
FILES_${PN}-config += "/usr/etc/vsomeip/*.json"

but at runtime this file gives error

Thanks and Regards

-- 
*Nitish Jha*

--047d7bfced328a4626053ea95c39
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello All,<br><br></div>I want to change fe=
w configuration Parameters of default vsomeip CMakelist.txt file from .bb f=
ile at runtime so that I can install vsome ip using cmake from usr/lib to u=
sr/lib64.<br><br></div>Contents of my .bb file:<br><br>DESCRIPTION =3D &quo=
t;A C++ SOME/IP implementation&quot;
<br>LICENSE =3D &quot;MPL-2.0&quot;
<br>LIC_FILES_CHKSUM =3D &quot;file://LICENSE;md5=3D815ca599c9df247a0c7f619=
bab123dad&quot;
<br>=C2=A0<br>#DEPENDS =3D &quot;boost dlt-daemon&quot;
<br>DEPENDS =3D &quot;boost&quot;
<br>=C2=A0<br>SRC_URI =3D &quot;\
<br>=C2=A0=C2=A0=C2=A0 git://<a href=3D"http://git.projects.genivi.org/vSom=
eIP.git;protocol=3Dhttp;nobranch=3D1">git.projects.genivi.org/vSomeIP.git;p=
rotocol=3Dhttp;nobranch=3D1</a> \
<br>=C2=A0=C2=A0=C2=A0 &quot;
<br>=C2=A0<br>SRCREV =3D &quot;2b7442a4c2452f8f3bd9e0f09f829478256d39af&quo=
t;
<br>#SRC_URI +=3D &quot;file://0001-modified-cmakelists.patch&quot;
<br>=C2=A0<br>S =3D &quot;${WORKDIR}/git&quot;
<br>=C2=A0<br>inherit cmake
<br>=C2=A0<br>do_configure_append() {
<br>=C2=A0=C2=A0=C2=A0 cmake -INSTALL_LIB_DIR=3D/usr/lib64
<br>}
<br>=C2=A0<br>PACKAGES +=3D &quot;${PN}-examples ${PN}-config&quot;
<br>=C2=A0<br>FILES_${PN} =3D &quot;${libdir}&quot;
<br>FILES_${PN}-examples =3D &quot;${bindir}&quot;
<br>FILES_${PN}-dev +=3D &quot;${libdir}/cmake/vsomeip/*&quot;
<br>FILES_${PN}-config +=3D &quot;/usr/etc/vsomeip/*.json&quot;
<br><br></div><div>but at runtime this file gives error<br><br></div>Thanks=
 and Regards<br clear=3D"all"><div><div><div><div><div><br>-- <br><div clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><div style=3D"font-family:arial;font-size:small"><div><=
b>Nitish Jha</b></div><div><b><br></b></div></div></div></div></div></div><=
/div></div>
</div></div></div></div></div></div>

--047d7bfced328a4626053ea95c39--
