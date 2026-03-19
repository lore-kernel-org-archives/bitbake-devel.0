Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C11088E6B
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 03:04:01 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3043.1773889435611693581
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Mar 2026 20:03:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=QTgVnRuM;
 spf=pass (domain: axis.com, ip: 52.101.83.70, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxpFQUVbPP7XsLveoEoxDSp2ab7B4zoAM/SXCLBktPWLYld3vFYX7d8yFeuOdorFimhjWDV7fUEb7l/afGDnPPE8G+bmnPVFL6pD6mJyCqzT7JOzuNtr5cozUyO0gmC0VobmwYPjAea40mtVn3F/85lFgFqRU1DpesYqi/oNYe/NvVHPMRK/PddUOmlNjGhdRtkxJX8Blg7RmVBcp2OaQIIeds1J0VycUKY5e2Vm5ZxZvVRrUNXRq88LiUnY4TqN0mMlx7FK0nNq4LzehwoRAM4VAyw/ulB2/RQZ+gBg3BS+shndvAzW1WKSe5f1WfUUC5ixxNhQY7oRzHpkDYKK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhjl1oHgHN8/+PIiFTJcFhZ6jFYjUGbmRIiNvjzs9+A=;
 b=EiiCD0BSsAizzaVtA74bsu26FnGtFE5VLKsKvxsFL0Ze0aEAxh/AvWCM8Mc54G2e76b3TSChqaX+zEUmlDr/8hoCDoJ7QZDzlRfmJhtp7qyj318g6JIhwBiLsM7NjzMRN6a26HRX2MtAfJSSS60oXLE08KxUc/dJv/X5fptFgbgADGpFm4P+OYW4CN8i760boBsVop+HkMXmC6B90hMVVb8ofkk70MfTV4QLDuUxXBEoudpZP+S/O1ZCAQaVX6d8Eha133QFa/Wn8vG5bqjJTG707Zw2s7j//2ss/ByDIwTRbaDA57/VYR8boQO82ZNZN83XwtzrWBEDPiXS25UE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhjl1oHgHN8/+PIiFTJcFhZ6jFYjUGbmRIiNvjzs9+A=;
 b=QTgVnRuMEUgVvTiV4zF9LGbWrWyGJYh+rne6Aowi0x4QeT+vd4Zo2wdE95rTPK7eZAUW5v1GJlTcZrMQRbO5+mx3RqFIZuBalfl4tw0zcjJlk+3bozeh2qG5OXPEJWvBJm88oXVEltTND122ZaSBH2+G2PfM2Fm0zRIFAL26P9c=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS2PR02MB10314.eurprd02.prod.outlook.com (2603:10a6:20b:62f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Thu, 19 Mar
 2026 03:03:50 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 03:03:50 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [meta-oe][PATCH] cjose: Remove PV
Thread-Topic: [bitbake-devel] [meta-oe][PATCH] cjose: Remove PV
Thread-Index: AQHct0WdkyXJDQJPukCmjF1/8lch87W1K1pg
Date: Thu, 19 Mar 2026 03:03:50 +0000
Message-ID: 
 <DB5PR02MB1021318961F19BE556B1E36D3EF4FA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <189E1C231988CB99.2964266@lists.openembedded.org>
In-Reply-To: <189E1C231988CB99.2964266@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS2PR02MB10314:EE_
x-ms-office365-filtering-correlation-id: 1a0c5cc7-d639-40e5-77d8-08de8564258e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003|7053199007;
x-microsoft-antispam-message-info: 
 Pt989dtnHMI9DnOexCKS/Phy9O/f0d1w0yBiCADseFDLrheFa55swkg8xMoF7sJyRroy809bT+QroRu3bGdGwbEHImxhKVRjIxMbHk0an4QlIX6YvT/ekFy76+JgsJ52rB3SRY582pH8umsvTSK1YTV+DMOoTkpYay/MPNtFKDUS8a4TTyVrLlVKKdm/UzhpZi7DSRCKXIaNYmhUr5CcMISXyDKDnKYJTPG1LDopM19NZ35gqyoDElzDPRmgsU/ufFyzqv/F97zL/XVgfJkIygbrwPJRffEDT105BIQQ0e2HwWfPNnAFgy8g2jtbZ0GLCS5e/KLvvu+5MI1idF9tp/l6nlOdIBiVxwtvWqy3vhfF3JHT+LkpHgidGRLTQqZVUUGn8xLAZjCC1x9VX9sTyX3p8zYsOSIBUdArRz0f9V/NCpQiB8O6DUSy09P1NzJvc6JUuuwPTfxD+rAuVSozDwAGKbpuSdNECVKM3JFca4BnGrpU4m+T4SR7T5jlQk1piYQIRcwcSlYrlCSzzpycTtEWgmgbQSkQaY0N0UCJcHzrQUQbf7v8NVBJmE8GySt1jvsQ/Vj8Z2liF5JdyyJU3U9GSjBVdux3r7JVkoL+JMaDGHAGSn4P+Dl/7wrN3w7yU0QNozw+cIRs1PsVKym/RTKqHJXc3KKddMh5z2kxqMAH8PoF2JyIybvES3f3TigLvbvdjWoie1WPT8F+rYzdpB6Bmzo5CzFcFaTiFatOvokD9SmnKsbuNwh4T1VVLOql0IWbvVU2VxUAuUDr09xqaq2wjrHuAvFKxMSNyxCtKm0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wBq6IjaMQ51kTBp5qSaW458OD0mpFfckaBFKzEIB/aWTjmS/6t3BRddjqPuc?=
 =?us-ascii?Q?MWqn+VnGfb0Lb48hXM4q3NQPCXeZ7uzatKl2nzoWdVODR7eRVnsJoY+hxT4z?=
 =?us-ascii?Q?nAnV2uANnn0Nv3SA5S2lsoZQzjIl3lJQcFcYafzg/JKW8Ggqn0kJi3lTxA8H?=
 =?us-ascii?Q?yiytmhmK2g6gNK/HZVsmK6sAZZo7U1N9BaoS9GNQZ8R+Xy9dV6It8cMbeRTH?=
 =?us-ascii?Q?h3AOr/rdxJqyWr0Sdp+r0NBcY6L8wmeBFnrvuDwvUx+gBgXN8ef53jq6hUyF?=
 =?us-ascii?Q?ypgbafstBZ76ahOTVLF2dZmZB8kQeERFyhCY24/iHkWed5zciAA0bawHz9cG?=
 =?us-ascii?Q?UHeHC38ASCKz+/J+rTjxsJFblWEJKYMnsaDtTURcyTUA9OgTLKoSi+cOvOmb?=
 =?us-ascii?Q?OyvOpHdqlWzORp+tGwvfK13ZffbGuUE0zAI5oMzgnkUJIsUSTpegW0fS/caK?=
 =?us-ascii?Q?rSNrqlwfrRDq4B79AG4dxdFmiPWMBNx4O8psMf2arxdAhyuZdeE4FXoZJnGX?=
 =?us-ascii?Q?/PZutTpelm24yNKkUOz+xnUFnqcCr7dGTTroo+jMDVy51dp9o0Qrm3BmlSpZ?=
 =?us-ascii?Q?VJR+o39P5lkvTt24DOhcvEANJcrRyvr6dy2r4SZJni6T/yn/sPAe4Nl7N/WA?=
 =?us-ascii?Q?kAxABUAzkvRb1yzgcMNvaig8jKdzaBSBNwasgXhTLBRyq97m2BbOdxKnO9Ru?=
 =?us-ascii?Q?XdsMKAUiGVEvlh7smAasEf6J5HMuJDhGVIPF68gp5JcmtJCRYytbOB/RbKuD?=
 =?us-ascii?Q?QRb5JtA/BBV8Y66VXZ1jqItMmg/pFMHQLqX/wGebHCmz7OOsBe3XTPIG/nl5?=
 =?us-ascii?Q?IMhmjYtBV+YHwfovCgyol18/yN+aTFVaN8z2M3d+dydiEz/RMXqHase1Hr2P?=
 =?us-ascii?Q?3gx9XH79xd0MTI9U2N5Jo7i9PuE1NMI/XqWRj9cCgaJFhrfWxvtHbral573q?=
 =?us-ascii?Q?IlAah/+E9/HUnKZ9UIGD7bim0QyT/N+HTC0Kj2LCFyiJKnpDjslfNEBTHlB9?=
 =?us-ascii?Q?2H77H3820TGUCPg7rCEMvvkQfNm3A3boBYy3EVFp9Iut45hGr6yRoibdYKSh?=
 =?us-ascii?Q?sOJEVhKnNpvojZe1haC2NwkyIiU5Q7tE3UcGuYWHvjSbOYJ9lt/2TJJplNzk?=
 =?us-ascii?Q?qKxMGsI2BG7nIZBN5kpjPRsHEP6fN6/8iUd6CbGjXab4pIaM4hskTlXwx9Sr?=
 =?us-ascii?Q?L4OXyLTfTfajdHd4GT7ulfSqD9FJhTImA07k0sd2Cmdmv8NIGwaw6eOQs3DF?=
 =?us-ascii?Q?p75aevvsY2i24MWN7rQ3zlJwX1udCXK1XMIeoE8vWXyIdaPyLe7prrZwJYsK?=
 =?us-ascii?Q?qZzBU2T/ByJgbH0ESXBkqSBP8po6tIl9C5YG5OHyLyQ96JQ75pAk4WigXG4p?=
 =?us-ascii?Q?3m6FjOsuzL/5SIB3MbKEGAfwrR7fPLpdv5i31EoiEXbk65D1TXzl6DAV1pd4?=
 =?us-ascii?Q?AZiKP9FDw0g2P8UJqWizCeJgn2XR3QAMI16utko3EzlmWdzc4Jlrcv76oo+o?=
 =?us-ascii?Q?P+70yuT6co3J3RT0Juenm7blb8WDNQkXlKzc1qAPAjVPcGl7dsLooWv+zx9q?=
 =?us-ascii?Q?xYuj3HgiIxLlBiEdYzEB+tLmWreArI1VphNfpin4MPSxBxANKa+NlD3WyOXO?=
 =?us-ascii?Q?qEqiv7phMmgwYrGEffoMWvLXrCHpBZmVt0TXgHh+y9WfIDxzBH9zdOIAqPMR?=
 =?us-ascii?Q?CS85wOAnfMHIITyfhMacyar3slc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0c5cc7-d639-40e5-77d8-08de8564258e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:03:50.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPmM9bsQSoSDsrnwJFnEQwpxbQNyI3FQdxfEnxvRy7I2H8bmVjTbSH4MwsvHw5J8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10314
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 03:04:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19170

Please ignore. Wrong list.

//Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt via
> lists.openembedded.org
> Sent: den 19 mars 2026 03:10
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [meta-oe][PATCH] cjose: Remove PV
>=20
> There is no need to set PV since the version is in the recipe file name.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb b/meta-
> oe/recipes-support/cjose/cjose_0.6.2.4.bb
> index f6a5d15a9b..eb1db40705 100644
> --- a/meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb
> +++ b/meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb
> @@ -5,7 +5,6 @@ LIC_FILES_CHKSUM =3D
> "file://LICENSE;md5=3D7249e2f9437adfb8c88d870438042f0e"
>=20
>  SRC_URI =3D "git://github.com/OpenIDC/cjose;protocol=3Dhttps;branch=3Dve=
rsion-
> 0.6.2.x;tag=3Dv${PV}"
>=20
> -PV =3D "0.6.2.4"
>  SRCREV =3D "8d94c3ad3237ab6a83d2e92fa541542b1b92c023"
>=20
>  DEPENDS =3D "openssl libcheck jansson"

