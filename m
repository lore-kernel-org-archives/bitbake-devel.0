Return-Path: <aurelien.ridet@preciamolen.fr>
X-Greylist: delayed 2084 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 15 Feb 2016 15:49:05 UTC
Received: from emea01-am1-obe.outbound.protection.outlook.com
	(mail-am1on0146.outbound.protection.outlook.com [157.56.112.146])
	by mail.openembedded.org (Postfix) with ESMTP id E9E11731DB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Feb 2016 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=preciamolen.onmicrosoft.com; s=selector1-preciamolen-fr;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=lcZEc9s7HtDP42n1GNCxGYiREdiN42uVM8kblfcjmuI=;
	b=gBarGzWo8uyK0+0a5AkCFmLcBUEpLQjK9JeNk0LRLEco3YRE6NpmB+/ubmc1Xyb5aryeCrWnpgCuTdWP5G8u6YB53drvXU0ECqAORRPtYB8X4nCBy4T4E04ZooXCH4QTbPDK58NNxKF7f49gXPGrZ7Mi8TdsYBE7T83BuWN25hw=
Received: from AM3PR05MB546.eurprd05.prod.outlook.com (2a01:111:e400:8808::23)
	by AM3PR05MB548.eurprd05.prod.outlook.com (2a01:111:e400:880b::22)
	with Microsoft SMTP Server (TLS) id 15.1.403.16;
	Mon, 15 Feb 2016 15:14:20 +0000
Received: from AM3PR05MB546.eurprd05.prod.outlook.com
	([fe80::f51d:b10e:cbe1:892d]) by AM3PR05MB546.eurprd05.prod.outlook.com
	([fe80::f51d:b10e:cbe1:892d%15]) with mapi id 15.01.0403.019;
	Mon, 15 Feb 2016 15:14:20 +0000
From: RIDET Aurelien <aurelien.ridet@preciamolen.fr>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: can't get xserver-xorg to compile librecord.so
Thread-Index: AdFoAlXoNQSGnOtvQWedX8CYaawNrA==
Date: Mon, 15 Feb 2016 15:14:20 +0000
Message-ID: <AM3PR05MB5462A2D3FE5CDFF3094FFB4E4AC0@AM3PR05MB546.eurprd05.prod.outlook.com>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
	header.d=none; lists.openembedded.org;
	dmarc=none action=none header.from=preciamolen.fr;
x-originating-ip: [46.18.228.233]
x-microsoft-exchange-diagnostics: 1; AM3PR05MB548;
	5:5pURRSitwdcEULh/KHzU39trNkuU/QoNrvRrmu6RFQVEpGZUmTqPO9+bLelP/b3oBCSZUSCtsz8NxsjOA1Nk+2AoyBuDZbTjeFAoc+b+o3wbMrTxGrXBlDfmndg6GMjT056aEyqwOnkPyUihhfXxRA==;
	24:oHhwC01ZuvFtxZYMf48rD6e9bEhG8PLN4TDHFISDqi1op0kY+HADWFifwZWikOkKW5mWmCxPAFf2LjNuEZyn/qycvCkB+sE9ITP0eY1oQXI=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM3PR05MB548;
x-ms-office365-filtering-correlation-id: 7a62cb8a-e175-43e9-829a-08d3361aae20
x-microsoft-antispam-prvs: <AM3PR05MB548EC3EF6BCD3092ABB938AE4AC0@AM3PR05MB548.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);
	SRVR:AM3PR05MB548; BCL:0; PCL:0; RULEID:; SRVR:AM3PR05MB548; 
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(6009001)(2906002)(33656002)(19625215002)(19300405004)(87936001)(5008740100001)(50986999)(16236675004)(229853001)(11100500001)(92566002)(76576001)(5004730100002)(19580395003)(2351001)(66066001)(5002640100001)(790700001)(3846002)(6116002)(2501003)(102836003)(15975445007)(3660700001)(1220700001)(1096002)(586003)(74482002)(3280700002)(189998001)(74316001)(450100001)(40100003)(5003600100002)(54356999)(107886002)(86362001)(5250100002)(5001960100002)(110136002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM3PR05MB548;
	H:AM3PR05MB546.eurprd05.prod.outlook.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: preciamolen.fr
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2016 15:14:20.3568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9281c83e-132c-4ab8-be80-34517d7a5b70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR05MB548
X-Mailman-Approved-At: Mon, 15 Feb 2016 17:59:46 +0000
Subject: can't get xserver-xorg to compile librecord.so
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
X-List-Received-Date: Mon, 15 Feb 2016 15:49:07 -0000
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_AM3PR05MB5462A2D3FE5CDFF3094FFB4E4AC0AM3PR05MB546eurprd_"

--_000_AM3PR05MB5462A2D3FE5CDFF3094FFB4E4AC0AM3PR05MB546eurprd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear,

For x11vnc, I need librecord.so embedded on my image device, but I can't ge=
t it in any way. Tried to force -enable-record in EXTRA_OECONF, tried to ap=
pend xserver-xorg-extension-record in IMAGE_INSTALL, tried to upgrade xorg-=
server to 1.18.0, it compile but doesn't provide the file I need. And tried=
 to downgrade to 1.11.2 as it was the last version where lib were shipped w=
ithout particular configuration, but couldn't compile it (due to too much d=
ep).
I also tried to remove all extra_oeconf, without luck. In the best case I g=
ot a file librecord.la but couldn't find any way to transform it in libreco=
rd.so

Can someone help me on this ?

My device is an iMX6, on fido branch

Best regards.

Aurelien Ridet
Precia Molen.

--_000_AM3PR05MB5462A2D3FE5CDFF3094FFB4E4AC0AM3PR05MB546eurprd_
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
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial","sans-serif";
	color:#1F497D;}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FR" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">Dear,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">For x11vnc, I need librecor=
d.so embedded on my image device, but I can&#8217;t get it in any way. Trie=
d to force &#8211;enable-record in EXTRA_OECONF, tried to append xserver-xo=
rg-extension-record
 in IMAGE_INSTALL, tried to upgrade xorg-server to 1.18.0, it compile but d=
oesn&#8217;t provide the file I need. And tried to downgrade to 1.11.2 as i=
t was the last version where lib were shipped without particular configurat=
ion, but couldn&#8217;t compile it (due to too
 much dep).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">I also tried to remove all =
extra_oeconf, without luck. In the best case I got a file librecord.la but =
couldn&#8217;t find any way to transform it in librecord.so<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">Can someone help me on this=
&nbsp;?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">My device is an iMX6, on fi=
do branch<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">Best regards.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">Aurelien Ridet<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#1F497D">Precia Molen.<o:p></o:p></s=
pan></p>
</div>
</body>
</html>

--_000_AM3PR05MB5462A2D3FE5CDFF3094FFB4E4AC0AM3PR05MB546eurprd_--
