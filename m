Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
	by mail.openembedded.org (Postfix) with ESMTP id 643847F33B;
	Thu,  1 Aug 2019 16:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=g/LUidnpC8Qd6fhqGFc2uS1mJALqiBfgR7y8D1DGhrebbK1Wxsdo6NbKYyczBsPwzIFsdSHqGPTGBeBRY4+TqHpdEOakg6t9udtgOMSZtBd5AUdGkHIMYWLQqZOLnPIGPOus7QnUVakm1+/TG/VLhXAPCHwlYoE+tPAUlIyHyEcci4eW3s9Hk/Kea1GC6zsNIFnAvfvoftW4rF+aBStODiWoBdUhyAuZxPIcom3skohD3TsTaCABOdVy6INEF/L6Yu4hQ36y8es8GGr8Piy66JIhw5I0adUbN4y3oKDObR5e+pj/xPlXikfpDKbPfS0Yfsv5IuHmmMJ90aAkZyEP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jM8aRCw8e0nfU659hmJzuO7u5Rniehp9K3S/QEtMTXg=;
	b=f+MfYGpVNdfFh3+Qc07kpnr0OSMkSs/cqW5T2f0rCYI/KTig9ZqJJ3WMuN1L/h04UV98fMe1kPODGjj/xjLzDCUiVOkG1cdnoMbfgDM2D+CyJ9KZIXAjRm/8EJzC4U4d8MKVbfDD/CRggY8YLtKeVZfPRkXpj3ibWxPqLNTRqam/t3JzWXubbaoezOqJSzfqUi+5U22hnth+N5NIltD41I5CyWAIpAnOb/xWZjGrxhgbhJgQYMwBRQrHH5OlCkwiPqmFN2JX5NtSRPSYG5j7xoCtTOaF73mD+FG08KFGGrkQrK/iZd7vvjpzy52tr4IbWlK5yvf+zjypfd0wcZxHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=agilent.com;dmarc=pass action=none
	header.from=agilent.com;dkim=pass header.d=agilent.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jM8aRCw8e0nfU659hmJzuO7u5Rniehp9K3S/QEtMTXg=;
	b=UOE3KhzRB86n0FjySX5YHROpWsPEOsJkG4swtgINmAHLxeq7+/zawcW5oCPpQgaEs2b61fGUetZUIlyOc4jQBTsrZsW6ty3Q5IZc73tL5e3GxGqG+aPrOp1q5N2eqzSdsQz0BGTT1rCl4j+dwnWgkD2kiC5WSHJAjM3md8FZFRE=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1703.namprd12.prod.outlook.com (10.175.63.9) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.16; Thu, 1 Aug 2019 16:51:38 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::4154:e959:dc1e:4abc%9]) with mapi id 15.20.2136.010;
	Thu, 1 Aug 2019 16:51:38 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: RFC: exposing information about the SRC_URI(s)/branch via
	buildhistory (or similar mechanism)
Thread-Index: AdVIiV4bZ0XUaI6MTqawP3i+Dxw25g==
Date: Thu, 1 Aug 2019 16:51:38 +0000
Message-ID: <CY4PR12MB1653C06268B3B4B862119BE18BDE0@CY4PR12MB1653.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [68.80.99.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8efa448-1e89-498f-2406-08d716a08552
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR12MB1703; 
x-ms-traffictypediagnostic: CY4PR12MB1703:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CY4PR12MB1703814DC57CE1B421A9A91B8BDE0@CY4PR12MB1703.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(29502001)(53754006)(189003)(199004)(486006)(5660300002)(52536014)(476003)(53936002)(478600001)(2501003)(66066001)(2906002)(9686003)(55016002)(6306002)(54896002)(74316002)(68736007)(450100002)(6436002)(25786009)(76116006)(64756008)(66446008)(186003)(66476007)(66556008)(790700001)(71190400001)(71200400001)(3846002)(7696005)(6116002)(256004)(99286004)(26005)(316002)(66946007)(110136005)(7736002)(86362001)(102836004)(6506007)(81156014)(8676002)(8936002)(33656002)(14454004)(81166006);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1703;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pAygMbZltSPw1QdtPeFI6LROdkj8Iy1Nobkk9RWRHpVFU43MtoFyJ+sXXsp1b3xKsVaCMPfljVrD7M420UEeRrXtkrVPPOcG7N8pNpyAxnz4I5I5OzZoBaHz7twbafveQMYY5csFBRkVC8bpSQ1dzu4vCa5Bi5jXcgTrU8lshaHaxzj4MVsNqZVdAhqmnivJ+DFlBapzWgblTasHVwEBHsZd0/WQQ+RNk+wrQdmsxmKoR543rU+0a6P2hVPaAnep29h3EOjgFI+/MZhhQ5KwbwxC60X8CtlUTqjlCuCgxYGnkw1Ut/5WKnXGE8ZL0C1+hyxw8Cc1LEzt4avZyja6wghq9jnDz9Kvs4FlAyfC47Tkwq/VUau2hwVrqYe9pb/NGsIT+MyYYryvktY2O+7mQQWYm1BJQA17b9jrRPtBDsI=
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8efa448-1e89-498f-2406-08d716a08552
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 16:51:38.2226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chris.laplante@agilent.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
Subject: RFC: exposing information about the SRC_URI(s)/branch via buildhistory (or similar mechanism)
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
X-List-Received-Date: Thu, 01 Aug 2019 16:51:38 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1653C06268B3B4B862119BE18BDE0CY4PR12MB1653namp_"

--_000_CY4PR12MB1653C06268B3B4B862119BE18BDE0CY4PR12MB1653namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

Most of my team's closed source recipes use something like the following:

SRC_URI =3D "git://git@host/path;protocol=3Dssh;branch=3D${BRANCH}"
SRCREV =3D "${AUTOREV}"
BRANCH ??=3D "master"

(BRANCH is just a convention we use to make the SRC_URI branch easy to over=
ride.)

This makes nightly builds convenient because we always build from the lates=
t. For release versions, we can use SRCREV_pn-recipe and/or BRANCH_pn-recip=
e overrides in local.conf. We get the SRCREV overrides using buildhistory-c=
ollect-srcrevs. But buildhistory has no notion or tracking of SRC_URI or br=
anches, so currently we use a script that generates the BRANCH overrides.

I'm interesting in adding SRC_URI support to buildhistory (or a similar mec=
hanism), and would like to get some input.

Option 1) The easiest way, I think, is to just generate SRC_URI_pn- overrid=
es with variable expansion.

Option 2) I think it could be useful to introduce BRANCH as a convention. C=
urrently the "branch" SRC_URI parameter implicitly defaults to "master". I =
could foresee it implicitly defaulting to "${BRANCH}", with BRANCH ??=3D "m=
aster" to replicate existing functionality. To handle multiple source-contr=
olled SRC_URIs, we'd have to do something similar to how SRCREV has a "name=
" override. With this option, I wouldn't think it would be necessary to gen=
erate SRC_URI overrides; just BRANCH overrides.

Option 3) A combination of 1 and 2?

Looking forward to input.

Thanks,
Chris

--_000_CY4PR12MB1653C06268B3B4B862119BE18BDE0CY4PR12MB1653namp_
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
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
<p class=3D"MsoNormal">Hello all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Most of my team&#8217;s closed source recipes use so=
mething like the following:
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">SRC_URI =3D &quot;git://g=
it@host/path;protocol=3Dssh;branch=3D${BRANCH}&quot;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">SRCREV =3D &#8220;${AUTOR=
EV}&#8221;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">BRANCH ??=3D &#8220;maste=
r&#8221;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">(BRANCH is just a convention we use to make the SRC_=
URI branch easy to override.)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This makes nightly builds convenient because we alwa=
ys build from the latest. For release versions, we can use SRCREV_pn-recipe=
 and/or BRANCH_pn-recipe overrides in local.conf. We get the SRCREV overrid=
es using buildhistory-collect-srcrevs.
 But buildhistory has no notion or tracking of SRC_URI or branches, so curr=
ently we use a script that generates the BRANCH overrides.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m interesting in adding SRC_URI support to b=
uildhistory (or a similar mechanism), and would like to get some input.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Option 1) The easiest way, I think, is to just gener=
ate SRC_URI_pn- overrides with variable expansion.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Option 2) I think it could be useful to introduce BR=
ANCH as a convention. Currently the &#8220;branch&#8221; SRC_URI parameter =
implicitly defaults to &#8220;master&#8221;. I could foresee it implicitly =
defaulting to &#8220;${BRANCH}&#8221;, with BRANCH ??=3D &#8220;master&#822=
1; to replicate
 existing functionality. To handle multiple source-controlled SRC_URIs, we&=
#8217;d have to do something similar to how SRCREV has a &#8220;name&#8221;=
 override. With this option, I wouldn&#8217;t think it would be necessary t=
o generate SRC_URI overrides; just BRANCH overrides.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Option 3) A combination of 1 and 2?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Looking forward to input.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB1653C06268B3B4B862119BE18BDE0CY4PR12MB1653namp_--
