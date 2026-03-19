Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7CB1088E6C
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 03:04:11 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3048.1773889444425557019
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Mar 2026 20:04:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=W1f6ZBSL;
 spf=pass (domain: axis.com, ip: 52.101.69.35, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqrEJxMlMYoGfyx2o3y2wCepcITuupCrT1kZUhoDCUaYQzCD2Im/xCJB1KCbZwZcfZgnSM1ZeE5VYPq4PaaFYeXPSaeyhENBZHvVipvsRo4ID6Ain7n6F762maLdpmxuX1Kk6eGi+ziMHoQ6DYdknw9vub5eWgAIeb+m/IhycHPxXHAlP7Ue3boPBw1v0IRHULDIkipIAXFMvmD5lzC4OD6kow71Q6nTjRvgieiRQnMpCuhyUfk4crmq6zFVNbK/A1JnWuLOiquNDM4VPA1iHh8N2kESUt7VtoFiMN7ezqT3zjQeiC6zaxDbNi5joUHTpvgqSGg68HI3pOmTlIK0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kQpjLlE3o1L2P4uRyIUYRug1KLOXuRZeB8dRN04s+w=;
 b=a8s3+MsCjF6MY/2IHf9P0+RJeAKJWNhow+jO8ah8hKw20qmRUGyXKtzJTV1S7I0RSJ0Drs66gLqFrRIf3O5spSE8ZejPvcZDNTnrX9gNq4ZJl28pkrA/yhkGlqP35wEdALzJb7/TNL4obE7NrX9KLqtZGF152h1dinRFlfGHJ7Awazmm85izh0dl9FSdEvrYL6YKPaT8NC7NTmw9dxsYVquijvAJ5ob2L2Ci4MmnSRjJuDHYYphxMnHVuc4EpQdZGHoeVAr32c3jnMWnI8nl/nrqgm3DJIqCcYT+tE5wIS1wz6cGLQ8/kdLRIlAwYXRxRHJxLSYefBfLZ1MF2AUcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kQpjLlE3o1L2P4uRyIUYRug1KLOXuRZeB8dRN04s+w=;
 b=W1f6ZBSL7kXJcvPLWmLX32gG/7heOTG3tsj7jd2qqAYJHKaxucj3aJgk9EVLIbPMoIbPD5Lj1V/A1biVUi9Rxi/vn9hSlnCy109vz0SwZvs8rWB09xpV5/IzCK0r4xlhAlyO6uJijnl09AKH8TYUzWnaGHht0KTxEgeh47fMiiI=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AS2PR02MB10314.eurprd02.prod.outlook.com (2603:10a6:20b:62f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Thu, 19 Mar
 2026 03:04:00 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 03:04:00 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [meta-oe][PATCH] liboauth2: Backport a patch to
 build with glibc 2.43
Thread-Topic: [bitbake-devel] [meta-oe][PATCH] liboauth2: Backport a patch to
 build with glibc 2.43
Thread-Index: AQHct0r/myIpCwkX6ke33NtvFWDk3bW1K3Fg
Date: Thu, 19 Mar 2026 03:04:00 +0000
Message-ID: 
 <DB5PR02MB1021324A07FE6D266942933A4EF4FA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <189E1E3E0D3BF4AB.2964266@lists.openembedded.org>
In-Reply-To: <189E1E3E0D3BF4AB.2964266@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS2PR02MB10314:EE_
x-ms-office365-filtering-correlation-id: 0a524f0a-04fd-49b0-88e3-08de85642b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003|7053199007;
x-microsoft-antispam-message-info: 
 uIbIfT09UlX9PF38EHiWggA9t0oF50/7t+KWFaURdkfa8ToMdXZ4BmMjMBHNJWkS7TR+HUw1HDpeJAsq/GcBXns/STL2RWnpRsFXrLwoshKbFwtjyZvc8Ibg3iZO69WG7G8H4CBmFCAe7I4GwXANO2sH+qpiS7clrAoimm8EUUG+IStf1XZ8oUigyUfo6dxIsqscuVJR+ZW5W52uLQP4UKyGaA15kEA+UUxzjqi9zgEYXKCSvZg+5SRdjAjYqnDEP8K3hi7+/8rCCGnbOAu4+eCJyGN2EX60NH9GFXu6NHCT+a22Q2r2rm1BjZZaSFR6z/grBAu+FJT1dsIA8wJy/2q/Nyndkuq8aUtmMlsPrioCh5o+fqWkk9NmksekfqeV1RGR7dYcKBKIzr+ynjS8InVr3umU4sM0ohVHheqoddMopF9kFCNwDFkUk9Wf+/nHbFb/dIAXSmqvx4YaAT7EkSuXo3Bt1taxyrKUB7GcPgKSmAokATP0Ey26/BJKPx0ixgIqzMMmmiUrKu7qSiJWzxzUTeOPA1WxUxO9IctXgm7mdaOIhAhzVk4YEw4+c/SsrqEGOiefV1pMoU53ZMa1bmLTJuKN4UCHLSrWXLPdMY1jwcOuqvUvIU75CYFWrnS6g03Na9f9rqxuXEldCSSZjd5psOYzy2wLoOLW6B2LmHrU6S8VZAdP70jM1RfeR1hD/WgiSTSH1KyoEYHhIhMx7Y6SqMGWp13PIRUKcSuUkVpU1qiScphJ5TH7hxai8CWI4re4Mbj6UpVAhHR17+Cv8HTZQJtTKCmBcEb+32zICVM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?A3l1ZeDqA+3PxtEShQYVqSPkXGZPCgvLnNUIgnExgwEJ57LiX0E7TIpt3wSa?=
 =?us-ascii?Q?kT3gTPLNBusS8SIIY6K1C4OrKx6J8SKWK5EKLGbnmafHQ92cXpfX8hR0aH+M?=
 =?us-ascii?Q?zYjBOQlj6gtEABAjUUi+42s0zv2S2y7n/WhCscHQpGcGKVQd9iGaLe/648eq?=
 =?us-ascii?Q?he6C1O9adaNbQfj2sRucLZHX2dxep2YjEaaY2VvAcCYe/KOXS2xkrzTxumNY?=
 =?us-ascii?Q?XuoDex0xZ/Fo5ccKnYw23zW/tzF4IJSoq/uLZ53POW+CQONAatefDcJrbiCm?=
 =?us-ascii?Q?q+WnV2tXy3LZZIVlzSMRIf1ZoMh2DIclL54rxC4Edxmt1ssrNnRec9fSiq1n?=
 =?us-ascii?Q?xwaRS0n0mYzzHWYKRDv5S2DzUODinMyFZ7KYgRwtrw1MetgetFMvjTLkBOlI?=
 =?us-ascii?Q?rGgoKIx6ZeO5FOIC77UPgqXvSunPC3hfao/GGfR848Rxe7tfLETMHjOQTXj7?=
 =?us-ascii?Q?wcrQgMDpo9eqI/7f0Ad9xHkScjWOtUtkwYRaotjQgwVOczFtinS+PL50TAV9?=
 =?us-ascii?Q?ctY+A4Ehh9pAujtaA1AegitLG7bRsvwb6NjuUbEbObspTBsGcnKwPX1Z5gVt?=
 =?us-ascii?Q?UwNINAUmOA6FXdiSjXk0OVCEAnEq+mME75jS11XxKcaC0SqTjLPSOOaAHNxj?=
 =?us-ascii?Q?YzPV1D1OyQHBlUHr2DTU89Jdb3H0ayYnejigsTY7vRxQbPRlGO1lrDhHPi0v?=
 =?us-ascii?Q?6++yMiQY4EVCamrXcwCQ2pXSn43k8AYY81nqQ+BLDScEFxq6bLbDmuz1MrNL?=
 =?us-ascii?Q?FuZoG0gTdEMqNNn8nhfdeMHJ1xpqW+F6zPnLyV1Al1KiIGpHfVQ28C3QP+UM?=
 =?us-ascii?Q?AbdfWpA2ZOLGwBO3RlpddbO21P6sFuuxkls7ibA6g9dNeWMvYUb7ewSsGDj8?=
 =?us-ascii?Q?A+3ECm28nK1FjSnDRpSENSYSxTIR+NyEWhKS5R+9mS3mIGLfphmS/LRNQ7MH?=
 =?us-ascii?Q?yEM7DIHHrzOEYFdYi/E4WOEdvwXY5SWNo4QoeFOaRJ+tHXDp1fHAMUr4+wGr?=
 =?us-ascii?Q?YxK82IQqqumFZx/fCCRPIcajGDsPeNoUkqnBA9U07uMifazNCvlhLxtTxQEu?=
 =?us-ascii?Q?9IwpnISY2XC55T39xUWJ24Q41/WYyeSeLoAnvTFetyw6ax+oq4bb1pbazeZp?=
 =?us-ascii?Q?bhQMEzTfmUUMiIOvMVxepPCy2AWew5plkGFa8zY4UUwLNFq/LyNA3PIxRYe7?=
 =?us-ascii?Q?8zpU5Pe1jm/4429p1xgjlhNCqAQqe7zh6oPFhnUKnAc+ky5OzJACEhrGHSF8?=
 =?us-ascii?Q?azEfqOozoUHMX2BDwiu7gBlxMnYeIR5ctVa7jnDbwZxXz61VhQapKnjkrAl0?=
 =?us-ascii?Q?6RGgU/VGHlkV/nTertUbkEOOP1NVTxRjWHe2xOv/U7dFeeGb2NIwmeP39ajY?=
 =?us-ascii?Q?FerNzErZk8YOhdmLqTw2+Jf99drc4jPzOt2rLNccXtKAlLtTB/9er2FqWIUm?=
 =?us-ascii?Q?XV5fkFmOJJFJbl3jFEWensm+6JAaNVUXSvNt+2GB3/Tgv25AJ1JMA6YTq97D?=
 =?us-ascii?Q?HbV4XChl27Ww0tHHXILOqyMqlmOKdkixizEH+BFftTo2yHhIwN3uLrBy2CPY?=
 =?us-ascii?Q?oz2+p08IVz8Ds7blV+lroSYDIjr1HxGWcd11XlPoOINhCh0qOWAR4BirGS03?=
 =?us-ascii?Q?tjSsphORzrTACGBHQ8sAPFSkktbS8T5lGG/rj9t7TiyMV5KUCHa7SuWAqQl4?=
 =?us-ascii?Q?shcLDGL1WnvLSbWrHEuGODZVImM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a524f0a-04fd-49b0-88e3-08de85642b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:04:00.6016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkh1OR/5tddUQ3kBAyZIhs2HSIgHObO/anuGi71NXjFe3+3CcRVQXm61ICwO0Vza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10314
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 03:04:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19171

Please ignore. Wrong list.

//Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt via
> lists.openembedded.org
> Sent: den 19 mars 2026 03:49
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [meta-oe][PATCH] liboauth2: Backport a patch to
> build with glibc 2.43
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  .../0002-Fix-use-of-strchr-with-new-GCC.patch | 33 +++++++++++++++++++
>  .../liboauth2/liboauth2_2.2.0.bb              |  1 +
>  2 files changed, 34 insertions(+)
>  create mode 100644 meta-oe/recipes-support/liboauth2/liboauth2/0002-Fix-
> use-of-strchr-with-new-GCC.patch
>=20
> diff --git a/meta-oe/recipes-support/liboauth2/liboauth2/0002-Fix-use-of-
> strchr-with-new-GCC.patch b/meta-oe/recipes-
> support/liboauth2/liboauth2/0002-Fix-use-of-strchr-with-new-GCC.patch
> new file mode 100644
> index 0000000000..65340e806a
> --- /dev/null
> +++ b/meta-oe/recipes-support/liboauth2/liboauth2/0002-Fix-use-of-strchr-
> with-new-GCC.patch
> @@ -0,0 +1,33 @@
> +From 0dcba079907d559550ee8d9a201d26203bb8aebd Mon Sep 17 00:00:00 2001
> +From: Alexander Bokovoy <abokovoy@redhat.com>
> +Date: Wed, 7 Jan 2026 11:41:37 +0200
> +Subject: [PATCH] Fix use of strchr with new GCC
> +
> +According to C specification, 7.28.5.1, strchr() is a generic function
> +and its string argument's type is promoted to the result. So if it is
> +const char*, the result will be const char* as well.
> +
> +gcc in Fedora Rawhide (15.2.1 20251111 or later) implements this
> +conformance, resulting in a compilation fail with
> +-Werror=3Ddiscarded-qualifiers.
> +
> +Signed-off-by: Alexander Bokovoy <abokovoy@redhat.com>
> +Upstream-Status: Backport
> [https://github.com/OpenIDC/liboauth2/commit/0dcba079907d559550ee8d9a201d=
2
> 6203bb8aebd]
> +Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> +---
> + src/jose.c | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/src/jose.c b/src/jose.c
> +index fbaf661..a3441c8 100644
> +--- a/src/jose.c
> ++++ b/src/jose.c
> +@@ -993,7 +993,7 @@ char *oauth2_jose_jwt_header_peek(oauth2_log_t *log,
> + {
> + 	char *input =3D NULL, *result =3D NULL;
> + 	json_t *json =3D NULL;
> +-	char *p =3D NULL;
> ++	const char *p =3D NULL;
> + 	size_t result_len;
> + 	char *rv =3D NULL;
> +
> diff --git a/meta-oe/recipes-support/liboauth2/liboauth2_2.2.0.bb b/meta-
> oe/recipes-support/liboauth2/liboauth2_2.2.0.bb
> index 31d7aec69d..244cd51a2c 100644
> --- a/meta-oe/recipes-support/liboauth2/liboauth2_2.2.0.bb
> +++ b/meta-oe/recipes-support/liboauth2/liboauth2_2.2.0.bb
> @@ -6,6 +6,7 @@ LIC_FILES_CHKSUM =3D
> "file://LICENSE;md5=3D2ee41112a44fe7014dce33e26468ba93"
>  SRC_URI =3D " \
>=20
> git://github.com/OpenIDC/liboauth2;protocol=3Dhttps;branch=3Dmaster;tag=
=3Dv${PV}
> \
>      file://0001-fix-clang-curl_easy_setopt-takes-a-long-not-an-int.patch
> \
> +    file://0002-Fix-use-of-strchr-with-new-GCC.patch \
>      "
>=20
>  PV =3D "2.2.0"

