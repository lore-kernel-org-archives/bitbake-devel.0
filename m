Return-Path: <toni.lammi@kone.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975A8C48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 13:06:26 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.80])
 by mx.groups.io with SMTP id smtpd.web10.10759.1707483981306725497
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 05:06:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kone.com header.s=selector1 header.b=B0etXGlJ;
 spf=pass (domain: kone.com, ip: 40.107.249.80, mailfrom: toni.lammi@kone.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNXnMveuLlyM9qRBkNQlJC8CGMU7+F4x3kR1IaHcYqluSL1ObcGY2ydqbMF1pixUfm5vQKoNqiKgM9d3UR8Tz14+cGQYC1Fwsmc/BfJF7O10pV7QL48VV1Fvl92Wsmig78iZ1voFreoT2GmGmxQEbudJMHmxv8VCXntMqNMnWwsuYPqtHvBoYyuzzln0XuklkqyNHaH392A75Q9LB72cpnnPta44X8iT3b3sKBXgQM3lBOvpJt/QjR+Tz/ZUhY0ZRSo5sU/sHvKRuW30K3wFmKGn3r8KRPZI3Uk8pSSzFOvfbKSgKgwXrvIzrPhjzv9S3SoWrtmTiOQb/atIW9JHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeEFR10ni+vR3UcFEXPpVT6WHCmBC51Ki5GjFpPCCFA=;
 b=n/5ypurNWl0pdeLqtvAzWa8xUZLheRnEBJcMMgmzcF1xcrdQRJrnh0uyerMvf+HFN5PtbxTvVOn6QCS61mdz/If+HI38DlHQUHm+vcNdLGRlVvWGa2A52Vd3EH+5zTWcGiS69EXe3tlw5fMxpg5/gZlRloyaxEAy9FcFH/x0OzckAXEzkX+eT0ZTmCVaD6zO1jWYA63BboXz5ciT+XSqVf2NLzphhcqaL8qJhL2VjIBSbG5MIGNot3dhKPZoYaD3i7DqeF/RkxwOnMqrjSkYpErapsHgQsv8G2RoNWX4tVFLgZAsFsZarumN7eOfKDgEL82eyoe/IgRDDkaErq5YBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kone.com; dmarc=pass action=none header.from=kone.com;
 dkim=pass header.d=kone.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kone.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeEFR10ni+vR3UcFEXPpVT6WHCmBC51Ki5GjFpPCCFA=;
 b=B0etXGlJN34HYBenKz6I2SfIt5PZiKs2KZMHwEUgQVZEMKWverUVv9ePg7gU6PktTlhbl5iP1v9XnHOoxBb+o/PySSR290fwiLxUN7hxjQX9Fcyl+Kt11z588jctOwBcZqJWUrph11rFVp6ULPG/qjNGmFg/vXEZ0jRo3Fcn3vBDHobxIb+X2WVcxFwEJtqS2FmIKe7LedHYVXui9HSx8yJc2ylDwmCQGcS21GPLtDw++mUTg0VMbQVtfcqLrcDLAkyCwiI+5PwVrKA21TeF9ETH3Nr09OuizzifkI+59Aswo+dooUjeV0zo3tTC0dCsrS8IPbRRK31mTE9M8/DJkg==
Received: from DU0PR07MB8715.eurprd07.prod.outlook.com (2603:10a6:10:319::19)
 by DUZPR07MB9997.eurprd07.prod.outlook.com (2603:10a6:10:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Fri, 9 Feb
 2024 13:06:17 +0000
Received: from DU0PR07MB8715.eurprd07.prod.outlook.com
 ([fe80::25d3:745:fffa:83f1]) by DU0PR07MB8715.eurprd07.prod.outlook.com
 ([fe80::25d3:745:fffa:83f1%5]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 13:06:17 +0000
From: "Lammi Toni (EXT)" <toni.lammi@kone.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] support temporary AWS credentials
Thread-Topic: [PATCH] support temporary AWS credentials
Thread-Index: AdpbK5sk4T698EbGQ4a2gNqDfSrSsQ==
Date: Fri, 9 Feb 2024 13:06:17 +0000
Message-ID: 
 <DU0PR07MB8715C1A2BFF38213A93DD589EC4B2@DU0PR07MB8715.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kone.com;
x-ms-traffictypediagnostic: DU0PR07MB8715:EE_|DUZPR07MB9997:EE_
x-ms-office365-filtering-correlation-id: 7e0e68f2-0434-48df-41d6-08dc296fe6f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iKjYeJds0nUXRDepvE4rbeYA1le+S1BMNM5/m0Hxm9dMGgMjcXhZXDfuTnieK8SU3GgHwcfQhGi/+erMuBSGokwSkKMfTrgbyfadiR29r0X2G8E5YzPPy3sONA/PfFzcU1rErsu4hQdJnlO3rq2iOPNVe6W+ajeK1RXgMIwHmjQbQUKPobFyLRJkkbjzWzzJkK22I76fQQ46/5O24feg7J8k64J/gAdUpu79Qypjcb1vyzwOqiiS38K1WnsQQA+vqOP0GTCuxSuWTO1I6YPaxR4eNRGivjaChlvcG/1jBZ5/PoCrlqoj+RXnG4W5QRQKHvCUBDMcDDm6uSulxJQ4g+1cUYW9uGYOWKPgzg5CNzBWXIyM+AKRbZh5hqKGfeicY1nSpscClUjhClomFY27n5BBH9kPpyBE0d0S8bFrp/YmI6m7WvE5v1zQ1SmepySvvFTDWTX2y8j3moucgQakThVHYFKHyzHptrJ349iCU3lcMy2f2/Bd5gDmvDvB0BSp57L72v49jAfbg2mGDTLi6tonVZSewQ0f/2eKZo/+WfYq0ysXyQ8ByipsjsoafZlpmLN8qWH+xFZe67WqG5EbvWIrOpBO7xTUs/zmfGqWeXYjMmMGbUgqNFMUCiofsQb4
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR07MB8715.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(64756008)(55016003)(66556008)(66446008)(66476007)(6916009)(66946007)(316002)(76116006)(41300700001)(71200400001)(2906002)(4744005)(5660300002)(8676002)(8936002)(9686003)(38070700009)(6506007)(7696005)(53546011)(86362001)(33656002)(478600001)(26005)(52536014)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?S/21e9T0O9yXB7bUJb4raL9V+TpzEcCsf5suDcFGlq2G/vPCAdY8XvBvNdAG?=
 =?us-ascii?Q?68iy+TJ98037CQ1Wu7xgsxveiqkR4X6xNTKV7L5wF/7nGOl9kdAjkcsqOtzq?=
 =?us-ascii?Q?RXB4K80UQRR/7PTlGkpFNqfFtx/k1Oi91y6krxTrlEx6rsFIdU8CQE7NyySV?=
 =?us-ascii?Q?asFxQM5t2OMZVRcsP+GqhnsBK+eOTVpOYMxanuelvWaAL+DcDVOeSsqZmgc2?=
 =?us-ascii?Q?EVFXVEpIjkbaeLKhnU5euNHFDCWwfKsFYj7N/yDfJPBxjkHe7Hmosk/i6mRH?=
 =?us-ascii?Q?oL5hQO+BKGKqho7JVGHruA27+fnTMZ4ZrDHjxSRu/iOAf3K35/JBhc/Z3S5q?=
 =?us-ascii?Q?GiQz549adJGf1ScMy29NhxOOPJ0QNMvPEQTNkUCywBXouhnMPICHVLk68osW?=
 =?us-ascii?Q?L/scgVD2qGzUxyAr6q+6XNAhyauwglJFZW//srBKqErRr9aprEzEMM5/Bvrw?=
 =?us-ascii?Q?E3zwEMIhQ3nfEOmIs2MsmdIwFQK4amQYr10ILqtc9XvH0yc+PK6PGbhxjlRQ?=
 =?us-ascii?Q?GxEc++1+QMywJbPfSahOKQn6p/U+P67VZ/4mWr5+0CthGv8Dr8KFOOUbdO/4?=
 =?us-ascii?Q?eg2kuNs7q38ECPM73yA1gdhN8Y+j1GEq1Tm+I6H3K7/sJWocVJbNCQyl7LKM?=
 =?us-ascii?Q?El48p1d/XoQ+QNehMo9HsdNmzfTONvlUgei2H0vN/lO7Fd9qPScUconvk/1b?=
 =?us-ascii?Q?8pGlQeSSI9Gmg4loU5/Xn/l6Q/rz/3SPZodSvtkhqkQU/zXxzCpilgmbY3MY?=
 =?us-ascii?Q?IxXXJPFbPh0qgKuzg5azW8KlKew1iS4E83L1wORCfIMLCs6P8Rjb6EjFsHHs?=
 =?us-ascii?Q?wmn6bk3GyW3ANJ9GXub0kngcei2GWSsz7F8oET+C13Xy6JKVz3P1n3FtGW+z?=
 =?us-ascii?Q?GE89jCO/+7u1Jfdk9DC3MtXMj04gCgu15TwIpAaexMFq/hnefBH/Zyo4/uSE?=
 =?us-ascii?Q?1AR72qmkLp0tNfwicGl2Ksm4MNnR5ZhhVVIq2cSH9CNiDACD5aJ/qvx4SFQi?=
 =?us-ascii?Q?DEz0CJyKh6TW6PcCa01IqXIts2fEImTCx7qxsp5ABKsDRI8h2h8y4SrLxVZN?=
 =?us-ascii?Q?NdVkoTcScFS02ndipm0Bau+yKOrIHFzbeg/dSmm003xVUnvmE0ZZ/cWP10WK?=
 =?us-ascii?Q?8y6+eA8F7VZ8lo0HStRB0EXA3AhVHH5dgoLyGdoMWCc+jVED00dMS2cNfE2k?=
 =?us-ascii?Q?0pFn5CNczEhUiLulkfLCV3/q2mptfRVf05Qmu41+LnX+Iy1TJet0m+zV7VLe?=
 =?us-ascii?Q?l6ktXSvK1mnVx+mTZ1RzvsJZ7mXfpPWUgwzhjb+KrYj3xXLewXa6zhQRvaii?=
 =?us-ascii?Q?vTVrTmPrVHVfIW/VSuTlwvIUu0S8jie28/T0tOM4j/xE+gVilkb5EgaXk/sD?=
 =?us-ascii?Q?JIIWTSlm3utbgQt/y8VO4SJXjUUMLkoY46AXrLm/1Lc8xWYXdXcCYyZ8oR+M?=
 =?us-ascii?Q?r/Phzv4IRKDBkgJRMfrCyWKlX9KAnZMS4gy+294DfetvtFERlRQHeeBioEdd?=
 =?us-ascii?Q?P6wED3KUwbyOj8kKf5NWRRhp6J70KcGbEHm2+RYYApT+bLmia4d2NS74xRnR?=
 =?us-ascii?Q?mYBcnGbThfYBMMZNm6feDRaPLB4vyQJTG3RhPYU2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D33890B572032D4BBEEEDA6FADEA6C9A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8715.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0e68f2-0434-48df-41d6-08dc296fe6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 13:06:17.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2bb82c64-2eb1-43f7-8862-fdc1d2333b50
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzOi1ebausny6FFlA537A5VeUvfaJlxpaYsK5AABvEvy8DRXjLkT/4I372KcJMPmdtAtkUv/YRVhp8dvjcGxTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9997
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 13:06:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15849

From e3c222d1f6d1a234ca3a3a4ff353549d276c5320 Mon Sep 17 00:00:00 2001
From: Toni Lammi <toni.lammi@kone.com>
Date: Fri, 9 Feb 2024 08:40:29 +0200
Subject: [PATCH] support temporary AWS credentials

Support AWS_SESSION_TOKEN which is used in temporary
AWS credentials.

Fixes [YOCTO #15384].

Signed-off-by: Toni Lammi <toni.lammi@kone.com>
Reported-by: Toni Lammi <toni.lammi@tl-software.fi>
---
 bitbake/lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index 677968a6a9..ac0f4dfa1d 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -875,6 +875,7 @@ FETCH_EXPORT_VARS =3D ['HOME', 'PATH',
                      'AWS_ROLE_ARN',
                      'AWS_WEB_IDENTITY_TOKEN_FILE',
                      'AWS_DEFAULT_REGION',
+                     'AWS_SESSION_TOKEN',
                      'GIT_CACHE_PATH',
                      'REMOTE_CONTAINERS_IPC',
                      'SSL_CERT_DIR']
--=20
2.43.0


