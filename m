Return-Path: <jdasilva@ciena.com>
X-Greylist: delayed 70827 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 22 Nov 2018 09:15:00 UTC
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810088.outbound.protection.outlook.com [40.107.81.88])
	by mail.openembedded.org (Postfix) with ESMTP id 31FC26C019
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2018 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cienacorp.onmicrosoft.com; s=selector1-ciena-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MlqgNWhNPe1u7vtWAmB9+MTB06PwrxXoCQxIRJ15x7s=;
	b=Pae5blEg1LWDBeO6ABBBd8q/Wpy52ofXk+M6O0L4jjgexcUjH55EyjFUUYuMp6GJBFeOp9DxAx6w6oA1t6vHhPUYWQbjXMCR9c7c6hU3Rc+mLabxVl98aDKLRF0meWrksflpaMcw7I2AfHLBYreTyQPMEvbnIJyh719uYNqHE3o=
Received: from BN1PR0401MB1060.namprd04.prod.outlook.com (10.160.79.21) by
	BN1PR0401MB0964.namprd04.prod.outlook.com (10.160.79.14) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1339.28; Tue, 20 Nov 2018 23:01:00 +0000
Received: from BN1PR0401MB1060.namprd04.prod.outlook.com
	([fe80::64a2:e9c0:aef4:1e6d]) by
	BN1PR0401MB1060.namprd04.prod.outlook.com
	([fe80::64a2:e9c0:aef4:1e6d%5]) with mapi id 15.20.1294.048;
	Tue, 20 Nov 2018 23:01:00 +0000
From: "da Silva Filho, Josias Inacio" <jdasilva@ciena.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Sumo to Thud migration: Fetch failure from gitsm.py
Thread-Index: AdSBJObPweM33ZEiQkaATXsZVx+NbA==
Date: Tue, 20 Nov 2018 23:01:00 +0000
Message-ID: <BN1PR0401MB1060D83D510823847F721347DBD90@BN1PR0401MB1060.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jdasilva@ciena.com; 
x-originating-ip: [66.48.12.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN1PR0401MB0964;
	6:1/7UMdtt3hpCcn90oaB0r2sA6pDkr+0vPjlhynUFxm1G7c3/AqRyyKZ6Boz6iG6+upDTigVn5de00wgg0a4AWu+AW0hfgDl/gmlw7dGjKIySPAm9al1iTFX5mt3an/p98q5BcMAiBsuXR5xshGzV7l72QLB3PFzJbo7hrwGX0rwPFRTYMmExvJbBcu/ZwbFrI4ni6MRM+L0gJ0BDqjMf99rV73IOknUE1EKuFK/7tI4ASLj/XeXcVnXp9ehNbBv90CF4eZ9hS/Z36deO1yZdf+bGTYLlCJLs9V5E+UyUROz5N+F+GE2xGV0PljHjQw77MIsO/LzW5uDyRb0UjFm03d7b5GnKoBwoj7C98uUXmRjcp0PeQm97PN+QNh/+29zLxplrf5SG97bnxsaejesG83swXKxay6ipztCufg+Satj7t0q7I8xC5Ax7p3wHaUA6ht54sZVsM+fqMmwFqpb6IQ==;
	5:oeeKZN9hDch9WiFEDj1HYTNgW0QYIkFIx1CFzY7jy4AzpfOR0uxZwJL3X68tn/EEXxoKSBG7UUDj9EiFlMHa+OxyRuxTlC63/I5gyVsVCC7Ll25/wXDLlxKWqcvQ/gBDRdM4TzmnU41Cv+TAVGFF/mxXf+0hMm13QtpgjtIv62Q=;
	7:/43BnhGssSVFUtKBeO76JrRGudHd+q4EVbYAtryzotfEV9xEdhofWbYdnYd2E2xxDr7P3rJHa6oeGG6JXHHfzZ1cmThXcp3gfnaJ5GzdI6i71rhX5dWfFOtdfCFcXsrzHPMqgNHTl8yE3kHg3SYx3Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5c65bb91-9247-4443-e424-08d64f3c09f7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
	SRVR:BN1PR0401MB0964; 
X-MS-TrafficTypeDiagnostic: BN1PR0401MB0964:|BN1PR0401MB0964:
x-microsoft-antispam-prvs: <BN1PR0401MB096430F4D36BB1939C18E736DBD90@BN1PR0401MB0964.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(4982022)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
	SRVR:BN1PR0401MB0964; BCL:0; PCL:0; RULEID:;
	SRVR:BN1PR0401MB0964; 
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(68736007)(81156014)(8676002)(81166006)(2906002)(8936002)(5640700003)(33656002)(606006)(790700001)(3846002)(6116002)(86362001)(5660300001)(236005)(66066001)(14454004)(53936002)(25786009)(478600001)(966005)(2501003)(6306002)(55016002)(9686003)(2351001)(54896002)(106356001)(256004)(6436002)(14444005)(2900100001)(74316002)(102836004)(186003)(26005)(105586002)(486006)(476003)(6916009)(316002)(71190400001)(97736004)(99286004)(6506007)(7696005)(7736002)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN1PR0401MB0964;
	H:BN1PR0401MB1060.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: ciena.com does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: ak+8j6/Umk3Sqo3meJKJb/6ri98vm6oy9Bdkj4BcbIgZCylBMDUKsPuEQA7BWP2/wcuWBtlKUrrDBLJlyWwiAMvPHLA1VJl+W9KwH9U3XGERE5wQTtkXES8uUj62o9mVKA/Uo37nneoKbJogWGXATsZmkohtmSdkNAksGHL+Jn8JegPo8Oshkc+38QjETiSqa9Z6REBkBNJ+8RD/Mkn77g0fGpmLhQ3lFPxKy4KFQJpVHYEGycN0qHHX1StBY4J3kHsXjFTriTrYnBLNw6fBjIeTT9d93lNXkR6hoCW4I4hSa1+Cc48T8b7VaRtZmEHNGaMnqT6NnNSWylkCS+WdE7n2djE5EyWAxEvNkgrRS8Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c65bb91-9247-4443-e424-08d64f3c09f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 23:01:00.2095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0401MB0964
X-Microsoft-Exchange-Diagnostics: 1; BN1PR0401MB0964;
	23:hIxI9YgQPPcvBWOO9fqvn19bjSnHQ0K4K0PvOwfI/Qs+Dk0OyZFVVwwTLrKn3Wh1qxDibw44d2wOzMariSEo2k4Wf3NVEYqPMiehhd8RX/IbzoHaibHyj7rRNTp8yCg8COgF0MEZVLUIQiP1xoLTTQ==
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
X-List-Received-Date: Thu, 22 Nov 2018 09:15:00 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN1PR0401MB1060D83D510823847F721347DBD90BN1PR0401MB1060_"

--_000_BN1PR0401MB1060D83D510823847F721347DBD90BN1PR0401MB1060_
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

--_000_BN1PR0401MB1060D83D510823847F721347DBD90BN1PR0401MB1060_
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
</div>
</body>
</html>

--_000_BN1PR0401MB1060D83D510823847F721347DBD90BN1PR0401MB1060_--
