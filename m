Return-Path: <kaustubha.s@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383AC43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 22:04:22 +0000 (UTC)
Subject: sha256sum and md5sum value.
To: bitbake-devel@lists.openembedded.org
From: kaustubha.s@gmail.com
X-Originating-Location: Montreal, Quebec, CA (165.225.212.91)
X-Originating-Platform: Windows Chrome 102
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 10 Jun 2022 15:04:15 -0700
Message-ID: <4RgF.1654898655633489443.g1Bs@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="1rUV8027YWav98S45Ky6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jun 2022 22:04:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13755

--1rUV8027YWav98S45Ky6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am new to bitbake, I was going through the bitbake documentation to get t=
he value of sha256sum and md5sum into the recipeinfo file from *.bb file.

for example in *.bb file:
SRC_URI[md5sum] =3D "XXXXXXXX"
SRC_URI[sha256sum] =3D "YYYYYYYY"

to recipe info file:
LICENSE: MIT
PR: r0
PV: x.x.x.x.x
SHA256SUM: XXXXXXXX
MD5SUM: YYYYYYYY

Can you someone please help me how to get this information into the recipei=
nfo file?

i tried using below instruction
get_name =3D d.getVarFlag("SRC_URI", 'sha256sum', expand=3DTrue)
if get_name:
info["SHA256SUM"] =3D data.getVar("SHA256SUM", d)

but is always prints "SHA256SUM : None". i am not sure what instruction to =
use for sha256sum or md5sum to log to recipeinfo file

-Kaustubha

--1rUV8027YWav98S45Ky6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; f=
ont-size: small;">Hi All,</span>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">I am new to bitbake, I was going through the bitbake docum=
entation to get the value of sha256sum and md5sum into the recipeinfo file =
from *.bb file.</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">for example in *.bb file:</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">SRC_URI[md5sum] =3D "XXXXXXXX"<br />SRC_URI[sha256sum] =3D=
 "YYYYYYYY"</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">to recipe info file:</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">LICENSE: MIT<br />PR: r0<br />PV: x.x.x.x.x<br />SHA256SUM=
: XXXXXXXX</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">MD5SUM: YYYYYYYY</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">Can you someone please help me how to get this information=
 into the recipeinfo file?</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">i tried using below instruction&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp; &nbsp; get_name =3D d.getVarFlag("SRC_URI", 'sha256=
sum', expand=3DTrue)<br />&nbsp; &nbsp; if get_name:<br />&nbsp; &nbsp; &nb=
sp; &nbsp; info["SHA256SUM"] =3D data.getVar("SHA256SUM", d)</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">but is always prints "SHA256SUM : None". i am not sure wha=
t instruction to use for sha256sum or md5sum to log to recipeinfo file</div=
>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">&nbsp;</div>
<div style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; fo=
nt-size: small;">-Kaustubha</div>

--1rUV8027YWav98S45Ky6--

