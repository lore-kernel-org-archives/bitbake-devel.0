Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ADBC3DA4A
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:26:15 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web10.29015.1740158771028340956
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:26:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Y/Gs6To2;
 spf=pass (domain: siemens.com, ip: 40.107.22.71, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAVUMelK5OWnXMr8nM5CSojA4VqHQ7Ru+oKm64GSp7vLOflEdebaIsgcFHthZee1034WmaMMjVYHn2Lnuw0JzqWc9HSVmWBaYNcoA2/QUU1aIMwwmz+h2bKHdR60XxlYpT1ikCPdpnSSMLUmYpypWRKAvzuQP1bYEWsA35QM6jifyUMxnw6+9A+OEJY46WikbMccjYZBKTuWCO886i48vykQ+eowq3sJonJbYpic2LRYTrH5Hd7pKuNI3ZuxUL8yhDF4PpMOPjh1J4/dnQOWXOX/7dfA9FYGykLqDScSAp8bLYdlLvdRZVYUWkMzDmki/E8NtEN9IaH2W3VPuyqo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grmg1xFFB8GESgdgnHvP0EwaggoI+O4wp2OGbohbnkQ=;
 b=rwzH50AU10nDRG6qoB9O91b15m9EC4nveRvSsPqNLO8NUj/0gjuHhrEa5Gd30i45Yq50Hi20mkZNlkYrLIjnyRwAnpU0gorVf01NnK+vEPZWEQylMkJlwJXK8cFr5PH7qGoWFZn+J+Hw0AxsgnkAVf0gHCe9NFiEnBuEol/tEGtpI+aSfBiBjaxcSx9PA2+ZhYxDJ0U94KYdCConfEV5IwDPUvhsyhNeWy/trtYzS+UY0xhJscXGDfmkxr9ap2KEuhhRY1qEkCnY3HDawwmAr83aurSO+D6c/d1BlbzjYa+IR3O5AZB4ITcG/qg795ZTIdoXhU4mlc7Yrm8ZwMC/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grmg1xFFB8GESgdgnHvP0EwaggoI+O4wp2OGbohbnkQ=;
 b=Y/Gs6To2oh+iP0eO0rX8YtWJyhnNCs2+L6QQ76xrV8MYSuWdphpwdFHOhP2GenSjw2L3C933Aj6Y3Tzsq3heOIfiuPSkc4y5pCMIQPC8+UW1SA4CWRHt6ytO9NCjwE9ZbeDlLma7UvmCfsODfAEgwpmnYBkpR00BMEmACH1MAgS1dUsJRu5SZbh3MKv+d7WjZxqSQXD4TYI790wvshWuWGcwpjLUldrxY1UAlxlY3DS6+oV5tdM0MK7r2VDwNeySWuZ60lRuxUCHhz2f4anQcsdByGIsAtaTBcHdxt6nQDH26g09xV4FtUVlcdmdKh2C9mkwUdRdOR1VK6AtPTNAMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DU4PR10MB8514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:26:07 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:26:07 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	quentin.schulz@cherry.de
Subject: [PATCH v4 4/4] tests/fetch: Add an additional test case to check whether the fast fetch is shallow
Date: Fri, 21 Feb 2025 18:26:02 +0100
Message-ID: <20250221172602.527924-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221172602.527924-1-stefan-koch@siemens.com>
References: <20250221172602.527924-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DU4PR10MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a1718a-e883-43bc-362c-08dd529cd392
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4mG14D9enCncCuNW4UD8lvlWtoEONfFhDBd4yr14OqvBP9vL8nVcHC90FjHr?=
 =?us-ascii?Q?RTZ8ylJgDm0vS9wVci8K5+FV/d1lFLqWQpcMCU4w3iyvsfmn7g8YwWlwwKTC?=
 =?us-ascii?Q?b+Xpa5lL02+JYWpiBTe4vKHts0akwiAHVTDad3GgPLXwY+yPY0+/77LH8dEF?=
 =?us-ascii?Q?xXabhGUY/VbE4NtVh0wNeLUjAF+Z77iRa+OBUfCVUYpOo19A7+fLQVWmeRKn?=
 =?us-ascii?Q?msfRoJKHadOqy3GFHaXu54DzcWYhLZvedzlJVIpBUuRhRRrYnBXXHcBSWnMV?=
 =?us-ascii?Q?bv9pFTum3s84cOkL8XPEP7PK/8VXfc1n/Pp5YAklUTbezcsmhQxIj0gzr6PY?=
 =?us-ascii?Q?WJZV9uvZxa0RWDzP79/Rb9r/pRCFf236ZmyWLUeeH0V+/DBHGhTx0GnnZx0B?=
 =?us-ascii?Q?dtNcigOc9CswIx7HG+fxrLH41xz1x3n2OvPTpYwDvHRc9lDOnfnuFQ105Pp8?=
 =?us-ascii?Q?cjV69W2i59joatTAwZatWzNqDK3qRBaD+Oud9MiAWLjbnGQBbnzsKrRfdvE5?=
 =?us-ascii?Q?sNR+p3aFTURgJ4LoPbMcxSAq4Pno0B9hZ3KqHdTOzPFn6SAmahORGAw07h28?=
 =?us-ascii?Q?UL/Jp4PA7NgmjPBpYiMkYu7hanvx9EZaBga9QzrBoy5WDdZb79B+7NlHUWAU?=
 =?us-ascii?Q?dpO4oDT+OYglc41b7jey8bKtzpSpTnVbuaZkxMus2rHqiJ0IcYZzdccSZo17?=
 =?us-ascii?Q?VITuTWYDviMbLZOMi5ykRttm/6qWkqVT8MBOqILwO50Cajrphx3JMro7xdbR?=
 =?us-ascii?Q?hPCRrhDzRuP0pQNyh8hNAierGGCijE5UlZZzntdszZAI0oIETJAjXNcuLtcR?=
 =?us-ascii?Q?4rCKx/4HtSRQQWIyYCr8Bel9i6LUyS7gzEB7qdq+C/BHnmtYRdZzMq8ET1x3?=
 =?us-ascii?Q?QK0EGMjGHB+NTzjCYZUxVTmsFKZ8IL7p0+7Ij84bPMw3C35sVXSVYzHsgFH3?=
 =?us-ascii?Q?st+vtezFS0GdR3jgiasGY/HobduutbMB5da1aEdjUf8U/RKUUxqFtNUPpkRJ?=
 =?us-ascii?Q?/vbj5IMuC0CbsqmeIoOPsVPiSwTd4zyhnd65T/8bnRa+adGGQefXSrUTHAgJ?=
 =?us-ascii?Q?p64gOtigUCZ+2Ahg7xDl331damTxeoSF8cDIV1oMJH/2oMUfs5oqSYBeLd1U?=
 =?us-ascii?Q?RqvPMdI2bL56a0aHConReCOL7swKa+FxZT3i+rYyaI4kudjEGaPUAQVaE8w+?=
 =?us-ascii?Q?ycxxLdmcdvNaB1hkRijKFuq5SBOiBHUUISJevbYF6cVns2ZJgEynolDdFgzR?=
 =?us-ascii?Q?RW5h6wnOhp520S4+nhA57zntSU1+KGAdmOkmn7gFdqePGZVdsGSXQ3ht3iHM?=
 =?us-ascii?Q?iPqFbfc/Jkw0z6NBPvkVTIM1+bs1UB7mD7bM482LkjTTjxE/v5gfJ6tC4Mox?=
 =?us-ascii?Q?F1aAj5q62LUSxARFCCdLnXunxzAC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JJ40xijMd7rJi3HKjFoC5BcyTseeLu9pslqyhJOzb0IzU16mkvB2Ge/lKixF?=
 =?us-ascii?Q?N9SgWAP5d4uNm/1MECSPv/X+9JPvaeEoM3GfrgJyxLaiNl/b1lnQ93fjfT7S?=
 =?us-ascii?Q?raZpwm3HYvJl4d4CtpfL4HEiCeOhb95TNzyjUXOOFEy/V8bYaSuvoB0fXnbq?=
 =?us-ascii?Q?S9VQDyxgjSWdhUuidrKCHjofAK1LAxHsEOZ+gP35IP5aop9GsFPSnFWw5geb?=
 =?us-ascii?Q?uxn/PAqMcoXGzw83tpZFBHA6nQ1SG9+Tx2ai2Vgl/0bg6/DdeOhPRxNx0V74?=
 =?us-ascii?Q?d3JA6+aj7xw5pjpZWy0JBbUnpGyPc1Zg/jiiFE8cdHvFhg1IWiS4FmBkuzOD?=
 =?us-ascii?Q?3dWNtcJb8S+f7wkjEPbO+oNnQ/qF89mme/Gh1DZw3Q8X/r8l24xIGWHj9X99?=
 =?us-ascii?Q?vL+Nv7S0gNKE52PrVoi5JpWpNJLB+s7qIIb5BkmmrGssHAeonHqAtDd4zdZi?=
 =?us-ascii?Q?hzmPAK4x1c9m9jr+HLhXdyUjlc5RdXfRTFpoQbPnqyFCC++1tvKasdpgQv2R?=
 =?us-ascii?Q?C14D64wf7/+VFzGz73Pd50ygp5D2uUm6ZN1Sh39c2xR9QZxtNsHN6RRsKRHZ?=
 =?us-ascii?Q?fxEWxQTvalNxGtQTNKXbRajuIui40aEhdZDaHw5W8U/rNyn7K+n6h07IGlCs?=
 =?us-ascii?Q?mzneIT5D9EA2SSyVVtfEesAtQgQ45ZMzepf3PHvV/hUAcBmQuJ5T9g7ozVCY?=
 =?us-ascii?Q?oGZtfZZdpJiKkxx7dpmir+l6TcFdP6i7UiJZ1+y7gVNNwECpq3uB/UxJRz2g?=
 =?us-ascii?Q?NcvFSBVJzaKYwy0ggUlRfP9kE3VGcLBnaGrH9Nti35pl0O/EczMdimD1WDkZ?=
 =?us-ascii?Q?/FuZQSUVCs8U1YQ36XeDBMaXt3UOignjOjpOC5Yc3apsN8PVBDuyelKviLFP?=
 =?us-ascii?Q?IGGW1u+UJvN3RExBRs+UMo/9l4v2PxFXmv5y7ULBoly5f+ZE8b7eKYlatqCq?=
 =?us-ascii?Q?DK0qyRJdhl+cfhPuRy01BPwJDtECVwN1qDZE/y0U9WYdv7NVo5O2iN19c2IV?=
 =?us-ascii?Q?lbgAruGuLCO1GZlQDsowRPY4UvEZsXwdCIdURP8JZoVUqQjFpFTjYmRCkCup?=
 =?us-ascii?Q?x1uV9iqXG4+fnIQUnivlFYMfig/OGRlFBviOHbFoBSOMgSa01geJgAaMe2Zf?=
 =?us-ascii?Q?ll4+15Pf+hlkWwO+rU5YvvXOEDt0KgtVgDT9C3b5BmRMCevsJk8dKZseDr3m?=
 =?us-ascii?Q?jorp+vgVzakhhKzwYzOqrTs3pqLBEX2+1FEgRVTC9EfpQKDKcV2P30HdDZC+?=
 =?us-ascii?Q?8+YIYhfJo/Iokhd/4EemiDvuRaDPMGNIEuvglDcOnKYw+3Bnan+esN1gK+9y?=
 =?us-ascii?Q?04X5qVAgLOwskFiNLBdaBeki6x5it4lXio3JJOJ2pV8gzkDpiviQYyNhfT4k?=
 =?us-ascii?Q?VAROEtbCPXhlrvqgkOEcozbTRE6m2XU9ghNelZ7bgAKfmQLxmHX7yrP5TMLu?=
 =?us-ascii?Q?W1A6oSAJ1RqrVeniwApRjSNcqWwFgxQlBm8zgeLEUUnctJ5HiQb5O7EvQiqA?=
 =?us-ascii?Q?mnFilwFLk2r7K5I75BufOaIV4sMDhg7NkzWvj/V3F3/3cjAQ4GZsGf+eicX0?=
 =?us-ascii?Q?GldwHXHVhqvBvGkrxaSQaPOAH/8cN7aqXG546zUzFj55GWks6tag8AxSNMhZ?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a1718a-e883-43bc-362c-08dd529cd392
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:26:07.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F27abWkD0E5D+YTndnkQnHsCHONJJX/53hJeE6/oWAeOyln5CPnSvCFIAa6y1rzChdrwQOQlCqAIWnbtUru74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8514
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:26:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17288

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ba08cee1f..91d1c3c7d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2321,6 +2321,18 @@ class GitShallowTest(GitShallowBaseTest, FetcherTest=
):
         FetcherTest.setUp(self)
         GitShallowBaseTest.setUp(self)
=20
+    def test_shallow_check_is_shallow(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        # Fetch and unpack without the clonedir and *only* shallow tarball=
 available
+        bb.utils.remove(self.gitdir, recurse=3DTrue)
+        fetcher, ud =3D self.fetch_and_unpack()
+
+        # The unpacked tree *should* be shallow
+        self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.gitdir, '.git', 'shallow')=
)
+
 class GitShallowSkipFastTest(GitShallowBaseTest, FetcherTest):
     """
     Test cases for use when skipping fast shallow mode.
--=20
2.39.5


