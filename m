Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.88])
 by mx.groups.io with SMTP id smtpd.web12.63403.1600097964001390741
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2020 08:39:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=dVc/Re0e;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.88, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuOYgrEry6ymE3UXZ5f0/UXHjcqI6nMlLZSWiLfJkgi3ZyK5OjJ6TFAZVdfTCz4cokx1NB0M90lXQgLUbI1RJnlnIFWmQFqBxCTgF9WT40dUO1+8Z5jDR5NVoPn2pjuJg6QZKzPAxXbQbf595vNiQ29ewjRtDRVDfhBgyE1g9lhn0XTuowoVNln8QXufQAzgrTO+6nbIBdpVvLIAieEsXAB6D6sotQLNIggyViKfzMlSkHnGeDKNA/nPTj6c92V1GS9F83g47Tzjlt/HBQ/q7P5t5Yhu41XokAN22ZxpK7LQ68e18bGUcQa5HJxnmiUcyBEx8hIAFWGDitg1kpZVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qfgUA3B2SaZ5lYlyW6DRP2O39a4UUqiQUmrcYCFdSU=;
 b=F/jnLtVEh+fg3laNLJ8GvpjwrF/HyHWVBJZR86MFSJ9VUFV5TvXoJHHzmVrGPbjNqn8phF+vhBjgGLyQUDK+uRVwF6AoNidEAUnqiJWDr20kTHo5N0FVATy5+aJqVBMq2o/R2zkqi8VpfX5ZEjZUCEFo/B/dzCuigLsKYldrZkAuwS4114/YY9jbmp6sgwXqz9kRy7dtSBPkB3VoggWFUMPpxjSmSA9WGX6NXPvFSQKH53GODSdUEhFP7ZhPVz0JOtCYMFIiJYG1lbnUMLL41irMItSpIQOXW2Kv+5Ps4gDfhoKs3w6GLmRWd6XSnxpjicsTcy4Imc2ebm2tRKSSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qfgUA3B2SaZ5lYlyW6DRP2O39a4UUqiQUmrcYCFdSU=;
 b=dVc/Re0essYshtV0tnNs9iJY3L1LfbCCKOQCxoGBwqZHkxiv+dg5uNw0EovLte1Mgsn3TqeX6O1XcrblMY0N1A3nFvmgxJhuuQzQbzg1iDTGvwMvy8UtgXew1EmF9Aov+q/8kbqN5DAx/S/z+hDerh1jS0/EA6YIBMTE9osoNO+G8R0KGPReTiDQsmNXkdkc7F3VMQrViDOvf4IHLCqxI8qvjpE84kEWapRppuyv1/F7YzZcs4ltChiE6bGG4JIJmvHjHiLcPHCo/GCT/nlrhpbh2QOdnioaLHmLTN/bpPCNj/jswQ8Ka/flR1BLtWiLxJrsEGQJuSBZQ9VM+J/LJA==
Received: from MW2PR12MB2474.namprd12.prod.outlook.com (2603:10b6:907:9::13)
 by MWHPR1201MB0256.namprd12.prod.outlook.com (2603:10b6:301:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 15:39:22 +0000
Received: from MW2PR12MB2474.namprd12.prod.outlook.com
 ([fe80::4057:8e1f:56f1:9e2f]) by MW2PR12MB2474.namprd12.prod.outlook.com
 ([fe80::4057:8e1f:56f1:9e2f%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 15:39:22 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: "BitBake Development (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: 'lockfiles', 'dirs' and 'cleandirs' order of processing
Thread-Topic: 'lockfiles', 'dirs' and 'cleandirs' order of processing
Thread-Index: AdaKrMNw9HEtkwd6QWqi62VApqnf4g==
Date: Mon, 14 Sep 2020 15:39:22 +0000
Message-ID: 
 <MW2PR12MB2474F256CC7B7B3A415148CC8B230@MW2PR12MB2474.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93d3055c-d1db-4b30-bd60-08d858c45a59
x-ms-traffictypediagnostic: MWHPR1201MB0256:
x-microsoft-antispam-prvs: 
 <MWHPR1201MB02563760D4A51DABD6DA2D748B230@MWHPR1201MB0256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ymdrBXCZT1qjLfp9YoxhiqF50r3tEzlWjvymQ2dq0wQ43CDXZtz/b5kGWt+sQUqg7aorkQYFcR8hrXHHDc3iOkGpwAre0R0PRijFxe9amX6uqs8a+uVNr+4memI3ZXoPECaZmHlblNkB9mLZpng3PakAAfBnJ398S7nCDRlUng3fCuRPhncw9DW1P1GooXL0AblbMTvqgMI5IH+3o/Yi5NveD3O9bIKk27pa6L1PUFk6QNFH2LElq8+iUehEp2oJ3K0qQ47tbXc199mWcTpzji5V/KzAWhD+OavvOh50ymb1CfEenXY3H2y5nkcz2PVaRKsy73X9Ijwhpn0ndbsy7o+QAkRQxoS1TwYt4NH1xHwd2env79jhmQ6YBLk1B4OU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(29502001)(8936002)(8676002)(86362001)(4744005)(5660300002)(316002)(4326008)(9686003)(55016002)(6506007)(26005)(7696005)(186003)(478600001)(52536014)(33656002)(6916009)(66476007)(66556008)(76116006)(64756008)(66446008)(71200400001)(66946007)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 U+OwqJp8nFSBGKSnGSxKNUAsfREL1scRrmStK+1XdWcY6vo5DFC9bvg25jmAYOntxnK13EqqejtLZHPkyR8RggxUGxBE2NeY9iK6wnpnFk2Ao4+SumOzO7TifCS5oIEpebk3RWonN5GTtZIhoW0ZrC6DDxgs3ByGHqzYdKK6eUyrq7BHLeuJwynR/oROpxt+Vn+zqX/tGIvNNkQYMZqw5Bsw6caLjA5ufKhpJswtXnNXiN1I1GfP4R8MEzMcA1IY8bLY1Itg5qd4tmAp0IfBnZlPHVu/pkUVxUo91QJBRKFjZQ7kXdHvndagkb+Rsni5YU1F/A+1+giCfLeToLGp6wV5TaygFZ980Y49QQ9RM2YojnXPGrb76JSN8XaBH0vyLzwF8hpyBE5YdEwX8PDcVWy8bX2g+Wz67/0Mg0DQKaitJL2zWUIbO7au9zopO8EZ0Tt6Ye9oAbbC+NEypgE121BIuAoGHlOeZSNJnjDiGnzKXCmcXvirVs3rVwvR1T2J3OL4g/+kfdXRIgBNbCF9MC7TK5g3YENN/0r+mNLeu3K3RBPTOnkfd9/vAYkSRlK0hkIPKJVW4Exh3dvTcoXLycb/Av3jSXSR7bMdzex/npHeu2WeZKGoeKh4PY34ZzdRysQyzDK/pqVcdN/Rt3lspQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d3055c-d1db-4b30-bd60-08d858c45a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 15:39:22.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ySuuCB6r1qd8UkkPmG28BbxLwFStfap8t63b6klk0oiHPAPqnwRv2XsAay83DiNWe3Fbx48aFEYWWpjhXq7Xtc2uT9OURzQ3JR8gmxtJMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0256
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB2474F256CC7B7B3A415148CC8B230MW2PR12MB2474namp_"

--_000_MW2PR12MB2474F256CC7B7B3A415148CC8B230MW2PR12MB2474namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

While I was debugging 'cve-check' failures under multiconfig, I noticed som=
ething a bit worrying in build.py. The processing of 'dirs' and 'cleandirs'=
 varflags takes place before 'lockfiles' are acquired. While it was not res=
ponsible for any of the 'cve-check' races I found, I think it has the possi=
bility to cause nasty failures if a task uses both 'cleandirs' and 'lockfil=
es'.

I'm planning on sending a patch to delay 'dirs' and 'cleandirs' processing =
until after the 'lockfiles' are acquired. Does anyone see a problem with th=
is?

Thanks,
Chris

--_000_MW2PR12MB2474F256CC7B7B3A415148CC8B230MW2PR12MB2474namp_
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
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">While I was debugging &#8216;cve-check&#8217; failur=
es under multiconfig, I noticed something a bit worrying in build.py. The p=
rocessing of &#8216;dirs&#8217; and &#8216;cleandirs&#8217; varflags takes =
place before &#8216;lockfiles&#8217; are acquired. While it was not respons=
ible for
 any of the &#8216;cve-check&#8217; races I found, I think it has the possi=
bility to cause nasty failures if a task uses both &#8216;cleandirs&#8217; =
and &#8216;lockfiles&#8217;. &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m planning on sending a patch to delay &#821=
6;dirs&#8217; and &#8216;cleandirs&#8217; processing until after the &#8216=
;lockfiles&#8217; are acquired. Does anyone see a problem with this?<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
</div>
</body>
</html>

--_000_MW2PR12MB2474F256CC7B7B3A415148CC8B230MW2PR12MB2474namp_--
