Received: from mxh1.animate.de (mxh1.animate.de [83.246.66.188])
 by mx.groups.io with SMTP id smtpd.web12.5051.1606917491959012820
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Dec 2020 05:58:13 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: uib.de, ip: 83.246.66.188, mailfrom: m.radtke@uib.de)
Received: from localhost (localhost [127.0.0.1])
	by mxh1.animate.de (Postfix) with ESMTP id 17406A0D8A
	for <bitbake-devel@lists.openembedded.org>; Wed,  2 Dec 2020 14:58:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at animate.de
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-9999 required=5 WHITELISTED tests=[]
	autolearn=unavailable
Received: from mxh1.animate.de ([127.0.0.1])
	by localhost (mxh1.animate.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KRmWzmeoW7ZU for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2020 14:58:08 +0100 (CET)
Received: from mail.uib.gmbh (unknown [188.172.119.254])
	by mxh1.animate.de (Postfix) with ESMTP id E16BFA0D86
	for <bitbake-devel@lists.openembedded.org>; Wed,  2 Dec 2020 14:58:08 +0100 (CET)
Received: from groupware.mz.uib.gmbh (localhost [127.0.0.1])
	by mail.uib.gmbh (Postfix) with ESMTP id BE9F31000B6
	for <bitbake-devel@lists.openembedded.org>; Wed,  2 Dec 2020 14:58:08 +0100 (CET)
Received: by groupware (kopano-spooler) with MAPI; Wed, 2 Dec 2020 14:58:08
 +0100
Subject: Updating debootstrap fails
From: "Mathias Radtke" <m.radtke@uib.de>
To: =?us-ascii?Q?bitbake-devel=40lists=2Eopenembedded=2Eorg?=
  <bitbake-devel@lists.openembedded.org>
Date: Wed, 2 Dec 2020 13:58:08 +0000
Mime-Version: 1.0
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.16
Message-Id: <kcEE.sLxEC9m1QQKuZhNLqo2zdw.ANjMKbPI1gE@groupware.mz.uib.gmbh>
Content-Type: multipart/alternative; 
 boundary="=_MRVNsRrM5cKt3RBcRCdyjEfzBlvtADrgYuO4AuqBY+fcABvZ"

--=_MRVNsRrM5cKt3RBcRCdyjEfzBlvtADrgYuO4AuqBY+fcABvZ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I wanted to integrate debootstrap into my image.=C2=A0
However the versions I found (1.0.67) are quite old and the .tar.gz file =
downloaded in the bb file is not present anymore.
Therefore I wanted to update the .bb file.

I updated the link, updated the checksums for the downloaded file and the=
 license.
However running bitbake fails

ERROR: debootstrap-1.0.123-r0 do_populate_lic: QA Issue: debootstrap: LIC=
_FILES_CHKSUM points to an invalid file: /home/user/opsi-linux-bootimage-=
yocto/poky/build/tmp/work/core2-64-poky-linux/debootstrap/1.0.123-r0/debo=
otstrap-1.0.123/debian/copyright [license-checksum]

The file is not present in the given directory, as it is in=C2=A0

/home/user/opsi-linux-bootimage-yocto/poky/build/tmp/work/core2-64-poky-l=
inux/debootstrap/1.0.123-r0/debootstrap/debian/copyright

I tried to comment the License checksum in the bb file, but this resulted=
 in error during oe_runmake.

Can anyone suggest me how to update debootstrap=3F

Regards

Mathias





--
opsi - Open PC-Server-Integration
das Open Source Client-Management-System von uib gmbh


Mathias Radtke
Entwicklung
eMail: m.radtke@uib.de
Tel. +49 6131 / 27561-0
Fax=C2=A0 +49 6131 / 27561-22


uib gmbh
Bonifaziusplatz 1B
55118 Mainz

Internet:
https://uib.de
https://opsi.org


Geschftsfhrer: Dr. Detlef Oertel, Erol =C3=9Cl=C3=BCkmen
Handelsregister: Amtsgericht Mainz HRB 6942

--=_MRVNsRrM5cKt3RBcRCdyjEfzBlvtADrgYuO4AuqBY+fcABvZ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://ww=
w.w3.org/TR/html4/loose.dtd"><html>
<head>
  <meta name=3D"Generator" content=3D"Kopano WebApp v-4.6.3.0+156.1">
  <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8=
">
  <title>Updating debootstrap fails</title>
</head>
<body>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;">Hi,</p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">I wanted to integrate debootstrap into my image.&=
nbsp;<br />However the versions I found (1.0.67) are quite old and the .t=
ar.gz file downloaded in the bb file is not present anymore.<br />Therefo=
re I wanted to update the .bb file.</span></p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">I updated the link, updated the checksums for the=
 downloaded file and the license.<br />However running bitbake fails<br /=
></span></p>
<div>ERROR: debootstrap-1.0.123-r0 do_populate_lic: QA Issue: debootstrap=
: LIC_FILES_CHKSUM points to an invalid file: /home/user/opsi-linux-booti=
mage-yocto/poky/build/tmp/work/core2-64-poky-linux/debootstrap/1.0.123-r0=
/debootstrap-1.0.123/debian/copyright [license-checksum]</div>
<p>The file is not present in the given directory, as it is in&nbsp;</p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-se=
rif;">/home/user/opsi-linux-bootimage-yocto/poky/build/tmp/work/core2-64-=
poky-linux/debootstrap/1.0.123-r0/debootstrap/debian/copyright<br /><br /=
>I tried to comment the License checksum in the bb file, but this resulte=
d in error during oe_runmake.<br /><br />Can anyone suggest me how to upd=
ate debootstrap=3F<br /><br />Regards</span></p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-se=
rif;">Mathias</span></p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;"><br /></span></p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><br /></p>
<p style=3D"padding: 0; margin: 0;"><span style=3D"font-size: 10pt; font-=
family: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family=
: courier; font-size: small;">--</span><br style=3D"font-family: courier;=
 font-size: small;" /><span style=3D"font-family: courier; font-size: sma=
ll;">opsi - Open PC-Server-Integration</span><br style=3D"font-family: co=
urier; font-size: small;" /><span style=3D"font-family: courier; font-siz=
e: small;">das Open Source Client-Management-System von uib gmbh</span></=
span></p>
<p style=3D"padding: 0; margin: 0;"><span style=3D"font-size: 10pt; font-=
family: tahoma, arial, helvetica, sans-serif;"><br style=3D"font-family: =
courier; font-size: small;" /><span style=3D"font-family: courier; font-s=
ize: small;">Mathias Radtke</span><br style=3D"font-family: courier; font=
-size: small;" /><span style=3D"font-family: courier; font-size: small;">=
Entwicklung</span><br style=3D"font-family: courier; font-size: small;" /=
><span style=3D"font-family: courier; font-size: small;">eMail: m.radtke@=
uib.de</span><br style=3D"font-family: courier; font-size: small;" /><spa=
n style=3D"font-family: courier; font-size: small;">Tel. +49 6131 / 27561=
-0</span><br style=3D"font-family: courier; font-size: small;" /><span st=
yle=3D"font-family: courier; font-size: small;">Fax&nbsp; +49 6131 / 2756=
1-22</span><br style=3D"font-family: courier; font-size: small;" /><span =
style=3D"font-family: courier; font-size: small;"></span></span></p>
<p style=3D"padding: 0; margin: 0;"><span style=3D"font-size: 10pt; font-=
family: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family=
: courier; font-size: small;"></span></span></p>
<p style=3D"padding: 0; margin: 0;"><span style=3D"font-size: 10pt; font-=
family: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family=
: courier; font-size: small;">uib gmbh</span><br style=3D"font-family: co=
urier; font-size: small;" /><span style=3D"font-family: courier; font-siz=
e: small;">Bonifaziusplatz 1B</span><br style=3D"font-family: courier; fo=
nt-size: small;" /><span style=3D"font-family: courier; font-size: small;=
">55118 Mainz</span><br style=3D"font-family: courier; font-size: small;"=
 /><br style=3D"font-family: courier; font-size: small;" /><span style=3D=
"font-family: courier; font-size: small;">Internet:</span><br style=3D"fo=
nt-family: courier; font-size: small;" /><a href=3D"https://uib.de/" targ=
et=3D"_blank" rel=3D"noopener">https://uib.de</a><br style=3D"font-family=
: courier; font-size: small;" /><a href=3D"https://opsi.org/" target=3D"_=
blank" rel=3D"noopener">https://opsi.org</a><br style=3D"font-family: cou=
rier; font-size: small;" /><span style=3D"font-family: courier; font-size=
: small;"></span></span></p>
<p style=3D"padding: 0; margin: 0;"><span style=3D"font-size: 10pt; font-=
family: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family=
: courier; font-size: small;"></span></span></p>
<p style=3D"padding: 0; margin: 0;"><span style=3D"font-size: 10pt; font-=
family: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family=
: courier; font-size: small;">Geschftsfhrer: Dr. Detlef Oertel, Erol &Uum=
l;l&uuml;kmen</span><br style=3D"font-family: courier; font-size: small;"=
 /><span style=3D"font-family: courier; font-size: small;">Handelsregiste=
r: Amtsgericht Mainz HRB 6942</span><br /></span></p>
</body>
</html>

--=_MRVNsRrM5cKt3RBcRCdyjEfzBlvtADrgYuO4AuqBY+fcABvZ--
