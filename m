Return-Path: <brad@evidence.com>
Received: from email.taser.com (email.taser.com [74.206.119.92])
	by mail.openembedded.org (Postfix) with ESMTP id C7F0D60D01
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Dec 2013 20:11:20 +0000 (UTC)
X-ASG-Debug-ID: 1387311081-0499bf7ce1411de0001-FWLXlK
Received: from MAGNI.atmoss (magni.atmoss [10.10.20.112]) by email.taser.com
	with ESMTP id R8DBsRoL5fY64Yvg for
	<bitbake-devel@lists.openembedded.org>;
	Tue, 17 Dec 2013 13:11:21 -0700 (MST)
X-Barracuda-Envelope-From: brad@evidence.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.20.112
Received: from TI-ODIN.tasernet.com (172.16.1.112) by email.taser.com
	(10.10.20.112) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Tue, 17 Dec 2013 13:11:20 -0700
Received: from TI-THOR.tasernet.com ([fe80::7c49:ae21:6650:2789]) by
	TI-ODIN.tasernet.com ([fe80::64ff:7320:e6e7:27c8%20]) with mapi id
	14.02.0347.000; Tue, 17 Dec 2013 13:11:19 -0700
X-Barracuda-RBL-Trusted-Forwarder: 10.10.20.112
From: Brad Litterell <brad@evidence.com>
X-Barracuda-BWL-IP: fe80::7c49:ae21:6650:2789
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Developing in Python for Bitbake
X-ASG-Orig-Subj: Developing in Python for Bitbake
Thread-Index: Ac77ZCTXIz7V07wdRpOFluYVtFjO6Q==
Date: Tue, 17 Dec 2013 20:11:18 +0000
Message-ID: <E51394554A503C4E852F9BEE46B03E8D019AC817@TI-THOR.tasernet.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.103]
MIME-Version: 1.0
X-Barracuda-Connect: magni.atmoss[10.10.20.112]
X-Barracuda-Start-Time: 1387311081
X-Barracuda-URL: http://10.10.20.59:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at taser.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
	QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=HTML_MESSAGE
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.143178
	Rule breakdown below
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	0.00 HTML_MESSAGE           BODY: HTML included in message
Subject: Developing in Python for Bitbake
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
X-List-Received-Date: Tue, 17 Dec 2013 20:11:22 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E51394554A503C4E852F9BEE46B03E8D019AC817TITHORtasernetc_"

--_000_E51394554A503C4E852F9BEE46B03E8D019AC817TITHORtasernetc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I want to create a new bbclass for some internal build tooling and am fairl=
y new to Python, so I have a couple of (hopefully quick) questions:

1. Can you recommend an Python IDE for developing for bitbake on Linux?  Th=
ere seem to be several, and if there is a consensus among the bitbake devel=
opers, I thought I'd start there.

2. Is there a list of pre-defined variables?  For example, gitpkgv.bbclass =
starts with def get_git_pkgv(d, use_tags):

"d" appears to be frequently assumed.  I'm guessing it is the same as the "=
D" variable in the recipes, but I am not sure whether there is a document t=
hat verifies this - and what else is available, or whether it is just triba=
l knowledge?

Thanks,
Brad



--_000_E51394554A503C4E852F9BEE46B03E8D019AC817TITHORtasernetc_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hi,
<div><br>
</div>
<div>I want to create a new bbclass for some internal build tooling and am =
fairly new to Python, so I have a couple of (hopefully quick) questions:</d=
iv>
<div><br>
</div>
<div>1. Can you recommend an Python IDE for developing for bitbake on Linux=
? &nbsp;There seem to be several, and if there is a consensus among the bit=
bake developers, I thought I'd start there.</div>
<div><br>
</div>
<div><span style=3D"font-size: 10pt;">2. Is there a list of pre-defined var=
iables? &nbsp;For example,&nbsp;</span><span style=3D"font-size: 10pt;">git=
pkgv.bbclass starts with&nbsp;</span><span style=3D"font-size: 10pt;">def g=
et_git_pkgv(d, use_tags):</span></div>
<div>
<div><span style=3D"font-size: 10pt;"><br>
</span></div>
<div>&quot;d&quot; appears to be frequently assumed. &nbsp;I'm guessing it =
is the same as the &quot;D&quot; variable in the recipes, but I am not sure=
 whether there is a document that verifies this - and what else is availabl=
e,&nbsp;<span style=3D"font-size: 10pt;">or whether it is just tribal
 knowledge?</span></div>
<div><span style=3D"font-size: 10pt;"><br>
</span></div>
<div><span style=3D"font-size: 10pt;">Thanks,<br>
Brad</span></div>
<div><span style=3D"font-size: 10pt;"><br>
</span></div>
<div><br>
</div>
</div>
</div>
</body>
</html>

--_000_E51394554A503C4E852F9BEE46B03E8D019AC817TITHORtasernetc_--
