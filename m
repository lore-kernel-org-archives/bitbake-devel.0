Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F3BCD6E57
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 19:03:31 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2816.1780427000967093228
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jun 2026 12:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=X6obvJlH;
 spf=pass (domain: axis.com, ip: 52.101.69.37, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZM6GVkdE74qX7GfwWBRbiKkWkHBsfm/uzqSzfkubQjdF5TJ+xteG8mWfY9q4Nvx+CIVKdohCRlsZD3OHqpxipYXiAmoEW/TVAWW2c5z+toTD4J5M2f9eEgzaylKApEPUo21vB21tVfhGkDLKPHPVC6ov4IPQ6HOSQEKT8hrVOlfJ1SIrmUzYVFXCIE5cTZgSV1alI1lAgGp7UmF1tALlxg9PjQZiisRSfsMz7NefiRYWiX/1+XSvG7E0JCny0nZF273oZPbpUUwrvZZ66NY0OLUXF6TgSU3zrIwKl08AJfr1Yxis3yaGSMUifcIT5aZVkVehBR/RYMG79odCkosgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBjmhzW+O1VNwK6D1sOQzhn+KsehFlxSunCYH8trmEE=;
 b=mKcYyES4KZsUyoxaIlNIHY/MXtnTmsSrhLrD4x6CJY9TpyT1etiXHfA6BpkPL3uBHwB8UOIXZ3vFfuVSVHt3DPvtyCK5Vy7pNYpnbu5Mj6kC/uvhcoA5FEvWkaMB6g9blNGEfO3J9r5BHiWn8GVYHip0YnWg5ibRV5Su5Oj/h6dKJOGnXRb7P0gn8mMG/F9ayTJxQpiAdwYPT/D3+72ocPJemDHcjGbMI23PoLPLSxv4KF//2t3ECa7NC9rpr1u3aLc/MMldsqBACaBqe9uTp5dXWUmV2TnuWdtaxlz0J+7+Gcs0d8kmpcr1u2psylBZ7GaB0aRVXdsUp1OfGioFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBjmhzW+O1VNwK6D1sOQzhn+KsehFlxSunCYH8trmEE=;
 b=X6obvJlHGNwcjxcxggLtA8o+dn8cTZ1KtJzecVbfgK3EKeZ1NuJqbAumOZy1CEm2Adzr/UN7gw6gRCbiQRgEBuh9YHdzxA7fjsdvuuywobMe3OOfU6/CHUXrzPcGa8mFLnj9tGaLk7roi9YmvGDaTCaTmudfHMQQEWSAKs59Db0=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DU2PR02MB7807.eurprd02.prod.outlook.com (2603:10a6:10:2e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 19:03:16 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:03:16 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "rl@karo-electronics.de" <rl@karo-electronics.de>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [scarthgap][PATCH] bitbake:
 bitbake-user-manual-metadata: fix missing option to 'echo' command in example
Thread-Topic: [bitbake-devel] [scarthgap][PATCH] bitbake:
 bitbake-user-manual-metadata: fix missing option to 'echo' command in example
Thread-Index: AQHc8pxH2TTKD8tqckuo0CWoBQDAt7YrnYTA
Date: Tue, 2 Jun 2026 19:03:15 +0000
Message-ID: 
 <DB5PR02MB102135B79F318C5FC1017E768EF122@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260602142909.984239-1-rl@karo-electronics.de>
In-Reply-To: <20260602142909.984239-1-rl@karo-electronics.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DU2PR02MB7807:EE_
x-ms-office365-filtering-correlation-id: 65b87291-9e84-404f-50c2-08dec0d99a3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|3023799007|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: 
 uxS/PdsvxA+cKiton7kH9mQPZVARewJaI23coM2q/tIC202Ji0BGZuPINMG7xE8ZIUzCelDTgRBtT/uc8YVywlLHAFoqsOgkrcfhj9HvJavv+ZzOzwI34/NDqZCixwtgqZXfgWx+n5EEqgj9PapdXm4k87BIBB+9zjBG8IuwrTh0K9+pXKnMfxVWImy3QKCuqo4esKACxopgKREhKrU5S0PUzS/s3akGTMvBU1arg+9J/qxgFVpqzj4Z/Xy92tnshXGN1MkY8jtWIW9MK3oG9bAX7v0gAfU1uNxGoHqfKIccLz6tCYBSpHRJMe/5t1+eiSp75M6TquFz8SESlYKLuixblDlMH91ziVkiesPzv5+C9sfadONnjOjOBVkcxAc/r4HuqGDjd67ydm5l3VjKnwvNQKsQKy1K0gNbWDwYRqNEGoITxINSE398IVoIZ/gkzOvWW8DFws+lQMLZZ759yj4DceWS3ziAcP4x/cAD7wLAcouWs4iQ9qPpHsXHRKv7iBGz67HDl0Djg8oc7fmTYaKfEzUaMQQWXPQeV8JW00zlJSyggqfj/AReYjyg8/j9N19zaAlk8xLYyflm5DHmijGxe4cdqE7z5COHHEx8Yw78V9H9uJfAEYoep75UP1w0sA0W5Gmc6O2nRQIiGNXt6Xy0B6oO9/wny570gi8ZutAieEUFrhym7FzjGppgOUq0fKuffhMLbER3rlOSUbxmWX/kLbAn/gICl9FbOy+1FsvHsnRcMHfy3dwE7IPOyIzp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tzgyn8qIWkTrMgJZ6pBkXyZnFr6LWqMHwe37Htr31/B0jnY0fg7pbsS58Ktd?=
 =?us-ascii?Q?INX9s5Eor4LIW1P6ikgLFNDOGyl9a55OYsNSCWVrBjl8Dc4qexC6n7tjtvox?=
 =?us-ascii?Q?qdT2rwojJBPa6qEZpfTD98CeoAs4hyKkURdJY/M7u+6ZJZ7edAmOec3QRR/j?=
 =?us-ascii?Q?QDdDLxiuCESJINYhxzSASXhSrvrCGCOf7+6L6lyASVo22T5G9gwyMrvcz4KZ?=
 =?us-ascii?Q?vW73JbwFhZwMfZBAN3HLZ4QIFXzGC78cfUND9TteUgpueAfta1mDbwWedqcF?=
 =?us-ascii?Q?nsaVgi4uxVbogrGE7LVq3Q0uCtJu3UV2fRr7d9bbnxtqtlUYnjjzU8Rm5374?=
 =?us-ascii?Q?3zlf5VZW/mxosdF0LnUU/M3sgiWxkQp7SZ1rucI8oPjSiNBWmSYOfbF+58sO?=
 =?us-ascii?Q?hjTPpxR7CBC3savu2sCIlf7A7YX+q3Ay7vYgUAp/GAKX1npEe8zhvo+0Pfmr?=
 =?us-ascii?Q?CiUHMAHkywgCcn2lBX78j91xTqGer7Gr40TdAlaWJ8ikwHBiwchQynYLOBbe?=
 =?us-ascii?Q?qyN8B8w1QFlrdizjkfWLaJgFJ6NmmOH7xFTN6S38mY79kSeJ5mSGK/3RDViI?=
 =?us-ascii?Q?Od/mRXyKct6l655+aetv8mkAADXrMy0t8jWet5cLV17aMsmetgHXamvzBHar?=
 =?us-ascii?Q?p9tpf6ofSdkg3UBov8GG4BRBQHYHPLF1GoSW3sGVUhJBnIc3eJECzxyxh00t?=
 =?us-ascii?Q?C/q0o5/COpC+fpC/11vv0AK3vqdTt4no/mbc8chM6UGKZFzFSWomGMCAmPoJ?=
 =?us-ascii?Q?FGK48OtcOJbwJHeK90ygOz2xhQzvg3arzNOzYgGl7LBeNVImnlMXRYSiPa1z?=
 =?us-ascii?Q?HT6HiibmmbCzaE0Esi4ob+paSkHVla2sc0yzzKsEdiDOnCClOaEWMQSMUC+T?=
 =?us-ascii?Q?VKooIdMeOF3e3BdL/SADGcpjO3gFugSENm0eqr6qbUVcyhimxgElAaW+yUM3?=
 =?us-ascii?Q?Y5McKQtlFMpk2qCjO0bGOdBG/9AOeYo5k4rTIhkdM8UARiRzqxviVY5PQAaW?=
 =?us-ascii?Q?BAQPXrKo+SxA6SzeooEJsPsDMwiPz0DBoVRdJI1r2q6VZp03L6lcDznpLs8c?=
 =?us-ascii?Q?rFWPkEaPuDmvznOcBOirTSboIriE3+p/fBuTrnFOGUb8RoV9b6mcoy2asDOm?=
 =?us-ascii?Q?uTyErZNpR5s+zLGKYIew3bRXl+CKhM9YsZ8tbwDQEtqD5cLXR+xqvhDrQC7S?=
 =?us-ascii?Q?Yhq5IxbZH3XcyjhYISjf49aKGDrNjQo68lax4ex3fNgxrw+1+2cEJJmGLQWZ?=
 =?us-ascii?Q?VpVUnhXgaECcBSWbb8+d3wP4DtiwYzKX2/BseQj7fK5l6Mm3SpysKsRtqfO1?=
 =?us-ascii?Q?ZLybBDek6kSNJIHHdFUEF65bTLS8T09xFPieelsqd+V4LC3ZWl2O3Zrt2Trc?=
 =?us-ascii?Q?yRtLB96I7U59G6PsCDFMd1ZbWNo2KlyADnVZj4PmfVo1GmwI2NMQYACw89i8?=
 =?us-ascii?Q?+1S8V4Pe+lKdQHdh0rXUPPjHrk0KA11zMQezxEAlD1WLKT+1Y3d9L5SGAyM3?=
 =?us-ascii?Q?9Zj96c+cH+NnSGDTouXTlwfN/VxxQF9XzhwO+MunIoTQBRSOi88IWLFpLf9s?=
 =?us-ascii?Q?pHYxAiTV1Yv39/Nb379LfEuDC82UkoPQhJLKRrA5rLG8hyownFPN9qTWj1yK?=
 =?us-ascii?Q?OtRclnkcwzA+3syIVtyhBBpGyikeLLm5HrBLxm/pZDV9rorVE9bkvXolzmkQ?=
 =?us-ascii?Q?XJ/vEASA9HvOz4OKa1ZXVaRKe3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b87291-9e84-404f-50c2-08dec0d99a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 19:03:16.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X86yKUqoUdIS/3ZqB/V1RW+c/ECVs2afseBbA+a102pOgWbspfeyMf3vxttmO6YA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB7807
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Jun 2026 19:03:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19593

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Robin Lintermann via lists.openembedded.org
> Sent: den 2 juni 2026 16:29
> To: bitbake-devel@lists.openembedded.org
> Cc: Robin Lintermann <rl@karo-electronics.de>
> Subject: [bitbake-devel] [scarthgap][PATCH] bitbake: bitbake-user-manual-=
metadata: fix missing option to 'echo' command in example
>=20
> The original text reads:
> | values. For these to have an effect, the value must be passed to some
> | utility that interprets escape sequences, such as
> | ``printf`` or ``echo -n``.

Umm, yes that's shown by git diff...

>=20
> The '-n' option tells echo to not append a newline to the output.
> What's missing here is the '-e' option to "enable interpretation of
> backslash escapes".
>=20
> Signed-off-by: Robin Lintermann <rl@karo-electronics.de>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 58975f4c8..3d32e8c1e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -128,7 +128,7 @@ Consider this additional example where the two assign=
ments both assign
>     BitBake does not interpret escape sequences like "\\n" in variable
>     values. For these to have an effect, the value must be passed to some
>     utility that interprets escape sequences, such as
> -   ``printf`` or ``echo -n``.
> +   ``printf`` or ``echo -ne``.

I would rather recommend to drop the suggestion to use `echo` as=20
how it handles escape sequences is shell specific, where Bash, Zsh,=20
and Dash all behave differently...

>=20
>  Variable Expansion
>  ------------------
> --
> 2.43.0

//Peter


