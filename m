Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE438C87FCA
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 20:42:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.96.58])
 by mx.groups.io with SMTP id smtpd.web10.18987.1753821767051154788
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 13:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=eo1EK11j;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.96.58, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqL74QNtoMTUn4JU4OGV+ZhB8rrSDudhh0VKqWjA9SjqVT4oP/YIcYmUF/eM4TM+7g1TJuy4mmrBZIrHEj1x57vU4DCKNjqIlNJ6Gxkm64dypqFIU1J254Obzbke/p5EuPJqEETDqsSSGGPpo9l+1LTPc0OBNvQvdLJlw8qEcpU6syY5VKNCzJ+X5jWtZqyo7VEku87IuNMThcfiCFd8Mgva5X/IDbRx/rublWzXWkzQ0ndb5/dkoewdzJMGSnGPsP+TcV5pvV7NDVK6c1Y1rFKo3EJErY+N07HhJqe51b5sOHaS5hILjzh8wGb0Dfs2KGWb+Vq7EA4fxZem3bE67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuXW87HAOTf0O37yPdOiOxvcH+EhvTkMZQwDoKcG5Kg=;
 b=EPi3dZt2pG+A3dswqPBIJJkMQu2z3U3L46V4O/AX1/fY7aFuUmxrz7udWSsG7ErJjyJFv0mDnugcvjRivoTYVnyrumnrhMKEtnQufbPy5H319pWhDqoeYmPdeGknKxvjZp9kreUiWee9VMXkIM530U965wfs5brhwdPdv5DSsgSfqMxgcnV6hVLfLP4izjEX9JvM9t6eARxBLmrJ4GyzQ1QBHryWApxxQ8myIfqG3kt9wtuURkd9RZ8yIwbOHAh8Zvh0s+nSWxHGb0dxGsqvMWjI0DSK4oihZ36vZKm2a3Fc7zBT4UVY1uXtpRkf1gmK0ppJz7D+d3TF2115GwkbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuXW87HAOTf0O37yPdOiOxvcH+EhvTkMZQwDoKcG5Kg=;
 b=eo1EK11jgy8kPvptvTIcB/WnrDzEQVbircHvnCWQVr1qedrqdiaKy57dcoxkSIb44cDaNOMjAwkAUBjmyCg0Sqco2lb3jCg5jyT9nlwZzu06ePEiMPl/l2MC0yfNhkeSeUBT+dD2p+w0bgfmPdnpjHDt0a6q8654pPE/Xdx7UP9gTjbn7RO9zOWSvcaV+1mGBF9hHuq8UIIJQPW4MrpNA+Y2n0xqJc+wZ2VtOzPqQo8Og/8RswkZLNdW248E9Uoz/exwN6vXrbT1jzCisZ+5WBK+EjV88IStJ9WRlVE4hfIqeN8bT48R16XHtkufQ/p1dNU6vjXyGhftxyIqZlBjfA==
Received: from MN2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:208:134::33)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 20:42:41 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::b7) by MN2PR16CA0020.outlook.office365.com
 (2603:10b6:208:134::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 20:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 20:42:41 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 29 Jul 2025 14:42:33 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Richard Purdie <richard.purdie@linuxfoundation.org>,
	Chris Laplante <chris.laplante@agilent.com>
Subject: [2.12][PATCH] utils: Optimise signal/sigmask performance
Date: Tue, 29 Jul 2025 16:42:25 -0400
Message-ID: <20250729204225.815110-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: b690baa4-efb2-4272-c90c-08ddcee0768d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XhLL2RGmd9fSvIEMaoo75dOy5N3QTy70M8q/dqURuVmM6DKabG8bbcbbz095?=
 =?us-ascii?Q?Y4RKwesblGRuO/KOgotR5g7fQdXlx6Deyn0SxQmtXpBvSXUKy5dxs7lf3RcJ?=
 =?us-ascii?Q?vpb53Cg+ZhIK7zeO/kuGuSyVVdJ6OcTiU+wNFGCV7zgPZEblYG3BDdoJBmzk?=
 =?us-ascii?Q?OrD+nWjuslBCUMlr+kEZcf7c1LN7aAT6/y1BZ38Vp4MHP/SFl2NbQdSmbekf?=
 =?us-ascii?Q?ROpS3Eazd5Vi08nR7sTHL0K6IR10KTh3eMIcuKcaNxr+XrfVZ4UpH4FS5LIW?=
 =?us-ascii?Q?Lvid5TK8MOGlboSS8QIxVep5P1KATpwyGzk3PcHT5gkY4WSOlmDo5efD5/fv?=
 =?us-ascii?Q?ch+bB0cyY1ryBW2rFXOgcUsEYs9Uqnlt0Xm95f7eFy/SwQdVB26Af4CSB3IM?=
 =?us-ascii?Q?5ewyLo1VjDF4js++PLluuAaNSrhcFS/NEmJ/GfVOjOImFl5MI4uu40ZTUgF/?=
 =?us-ascii?Q?lWsMIPhEW7dGkfRVc8RJ/fGideG+3eUwmNqwg15klST+VMoc1NTnnw2sR+hq?=
 =?us-ascii?Q?0A/ukqJqUM8Yg6fIvcMRk/jzVr0PaaD4cBV6Ew0GpXv+3Vn6SR8ciwGjscwh?=
 =?us-ascii?Q?Rap2QIi/mrdVewhJXLRY1mJlvtFIowf8df0ZeE0ClRutF9bdjDZfu84ItM2q?=
 =?us-ascii?Q?qHdzIYUASXaIUHpbKcIg7FR1RJcAYp1cDa7mMnjBme9ecSCzBaImbmYRXq6a?=
 =?us-ascii?Q?XKhTDX5MeUlwwewB/Uj8+PaVztgcQZQxvngndKALISuxvBpVxNQGZbd9Ijt2?=
 =?us-ascii?Q?tTu/Ckk+s/fSZzFZ3MWekcdWWf6aSo7X7l4QJfI2mLFLRHvOgSOQM+XF8VzQ?=
 =?us-ascii?Q?1HadPX33uhaF80Tg4IKaYQa79GXStZAZjS3gwGgXPNtzGrh473fiHNucc797?=
 =?us-ascii?Q?p8nMObqnylDbu3c2NMLNjrjyfsSiYHlMZSKIpIhY2NS56bUXzCiXW1cesg9n?=
 =?us-ascii?Q?zxBjCFqlb49rcUFtkWeBkx/zQV+OtCq03ucYmcUAtHcT+hG96iW0XWJbYFjj?=
 =?us-ascii?Q?YVaxnxO6KSMWFIvCDmWFek9rzqhaxQs6vo/bMFHjWHCegXaNn9Sr8bTwZWxy?=
 =?us-ascii?Q?TDYT4r4Oj+FW3tLaCWPjjnH8fhrhPkyIoU7pMbnYZkSLbH/PksZIMbjmB4W8?=
 =?us-ascii?Q?P/ZZeNqIQC+63/05qcU0T+eqB+a1vq6cJTpKDGUAE8MPVeHQWb9XSZDxQHE1?=
 =?us-ascii?Q?aUV/krRf6WPt0oD3ck0b1XJyGJjnvdi/KBD2fGCAQsJ0eyEima5natjWDeBA?=
 =?us-ascii?Q?uHVc1tcJ8TTAt9l7u0+/aR0woX2nTSBywfmwwtvWCbDMsGUQOhhLWw+Konis?=
 =?us-ascii?Q?fRWtAcLGIAZDWt0gdtmQVJnD6mjY2NWJw/gCilK52NO4EtV3sqebJcFzk2FC?=
 =?us-ascii?Q?gqOS0QnVnVxaQ79jisdxRLtP9Jx19LoJdusPY9/+S21hKHd5eUj40+zNSCMD?=
 =?us-ascii?Q?08LMQdca1HqAuWZfg2xB5c6oC+VHryrrm+24fphq2g1W41khrRd8ITZJ11oO?=
 =?us-ascii?Q?a++w5+xsWUJDMpJd0fTo20JqJyJOqtbiJXo6?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 20:42:41.2166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b690baa4-efb2-4272-c90c-08ddcee0768d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 20:42:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17826

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Running "time bitbake -pP idle" with a valid cache shows around 800,000
calls to enum creation from python's signal.py. We don't care about this
overhead and it adversely affects cache load time quite badly.

Try and use _signal directly, falling back to signal, which avoids
this overhead we don't need and makes cache loading much faster.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ee5fce67ce35b025c68aa61e2e758903269ee346)
Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/utils.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 5486f9599..083242268 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1876,6 +1876,15 @@ def path_is_descendant(descendant, ancestor):
=20
     return False
=20
+# Recomputing the sets in signal.py is expensive (bitbake -pP idle)
+# so try and use _signal directly to avoid it
+valid_signals =3D signal.valid_signals()
+try:
+    import _signal
+    sigmask =3D _signal.pthread_sigmask
+except ImportError:
+    sigmask =3D signal.pthread_sigmask
+
 # If we don't have a timeout of some kind and a process/thread exits badly=
 (for example
 # OOM killed) and held a lock, we'd just hang in the lock futex forever. I=
t is better
 # we exit at some point than hang. 5 minutes with no progress means we're =
probably deadlocked.
@@ -1885,7 +1894,7 @@ def path_is_descendant(descendant, ancestor):
 @contextmanager
 def lock_timeout(lock):
     try:
-        s =3D signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signal=
s())
+        s =3D sigmask(signal.SIG_BLOCK, valid_signals)
         held =3D lock.acquire(timeout=3D5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins,=
 timed out, exiting.\n%s" % traceback.format_stack())
@@ -1893,16 +1902,16 @@ def lock_timeout(lock):
         yield held
     finally:
         lock.release()
-        signal.pthread_sigmask(signal.SIG_SETMASK, s)
+        sigmask(signal.SIG_SETMASK, s)
=20
 # A version of lock_timeout without the check that the lock was locked and=
 a shorter timeout
 @contextmanager
 def lock_timeout_nocheck(lock):
     try:
-        s =3D signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signal=
s())
+        s =3D sigmask(signal.SIG_BLOCK, valid_signals)
         l =3D lock.acquire(timeout=3D10)
         yield l
     finally:
         if l:
             lock.release()
-        signal.pthread_sigmask(signal.SIG_SETMASK, s)
+        sigmask(signal.SIG_SETMASK, s)
--=20
2.43.0


