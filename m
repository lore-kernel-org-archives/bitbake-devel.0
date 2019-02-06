Return-Path: <cameron@paloaltoinnovation.com>
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
	[209.85.214.170])
	by mail.openembedded.org (Postfix) with ESMTP id 9B32C6D3A2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Feb 2019 19:13:19 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id b5so3531062plr.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Feb 2019 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paloaltoinnovation-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to;
	bh=t4FRkagRLECFsWPz94uGnbbFkbxTSlHjGBX9B5uQhpU=;
	b=bojgmdD+ybd7TisGUmNpihF9ZlBo4QiHYWpje4zD4F3xMjsyNHG6NeHJCxotUp6JQk
	wLbwX4OmbxmyRcT7DAtf69ND7ofK/PvfaxobcByAyJ1OdXL4Ts67wnHZnP7L+OX9MO42
	p0J3mpSjyCD2znh30MkwgfSLCHFtVkwgYDOXIa/EDwH/UWdJki7iHXuS7iIsK/B+my8V
	lCCFbFySLHp086Ej+tu3z92ssvGzrTo7dmbA7FHYpMh/40HVetn2DXAWuquusHZTQwjS
	LLypDhRRw/osCUulm0rSSLJj568M/vMT2i8UXud00tMXk0yZIumapqxK3G6nwtx2o2bA
	Xw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=t4FRkagRLECFsWPz94uGnbbFkbxTSlHjGBX9B5uQhpU=;
	b=F1KCs00g31qW7NlBwSeeDJyYmG/qHQsMPVfrveKstrMYXInrSMORz9b0rCRGgq9+CM
	/wldy5OSgZ5zt/45EJq0/Nx8+lU/UymLXOyWfZFVkC9RBcc4dA6nYJMuDoWm8/Nmugio
	ZoCiiZEBofkGpTdytqDIntKBSJ6IfF5/6r8XQ9SB0RnhrqTW8IKj7dTnilQCodj70w2N
	OnoDD0f/w4uTBHnESy5AyAsmCcjyz1Pc/kND8KoWzeLqLX2ZqYVxjwUL/jiqZlhziQeR
	bnh6ST2c+BGn7D541LwVS/C8/6B3nTo+m0h+/mBpIxpczREzI0RW/QtoBQkOI5jGs09d
	6++Q==
X-Gm-Message-State: AHQUAuYNVwi7ahkLfFhIuCaijA1Y/s5lBZAuMbp1yZnwXQ5rnFUUuG+P
	GF4T7sBiPkvgI4d/l+ckUumsPCIkSyTNa6CgI2MQFSxk4Ko=
X-Google-Smtp-Source: AHgI3Iamnh17D32NJj0o/M0pWruhTg3AI2xYJJfA5eoq9B/hNYVS9l8EFv3ZLAddTIDvj1hGNhgXKxvYHg7d7SgprGI=
X-Received: by 2002:a17:902:346:: with SMTP id
	64mr12479478pld.337.1549480400344; 
	Wed, 06 Feb 2019 11:13:20 -0800 (PST)
MIME-Version: 1.0
From: Cameron Kellough <cameron@paloaltoinnovation.com>
Date: Wed, 6 Feb 2019 11:13:09 -0800
Message-ID: <CAHWfWz=EQrrUXBeSUqu6mxCd5A-Yw+yLWJxETfwW+D1AdNFPoQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Bitbaking recipe with patchdir in SRC_URI creates parse error
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
X-List-Received-Date: Wed, 06 Feb 2019 19:13:19 -0000
Content-Type: multipart/alternative; boundary="000000000000d968a505813e846b"

--000000000000d968a505813e846b
Content-Type: text/plain; charset="UTF-8"

Hi bitbake developers,
I'm working in a Rocko based bsp.  I've used the patchdir construct in
SRC_URI to apply patches in the tree where the build is expecting them.
When I set PV="1.0+git${SRCPV}", I get the following error and traceback if
any of the patchdir directives are present in SRC_URI:

ERROR: ExpansionError during parsing
/media/ckelloug/ExtraDrive1/edm_ycoto/sources/meta-doppler/recipes-doppler/doppler/
doppler_git.bb

Traceback (most recent call last):
  File
"/media/ckelloug/ExtraDrive1/edm_ycoto/sources/poky/bitbake/lib/bb/data_smart.py",
line 412, in
DataSmart.expandWithRefs(s='${BASE_WORKDIR}/${MULTIMACH_TARGET_SYS}/${PN}/${EXTENDPE}${PV}-${PR}',
varname='WORKDIR'):
                 try:
    >                s = __expand_var_regexp__.sub(varparse.var_sub, s)
                     try:
  File
"/media/ckelloug/ExtraDrive1/edm_ycoto/sources/poky/bitbake/lib/bb/data_smart.py",
line 111, in VariableParse.var_sub(match=<_sre.SRE_Match object; span=(57,
62), match='${PV}'>):
                 else:
    >                var = self.d.getVarFlag(key, "_content")
                 self.references.add(key)
  File
"/media/ckelloug/ExtraDrive1/edm_ycoto/sources/poky/bitbake/lib/bb/data_smart.py",
line 794, in DataSmart.getVarFlag(var='PV', flag='_content', expand=True,
noweakdefault=False, parsing=False):
                     cachename = var + "[" + flag + "]"
    >            value = self.expand(value, cachename)

  File
"/media/ckelloug/ExtraDrive1/edm_ycoto/sources/poky/bitbake/lib/bb/data_smart.py",
line 436, in DataSmart.expand(s='1.0+git${SRCPV}', varname='PV'):
         def expand(self, s, varname = None):
    >        return self.expandWithRefs(s, varname).value

  File
"/media/ckelloug/ExtraDrive1/edm_ycoto/sources/poky/bitbake/lib/bb/data_smart.py",
line 426, in DataSmart.expandWithRefs(s='1.0+git${SRCPV}', varname='PV'):
                 except Exception as exc:
    >                raise ExpansionError(varname, s, exc) from exc

bb.data_smart.ExpansionError: Failure expanding variable PV, expression was
1.0+git${SRCPV} which triggered exception RecursionError: maximum recursion
depth exceeded while calling a Python object



The error can be duplicated by doing bitbake -p doppler on the following
recipe as it occurs at parse time.  I've redacted my username and password
from the recipe and verified I still get the same parse error.


SUMMARY = "doppler"
SECTION = "doppler"
LICENSE = "MIT"
LIC_FILES_CHKSUM =
"file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/pa-innovation/doppler.git;protocol=https; \
           file://DopplerSettings.json \
           file://AlexaClientSDKConfig.json \
           file://doppler.conf \
           file://dop.sh \

file://0001-Commented-out-check-for-DopplerSettings.json.patch;patchdir=${WORKDIR}/git
\

file://0002-Added-opt-doppler-include-and-link-directories-to-CM.patch;patchdir=${WORKDIR}/git
\

file://0003-Added-opt-doppler-lib-to-all-amazon-find_library-sta.patch;patchdir=${WORKDIR}/git
\

file://0004-Set-find_library_path-path-for-ggk-lib-to-opt-dopple.patch;patchdir=${WORKDIR}/git
\

file://0005-set-path-for-PAI_LOCAL_LIB_INCLUDE_DIR.patch;patchdir=${WORKDIR}/git
\

file://0006-set-THREADS_PTHREAD_ARG-to-avoid-test-compile.patch;patchdir=${WORKDIR}/git
\

file://0007-Changed-Gobbledegook-to-not-have-embedded-relative-p.patch;patchdir=${WORKDIR}/git
\
           file://0001-Changed-sensory-path-to-6.6.0.patch; \
           "

#SRCREV = "e68d0527aa91a9bb1d43a0e38960995c3a53a54f"

SRCREV="${AUTOREV}"

#python() {
#     bb.warn("SRCPV=", d.getVar('SRCPV',True))
#}

PV = "1.0+git${SRCPV}"

#python() {
#     bb.warn("PV=", d.getVar('PV',True))
#}



S = "${WORKDIR}/git/src"
B = "${WORKDIR}/git/build"

SYSROOT_DIRS += "/opt"

DEPENDS = "glibc boost sqlite3 gcc-runtime libgcc libpai glib-2.0
gstreamer1.0 avs-device-sdk sensory alsa-lib ggk"


RDEPENDS_${PN} = " avs-device-sdk networkmanager"

inherit cmake

#EXTRA_OECMAKE = " \
#                  -DCMAKE_SKIP_BUILD_RPATH=TRUE \
#"

EXTRA_OECMAKE = " \
                  -DCMAKE_INSTALL_RPATH=/opt/doppler/lib \
                  -DCMAKE_BUILD_WITH_INSTALL_RPATH=TRUE \
"

do_install() {

install -d ${D}/opt/doppler/bin
install doppler ${D}/opt/doppler/bin
install logger-conf.conf ${D}/opt/doppler/bin
install bright-logger.conf ${D}/opt/doppler/bin
install scanWifi.sh ${D}/opt/doppler/bin
install connectWifi.sh ${D}/opt/doppler/bin
install disconnectWifi.sh ${D}/opt/doppler/bin
install wifiStatus.sh ${D}/opt/doppler/bin
install spot-alexa-rpi-31000.snsr ${D}/opt/doppler/bin
install ${WORKDIR}/DopplerSettings.json ${D}/opt/doppler/bin
install ${WORKDIR}/AlexaClientSDKConfig.json ${D}/opt/doppler/bin
install ${WORKDIR}/dop.sh ${D}/opt/doppler/bin
install -d ${D}/etc/dbus-1/system.d/
install ${WORKDIR}/doppler.conf ${D}/etc/dbus-1/system.d/doppler.conf
}

FILES_${PN} =  "/opt/doppler/bin"
FILES_${PN} += " /etc/dbus-1/system.d/doppler.conf "

--000000000000d968a505813e846b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div>Hi bitbake developers,</div><div>I&#39;m working in a Rocko =
based bsp.=C2=A0 I&#39;ve used the patchdir construct in SRC_URI to apply p=
atches in the tree where the build is expecting them.=C2=A0 When I set PV=
=3D&quot;1.0+git${SRCPV}&quot;, I get the following error and traceback if =
any of the patchdir directives are present in SRC_URI:<br></div><div><br></=
div><div>ERROR: ExpansionError during parsing /media/ckelloug/ExtraDrive1/e=
dm_ycoto/sources/meta-doppler/recipes-doppler/doppler/<a href=3D"http://dop=
pler_git.bb">doppler_git.bb</a></div><div><br></div><div>Traceback (most re=
cent call last):<br>=C2=A0 File &quot;/media/ckelloug/ExtraDrive1/edm_ycoto=
/sources/poky/bitbake/lib/bb/data_smart.py&quot;, line 412, in DataSmart.ex=
pandWithRefs(s=3D&#39;${BASE_WORKDIR}/${MULTIMACH_TARGET_SYS}/${PN}/${EXTEN=
DPE}${PV}-${PR}&#39;, varname=3D&#39;WORKDIR&#39;):<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 try:<br>=C2=A0=C2=A0=C2=A0 &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D __expand_var_rege=
xp__.sub(varparse.var_sub, s)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 try:<br>=C2=A0 File &quot;/media/ckelloug/ExtraDrive1/edm_ycoto/sources=
/poky/bitbake/lib/bb/data_smart.py&quot;, line 111, in VariableParse.var_su=
b(match=3D&lt;_sre.SRE_Match object; span=3D(57, 62), match=3D&#39;${PV}&#3=
9;&gt;):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:<br>=C2=A0=C2=A0=C2=A0 &gt;=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 var =3D self.d.getVarFlag(key, &quot;_content&quot;)<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 self.references.add(key)<br>=C2=A0 File &quot;/media/ckelloug/Ext=
raDrive1/edm_ycoto/sources/poky/bitbake/lib/bb/data_smart.py&quot;, line 79=
4, in DataSmart.getVarFlag(var=3D&#39;PV&#39;, flag=3D&#39;_content&#39;, e=
xpand=3DTrue, noweakdefault=3DFalse, parsing=3DFalse):<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cachename =3D var + &quot;[&quot; + flag + &=
quot;]&quot;<br>=C2=A0=C2=A0=C2=A0 &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D self.expand(value, cachename)<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 <br>=C2=A0 File &quot;/media/ckelloug/ExtraDrive1/=
edm_ycoto/sources/poky/bitbake/lib/bb/data_smart.py&quot;, line 436, in Dat=
aSmart.expand(s=3D&#39;1.0+git${SRCPV}&#39;, varname=3D&#39;PV&#39;):<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def expand(self, s, varnam=
e =3D None):<br>=C2=A0=C2=A0=C2=A0 &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return self.expandWithRefs(s, varname).value<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 <br>=C2=A0 File &quot;/media/ckelloug/ExtraDrive1/edm_ycoto/sources/=
poky/bitbake/lib/bb/data_smart.py&quot;, line 426, in DataSmart.expandWithR=
efs(s=3D&#39;1.0+git${SRCPV}&#39;, varname=3D&#39;PV&#39;):<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 except Exception as exc:<br>=C2=A0=C2=A0=C2=A0 &gt;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 raise ExpansionError(varname, s, exc) from exc<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 <br>bb.data_smart.ExpansionError: Failure expanding variable PV, expres=
sion was 1.0+git${SRCPV} which triggered exception RecursionError: maximum =
recursion depth exceeded while calling a Python object<br><br></div><div><b=
r></div><div><br></div><div>The error can be duplicated by doing bitbake -p=
 doppler on the following recipe as it occurs at parse time.=C2=A0 I&#39;ve=
 redacted my username and password from the recipe and verified I still get=
 the same parse error.<br></div><div><br></div><div><br></div><div>SUMMARY =
=3D &quot;doppler&quot;<br>SECTION =3D &quot;doppler&quot;<br>LICENSE =3D &=
quot;MIT&quot;<br>LIC_FILES_CHKSUM =3D &quot;file://${COMMON_LICENSE_DIR}/M=
IT;md5=3D0835ade698e0bcf8506ecda2f7b4f302&quot;<br><br>SRC_URI =3D &quot;gi=
t://<a href=3D"http://github.com/pa-innovation/doppler.git;protocol=3Dhttps=
">github.com/pa-innovation/doppler.git;protocol=3Dhttps</a>; \<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://DopplerSettings.=
json \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
://AlexaClientSDKConfig.json \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 file://doppler.conf \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://dop.sh \<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0001-Commented-out-check-for=
-DopplerSettings.json.patch;patchdir=3D${WORKDIR}/git \<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0002-Added-opt-doppler=
-include-and-link-directories-to-CM.patch;patchdir=3D${WORKDIR}/git \<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0003-Ad=
ded-opt-doppler-lib-to-all-amazon-find_library-sta.patch;patchdir=3D${WORKD=
IR}/git \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
ile://0004-Set-find_library_path-path-for-ggk-lib-to-opt-dopple.patch;patch=
dir=3D${WORKDIR}/git \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 file://0005-set-path-for-PAI_LOCAL_LIB_INCLUDE_DIR.patch;patch=
dir=3D${WORKDIR}/git \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 file://0006-set-THREADS_PTHREAD_ARG-to-avoid-test-compile.patc=
h;patchdir=3D${WORKDIR}/git \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 file://0007-Changed-Gobbledegook-to-not-have-embedded-re=
lative-p.patch;patchdir=3D${WORKDIR}/git \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0001-Changed-sensory-path-to-6.6.0=
.patch; \<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &=
quot;<br><br>#SRCREV =3D &quot;e68d0527aa91a9bb1d43a0e38960995c3a53a54f&quo=
t;<br><br>SRCREV=3D&quot;${AUTOREV}&quot;<br><br>#python() {<br>#=C2=A0=C2=
=A0=C2=A0 =C2=A0bb.warn(&quot;SRCPV=3D&quot;, d.getVar(&#39;SRCPV&#39;,True=
))<br>#}<br><br>PV =3D &quot;1.0+git${SRCPV}&quot;<br><br>#python() {<br>#=
=C2=A0=C2=A0=C2=A0 =C2=A0bb.warn(&quot;PV=3D&quot;, d.getVar(&#39;PV&#39;,T=
rue))<br>#}<br><br><br><br>S =3D &quot;${WORKDIR}/git/src&quot;<br>B =3D &q=
uot;${WORKDIR}/git/build&quot;<br><br>SYSROOT_DIRS +=3D &quot;/opt&quot;<br=
><br>DEPENDS =3D &quot;glibc boost sqlite3 gcc-runtime libgcc libpai glib-2=
.0 gstreamer1.0 avs-device-sdk sensory alsa-lib ggk&quot;<br><br><br>RDEPEN=
DS_${PN} =3D &quot; avs-device-sdk networkmanager&quot;<br><br>inherit cmak=
e<br><br>#EXTRA_OECMAKE =3D &quot; \<br>#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -DCMA=
KE_SKIP_BUILD_RPATH=3DTRUE \<br>#&quot;<br><br>EXTRA_OECMAKE =3D &quot; \<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -DCMAKE_INSTALL_RPATH=3D/opt/doppler/lib \<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -DCMAKE_BUILD_WITH_INSTALL_RPATH=3DTRUE \<br=
>&quot;<br><br>do_install() {<br><br>install -d ${D}/opt/doppler/bin<br>ins=
tall doppler ${D}/opt/doppler/bin<br>install logger-conf.conf ${D}/opt/dopp=
ler/bin<br>install bright-logger.conf ${D}/opt/doppler/bin<br>install scanW=
ifi.sh ${D}/opt/doppler/bin<br>install connectWifi.sh ${D}/opt/doppler/bin<=
br>install disconnectWifi.sh ${D}/opt/doppler/bin<br>install wifiStatus.sh =
${D}/opt/doppler/bin<br>install spot-alexa-rpi-31000.snsr ${D}/opt/doppler/=
bin<br>install ${WORKDIR}/DopplerSettings.json ${D}/opt/doppler/bin<br>inst=
all ${WORKDIR}/AlexaClientSDKConfig.json ${D}/opt/doppler/bin<br>install ${=
WORKDIR}/dop.sh ${D}/opt/doppler/bin<br>install -d ${D}/etc/dbus-1/system.d=
/<br>install ${WORKDIR}/doppler.conf ${D}/etc/dbus-1/system.d/doppler.conf<=
br>}<br><br>FILES_${PN} =3D=C2=A0 &quot;/opt/doppler/bin&quot;<br>FILES_${P=
N} +=3D &quot; /etc/dbus-1/system.d/doppler.conf &quot;</div><div><br></div=
><div><br></div><div><br></div></div></div></div></div></div>

--000000000000d968a505813e846b--
