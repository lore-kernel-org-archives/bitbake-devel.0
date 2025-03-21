Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BFEC36002
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 16:47:51 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.50])
 by mx.groups.io with SMTP id smtpd.web10.4575.1742575664866966358
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Mar 2025 09:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=dOmoIB9i;
 spf=pass (domain: axis.com, ip: 40.107.105.50, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv2xi9o9Mdtf3NlFSIWCbeniqiX0DsejN28SBXjyVzUtLpbs9sbyoqBCUNMYqwV89U9NuzHRLiQBEfMw9OuNShxmWUCdHE2oJPGRvawYBFYplbIlFfPsEFyzdXEE+XTv6kGagi5zl8BlWI9yEGmvDh2UsKIjGXlMka1rr29+fZnnm0fxMMRZEToFcP3rQ/Fo8O/JYbMN2Of1L5DcUO2SXoGwPgHC56ajB7z8oBl5YCR9sHPlnybpclrzsJMNs1Pm4riedHTDULANCmne8HPAOWtzlWPzzZDXDvZi2PdCX5qUPUT0K0luNdBIWcE/Kit1qaDLZ8FKttPK26iBJcMmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fakswd+0dNzujjX9stph0UGkT445Ab8NHLFYJ7caJaQ=;
 b=sQO61psIx8KK2It0msPqDNkSKtgFWSzUD0A+GTG4kxaI+LWemt/QU0/LMn/yiv2xSjlfw2ZqwoBXqIjzLHsHffC3Xw5mL6ZrAtQPyyjrqlXEUsMmv2qeMCpQZiPo8Aejonp+RbznnyKw1q6AKNP/U6FQQs85jS3LtCUgP/NnhsxkoJuL1gqoUVsBmbrAqBuvj6h4/kYTWIFBeKPIKM7lHcZGDLRF95emMdGPIQ0ofVDegUy/0O+JCmfNnajkYycVGV2U2ShnT7KLrX72QPMkuiur+gxOIVM2GXWzRSIUyXWNokAL0IfncKJNkIjnrmSmr9pyWYrvwLEKcOUvKwImuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fakswd+0dNzujjX9stph0UGkT445Ab8NHLFYJ7caJaQ=;
 b=dOmoIB9igT2VqwMg5/c3YYCbBYay2WPe0o5u2JKRy16NwhnmdQCCOEA8azMEZGaHzt8o3WxKB/ROXRN9VbgnuuEc3XZ8XKycHWqKFPNgYeNG4/8B7V6xCpcV2DEW1fR/ApzoV0zJWCed/q6kN+BuNi78yZNnZ2od/4YufOLvbkk=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AM9PR02MB7219.eurprd02.prod.outlook.com (2603:10a6:20b:3ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 16:47:41 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 16:47:41 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Christian Lindeberg <Christian.Lindeberg@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v2] fetch2/gomod: Fix mirroring problem
Thread-Topic: [bitbake-devel] [PATCH v2] fetch2/gomod: Fix mirroring problem
Thread-Index: AQHbmYGn9j0sDhbu4EOa7PwkyTki9bN9zmJQ
Date: Fri, 21 Mar 2025 16:47:41 +0000
Message-ID: 
 <DB5PR02MB1021330E9A37389FE1961E077EFDB2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250320101949.1680184-1-christli@axis.com>
In-Reply-To: <20250320101949.1680184-1-christli@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AM9PR02MB7219:EE_
x-ms-office365-filtering-correlation-id: 707c45fd-65ab-4f7f-316c-08dd68981886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?v5+Zetr4llRyR3qCKt4buPd1y81FfwyWrgha5IzJzKFSX/XxoV+UECUj+bOX?=
 =?us-ascii?Q?c16e4l29/UyapNTbi58oO4DIWYIedmMBrMRgXzeG+/dezDyfKBPc5xnXSMJh?=
 =?us-ascii?Q?g6MHjjlZaS6Ji3wpsMZHEXuL/GG6PxLprZyX1RiqMqa9J+GWF5uu9WX0vfLY?=
 =?us-ascii?Q?o7jVWLBED24sRTNzskvwiSS0gFkgCDcsqRMNPGZE/MHyY97HLFbfNq8P6uRq?=
 =?us-ascii?Q?yViK+Dz92yAE70MpiJmO+TmH8XuW69umVR0XZ4xKDNOIfE5HzYgTdWdQpdKZ?=
 =?us-ascii?Q?L+gRIMdDYr8VyxBDoEBOjVEtmWBmyB/oe6dikxFIfHUR1yA8a0AT/UaaeBgI?=
 =?us-ascii?Q?mgCR6Aml/WTNuIczKrzq+blVObSxamNK4i4NRW2UQA7lxy0JLfHHFsqXDYwM?=
 =?us-ascii?Q?XkptPOxrgVBpVfSTIXKendUfIkZ1b0+/pmD66EW+1AA9J2EPOoo+Ty5+uqAz?=
 =?us-ascii?Q?R7eJ3JjXA6Zs77K5Wl2kKTeCI2ZxdhZvpwJy/Uclnbtb9FgS+r6w6fezgkgb?=
 =?us-ascii?Q?6mXY703rGHqxeJBomElfyGQb2bIPgwMkUkl7vx2UY5mPJSSl/h7QKl0aiZ1p?=
 =?us-ascii?Q?vGh2zCxAxhaABc0ZTp5Otiv4MyTY0kbnF+rio+x+50JABpDcM52S9V1WJG4Y?=
 =?us-ascii?Q?0IgPC2FSWRbeqm8KCHAGL6HvMmnIvfVTU5UCzKD7zKtUvb81hB4+tsX0J27o?=
 =?us-ascii?Q?imo+08Cl/jYdjyslPfDrHSduCkXj47gWD25kQEWsGU0bSDqUdGavE51cFUn1?=
 =?us-ascii?Q?D8aNcvLEaqcr7M1WW321CW1OmhT3OQ9n3rvEA4XMlfqA0Pq41KppsPmwrLQu?=
 =?us-ascii?Q?Muc/oS/FEETK8tGZmrp/S4oHIDipFjtJn74dqWp2zcY64mRRyFC0k0B5DyxP?=
 =?us-ascii?Q?T9LIXXQVuijdrWrfe8tmXesrCAFpTLV7lj+JRDwXwfrJo0xorGa3SBmOUITW?=
 =?us-ascii?Q?mBNvs26ZHgcZgQZp1uyKhavkSR10xOCMV4ilF765PCj8i6vbs24RbFNAetYy?=
 =?us-ascii?Q?cSRwszKPGgldDuZw7v4OJ3EGZDBfErGeDIDvyGKUPjpcI5nDVBhXNDYSa5qy?=
 =?us-ascii?Q?AEXtc1GL3AlEwXad7Pud8LoytkfyC7mA05upfTn7i0mCYVo/hMTDJ2CeS9sZ?=
 =?us-ascii?Q?SkdE+n5U5wJPkHXTi9PU+ET9y0t07w8Qt4/SpRtdwS15RzPAu1X2Kk8cfp6F?=
 =?us-ascii?Q?+BfKT9hxQeX04IalZH+aT4dWujWJsA2PLcMPZJOcFy6ezBH/pVuCWj8hr27L?=
 =?us-ascii?Q?OwbOwSAxDdb4Yql8Mpu5IX6b9soYndC5krarPVgtcQV5l+2b5XtPLh9BlKOI?=
 =?us-ascii?Q?1i16T5OWeP1aY2x45JdCGUeY2cEvqg7F0JLCrIVhteARwJX93SHYT2nQcvMl?=
 =?us-ascii?Q?L4MdVMcawSwL40X10TCqIs4KCPytTSm4G5IoSxNMpexW1cDywSOAxKHdWe72?=
 =?us-ascii?Q?jUyGbkNHdFJV7DI0FSzAkLL7YduP8vWS?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?JjCOLkG/1YrtTVmTV0p93MjqUqf+csRE2pfi1usG8hf1CWWGeNnFoD1+/mtP?=
 =?us-ascii?Q?1wPDPbs1WnIAPN3UH0f99T7Bp63LZ1HUddyuFF8kVy5FX4yEkv2nqQ7h2Gy2?=
 =?us-ascii?Q?/RwwekM+etpcdQqloYQInWQglNfBy1mvG2Ly/IPUckiu2hShA3xud7prcbgh?=
 =?us-ascii?Q?xxDLCxXCjrLK+aRYcjOTfmrBe3hAE+ox1zimTBEYWkXWWnGkBOMEDys9fwz/?=
 =?us-ascii?Q?Q9BqEV49STIB+bZOywtHqHvLNchS6lejF2saJvlb1YUpQ5H4L0GvWtE8SLh4?=
 =?us-ascii?Q?SdRVPOaa6qUtnn31PJkKSsYSRLgcve4PWHer+hgWBacd7w8YtJtlnGEq4ivd?=
 =?us-ascii?Q?6sPeY/5Sk/At9qjQrh0AlKYSnboitQmGjOqLjHbVduTzcDXN0rGWzJhnKP/V?=
 =?us-ascii?Q?yNT25wBSjmLgspwZpKEDxuJXDj1p4dDWXXl6zOpMivmTCiQYQasSh/I5XUNP?=
 =?us-ascii?Q?7x1xhI9+Aj7Bp9G/haUNP9X8HZDHv6Qh/0dbrTzlexgmduk6Ttsz7a7ZIiiH?=
 =?us-ascii?Q?43mUKYkcZN0h7dJMWxZ4HfGtH23H40sz4GTLFTpinWMEKGBvmZeWM3ZIZKeE?=
 =?us-ascii?Q?QfjfKU5qnJID/EY3s7DoTvDTs/Sv6KGH9GPgog45bMJ5ir7+EC6GIc6t+UiC?=
 =?us-ascii?Q?H80JSxjeu2GQAk4158sG6yzA5ZUT4O25gS+6eo2yTusT6rsUT09qixkb6En7?=
 =?us-ascii?Q?baUjjt0LTxa+7E5vPPYfYN8YZLD2mAOfS+O6UvQq2kSABQQbk/kzbwTAy/3W?=
 =?us-ascii?Q?M7FsrdnAQwF/FhPPR5HN7FhpxOo+G8PPpQxSPopUNryhSUKeW23F95IayL7Q?=
 =?us-ascii?Q?D+y39lsuZtHyNY4bTUTYSzljQJSpHXT7hNHiQ0+bpmTVNA82U/Nt4EwIIcLi?=
 =?us-ascii?Q?oQqLbiQEAfrbvk/ug4JgLijh2Aij080vci8gejtEc5fFgEjDBwkiVZymFayK?=
 =?us-ascii?Q?o1KmGFtr6w0e0NtyOdqytGXz6rO+R12ml1VKIDnnoNPbh/2kLnfPKfKT+wIv?=
 =?us-ascii?Q?mB2UU6HURHoytRFcTZEX9urdSylJzrwz58oK4nPRINJVCFfl6fAP9yH4RDo4?=
 =?us-ascii?Q?bZrP64BNltIH8arztIH3z6HLHUCQ0ORghP9xDYPMAMJq8h5PIPiBlsvYz3wK?=
 =?us-ascii?Q?cZSz38pmneqJLUreY/nsE4c2zkrggSx2G121+ggPTdNOLG388RywYRqkfnaP?=
 =?us-ascii?Q?KNSZxqTRDOJzQcfvUMfdF0fz5GPGe+qMbVt2p7Q1+oV6l1YV4brk7ehKLS/P?=
 =?us-ascii?Q?FlKwmDw4K9glw5VXll5CQoMJSNHFlG/o5EDk2ce3hwcbshBpQvHCKOO7hlsz?=
 =?us-ascii?Q?pt42YJZgCzBKIAiubWK5LwL9VyA/9L5lvZaxbjwB10bikQKxnFDCBVSzJ5+3?=
 =?us-ascii?Q?Fb0IGJXrmU+qF8P4n47c+mND0gd69YBHHHJGnItzI3Rag7a2aPGaHzS/xkdp?=
 =?us-ascii?Q?TRux7itrvvsnVQzTcwvPvzA6QM4W7leXcrUyTpfv0LBiFPCGBJDgCW3kjEBR?=
 =?us-ascii?Q?6WGLolK9J31O6smhMrxizFZIiW1BkJXeYkNeaV5PRxIv/T/3JxReZroNNksE?=
 =?us-ascii?Q?xWQGwxoqaxUHYv9CGaM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707c45fd-65ab-4f7f-316c-08dd68981886
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 16:47:41.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbPNTpETu3U8kfpf51LGzwY/ugQHGDI/wrcw1HVGKTIBlyN9Udco3jT8pG6ASClW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7219
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Mar 2025 16:47:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17482

 -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Christian Lindeberg via
> lists.openembedded.org
> Sent: den 20 mars 2025 11:20
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH v2] fetch2/gomod: Fix mirroring problem
>=20
> From: Christian Lindeberg <christian.lindeberg@axis.com>
>=20
> Build the 'downloadfilename' parameter by replacing path separators in
> the module path like the git fetcher builds the mirror tar ball name.
> Copy the downloaded file in the fetcher's unpack method like the crate
> fetcher instead of calling the base fetcher's unpack method.
>=20
> Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
>=20
> Changes in V2:
> - Add the lost unpack tracer call.

The patch log should go after the --- line below as it is not supposed=20
to be part of the commit message.

>=20
> ---
>  lib/bb/fetch2/gomod.py | 35 ++++++++++++++++++++++-------------
>  lib/bb/tests/fetch.py  |  9 +++++++++
>  2 files changed, 31 insertions(+), 13 deletions(-)
>=20

//Peter

