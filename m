Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A9EC88E75
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 15:41:07 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.636.1789400458921853252
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 08:40:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ME1PoIxh;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.53.32, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X925L0Rv9S8jxvWmt6icY23UJcDn7vJP8SSA30Q535y2nATJWpDvinA0dZwQwaIxYP8Rigs464vCLjSSjYuILhDo/PdVuPUo+LDDgZgQdH6xN2tQbM8831OX/ZSEupQtDDIR/M0lRauFKES0Vez26aPPE06+SI6dn3LWd0YCW5oLpi7d1Va18xc3E7bbHG9OGPufnW7z1TnMHC1CC+gNkX7QlgIRwmj5zJhTOTB4JLrDupL7qvagS27kJzsVA7ZFlxtAR4EpEF9JQkTirgjqPeodFY7gdf4O0OGxkEJVIIevLauMJhVoh2TmOCeYGcJQWpwShemD9CqF8i1L8LaWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3aKArbhHwscf/4iAcOgJ+v6x5gRdNv9Id+klW8Fryc=;
 b=Jo3hM3HcDWiZIbN9dkTJoQ3QDUMj4iDX92PHigSJXF850atAhv8q7kShjW/s+nWcJEaJSq+D4JRUHLqHiIwqUemldQ4OoTPrRE6Ug8zoqNVGimxhF4/ZN0caytvkOm9/n9JJHvJhwfWYr7O72+jb5MkKw0q1Y5MoppfHgk+uleGNAuI8fYSqcOxzjyPciM7Xva5BjK/I9jgDp3fURN0yiEs9CCTwE/1rxVZY58IME8G5ccgQDBchPkV/ENDTu9fXH62905fyP28Nw2OiohmyUQDZeOZvSJ8raKy4m82Z6oVWNFMDpbv/l00ymmQ1tKoonCdpWQDgxXLhufyrjp7ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3aKArbhHwscf/4iAcOgJ+v6x5gRdNv9Id+klW8Fryc=;
 b=ME1PoIxhU2E0/n83hjNCmMS1WNTvFtcig5bUZWUNG9s6STj5/vGWV/o5IpsDDnt4T74MDdwTJDwhOxIVdsOxmFKjFADQvhRnMhGIOTNlj9j9iwTD1LliN22eDChVhnKrayfKl5wXMrqwcMSVM2Y16FGI/0uuQ/6XtUw94pG9eiEqAyFhMTqyVDdVU7r6DQDih3DYzI90gJrMp8/Sk3yEAZ/xFjCCvuGbuYZZ4Y3gnbcBk+77RflBi1sDvDUyvYgj4bqd+b86KG0GRj0PyVFyiKatCmQh4C2lPxKDmVkyoX8QIPgtdiMdQIfJ0uu0wdAHsPILY5By/WYLtYQ5ZCahYg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:40:54 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:40:54 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [docs] [PATCH v2 1/4] lib: rename fetch2 as fetch; invert compat
 shim to make bb.fetch2 = bb.fetch
Thread-Topic: [docs] [PATCH v2 1/4] lib: rename fetch2 as fetch; invert compat
 shim to make bb.fetch2 = bb.fetch
Thread-Index: AQHdNwoK38+J/mz3P06K3mDmr6DsArbOS2+AgAADlZA=
Date: Mon, 14 Sep 2026 15:40:53 +0000
Message-ID: 
 <DM8PR12MB5430674E2CC68ED0C96C2C178BBB2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260828162612.753815-1-chris.laplante@agilent.com>
 <d8eedd54-51b2-4d71-a8c8-4dabe0437c63@cherry.de>
In-Reply-To: <d8eedd54-51b2-4d71-a8c8-4dabe0437c63@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=e8e05f74-f896-415d-83e8-738296b8e098;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-09-14T15:34:36Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA1PR12MB7271:EE_
x-ms-office365-filtering-correlation-id: 0922c156-e95e-44cc-f8c0-08df12768fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 d2pIFuYq6o24iZsYL5hJljugMheV2ZfW9jDTViGxPkxveScElMU0a8HhyMe305OkcJA0CeVzXnRoXjVO/4eJzEX2rUk1dq1wp3znlkRtPz9T/4XSdbEU+teSERgrTPwWbF8MW8CyrnXO9poBuBbMfgJn8NOXH9KIkn4GSeAV7ypPI4+aDWYTS2f7UQi30AGBuHF2/jb8A7tO6mP/aLX/3P386ITutkoz4NIoQLXhrZ8oXD+aP+FgR1K5QZW8rSvrq9G+1IRZJqVXKr9TnE/tPKxjFUNy5cEsDYc77wULuC7nqMAhCQl4kUX9GwOC0D1UhiuHjyofi2dOJN8MhFWg2xXbLqi50GC+qnD01RIosw5q2JxQlCbf94JKTCoITExKrOG/0LEyY/hn5TfhhKjse8CkClSeqyQ71BKzqPM8+EmW7Gkgn4HgHn0JX4wmest/6p8PUw0sRUKJde07SJs2u78pn2bv0GmOkIc338+gP9YDbOYYsVFBRhoGotWkf3mCiTg2/w8rBom5PAnU6ZZ4v5/1xhDIfLpZW6AbXbW3VO59DrQ/eSokD1k1l4Yru4ONQUzxAnXp6Orfr6psAsGt2V7qqq1kQnKR4cKizXT9EIUfzbu7Q7t3SS7oQkxHQa84gsmwuocIzrVvMVvKpp8bDcXNT/w5uPeBzA2T8XExVsWcwIClyGiB1dBGkunsf5iaf2AwsxWnoVcDZCQWCKUCYxTRC8lTr5o9IkUepia7/uI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kK4Ase+TweLo5Zo9cmIdTkiOKP8IKQgEAbS1MFlkGXsDqzoN9TjKmB7aXjOR?=
 =?us-ascii?Q?ZS3TVhBgmLYZdSS7/8rhJjfCIl/0SHiuX9BZWgq9qwuXY0zcHw8iamoBNpWB?=
 =?us-ascii?Q?6bPPBDssqSpffu2DMUpd4m6ZjszyWn1cBJ1COnV7c/AeMeyjYlZmax0DG9Ty?=
 =?us-ascii?Q?J4EjhqWZ9pb2GmHjKN0Dypr+ivxhKf5u65p04nCndDjeCApI0I54ZgJz1BXs?=
 =?us-ascii?Q?rwUhC4JAu3W30ic3sxtCbMST/mAtzriuUJCnAX+0OSiHhsADaRcQU0/GqccF?=
 =?us-ascii?Q?WcDqOkKGOUTyc9OgEVxni+TiXcKeFdrYx1086d7tAdwOc4tSplIlNKxKVFYm?=
 =?us-ascii?Q?y5wllxm7YI2cj2puBJWjuP1HVUe2ml1SSGfkblid7lkCy6Zt7j5mqF9rx7ah?=
 =?us-ascii?Q?+g9yCbBNUu94PPmMjOzv1JsEnO3CLd2qYT1ZHl82R6ptPqcUfAOGZJWfS1QO?=
 =?us-ascii?Q?F4mqIZ+sMkny5nAC4xxCapUqOekcPAJ03coO6RS5Eqs+YPi7VqBDTLgcmCBt?=
 =?us-ascii?Q?JT5SqLhKvM2SNE+nw3Zah7mIvV4szE2Jcv2qR6y7mtI6fj6RuWYnx1heC2Sc?=
 =?us-ascii?Q?zm0UotWauAE2nIpe1YCZTW99p774we9G9SLmfMzl0m3NXSa+KBJ0Yax5aDV/?=
 =?us-ascii?Q?BTdDBaWIzL/T9xI9TZOKM6srFzGID5eZ9JMHypsf4bcZX1YBHIelXn5g7P9K?=
 =?us-ascii?Q?5LlLdl9HicAuEIqTesuOX3Se+1oFYzbZCBr4hWQmC+XqPQWzFYcQAWtuImBs?=
 =?us-ascii?Q?SwfJ4LC5itGVX7jTD/S0+j72QEE/k9bu2qez2mgj3oryCFwvrYtyaRlgC+07?=
 =?us-ascii?Q?3QwmZ33Pi6LJXvHGpL4HoS2O9fBf87tb4ms8MNsQ1ByNLgp8YD9rF1PGNHkh?=
 =?us-ascii?Q?PyIGLJLr0znrC3CyHrTSol6QtFr552XSvfAxt9ZgOMb7EejSDH0+C6Iyj3ua?=
 =?us-ascii?Q?L7sGm0wofLOeRJq9RsLVZLnZc3zNbnfsGY2nfgVZLE4/SQSYHIlfS/8l19Qz?=
 =?us-ascii?Q?wW1i1lQ+OLW5VuraoIXOz+1t30t2WoeSdd2l9aNbvLFqqEQSfeShoJD9l4a/?=
 =?us-ascii?Q?NuSz9mCCwarD9TLARW0i6XNWm17mZ7KTXP2M1dgr7+eLorQuDKwKU7yRNydK?=
 =?us-ascii?Q?XprnGXiNWMj5ehhOCy6dz1c+Hum+9joPxjN6dP2g1Ll5defjXmkN1E8viQ+2?=
 =?us-ascii?Q?9fzu7lHZj/SkUiwLXRT6TDK+fA/Zhjnpr1dtepeOTdqVnXJG3O4IW+pvEUKo?=
 =?us-ascii?Q?YQZh4Ssnj+gWK2YR7XHz4J5BGtzYU39cGJtuQk+B49c25h4KV6Umcx8x9ZMO?=
 =?us-ascii?Q?pfajhnsFTYOz/hTyTvrM3DxRwdgp6d8NvJEqRdfCN14QGYlr0Lb7iNtQwkuX?=
 =?us-ascii?Q?vKTE64EI/y0HlWTVcoFA+74Y73Fa3saSFLH+w3n3C2VVXDIKtS3ttQgU9k3g?=
 =?us-ascii?Q?0UzCS5ullaRS+wzcWT4M3uQxI+GiG3M7cwiiV0PEbQqaBYaFTDN8yqx0rUkD?=
 =?us-ascii?Q?YVrby+9V17uh9p+1JNGBsdxR1PsBvKv/YBvaDMzlPiqR0azQTEiFmFj3A2+t?=
 =?us-ascii?Q?IRg2ice41ekLESWplxhn6djVLv1n5/TnqkY7UVborG3vvn/g9Ma68S1N+bCD?=
 =?us-ascii?Q?0veSqMkoVHf4sA4aED/d4+1FcYh4A1/jNMSmHTVpuvOiLppJio2NNKcOCjre?=
 =?us-ascii?Q?dMdUgwCQ01IvZ8kFfyXYo+2dfigUMzNtyk+ndzjQsWaqODTbST2JGqyJTiUX?=
 =?us-ascii?Q?blrn9RBBIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0922c156-e95e-44cc-f8c0-08df12768fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 15:40:53.9958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gs2ic9owp8Yn86BgvU6Ox8rI2dpjVHyHCahzfivxh6toWnZOLMnjvaN2THYDl1alLRRPerKZBf9fMKlpY2BJetF+MMlOwUpAHBVfCYJMFqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 15:41:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20198

Hi Quentin,

> I see this has merged already but I cannot help but ask "why". You don't =
explain
> what is the issue with having fetch2 instead of fetch or what this is hel=
ping with.
> The only thing I see this changing is adding a deprecation warning if you=
're
> using bb.fetch2 in a third-party layer, and I'm assuming at some point it=
'll be
> removed and layers will need to adapt or be broken. What's the context? I=
f it
> works, why "fix" it and potentially introduce issues?

To clean up some technical debt.=20

My original series kept bb.fetch2 and just got rid of bb.fetch (https://lis=
ts.openembedded.org/g/bitbake-devel/topic/patch_0_3_remove_bb_fetch/1208650=
02), but it was correctly pointed out that there is no point in keeping the=
 '2' anyway. =20

Thanks,
Chris

