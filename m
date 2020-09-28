Received: from mxh1.animate.de (mxh1.animate.de [83.246.66.188])
 by mx.groups.io with SMTP id smtpd.web12.31025.1601276068992917848
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2020 23:54:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@uib.de header.s=uib20190118 header.b=SoIRXotr;
 spf=pass (domain: uib.de, ip: 83.246.66.188, mailfrom: m.radtke@uib.de)
Received: from localhost (localhost [127.0.0.1])
	by mxh1.animate.de (Postfix) with ESMTP id 706EFA05F6;
	Mon, 28 Sep 2020 08:54:26 +0200 (CEST)
Authentication-Results: mxh1.animate.de (amavisd-new);
	dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
	header.d=uib.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uib.de; h=
	message-id:x-mailer:content-type:content-type:mime-version:date
	:date:from:from:subject:subject:received:received:received
	:received; s=uib20190118; t=1601276066; x=1603090467; bh=1s1b1DO
	pjJr81CNuSSsXt9V/nb5YZgVAg2UHVAZMOSA=; b=SoIRXotrVImXy6owEFabc+Z
	LOsVy4JnNlGMEbQ3eOkJn1DaTGAtDlZtlTOpVrpB+hf4Xw+i0EaJYaXXJ2w6Sn85
	9NPmYLsRlMwCYUEzCtGl3OEp4v8PZ3TaiT+GYV29Cq8aC19sSHYhfmhXqxRsILrz
	WBDproT552Z3ERFUeOAc=
X-Virus-Scanned: Debian amavisd-new at animate.de
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-9999 required=5 WHITELISTED tests=[]
	autolearn=unavailable
Received: from mxh1.animate.de ([127.0.0.1])
	by localhost (mxh1.animate.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xl6gEzguLYRj; Mon, 28 Sep 2020 08:54:26 +0200 (CEST)
Received: from mail.uib.gmbh (unknown [217.19.180.154])
	by mxh1.animate.de (Postfix) with ESMTP id 1E1D0A05EF;
	Mon, 28 Sep 2020 08:54:26 +0200 (CEST)
Received: from groupware.mz.uib.gmbh (localhost [127.0.0.1])
	by mail.uib.gmbh (Postfix) with ESMTP id DFD531000B5;
	Mon, 28 Sep 2020 08:54:25 +0200 (CEST)
Received: by groupware (kopano-spooler) with MAPI; Mon, 28 Sep 2020 08:54:25
 +0200
Subject: Re: [bitbake-devel] where to find mkfs.ntfs ?
From: "Mathias Radtke" <m.radtke@uib.de>
To: "Khem Raj" <raj.khem@gmail.com>
Cc: =?us-ascii?Q?bitbake-devel=40lists=2Eopenembedded=2Eorg?=
  <bitbake-devel@lists.openembedded.org>
Date: Mon, 28 Sep 2020 06:54:25 +0000
Mime-Version: 1.0
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.16
Message-Id: <kcEE.eVvSig05RiSgQm5eHzccAg.gCapM2SV1gE@groupware.mz.uib.gmbh>
Content-Type: multipart/alternative; 
 boundary="=_xyosohtfERZfordUEXfep5PVfEcmaXpe6+ZVG045Cl8waKuJ"

--=_xyosohtfERZfordUEXfep5PVfEcmaXpe6+ZVG045Cl8waKuJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi







there is meta-filesystems/recipes-filesystems/ntfs-3g-ntfsprogs/ntfs-3g-n=
tfsprogs_2017.3.23.bb
in meta-openembedded repo, which you could use

Yes I already found it and did built into my image, therefore I expected =
mkfs.ntfs to be present in the image.




but you might need to add BBCLASSEXTEND =3D "native" to make sure it can=

be built for host, if you are trying to use it during cross compiling

Will try it. I am building on x86_64 for x86_64.



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
55118 MainzInternet:https


://uib.de
https://opsi.org



Geschftsfhrer: Dr. Detlef Oertel, Erol =C3=9Cl=C3=BCkmen
Handelsregister: Amtsgericht Mainz HRB 6942

--=_xyosohtfERZfordUEXfep5PVfEcmaXpe6+ZVG045Cl8waKuJ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://ww=
w.w3.org/TR/html4/loose.dtd"><html>
<head>
  <meta name=3D"Generator" content=3D"Kopano WebApp v4.3.2950+139.1">
  <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8=
">
  <title>AW: [bitbake-devel] where to find mkfs.ntfs =3F</title>
</head>
<body>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;">Hi</p>
<p style=3D"font-family: arial,helvetica,sans-serif; font-size: 11pt; pad=
ding: 0; margin: 0;"><br /></p>
<p style=3D"padding: 0; margin: 0; min-height: 11pt; font-family: arial,h=
elvetica,sans-serif; font-size: 11pt;"><span style=3D"font-size: 11pt; fo=
nt-family: arial, helvetica, sans-serif;"><br /></span></p>
<blockquote style=3D"border-left: 2px solid #325fba; padding-left: 5px; m=
argin: 0px 5px 1em;">
<div>
<pre style=3D"white-space: pre-wrap; word-wrap: break-word;">there is met=
a-filesystems/recipes-filesystems/ntfs-3g-ntfsprogs/ntfs-3g-ntfsprogs_201=
7.3.23.bb<br />in meta-openembedded repo, which you could use</pre>
</div>
</blockquote>
<p style=3D"padding: 0; margin: 0; ">Yes I already found it and did built=
 into my image, therefore I expected mkfs.ntfs to be present in the image=
=2E</p>
<blockquote style=3D"border-left: 2px solid #325fba; padding-left: 5px; m=
argin: 1em 5px;">
<div>
<pre style=3D"white-space: pre-wrap; word-wrap: break-word;"><br />but yo=
u might need to add BBCLASSEXTEND =3D "native" to make sure it can<br />b=
e built for host, if you are trying to use it during cross compiling</pre=
>
</div>
</blockquote>
<p style=3D"padding: 0; margin: 0; ">Will try it. I am building on x86_64=
 for x86_64.</p>
<p style=3D"padding: 0; margin: 0; "><span style=3D"font-size: 11pt; font=
-family: arial, helvetica, sans-serif;"><br /></span></p>
<p style=3D"padding: 0; margin: 0; "><span style=3D"font-size: 11pt; font=
-family: arial, helvetica, sans-serif;">Regards</span></p>
<p style=3D"padding: 0; margin: 0; "><span style=3D"font-size: 11pt; font=
-family: arial, helvetica, sans-serif;">Mathias</span></p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 14.6667=
px; padding: 0px; margin: 0px;"><span style=3D"font-size: 10pt; font-fami=
ly: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family: co=
urier; font-size: small;">--</span><br style=3D"font-family: courier; fon=
t-size: small;" /><span style=3D"font-family: courier; font-size: small;"=
>opsi - Open PC-Server-Integration</span><br style=3D"font-family: courie=
r; font-size: small;" /><span style=3D"font-family: courier; font-size: s=
mall;">das Open Source Client-Management-System von uib gmbh</span></span=
></p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 14.6667=
px; padding: 0px; margin: 0px;"><span style=3D"font-size: 10pt; font-fami=
ly: tahoma, arial, helvetica, sans-serif;"><br style=3D"font-family: cour=
ier; font-size: small;" /><span style=3D"font-family: courier; font-size:=
 small;">Mathias Radtke</span><br style=3D"font-family: courier; font-siz=
e: small;" /><span style=3D"font-family: courier; font-size: small;">Entw=
icklung</span><br style=3D"font-family: courier; font-size: small;" /><sp=
an style=3D"font-family: courier; font-size: small;">eMail: m.radtke@uib.=
de</span><br style=3D"font-family: courier; font-size: small;" /><span st=
yle=3D"font-family: courier; font-size: small;">Tel. +49 6131 / 27561-16<=
/span><br style=3D"font-family: courier; font-size: small;" /><span style=
=3D"font-family: courier; font-size: small;">Fax&nbsp; +49 6131 / 27561-2=
2</span><br style=3D"font-family: courier; font-size: small;" /></span></=
p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 14.6667=
px; padding: 0px; margin: 0px;"><br /></p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 14.6667=
px; padding: 0px; margin: 0px;"><span style=3D"font-size: 10pt; font-fami=
ly: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family: co=
urier; font-size: small;">uib gmbh</span><br style=3D"font-family: courie=
r; font-size: small;" /><span style=3D"font-family: courier; font-size: s=
mall;">Bonifaziusplatz 1B</span><br style=3D"font-family: courier; font-s=
ize: small;" /><span style=3D"font-family: courier; font-size: small;">55=
118 Main<a href=3D"zInternet:https">zInternet:https</a></span><br style=3D=
"font-family: courier; font-size: small;" /><br style=3D"font-family: cou=
rier; font-size: small;" /><br style=3D"font-family: courier; font-size: =
small;" /><a href=3D"https://uib.de/" target=3D"_blank" rel=3D"noopener">=
://uib.de</a><br style=3D"font-family: courier; font-size: small;" /><a h=
ref=3D"https://opsi.org/" target=3D"_blank" rel=3D"noopener">https://opsi=
=2Eorg</a><br style=3D"font-family: courier; font-size: small;" /></span>=
</p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 14.6667=
px; padding: 0px; margin: 0px;"><br /></p>
<p style=3D"font-family: arial, helvetica, sans-serif; font-size: 14.6667=
px; padding: 0px; margin: 0px;"><span style=3D"font-size: 10pt; font-fami=
ly: tahoma, arial, helvetica, sans-serif;"><span style=3D"font-family: co=
urier; font-size: small;">Geschftsfhrer: Dr. Detlef Oertel, Erol &Uuml;l&=
uuml;kmen</span><br style=3D"font-family: courier; font-size: small;" /><=
span style=3D"font-family: courier; font-size: small;">Handelsregister: A=
mtsgericht Mainz HRB 6942</span></span></p>
</body>
</html>

--=_xyosohtfERZfordUEXfep5PVfEcmaXpe6+ZVG045Cl8waKuJ--
