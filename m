Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB3C0219E
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.73])
 by mx.groups.io with SMTP id smtpd.web10.68437.1738932437003972275
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=iHNnWVkR;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.73, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzZol2ViAXl7xuC6YITdha/nX48DHTI95MgEQlGXT1HbuwmEgLVBx92MClqq9XOyQL2I3cPS9vgDZrt8N6aVDn6RGDsEgRcIHNOWOKOSqmozdfpP8pL9aHIMeijeiD5ejH1+rWAZeFFAIFUjx1rMzrUfkH8KO8/XXvsdKD6eMR8g50Ju2mORNpO+cXQF8J31/nQKXayZa2BoyjEWNAHfCNsEBFN/VsxIKpQDVxwlbIy5O+YRrRJ2dBzXNW+7TlUUeeNFfs8+YcVwRnfglE1myvvtlwvMSQKby/IC7hukO98iq1H8I3wZBKCaufksYluQ4Ur4G7PI0a6jPEgM3rUruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUlYW2S6BTy33jm3j0pR6nxwMZS08/WQy+wRjM3rl8c=;
 b=RSvEmBudAz9FChIKC0vKl2mdMRCV5FIdsyR2Z1xmJj0yvDNm7u4Jqx59boRWRHfdoHNWSBo689sjS+mFKXDGPbWMqe3wunO+tPQHXDWz/ODZc+3dXJZjipvvCWG4pOb50b22O/fTGLTQ2nX+d58lYWn6rv7cvS2Df9PnbRuKvMlzDVqalFrntj1Y7WlNYIQU4KuRaIu9zyixbR+CnKRkkQLTEVMw/27cI9MdE5NqfY1ect5XxYNkrv1j1OJMegA3I4b+ke0XPabiWK0Rt+PzgkgUtE4KdQ+wXQgyzsQGSE5BIT7N8nXq0s83nrsJUasqid6vZy4DRuQtsxYpHZaNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUlYW2S6BTy33jm3j0pR6nxwMZS08/WQy+wRjM3rl8c=;
 b=iHNnWVkRT57Uvh45i8r8SzNoGGtgdMzZvAVVwR3JTszR0X87sfk2j5F1PnwYVka68evYim9F3onGAgspsJoz/luf9su4/1uUJImO0XVE2UdkzM0339bj4adBsuzo+rjTfIFL8d57mGpBpvj4BY49y+On38u4L/AJmXqR3fe/TtamBgjXemdCAaq2FAEhpcPCbr0gBq5ggrIQYlJiPBXWo43BjP1z66K8rtUfIRPDPSn/tAXBNwKgDd0El0Yy40tfSn0CqgwWYa/S8WL0YWVxQFo+YPcseWnMkgs6IFEEHxO+d1GTM2gI1WBrx02Z9Kt2HZVN/gVazXPjWwoTvnhnvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:15 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:15 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 03/13] tests: fetch: use lower case hostnames
Date: Fri,  7 Feb 2025 13:46:51 +0100
Message-ID: <20250207124701.14787-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 934e44a5-3d29-4293-2a90-08dd47758b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?16ntyW7gTPRJN+hhQuJ0iUUI2qkiDlmbAql1L4LMDGdcKzJTFuvMK8IJAHxB?=
 =?us-ascii?Q?AbF9Zr8WoyxojsDDHPjN6IYd/P1SME7i6IQfHIn5U/JHxd7VFBCD+fg1LbaR?=
 =?us-ascii?Q?gtu+XEdjjBHDHP8TN5M5G8hdU0cTzhTKCh3YTc/sHPFGe97/Yq2iz7SDHEM/?=
 =?us-ascii?Q?SC/xHgP0PdPf4zTtyVJhWra9g9UCyQ0Ei4YAK66HQECeTODFpaSz5NHPihYR?=
 =?us-ascii?Q?FggC4eDWUVj+D2JrMInib2VPMEirzTYVBcX+1XxB+PdyrCcFV0ne/+5U30D4?=
 =?us-ascii?Q?iUHW3YFw+n1c1IePwqgSQpIR7H3oVp3aq928CLmWQtlAHMfoDp+xZlK30ruG?=
 =?us-ascii?Q?Yq3yIOySJEroMJvZ0L/6X1IATGoxRESaCIVoixZ79m/xZpej9EjFE1kHm2hL?=
 =?us-ascii?Q?dXaj2brSRte7SM9RElHQr7GC2hMOhaqNcdw3lLr3TsjEThtm3+V5l1FEWKcn?=
 =?us-ascii?Q?6JtO4hrwkt9quqwqqNkuJPlDF/MYioL/6hco444S4YHYe5MKrfSdTJ9rhh+9?=
 =?us-ascii?Q?GnDSfc1J0VerI/CEa2zUUVLY6b09n8L+ImkJmQ9gmI8mFDFW8Dw0gxLvJ1f7?=
 =?us-ascii?Q?xF5nOIFdalpd8v9aGhHd0JZXTbZgGOCaD2IiU044tlhi71AeJM0jWhA9Ywgc?=
 =?us-ascii?Q?pnp9riN7u+BVxYmpITbWJi+P2PWQykGOcZvFU/nGcCMpALN3qjroNMAFubom?=
 =?us-ascii?Q?uv6/loiU5okO0R9p0QFRoDFVlF42qeQRctPrPYlJTC0RPnXGbn66DV4l56/c?=
 =?us-ascii?Q?XGKqSvdX7cUVa/rg9ddY2PqCnRV6W3wmVHH7ahNLzD0uKzzikYPyEOnHlo6m?=
 =?us-ascii?Q?qFm9sI0pr3Sd1B0Mpar48nmVZa1zhPEwMTaUETC7qKIQ+m/Mzen5SEzwJ3Ep?=
 =?us-ascii?Q?RZeSPuIRaHHTV96KOF8Hq9sjlkHhu6PXMeGJ3BZiz2At1ulZgONyhXIHoUEj?=
 =?us-ascii?Q?73y4LF3RJy4l4xJMQ2q80tKJrZna6r2WILwJa16rXpSgNCWz8oWTGP9u4FE3?=
 =?us-ascii?Q?cY3htrhyWAFtvz833QhlIwQnLb9dlOZ1JzcbcYfKj2RRQwdjhdbCSKtf1LP2?=
 =?us-ascii?Q?Uy0OP65ors4RIerXzB+IDD7r0CmAAdzsCJdwVX/hczC6rjnsjJ0VwsAkwPwp?=
 =?us-ascii?Q?GlGzCu4CVp44aEc5dqE2PnpIP8pcjqsKjyx1ovBrxeLvGpiYBIkMDARFWd7Z?=
 =?us-ascii?Q?z/sx4EIGbHcv7IcK+p7IlmQtqCEdXq691SlLNwhGEmYczJ7dAss+fn2oXoa0?=
 =?us-ascii?Q?hiYQ8SXzzUEL8koALrmWdn48F5vdy28+v6Cwn5orD+yyz5j8lqllWdrnqq0z?=
 =?us-ascii?Q?vGzxPP+v9kBrDGP0fC07pBc0M6DxNTz3p1LUKrwWCmcBchDAJ44KTmi0RR/R?=
 =?us-ascii?Q?iNiD3t5HHQRwIAbwgmh0Jaw/aUxW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eC/EQoLH64syyGRwrOMH6H+LKOaVHgDyR3niOd0RClICPWqEYBXiLjpaRM4/?=
 =?us-ascii?Q?CJaI5WRv0JGPdkc7uzhH4P4YlemV2R07NvAkj3cQjq2AOTjIgFDOE/yjVVhY?=
 =?us-ascii?Q?fAYiRnuQx/K3Ql8qZ6j0wjh3Vl04HI9WxqSYRuSFjNVo4JqRTkNzGkH1/CGo?=
 =?us-ascii?Q?jI8MYOtnULSagx9SZZQrGO+XDXTg4KTwkfyjZhi3Tmuw6MEQwZbNAdLrf5AY?=
 =?us-ascii?Q?XQH3XdXYKq85MSPJnASlUESr88szX8ELAUHdPtx/a4U6bwU0JP+IknKIOWr0?=
 =?us-ascii?Q?Rr7Ro8nEkqY5g6wd4H9i2buG0J6LJBsm0H6vf0XQOWZRz+Quv1Ynl58rENhS?=
 =?us-ascii?Q?8hIzbdSR8XS2sVJAmz//WK1Gt+IA62QWpt6ziPt+4iNRAQuZ+m25ooUGoZdb?=
 =?us-ascii?Q?xaaOkdWIh0vFsxcSldESHEXmhBUoD0in/Qk6aLrXpbERKE6bRR2jFxC9pGNH?=
 =?us-ascii?Q?WzK/mLHf4w3m7DVYKEihBiDsIh0Ca/zbuwkwdY4xKvAaO6KFHwP+pny3h/LB?=
 =?us-ascii?Q?uj8hwHRGGOGiacUaRQaN1sgOi31vmp5bBkHuJbmZLAQwBLJMwBmFEay/VW3W?=
 =?us-ascii?Q?1y6DOatOT23z7TGN8SZ8n4J+bO5Sw2Wi1O7T8HQj3gg4LNmIbLar8ELBeSp1?=
 =?us-ascii?Q?MkzNoY7qz0l3olk4Kh1HhRR/Kcx84H5ArRLG5OJCKbw+8mwE6cREzVHZNk7O?=
 =?us-ascii?Q?7ZumehKiVEukWZ3vmsYkNFy6CU5IxzNRH950nmJOiAcouc5HU6NABGKA6SYr?=
 =?us-ascii?Q?SP5jXRyI8vIa2aFmHIRkMIa5xO2GDYNnGCTBneblZKh6IBTRV42AeP3qj20R?=
 =?us-ascii?Q?YU6hqEt0VTYYvNdKu0BvHZOhudTTT6WAuIhZUOlGNa6iLEQ9Hvl3yegKNOfF?=
 =?us-ascii?Q?klXl8n76o4VkT4qthnmztt8dO6E0Tr6TD8cYlgvm063UQnrKsTz9qDDIfL0u?=
 =?us-ascii?Q?nkJZZpj1wqRMnxk4rqHdGovHRJB0oV5jSfa25wfA3a/3S/8s7lf4v6p4AMVH?=
 =?us-ascii?Q?zv4B3sfKzA2yNPtGGeM375zXQUV0r7c5oqWGmKmIuxpEkVvdmSYn/lU23+i5?=
 =?us-ascii?Q?XR7GadT11Dynw4jwqERGMaADxEXxIXwCbHob5vn33OeAEWyd8zHRFau/yvZJ?=
 =?us-ascii?Q?PGrae5RpHFq0dMcHWT4XeJ8EBsYK3ahcD7cQhEkEUTvssRwQG0ZdQIV70gux?=
 =?us-ascii?Q?DMsIivNrhjVI6cUBZYDZFIJ3MpF87R1xxj0o+UU5DXlQ0V5Q1k28u/46XSEp?=
 =?us-ascii?Q?e9Zb+a+1Xz5L0S1KYr64xN4P1uFZOzYJqot72ea0rlmH4JMbDNFGyr300IuH?=
 =?us-ascii?Q?ULmCkQavU2/Q0WooweRkgBkDZLHtuGcX/ScBvy9/RtRTRW8ArKvfOcU1qZk1?=
 =?us-ascii?Q?xntBm78xszP/SItp6H8lC/cHqi00lCoWRvRzgippCGFZAXdIR67+fJwlMnd4?=
 =?us-ascii?Q?pMIDL7NDB7eU0sA07lbEQuMA7ifWnbV6NOec+faHai3Ni4u7q78cU7v09hjL?=
 =?us-ascii?Q?yZtGZAiZGvD9VoP18UI++9RJfdG9meOHlgCfKJ7vIOd1mMhuh6AQZI9+hJP4?=
 =?us-ascii?Q?6VZVcpZoXfOJtLzPbAPYIlrYBn0jcAEmw4DrMWZc63wXjRKuUmsa0c2a359K?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934e44a5-3d29-4293-2a90-08dd47758b93
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:13.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKw5JLA+TBtJ+8a0P+y9KVrBvu4QYqRk74G40Gcjaznv827RDWHUOChR/WGJBCf0q8MELhSL8GCPQ7g34onzag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17172

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Do not use upper case hostnames because the hostname is case insensitive
and maybe decoded into lower case to follow the common style.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3be7db358..0f1cb7670 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -570,16 +570,16 @@ class MirrorUriTest(FetcherTest):
                                 'http://otherdownloads.yoctoproject.org/do=
wnloads/bitbake-1.0.tar.gz',
                                 'http://downloads2.yoctoproject.org/downlo=
ads/bitbake-1.0.tar.gz'])
=20
-    recmirrorvar =3D "https://.*/[^/]*    http://AAAA/A/A/A/ " \
-                   "https://.*/[^/]*    https://BBBB/B/B/B/"
+    recmirrorvar =3D "https://.*/[^/]*    http://aaaa/A/A/A/ " \
+                   "https://.*/[^/]*    https://bbbb/B/B/B/"
=20
     def test_recursive(self):
         fetcher =3D bb.fetch.FetchData("https://downloads.yoctoproject.org=
/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors =3D bb.fetch2.mirror_from_string(self.recmirrorvar)
         uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
-        self.assertEqual(uris, ['http://AAAA/A/A/A/bitbake/bitbake-1.0.tar=
.gz',
-                                'https://BBBB/B/B/B/bitbake/bitbake-1.0.ta=
r.gz',
-                                'http://AAAA/A/A/A/B/B/bitbake/bitbake-1.0=
.tar.gz'])
+        self.assertEqual(uris, ['http://aaaa/A/A/A/bitbake/bitbake-1.0.tar=
.gz',
+                                'https://bbbb/B/B/B/bitbake/bitbake-1.0.ta=
r.gz',
+                                'http://aaaa/A/A/A/B/B/bitbake/bitbake-1.0=
.tar.gz'])
=20
=20
 class GitDownloadDirectoryNamingTest(FetcherTest):
--=20
2.39.5


