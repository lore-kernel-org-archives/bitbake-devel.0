Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B8CCF9F8
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 17:09:18 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.68])
 by mx.groups.io with SMTP id smtpd.web11.3257.1761844156229261249
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Oct 2025 10:09:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=kLebLRSL;
 spf=pass (domain: axis.com, ip: 52.101.72.68, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNnUSX1DkgtnRevfkqj9ASSgAuU/lMQ2hioCxfHQqlIJ57UZHLetyrq+87Xycw6wfTuTx9VIrItV2ZwKx9jhLyA5zqSuEm79FFmemK9lmNe/DM2zCBQBl/IHRbzwUAl1u83BaRSVpM9GrNuh/sjjd8sZAIJkywWLdbol58z363ak0iBhEMJ15P52YDPVjJ3jkwMCIDmO9F+YdnYwwUx1jPADFF+E5Tf5mc3xIRNqCGGGk2nl3PejmuZBfZeGq+eMJWr155gDz+x/O972vVZKcVM2JbNqEfS0W8tI9RNUFInDwAQrhRk/xqzr5DbwPkwphcRKIpzCYwucb0dOPn4aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8r9zTu4Izg+m02BN8OLhh25SoZDViRToO9bidNJwP0=;
 b=maG3ELOtlKOG6dTJEeXu9z976Olo1Mt8msltZ+pLDpqKAWJK/6wKnrgj3OlXD7rSPxGXHJGGV8whnzhd4Vky0ulLgJqGXi+h2w+jufRK5c9iJUUGHaY9M/KUV3GPcwexh9TA0zm5DandDwCli8Lt9YBBuQ1thSShycd89eX4tkss6E4pF7Cd2u+7nt530mn+iU7IUhREOuIc8XSoXmKw7hcq43h8jekbq/3r8wwLY1VvRFgrqU/6hr0DMhXiOWrXBKxab1YCS7kj7mudyd2lIHdNlYli13sNlPuRHMqLuQEQ88XaJF+jZVVcqfXNPqW9M7n+sSFOY0Xx+vWw34lhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8r9zTu4Izg+m02BN8OLhh25SoZDViRToO9bidNJwP0=;
 b=kLebLRSLpzsoAB9Q5CqUsWtdW5CzUZ6sZKuKX2IpmOE/PYvNwogHbUTkkttkv5o22S1YsD+5zOxZfQpM0S2bj/0Xdc+mqE3Fks63pTIiXzT8L0VdZCTUTcGvMCh32tO0ffG391yC5mMe4IsdeRITrywF2s1C3QaoYQ9M8hlTrV4=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by PR3PR02MB6187.eurprd02.prod.outlook.com (2603:10a6:102:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:09:12 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:09:12 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "JPEWhacker@gmail.com" <JPEWhacker@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][RFC] cookerdata: Include "originating" recipe
 data when parsing
Thread-Topic: [bitbake-devel][RFC] cookerdata: Include "originating" recipe
 data when parsing
Thread-Index: AQHcSagy6DF8HHRt206H20WtSxC7M7Ta7B6Q
Date: Thu, 30 Oct 2025 17:09:12 +0000
Message-ID: 
 <DB5PR02MB102133B9E1450E0175B8576D4EFFBA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251030141904.69494-1-JPEWhacker@gmail.com>
In-Reply-To: <20251030141904.69494-1-JPEWhacker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|PR3PR02MB6187:EE_
x-ms-office365-filtering-correlation-id: 8d84de23-0667-426b-b841-08de17d70c6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?3fb21dUSMvifqkQs0xThgJkI9Y5nmYnErwTczu4mYb7+XxMSrbC2Ef1v2WtQ?=
 =?us-ascii?Q?h37eMonHSYyuD1XtewST60vGo5IhF/hL5auc5l1mT1zzUeWHYyn9qU5pZiSe?=
 =?us-ascii?Q?5V6fi2l4KKEIAiplJiaVfiQ7IZROzVceYkaXadxXA/IajaL2XICPjyBMceet?=
 =?us-ascii?Q?ik5wodJmQdJbrrilWY4Dyzl8Y2XKtV+wRtYPUBG4NrhfZhNQnfYQ2kUMkR9y?=
 =?us-ascii?Q?yBd4NBrZMPXeskGJzFQdACXlnCN33De70xiLbQfokFVd35xFE7QC09UeujhL?=
 =?us-ascii?Q?Nn+f1/Z1zi+ucjfQ0CKNAnuaN8nwIXSLXEk7rihGiJM5YGR7kKKcwxX5dN2c?=
 =?us-ascii?Q?FkMlYF+6BOlx4c5ZN+/sOBLLP/U/XeGXmObpOohhB+0TAUbNMuE52OfBD5rP?=
 =?us-ascii?Q?prVFgHNsiyTQid+7e2aYQgbxoYVbQaMxfTaO03Z0YbFbWfTlMs1BfpxJkPef?=
 =?us-ascii?Q?QCycVFYywIzmLZIa4kCAphwPy0m3xD++WNwaruxmOipNiYUEW+ZzAOY3EOPu?=
 =?us-ascii?Q?NLG0FMpJ7HyEAnYHKlno1Lt8MYmqzOkisJ9zRE+za4UaxnwCGeLOY5I7gjfM?=
 =?us-ascii?Q?FTwn2cSQWVEoY7NYDCypMUqcaRGIB8hAOAOcj5OtFfTQr7xk0FlB6ZeY++X0?=
 =?us-ascii?Q?OAUTrWA6ooabwvib7wQ1KH+zLP8QNCel4x9bBiXT0KW0kKmBaDFAkaZVvNbc?=
 =?us-ascii?Q?CXBYkAX09H99UDEwQ7YVWd9KNcthHc2VGYK1TRgfZMXGPenBITo2CHnMQTQU?=
 =?us-ascii?Q?UBIhAFgThjFhZMyXrPhB3oDgXy8qDnxZyoUTZx3j/eQiHV0dXqvXCSp8pU6c?=
 =?us-ascii?Q?YEm+DMqHwV9UnVREgHLVfb2e/xLg8+qkz6/dm+y+Xx7B2KOH54gg0TR8rB9Z?=
 =?us-ascii?Q?wVHfCbbVd8RPs3YlMm+wv6m1J48qe8VKs52OrVaRWiTV3b7wHj7II6ixc7gd?=
 =?us-ascii?Q?PACoq276s4cugw0yXLXPcY0UuqtUZjN16s1J2LikpgnBP6VaqROVi0KF1mUA?=
 =?us-ascii?Q?yNBikBMbseSSCuWq20quXmVwBs5zlwtONxtLk7zMVb1JsKbvpMJEnWDaizy4?=
 =?us-ascii?Q?ZE8Op56hNX21gARyzg4Wldi5DV6y/RPG5U+U/YOB1WwCxqJTuidrxiQ5GrVU?=
 =?us-ascii?Q?cOhWTSk4DfoJLhMazGrYsPYP9nnmyjLsKB4YI+CzLW0wVCrAOKN9vZYjfLYj?=
 =?us-ascii?Q?SwgpJReaFi5YXCzk/n/EM5xlyMGWjzpRqo5QXqOUGLVMcYsCn0kI4PHHr5d8?=
 =?us-ascii?Q?DOc2Z1AT3nmIVK8jw+L1o7sy0dnFWTT7NHN0I7RQYaXc20KxF+HVZIzs0Mgm?=
 =?us-ascii?Q?oNgl2i9hOY6P6Nr1sAI7cOijmrD0Llt90GsbIOEmskVgqdF51i7oU03S9qq6?=
 =?us-ascii?Q?dVMjXB0b9u1jO7KwCEmjoWxC0zLfOuJYBa2fcQvdEX34EV5Y3e8hE7hIFBbx?=
 =?us-ascii?Q?/kf5pHfX8t1eY6cj1JP60aJdACNsbfY4d+vtA2frW4Nh9V1Y+WKY1YX+Shxf?=
 =?us-ascii?Q?7+cJcU+UQcCEdWluOq4nVgbQPgagV8y/oL//?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bgaKZ/ViJf/8pN3pMlrazyiNMGUwzugafPc10NhD68gdc+Vpw/MjMOLH7ClR?=
 =?us-ascii?Q?VoFDH+RgFYQKN3vH+zenCbb8UtFqaalRulW6pqqBAkG5VKiSP19RrankozRu?=
 =?us-ascii?Q?oxQdYGLPtCEBzbYwe+PNn36ZMzrHoTP2FfRVvEAdJ/rD2TU5h8xXGS4awkod?=
 =?us-ascii?Q?tjk+gUomKfqa+MTv7k7NZEDRCh01Qg800S5393NSlikFZnriHX87cvh+H4h+?=
 =?us-ascii?Q?NhV7IA1QT5L31J6DoTb36xn1MvafXx30ia0xUCR55d2mPUXX1wRWCdcsmC+G?=
 =?us-ascii?Q?9GNIDIWeoBp0C8HQPIPYOJNY29Cqt3movvswJv36TvXSDvWdMgRUcCdXOrKM?=
 =?us-ascii?Q?3zcma13oblz73ZgZpcu7ibh9OQl7OPYh5Y4tBf/Pb+se1EchtfQdn06FICUJ?=
 =?us-ascii?Q?mtYPb9NHZIExNDts4bD0lfxFdIsPZWZw6Ng8cHC9qTOfXS3mJ2QwBEFWWCkZ?=
 =?us-ascii?Q?5cuMeg/zFenjGwBWocMIPMrz6y0kcu7kAFJwUwBIEhvIp4AyLAb95f64v2C+?=
 =?us-ascii?Q?aZ+K21sDi7UaaGBrAG/XPCCVWUXNBhmZIf+6vmQkZKEo5vv/ZBvrxl28ZeNK?=
 =?us-ascii?Q?oIWUR8KLnkt2kyTscfZP8r6mFE+MTr9VtIL+emmgUc75ihw/nYpjCvzcRRTd?=
 =?us-ascii?Q?Zygcu/+o47LOrWE5AsIRmr9dtacmP1FZn03iw0zw9wgtGSorDHRzCvPw9VtV?=
 =?us-ascii?Q?jtPTdCBgHYyaiigtDmU9yiR72uo94sbnIpUxb4lU0DYHZf7qpeiMpS6zHd4L?=
 =?us-ascii?Q?jwSVMY8ZbXlmxK4UMMOJMATb/UOjsDlRP6Dc9qoRmZRQ/Lvw1rKIu2evx3Q5?=
 =?us-ascii?Q?uR72Hpvu9HGtjeb6qkhhmrqzUK5GO9aG/oToRkgTX6RVdhmiuJ1R2ngLSfPf?=
 =?us-ascii?Q?Eawp/HEp78SgF0mmWVlbnA989J3fdDlzPsTRrw3WLh4xRlMQhDUro5ygBZNq?=
 =?us-ascii?Q?vvFtr+/O3nUapP8NOlvTG53h1LHyrv1fKrf8u1HBcNSzuemUlaiyjCaYGmWA?=
 =?us-ascii?Q?0xAUe8nXQmoIFdAI88p8zLRt6UzPewdhrvYrhMRtEc1afZUsExUjNfiEE2Vv?=
 =?us-ascii?Q?veSDw4uqQ9mAl+h3veYghQ4OJnUbqNvbPL13TR3Szmc7kQSwxUDX3KFks5wL?=
 =?us-ascii?Q?SYoJrjQJ3JHfqZdPjfRuZ4oz4MP1rYu8pT6QVSDUkY8U0Ws5/lQdSEc4yrdk?=
 =?us-ascii?Q?LjHFntHpk0bgynWdH5f4CAZohxhsVaNMgS38T5+aL9OGrxjDtKZ6urxcqJ9c?=
 =?us-ascii?Q?Ql/zcYtlKA0tIU2V/ob3YRXEpSCVeXeePT8hz4DIHUqkU7IYUlA1h5i1vcRE?=
 =?us-ascii?Q?1DvApw5WybeubZPjTUVEbwrKO74wq6Za6/HRoz/l2sCr9pGZVtCxJbTie2N4?=
 =?us-ascii?Q?JzQ28OGzVLW9rEXtsgXmmeTl1MrgPwU+IfMsx3ViU/LPqHwR5qSWgNtyi76K?=
 =?us-ascii?Q?Ax5+2Z7jATV1yYF5r7oDc+Vt8nVquhauJXBRP8dilYTOHMWEwxeVliMQxAUk?=
 =?us-ascii?Q?GP9NXFMPn3r8J7DRZb7+IuEhC5WWlRGGEt/EpwW3FCJK2zGQvQdO2WYksA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d84de23-0667-426b-b841-08de17d70c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 17:09:12.6839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvrP4u8RQE0hrEGYZmuTgR7nxALkkaFPwvbscyKLu58pQXzdp2a4lrZtqjFc4Vq/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6187
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 17:09:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18227

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Joshua Watt via lists.openembedded.org
> Sent: den 30 oktober 2025 15:19
> To: bitbake-devel@lists.openembedded.org
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Subject: [bitbake-devel][RFC] cookerdata: Include "originating" recipe da=
ta when parsing
>=20
> Parse out PN, PV, and PR from the "originating" recipe (the .bb file
> being parsed) and provide them at parse time. This allows .bbappends,
> .inc, etc. files to know what recipe is currently being parsed.
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  lib/bb/cookerdata.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 65c153a5b..8abf5e56e 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -504,6 +504,12 @@ class CookerDataBuilder(object):
>          bb_data.setVar("__BBMULTICONFIG", mc)
>          bb_data.setVar("FILE_LAYERNAME", layername)
>=20
> +        pn, pv, pr =3D bb.parse.vars_from_file(bbfile, bb_data)
> +
> +        bb_data.setVar("ORIG_PN", pn or "defaultpkgname")
> +        bb_data.setVar("ORIG_PV", pv or "1.0")
> +        bb_data.setVar("ORIG_PR", pr or "r0")
> +
>          bbfile_loc =3D os.path.abspath(os.path.dirname(bbfile))
>          bb.parse.cached_mtime_noerror(bbfile_loc)
>=20
> --
> 2.51.1

You want to include PE as well.

//Peter


