Return-Path: <dobekp@wp.pl>
X-Greylist: delayed 400 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 28 Jul 2014 04:14:40 UTC
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	by mail.openembedded.org (Postfix) with ESMTP id 050BE65EE7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jul 2014 04:14:40 +0000 (UTC)
Received: (wp-smtpd smtp.wp.pl 6226 invoked from network);
	28 Jul 2014 06:07:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
	t=1406520479; bh=tdZiqlM6y7wMfh4ltT05v+WWbtFgdoHlDUV75QaCRSI=;
	h=Subject:From:To;
	b=fANQgVCNoZOBB+w8WjT3tc8/qhPJSvMQnyWIviZu2O4LaCvj7T5GoRrlawyxictpK
	s3vlBTyaM5FDUmfougCEn4mWLMB2UBdga1PGsPZSdp6h4ZA+QUkKCAVJTvFJdvA+JA
	AHb97UlC+lLFgBNqNSPihGRouyTRxj1AtbxuwZrc=
Received: from mail-qg0-f45.google.com (dobekp@[209.85.192.45])
	(envelope-sender <dobekp@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with RC4-SHA encrypted SMTP
	for <bitbake-devel@lists.openembedded.org>; 28 Jul 2014 06:07:59 +0200
Received: by mail-qg0-f45.google.com with SMTP id f51so7862804qge.32
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 27 Jul 2014 21:07:57 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.140.47.80 with SMTP id l74mr55456147qga.24.1406520477700;
	Sun, 27 Jul 2014 21:07:57 -0700 (PDT)
Received: by 10.96.51.170 with HTTP; Sun, 27 Jul 2014 21:07:57 -0700 (PDT)
Date: Sun, 27 Jul 2014 21:07:57 -0700
Message-ID: <CAKgi2ABPViNFnjQJyCmsx6hS4+-ARB00rO6sgARatWX2xNBzZw@mail.gmail.com>
From: Dobekp <dobekp@wp.pl>
To: bitbake-devel@lists.openembedded.org
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0W00000 [AeNk]                               
Subject: Custom license fails
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
X-List-Received-Date: Mon, 28 Jul 2014 04:14:48 -0000
Content-Type: multipart/alternative; boundary=001a11c16064715b3704ff3911be

--001a11c16064715b3704ff3911be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've created a test layer with a custom license and I got bitbake errors:

ERROR: Function failed: test-license: LIC_FILES_CHKSUM points to an invalid
file:
/home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-r=
0/test-license-2.3/TESTLICENSE
ERROR: Logfile of failure stored in:
/home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-r=
0/temp/log.do_configure.15560


Some logs:

do_populate_lic_setscene (15543): log.do_populate_lic_setscene.15543
do_fetch (15555): log.do_fetch.15555
do_unpack (15556): log.do_unpack.15556
do_patch (15558): log.do_patch.15558
do_configure (15560): log.do_configure.15560


DEBUG: Executing python function do_populate_lic_setscene
DEBUG: Executing shell function sstate_unpack_package
license-destdir/
license-destdir/test-license/
license-destdir/test-license/generic_TESTLICENSE
DEBUG: Shell function sstate_unpack_package finished
DEBUG: Staging files from
/home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-r=
0/license-destdir
to /home/dobek/code/poky/build/tmp/deploy/licenses
DEBUG: Python function do_populate_lic_setscene finished

DEBUG: Executing python function do_fetch
DEBUG: Executing python function base_do_fetch
DEBUG: Python function base_do_fetch finished
DEBUG: Python function do_fetch finished

DEBUG: Executing python function sysroot_cleansstate
DEBUG: Python function sysroot_cleansstate finished
DEBUG: Executing shell function do_configure
DEBUG: Shell function do_configure finished
DEBUG: Executing python function do_qa_configure
NOTE: Checking autotools environment for common misconfiguration
DEBUG: Python function do_qa_configure finished
ERROR: Function failed: test-license: LIC_FILES_CHKSUM points to an invalid
file:
/home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-r=
0/test-license-2.3/TESTLICENSE


My layer:
meta-test-license
=E2=94=9C=E2=94=80=E2=94=80 conf
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 layer.conf
=E2=94=9C=E2=94=80=E2=94=80 recipes-test
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test-license
=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 test-license_2.3.bb
=E2=94=94=E2=94=80=E2=94=80 TESTLICENSE

layer.conf:
# We have a conf and classes directory, add to BBPATH
BBPATH .=3D ":${LAYERDIR}"

# We have recipes-* directories, add to BBFILES
BBFILES +=3D "${LAYERDIR}/recipes-*/*/*.bb \
${LAYERDIR}/recipes-*/*/*.bbappend"

BBFILE_COLLECTIONS +=3D "test-license"
BBFILE_PATTERN_test-license =3D "^${LAYERDIR}/"
BBFILE_PRIORITY_test-license=3D "6"

#LICENSE_PATH :=3D "${LAYERDIR}"

test-license_2.3.bb:
DESCRIPTION =3D "Test License"

#LICENSE =3D "MIT"
#LIC_FILES_CHKSUM =3D
"file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0bcf8506ecda2f7b4f302"

LICENSE =3D "TESTLICENSE"
LIC_FILES_CHKSUM =3D "file://TESTLICENSE;md5=3D46311aae768cf83d79351d78701a=
6670"

It works fine for MIT license but not for test one. Is it a bug or I just
missed something?

BTW to rebuild I call:
rm -fr
/home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-r=
0
; bitbake test-license -c clean ; bitbake test-license -f

But it is still not the same. The first time I got additionally:
WARNING: Could not copy license file TESTLICENSE: [Errno 2] No such file or
directory:
'/home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-=
r0/test-license-2.3/TESTLICENSE'

--
Thanks
Dobek

--001a11c16064715b3704ff3911be
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;ve created a test layer with =
a custom license and I got bitbake errors:</div><blockquote style=3D"margin=
:0px 0px 0px 40px;border:none;padding:0px"><div><font size=3D"1">ERROR: Fun=
ction failed: test-license: LIC_FILES_CHKSUM points to an invalid file: /ho=
me/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-r0/t=
est-license-2.3/TESTLICENSE</font></div>
<div><font size=3D"1">ERROR: Logfile of failure stored in: /home/dobek/code=
/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3-r0/temp/log.do_co=
nfigure.15560</font></div></blockquote><div><br></div><div>Some logs:</div>
<blockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px"><div>=
<div><font size=3D"1">do_populate_lic_setscene (15543): log.do_populate_lic=
_setscene.15543</font></div></div><div><div><font size=3D"1">do_fetch (1555=
5): log.do_fetch.15555</font></div>
</div><div><div><font size=3D"1">do_unpack (15556): log.do_unpack.15556</fo=
nt></div></div><div><div><font size=3D"1">do_patch (15558): log.do_patch.15=
558</font></div></div><div><div><font size=3D"1">do_configure (15560): log.=
do_configure.15560</font></div>
</div></blockquote><div><blockquote style=3D"margin:0px 0px 0px 40px;border=
:none;padding:0px"><div><font size=3D"1"><br></font></div><div><div><font s=
ize=3D"1">DEBUG: Executing python function do_populate_lic_setscene</font><=
/div>
</div><div><div><font size=3D"1">DEBUG: Executing shell function sstate_unp=
ack_package</font></div></div><div><div><font size=3D"1">license-destdir/</=
font></div></div><div><div><font size=3D"1">license-destdir/test-license/</=
font></div>
</div><div><div><font size=3D"1">license-destdir/test-license/generic_TESTL=
ICENSE</font></div></div><div><div><font size=3D"1">DEBUG: Shell function s=
state_unpack_package finished</font></div></div><div><div><font size=3D"1">=
DEBUG: Staging files from /home/dobek/code/poky/build/tmp/work/core2-64-pok=
y-linux/test-license/2.3-r0/license-destdir to /home/dobek/code/poky/build/=
tmp/deploy/licenses</font></div>
</div><div><div><font size=3D"1">DEBUG: Python function do_populate_lic_set=
scene finished</font></div></div><div><font size=3D"1"><br></font></div><di=
v><div><font size=3D"1">DEBUG: Executing python function do_fetch</font></d=
iv>
</div><div><div><font size=3D"1">DEBUG: Executing python function base_do_f=
etch</font></div></div><div><div><font size=3D"1">DEBUG: Python function ba=
se_do_fetch finished</font></div></div><div><div><font size=3D"1">DEBUG: Py=
thon function do_fetch finished</font></div>
</div><div><font size=3D"1"><br></font></div><div><div><font size=3D"1">DEB=
UG: Executing python function sysroot_cleansstate</font></div></div><div><d=
iv><font size=3D"1">DEBUG: Python function sysroot_cleansstate finished</fo=
nt></div>
</div><div><div><font size=3D"1">DEBUG: Executing shell function do_configu=
re</font></div></div><div><div><font size=3D"1">DEBUG: Shell function do_co=
nfigure finished</font></div></div><div><div><font size=3D"1">DEBUG: Execut=
ing python function do_qa_configure</font></div>
</div><div><div><font size=3D"1">NOTE: Checking autotools environment for c=
ommon misconfiguration</font></div></div><div><div><font size=3D"1">DEBUG: =
Python function do_qa_configure finished</font></div></div><div><div><font =
size=3D"1">ERROR: Function failed: test-license: LIC_FILES_CHKSUM points to=
 an invalid file: /home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/=
test-license/2.3-r0/test-license-2.3/TESTLICENSE</font></div>
</div></blockquote></div><div><br></div><div>My layer:</div><div><div>meta-=
test-license</div><div>=E2=94=9C=E2=94=80=E2=94=80 conf</div><div>=E2=94=82=
 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 layer.conf</div><div>=E2=94=9C=E2=94=80=
=E2=94=80 recipes-test</div><div>=E2=94=82 =C2=A0 =E2=94=94=E2=94=80=E2=94=
=80 test-license</div><div>=E2=94=82 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=
=80=E2=94=80 <a href=3D"http://test-license_2.3.bb">test-license_2.3.bb</a>=
</div>
<div>=E2=94=94=E2=94=80=E2=94=80 TESTLICENSE</div></div><div><br></div><div=
>layer.conf:</div><div><div><font size=3D"1"># We have a conf and classes d=
irectory, add to BBPATH</font></div><div><font size=3D"1">BBPATH .=3D &quot=
;:${LAYERDIR}&quot;</font></div>
<div><font size=3D"1"><br></font></div><div><font size=3D"1"># We have reci=
pes-* directories, add to BBFILES</font></div><div><font size=3D"1">BBFILES=
 +=3D &quot;${LAYERDIR}/recipes-*/*/*.bb \</font></div><div><font size=3D"1=
"><span class=3D"" style=3D"white-space:pre">	</span>${LAYERDIR}/recipes-*/=
*/*.bbappend&quot;</font></div>
<div><font size=3D"1"><br></font></div><div><font size=3D"1">BBFILE_COLLECT=
IONS +=3D &quot;test-license&quot;</font></div><div><font size=3D"1">BBFILE=
_PATTERN_test-license =3D &quot;^${LAYERDIR}/&quot;</font></div><div><font =
size=3D"1">BBFILE_PRIORITY_test-license=3D &quot;6&quot;</font></div>
<div><font size=3D"1"><br></font></div><div><font size=3D"1">#LICENSE_PATH =
:=3D &quot;${LAYERDIR}&quot;</font></div></div><div><br></div><div><a href=
=3D"http://test-license_2.3.bb">test-license_2.3.bb</a>:</div><div><div><fo=
nt size=3D"1">DESCRIPTION =3D &quot;Test License&quot;</font></div>
<div><font size=3D"1"><br></font></div><div><font size=3D"1">#LICENSE =3D &=
quot;MIT&quot;</font></div><div><font size=3D"1">#LIC_FILES_CHKSUM =3D &quo=
t;file://${COMMON_LICENSE_DIR}/MIT;md5=3D0835ade698e0bcf8506ecda2f7b4f302&q=
uot;</font></div>
<div><font size=3D"1"><br></font></div><div><font size=3D"1">LICENSE =3D &q=
uot;TESTLICENSE&quot;</font></div><div><font size=3D"1">LIC_FILES_CHKSUM =
=3D &quot;file://TESTLICENSE;md5=3D46311aae768cf83d79351d78701a6670&quot;</=
font></div>
</div><div><br></div><div>It works fine for MIT license but not for test on=
e. Is it a bug or I just missed something?</div><div><br></div><div>BTW to =
rebuild I call:</div><div><font size=3D"1">rm -fr /home/dobek/code/poky/bui=
ld/tmp/work/core2-64-poky-linux/test-license/2.3-r0 ; bitbake test-license =
-c clean ; bitbake test-license -f</font><br>
</div><div><br></div><div>But it is still not the same. The first time I go=
t additionally:</div><div><span style=3D"font-size:x-small">WARNING: Could =
not copy license file TESTLICENSE: [Errno 2] No such file or directory: &#3=
9;/home/dobek/code/poky/build/tmp/work/core2-64-poky-linux/test-license/2.3=
-r0/test-license-2.3/TESTLICENSE&#39;</span><br>
</div><div><span style=3D"font-size:x-small"><br></span></div><div><span st=
yle=3D"font-size:x-small">--</span></div><div><span style=3D"font-size:x-sm=
all">Thanks</span></div><div><span style=3D"font-size:x-small">Dobek</span>=
</div>
</div>

--001a11c16064715b3704ff3911be--
