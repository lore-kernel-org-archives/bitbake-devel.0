Return-Path: <alejandr@xilinx.com>
X-Greylist: delayed 90518 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 26 Jul 2018 17:43:53 UTC
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
	(mail-bl2nam02on0055.outbound.protection.outlook.com [104.47.38.55])
	by mail.openembedded.org (Postfix) with ESMTP id 96F3E78C48
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=oEA/7HLWhcdkY9RFX3I8ZXvM8TiF6wPglmIkUrz6y+Q=;
	b=NS8/ZHTle/Xf/RYdt4NZyv8vPoR9Yky8sTFmITaaQTXjPXX79mtmHv3uf8HpvZv6ukxVr2LAnV+kNBJnUc4zPotFQpquRhWn1DKzF4cHbkpdafMzjJ+Ery7fYlaQJfGKfaC7vaJXWQkuuBOuWBhrcbc+xm8CfN8PVvPfy3o8DR8=
Received: from CY4PR02MB3334.namprd02.prod.outlook.com (10.165.89.141) by
	CY4PR02MB2390.namprd02.prod.outlook.com (10.169.182.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.995.16; Thu, 26 Jul 2018 17:10:30 +0000
Received: from CY4PR02MB3334.namprd02.prod.outlook.com
	([fe80::f910:7335:bb4b:3a9d]) by
	CY4PR02MB3334.namprd02.prod.outlook.com
	([fe80::f910:7335:bb4b:3a9d%6]) with mapi id 15.20.0973.022;
	Thu, 26 Jul 2018 17:10:30 +0000
From: Alejandro Enedino Hernandez Samaniego <alejandr@xilinx.com>
To: Harini Srowa <harini@bruviti.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Building scipy with yocto 2.2
Thread-Index: AQHUI/nucv/7Ydaow02UxzFnJ+eHBaShvmpw
Date: Thu, 26 Jul 2018 17:10:29 +0000
Message-ID: <CY4PR02MB3334C0D517A85F2F6B83CD89AC2B0@CY4PR02MB3334.namprd02.prod.outlook.com>
References: <CY1PR04MB2170674BB2E79C39F14DB4EAC7540@CY1PR04MB2170.namprd04.prod.outlook.com>
In-Reply-To: <CY1PR04MB2170674BB2E79C39F14DB4EAC7540@CY1PR04MB2170.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=alejandr@xilinx.com; 
x-originating-ip: [108.65.76.171]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR02MB2390;
	6:MhMCyXTVjoeIdX0OCk0k59lrXD+L07f04nnSwNopYj3DsEg9xPndjEQPTnVfoeKUQPwav/p2JRe1B40ng06zmCyWqz7f9ay8r3xFbZlCrH7Zbay7yyBsAPxtPagIt+8DeCsvnAS2Xu3dQ5gVpxLVFqFTYnFede/o+CGLSrC2IzMGVap4Hs04FYwrRwC0kERjHJOv4TkzAPhqRY1c7tqnjWsLWT5iNWNs1dYmJJ2AM4uBKdpJBorOtVDNvTugEaN0xbCp0aXbR/Od8B7pDaSpZ3lQ+Duz/PjLxw6HEZCoe7Vua4A3/yGgm+3GTRluXvQjnVrfp4ecw6CvWrtupT8Lor8lhadaf2WjpDlT5iLyZ6fsNAaW+v43WJ8rK3YnSQwlyY5rbdlKDj1ZYBv05jljULUm8Yfu573nP8REhMAExN4csHT90dbq1BYufZnShUne+acSy5whitvKqWj2KTaeKg==;
	5:3Ijooow3zL6P5cRaKNtlzwaHkZGd10yHu/XONKALPTo9bWfh4lHZLxLTEtKcJGm2bNSnvQtjMI6dxsvEl3mfbn5X+r4RbNCq3mAXdixTLkP+71F81+xkwIjjTf56jQoHo3PijKBxfgpmJrmvxdXAM1Od5v7Bwtug1HptSCDuc80=;
	7:o/5AIZVuYGRHhu5WXzrx17r4i3RejJ8mLcA2Nky/LrpwjdW7UatUngFmXcXL4kORZAPD70x5NWVBdqU6YDn6+zhBz3E9L8GqgjzH07LFj94B7yHr6JCoYATc+aCL8mXURBi9iIl2uN5rNhiSrG5rRvkZAtlbCLuo9Znr2VpmWo7iYhl6hBayMHRvdhqYDEV5Fsz+Gln/3NH5we251v+Ok7/r05dhXxj55jt8iABg7eP1FR/kHfPSsBrl7VjVP1vo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 108fd913-bafa-479b-0d39-08d5f31ab0ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:CY4PR02MB2390; 
x-ms-traffictypediagnostic: CY4PR02MB2390:
x-microsoft-antispam-prvs: <CY4PR02MB23901DB1B822B75BFA5D169DAC2B0@CY4PR02MB2390.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(48706222282353)(251646265452963)(264703809997249)(21748063052155);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);
	SRVR:CY4PR02MB2390; BCL:0; PCL:0; RULEID:; SRVR:CY4PR02MB2390; 
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(6436002)(53936002)(55016002)(9686003)(6306002)(54896002)(236005)(229853002)(106356001)(256004)(446003)(11346002)(105586002)(86362001)(5660300001)(81156014)(476003)(25786009)(8676002)(81166006)(6246003)(33656002)(575784001)(8936002)(2906002)(486006)(3846002)(790700001)(6116002)(606006)(97736004)(76176011)(2900100001)(186003)(53546011)(26005)(102836004)(6506007)(99286004)(7696005)(110136005)(66066001)(316002)(478600001)(2501003)(7736002)(74316002)(5250100002)(68736007)(14454004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2390;
	H:CY4PR02MB3334.namprd02.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: FEbYKd7rqgICxIMP/N6+yZo4t8Urnn6vL0Bq6fVyEJBqHw+5ULOeWhgWLooxwUU8AWjAmbHJX1tOjoNOMWWFJkP3DwzFgdeRhC57bv5lAhbmHuF4mS1CjHoPCCCgVfBGTt0+HGpekkjPfPPvOGjsRw4/i4EfYOIHVes8nWq69juVhil7VF3xdy708PeoRTbkSEdRw+gaOvIfKxzUcTJcG3uJfag0GYf6S7F58qjdu9ue3+sPgo5YOSNofKJaThHccyEpzIVyqZIJB8XfxnaO7a+Tia2EHaGB2851JS+8yONoZ0Hy+ddtJ6g34WN/ayhGSgGAvDt6D2JE5vuPREf8SqBHjbyXqOJzYPOmXJz9Y+0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108fd913-bafa-479b-0d39-08d5f31ab0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 17:10:29.9722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2390
Subject: Re: Building scipy with yocto 2.2
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
X-List-Received-Date: Thu, 26 Jul 2018 17:43:54 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR02MB3334C0D517A85F2F6B83CD89AC2B0CY4PR02MB3334namp_"

--_000_CY4PR02MB3334C0D517A85F2F6B83CD89AC2B0CY4PR02MB3334namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Harini,

This email should be sent to the meta-openembedded or the oe-core list.

Also, scipy needs a math library (BLAS,LAPACK,ATLAS), and that needs to be =
cross compiled, you have to find  (it didn't exist back when I tried this) =
or create a recipe for it.

Alejandro

From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Harini Srowa
Sent: Wednesday, July 25, 2018 3:06 AM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] Building scipy with yocto 2.2


Hi,



Has anyone tried building python-scipy with yocto 2.2. Our bitbake file loo=
ks like this:

SUMMARY =3D "Scientific Library for Python"
SECTION =3D "devel/python"
HOMEPAGE =3D "https://pypi.python.org/pypi/scipy"

LICENSE =3D "BSD-3-Clause"
LIC_FILES_CHKSUM =3D "file://LICENSE.txt;md5=3Dd0db8f4148a3d5534cfb93be78f9=
287c"

PYPI_PACKAGE=3D"scipy"

SRC_URI[md5sum] =3D "53fa34bd3733a9a4216842b6000f7316"
SRC_URI[sha256sum] =3D "87ea1f11a0e9ec08c264dc64551d501fa307289460705f6fccd=
84cbfc7926d10"

inherit pypi setuptools distutils

RDEPENDS_${PN} +=3D "python-core python-numpy-native python-distutils"
DEPENDS +=3D "python-numpy-native"

RDEPENDS_${PN}_class-native +=3D ""
BBCLASSEXTEND =3D "native nativesdk"

do_compile_prepend_class-target() {
    ${STAGING_BINDIR_NATIVE}/python-native/python setup.py build
}

Bitbake compiles the python-scipy half way and then it is not able locate l=
apack/blas resources.
My build machine is x86_64 and I am building it for arm architecture 64 bit=
.

Let me know if anyone has come across such situation.

Thanks and regards,
Harini


--_000_CY4PR02MB3334C0D517A85F2F6B83CD89AC2B0CY4PR02MB3334namp_
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"MsoNormal">Hey Harini,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This email should be sent to the meta-openembedded o=
r the oe-core list.<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
Also, scipy needs a math library (BLAS,LAPACK,ATLAS), and that needs to be =
cross compiled, you have to find &nbsp;(it didn&#8217;t exist back when I t=
ried this) or create a recipe for it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Alejandro<o:p></o:p></p>
<p class=3D"MsoNormal"><a name=3D"_MailEndCompose"><o:p>&nbsp;</o:p></a></p=
>
<span style=3D"mso-bookmark:_MailEndCompose"></span>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> bitbake-devel-bounces@lists.openembedde=
d.org [mailto:bitbake-devel-bounces@lists.openembedded.org]
<b>On Behalf Of </b>Harini Srowa<br>
<b>Sent:</b> Wednesday, July 25, 2018 3:06 AM<br>
<b>To:</b> bitbake-devel@lists.openembedded.org<br>
<b>Subject:</b> [bitbake-devel] Building scipy with yocto 2.2<o:p></o:p></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:10.0pt;color:black">Hi,</span><span style=3D"fo=
nt-size:12.0pt;color:black"><o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:10.0pt;color:black">Has anyone tried building p=
ython-scipy with yocto 2.2. Our bitbake file looks like this:</span><span s=
tyle=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">SUMMARY=
 =3D &quot;Scientific Library for Python&quot;<br>
SECTION =3D &quot;devel/python&quot;<br>
HOMEPAGE =3D &quot;<a href=3D"https://pypi.python.org/pypi/scipy">https://p=
ypi.python.org/pypi/scipy</a>&quot;<br>
<br>
LICENSE =3D &quot;BSD-3-Clause&quot;<br>
LIC_FILES_CHKSUM =3D &quot;<a href=3D"file://LICENSE.txt;md5=3Dd0db8f4148a3=
d5534cfb93be78f9287c">file://LICENSE.txt;md5=3Dd0db8f4148a3d5534cfb93be78f9=
287c</a>&quot;<br>
<br>
PYPI_PACKAGE=3D&quot;scipy&quot;<br>
<br>
SRC_URI[md5sum] =3D &quot;53fa34bd3733a9a4216842b6000f7316&quot;<br>
SRC_URI[sha256sum] =3D &quot;87ea1f11a0e9ec08c264dc64551d501fa307289460705f=
6fccd84cbfc7926d10&quot;<br>
<br>
inherit pypi setuptools distutils<br>
<br>
RDEPENDS_${PN} &#43;=3D &quot;python-core python-numpy-native python-distut=
ils&quot;<br>
DEPENDS &#43;=3D &quot;python-numpy-native&quot;<br>
<br>
RDEPENDS_${PN}_class-native &#43;=3D &quot;&quot;<br>
BBCLASSEXTEND =3D &quot;native nativesdk&quot;<br>
<br>
do_compile_prepend_class-target() {<br>
&nbsp;&nbsp;&nbsp; ${STAGING_BINDIR_NATIVE}/python-native/python setup.py b=
uild<br>
}<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">Bitbake=
 compiles the python-scipy half way and then it is not able locate lapack/b=
las resources.<br>
My build machine is x86_64 and I am building it for arm architecture 64 bit=
.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">Let me =
know if anyone has come across such situation.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">Thanks =
and regards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:black">Harini<=
o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_CY4PR02MB3334C0D517A85F2F6B83CD89AC2B0CY4PR02MB3334namp_--
