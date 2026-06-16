Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF65ACD98E1
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 14:18:38 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.155568.1781619509412828525
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 07:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=obk/ihPJ;
 spf=pass (domain: est.tech, ip: 52.101.66.4, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaVHlxCba6ZW0wF36aJU9xZabQG09CHJNDhFGJ0fsn2a+SJ2poAOoCKRayBrlBbF0XAtNtsnpHzVMIVupJmfh88VbwcdR/9vkqcze69LA+ndpPkPTLuF/OWaoMS/0lmuXCSCqIi83v/hYP42zSCXCwO+LfKZkV1dG5UcWLFRTTtB6hO+gbhSyZQZbuQFXo0rKCwk9ixkCHVqJP4LlmmFzFebiZ59vBKn4jTr6sbKWMYrOOf4XxvTyvNTcQjWse9CwcjqR/UQUWV/bvyxUV6sDoRTMLxOYTFmXfo1Qqxs+K+mGEEgNuighMRuXhSVui658PWfn5OaY7SQBhSmnQCUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp0J58dj5K4Lg83vUPkuwQ3AfA4DY7b6ekY4Cm9ivI8=;
 b=uXfxD/e9C3xA1lJPr0Plrm5Yo16vB5irZJ1rFxTenp+/EV1sF90lj2DsnkR10m5HbxJ8pGWSYA54CO8MXeA11L/qVXyFBn/xHCPQo0tY+P1/34PmdO89fZPU5X+i+e+dTkJkGJlEwZkfZRQMb0+QwYfuUXEGS6fc+iXqjxhkN5UIy80DiCmtVrRhGb7TekSG5xRaJuFxReNTVljtAMYXiOk/lRghD6aHmRDlABN9hID4Z0MXb4r6VuRIDPoaHbE7c9PVQTrRiNYVU8Axs45LiXfx2InzlkB28jAEXgwqHaZJqqvrrwRTdPReXmNLefbFZ5qtgIaYDVhSz0Fsvhi/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp0J58dj5K4Lg83vUPkuwQ3AfA4DY7b6ekY4Cm9ivI8=;
 b=obk/ihPJvOfaHKmYCCLlI1ZXWUjA5pFVx/a98fyna9p+PjqyoECJss6TCsLWVwaBzTMtqQjtbhGCSo4qEVJhR/Vm/bgYn49J/v3oc8p+tKa43VEWUv5uyjsaImfJXr1vlPl4k3e6hp8GOCbIs7j+TzJrmloqLtKjSNxg2fgiexu9wGmLAGmbrZY1+bPDYbPFA2KXCKLjquTAuAXe8PqYdu4LsTdoSD+R2Kbtjs3bYS5pI8UiSkmrnRnWoDQWhj1TFh3oqHZW7NP8oiwQoTulEVcmzZ4oPqXvv18VRzVUhuttLowCfjary6Yf1X4FZfB22V0zQ5KImjlXubvMIo/EuA==
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by VE1P189MB0910.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:16f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 14:18:24 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::566d:7425:a795:5560]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::566d:7425:a795:5560%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:18:23 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
Thread-Topic: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
Thread-Index: AQHc/MEmemh0KfEkr0iryPC9iD+ZPrZA9jiAgABA4kU=
Date: Tue, 16 Jun 2026 14:18:23 +0000
Message-ID: 
 <DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
 <4beac8227f89f57e5ae0984a5163685132577583.camel@linuxfoundation.org>
In-Reply-To: 
 <4beac8227f89f57e5ae0984a5163685132577583.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU7PPF66507B2D7:EE_|VE1P189MB0910:EE_
x-ms-office365-filtering-correlation-id: 81903c89-8908-439e-d923-08decbb22039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|11063799006|4143699003|3023799007|6133799003|8096899003|56012099006;
x-microsoft-antispam-message-info: 
 ooinerxHABUWmyJUsdA0fDYJPYCq9BE4bJwXzBBBh9yYj1O3ugq3emcLGMAhfN3itfWSmReTgYAOLPirEJMQmzyWnqj6cjJsTGfYa0y7YMz+gDdjBGl6Ri8A7E6rQDkACCTdVAGLoNwfRI+O6aiuf1KYhzYMJXsTtCbhkfBQdF+/VnXF1DOSoZI4qukRIdZHhGW74nYibd/tpf+4Term8pOyKUzosvw3bSHzKSfN9ApXCr1TcrneClt65Q/PPtNgMhT4GmrsC3pbHn9bo+4bAYhwJW0dRojSH+cOiu7ntKMzfloP9Wbg9Sn7OJQofCo9U2hJHRZXcjA9qdAqREnr4Ng1y3YAsjVrnhPsZo5+oNYyDyIwU6ggWEO/JZxJr2l05aHes1Mixujcbns1iUlAjgbKAUK8qcTRkKCx2+o4pRYL1921Xyit6W+HmzU6Y6lr3jGh/3/nZoMkMFEsURyQBeL5XeelsuVu6Rwm76i8PsJOspOLAibkVXw8YaBocNUJIMZaH4LM/DiTIjKWHmD49aXtRjZdIQpaFa8uyUK2V21o2uFvcc+WyGLCof2dotsFg7bglAW8oJHTn1PQrlwYmVwrL3KczTQ9wrJK1Tp1AOocDR42bhVT8ji9mgU32MjDKE5IqvyjiIipp8qlPnvV/khbow2kX+mUHGiZ98+CydO0TqWfSnABxshQgsyJr7qDUNc8w7ssNFpCOBDRtePSW2y9eLBvsZuwsYTeyN4HnAPuYOsabuBDlXnmV9SDKBqg
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(3023799007)(6133799003)(8096899003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Dv8LMbVvabf7/4gGRKh0O91N7jh3SDSNegpEMMwFdth0907pMLGLq2jQ?=
 =?Windows-1252?Q?AS4fQAluaFmOc9FWsCo4KxP28gcKmxiKE2L5EcW/XEr0iUWoU2Zm6ZIS?=
 =?Windows-1252?Q?DDRZ0UXS35EgaROEbZbOOhNpPTC0eka/syZaVD5NJsmZ5oTbh6Szqoyt?=
 =?Windows-1252?Q?AtqqWoIe7z31KoH5nJFjc845PgLU+RZwmDCXk/wcWIfyRict0Kb4gSyO?=
 =?Windows-1252?Q?9OZNVRTqsfzhZIf6el72K7jd/+OVgdhsGRSAd1ruLa42ESyqHFIrUGlT?=
 =?Windows-1252?Q?rQwxtsMOMgLKxFme1UUos+7bD00xWMhN0yoxg4JZE32hsIng+JuRa6x4?=
 =?Windows-1252?Q?Ddo4Be3FPmgrLoKH44xeOf3UQzYcc74P/Yr8wNh8BDC8zq+Pe4VFpMY8?=
 =?Windows-1252?Q?rTBILwq0l4p/pYoIZPp+jN6fi5dhDSviHWBk5MXmtR+HJ7HrluMTZeo3?=
 =?Windows-1252?Q?Xt5rxnknh8YsCqzIfBCT7h0T8JQax4zy4GfbzY6jRcnfu+Xy2BfiaK3R?=
 =?Windows-1252?Q?uwphGrY+YaY/9ROSLZN/1upoawAdIvthG7F2SvIP31kdkQfu3vSKdEHy?=
 =?Windows-1252?Q?d5SFxXjbIhmHHVYuEuLLhsjkRW8u5Y/eviR2+XPEHRBwhnGjuFUiF5dZ?=
 =?Windows-1252?Q?oY6IXqtGz1kyXVOfSGT1vvQlXeHxKcSI5y4EKC4Z79BYctagEqQguHzC?=
 =?Windows-1252?Q?TqdmOTCwj51KhM1dQafumdINR5ap0SRFV+8659RZqYjtAiImjq1MgZJM?=
 =?Windows-1252?Q?KBSZVthZTttyrLWDRtDVlM0IeIEfysjhveFFho2CQpZDX0u8dQrQ7xxL?=
 =?Windows-1252?Q?g+GATKbhkhMyXs6maK1IgXIGpBtEuQ+PGaFKIr4zAa9yPL3OHVUOxqxP?=
 =?Windows-1252?Q?jLskNFNBQ/RKhWEbuYoVZI6VfaTEItwAYOngP3KwD7sXLW/AFpo8xrBM?=
 =?Windows-1252?Q?5k7mVFljF6VvYIdRtZKLonBp1EEKEM6d3ogeoZ5DTtkIflVpGhvkygpV?=
 =?Windows-1252?Q?HgBQTy3TGCoc40h9AGdtuFLQR6XCQTWsCsmaBU3jhG0pRj2d7w929cIw?=
 =?Windows-1252?Q?tfxx1GtrFAmCPoNDQeCz+Dhs0aSACvNwLcD1V4zWWvOrEE3+PkTWQvZq?=
 =?Windows-1252?Q?/0YrHrMWVkxFIvuYPmTbggb6zZeoZ5imISum1M2PmPTTUxsv4yudjvQS?=
 =?Windows-1252?Q?b0veSCFSHICHWug1J9fa2VytzWZsikObtpvpI0Qgjbtu2H4wLKONnXJz?=
 =?Windows-1252?Q?r4oHVgYdqcOoTJGfiZgm5IuSEWfQv+wZquQrPGhA+sCi9UyX+tlMbvRq?=
 =?Windows-1252?Q?hEovYSoCAEhzB4psiDQGj+JQoQUi/kg1noO6jkwPPJhrjlQiJStPsRFD?=
 =?Windows-1252?Q?xZ37yWuiveiGODmaobaodiC7cKaMyATXjkKGSuXZCt13ky3vv1dRtpbS?=
 =?Windows-1252?Q?6VMUyXTEsBh8WS0C+FMMSpg63Oz03N/a6X0s+OI0kBfP0Ohnn9cU0Phu?=
 =?Windows-1252?Q?3sn7tETru3J0hJO7MztZJrzLh9fDXWFqzJ8MXUUSt46OSLGHHLjlwQGw?=
 =?Windows-1252?Q?oax0ahy0LEUfe7Hkdf48six0qLmkJYoCAZSYWQumhedLo8gsqD5b+LXV?=
 =?Windows-1252?Q?AT1Hcb4kEqizMNBVZIsAec18gEJ2kSmGRoCJS3osKWqI+wgxQHdTxuOC?=
 =?Windows-1252?Q?xdc+3LbsjyA3rwudIg5xewc8YU1YogZzn+oQAOfOkMOvXV7dpJ7e+iuQ?=
 =?Windows-1252?Q?KQxMZZebZUjIBYXV9WfiMWsamKKkk+eVRSB8f7h5P5yF3TJQla93CTSv?=
 =?Windows-1252?Q?fJ4/YgdUJCbg+XvzPicvQppkScXInu5fxYA4EoW7WEF40lNtUH01FKs1?=
 =?Windows-1252?Q?9GXsYtNdI4kWYUBzZ7wR/uTKxeDgJLjkVTY=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52DU7PPF66507B2D7_"
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81903c89-8908-439e-d923-08decbb22039
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 14:18:23.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mly9rZ+zYfy+t+8/T54X76fPFjDKzr8fWWpHeku6cQ0/IzOAeROtHhgkUkF6CJAJeRPRRZEVbn4bCoOeZ+ktRZg3t8CYXDXk8g9thEycRic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB0910
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:18:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19708

--_000_DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52DU7PPF66507B2D7_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Agreed on removing --sdk-name  and I have sent Patch v2 for review in oe-co=
re.

For --no-check =97 I'm fine removing it and having the install-buildtools a=
uto-detect, but we need to decide on the failure mode: if the checksum file=
 can't be fetched
(404 or network error), should we:

(a) warn and continue the install without verification, or
(b) hard fail and refuse to install?

If (a), we're effectively auto---no-check on failure, which may silently sk=
ip validation on transient network issues. If (b), users with custom/local
URLs that don't host checksum files would have no way to install without us=
 re-adding an override flag or having them to add checksum file.

I checked the history why "--no-check=94 was added and it was part of bf902=
a810f98f55dd9e8cb9e6c6b0903f9902157

What's your preference?

Based on review verdict on oe-core patch, I will send patch v2 here.

Regards,
Jaipaul Cheernam

From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tuesday, 16 June 2026 at 12:07
To: Jaipaul Cheernam <jaipaul.cheernam@est.tech>; bitbake-devel@lists.opene=
mbedded.org <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools=
 options from config and CLI

On Mon, 2026-06-15 at 14:18 +0200, Jaipaul Cheernam via lists.openembedded.=
org wrote:
> Allow distro-specific buildtools to be configured with a custom URL,
> filename, and SDK name via an install-buildtools section in
> config-upstream.json. Expose the same options as CLI arguments: --url,
> --filename, --sdk-name, --no-check. CLI arguments take precedence over
> config values.
>
> This requires the --sdk-name option to be available in
> oe-scripts/install-buildtools from openembedded-core.

I replied to the oe-core patch, lets just remove the need to have --
sdk-name, I don't think we need that. I also don't understand why you
want/need the --no-check option, we should be able to tell if we should
be checking the checksum or not? If that means fixing the install
script, so be it.

Cheers,

Richard

--_000_DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52DU7PPF66507B2D7_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Richard,</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Agreed on removing --sdk-name &nbsp;and I have sent Patch v2 for review in =
oe-core.&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
For --no-check =97 I'm fine removing it and having the install-buildtools a=
uto-detect, but we need to decide on the failure mode: if the checksum file=
 can't be fetched</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
(404 or network error), should we:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
(a) warn and continue the install without verification, or</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
(b) hard fail and refuse to install?</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
If (a), we're effectively auto---no-check on failure, which may silently sk=
ip validation on transient network issues. If (b), users with custom/local<=
/div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
URLs that don't host checksum files would have no way to install without us=
 re-adding an override flag or having them to add checksum file.&nbsp;</div=
>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
I checked the history why &quot;--no-check=94 was added and it was part of =
bf902a810f98f55dd9e8cb9e6c6b0903f9902157</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
What's your preference?</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Based on review verdict on oe-core patch, I will send patch v2 here.&nbsp;<=
/div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Jaipaul Cheernam</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</div>
<div id=3D"mail-editor-reference-message-container">
<div style=3D"padding: 3pt 0in 0in; border-width: 1pt medium medium; border=
-style: solid none none; border-color: rgb(181, 196, 223) currentcolor curr=
entcolor;">
<div class=3D"ms-outlook-mobile-reference-message skipProofing" style=3D"te=
xt-align: left; font-family: Aptos; font-size: 12pt; color: black;">
<b>From: </b>Richard Purdie &lt;richard.purdie@linuxfoundation.org&gt;<br>
<b>Date: </b>Tuesday, 16 June 2026 at 12:07<br>
<b>To: </b>Jaipaul Cheernam &lt;jaipaul.cheernam@est.tech&gt;; bitbake-deve=
l@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<br>
<b>Subject: </b>Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-bui=
ldtools options from config and CLI<br>
<br>
</div>
</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;">On Mon, 2026-06-15 at 1=
4:18 +0200, Jaipaul Cheernam via lists.openembedded.org wrote:<br>
&gt; Allow distro-specific buildtools to be configured with a custom URL,<b=
r>
&gt; filename, and SDK name via an install-buildtools section in<br>
&gt; config-upstream.json. Expose the same options as CLI arguments: --url,=
<br>
&gt; --filename, --sdk-name, --no-check. CLI arguments take precedence over=
<br>
&gt; config values.<br>
&gt;<br>
&gt; This requires the --sdk-name option to be available in<br>
&gt; oe-scripts/install-buildtools from openembedded-core.<br>
<br>
I replied to the oe-core patch, lets just remove the need to have --<br>
sdk-name, I don't think we need that. I also don't understand why you<br>
want/need the --no-check option, we should be able to tell if we should<br>
be checking the checksum or not? If that means fixing the install<br>
script, so be it.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</div>
</div>
</body>
</html>

--_000_DU7PPF66507B2D7CFA2CD308AAA2C04622AF3E52DU7PPF66507B2D7_--

