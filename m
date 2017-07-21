Return-Path: <viditha@mpconsultants.org>
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com
	[209.85.217.178])
	by mail.openembedded.org (Postfix) with ESMTP id 85AFB77DC8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jul 2017 19:11:04 +0000 (UTC)
Received: by mail-ua0-f178.google.com with SMTP id w45so52417131uac.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jul 2017 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mpconsultants.org; s=google;
	h=mime-version:from:date:message-id:subject:to;
	bh=eWm+8ijkoNhRDB0XmN50+o9VPbzKLpqRSt66VmJGR3A=;
	b=fAtzC2lgZY1TYQjVg8qFFyQIE7Jm5Z0wxrBamxh7kohal5ARrxe27zWj+S8gmU4pOs
	l2aFkJNiaVJA4by/2jCknTXxfRzDXVA3weLxj2FKGxcdpQ+AkFH3Gg1Po6VmSzgTk75L
	VyHAHoUiPjAHVWZt+EYs1c1V8kFGwqpWexuSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=eWm+8ijkoNhRDB0XmN50+o9VPbzKLpqRSt66VmJGR3A=;
	b=XbdLtq5qLpHZFTyPmMa40lvq7slsHMrqM+6mGpWyR/E8rtJ9PW/GnIjCeB8N5ragYt
	l6sl04VH3wax6Uz+/fudjXsrSNv6tcLVaGue6YrRrBOiNatf47Zdd9erU4/Bmi6N2V+b
	5mUChRVZ61LpFaU5qOImiQgolsgPmKWzasy+FgvxpO+qUZE0BrXggjO1tLv7O3dIbzp8
	wc8LS/2wk6S//3gHup4mntr03AVaSTFerLMR/7UAEAnYs6KVzn+9Rez3U5pp1BElxKrG
	5bPzGHCJZkfODzsfJiXbtyIrvNI4+KcQ+2ovAmjC5AfhJSBwj2BAO/iodU1g2nTQkTnI
	2HEQ==
X-Gm-Message-State: AIVw111n1YMjfHCb1KJGMGNXVJmZeNSp7OdLXx+AXnWUE5imKDLSk5IX
	+uwRnvjXLYP5l1UuTcYeysHBe6qlPLFqmEc=
X-Received: by 10.31.207.132 with SMTP id f126mr3670774vkg.147.1500664265162; 
	Fri, 21 Jul 2017 12:11:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.78.159 with HTTP; Fri, 21 Jul 2017 12:11:04 -0700 (PDT)
From: Viditha Murahari <viditha@mpconsultants.org>
Date: Fri, 21 Jul 2017 14:11:04 -0500
Message-ID: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: need help to write a recipe to link a static library to my application
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
X-List-Received-Date: Fri, 21 Jul 2017 19:11:04 -0000
Content-Type: multipart/alternative; boundary="001a114e2fee73dc660554d8a0b8"

--001a114e2fee73dc660554d8a0b8
Content-Type: text/plain; charset="UTF-8"

I'm new to yocto and bitbake and I'm building a voip application for a
custom imx6 board. I want to use  pjsip libraries to build my application,
I have compiled pjsip in my yocto build and generated pjsip libraries ( all
pjsip libraries r static). I'm having issues building a recipe for my
application that calls the pjsip functions. Below is how my recipe looks


Filename: rttapp.bb

DESCRIPTION = "Simple voip application"
SECTION = "examples"
LICENSE = "MIT"
LIC_FILES_CHKSUM
="file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r1"

SRC_URI += "file://rttapp.c"
SRC_URI += "file://include"
SRC_URI += "file://lib"

S = "${WORKDIR}"

CFLAGS_prepend += "-I${WORKDIR}/include -DPJ_AUTOCONF=1
-DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1"
LDFLAGS_append += "-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-gnueabi
-lstdc++ -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound"

do_compile() {
${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp
}




When i do bitbake rttapp, the error i see is as below


Log data follows:
DEBUG: Executing shell function do_compile
/tmp/cc6nn4Dp.o: In function `main':
/usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined reference to
`pjsua_create'
collect2: error: ld returned 1 exit status
WARNING: exit code 1 from a shell command.


Please advise

--001a114e2fee73dc660554d8a0b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m new to yocto and bitbake and I&#39;m building=
 a voip application for a custom imx6 board. I want to use =C2=A0pjsip libr=
aries to build my application, I have compiled pjsip in my yocto build and =
generated pjsip libraries ( all pjsip libraries r static). I&#39;m having i=
ssues building a recipe for my application that calls the pjsip functions. =
Below is how my recipe looks=C2=A0</div><div><br></div><div><br></div><div>=
Filename: <a href=3D"http://rttapp.bb">rttapp.bb</a></div><div><br></div><d=
iv>DESCRIPTION =3D &quot;Simple voip application&quot;</div><div>SECTION =
=3D &quot;examples&quot;</div><div>LICENSE =3D &quot;MIT&quot;</div><div>LI=
C_FILES_CHKSUM =3D&quot;file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0=
bcf8506ecda2f7b4f302&quot;</div><div>PR =3D &quot;r1&quot;</div><div><br></=
div><div>SRC_URI +=3D &quot;file://rttapp.c&quot;</div><div>SRC_URI +=3D &q=
uot;file://include&quot;</div><div>SRC_URI +=3D &quot;file://lib&quot;</div=
><div><br></div><div>S =3D &quot;${WORKDIR}&quot;</div><div><br></div><div>=
CFLAGS_prepend +=3D &quot;-I${WORKDIR}/include -DPJ_AUTOCONF=3D1 -DPJ_IS_BI=
G_ENDIAN=3D0 -DPJ_IS_LITTLE_ENDIAN=3D1&quot;</div><div>LDFLAGS_append +=3D =
&quot;-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-gnueabi -lstdc++ -lpjsua-arm=
-poky-linux-gnueabi -lm -lrt -lpthread -lasound&quot;</div><div><br></div><=
div>do_compile() {</div><div>${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp<=
/div><div>}</div><div><br></div><div><br></div><div><br></div><div><br></di=
v><div>When i do bitbake rttapp, the error i see is as below</div><div><br>=
</div><div><br></div><div>Log data follows:</div><div>DEBUG: Executing shel=
l function do_compile</div><div>/tmp/cc6nn4Dp.o: In function `main&#39;:</d=
iv><div>/usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined reference to `=
pjsua_create&#39;</div><div>collect2: error: ld returned 1 exit status</div=
><div>WARNING: exit code 1 from a shell command.</div><div><br></div><div><=
br></div><div>Please advise</div></div>

--001a114e2fee73dc660554d8a0b8--
