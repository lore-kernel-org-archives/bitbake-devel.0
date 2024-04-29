Return-Path: <kari.sivonen@live.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C8C4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 06:41:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.92.21.10])
 by mx.groups.io with SMTP id smtpd.web10.14532.1714372898724374060
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Apr 2024 23:41:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@live.com header.s=selector1 header.b=q2BqdL0b;
 spf=pass (domain: live.com, ip: 40.92.21.10, mailfrom: kari.sivonen@live.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxOBR5fRfmGAo1+8P6ao6RGVDBZTsMgQ5u+yvsKWKiiRIaAEj7oiH9PPIz7nlz9YySqIW0cFuyRuYwKyba3d9X+B/ieQoRfbYLXOArccNuufL3m+xjRjFtZ1k8n9orSXg6yboKvjjta8GUJXj17bFfT1qduD1I33m8nLUwZQq77EgaRFw19QN05I2KE9ZXoJQHHE+Y5vegruL2h4Nrkheim+l53Esx/k8bunKmbaIbkQUdPsYAxX7scHaCW5JwQWXKFgLTPnOkElZo0Ilb7c/Pta8zC9gde96ZrvSa/BnSFgIkEtpI+zUBBLbh/4KrBgzxUG3ZqH0yim/bypdXyrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB4ZnDy1IA8LnFSRLaYxaq7GB6d+bWKJ6vsJ/lqwSu0=;
 b=ZLOsUMavgXEgKfcsChmb5QwIzkJeW22o1KePmxl+1yq4SKRUtF5C+7kT+aW/VrE/G9ebZDJ7VDkyI+c4hGxX3BPtucRFfUGO98AUZZxmZM73s8hRqtNJjlSwAdMePAMHVa8v1mbPOqA3QfL/cLs4Vf7JWgfm53O1txG/5DuL3qOoEYR1E6eWZC/yhbl4kq8+MHgY0A1vKvxDCXB8rBCb/Gxh4WygmV60aYyGek5kAguQyigDZQNlxyONLBXWX3aQ+wQgeeMSYSoUKDi4yv4c8Uk/N9hAfMXftbgGzCgrkRIrXTVUDEw77Kg1lkV4mfIo220+IEiZMgT/4k20NJTf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB4ZnDy1IA8LnFSRLaYxaq7GB6d+bWKJ6vsJ/lqwSu0=;
 b=q2BqdL0bekm/TiggRbq7wQq5g95ynyV1anFBJEnF1dENA+FvCXzB/wP36kUpXnX4lSjmKchAPVqtItIzTmdWh/e93q6nXmp3SdUOAQuQ4gh86N/46hZ7RlF7Akgh5+skztwGFv1su3pFITfVadFAeoZXbk6y0d4CUdyc/TozY459RENonVwXWQY4eBvZ9GxaBAlivnqQ3/J7Bs2IiPpsLETfqoymIiFFTXGCd+8sr+s0Y//fGMg2ILbWmPPvcSXSIY9Gq+/mY/oDdfZF5L/0RZM+8+LMUrzdZabjWhFqPJJVAM2aBoDMxWtNHExxpOqq/QLwcHpovzZNLJxCEZzBLg==
Received: from SJ0PR22MB2795.namprd22.prod.outlook.com (2603:10b6:a03:3e7::10)
 by EA2PR22MB5332.namprd22.prod.outlook.com (2603:10b6:303:25e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:41:36 +0000
Received: from SJ0PR22MB2795.namprd22.prod.outlook.com
 ([fe80::85cd:96da:b540:78c0]) by SJ0PR22MB2795.namprd22.prod.outlook.com
 ([fe80::85cd:96da:b540:78c0%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:41:36 +0000
From: Kari Sivonen <kari.sivonen@live.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] Fixes [YOCTO #15473]
Thread-Topic: [PATCH] Fixes [YOCTO #15473]
Thread-Index: AQHamf1zIqd4N+wB9EuIG689A0SX7bF+y7X5
Date: Mon, 29 Apr 2024 06:41:35 +0000
Message-ID: 
 <SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2@SJ0PR22MB2795.namprd22.prod.outlook.com>
References: 
 <SJ0PR22MB2795DC6C37BD24073A05AC1BFA1B2@SJ0PR22MB2795.namprd22.prod.outlook.com>
In-Reply-To: 
 <SJ0PR22MB2795DC6C37BD24073A05AC1BFA1B2@SJ0PR22MB2795.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [cDokl33LnFy7+br7JuYAw/52cmImLuN7viB7DEJbKH8=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR22MB2795:EE_|EA2PR22MB5332:EE_
x-ms-office365-filtering-correlation-id: 3cdc9a13-84e7-4ed6-a8ab-08dc68176a5b
x-microsoft-antispam: 
 BCL:0;ARA:14566002|461199019|6092099003|102099023|440099019|3412199016|3430499023;
x-microsoft-antispam-message-info: 
 +3stsHjldB62rrGkzIxUr6gzTeSVdTCfvxSDpRBPBS5T5bny0rHrLRnaxvjY+6jbW/d3MzCOghqp8ex8bJWkQ5Lch/NPrl7VnBXezb847n4KGUaaWVkJofPs8b0V+n/Sf8q/mHK8I7kAMmLpxujW1PHujMYpXN/CIfsSD+S69yjU3XEfaWGbGXSUL2bI5wPn7Q6Rm8WdZ59TWg3KWt5mFRu0XwhcMgIMlu1LFw9K8OcuRuWyZT9Sdi3wKV/NmZC6ioTddvoZmbUgzde6tgojI8LQVs4Bv3TCHkB/MNSF7PMTDbrD10GX0c0tYmrUwRi+e4G5D2r6M2wjmbfQW4pLZMKvvQo0/Ts0sNf+6dheXZZoXIbRbyfVPD4TOn3paJSrHeFuHuLF1X4UinFucMs9oi+IjNrLPBS/eBcuelVfAX4zLDYMkcktwsLlbVMa2KfePiRrh9Sr/ztibIA9j8rNfuEJ7iu48IHWN8PMdi8X/FAiIDWqXu2UuQ3bIfO+J3MPZp8j3i65GZMHu6ddXM7qXCXVqJ8sj3Xk0Qfa9e66LOg9Ou47NplU1B+xSSUHkOsykoP8tdqXMvmKJVWLkJQyLVETi1k3LAVR9siVeLY2IkYSVJiBkiw108TboFFD4415
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?GkODgoJvtXKKWN83snbQ8FGiQW5HScLCTQrZGITc3C+luIZwB+NuKp6ah0?=
 =?iso-8859-1?Q?wCicRdWTS0tQ0aHSsqHZtYopMcGGsF6Aw6GyMufWs8UKDsgXFfr59+ZPmY?=
 =?iso-8859-1?Q?fiTfHhkBCVJKUMWbZZrg6zy6y0v5PSLiS3eSRsR27XCJDaO+5ioOuO0kgB?=
 =?iso-8859-1?Q?OrujdXe6xk7LPKpmqvXvwPIj9qDN+Y7INigb6tDkqwAdClQQUeQadWJYGY?=
 =?iso-8859-1?Q?CnoGxe2GYIQI/oj+ke5s0nf0LpC0KYl2btiiRgBQ8HnVS6QiOfLJCtc7sR?=
 =?iso-8859-1?Q?suNtlL0NQfw4rHwQTHbFfJ5iw5WVTptNGZMn65cpDxoFcjEron2kb6pZPq?=
 =?iso-8859-1?Q?+8n4CtbLDkm7hNJZD3hkEMSMRrN7c6svDtiyhsH6jbfjGD740gEL+QzsyB?=
 =?iso-8859-1?Q?OqQ1JJZBEVy3Lt5onFPtiB1Olib1IXkPqmW7X32izKh9TzhDl9Wq4MovRF?=
 =?iso-8859-1?Q?Dyxj5796xRMIcfey1vgZozSvrUPhkYO4smu+/NChiC3q/7puatwYIlxinT?=
 =?iso-8859-1?Q?9biJNgHLG6XfqScY0ve3aIGyuqdJXO7M5Ys+EzzdhqVFZlZFzo4glVkBAz?=
 =?iso-8859-1?Q?Rak4Z/Seh/wxb/DNTPyiGV1SBF/y0o8QXqeHTyajl0gSKvKY7oBFgEOc9t?=
 =?iso-8859-1?Q?AuTx14E9c4x4NpDnX8wGZxmNQyP7j5UYrU3DovKcgSBmKAWGccuR5b/HmJ?=
 =?iso-8859-1?Q?xjqrLijCyNEt3M2X8pbeAkh+u1n4hgEqTXzQCZA/mdrX4lVnO1BCq2zIYg?=
 =?iso-8859-1?Q?TjCQgH9twViDkvXmjddx4IQYbBWJmV6KdyockRYbOA1WNixWccsizvGny6?=
 =?iso-8859-1?Q?FCS2eFVIlm87Tb885LpB9jBqkPurLi8WfQH2ug5Sz9PcjoSBfwQr3zaOq+?=
 =?iso-8859-1?Q?noLhQ70Ua1CtqCJvMznoqoriSsX50/Q6ZS/PUhg0MmdUntp7nJzA/okiSc?=
 =?iso-8859-1?Q?J5I9CTxS+FK00up9Oc8t/KNU70SF5heWNjawITLPUv3naswgxUk4fYPf+q?=
 =?iso-8859-1?Q?9E+xNMrJxv+1jIQG885CqrKaSTDo5ycu1MaRnrtswRxc8vpk8dLwWpTkYN?=
 =?iso-8859-1?Q?23v1C/YEGMV1zkYuXpxt8oClWmGEXf13Ls9fgbmB5tJC67Tt8KCspaPLXQ?=
 =?iso-8859-1?Q?N0hrdi1MUYfU+w0N/jcomimhjPU4VUQS0ldS9WebENLDbDxaci3ez3ITTZ?=
 =?iso-8859-1?Q?F6muYPbo/nEHUwrmGrctPq2skpX/1+3TkPHBBzrCTshodT/lI/i/5cLlW1?=
 =?iso-8859-1?Q?X6wHyHQNv3XuksxUANYoLWESkIFdEeGe0CplAGqBs=3D?=
Content-Type: multipart/mixed;
	boundary="_004_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2795.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdc9a13-84e7-4ed6-a8ab-08dc68176a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 06:41:35.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5332
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 06:41:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16148

--_004_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_"

--_000_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi,

here is patch for my bug. Send manually as looks like git send-email says i=
t sends but something block it and looks not send.

Looks like I need to register to openembedded also. Not enough to join bugz=
illa  of yocto project.

I hope now you will get the patch.

-Kari

--_000_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
here is patch for my bug. Send manually as looks like git send-email says i=
t sends but something block it and looks not send.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Looks like I need to register to openembedded also. Not enough to join bugz=
illa&nbsp; of yocto project.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
I hope now you will get the patch.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
-Kari</div>
</body>
</html>

--_000_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_--

--_004_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_
Content-Type: text/plain; name="0001-Fixes-YOCTO-15473.patch.txt"
Content-Description: 0001-Fixes-YOCTO-15473.patch.txt
Content-Disposition: attachment; filename="0001-Fixes-YOCTO-15473.patch.txt";
	size=2468; creation-date="Mon, 29 Apr 2024 06:24:08 GMT";
	modification-date="Mon, 29 Apr 2024 06:38:28 GMT"
Content-ID: <89146B5B813FC540B0F7B71765CC65E4@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjNTJiYjAyNzAyZGQ5YjAxNDhkNzYxMTU3OTdkNjA5YjFlZjA3ZTYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogS2FyaSBTaXZvbmVuIDxrYXJpLnNpdm9uZW5AbGl2ZS5jb20+
DQpEYXRlOiBUaHUsIDI1IEFwciAyMDI0IDE3OjU0OjIyICswMzAwDQpTdWJqZWN0OiBbUEFUQ0hd
IEZpeGVzIFtZT0NUTyAjMTU0NzNdDQoNCkFkZCByZXR1cm4gZmFsc2UgdG8gc3VwcG9ydHNfY2hl
Y2tzdW0gZm9yIHN2biBmZXRjaGVyLg0KDQpUaGlzIGZpeGVzIE1JUlJPUiB1c2FnZSBmb3Igc3Zu
IHVyaS4NCg0KU2lnbmVkLW9mZi1ieTogS2FyaSBTaXZvbmVuIDxrYXJpLnNpdm9uZW5AbGl2ZS5j
b20+DQotLS0NCiBsaWIvYmIvZmV0Y2gyL3N2bi5weSAgfCAgMyArKysNCiBsaWIvYmIvdGVzdHMv
ZmV0Y2gucHkgfCAxMCArKysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL3N2bi5weSBi
L2xpYi9iYi9mZXRjaDIvc3ZuLnB5DQppbmRleCBkNDBlNGQyOS4uMDg1MjEwOGUgMTAwNjQ0DQot
LS0gYS9saWIvYmIvZmV0Y2gyL3N2bi5weQ0KKysrIGIvbGliL2JiL2ZldGNoMi9zdm4ucHkNCkBA
IC0yMTAsMyArMjEwLDYgQEAgY2xhc3MgU3ZuKEZldGNoTWV0aG9kKToNCiANCiAgICAgZGVmIF9i
dWlsZF9yZXZpc2lvbihzZWxmLCB1ZCwgZCk6DQogICAgICAgICByZXR1cm4gdWQucmV2aXNpb24N
CisNCisgICAgZGVmIHN1cHBvcnRzX2NoZWNrc3VtKHNlbGYsIHVybGRhdGEpOg0KKyAgICAgICAg
cmV0dXJuIEZhbHNlDQpkaWZmIC0tZ2l0IGEvbGliL2JiL3Rlc3RzL2ZldGNoLnB5IGIvbGliL2Ji
L3Rlc3RzL2ZldGNoLnB5DQppbmRleCA4NWMxZjc5Zi4uNjZjOTMyODIgMTAwNjQ0DQotLS0gYS9s
aWIvYmIvdGVzdHMvZmV0Y2gucHkNCisrKyBiL2xpYi9iYi90ZXN0cy9mZXRjaC5weQ0KQEAgLTUx
MSw3ICs1MTEsOCBAQCBjbGFzcyBNaXJyb3JVcmlUZXN0KEZldGNoZXJUZXN0KToNCiAgICAgbWly
cm9ydmFyID0gImh0dHA6Ly8uKi8uKiBmaWxlOi8vL3NvbWVwYXRoL2Rvd25sb2Fkcy8gIiBcDQog
ICAgICAgICAgICAgICAgICJnaXQ6Ly9zb21lc2VydmVyLm9yZy9iaXRiYWtlIGdpdDovL2dpdC5v
cGVuZW1iZWRkZWQub3JnL2JpdGJha2UgIiBcDQogICAgICAgICAgICAgICAgICJodHRwczovLy4q
Ly4qIGZpbGU6Ly8vc29tZW90aGVycGF0aC9kb3dubG9hZHMvICIgXA0KLSAgICAgICAgICAgICAg
ICAiaHR0cDovLy4qLy4qIGZpbGU6Ly8vc29tZW90aGVycGF0aC9kb3dubG9hZHMvIg0KKyAgICAg
ICAgICAgICAgICAiaHR0cDovLy4qLy4qIGZpbGU6Ly8vc29tZW90aGVycGF0aC9kb3dubG9hZHMv
ICIgXA0KKyAgICAgICAgICAgICAgICAic3ZuOi8vc3ZuLnNlcnZlcjEuY29tLyBzdm46Ly9zdm4u
c2VydmVyMi5jb20vIg0KIA0KICAgICBkZWYgdGVzdF91cmlyZXBsYWNlKHNlbGYpOg0KICAgICAg
ICAgc2VsZi5kLnNldFZhcigiRklMRVNQQVRIIiwgIi4iKQ0KQEAgLTUzNSw2ICs1MzYsMTMgQEAg
Y2xhc3MgTWlycm9yVXJpVGVzdChGZXRjaGVyVGVzdCk6DQogICAgICAgICB1cmlzLCB1ZHMgPSBi
Yi5mZXRjaDIuYnVpbGRfbWlycm9ydXJpcyhmZXRjaGVyLCBtaXJyb3JzLCBzZWxmLmQpDQogICAg
ICAgICBzZWxmLmFzc2VydEVxdWFsKHVyaXMsIFsnZmlsZTovLy9zb21lb3RoZXJwYXRoL2Rvd25s
b2Fkcy9iaXRiYWtlLTEuMC50YXIuZ3onXSkNCiANCisgICAgZGVmIHRlc3RfdXJpbGlzdHN2bihz
ZWxmKToNCisgICAgICAgICMgQ2F0Y2ggc3ZuOi8vIC0+IHN2bjovLyBidWcNCisgICAgICAgIGZl
dGNoZXIgPSBiYi5mZXRjaC5GZXRjaERhdGEoInN2bjovL3N2bi5zZXJ2ZXIxLmNvbS9pc291cmNl
L3N2bnJvb3QvcmVwb25hbWUvdGFncy90YWduYW1lO21vZHVsZT1wYXRoX2luX3RhZ25hbWVmb2xk
ZXI7cHJvdG9jb2w9aHR0cHM7cmV2PTIiLCBzZWxmLmQpDQorICAgICAgICBtaXJyb3JzID0gYmIu
ZmV0Y2gyLm1pcnJvcl9mcm9tX3N0cmluZyhzZWxmLm1pcnJvcnZhcikNCisgICAgICAgIHVyaXMs
IHVkcyA9IGJiLmZldGNoMi5idWlsZF9taXJyb3J1cmlzKGZldGNoZXIsIG1pcnJvcnMsIHNlbGYu
ZCkNCisgICAgICAgIHNlbGYuYXNzZXJ0RXF1YWwodXJpcywgWydzdm46Ly9zdm4uc2VydmVyMi5j
b20vaXNvdXJjZS9zdm5yb290L3JlcG9uYW1lL3RhZ3MvdGFnbmFtZTttb2R1bGU9cGF0aF9pbl90
YWduYW1lZm9sZGVyO3Byb3RvY29sPWh0dHBzO3Jldj0yJ10pDQorDQogICAgIGRlZiB0ZXN0X21p
cnJvcl9vZl9taXJyb3Ioc2VsZik6DQogICAgICAgICAjIFRlc3QgaWYgbWlycm9yIG9mIGEgbWly
cm9yIHdvcmtzDQogICAgICAgICBtaXJyb3J2YXIgPSBzZWxmLm1pcnJvcnZhciArICIgaHR0cDov
Ly4qLy4qIGh0dHA6Ly9vdGhlcmRvd25sb2Fkcy55b2N0b3Byb2plY3Qub3JnL2Rvd25sb2Fkcy8i
DQotLSANCjIuMjkuMA0KDQo=

--_004_SJ0PR22MB27953575EC4D45F9CFEB4D9BFA1B2SJ0PR22MB2795namp_--

