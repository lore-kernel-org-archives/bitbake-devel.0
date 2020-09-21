Received: from mxh1.animate.de (mxh1.animate.de [83.246.66.188])
 by mx.groups.io with SMTP id smtpd.web11.39614.1600686763687918699
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Sep 2020 04:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@uib.de header.s=uib20190118 header.b=VSoTe/b5;
 spf=pass (domain: uib.de, ip: 83.246.66.188, mailfrom: m.radtke@uib.de)
Received: from localhost (localhost [127.0.0.1])
	by mxh1.animate.de (Postfix) with ESMTP id 21E21A009E
	for <bitbake-devel@lists.openembedded.org>; Mon, 21 Sep 2020 13:12:41 +0200 (CEST)
Authentication-Results: mxh1.animate.de (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=uib.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uib.de; h=
	message-id:x-mailer:content-type:content-type:mime-version:date
	:date:from:from:subject:subject:received:received:received
	:received; s=uib20190118; t=1600686760; x=1602501161; bh=E3Kr7Lv
	2ANuyic3I2dPRKMFwirblmMNl7MNC0hfoAjk=; b=VSoTe/b5C9wwMs9mMFDzm1c
	uemMVXcgkE4kQIW6iLgryGKbqTGgAah2GFzk+YQgqJaDIVjm5DM19KSVsC9te4w1
	MR72HsjMUVvQbsKKa2/dyWvudR6OuhYSePpdHgdOEMaTNqUB9Ms+sI/2x38zZ94U
	JungyMNUdhVrwE3MFZJk=
X-Virus-Scanned: Debian amavisd-new at animate.de
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-9999 required=5 WHITELISTED tests=[]
	autolearn=unavailable
Received: from mxh1.animate.de ([127.0.0.1])
	by localhost (mxh1.animate.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V9hAc5CrKoI8 for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Sep 2020 13:12:40 +0200 (CEST)
Received: from mail.uib.gmbh (unknown [217.19.180.154])
	by mxh1.animate.de (Postfix) with ESMTP id C62ABA009B
	for <bitbake-devel@lists.openembedded.org>; Mon, 21 Sep 2020 13:12:40 +0200 (CEST)
Received: from groupware.mz.uib.gmbh (localhost [127.0.0.1])
	by mail.uib.gmbh (Postfix) with ESMTP id A13DF1000A5
	for <bitbake-devel@lists.openembedded.org>; Mon, 21 Sep 2020 13:12:40 +0200 (CEST)
Received: by groupware (kopano-spooler) with MAPI; Mon, 21 Sep 2020 13:12:40
 +0200
Subject: Downgrade util-linux
From: m.radtke@uib.de
To: =?us-ascii?Q?bitbake-devel=40lists=2Eopenembedded=2Eorg?=
  <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Sep 2020 11:12:40 +0000
Mime-Version: 1.0
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.16
Message-Id: <kcEE.5s8ZgDnjR+m5TxjkKS3lEQ.AESCHgiQ1gE@groupware.mz.uib.gmbh>
Content-Type: multipart/alternative; 
 boundary="=_EG8qKAGa3IgOR7vYjL0hBC4pz-K7lpH1Pp8H6wKHH7K0eJwf"

--=_EG8qKAGa3IgOR7vYjL0hBC4pz-K7lpH1Pp8H6wKHH7K0eJwf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I am currently experimenting with yocto and I was having a good start unt=
il now.

I want to rebuild a bootimage we have with yocto.
Currently the bootimage uses sfdisk 2.25.2 as later on the outputs change=
d and I didn't have time to adapt I always downgraded util-linux on the o=
ld bootimage.
To get quick results with a yocto based bootimage I wanted to do the same=
=2E I found a receive for a util-linux 2.25.2 package and added it to my =
recipes.

In my local.conf I added:



# downgrade util-linux
PREFERRED_VERSION_util-linux =3D "2.25.2"
=C2=A0However this seems to work partially as the output of bitbake is no=
w the following
=C2=A0ERROR: Multiple versions of util-linux are due to be built (/home/u=
ser/opsi-linux-bootimage-yocto/poky/build/../meta-opsi-bootimage/recipes-=
opsi-bootimage/util-linux/util-linux_2.25.2.bb /home/user/opsi-linux-boot=
image-yocto/poky/build/../meta/recipes-core/util-linux/util-linux_2.35.1.=
bb). Only one version of a given PN should be built in any given build. Y=
ou likely need to set PREFERRED_VERSION_util-linux to select the correct =
version or don't depend on multiple versions.



How can I build a bootimage with a downgraded util-linux package=3F

Regards

Mathias



--
opsi - Open PC-Server-Integration
das Open Source Client-Management-System von uib gmbh


Mathias Radtke
Entwicklung
eMail: m.radtke@uib.de
Tel. +49 6131 / 27561-16
Fax=C2=A0 +49 6131 / 27561-22


uib gmbh
Bonifaziusplatz 1B
55118 Mainz

Internet:
https://uib.de
https://opsi.org


Geschftsfhrer: Dr. Detlef Oertel, Erol =C3=9Cl=C3=BCkmen
Handelsregister: Amtsgericht Mainz HRB 6942

--=_EG8qKAGa3IgOR7vYjL0hBC4pz-K7lpH1Pp8H6wKHH7K0eJwf
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://ww=
w.w3.org/TR/html4/loose.dtd"><html>
<head>
  <meta name=3D"Generator" content=3D"Kopano WebApp v4.2.2878+128.1">
  <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8=
">
  <title>Downgrade util-linux</title>
</head>
<body>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;">Hi</p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">I am currently experimenting with yocto and I was=
 having a good start until now.<br /></span></p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">I want to rebuild a bootimage we have with yocto.=
<br />Currently the bootimage uses sfdisk 2.25.2 as later on the outputs =
changed and I didn't have time to adapt I always downgraded util-linux on=
 the old bootimage.<br />To get quick results with a yocto based bootimag=
e I wanted to do the same. I found a receive for a util-linux 2.25.2 pack=
age and added it to my recipes.</span></p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">In my local.conf I added:</span></p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;"><br /></span></p>
<div style=3D"padding-left: 30px;"># downgrade util-linux</div>
<div style=3D"padding-left: 30px;">PREFERRED_VERSION_util-linux =3D "2.25=
=2E2"</div>
<div style=3D"padding-left: 30px;">&nbsp;</div>
<div>However this seems to work partially as the output of bitbake is now=
 the following</div>
<div>&nbsp;</div>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 11pt; p=
adding: 0px 0px 0px 30px; margin: 0px;"><span style=3D"font-size: 11pt; f=
ont-family: arial, helvetica, sans-serif;">ERROR: Multiple versions of ut=
il-linux are due to be built (/home/user/opsi-linux-bootimage-yocto/poky/=
build/../meta-opsi-bootimage/recipes-opsi-bootimage/util-linux/util-linux=
_2.25.2.bb /home/user/opsi-linux-bootimage-yocto/poky/build/../meta/recip=
es-core/util-linux/util-linux_2.35.1.bb). Only one version of a given PN =
should be built in any given build. You likely need to set PREFERRED_VERS=
ION_util-linux to select the correct version or don't depend on multiple =
versions.</span></p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 11pt; p=
adding-top: 0px; padding-right: 0px; padding-bottom: 0px; margin: 0px;"><=
span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif;=
"><br /></span></p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 11pt; p=
adding-top: 0px; padding-right: 0px; padding-bottom: 0px; margin: 0px;"><=
span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif;=
">How can I build a bootimage with a downgraded util-linux package=3F<br =
/><br />Regards</span></p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 11pt; p=
adding-top: 0px; padding-right: 0px; padding-bottom: 0px; margin: 0px;"><=
span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif;=
">Mathias</span></p>
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
-16</span><br style=3D"font-family: courier; font-size: small;" /><span s=
tyle=3D"font-family: courier; font-size: small;">Fax&nbsp; +49 6131 / 275=
61-22</span><br style=3D"font-family: courier; font-size: small;" /><span=
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

--=_EG8qKAGa3IgOR7vYjL0hBC4pz-K7lpH1Pp8H6wKHH7K0eJwf--
