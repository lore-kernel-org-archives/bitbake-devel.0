Received: from mxh1.animate.de (mxh1.animate.de [83.246.66.188])
 by mx.groups.io with SMTP id smtpd.web12.6897.1601037909566542285
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Sep 2020 05:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@uib.de header.s=uib20190118 header.b=RIm55kyD;
 spf=pass (domain: uib.de, ip: 83.246.66.188, mailfrom: m.radtke@uib.de)
Received: from localhost (localhost [127.0.0.1])
	by mxh1.animate.de (Postfix) with ESMTP id 272539FFC4
	for <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2020 14:45:07 +0200 (CEST)
Authentication-Results: mxh1.animate.de (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=uib.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uib.de; h=
	message-id:x-mailer:content-type:content-type:mime-version:date
	:date:from:from:subject:subject:received:received:received
	:received; s=uib20190118; t=1601037906; x=1602852307; bh=8FfAMKR
	omjPx2CVx5ZI0TUetSYk3mup7EpjzP2K5eGU=; b=RIm55kyD1RPel41mrOr2+2f
	E+50Xx9JwXsrzZo5wA1Zv7g2gUjCzkZpzgUyEGczIthhBPcUWrdB49MBd0Ca6NST
	SGBN/vBCq1/FTd7zuwG4UvN7ODNOwbXV4hVvPDuO1olYjKeDfDdZiCOerra1OsLw
	z+quMwpVo8W1eaDd1WCU=
X-Virus-Scanned: Debian amavisd-new at animate.de
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-9999 required=5 WHITELISTED tests=[]
	autolearn=unavailable
Received: from mxh1.animate.de ([127.0.0.1])
	by localhost (mxh1.animate.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mllmCeR6p_f8 for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Sep 2020 14:45:06 +0200 (CEST)
Received: from mail.uib.gmbh (unknown [217.19.180.154])
	by mxh1.animate.de (Postfix) with ESMTP id DFDE19FCAD
	for <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2020 14:45:06 +0200 (CEST)
Received: from groupware.mz.uib.gmbh (localhost [127.0.0.1])
	by mail.uib.gmbh (Postfix) with ESMTP id CAFF61000B5
	for <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2020 14:45:06 +0200 (CEST)
Received: by groupware (kopano-spooler) with MAPI; Fri, 25 Sep 2020 14:45:06
 +0200
Subject: where to find mkfs.ntfs ?
From: "Mathias Radtke" <m.radtke@uib.de>
To: =?us-ascii?Q?bitbake-devel=40lists=2Eopenembedded=2Eorg?=
  <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Sep 2020 12:45:06 +0000
Mime-Version: 1.0
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.16
Message-Id: <kcEE.ZOfbFqNNSymtV0U67GQmfg.ALXVsTmT1gE@groupware.mz.uib.gmbh>
Content-Type: multipart/alternative; 
 boundary="=_ipurGMWcCB+qauFM7kKqhWyUn6Pn12bIEk-4okqaEGs5pKZG"

--=_ipurGMWcCB+qauFM7kKqhWyUn6Pn12bIEk-4okqaEGs5pKZG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi
I am building a bootimage with yocto(poky).

Currently I am trying to find a package that provides mkfs.ntfs as we nee=
d it to partition a disk that should contain a WinPE partition.
Any suggestion which package it is=3F

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

--=_ipurGMWcCB+qauFM7kKqhWyUn6Pn12bIEk-4okqaEGs5pKZG
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://ww=
w.w3.org/TR/html4/loose.dtd"><html>
<head>
  <meta name=3D"Generator" content=3D"Kopano WebApp v4.3.2950+139.1">
  <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8=
">
  <title>where to find mkfs.ntfs =3F</title>
</head>
<body>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;">Hi<br />I am building a bootimage with yocto(poky).<=
/p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">Currently I am trying to find a package that prov=
ides mkfs.ntfs as we need it to partition a disk that should contain a Wi=
nPE partition.<br />Any suggestion which package it is=3F<br /><br />Rega=
rds</span></p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">Mathias</span></p>
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

--=_ipurGMWcCB+qauFM7kKqhWyUn6Pn12bIEk-4okqaEGs5pKZG--
