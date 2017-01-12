Return-Path: <Javier.Viguera@digi.com>
X-Greylist: delayed 424 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Jan 2017 17:11:25 UTC
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
	[216.82.251.4])
	by mail.openembedded.org (Postfix) with ESMTP id 2DB6471C4C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 17:11:25 +0000 (UTC)
Received: from [216.82.249.131] by server-4.bemta-12.messagelabs.com id
	5A/80-01710-517B7785; Thu, 12 Jan 2017 17:04:21 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRWlGSWpSXmKPExsXi5LtOQFdke3m
	EwZezlhbXj4Y6MHqc27iCMYAxijUzLym/IoE14/wnvoIO+Ypfl08yNTAululi5OIQEljNKPH7
	3zk2CGcNo8TjL7OZIJwljBJ/ji9l7WLk5GATMJSY8OkTG4gtIhAk8eljCwuILSygJ7Hx2yKou
	LHEx0MX2SFsPYnr77YC1XBwsAioSlzu4QcJ8wr4Sjy9sAOsnFFAVuJL42pmEJtZQFzi1pP5TC
	C2hICAxJI955khbFGJl4//sULY8hJTPlxkhLANJVZNO8ACYUtLvOlZxwYxJ0+i4dVTJohdghI
	nZz4BqxESUJHYcOM30wRGkVlI1s1C0jILSQtEXEdiwe5PbBC2tsSyha+ZYewzBx4zIYsvYGRf
	xahenFpUllqka6aXVJSZnlGSm5iZo2toaKSXm1pcnJiempOYVKyXnJ+7iREYWwxAsIPx/wTnQ
	4ySHExKorwyW8ojhPiS8lMqMxKLM+KLSnNSiw8xynBwKEnwzt8KlBMsSk1PrUjLzAFGOUxago
	NHSYRXAiTNW1yQmFucmQ6ROsWoKCXOGwaSEABJZJTmwbXBEsslRlkpYV5GoEOEeApSi3IzS1D
	lXzGKczAqCfPGgEzhycwrgZv+CmgxE9DiizZgi0sSEVJSDYyTt1rde3F3+oVF5qe1xLPvHnvb
	nDqXv97MI/zgBTXXR/zifQWbDO/b/F8TdmTDVec0qye9rn3y925O/nit+saraSfeWJ5bXXgzc
	NWp/+tPhSXnTT8ouT3HQof3c4JZazmv3towX81fO3PuTNomP0fhavW3pAfmrbOuad9ZrM3dza
	AW/HHp4oa1SizFGYmGWsxFxYkAj0+JIScDAAA=
X-Env-Sender: Javier.Viguera@digi.com
X-Msg-Ref: server-4.tower-28.messagelabs.com!1484240660!28130243!1
X-Originating-IP: [66.77.174.16]
X-StarScan-Received: 
X-StarScan-Version: 9.1.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21032 invoked from network); 12 Jan 2017 17:04:20 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
	by server-4.tower-28.messagelabs.com with SMTP;
	12 Jan 2017 17:04:20 -0000
Received: from MTK-SMS-XCH02.digi.com (10.10.8.196) by MCL-VMS-XCH01.digi.com
	(10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.319.2;
	Thu, 12 Jan 2017 11:04:16 -0600
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MTK-SMS-XCH02.digi.com
	(10.10.8.196) with Microsoft SMTP Server (TLS) id 14.3.319.2;
	Thu, 12 Jan 2017 11:04:16 -0600
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
	DOR-VMS-XCH01.digi.com ([::1]) with mapi id 14.03.0319.002;
	Thu, 12 Jan 2017 18:04:13 +0100
From: "Viguera, Javier" <Javier.Viguera@digi.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Backport git submodules fetcher fixes
Thread-Index: AdJs9b1OSD/106AjT+abjXpMveSR3w==
Date: Thu, 12 Jan 2017 17:04:12 +0000
Message-ID: <DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8E@dor-sms-xch01.digi.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.2.55]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
MIME-Version: 1.0
Subject: Backport git submodules fetcher fixes
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
X-List-Received-Date: Thu, 12 Jan 2017 17:11:26 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8Edorsmsxch01digi_"

--_000_DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8Edorsmsxch01digi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm using bitbake 1.28 (under Yocto Jethro) and I have a problem with a git=
 repository that has nested submodules. There are a couple of commits in ve=
rsion 1.30 that fix the problem. Those commits apply cleanly with git cherr=
y-pick.

Could someone cherry-pick following commits into 1.28 branch?

In this order:

1. 54a3864246f2be0b62761f639a1d5c9407aded4f
2. dbafbe229360ffe5908b106a9c10e274712b9b17

And eventually will these late fixes make it into Yocto  Jethro branch (pok=
y.git repository)?

Thanks.

--
Javier Viguera
Software Engineer
Digi International(r) Spain S.A.U.



--_000_DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8Edorsmsxch01digi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:70.85pt 85.05pt 70.85pt 85.05pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I'm using bitbake 1.28 (under Yocto Jethro) and I ha=
ve a problem with a git repository that has nested submodules. There are a =
couple of commits in version 1.30 that fix the problem. Those commits apply=
 cleanly with git cherry-pick.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could someone cherry-pick following commits into 1.2=
8 branch?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In this order:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">1. 54a3864246f2be0b62761f639a1d5c9407aded4f<o:p></o:=
p></p>
<p class=3D"MsoNormal">2. dbafbe229360ffe5908b106a9c10e274712b9b17<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">And eventually will these late fixes make it into Yo=
cto &nbsp;Jethro branch (poky.git repository)?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">Javier Viguera<o:p></o:p></p>
<p class=3D"MsoNormal">Software Engineer<o:p></o:p></p>
<p class=3D"MsoNormal">Digi International&reg; Spain S.A.U. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8Edorsmsxch01digi_--
