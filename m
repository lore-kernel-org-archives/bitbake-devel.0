Return-Path: <H.Saadat@osb-ag.de>
X-Greylist: delayed 2280 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 17 Jul 2017 12:36:10 UTC
Received: from relay02.mail-connect.net (relay02.mail-connect.net
	[80.254.138.130])
	by mail.openembedded.org (Postfix) with ESMTP id E5DC0719A8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jul 2017 12:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=osb-ag.de;
	s=mail-connect; 
	h=Content-Transfer-Encoding:Content-Type:Date:Message-ID:To:From:Subject:References:In-Reply-To:MIME-Version;
	bh=pmbJdO0cPjG73YvVHNMltM0PjvDKDfMOFWVbAp7arEs=; 
	b=ngL30us9lv0AIdFfeNOfTH5yS1VRYA3lZAzozi4CPwWN12jftmsGyNWiR21yH0qC8UVR1UwxuYQqkZv15rC1BQBkd7WORO+lh3kItHZaCdKHmy3QTWHSLWR6Em5DFBH9dbUF9JWlLaSWKBx1pNgeYGIU69xIYw+J03Npo+zj8qo=;
Received: from [80.150.110.25] (port=63931 helo=idvnotes.idvnet.de)
	by relay02.mail-connect.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.84_2 #1)
	id 1dX4fF-0007ms-Jo for bitbake-devel@lists.openembedded.org;
	Mon, 17 Jul 2017 13:58:13 +0200
MIME-Version: 1.0
X-Disclaimed: 1
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
From: Huzaifa Saadat <H.Saadat@osb-ag.de>
To: bitbake-devel@lists.openembedded.org
Message-ID: <OFBF6045D6.1B647F86-ONC1258160.00409522-C1258160.0041C102@idvnet.de>
Date: Mon, 17 Jul 2017 13:58:12 +0200
X-Mailman-Approved-At: Mon, 24 Jul 2017 13:48:57 +0000
Subject: Creating .iso Images for RCar H3
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
X-List-Received-Date: Mon, 17 Jul 2017 12:36:11 -0000
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<font face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D"2"><div>Hello Bitbake developers,</div><div><br></div><div>I have two d=
evelopment boards, a MinnowBoard and a RCar H3 Board. In MinnowBoard's Imag=
e folder (after bitbaking) I see the .hddimg .iso images. Can I create the =
same images (.hddimg .iso) for RCar H3?</div><div><br></div><div>My underst=
anding was that I need to toggle a few things in the *image*.bbclass receip=
es but they are identical for both the boards.</div><div><br></div><div>Tha=
nk you in advance.</div><div><br></div><div>Regards</div><div><br><font fac=
e=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=3D"2"><fon=
t size=3D"2" style=3D"font-family: arial, helvetica, sans-serif; box-sizing=
: inherit;">Huzaifa Saadat</font><br style=3D"font-family: arial, helvetica=
, sans-serif; box-sizing: inherit;"><font size=3D"2" style=3D"font-family: =
arial, helvetica, sans-serif; box-sizing: inherit;">Competence Center AUTOS=
AR</font><br style=3D"font-family: arial, helvetica, sans-serif; box-sizing=
: inherit;"><br style=3D"font-family: arial, helvetica, sans-serif; box-siz=
ing: inherit;"><font size=3D"2" style=3D"font-family: arial, helvetica, san=
s-serif; box-sizing: inherit;">OSB AG</font><br style=3D"font-family: arial=
, helvetica, sans-serif; box-sizing: inherit;"><font size=3D"2" style=3D"fo=
nt-family: arial, helvetica, sans-serif; box-sizing: inherit;">Theresienh=
=C3=B6he 30</font><br style=3D"font-family: arial, helvetica, sans-serif; b=
ox-sizing: inherit;"><font size=3D"2" style=3D"font-family: arial, helvetic=
a, sans-serif; box-sizing: inherit;">D-80339 M=C3=BCnchen</font><br style=
=3D"font-family: arial, helvetica, sans-serif; box-sizing: inherit;"><br></=
font><span style=3D"font-family: arial, helvetica, sans-serif;">M: 0151 113=
45439</span><font face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-s=
erif" size=3D"2"><br style=3D"font-family: arial, helvetica, sans-serif; bo=
x-sizing: inherit;"><font size=3D"2" style=3D"font-family: arial, helvetica=
, sans-serif; box-sizing: inherit;">T: +49 89 238857 590</font><br style=3D=
"font-family: arial, helvetica, sans-serif; box-sizing: inherit;"><br style=
=3D"font-family: arial, helvetica, sans-serif; box-sizing: inherit;"><font =
size=3D"2" style=3D"font-family: arial, helvetica, sans-serif; box-sizing: =
inherit;"><a href=3D"mailto:h.saadat@osb-ag.de" target=3D"=5Fblank">h.saada=
t@osb-ag.de</a></font><font face=3D"Default Sans Serif,Verdana,Arial,Helvet=
ica,sans-serif" size=3D"2"></font></font></div><div></div></font>

