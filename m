Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A3ECD98ED
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 17:58:29 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.13])
 by mx.groups.io with SMTP id smtpd.web11.16338.1725559106381916471
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Sep 2024 10:58:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=rCSC1IvD;
 spf=pass (domain: axis.com, ip: 52.101.69.13, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzrRulB+Tx5c17od3gpaRqTueFOqSat/b28YkzNPBvUQvqHYv7WJ0nheB9gj7/nemnPBzt4s71Pu9dO155mhewIeGLuN7ltgQFUmGV7Roqm1S2PETWdxjVIKw4CpYntL+iudBG4NOyvpuUEjSKeRe2PMTVlkX8lz03WJDxv3zN8pRd1uIhm0G8DsT8UgI/M0qfeFEN+tG0lTOqzFFfIToisME2luPz0uDcAfjl6BiLTAYCKXgTxamP/InAm+zzC2ECmVfNoGcQezqjS/pvQu0oW/eCeKa1gyRke7yH+pDRHBC3OajfX3RD5TPxaCPP0IDEN44eHc1LaN6YV/mf26wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjb9TBTgewB+C75w15lfZYCEMOXUTXDv9zg7OlxOcFg=;
 b=Wrqiwr1fZ1e53Q8PhiISCm6rc2+fY2KWkqroPJksUKVdesVO3LyfClGRHuvuf0ig2hzFTbPUXMdKPd/CJTSGi71Tno0vgxOnsEgRbPMGdC923KbCfq9HLJqRevVyegei8XUzbB3RkFVTzhEtszRS5fq9ou0U7IRukmUtaTW/C2FV/U0zuKZopsN/tZ1/A30b6HgdezwOMktLctXmAFbzUQteZbcOwJbhLr4cYlclA8BTxZDaRqFcqz7EjBt9GRno9orXrXPx0I6zwJv1Gkrv6fjGvY/PkjBhSipDCElVkXK0j1L8cpP0Mf6x5bYlJI8OLtblENERv3EWWqnuQoDu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjb9TBTgewB+C75w15lfZYCEMOXUTXDv9zg7OlxOcFg=;
 b=rCSC1IvDL7i/2fZjZeWN/i3oiqCacOqiWTg+DkgfOaEEXTOeU/y2siKq/MUYLGYXK47nOEbYypglItXzmLHK2cOBV1qmDhluZF8DSfLhc9VkHrfBgyX++3AfPr9S++Vc9SlIhP5trI6HiTXuJS/w5dt7vzVOIhqOdLcSY9OhZB0=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PAVPR02MB9618.eurprd02.prod.outlook.com (2603:10a6:102:301::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 17:58:21 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 17:58:20 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] siggen: Fix rare file-checksum hash issue
Thread-Topic: [bitbake-devel] [PATCH] siggen: Fix rare file-checksum hash
 issue
Thread-Index: AQHa/6yX1CQHvQmFckG2/qg8x3SFzrJJee9A
Date: Thu, 5 Sep 2024 17:58:20 +0000
Message-ID: 
 <DB5PR02MB1021347F5CAB0525949685060EF9D2@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240905155909.1595157-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240905155909.1595157-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PAVPR02MB9618:EE_
x-ms-office365-filtering-correlation-id: 0cdbd37b-2e8e-43c2-df6f-08dccdd45431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?0vd+JtGzCkA2eqmN4QsTr8Jc3z1adlF6Qcoq1z7k3Yg5fvZJtNHi3l5qsJzG?=
 =?us-ascii?Q?33cwE08nyZp2N0oOFp4kztJw+pmnNj/SfCfRGoG1da3WJrS+5Wt2RvvQDxol?=
 =?us-ascii?Q?UVbjmVxYUlREJeByUizZ0Fm/vw38hlTdrkvUl2ILXuq85VSp2uAbt7ogR/Uf?=
 =?us-ascii?Q?eX3DsQZKn2kgO8xZG8s8WVTA4LKWBR9zchnIWkqSW7cQOEpelE4VWZ1ubgx8?=
 =?us-ascii?Q?UtujBpuLsM0ii3lgXR3iGnHQ58WuJkoR5TJD3YxxO1Eo0kaBFRBSZ8gsrQqU?=
 =?us-ascii?Q?tGpcXZB5wgLgehl9vIRPrfu9DVX55xT8xvUKRUIacA1mdRJX6n58VI98LVkM?=
 =?us-ascii?Q?O5CYDSTi8MVVBtK6aSZOGVPmFsIMKR6NyaPCN/kbLiX3Tvle9k6GY1sG+jRS?=
 =?us-ascii?Q?poHPxUSLfH3JG05QPgQOkQhevKaOFEKZXWhIyg4eXiab30A736xWRD1UuQ8q?=
 =?us-ascii?Q?OfCzc/PVQvvdQI5qCYG7kaOTNjpvHlAIYVDwiRvJ0Apz6I9CChypIfHyqLNy?=
 =?us-ascii?Q?NHjMydFYSSffCH29IMDXito1hVs93FOVdlqyu1h9i+2R9Ky0a8HYsMTzqksP?=
 =?us-ascii?Q?I2gGCeplQWWo3FsAqJoGtXyPchBo6R94337NXzcTxXkzGTbSMQTCuF0NL89B?=
 =?us-ascii?Q?vUqatN4hPok9LTj+GVbfnDZzsIZvaTkpg32/ShXIkmex/8UVwNtjoLVbr7Ss?=
 =?us-ascii?Q?bSuKSGV0XV9yBId7R1yu0PTRDhfKSiknamMQMH2K+R928VxbVSTQwvffTyr1?=
 =?us-ascii?Q?hPsOJn1/PhwhN3eho9PIw2jylWG1iAnn1zl4TdXk9C0C5QGB05silZSJXeJn?=
 =?us-ascii?Q?g4h8S71BSqviybk3aIfYmEZdHXfRjwdFzLTigBrSfvsEnSqSvh/35RL8NoRF?=
 =?us-ascii?Q?p9G/2EpXoXxwySyH591HeIvBeQn+jaLWAYT6r7F8hMnAXRryR+Tbmv/398fP?=
 =?us-ascii?Q?jXxyxls+QMLf73izcjgOMZOp9Sd1VtQaA0Gxt1S/JmabZGIaNpfMhZbVPgMt?=
 =?us-ascii?Q?XUyFWr8bQNDBDTnX09hJDJvQpbY4T/eZ+w1qZTsW7oCKtX+PTEJsZo5DKl0n?=
 =?us-ascii?Q?675DuDf1YGxPYp94jdZfM/oTq7FLmiMKxdeW2RiZlNSLl1Ka3OEnWmlo4jq/?=
 =?us-ascii?Q?ur9VrR4G+2nMhwNvy12tNXNxbLRaMV1tnMecUitHS7TC/O/HdzGPwpZ5tLW2?=
 =?us-ascii?Q?Spw9qRxKrPemGtFSF7/VE7WRdGTCuMP9uP6iY/3W3UPnvOX0qoPKLENv5+7Z?=
 =?us-ascii?Q?zZk++2lxBIKeGiRly0BKN0v4IeV55TOgojEps9OuXEVuT3ErvnizUT5GLM1D?=
 =?us-ascii?Q?K4lk3Kdwh9pFg2p3DgMh0Pt3URcLAb8rab/ZhOdp304ir/CguXOwZZkM3WCr?=
 =?us-ascii?Q?Qo+zuhRMn+HmpCSb7fFcibmzTomD0lm5WPae5fRU1mZui7yzyg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?e+8PaWPkhAJ8/rNXcuzhWRQWYLSSBz1XiEFr9atxV3xsB64VGFaO+YeD+mls?=
 =?us-ascii?Q?JDsWHmBNBejVjZ60w6CYR8eVxrzUUVj+5/IiLTZ4bZ8BmOFd1egrxK6fb+Jn?=
 =?us-ascii?Q?+bUifdK+TiO+Ad4gXVHwT+qlSia8Q5Yqz0E8rmOlLWPeQUGat1uu5CNFwyCY?=
 =?us-ascii?Q?ZfEl59BQX4hVYDSRg/pQ1X5TayXtmSGurYmJIlPhyiJLnhOlwOgMN4QdN1wE?=
 =?us-ascii?Q?lnyY3K+bVRkqqTpQcjfrHfpuvazdfEglsEeCgw2ArHbZO8q9OVFpQHJilx78?=
 =?us-ascii?Q?xNVBt33mT3Rgz10nAZ0pygNuZtaVkpbI1/4IOzFh8DaadIglH1mzNBxEnzrO?=
 =?us-ascii?Q?HJ8tjll+q8Tpmp6UpGJEFf1xW5P6IU/j0egO986rWNqdst2oPGPNhz8Pp0KM?=
 =?us-ascii?Q?PIpMMTA2pMx7JeyzLW6da/1HtIwQAM/5SHy6n4zT1hEYhnpNu65BFoRZpbdi?=
 =?us-ascii?Q?RImOyALL5UjwC4nzkwzOuimh0AXE41NsDfTI6o9fz9JMALkzw3iwUJm0AuqW?=
 =?us-ascii?Q?Tgw7wwjxRrplyfFk13mCWTlc7JB91Cp79F/A2j8BnE2m2E9NnpuZnbngeMrB?=
 =?us-ascii?Q?HJSMHJusCcsx3bQnKnVrQn3m3ILOJ/LWLI+cDthX468nVZkj2+mBUE6YMbfA?=
 =?us-ascii?Q?XpPshIn8Td269BBLg7lEpuagcypp9fir+S4tvyiGtB4IzVenPjopkeQB4PDN?=
 =?us-ascii?Q?xLAzcPWYaxo3ABwERomihupJvW3jRqxcnoKPwOJgUT1UboixeUy8QU99rka1?=
 =?us-ascii?Q?jA8wwzeqxBSYZ4v8RoYawwdCH+rM0vCHN9YjFBmQPPr5AKyRnVVB5AT4oCr8?=
 =?us-ascii?Q?GolsTKakJyug9zPp32xYbuH2dUigAJV+IyiUINtp+Ijz8nMeEXJEDv1IegK8?=
 =?us-ascii?Q?RTkJWsCG5jVjBcjyLT0HWCvI4+TLpKBGeTEN6vhRAdZdfrBvFDH+5WTJweGD?=
 =?us-ascii?Q?YoU6iIRO8VGUEDYy/VuvWMnRZclWULddFa6EtFqhdSeggJbzfKLsvZkgYd4z?=
 =?us-ascii?Q?N4o6zvFGH35ste5KOGoOcn6iWhWsVSqUKAMgclOCU3bnZB/NMs/P8GOKmMBN?=
 =?us-ascii?Q?wgj3FLmGKpftKS33E4t0Qzor8/9n3elJndkKaIE5+UZwJ3ktNh4eC2PUEmqC?=
 =?us-ascii?Q?JYPsHfaSZEYVL3HFVf+l5JTBIOL+w6rAX4vX2XGzC2Ktxwgjg/lF/flh/mbf?=
 =?us-ascii?Q?/PB07J/aRCyA1c4jekfoXo/U5LGzp8cE0D4V8hW0xBudztkhuzunJ57m4KA8?=
 =?us-ascii?Q?bmczip5CVsXGLVjSsgLabhHvHwSUrwWiHrGBXqbnONDrR23sQWqyFpn43Bp4?=
 =?us-ascii?Q?tb+5J+az4Q6M5XHpth77Ug87RcSD/x0cnfHk3hsxrLYDqvfRh9rljwpV2LzY?=
 =?us-ascii?Q?t3z+vsAxZ3VmbYirFOrQ1p2GUJYzlYLtdoVu6LMKWYpyY1qKRBMUj56gmkos?=
 =?us-ascii?Q?fD7hErzMv4+sy8/mWY7FJJOUmbzNhGFA7woNgj2FRwx2jKNSdAW0mS4nnMax?=
 =?us-ascii?Q?3z8h5CayK+rRXehjSF+Q1YsQC8hLnw3NCI42zNmb+ao4CGt+0oVE7s/XXrXO?=
 =?us-ascii?Q?JfxKbX/PLhM4bbHMgAc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdbd37b-2e8e-43c2-df6f-08dccdd45431
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 17:58:20.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 281BaPX+zHiIo1+8SAM2TMgunSnGWpPJPkeg8AxyXI79uxB9xUIgPlrbYUohWO4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9618
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Sep 2024 17:58:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16541



> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie
> Sent: den 5 september 2024 17:59
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] siggen: Fix rare file-checksum hash issu=
e
>=20
> There is a subtle issue with full pathnames being included in the
> file checksums since the sorting might be different depending upon
> how layers are being setup causing hash mismatches for recipes appeneded
> from other layers with differing directory layouts.
>=20
> Avoid this by filtering out to the path basename which is what is written
> into the sig data anyway later in the code.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/siggen.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 8f24535528..a6163b55ea 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -878,7 +878,7 @@ def clean_checksum_file_path(file_checksum_tuple):
>      f, cs =3D file_checksum_tuple
>      if "/./" in f:
>          return "./" + f.split("/./")[1]

Wouldn't it make sense to remove the if-statement above then too?

> -    return f
> +    return os.path.basename(f)
>=20
>  def dump_this_task(outfile, d):
>      import bb.parse

//Peter


