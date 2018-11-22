Return-Path: <jdasilva@ciena.com>
X-Greylist: delayed 130209 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 23 Nov 2018 02:45:04 UTC
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700064.outbound.protection.outlook.com [40.107.70.64])
	by mail.openembedded.org (Postfix) with ESMTP id 1D7D76C65F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 02:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cienacorp.onmicrosoft.com; s=selector1-ciena-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=p1meVorhv0KozZj/JT0gjxFWkQ+b9H0lbCUEmGl4gWE=;
	b=caF/Vpy4E7G6VtuOJDqnwMACFbp5PhUpkDmJvdb7dio4ZEg6qvftLgv5dWKDQO+dKitfyAZs+Oh0fVyGOQyTAcxWKQSUsuApyGYwYpBn04ayC5mztKUiJip/fxLEsSBtiPFWxOjdPtjBVKA9SCKykZ4zjER9jlmg7bCp5/xJHnw=
Received: from BY2PR0401MB1062.namprd04.prod.outlook.com (10.160.65.142) by
	BY2PR0401MB0968.namprd04.prod.outlook.com (10.160.64.151) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1361.16; Thu, 22 Nov 2018 15:31:24 +0000
Received: from BY2PR0401MB1062.namprd04.prod.outlook.com
	([fe80::71ac:592b:3289:5639]) by
	BY2PR0401MB1062.namprd04.prod.outlook.com
	([fe80::71ac:592b:3289:5639%5]) with mapi id 15.20.1339.026;
	Thu, 22 Nov 2018 15:31:24 +0000
From: "da Silva Filho, Josias Inacio" <jdasilva@ciena.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Sumo to Thud migration: Fetch failure from gitsm.py
Thread-Index: AdSCeGxGQeNgnFnkSUmdvkivwo5rPg==
Date: Thu, 22 Nov 2018 15:31:23 +0000
Message-ID: <BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0@BY2PR0401MB1062.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jdasilva@ciena.com; 
x-originating-ip: [66.48.12.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR0401MB0968;
	6:Ibs2VTi1KXvq7TDHV2GRPjG2vNTYNf5eRis186zm1wpM9BgoHVfLzvcE6wYerx2+8DnUvlqwaPfK/B8elIiwFZFx41n//8uGIdJPg2lxvfTUZh9S5z56LCycMBj7lK4juJXiuhLeHXYsOJq1fVhzj1bEgpiEHV6n4/l0WRnBZOX3poVV6ON0Hgx9cyJ3l9iPQrrkGoldCo1Ho3HRtX1b/bviFfTVuiyFpu2HZm7Pe9L/Pakji3vihUT8Fxmgo1yFCzIpo10IucAzl+Ze9m6UsuF1vZL1IAJ//YmxNqFWV8jOaDvyrOV97F2ncPtIMDfrKbkfynpunFT8szyxVe6iQb3OIXujo0UDCqasAcCGaq0poHq78WzQo7JMiIMEHVvfaSGCWCsVi4h95tftd637dJgx8elI82AewKc2SYt0Ze8RTDLx/xMgp+QbqnAGsxob94xk84x78YtA1ylYiKE0zQ==;
	5:lYJwkx6Cv0g4coHHUw+6oynMWqD5XoTMWdI+nSuHoyJWZqACPFIGbdw4ZLUSffBUK1et854KsfFkrqchBrx8DGLc6ykuOsqYw6yh3zQib7UgU8ZLSLXFl9uOPpig+2ik79HwWMLZBnTzcNlstgf8dKTdpHntpxmNzjl3Art27BA=;
	7:Lg6Gvk5YlTZ93wUaBDvybeeTnuDpKFwwL0M42hcAI+8mOmiJphVlfHtDA3POU3R4xM+hWHftdZ8RZbFyzESSb3+zZlBttP1rN3SiK64YVrxpyn0X5k5Zz1P3gkVfToOEY8nQrQeu0zDyVYFgsT3Lxg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5565edcb-8d40-4154-331f-08d6508f8fb4
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:BY2PR0401MB0968; 
X-MS-TrafficTypeDiagnostic: BY2PR0401MB0968:|BY2PR0401MB0968:
x-microsoft-antispam-prvs: <BY2PR0401MB096882C85A0FD8EF22C4BDBEDBDB0@BY2PR0401MB0968.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(4982022)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
	SRVR:BY2PR0401MB0968; BCL:0; PCL:0; RULEID:;
	SRVR:BY2PR0401MB0968; 
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(8676002)(6436002)(6116002)(3846002)(790700001)(478600001)(2906002)(68736007)(316002)(99286004)(6506007)(102836004)(8936002)(105586002)(66066001)(966005)(81156014)(81166006)(186003)(26005)(106356001)(2351001)(33656002)(7696005)(476003)(486006)(74316002)(606006)(2900100001)(86362001)(5660300001)(14454004)(14444005)(256004)(2501003)(6306002)(9686003)(54896002)(55016002)(7736002)(53936002)(97736004)(25786009)(236005)(71190400001)(71200400001)(6916009)(5640700003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR0401MB0968;
	H:BY2PR0401MB1062.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: ciena.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: JWKNBs1oPlxvReaRC2DUMgj8WRjBSR8pxVs0S3ogl+ghqe3OyFDSqZ7Hk4JE8QP0wBICKIltnoIlK6BCKdrJH7mwm66yY7rG6MIw9PQcbgIWUYjDsEeIAjzrgbpIFTpMO5/cepzsGpRdbIuzVLAi8PBNV02imwRIRDGXtFrzsM/GXoemikHK/kUOTadBna/Q+7sF6+JbUByB+VivNvxz8RVJcXfuZCnPw2PTC2VNyl/g0A2VYS/akxcM0oiUXURVhLuwP0J1wNTlacjOjMIno8PQzEPemzOydpOX9qRcuuSuOXPaZs1g6fmAMi5/JqFlbjLtKhbRZns9H214Ox38POESnXVIIsFVUpIukrZeBww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5565edcb-8d40-4154-331f-08d6508f8fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 15:31:23.9438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0401MB0968
X-Microsoft-Exchange-Diagnostics: 1; BY2PR0401MB0968;
	23:xcwRiyrJbRFFlZ5nKfqts0WOpL8NwniFMY4fqaK2d0bmmiT+W5HdCZyHhISlKCjQdPddcAQyDoje541linwpvRO1wS9lEjIBYtgbypoKcq6l0f3hpeQFOEuLFkzz+SOe0n5oeUUI6WrAJpnUDCXrwQ==
X-OriginatorOrg: ciena.com
Subject: Sumo to Thud migration: Fetch failure from gitsm.py
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
X-List-Received-Date: Fri, 23 Nov 2018 02:45:05 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0BY2PR0401MB1062_"

--_000_BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0BY2PR0401MB1062_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi folks,

I'm working on migrating my environment from Sumo to Thud. After fixing a f=
ew quirks, it seems the fetch is failing for my foo.bb which uses gitsm.

.gitmodules content in foo repo:
[submodule "common-lib"]
                path =3D common-lib
                url =3D ssh://git@<url_to_common-lib>/common-lib.git

foo.bb:
SRC_URI=3D"gitsm://git@b<url_to_foo>.git;protocol=3Dssh;branch=3Dmaster"
SRCREV=3D"f55fae9dc9b476f8ed193f15e2d5cd6747777451"

Digging inside gitsm.py it looks like module_hash is not being set correctl=
y (empty) and that causes the issue:
http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/g=
itsm.py#n87

I added the following right after line 87, so I could dump the variables co=
ntent. This is how I confirmed module_hash is empty:
raise bb.fetch2.FetchError('module: %s, submodules: %s, module_hash: %s, ba=
secmd: %s, revisions: %s, paths: %s, clonedir: %s ' % ( module, submodules,=
 module_hash, ud.basecmd, ud.revisions[name], paths[module], ud.clonedir))

And the output:
ERROR: Fetcher failure: module: common-lib, submodules: ['common-lib'], mod=
ule_hash: , basecmd: git -c core.fsyncobjectfiles=3D0, revisions: f55fae9dc=
9b476f8ed193f15e2d5cd6747777451, paths: common-lib, clonedir: /localdata/yo=
cto/downloads/git2/<foo's path>.git

Any ideas why module_hash is not being set correctly?


--_000_BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0BY2PR0401MB1062_
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
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi folks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m working on migrating my environment from S=
umo to Thud. After fixing a few quirks, it seems the fetch is failing for m=
y foo.bb which uses gitsm.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>.gitmodules content in foo repo:<o:p></o:p></b></=
p>
<p class=3D"MsoNormal">[submodule &quot;common-lib&quot;]<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path =3D common-lib<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; url =3D ssh://git@&lt;url_to_common-=
lib&gt;/common-lib.git<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal"><b>foo.bb:<o:p></o:p></b></p>
<p class=3D"MsoNormal">SRC_URI=3D&quot;gitsm://git@b&lt;url_to_foo&gt;.git;=
protocol=3Dssh;branch=3Dmaster&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">SRCREV=3D&quot;f55fae9dc9b476f8ed193f15e2d5cd6747777=
451&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Digging inside gitsm.py it looks like module_hash is=
 not being set correctly (empty) and that causes the issue:<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi=
/poky/tree/bitbake/lib/bb/fetch2/gitsm.py#n87">http://git.yoctoproject.org/=
cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/gitsm.py#n87</a><o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I added the following right after line 87, so I coul=
d dump the variables content. This is how I confirmed module_hash is empty:=
<o:p></o:p></p>
<p class=3D"MsoNormal"><b>raise bb.fetch2.FetchError('module: %s, submodule=
s: %s, module_hash: %s, basecmd: %s, revisions: %s, paths: %s, clonedir: %s=
 ' % ( module, submodules, module_hash, ud.basecmd, ud.revisions[name], pat=
hs[module], ud.clonedir))<o:p></o:p></b></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">And the output:<o:p></o:p></p>
<p class=3D"MsoNormal">ERROR: Fetcher failure: module: common-lib, submodul=
es: ['common-lib'],
<b><span style=3D"color:red">module_hash</span></b>: , basecmd: git -c core=
.fsyncobjectfiles=3D0, revisions: f55fae9dc9b476f8ed193f15e2d5cd6747777451,=
 paths: common-lib, clonedir: /localdata/yocto/downloads/git2/&lt;foo's pat=
h&gt;.git<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any ideas why module_hash is not being set correctly=
?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0BY2PR0401MB1062_--
