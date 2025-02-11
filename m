Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39301C0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 16:22:46 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.55])
 by mx.groups.io with SMTP id smtpd.web11.3397.1739290956405040499
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 08:22:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=B5R6evLP;
 spf=pass (domain: axis.com, ip: 52.101.67.55, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNN79slP8Rgk1t3aXAGeC4g0nFGlEdMDYPABil+jftoLSu7Y6OTqD6erBr2Rx7RQST0LQ0WJSq7eHD8miYXGiblbpTuNgpCd9N/lTxQufiYNQaRxxVBWo7q3JDs6SDrRTqfLKtYyl7dKDNXS14RFaMZ3rm/GH8rErWzYc9VINltU2iJf+m9E90t2jr2D5x1+dNZsKkxI4pm4Y834jpeUKNRXP202XaX2DZhSEwtpufJR2r9qVuZjouZ+qQ5K1nmhDdotEJOPhoR8/doJsz4vh+4PFMb7iBAXG2zP+3btUQdBa/5udERq+IL1Mxdi2rKZmd4RI2Tabxv/JK0irOPt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CFI8yf+DikDfj97NHhtuzFJgBh3Hf9Hu+ubuIjOq+k=;
 b=FV7raMfzKNjdWy+7LZa9m5DSlpqrFuCS9jQlm7MimaQ0ud4RtCehxpe/nmZNocsFZeX5UyKbcGX0pz6SxkjrbnZvRdJu4VDTmJPZcgwQHd0lSD2GfPSQHRFoTR+i2K3FB6N9Y9QcDvqd1GjhImzEQ/Sv4s947xXz05NksZXuPjPq/qmPDCjV6z/aNZV7XkhAt4a4orSHTmRekOI7NHpU9DVQyUlPbnIorA8hmhvXhipe1pRkrUnHdr6cTOiMIcvMGnAiJrViGaIkekGcpHf1eVdlecmZU0wbRzP6tneNMr5Irta7xCwQOrICZ3bSRaOysClMF8ibQDaPEe1lQztTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CFI8yf+DikDfj97NHhtuzFJgBh3Hf9Hu+ubuIjOq+k=;
 b=B5R6evLPl/ifvF+tMFoWVD9zaviU8spTP6RLxYWGvk/xt8NRdSuD/bBoHE3w2Y9Z/gCR87mIGlvjvAVqQPifMbdOZyYuuCnRAJG1pu24JsuKTchYHuqAzrQ4Q1xzr8KfmmqJQDAIjKfJ1LQsIgjkzueZ7kAe3raOjH8Q1hvRYbE=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by AM9PR02MB6884.eurprd02.prod.outlook.com (2603:10a6:20b:2cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 16:22:32 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 16:22:32 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "stefan.herbrechtsmeier-oss@weidmueller.com"
	<stefan.herbrechtsmeier-oss@weidmueller.com>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add
 SRC_URI_FILES variable
Thread-Topic: [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add
 SRC_URI_FILES variable
Thread-Index: AQHbfJX+IYJ6OQ0qukCyKxHklPFNXbNCR7PA
Date: Tue, 11 Feb 2025 16:22:32 +0000
Message-ID: 
 <DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: 
 <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: 
 <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AM9PR02MB6884:EE_
x-ms-office365-filtering-correlation-id: 3d04de8a-fe12-45f3-51b0-08dd4ab84963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?jho1dpiP6bz2n/YZaqTIYOTHycYc8BkAq63mx9FHwGdNN7ltmamSmtIDI+AE?=
 =?us-ascii?Q?02RoL8O4fGF3AAJbEUjE7vZVylmX4j8m8cO6W+7s3wYzldwq6C87qn4pw8vN?=
 =?us-ascii?Q?txnSKy9e38BVnDJvDQBGaianspGFCLDYEm3Gm8Sa2SlqzYmGN6VbBLukU2NB?=
 =?us-ascii?Q?3zxQqrkJ0cBTd4GC1fLx0z0KXoHYuXfAfPazwBLVqfkvYLgqaeKxK8OzVSkB?=
 =?us-ascii?Q?f7Y8QoJJrLnKB0y+r5pMLClHoUzoQzBjnymUwyL1jWWnR4JmShxtnd4h+5nm?=
 =?us-ascii?Q?uiOsY0o7ZSeB478P5J9TtUtQhG7mg6cN9Ak8HcFuPClGo5nJg2W8qUxBCmfr?=
 =?us-ascii?Q?mBtLHX0V50VuLhegfygLi+NNsIl7DJcCP8uGYoelVXOHyN9iM2ZTzQ9gr+yI?=
 =?us-ascii?Q?63DDkiMclzPUc/i/ivPdkUVs476RclGVG26eUntN/Jwve+q5H0ypeLONF37w?=
 =?us-ascii?Q?MO8BozQYXbxN1NS6LAABJE9F5A25XD6SU6oxm0X5jtXqDIuIjGDY62QjxeHR?=
 =?us-ascii?Q?m5MABwlX9F7tUmP2HPxvwH/qliycss+c//ehtCJ4wEjIbpbr4ODGjfEo/Exk?=
 =?us-ascii?Q?+EtpvUoysVpmX4Qxsb/uZkUJhn5kVZqMWSEgPHmT4GnUDe06eewb5BRLGHMZ?=
 =?us-ascii?Q?PWSRl6rF5T/5l9OP2Z8VEQ2jPT8wAYnfosxenV+MKbY7cCPsQJ+MrSIgeMPR?=
 =?us-ascii?Q?oNeGzm32A9j7IZbi03c80ATjPlEAR+YMYdM3iXk5YL9H0VS9rwlsB4Zcnr6i?=
 =?us-ascii?Q?xLXppzWaX/aPpWJJY4dwYiBY5RQmE9Nqbnk8Hzgw1LrnvQUSRa7Hs3qi1B10?=
 =?us-ascii?Q?tq0zk31gZw29Xhru2DruoI662I1Qy0Cbk/sz9LlgtojRltSiVGXirGgfGc/w?=
 =?us-ascii?Q?H4LCtzMxMHGACLU1R54RzAo5ln0LeHZJ6jBEr2SdD+SktWi78qibGFHNZF1o?=
 =?us-ascii?Q?MXNrJDzPuiudDTi0QsjQJhNelPM2s1iTLgEQ/yMYEY4yDBBxBUHdDcF7MPK4?=
 =?us-ascii?Q?T57/C8kw0E6cjoEtIVPnGC/hbMpriIChj7nH8nHVEOGVHII7sV6DN+sxmo3J?=
 =?us-ascii?Q?ieDum1FKKinEFI9+tVSP98Y2uWuDxfp5AiI+2wuBHNjXtGoFlV8QjgLXccrI?=
 =?us-ascii?Q?gum8scLshRmSyPYxyPrdEwstUYZTFX0h39OAhkqct3FopHh+K8otyYBfN92l?=
 =?us-ascii?Q?3oFf5pWtmYRuaOvufqjedJ5UObHb31rwSZehrDFwtIZ9ND7JtSPZ1Fjf1Txt?=
 =?us-ascii?Q?V0rBtdmjKZw1H41b5KjINGlB3CxCmBZ45OSEAYluAYT4CnypUyj3hlpzXSj8?=
 =?us-ascii?Q?bTEorgBViEGcfIZtJoNxEt+j2E6GRKwxJ0/SbSHrRlw+hTW57VaNeYByX9ds?=
 =?us-ascii?Q?IyoCV/a0CgY+ZBfAQQFUokt6Idd8Q0Q88nnn6hkoJxR6vX1p5lEY6tFOAOfT?=
 =?us-ascii?Q?x2aFThL5aTI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dQDjZxMRIGH7Z5sdu1JkPJesQqX8PIXH/iXLuVY2ux+EFGif6uce9NfGJNK8?=
 =?us-ascii?Q?Fb4iHCWkdimKiKAvdzJdpMI9GDbbP1hf8id+aLWoB/MYvnwpitRNom7Z421X?=
 =?us-ascii?Q?7k1tqsGIU8YETByVPrwU3E3y2YEvksgv3Q2O3GHGAi9kFR0Klatf9of0Xtti?=
 =?us-ascii?Q?qKvtzCspuFKiSCW+rySEpuqEbAljVt+moyQBBBAtcXzAm6Sfo9EArwonHPwq?=
 =?us-ascii?Q?7OxW6vW7hg258ImKPLe10z7zVHtKm6UzDFWeB6/+VNmLtxnc57MfV7nEO019?=
 =?us-ascii?Q?TZj0UWBpG4mZaw402ACwPAc1aDXo6yQXPODFBMHZIk7AB4WDgvDb8KXGlMFO?=
 =?us-ascii?Q?7MnolqhgGnluZuZ+DhpWQWi4xiqXnbgYmezDVhsXJGuYWSV24h6jq+vJ5oa5?=
 =?us-ascii?Q?yvOcKlvRtlNAkmzBHeHqKubVkA6tALmOBrwJYFR5AEXhBBP4GQRuCkn0Tt0B?=
 =?us-ascii?Q?solMD7++vbBFdaKX+NRUBH7LpbKpTu15W89e8kgtLB94hqVF83mTaK9vKAND?=
 =?us-ascii?Q?urHDGCJtFWpcIXVYTAsOfYjiET2LJEi0BgRwKiY9vS1G+S+o+DZTn1PlyuQI?=
 =?us-ascii?Q?tF/0gTD2S6srCPcav/g6CqL91xMoug3neOhxvy/YTlieLsnXgIB9KEo9SIyh?=
 =?us-ascii?Q?G4aPRZyEzyFYbROdJv2s+oKvbaCJPLkddgMBci++kRUxLWYbIGNPaTjHc9eo?=
 =?us-ascii?Q?S1qU2PKl7jCsfF8cyt/zwnHzJanL+tPal+wIZZ/isqIIRJl63f52hb7Hi/Xh?=
 =?us-ascii?Q?ky5N+Z0xDzrfr31T1y6jbNpQKKKG+J5cXNylrCnBp8wvOqlg0K1DfjXNEaT+?=
 =?us-ascii?Q?cf077Om7A6nuAv9JTJfV6lGDC+ZYO0mzxAYSkEa7CtRjhFDxFVfHH2g5YMxT?=
 =?us-ascii?Q?gwmRhCIfqAlQegT/ewNN8KsI3Hjaf9DM8ViGYoB/AKK9EqSyDaOdp8EXVC/A?=
 =?us-ascii?Q?TwZpzrk9GLczTFObcT9q5HmTRFcDj3kSTaYgAc8IqA+dKQU5+g/pGALdRZyt?=
 =?us-ascii?Q?N7MrbafElGAuxp4rKFTFBM0qPeMpHRUlRcF7jN3/0N5W0xZaZNrldJoxBlCk?=
 =?us-ascii?Q?TbZB6TwJprZSFDf2AMsnAtPJ3RGTgAUDc3SQGsoPFVkNdUbVzeCTeI+ks3fa?=
 =?us-ascii?Q?onNVW+jNUpdIXhlDh58qB8UO9Xil5NujXMVgJ38xFFLzfw2rM4vIlsFYYyZx?=
 =?us-ascii?Q?5I81LdVaBxNvI9000YkRo+wKzLPJy2ASkS1l/KNAukBYKRI3zWg+nqL4Tvks?=
 =?us-ascii?Q?UOEocYGPXfHgp6Kxf7p9VUfShdCWwj8v8hOoqsqcwvAFQtqndW2aCliRSrgn?=
 =?us-ascii?Q?pJF6Stb5gFay32YgZOKtDlLyRh4e9JqUPg1RBxJ10sHK5/DJqxEVPPyk7C1B?=
 =?us-ascii?Q?WxDKW9AYsgDBn0JeFvWg8fSx1qSS39HVbaXReWdJ+Tp6IzlBn8DCZ8zT+ryo?=
 =?us-ascii?Q?O2g8TH63BMY9rD6WC7VfR850ZdZENZgsolllmMCX9kNRABh4suyXsMTb9bhp?=
 =?us-ascii?Q?q5jpBTlzWCjXABhoblQE1Wn6jYjopUwfGKaIkzweceqx1vSWWt/dSf1bXI8u?=
 =?us-ascii?Q?uZQ0AFHMRlgsfLQfB5w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d04de8a-fe12-45f3-51b0-08dd4ab84963
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 16:22:32.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yegfgLRTLuoenqC85FRw/gAEA2S9pWfLxAqERSdTm0kScXxKn+QfDecj65IsUA/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6884
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 16:22:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17194

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Stefan Herbrechtsmeier via lists.openembedded.org
> Sent: den 11 februari 2025 16:00
> To: openembedded-core@lists.openembedded.org
> Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>; bitb=
ake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add SRC_URI_FIL=
ES variable
>=20
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> Add the variable SRC_URI_FILES to collect files whichs contains
> additional SRC_URI lines.
>=20
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---
>=20
>  meta/conf/bitbake.conf | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
> index 8b607088c6..ed67500ba7 100644
> --- a/meta/conf/bitbake.conf
> +++ b/meta/conf/bitbake.conf
> @@ -745,6 +745,7 @@ AUTOREV =3D "${@bb.fetch2.get_autorev(d)}"
>  SRCPV =3D ""
>=20
>  SRC_URI =3D ""
> +SRC_URI_FILES =3D ""

Do we really need a new variable for this? Can't you add some parameter=20
instead to the URIs that should be handled separately?

If a parameter is not appropriate, then the name of the variable should=20
be reconsidered. Based on the name it is unclear what is expected to go=20
in SRC_URI and what should go in SRC_URI_FILES.

>=20
>  # Use pseudo as the fakeroot implementation
>  PSEUDO_LOCALSTATEDIR ?=3D "${WORKDIR}/pseudo/"
> --
> 2.39.5

//Peter


