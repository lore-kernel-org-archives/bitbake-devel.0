Return-Path: <Jack.Gatrost@atlascopco.com>
X-Greylist: delayed 3618 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 27 Dec 2017 10:18:35 UTC
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
	(mail-am5eur02hn0202.outbound.protection.outlook.com [104.47.4.202])
	by mail.openembedded.org (Postfix) with ESMTP id EBF6E605C2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Dec 2017 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlascopco.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=ULt9y016UtXbMW/pIFKRmmQni6iyLbxQ7yIAKzXSnJE=;
	b=RpMXj71Lpsg0tDNjVs8hIIBPqw7xVbHcbYMnDLxz10i5HX+te9e4r+VePehfAXAQYDTNRdw1Hz0o4IS9HHMKMLaFBv9gsn0RKhBsxRVUcmWmzKTYuA5hgjj0GR2JW8PyxZHEIaMv9VOANb+70j8WRCIUOK6+34DJ6pW70oMFYWU=
Received: from AM6PR0302MB3174.eurprd03.prod.outlook.com (52.133.11.29) by
	AM6PR0302MB3174.eurprd03.prod.outlook.com (52.133.11.29) with Microsoft
	SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
	15.20.345.14; Wed, 27 Dec 2017 08:45:31 +0000
Received: from AM6PR0302MB3174.eurprd03.prod.outlook.com
	([fe80::252a:9fb3:38ec:14b]) by
	AM6PR0302MB3174.eurprd03.prod.outlook.com
	([fe80::252a:9fb3:38ec:14b%13]) with mapi id 15.20.0345.017;
	Wed, 27 Dec 2017 08:45:31 +0000
From: Jack Gatrost <Jack.Gatrost@atlascopco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Link in bitbake-user-manual hacked
Thread-Index: AdN8F/Dwa30dIdZfQi2A+fKIrmi0ew==
Date: Wed, 27 Dec 2017 08:45:31 +0000
Message-ID: <AM6PR0302MB3174B86AD7DF73445992CBC9EB070@AM6PR0302MB3174.eurprd03.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Jack.Gatrost@atlascopco.com; 
x-originating-ip: [95.116.226.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0302MB3174;
	6:DI/SgmtZPpV41Bt9gaXIDmWtlkV9XM8MN/vKGBGcn8TiBc0nZGwKzEdhn2fXvjyAc3BzvNrc/Z3JmtAXDdHaw2p74ZeMaD2A0uAcErzm/qqRxnkEEmBV7SdPhbFiNZjai2zKdgAsicp7Nr9TPXt+HAFltOggitAcQIhIZBW1QEJAZqX8EyEtkyVAyvlVpfH3DihfvbroeJ4gomCxQExtigZmUluyUJUdybvxEpGZWcBU/AGRoeGx4yY6TL9IzEorRwVDzpLWMOj2CD3rebHsem9m3bxaAvLV1qxVZX12aymm0BCtkN9K+zmDdKhz14j5GOgdTVLAZvYCPD9+lrXj5CCP1Y8QWQBflOnGgeHZ3v8dYYufACHhShwmysimUug9KgX8WwHZ2lbETcD4fmugkQ==;
	5:uf91StoiSUbjm/LoFiTBzdC5yea9sHZvKc/tM9kl/3MLgdi0TuxCwsFzU4WsxeOFJF6ePbArhUd+7GoGHFYq1Qx2rNWkNhyKC2F0zRw/e3C5EUZ/xawuaBK7ITt5R6rxXFIeXKFeosDnu4uo6KichtgbdUNf1mHdkSNmVuL15Dk=;
	24:o7bmpRZje3zzIw8pLwgjUaM5aVVMBym4PTzyC7xdSl/3qNSH2BQI5FWYddSQPAbamKbbC/mD5aao5I/zA+a7ww==;
	7:bpD+VEZ7WyJyfYpfFRo27KmX00mYS+igc/mTG2jOucda2s6kj3NvTpXgA02QB8Jmbhm7nqE/nBK7GO9iMeYmXc8oZ+z64obMWyxaPXmIjDskRd+ouYDQGe66hyQBUPMJ8vQqCfyUQtgy+POZFUaPzsxlGZvW6m7FrFhBfiISd6B+0zntBwzPjFv3dagEWmaJWy4BMrcWOmZkKB4XK14hNSjG2aWzM17sQBpu4HSdlOWhjuSZev9qcRYzajMj9ZF/
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 0196bdd8-7e05-4c93-2142-08d54d063001
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603307)(7153060);
	SRVR:AM6PR0302MB3174; 
x-ms-traffictypediagnostic: AM6PR0302MB3174:
x-microsoft-antispam-prvs: <AM6PR0302MB317416F8E9CAEB63FF6B3996EB070@AM6PR0302MB3174.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(21748063052155);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);
	SRVR:AM6PR0302MB3174; BCL:0; PCL:0;
	RULEID:(100000803101)(100110400095); SRVR:AM6PR0302MB3174; 
x-forefront-prvs: 0534947130
x-forefront-antispam-report: SFV:SPM;
	SFS:(10009020)(979002)(396003)(366004)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(102836004)(7736002)(316002)(2906002)(99286004)(6916009)(14454004)(9326002)(966005)(55016002)(230783001)(105586002)(7696005)(2501003)(8676002)(5250100002)(81156014)(5660300001)(3660700001)(3280700002)(81166006)(68736007)(72206003)(6506007)(66066001)(97736004)(53936002)(478600001)(86362001)(74316002)(25786009)(236005)(8936002)(53376002)(9686003)(33656002)(5640700003)(54896002)(606006)(6306002)(106356001)(2900100001)(3846002)(6436002)(790700001)(6116002)(2351001)(526004002)(568214009)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1501; SCL:5; SRVR:AM6PR0302MB3174;
	H:AM6PR0302MB3174.eurprd03.prod.outlook.com; FPR:; SPF:None;
	PTR:InfoNoRecords; MX:1; A:1; LANG:en; 
received-spf: None (protection.outlook.com: atlascopco.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: bg6Nwm6UhUGyHwqMOJpHvBcuKkkaoz2VuzkABp+oZVseCTsmOhPeSWq8zHNt+FKf1fqGMYW7Po6GL8MrDXphCg==
spamdiagnosticoutput: 1:22
MIME-Version: 1.0
X-OriginatorOrg: atlascopco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0196bdd8-7e05-4c93-2142-08d54d063001
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2017 08:45:31.2534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 556e6b1f-b49d-4278-8baf-db06eeefc8e9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3174
X-Mailman-Approved-At: Thu, 28 Dec 2017 13:16:53 +0000
Subject: Link in bitbake-user-manual hacked
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
X-List-Received-Date: Wed, 27 Dec 2017 10:18:36 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM6PR0302MB3174B86AD7DF73445992CBC9EB070AM6PR0302MB3174_"

--_000_AM6PR0302MB3174B86AD7DF73445992CBC9EB070AM6PR0302MB3174_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

In the http://www.yoctoproject.org/docs/2.4/bitbake-user-manual/bitbake-use=
r-manual.html#the-hello-world-example

the link in step 7 http://hambedded.org/blog/2012/11/24/from-bitbake-hello-=
world-to-an-image/#tasks

has been hijacked by some fully irrelevant "Sunny leone Sex video download =
..." page.

Perhaps this can be fixed.

Regards,
Jack Gatrost



--_000_AM6PR0302MB3174B86AD7DF73445992CBC9EB070AM6PR0302MB3174_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:70.85pt 70.85pt 56.7pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"DE">Hello,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">In the <a href=3D"http://www.yoctoproject.org/docs/2=
.4/bitbake-user-manual/bitbake-user-manual.html#the-hello-world-example">
http://www.yoctoproject.org/docs/2.4/bitbake-user-manual/bitbake-user-manua=
l.html#the-hello-world-example</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">the link in step 7 <a href=3D"http://hambedded.org/b=
log/2012/11/24/from-bitbake-hello-world-to-an-image/#tasks">
http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/#=
tasks</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">has been hijacked by some fully irrelevant &#8220;<i=
>Sunny leone Sex video download ...</i>&#8221; page.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Perhaps this can be fixed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack Gatrost<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AM6PR0302MB3174B86AD7DF73445992CBC9EB070AM6PR0302MB3174_--
