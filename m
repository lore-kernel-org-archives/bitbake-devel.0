Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF86C61DBD
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 16:27:08 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com (PH8PR06CU001.outbound.protection.outlook.com [40.107.209.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4812.1787934422135848739
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 09:27:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=aTHRqmIK;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.209.20, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRgXWa8Sl4NycH9vQEbH6mUDWtHJDNrLrnhBshdPo9wGcgVNKOMscNAUwzjfWIwVU8ye39x14wIoLY9Fi9AJ2KeP5iNo8DOgzVdJgTTcpuQAT5Xf0N0Uvceuf9n6jxoYc/Rf3vsOEYjNbEulv5mMIddvbB2xo/qvcB/Q+fGk2LH8fp7NQNSPgWRQKVQ4ij4R4j8ILeYNqpzqp67kNM73Bcr99tZzcYQYCwjXXdGJSJNCIyVIa03r1RIOKuPHPbez/u+dh4doRrah7hhtf77S3YjPa0ZMOGrRaZvA+uVLriF6TW3PrV7VDPoMS6L755tVwSc8VfrZLHIAXDSOuoRNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL6enQx4yHW69uaoNOsgoLooKCrgKEj3A1s4K2Y/9R0=;
 b=LnUJm0owtPtir/N4VdvO4Fzzll7heu5Xt+6xDQ3AgFno6KANU3eoF7U7VUkQLbosth6o4UXl5vv9dHd2vb4j0T+ZX2Ms63vX4Vv6prlA5KAM8EdiV82A59RqW9S5a4NF10evOB+hLKRIALpzia17IncAfCA967VXTU0MEVTZkAFjyHIrgbxu/mj7ni8lx0H/aR3+g0QUr8Ba0s+ciw490L6sWAJfnBNPu6kbcqUFvZr8xr1f4h7ufPUFCwajhQT1PlXj8SuEqOxd/2qU1lPNlorX3ZwQhaVqbhlGf729pmc121xdIojqXWc3Aw9BXt97KGcpbcXmmV6aQZxM9sYl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL6enQx4yHW69uaoNOsgoLooKCrgKEj3A1s4K2Y/9R0=;
 b=aTHRqmIKWX75wj/ZF5avRgHKEvb+Rg2hXbP9nQbC0CtxB9BNlEPdoq/nCTR2NFayzfAuRMvVq6+OcyXCxnbLQFYiudlildglwd9M5Xo02rfjXIW0kxOgu9jjPbDR5XUpPvCpG7+Zppx5FtMXxbfNypqt+W+bTGZGpFnoO552JJpxG3MAn5/v3NYeUIVsnpgWyRRlpBOUAQF+mpltEPybu1pmOgpvbdqn7DP+Hx2sh2EPLwKwsSxkjaq7GE7LRooaDhgrRFseU82tJZWFKBXQb3ILgT/5jVZLjNewru264C457e4/p6pFZf8Bu8nSCDOUoALo55NU2WLRDhbhogzhPg==
Received: from IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::6)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 16:26:57 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::2e) by IA4P220CA0008.outlook.office365.com
 (2603:10b6:208:558::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 16:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 16:26:54 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 28 Aug 2026 10:26:36 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 4/4] doc: update manual to reflect bb.fetch2 => bb.fetch migration
Date: Fri, 28 Aug 2026 12:26:12 -0400
Message-ID: <20260828162612.753815-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828162612.753815-1-chris.laplante@agilent.com>
References: <20260828162612.753815-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb98edd-c129-4d36-4f47-08df05212c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	4/W7+i8X8FDLWPNFOyKq3HLXu1oajpg4cJsMquiUsrlVCU+TOiF/WxB1xMFkt0xNGDCd0F9miol14j5y9juloeT0v2O+Y8PXbCaVzXBNE2/x+dMrcOPaCKOslEKcjd5jo2V8+ElHO4ytqtNMTmbY19UZB6RE5CCpEcnVwB+p2gQpIiXjeXcS0nj3fX0U4CJK+SIjiSg/+Vg8Vaawpzjz3Rl6V8gXztxfHfjkAVbiLSCGixzkI6Dj14TKMXC4CItmapR6DCzQSdden2+qCh6dD7U38crRMj5mrEskQYgA9L+2GhqwqLmeFjbN3jZ0t73JSehu5xxRUNcPMBhFruGWK/17/j5cxCxwze1Wm9knoabmUhYsMXKv8GbG4qJWnQ3iHA99oo4g+5Q4uUkQNKOH5bIeCkQmGkw7u1jwx+Oz0+7Xf1Ah7nEYKakw/aUEql8XdZp271LrinbEs7Yiw7l17OX5JHgXcsbGT8i7JYmWHuxC337wCxZ6S5gPNTMDeYtrvFm822WBgunxb+TkxoKI13upGUw/xyr7xCz08Mp1lqcI27tjiDt1vdZAJKQm4rqWM4/cfZfAbDUmc9fTXFadD0wNtfCXUWnQiw5bvui3DqbUrigzsivbv7VeQQ5LnRLjT3uMtfTv5hffgCnr3gW9ApSDpvPDJaL+SWyXan2HkatagM1dsGmI4tB8eAF7O7V4QrJhFyiOHnO9+HCKGHRkDQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	fTd0kenrowHN5RoCG2T/GUId7Y3uiF12/bgU7NL5t9DX2bvk17BrcGdQe42HSyqPlc6X65ygyDst1QTw6w+VZDE8YBo8uUCv3UoTnQqExVukBO3M6DyKEPqa+3n9UwwmIAZg06QjlmDs80TGsNUlHgHFMkzhkfdeHX0jry7xc2VoozW+218QABodgVrcrFtmhERTk4PWw3Tpcglc8OzaGQvyL+WFW9MLf8rKxI2o5C0ul+KuecHANs1SSRISvjbPuB8VUCg0MBCndV+2Z8WZU4U7hsWIMtQksbs0H6bzLdBXA0S4AQN9St+3/Y/upRbd3gzlynAK5zvf/sCnVtu/Nc9l5DarNGHn5bWZHkZpRJP4OimpiBQwoq4QdS1dG9hQSVbd7WxCJh16LVnA+RkhdPDDXMVIZwS4+IhE4/fPvJGjjMnoNv34tpJss+Zk19fK
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:26:54.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb98edd-c129-4d36-4f47-08df05212c7e
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 16:27:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20120

From: Chris Laplante <chris.laplante@agilent.com>

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 .../bitbake-user-manual-fetching.rst                  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-fetching.rst
index b96018a4e..d326403fa 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -11,10 +11,11 @@ with the intricacies of downloading source code and fil=
es from remote
 systems. Fetching source code is one of the cornerstones of building
 software. As such, this module forms an important part of BitBake.
=20
-The current fetch module is called "fetch2" and refers to the fact that
-it is the second major version of the API. The original version is
-obsolete and has been removed from the codebase. Thus, in all cases,
-"fetch" refers to "fetch2" in this manual.
+The fetch module was previously called ``fetch2`` to distinguish the secon=
d
+major version of the API from the original version, which is obsolete and =
has
+been removed from the codebase. The module has since been renamed back to
+``fetch``. Existing code using ``bb.fetch2`` remains supported by a
+compatibility alias, but new code should use ``bb.fetch``.
=20
 The Download (Fetch)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -30,7 +31,7 @@ The code to execute the first part of this process, a fet=
ch, looks
 something like the following::
=20
    src_uri =3D (d.getVar('SRC_URI') or "").split()
-   fetcher =3D bb.fetch2.Fetch(src_uri, d)
+   fetcher =3D bb.fetch.Fetch(src_uri, d)
    fetcher.download()
=20
 This code sets up an instance of the fetch class. The instance uses a
--=20
2.43.0


