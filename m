Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810074.outbound.protection.outlook.com [40.107.81.74])
	by mail.openembedded.org (Postfix) with ESMTP id 10A2A7E502;
	Tue, 24 Sep 2019 18:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=BlUgHM2PryGYlt92JpC46YQoYQzfAPMtaA5AQEt+OlA8Gfuv51H0MdPW3POBQFVBdBSLIzwXcq0230vO9u0YAEBzLQmYwyZgLFu6zZYNyp8xBJZzANY1rXneMxjMq/CrVAGCenZVZZcDuulmSza9iEsaIe4FMrc7TlQR9whb/Gc8ceWtCHIvwCNao3Af0JOhQtQHduphctZGKaoM60Kyd33xTLOM3UohrfH08q2llIxF60rRrDhf8++Q2z3Kffakzs4Nm8mSs9nZB+1KDMWpzZMfLZQqTFCuTLBLaQWSYTjbXklXzWFtFkg8U2UOyDbYI+6vTqHrl/EBuKJ70Y7FNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BBTaW5RhadQlorwLHRgviS6G93esjDotxMZfnASsbic=;
	b=I1506xPTiII0OVWDE/5ztOuh0sVWZmjQL77KJhIHfx2466jGUgl7lXuGw+SRZvYTmMHfAMYAVtMXVaSHbGVV/m04SI+LbxNX8eOtIdl2+nXZyVEkMFlOWL8x60wNCy6dIDgVIefMvS6oPDD7mfJy/sM/3F2tPquYP9iqiNVmTsalXqvztULvPqChGcU+qG2KQ9N4wHGTfcXNpLyEjC533fR7DpUhUANpgbIsxvyi4YvxQpO4uRZAv9o/lDF928F4Ef0JoElhKOLPMz19vkWh0foOIhZkR5ltc1wiHPW1uZBS9Lb/nkkZ59Xh3h5fwAM8Po4R4+vO6JqF62G1u0LLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BBTaW5RhadQlorwLHRgviS6G93esjDotxMZfnASsbic=;
	b=Mu/N7OhuX8KC+MA8oi/cPJ8+i1jiVdefrMY0+I67ntKazbVduTqJP2Ph+zHqGYRELxRAVRzingUBLypE3xyPuolJAn/ysmYbut8qV2yysiR55oa0KBG850MYDjg2hOMZBBr2s+TuXWXGNYshhDPZfAUVf/Uv7a18+bqbMzfXNkc=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4SPR00MB246.namprd12.prod.outlook.com (10.173.185.151) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2284.26; Tue, 24 Sep 2019 18:21:26 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::482a:ace:8e58:d90]) by CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::482a:ace:8e58:d90%12]) with mapi id 15.20.2284.023;
	Tue, 24 Sep 2019 18:21:26 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Keeping multiconfig config files in sync
Thread-Index: AdVzAyq6fYyA3QQ+TrmlUxM8RoagYQ==
Date: Tue, 24 Sep 2019 18:21:25 +0000
Message-ID: <CY4PR12MB16531DD24CCB0C838C7906608B840@CY4PR12MB1653.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 582dc2c3-35c0-49f7-8b2c-08d7411c02f1
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:CY4SPR00MB246; 
x-ms-traffictypediagnostic: CY4SPR00MB246:
x-microsoft-antispam-prvs: <CY4SPR00MB246D5240BF4429C183AD7BA8B840@CY4SPR00MB246.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(29502001)(9686003)(55016002)(54896002)(7736002)(316002)(66066001)(110136005)(7696005)(6306002)(486006)(6436002)(66446008)(64756008)(66556008)(2501003)(66946007)(76116006)(450100002)(186003)(6506007)(14454004)(86362001)(25786009)(478600001)(66476007)(74316002)(99286004)(5660300002)(256004)(81166006)(33656002)(8676002)(26005)(102836004)(81156014)(476003)(8936002)(71190400001)(3846002)(9326002)(71200400001)(790700001)(6116002)(4744005)(2906002)(52536014);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4SPR00MB246;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /TlhVX1PzN/+CFEO0Oi3H/NnsZKkV5HY4+fpfwrL58BK9DoVkV8+fqzO2AGt37ZU4EUl4OSuw9SBnp/PjLcyTsY4JYecwBjTxbH+n08IrOSSpWNJtohjWAEh4feDcUGnoLJRPVus6Mkl7i6FGuG4KwFL5ZjcFJwEvhIDl8KZ+xH6GGlZlaxb9UGoJ/MqZRlo1EtnAZGI/TB13vS6qN2/g27lpjI190BzLvRIde0NQI4J0OydwFjUjvHCzQcaJJCRGGF/mU8f5VcbzO3wp5oZqBRwyb7d3dx3ks1D/J3pIQDDp4eTDczjikdEa8r29fhyYWmRajfL10dbvO9zEK4IDbT8awXaoc2VBHVIUYgcdbKczizVW0DY7VNgfoyoidPJaQ+Cdrj7QqFQ40adX64De0uhcLWM7nWpEZIZBm6ONLw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582dc2c3-35c0-49f7-8b2c-08d7411c02f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 18:21:25.9978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxKj8PlVp3oca0w84luEG0xeoFTGFaiSUKEnfjIO7SqLcjtvXRxplqN9JZXdvapPPPPAtKLMqgd7zqRvyZEDiJ77XKLS6vl/Z9JlysWJgSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4SPR00MB246
Subject: Keeping multiconfig config files in sync
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
X-List-Received-Date: Tue, 24 Sep 2019 18:21:26 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16531DD24CCB0C838C7906608B840CY4PR12MB1653namp_"

--_000_CY4PR12MB16531DD24CCB0C838C7906608B840CY4PR12MB1653namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks to Richard and others recent hard work, multiconfig is poised to bec=
ome much more practical in YP 3.0.

One thing I'm not clear on, however, is how it will work in a team environm=
ent. If I have recipes with multiconfig dependencies, then I must ensure th=
at anyone else using those recipes has the exact same set of multiconfig co=
nfig files defined in their build/conf/multiconfig/ directory. Or at least,=
 compatible multiconfigs with matching names.

Since these files are under build/conf/, it's not immediately clear how one=
 might version control these. Unless I'm mistaken and there is a better way=
, as a workaround I will probably put the multiconfigs in a layer and instr=
uct developers to symlink build/conf/multiconfig to there.

Any insight?

Thanks,
Chris

--_000_CY4PR12MB16531DD24CCB0C838C7906608B840CY4PR12MB1653namp_
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
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
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
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks to Richard and others recent hard work, multi=
config is poised to become much more practical in YP 3.0.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">One thing I&#8217;m not clear on, however, is how it=
 will work in a team environment. If I have recipes with multiconfig depend=
encies, then I must ensure that anyone else using those recipes has the exa=
ct same set of multiconfig config files
 defined in their build/conf/multiconfig/ directory. Or at least, compatibl=
e multiconfigs with matching names.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Since these files are under build/conf/, it&#8217;s =
not immediately clear how one might version control these. Unless I&#8217;m=
 mistaken and there is a better way, as a workaround I will probably put th=
e multiconfigs in a layer and instruct developers
 to symlink build/conf/multiconfig to there.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any insight?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB16531DD24CCB0C838C7906608B840CY4PR12MB1653namp_--
