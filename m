Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05CC433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:27:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.77])
 by mx.groups.io with SMTP id smtpd.web09.7284.1648564021010000479
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:27:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=1IPmxIUS;
 spf=permerror,
 err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}:
 invalid domain name (domain: agilent.com, ip: 40.107.243.77,
 mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1hSZpYDnAR9rPkWn78mdK5oxKgYOU4A00hDEVQZbbdMQdr1+MtUBIne+3kI9JI4JgDAFwICvfk6sAEco5I4gVuy0baSMqpcLECRyYsJ1fVtI0rnUOLvUjzzZ16NNlTS1//dw8z1TihqdlCW1m16GTu2HX7W5CGMiOXCp3Ds42ZhK4d9HYS1CrLwevozo2NLrpM+yTqwI5/BeV+TYeqpAxkV1tOQEgIV23Qk/OtkR7Ph2+X1OzvTieApbQKzhuwgCjqxFHaN72GPp3sdzJIHmdd63DnWE1ClOBSQqwgubScuZBHa+Q2f8A8pnW5qHQw99mkA3hgk4jbLlZ0bHzh8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX5dfh+BWNSxv2cDCZbQSkAaSYMlZ1uQkbO+kDk/aIo=;
 b=QWSyL6Ci/XiU1ej1GfjTeCfTbRsOQIBamn2vawvUerD9FWixlyKw6fAx74GCkS3saqgbgru/OCcLqUJH0LJeOZHoGmr7J9NlGqG8xuolyVynOaw0ZT4GZfeYAobLiGv2Dnw4CgyxRpf3adKJywCi02a3Dgvj1g55KyRiCYlT039koxRtIE1/u9Dx45pTrFNDAdqayftH919r1+AC6N/iB46ielGBv7mvSQe2v6DAndPVrg16w7YLoKZ+mMB5Kqg4nX0RTIbkO+c59MDFYZrHNnKAHWDOkTX4OSt85Kk0g0/swtI7L1MIzYT6wDQrnDaLiglP+UmFIoYsKH3bLuFaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX5dfh+BWNSxv2cDCZbQSkAaSYMlZ1uQkbO+kDk/aIo=;
 b=1IPmxIUSkgOqWRION1oIjTNcigzBnWq069/DR0oQUPpaKbZp/Y9DW0Rcep2xs/U21qGYtgEdfTPm+ue850WyEuLVjsFGcA4TpK4SLpkhqjIOUp4yeDBq/jt9AKf7EGntkbwGYbS0wz89jEtFnOoR1roiPNR7FqEEQolswZZWK2XmhQMD77VTPm4FU78o/b1RbckSP0e+BR5n/e3blPYUspvQ6IF41tNTKm8Dxt48RJsZssalNEycIpyrIpqwi1JTliBpceGD3WGczt0sHWMW7EViwgXqSUdRnD4NcRxhZT3aWDWdSmHKLflt2lFu3/md31heFD2iQIEIdVmUdh5J0w==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Tue, 29 Mar
 2022 14:26:58 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::f9e1:27d9:4498:2795]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::f9e1:27d9:4498:2795%6]) with mapi id 15.20.5102.022; Tue, 29 Mar 2022
 14:26:58 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: bytebraise - experimental Rust implementation of BitBake's DataSmart
 & parser
Thread-Topic: bytebraise - experimental Rust implementation of BitBake's
 DataSmart & parser
Thread-Index: AdhDeIjTwai5brEeSw6mXWbOMbkVMA==
Date: Tue, 29 Mar 2022 14:26:57 +0000
Message-ID: 
 <DM8PR12MB5430BF930602CDC35185CB7E8B1E9@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c938db2b-b6e9-4c44-ce91-08da11902ebb
x-ms-traffictypediagnostic: MN2PR12MB4142:EE_
x-microsoft-antispam-prvs: 
 <MN2PR12MB4142EE85B35CB117A128F4EB8B1E9@MN2PR12MB4142.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +dlbtD8kXxdL8VIJO/RrRCCwHNuJAMAF4v8lQP/j5Gxd63fgWUA8srU6xA/FhN0eyQZxhKhenbE6oJOU2oc9qPRglNYZuFOJ8t+e/ZCam+c/2B8ouoQFxPIS5fcari0SRUloR8FPLUfd4X2MS26YXy6fWcnCx6hNx3QHG7DG9fOOypRpJj0jeQKhHS5zKskNyWf5hmYreA777HOWDliYuWdSBiXOmwHl+fhyirtkdHb7hWzbztDJW9KhQbEyEa8sokX75Xo2kQU60ny46tnE6BXeHXL/0Afuy0GR9kfItmw6L0GuN2Zxq1WMj50aZgmnn8SYbCBdqyc2wJ/iCQOxaIH1TmBiB8xqiWBQQziFl57Ibsh5BeygAc8h4KMY5w9JPtYNSnpRtIlm1TQeviozC0hvEZPAIx7pTBG7b7tUuPyt2txDA0cD66moT0HWZsf35oudmEdwlhUc5uUwiVqCbig4aaEVhhf8MvA0MHrhaS2k3kwxUKtjLaQ58jOFQ2WCEsUhPPddMjjm+P4aZ4svGYsPrR86tPvtOgCZ89HXoKnINZNYcPtbIIsV080Hgccjm+AlL7rnQKh1epsQNvhPdZdFvoHwrpB2EIkQBhNdAjruShMfeJOFEmyp7Nqxgo9s99Wn5AVkUWGLe3AcEPsjB99Mcnm1QNlr2X18rcwO4PoMENeoFeQ+vRdW4NMMWhJBMrRhQAFiSHrmZnp0Dg2zQbJYP6EW5dIVDoEf3NeRw8H+64Mgl4IY+XGmM1UwjUygqp/ZsRYckS5zFwZvZtaDaxz7uhWW9vnLdLl7HaQriBk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(29502001)(6916009)(316002)(7696005)(6506007)(9686003)(26005)(186003)(38070700005)(71200400001)(966005)(508600001)(2906002)(166002)(5660300002)(8936002)(4744005)(55016003)(86362001)(122000001)(8676002)(66446008)(38100700002)(66476007)(66556008)(64756008)(66946007)(33656002)(76116006)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?84YIu/A96JazjoIe//Z5FPamKVvirNh/jcMMnM1lksPUM3/Y0ZGcGYkeSy+b?=
 =?us-ascii?Q?yxy1oUdm67xOf+S6GoV92we4GDSkzYFNbDRs8K5zAizvqzHzSFGBMLOtMYTx?=
 =?us-ascii?Q?qIJn0+ZGNhVdweHZfhqGt1/maVS6H2eFMLrdzAGy7+KYl+5kAd55G3VdHb/q?=
 =?us-ascii?Q?m74ToiNAbNFfFwZso3RXNDoxJy6NyoSH9/CZkWKLebqerGN1+wk1rD7026vR?=
 =?us-ascii?Q?rYcg4woiUAIh8cwgA5Q7LWzt/Y583lMqskEsyXjXusm4Wev/fzOaJ+TYN9u+?=
 =?us-ascii?Q?yK1oqFocxB9L9g4TGrtZ1URBNyO9FG2WfaFi3vlLjK8PWlsIqSyslxv4Sjal?=
 =?us-ascii?Q?B5c/CyKxeoBHzgguieVA0SvCGZ/vIkX0hI8EaGXPKre9sac7yQ5h8DBqowqf?=
 =?us-ascii?Q?+hxchYmqukeMNYyBdrMYSFoo7zqHtVP3ItT7FmhpjTITXbSR1AIqF0BuSWEa?=
 =?us-ascii?Q?HlcA7o6gGY8PWV0n+l2geKNM531kM7MGHW8hcovpiHxoRQJSuCmixAdebGEG?=
 =?us-ascii?Q?BgcbdsLigDVwPTe4nsBcCKz3a3Ju/zD92nvWtILS333VsQuwqKRiewab6T0t?=
 =?us-ascii?Q?2Y2SDDt7JR3aQcWi7gl0cEGGGcKf+kMnK9I5UXj606FTiKUYW79k4oLe15F0?=
 =?us-ascii?Q?kcvikcPpIKfZwozVTy+Vom8YypeeoGeWk+dUVZryjmDBTfsfZTgKN+GHQWg8?=
 =?us-ascii?Q?t0sfc4O3q91yyghd1Kd9vlW8KuNyvkqxVuS6XVfaGE8PJe/hmj23DFFtIkG5?=
 =?us-ascii?Q?kr9XvemL8sXPujg0JkQqIn60Cg1QKSYiauwN6OdlgCBTqsEO+KlpVJQuTjXY?=
 =?us-ascii?Q?PlGLK3EKNgqPx9xzVpCepbqTDDGwQ/uLu80uVdh8HyOhHDNYBqAtc5NwEiEa?=
 =?us-ascii?Q?oCKTqnwxkz1QVDkxmOO+5ncgvRUFJImt3gaJlWH0SDzzHwSEPYF4ea2yaogn?=
 =?us-ascii?Q?aqoALoaMjcW48A4ChrEp1Ahv8oahzgdhfBNue61BibQl/1utpo8m+3x80t/f?=
 =?us-ascii?Q?sb9Y2ozXWfwCwdW3BiHlbHsQRWAAaws1IY/XEplVbDjOcBMZaryIr6IAD6tj?=
 =?us-ascii?Q?aWOXnMscJunQ0tTiPcXi2QGy/JpZ/GHpnOqjfqheQ4jVA0111xJsfkTCWnUz?=
 =?us-ascii?Q?0j/Ff6Q5kyFUg5R+Uw+75b+KFg5RPC+VFzfwGHZLZSDM4RjOYQoJ1K3BOrHf?=
 =?us-ascii?Q?J6HFiwCzhr/QjXmvuQccKI4WrG8ZbFsSmMmTHMDIwlvmbvNk42pLFV9QcYD/?=
 =?us-ascii?Q?Wm2YeFY8gKCK7rTDvfE13vBMh04ZZaBGTLaD1A7WMSS3lFuVS2Z1gf15LNkr?=
 =?us-ascii?Q?Gp6XgFn0vimeNzwIRigEIIczWV4kTsfGP8BMmgsm+ku8egzCO/ODMq7Y8676?=
 =?us-ascii?Q?EvR8Bmvr9RQLzFCJHXYfpiCnE7512ALJQNXEopsX5yJYh/GYQ6g1o9tbC5LM?=
 =?us-ascii?Q?dDGVCctPYdHk9F9Nn4xRSO+ZI++YBCLSCqVZtUxjJ4zLgntA+nBuyboyXEwR?=
 =?us-ascii?Q?HsPZesq3T6S4cIdZOynMykooPnfhlz068ij/jEWHyGmC46+7j6qXJmL90NT1?=
 =?us-ascii?Q?ZAOz+PuiMtrN+nSDAfXFqN2bYLV/bTkQKaL2jUHj5NT/jhdMypIAFXyiba4e?=
 =?us-ascii?Q?SuGYEIbfhkbC/mvZmtj0jXHI3Nj5FbnxwaG2aPUI+royvna0kOTUx7J/+U4x?=
 =?us-ascii?Q?1vlv2lkeiI2ZQthx5jNiDhirAJ60unsje3DCzoGMg151azOdwUSJ4lKg7zQ3?=
 =?us-ascii?Q?ofb+NTdSGOakmO2f+KX/EOR3DjQtLYs=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB5430BF930602CDC35185CB7E8B1E9DM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c938db2b-b6e9-4c44-ce91-08da11902ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 14:26:58.2588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 xhqjhH0SxHrEtICXRdI3KWheJk6jfJ2BmylKs6j5szluX9A8+VgZNep4HXI2xJzPjrjXcXwHhBP2GlDaM5SRvmhVO0K/b3All2w8nSAWtSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:27:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13539

--_000_DM8PR12MB5430BF930602CDC35185CB7E8B1E9DM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

If anyone is interested, I've been working on reimplementing some parts of =
BitBake in Rust (for fun and educational purposes). The code is here: https=
://github.com/Agilent/bytebraise

For now, I've implemented DataSmart and a lexer & parser. The ability to in=
teract with Python is also prototyped.

It is all very rough and early code, but maybe someone will find it interes=
ting/useful.

Thanks,
Chris

--_000_DM8PR12MB5430BF930602CDC35185CB7E8B1E9DM8PR12MB5430namp_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If anyone is interested, I&#8217;ve been working on =
reimplementing some parts of BitBake in Rust (for fun and educational purpo=
ses). The code is here:
<a href=3D"https://github.com/Agilent/bytebraise">https://github.com/Agilen=
t/bytebraise</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For now, I&#8217;ve implemented DataSmart and a lexe=
r &amp; parser. The ability to interact with Python is also prototyped.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It is all very rough and early code, but maybe someo=
ne will find it interesting/useful.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM8PR12MB5430BF930602CDC35185CB7E8B1E9DM8PR12MB5430namp_--

