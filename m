Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863AE77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 09:18:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.132])
 by mx.groups.io with SMTP id smtpd.web10.16695.1736241496534764322
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 01:18:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=ukd5fIly;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.132, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT90JV6qPihnqIvZxxxqrt1h+0pTlIdEXs9Qu96QDNCe4tpQGrFC3gpgiO5LNGj89MW0A6HZbEJgmnceOZkTFunJZgoxiXRZ3rZAwoyMQ/b/Ld3nbm4+tRMRNJChB6LePgRsn1safFpTBes1AxpAvD3/e81FDD/zN4DIwKdDC6JIrXvNU2S67ceqyHQT/bUmPICsPJ7rJgVlBPS/FQ3QaJ9/h7zkNz7fTzIo/S2b6jkDdVxtW3bZrNxK24i7uS3FRf0wMDantRu9DwrLx9ZRLyNR/UEU/AplONKt2xoqgdZylNJuGz/tpn+AF1FSyw0ZkiPZ77ne+PVKpaMk8kFFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewVwnLM5yRWvMN+kCtC02ZcXqSuYgT7b2e8hqenzALo=;
 b=khtAZTzBmLzpIUdRQzwbpHxl0WuZ5/sHXS0RmD33orQ3KgonZs3YG6lqIEPY9Gr5RvRMq0vVqTa6Qhg2TPR0Aowr2+ApA7tWBHDYU7T/UXFTRM/hpYCByXFakX2JAT15bhUdRTeYl6h3IIG5O0L1Oz2yDGqhCQb61QKAcO54vmaDG983fOKvAiOzohVKI/Ge/kD8znBhX5mlczUVjgFBBOcIgHQXVfhWYPXgBtxGv3dTNlTP92eQUnmfcTTdh84q+hg32fLwVyHRf39QtjKmjql9R+RC6LoaBGM3getN4cL2ugEk5A52If9pP9DGGMmrrJtq13HpU/1zVEfNqxwG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewVwnLM5yRWvMN+kCtC02ZcXqSuYgT7b2e8hqenzALo=;
 b=ukd5fIlynKNKmE6jvfuHyck0kLJ4LPhyzVbTJpzQOpf6GZEFbrckL0ukYJLNrJnoAJTtrXtkIOh3D4UKWlXrq/LM9KZRkpnr5NeFPwT3ZA+C+pWmQRjAODg8wHhLS2QapLRQEjJNtyc5oO8vwbgJc+Etyth1mSZ1Ogvcbs0U6jVd9v1eYMs7+oQk99E014pHyJ2v+28PiU7Yx7RVS/W+VLDcUUIBc2jVC6r8Vh0btm0y0cU4+c1V7v88riM4mxgdBYQEaXCzg779dPEUJQd21yTAnO9PiY+zmTQvY8mQ+QSWCoBf0FUKOFMqbvwxlf1tpon50gpzUVPnht5unOUQVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by GV1PR08MB10607.eurprd08.prod.outlook.com (2603:10a6:150:16c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 09:18:12 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 09:18:12 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 0/5] Update npm(sw) fetcher and embedded checksum handling
Date: Tue,  7 Jan 2025 10:17:52 +0100
Message-ID: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|GV1PR08MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: e9da2d23-5e1b-4598-1e37-08dd2efc3548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tDo/U7bwzsKjHbxBKkEpiD/650OSQZHglfdBa+zRN/RQMF4ZjNo2mh9pIGg+?=
 =?us-ascii?Q?Xdr92IyRXovnCAF9nngYnCL/5pTsIddz/QdGnWJMR849qccUebwnelj8EjxF?=
 =?us-ascii?Q?A4eGqY3+HN+/ikYHor0/yRY8yoLsrvd/MSPZvExcd3i5rl9sWZWBR6EJyFlZ?=
 =?us-ascii?Q?TnVLzcF4ruLyHPlym3dFWNblq1U21syWPdBrzcPWjx5J7a53Exs52a1mKH/1?=
 =?us-ascii?Q?+TQpGDNSESq/5SuVMkC8yRZxSEpIGxRfIxucAi/eRR/fkcXzfOGaLk/PcM9l?=
 =?us-ascii?Q?GyAv+zigWfe/JB0VLcu5No6FlEF3T2l56RwkyQFBQt1AW/o1HHSJ8vM5PQo/?=
 =?us-ascii?Q?UvNF1gN/DCqJy2Lup34ZJKUY9RCPcqHs5jNlDM5+y8SRE9M4cHflUfLK3ERs?=
 =?us-ascii?Q?gdqfmXZOA2kS84TkCUhSKWRBtIb3CdN9Xk/Uc8zwCjgmRX6Fyx1vZ0LCIXhe?=
 =?us-ascii?Q?qWTXhdge3R7lB7rYsNLvLjATn6MQBHWEZqSUvySvBJmdKLB2IyaeiE6m0hNU?=
 =?us-ascii?Q?N2Q1tRupym5TQ2UGEhCtS/ZZMAuiKSnz9P0G3Fr7CXLpRnOTcK7Iz2m2SH/c?=
 =?us-ascii?Q?CuOJQYXTaNNwcD3Lp03hBtU3t8RN3LzaF02oYeeuHH4c2+oGXdYUVaamUf1k?=
 =?us-ascii?Q?Xs4Yxm+j+7DzHwtq/q/N7A1HvpBoDG6zg4HjGdVkibm2oGIOQrFz6d+AtLg1?=
 =?us-ascii?Q?Ft1Av9rv357ECojgWSGK4rn6B6JEcmuy3pnNl6VHkNSINKn1mIsbmJzNpmu0?=
 =?us-ascii?Q?xu76bfDI++vOVQ/OG+NnHPgCT16/GirupWoXg2gbFzPzjMXjLBIh9JtJigRJ?=
 =?us-ascii?Q?MBfYDBjyxzTSZn93UNzmSfEj4MD4w32LEmp7SRSiz4ixSly/pxD8OK5RDHKy?=
 =?us-ascii?Q?c02hg8qz0dVPaPucg+a6ibdNP5+4mj1gIlBXD3pI63t2N/e0XIX4R0m69rlX?=
 =?us-ascii?Q?VVYvdrlp30ZNGyLziSQ4CTyWY9dGcXBI2OS9yFH6oUlnmbwP4cQ6ZtbkRKhg?=
 =?us-ascii?Q?/PnI2g9aOORXI2c1l6WEje/do7bOEQsC8AkwEpYJ8Rwnk8aENp98Z+qMDxJq?=
 =?us-ascii?Q?1rv3orTJazHccPqtuuBXBczSISg+OcsoP8R3f1epOlov19jHMrVfv4gMNSKC?=
 =?us-ascii?Q?vvzYjdPhMYq8TNMGXUuTcz36IbZGGzfodlQK/cHm5PtIl8Ga6aSe+ozW43Ad?=
 =?us-ascii?Q?WJQDf4pLHZv/hBfxajbk5XoDJIMDzZeoYk6Kc5QN5Ec8pLBejOkvibck7qLw?=
 =?us-ascii?Q?yq1m7ZoRgyoixopE/uqAiDwZE0JwECxiziWPBmDqF9D8Izu75eB4CKJBP+12?=
 =?us-ascii?Q?AOOTtZLv6H5AA0LuFB2m11aWb92tKwf5W7/KPQnerfLMctK5cBVPs3bc/Dzn?=
 =?us-ascii?Q?bJ83cPvWysoVxWoxTI8pcAZVVC1ffcNzDCZ3MNreDdWpvkojxlaxjXHK9EfZ?=
 =?us-ascii?Q?uYWB1ZiWT+TJqbr68mHCDK6LwhIdpZ13?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rLfbLNKms2NnycV/iAdygUqLBipkk9rQLsvhh+Yq5pRDy6w9aa8hrKquSU29?=
 =?us-ascii?Q?ewtsJ7Qh2OLomrFSsQeIJLWAn57cRoaK7hk7fc5frAtvJplxobQV6h21Jb1p?=
 =?us-ascii?Q?Bi8jtk802LyMDQAokYiKMU/GMGn2hOrl8v4JwPUwnVakcG6aML0z8+HxTpT1?=
 =?us-ascii?Q?LwxtmSpxDLng6yyORuf/Vorm5gFep/sO784NLOQwTCeUpP8E7g7/CmtJ5VVh?=
 =?us-ascii?Q?n5pes8FC6fPS/d5+1NX2tF+7Ie/XAYE757385iaxg2ZXEDad0PLehXv0kU/h?=
 =?us-ascii?Q?8ykvR9jw3p5GnVJhWeRgHpW04bOi8VeVm0vg0H/qDfWNhVNMlDaF41cw1oJu?=
 =?us-ascii?Q?7t/6d300sQl7avThvbPiIew9v+4F8RrPtzX0VlkMDyrJvX3qSHd7ytDiKAm2?=
 =?us-ascii?Q?NGfuhSZCXRfz4cFv9/Gku6eHwWCMt8fR4+R9Ka7SQ8Q5A+50NI/ZHrxX4ZI+?=
 =?us-ascii?Q?h37oIrzIVoLiFpkpqkB8T2mo0J5zAFJNBzqiHo+zv+zCz41zgCElu9VhnIPS?=
 =?us-ascii?Q?s1p07DbXnqiIkvJu+FNgzTAVLQep/PEsDV2+SxeNDKxMLXzP+mFcCUKLmpkm?=
 =?us-ascii?Q?JM8sPSvYHWbCGU06D5xoy/RRGHGGc0zSP2+1K9+Q52fK6UiHsvTkFBw5x4yj?=
 =?us-ascii?Q?7orKH1b1WRX7vd/1f6vCryu9oVAGmAJCZxeThuDFCYUfHk+fU9cz4yolSqxv?=
 =?us-ascii?Q?yQo0njxHUQhwFAUIM2R6qUdhZr+5zwTd+B7obIcC1A/qofmIlxcEZ6tVMmQF?=
 =?us-ascii?Q?KLNiVEnn3BPBsHhp+V9X78PEmqi8sAhQAl09ze6bZzOfuX3ssc4wQhutcyPk?=
 =?us-ascii?Q?pTh7YtByUzffcMifM7A1vWWkaN1Aljp7l0Li8tE/W9q+v7r4HsmvQFWzZMR9?=
 =?us-ascii?Q?HTHDZP8wz7JQUvMlc7ZKTXhxuc2qcPpCUplMSVLAiou72i2oC+BMEhi4XC8z?=
 =?us-ascii?Q?oHcWUS1Bv6/TNCj4XKfV2NKRyQ9AQRmMprjOESqBhVPA21Hwp5+Kvl/4Dcaz?=
 =?us-ascii?Q?AdorLjbN7g1JjPekDYHNR7kTczAceG09XVpHkFIxfggwGPTQwyrZrylK09uV?=
 =?us-ascii?Q?n8zYWQJ/LoHt9rxPDhOSJCWMupH7Y0qZNiLPX5LgjNM+eP4Fv1zq51oq8SfG?=
 =?us-ascii?Q?jw+78FSJvzvKtsIbu9trIfd4giBtdz+NLp3v8IPwdlTx9cfxsnB/QlWS/pns?=
 =?us-ascii?Q?zqhv3UmIvDn1Oi1KnWadi1M5QE1Q5WuCx51E6OGgsmTUWirNpSwi3vnEGI39?=
 =?us-ascii?Q?/moEv5ezc7QA03j/dO5ihYJNBLpN43l7dRgoqVb4bkpSMtbz3m4AESHrPlIA?=
 =?us-ascii?Q?BLPX0LmOTrP3WHzTCE33BEV5XwbfzDKXWoycnEUWsf/W3/MdNB8k/va/k3Qs?=
 =?us-ascii?Q?uKMO0MTUvlJUFxnckgjDYC1bY+g1L6O8YDEM6wd3PK6PoNAFr/o7fO2MPcKa?=
 =?us-ascii?Q?3+ymTt1E8e7IvVQ94pIByFESXaIEUqZIz70gNbV90z6kJlK1fpWlcYOmF+Jv?=
 =?us-ascii?Q?h/5KG2mzhKkMKsdZb+6VLw5yp5c78/etH0qVcj6pXJkjYNk8SkWwPxI9AdYO?=
 =?us-ascii?Q?9Wj4DCTStU8itniuIElLHUn1nWHyDc33Mv3P5m6+fPXU0dntTRF/osbZ3gcS?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9da2d23-5e1b-4598-1e37-08dd2efc3548
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:18:12.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjuXhHuOBSG7aYpx46CapEcBSvyNJmvj6Wr1+YMcr2HaIhpdzPWCEmmzLD6fgxZ84tkbsbrYli+Ki2A4hu9bpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10607
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 09:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16970

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Update the npm(sw) fetcher and embedded checksum handling as preparation
for a common dependency fetcher.


Stefan Herbrechtsmeier (5):
  tests: fetch: update npmsw tests to new lockfile format
  fetch2: npmsw: remove old lockfile format support
  tests: fetch: replace [url] with urls for npm
  fetch2: do not prefix embedded checksums
  fetch2: read checksum from SRC_URI flag for npm

 lib/bb/fetch2/__init__.py |  11 +-
 lib/bb/fetch2/gomod.py    |   5 +-
 lib/bb/fetch2/npmsw.py    |  97 +++++++-----------
 lib/bb/tests/fetch.py     | 205 ++++++++++++++++----------------------
 4 files changed, 131 insertions(+), 187 deletions(-)

--=20
2.39.5


