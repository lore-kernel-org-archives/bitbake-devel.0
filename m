Return-Path: <zzebowa@hotmail.com>
X-Greylist: delayed 38077 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 06 Dec 2018 05:21:28 UTC
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
	(mail-oln040092068100.outbound.protection.outlook.com [40.92.68.100])
	by mail.openembedded.org (Postfix) with ESMTP id 8CB276B51C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Dec 2018 05:21:28 +0000 (UTC)
Received: from AM5EUR02HT073.eop-EUR02.prod.protection.outlook.com
	(2a01:111:e400:7e1c::290) by
	HE1EUR02HT079.eop-EUR02.prod.protection.outlook.com
	(2a01:111:e400:7e1d::371) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.13;
	Thu, 6 Dec 2018 01:47:19 +0000
Received: from HE1EUR02HT075.eop-EUR02.prod.protection.outlook.com
	(2a01:111:e400:7e1d::426) by
	AM5EUR02HT073.eop-EUR02.prod.protection.outlook.com
	(2a01:111:e400:7e1c::290) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.13;
	Wed, 5 Dec 2018 22:47:26 +0000
Received: from AM5EUR02HT077.eop-EUR02.prod.protection.outlook.com
	(2a01:111:e400:7e1c::383) by
	HE1EUR02HT075.eop-EUR02.prod.protection.outlook.com
	(2a01:111:e400:7e1d::426) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.13;
	Wed, 5 Dec 2018 19:17:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wCJkcOa7ql97UdIpwrLCWP3My2lWb9HIYjQ8c6BsDCU=;
	b=PVJos7jDqM2YowSL8OrlrHJWyiH0f2SfrSRZPzfIpbpMX5SybTPahVtGiGWgveLHyfCgja+O8dEOx1XhqvuMarbfdlVm0B4y16Y//i5186LIbam762NqCRMwGiA3uJvFTUFhr5VmZNJCSfN+5hDmOcLy0mtbtFzbIX8CDPNUtGnSjvA5Azl6HZi20dhyGFX/q88Q6vlXXlPBRNzQYK/hEabafi73JP0f+OAvfN4MaaqBKbeqIHhnx2jB5v3GjklDliO0dmXnQz+RPz2676jBZuXmvNBxm7WvoCdY8rTO+nOzU6gitwhHxO/l6jR7vdZFeL35q/DQmWYlV+SI9+oS6g==
Received: from AM5EUR02FT042.eop-EUR02.prod.protection.outlook.com
	(10.152.8.55) by AM5EUR02HT077.eop-EUR02.prod.protection.outlook.com
	(10.152.9.127) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.13;
	Wed, 5 Dec 2018 14:14:19 +0000
Received: from AM6PR05MB5507.eurprd05.prod.outlook.com (10.152.8.56) by
	AM5EUR02FT042.mail.protection.outlook.com (10.152.9.106) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.1404.13 via Frontend Transport; Wed, 5 Dec 2018 14:14:19 +0000
Received: from AM6PR05MB5507.eurprd05.prod.outlook.com
	([fe80::30dc:a7ac:ec4a:ccf9]) by
	AM6PR05MB5507.eurprd05.prod.outlook.com
	([fe80::30dc:a7ac:ec4a:ccf9%4]) with mapi id 15.20.1382.020;
	Wed, 5 Dec 2018 14:14:19 +0000
From: Matt Sykes <zzebowa@hotmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: iso image creation
Thread-Index: AQHUjKR0fqKnN98Zo0OPW5AbW2iRgQ==
Date: Wed, 5 Dec 2018 14:14:19 +0000
Message-ID: <AM6PR05MB550726E165A6FBFA73CEDA96B1A80@AM6PR05MB5507.eurprd05.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:5E5959AD7586B35FE9D44B0ACF403E54FDF85FF5AB2886A1D6865C53EEE6812A;
	UpperCasedChecksum:B476B1F120D77E73E40948FB7F771A424319D178B2D438342E6941FE67E9A23B;
	SizeAsReceived:6795; Count:43
x-tmn: [CjG3wyMw9VAi2C0gj4/ST9E/BceuKsR0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5EUR02HT077;
	6:cnlNFNtnpRc/JPuI1RnIjeouKppwb7m5dz9K5H7L1AR1VfVvFXA6JhRIuin2O7txD7mF/UnRV8y7x3ALf00GM7blTGiQWcsBDB1doyZrlsRSI0igy53wikVTWAA4DReiMQrFaFMWcc3kZOZT4p3M6gNI0rh9qBgN9rR5ehyhXiTFMqCAb2WyAyROKo11H5J5yomjjYaijN/rb69HcSaEdr4lT0N0HIL3W/PV3wEr2SQfIR9dxHlMXey9yvCNxq+AQsuJvzZvB6BG2VjJoJPD/gZ5gqOBwc/eCwiJRRvU93edQkmfMQLNUzA7Kbxxpcmkcv87dYrzfuy8j44paR2/PQUlebf070e3jOI9PqwiGeeF6g3gY2UJcBaoZ91bn0DBHm+Pr5iQuaOrOAP6ELyQWIKw9rCkLhf589cfqJYzxklrDUjMAs7a5n/qLiyL2L5rMCbcS+6C2skAFBYnfNp6RQ==;
	5:wd6kyvW/h099NZ42F8iU7HN8zs3HrbzSv3m1plJqw3P2IOvwq22rAm25fK2pnKnrFvn2xx30yik+6hjZ4C9K2pixyCjvq3ATW2iE5o7HUcwYNKfoudihl5WyGA0wG1wa0ED1HvJkeLoZpWrG4c1MRVWjeK+Ih923ewjtRfjq3Xg=;
	7:Z3JhJ5cBFhNuqOO2lKHdZTFwAWVazjIbR52xPEfD4WWCQvJnZVm7D9rysLSAFYfwNWLN9wDAHYIVazdEXcWB1MWXMnoEdHM/NJlhr+McahBjrDb6Dv1tdKxhokqyGHmjtchsIoCap7iKduan22rP8w==
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);
	SRVR:AM5EUR02HT077; 
X-MS-TrafficTypeDiagnostic: AM5EUR02HT077:|AM5EUR02HT077:|HE1EUR02HT075:|HE1EUR02HT075:|AM5EUR02HT073:|AM5EUR02HT073:|HE1EUR02HT079:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
	SRVR:AM5EUR02HT077; BCL:0; PCL:0; RULEID:; SRVR:AM5EUR02HT077; 
x-microsoft-antispam-message-info: TDg90l5dH4PSP3Pq4l57hlhdgSBNR4zNLb4h9E8Db+QWKFiuphPpkecMxt6NCFKC
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: b6587b75-6f1a-4db7-b0b6-5cad10ef59a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 126d73b9-dda1-498a-dabd-08d65abbf2e3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: b6587b75-6f1a-4db7-b0b6-5cad10ef59a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 14:14:19.8956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT077
X-OriginatorOrg: hotmail.com
Subject: iso image creation
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
X-List-Received-Date: Thu, 06 Dec 2018 05:21:29 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM6PR05MB550726E165A6FBFA73CEDA96B1A80AM6PR05MB5507eurp_"

--_000_AM6PR05MB550726E165A6FBFA73CEDA96B1A80AM6PR05MB5507eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all

I am new here, and havent used bitbake much, but have hit a wall trying to =
get an iso image created.   I can get vmdk images to work, but not iso.

I added this to   core-image.bb    IMAGE_FSTYPES =3D "iso tar.bz2 vmdk",  t=
he build was cleaned with -c clean and rebuilt.

The vmdk images got built but not the iso.

Can anyone point me in the right direction here, I really want to get this =
working.

Many thanks

Matt

--_000_AM6PR05MB550726E165A6FBFA73CEDA96B1A80AM6PR05MB5507eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Hi all</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
I am new here, and havent used bitbake much, but have hit a wall trying to =
get an iso image created.&nbsp; &nbsp;I can get vmdk images to work, but no=
t iso.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
I added this to&nbsp; &nbsp;core-image.bb&nbsp; &nbsp;&nbsp;IMAGE_FSTYPES =
=3D &quot;iso tar.bz2 vmdk&quot;,&nbsp; the build was cleaned with -c clean=
 and rebuilt.&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
The vmdk images got built but not the iso.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Can anyone point me in the right direction here, I really want to get this =
working.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Many thanks</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Matt</div>
</body>
</html>

--_000_AM6PR05MB550726E165A6FBFA73CEDA96B1A80AM6PR05MB5507eurp_--
