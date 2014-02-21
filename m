Return-Path: <oboturoff@gmail.com>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id 7B07B6CB7C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2014 13:18:27 +0000 (UTC)
Received: by mail-ob0-f174.google.com with SMTP id uy5so4034106obc.19
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2014 05:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=mleifxqGcUZnL2AntD2F9Jjvr9citN2WZxMEXPuJ+WI=;
	b=BQgHxt0J5vfe86EXS9rGUKSfgmLcj0c2y8P2GX7/e/ECM67tmil7hy+CfCEQl9b/ET
	pMgMh/J2QnkftkOrT64/RmNrsur3bWPn1vKqtyUbqMwi4NQCJbdNKlHFWQoOn4sVcPZk
	xIxl9Ic/kVpnLGIZbAeAjdADURn0AeSxoVfcqYwMakbknoxkIyDS1CoYDjwSM76FT4Et
	jXEl6prIwYB4ZHvpYHZ1hBltFLBu5vjPi6BxGa+oigoLs/ImZFoandnangW/cP/9NOZ6
	RMQc5xaY73r6KvfhbreUfQBR9cml/VTB4YusadQSuIz8FVWdGQr/p6y3MPuFGeqThgxZ
	PPbA==
MIME-Version: 1.0
X-Received: by 10.42.254.3 with SMTP id nc3mr3415225icb.67.1392988708212; Fri,
	21 Feb 2014 05:18:28 -0800 (PST)
Received: by 10.64.225.18 with HTTP; Fri, 21 Feb 2014 05:18:28 -0800 (PST)
Date: Fri, 21 Feb 2014 17:18:28 +0400
Message-ID: <CAC7Dm8+3uyPxwUiUxYbRnw0_+gZsN+0L6hEq7Wsv3GksctH6Ew@mail.gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0J7QsdC+0YLRg9GA0L7Qsg==?=
	<oboturoff@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake -c cleanall <target>
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
X-List-Received-Date: Fri, 21 Feb 2014 13:18:31 -0000
Content-Type: multipart/alternative; boundary=bcaec51593e32116ea04f2ea75a3

--bcaec51593e32116ea04f2ea75a3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

sorry for my stupid question. i am beginner in bitbake.

How I can correct delete all images from folder:
*/build_p5040ds_release/tmp/deploy/images*

in yocto system.

i know a command:
* bitbake -c cleanall <target>*

but i am not understand, what this *<target>*?

i try to use:

*bitbake -c cleanall e5500*

*bitbake -c cleanall fsl-networking*

*bitbake -c cleanall ppc*

*bitbake -c cleanall fsl**
*bitbake -c cleanall fsl-image-minimal-p5040ds-20140212095057.rootfs.tar.gz=
*
*bitbake -c cleanall linux*

they are not working.... and I have always error:
*ERROR: Nothing PROVIDES ....*

current folder content:
*ls -l*
*=D0=B8=D1=82=D0=BE=D0=B3=D0=BE 354236*
*-rw-r--r-- 1 dima dima     28512 =D1=84=D0=B5=D0=B2=D1=80. 12 13:44
fsl_fman_ucode_p5040_r1.0_106_1_11.bin*
*-rw-r--r-- 1 dima dima     28512 =D1=84=D0=B5=D0=B2=D1=80. 12 13:44
fsl_fman_ucode_p5040_r2.0_106_1_11.bin*
*-rw-r--r-- 1 dima dima 307173732 =D1=84=D0=B5=D0=B2=D1=80. 12 17:14
fsl-image-full-p5040ds-20140212130719.rootfs.tar.gz*
*lrwxrwxrwx 1 dima dima        51 =D1=84=D0=B5=D0=B2=D1=80. 12 17:14
fsl-image-full-p5040ds.tar.gz ->
fsl-image-full-p5040ds-20140212130719.rootfs.tar.gz*
*-rw-r--r-- 1 dima dima   3658923 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46
fsl-image-minimal-p5040ds-20140212094514.rootfs.ext2.gz*
*-rw-r--r-- 1 dima dima   3658987 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46
fsl-image-minimal-p5040ds-20140212094514.rootfs.ext2.gz.u-boot*
*-rw-r--r-- 1 dima dima   4521984 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46
fsl-image-minimal-p5040ds-20140212094514.rootfs.jffs2*
*-rw-r--r-- 1 dima dima   3638829 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46
fsl-image-minimal-p5040ds-20140212094514.rootfs.tar.gz*
*-rw-r--r-- 1 dima dima   6340608 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46
fsl-image-minimal-p5040ds-20140212094514.rootfs.ubi*
*-rw-r--r-- 1 dima dima   5913600 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46
fsl-image-minimal-p5040ds-20140212094514.rootfs.ubifs*
*-rw-r--r-- 1 dima dima   3658906 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds-20140212095057.rootfs.ext2.gz*
*-rw-r--r-- 1 dima dima   3658970 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds-20140212095057.rootfs.ext2.gz.u-boot*
*-rw-r--r-- 1 dima dima   4521984 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds-20140212095057.rootfs.jffs2*
*-rw-r--r-- 1 dima dima   3638827 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds-20140212095057.rootfs.tar.gz*
*-rw-r--r-- 1 dima dima   6340608 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds-20140212095057.rootfs.ubi*
*-rw-r--r-- 1 dima dima   5913600 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds-20140212095057.rootfs.ubifs*
*lrwxrwxrwx 1 dima dima        55 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds.ext2.gz ->
fsl-image-minimal-p5040ds-20140212095057.rootfs.ext2.gz*
*lrwxrwxrwx 1 dima dima        62 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds.ext2.gz.u-boot ->
fsl-image-minimal-p5040ds-20140212095057.rootfs.ext2.gz.u-boot*
*lrwxrwxrwx 1 dima dima        53 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds.jffs2 ->
fsl-image-minimal-p5040ds-20140212095057.rootfs.jffs2*
*lrwxrwxrwx 1 dima dima        54 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds.tar.gz ->
fsl-image-minimal-p5040ds-20140212095057.rootfs.tar.gz*
*lrwxrwxrwx 1 dima dima        51 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51
fsl-image-minimal-p5040ds.ubi ->
fsl-image-minimal-p5040ds-20140212095057.rootfs.ubi*
*drwxr-xr-x 2 dima dima      4096 =D1=84=D0=B5=D0=B2=D1=80. 12 13:44 hv*
*drwxr-xr-x 3 dima dima      4096 =D1=84=D0=B5=D0=B2=D1=80. 11 18:19 hv-cfg=
*
*drwxr-xr-x 3 dima dima      4096 =D1=84=D0=B5=D0=B2=D1=80. 11 18:19 rcw*
*-rw-r--r-- 1 dima dima       252 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 ubiniz=
e.cfg*

Thanks

--bcaec51593e32116ea04f2ea75a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>sorry for my stupid question. i =
am beginner in bitbake.</div><div><br></div><div>How I can correct delete a=
ll images from folder:</div><div><b>/build_p5040ds_release/tmp/deploy/image=
s</b><br>
</div><div><b><br></b></div><div>in yocto system.<br></div><div><br></div><=
div>i know a command:</div><div><b>=C2=A0bitbake -c cleanall &lt;target&gt;=
</b></div><div><br></div><div>but i am not understand, what this <b>&lt;tar=
get&gt;</b>?</div>
<div><br></div><div>i try to use:</div><div><font size=3D"1"><b>bitbake -c =
cleanall e5500<br></b></font></div><div><font size=3D"1"><b>bitbake -c clea=
nall fsl-networking<br></b></font></div><div><font size=3D"1"><b>bitbake -c=
 cleanall ppc<br>
</b></font></div><div><font size=3D"1"><b>bitbake -c cleanall fsl*<br></b><=
/font></div><div><font size=3D"1"><b>bitbake -c cleanall fsl-image-minimal-=
p5040ds-20140212095057.rootfs.tar.gz</b></font><br></div><div><b style=3D"f=
ont-size:x-small">bitbake -c cleanall linux</b><font size=3D"1"><b><br>
</b></font></div><div><b style=3D"font-size:x-small"><br></b></div><div>the=
y are not working.... and I have always error:<br></div><div><b>ERROR: Noth=
ing PROVIDES ....</b><br></div><div><br></div><div>current folder content:<=
/div>
<div><div><b><font size=3D"1">ls -l</font></b></div><div><b><font size=3D"1=
">=D0=B8=D1=82=D0=BE=D0=B3=D0=BE 354236</font></b></div><div><b><font size=
=3D"1">-rw-r--r-- 1 dima dima =C2=A0 =C2=A0 28512 =D1=84=D0=B5=D0=B2=D1=80.=
 12 13:44 fsl_fman_ucode_p5040_r1.0_106_1_11.bin</font></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 =C2=A0 28512 =D1=84=
=D0=B5=D0=B2=D1=80. 12 13:44 fsl_fman_ucode_p5040_r2.0_106_1_11.bin</font><=
/b></div><div><b><font size=3D"1">-rw-r--r-- 1 dima dima 307173732 =D1=84=
=D0=B5=D0=B2=D1=80. 12 17:14 fsl-image-full-p5040ds-20140212130719.rootfs.t=
ar.gz</font></b></div>
<div><b><font size=3D"1">lrwxrwxrwx 1 dima dima =C2=A0 =C2=A0 =C2=A0 =C2=A0=
51 =D1=84=D0=B5=D0=B2=D1=80. 12 17:14 fsl-image-full-p5040ds.tar.gz -&gt; f=
sl-image-full-p5040ds-20140212130719.rootfs.tar.gz</font></b></div><div><b>=
<font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 3658923 =D1=84=D0=B5=D0=B2=
=D1=80. 12 13:46 fsl-image-minimal-p5040ds-20140212094514.rootfs.ext2.gz</f=
ont></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 3658987 =D1=84=D0=B5=
=D0=B2=D1=80. 12 13:46 fsl-image-minimal-p5040ds-20140212094514.rootfs.ext2=
.gz.u-boot</font></b></div><div><b><font size=3D"1">-rw-r--r-- 1 dima dima =
=C2=A0 4521984 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46 fsl-image-minimal-p5040ds=
-20140212094514.rootfs.jffs2</font></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 3638829 =D1=84=D0=B5=
=D0=B2=D1=80. 12 13:46 fsl-image-minimal-p5040ds-20140212094514.rootfs.tar.=
gz</font></b></div><div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 6=
340608 =D1=84=D0=B5=D0=B2=D1=80. 12 13:46 fsl-image-minimal-p5040ds-2014021=
2094514.rootfs.ubi</font></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 5913600 =D1=84=D0=B5=
=D0=B2=D1=80. 12 13:46 fsl-image-minimal-p5040ds-20140212094514.rootfs.ubif=
s</font></b></div><div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 36=
58906 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds-20140212=
095057.rootfs.ext2.gz</font></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 3658970 =D1=84=D0=B5=
=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds-20140212095057.rootfs.ext2=
.gz.u-boot</font></b></div><div><b><font size=3D"1">-rw-r--r-- 1 dima dima =
=C2=A0 4521984 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds=
-20140212095057.rootfs.jffs2</font></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 3638827 =D1=84=D0=B5=
=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds-20140212095057.rootfs.tar.=
gz</font></b></div><div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 6=
340608 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds-2014021=
2095057.rootfs.ubi</font></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 5913600 =D1=84=D0=B5=
=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds-20140212095057.rootfs.ubif=
s</font></b></div><div><b><font size=3D"1">lrwxrwxrwx 1 dima dima =C2=A0 =
=C2=A0 =C2=A0 =C2=A055 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal=
-p5040ds.ext2.gz -&gt; fsl-image-minimal-p5040ds-20140212095057.rootfs.ext2=
.gz</font></b></div>
<div><b><font size=3D"1">lrwxrwxrwx 1 dima dima =C2=A0 =C2=A0 =C2=A0 =C2=A0=
62 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds.ext2.gz.u-b=
oot -&gt; fsl-image-minimal-p5040ds-20140212095057.rootfs.ext2.gz.u-boot</f=
ont></b></div><div><b><font size=3D"1">lrwxrwxrwx 1 dima dima =C2=A0 =C2=A0=
 =C2=A0 =C2=A053 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040=
ds.jffs2 -&gt; fsl-image-minimal-p5040ds-20140212095057.rootfs.jffs2</font>=
</b></div>
<div><b><font size=3D"1">lrwxrwxrwx 1 dima dima =C2=A0 =C2=A0 =C2=A0 =C2=A0=
54 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds.tar.gz -&gt=
; fsl-image-minimal-p5040ds-20140212095057.rootfs.tar.gz</font></b></div><d=
iv><b><font size=3D"1">lrwxrwxrwx 1 dima dima =C2=A0 =C2=A0 =C2=A0 =C2=A051=
 =D1=84=D0=B5=D0=B2=D1=80. 12 13:51 fsl-image-minimal-p5040ds.ubi -&gt; fsl=
-image-minimal-p5040ds-20140212095057.rootfs.ubi</font></b></div>
<div><b><font size=3D"1">drwxr-xr-x 2 dima dima =C2=A0 =C2=A0 =C2=A04096 =
=D1=84=D0=B5=D0=B2=D1=80. 12 13:44 hv</font></b></div><div><b><font size=3D=
"1">drwxr-xr-x 3 dima dima =C2=A0 =C2=A0 =C2=A04096 =D1=84=D0=B5=D0=B2=D1=
=80. 11 18:19 hv-cfg</font></b></div><div><b><font size=3D"1">drwxr-xr-x 3 =
dima dima =C2=A0 =C2=A0 =C2=A04096 =D1=84=D0=B5=D0=B2=D1=80. 11 18:19 rcw</=
font></b></div>
<div><b><font size=3D"1">-rw-r--r-- 1 dima dima =C2=A0 =C2=A0 =C2=A0 252 =
=D1=84=D0=B5=D0=B2=D1=80. 12 13:51 ubinize.cfg</font></b></div></div><div><=
br></div><div>Thanks</div><div><br></div></div>

--bcaec51593e32116ea04f2ea75a3--
