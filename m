Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0901CC87FCA
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 18:44:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.50])
 by mx.groups.io with SMTP id smtpd.web11.16155.1753814665539400228
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 11:44:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=zJtScJt8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.50, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvYK7jdRj+LSd8CGT1v2D3hWxnl1gHzTw0PTThD1lPlweM9xtA5LdjbZiYd0dMLGmSAsni4dhPG/HJxjDXJbJvHHh00kKaEP4BqBfLkHywMTPsaKRZvUez9vJnfUCuSWTy50wHj/I8SQiPMw/36wcUB7Y0535PiA9LTJ0biY1YcBa/pGtGGh2+hso8XmKUwUAA6kMomuf4ZCX7n1gGxlaRPtz8bAc21B1CaMbFYdg9MOJQ3gcDPkaRj6t/IxpAiu11zZc6/8FYV39peYNjHHVI/0jB+NKZeK23s6Q7pXxXH5y+aHdK742JIaSn9mJ6YoJt1GdHJzvd2RW1076UmNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+bOAzAcLWDHK/Bpr3CribahW89dXvM62Nu7nUCYgXw=;
 b=WpoBAfcCqhJO3xE7iMa0JRQQ0mMHNhLHwx1DP2cdJ7MwDsd0O+dM87p5kXqmEKZ29RKDXIkQ+M7pPr1ej8ESZ5RW1pYI1mCzWsr147u8tCGaeByuDHXuCMsaBnbSArbE3Hmzg44S2jXHR0I6Pffkse/2Ncm3p7dSvmruDyIfeuV+ZjH+kEG/tb5Fyys/xaGwf7dckHVvXYkX2uFPw465lr/G6Uv4TOIwV9FyL7fgSuAZmHDjzy6w6WImIQ5DPe0SaQPnY1ABouf/JVairznSmLqDUjU7dpjp+wtGsuqDq/+Vx6djapUlCm/iPPEJc1jrBzYp7tgAGkSakFn7HLJxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+bOAzAcLWDHK/Bpr3CribahW89dXvM62Nu7nUCYgXw=;
 b=zJtScJt8wsz/LJriee+W4W699cunvLA5fYdosqhAntO0xahrXbxlnZ6z9Uxb9KLecNUzZQbspJ3uf0YDzJfNPxmUSpaerZCYlN6Zvd5vef/XpcUlfzAtoXiyWOCNb+SObHsqHluFLRd0Z1TBV+Zk10xQEIYTVRIeJDMOk4SwARcRjeGfw0uEsHP/AwGGTWuOvrJigFh9mWB2PQ6sT4U+OR84EklSbddqOYWVdZU854FwzqNJvroevwYPA3D6ockZuQlieNYQFGbE3ADXxhl6tNYL1TbaBOLh0MWho7DUw5e3irJkfCLegA7HC3RyLQ50kLTLYWi9TGYteChivDnUEw==
Received: from BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::24)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 18:44:21 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::85) by BL1P223CA0019.outlook.office365.com
 (2603:10b6:208:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 18:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.0 via Frontend Transport; Tue, 29 Jul 2025 18:44:20 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 29 Jul 2025 12:43:45 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Richard Purdie <richard.purdie@linuxfoundation.org>,
	Chris Laplante <chris.laplante@agilent.com>
Subject: [2.8][PATCH 2/2] utils: Optimise signal/sigmask performance
Date: Tue, 29 Jul 2025 14:43:09 -0400
Message-ID: <20250729184309.292510-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729184309.292510-1-chris.laplante@agilent.com>
References: <20250729184309.292510-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c1e805-16c3-457b-d72e-08ddcecfee5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p+zqrOQuQT0NprE6SHGehzO8dTyUxLGn2J7HTBYMTYxqQ8jzY8N1RhZu5zCz?=
 =?us-ascii?Q?8qMA6lVypwJTC0ut8hFqCDxZt430b6THOk68YLyr0twObqBD5Q7IBH0RQnPj?=
 =?us-ascii?Q?1CfhiwXAdpD9NS0uHKa96iHvPXDRRxEhwH7aWtVZ28oZfzTof6zs54oJPev6?=
 =?us-ascii?Q?EJzfGGPntq95p1L2IdLKThmRjvqgCfFPfnwIuk5Op59N4eFUErRdFpG71tp9?=
 =?us-ascii?Q?d5fUx6Wl+zwveNkpTD9w3i0pCEQd38cJYNcI8c7KBsLqGAscops3KjVnLT6w?=
 =?us-ascii?Q?GLpGBUZrL+EdFP1cfQS2a/xiaoxWLix2B4dhB/cKAJAfi2XyAPCENh8uFbGT?=
 =?us-ascii?Q?voGP61NKJKMnlCHSp5/FZKhfgB8NuswRvb/d3vTHy7M/8CP/6sTFxf7yr7Op?=
 =?us-ascii?Q?CmungjMv/ZfxouIZbs3bbeHRbOCH4RUtFpYvNVwep+UVnC8lMISOyK743jeK?=
 =?us-ascii?Q?ie3v9VqWam8GdI/Cl3mfVgG7AwVA+BBNnmH9ugbBDJOh37967a6jqtDh7Osw?=
 =?us-ascii?Q?TwRzqLjKwKE7tax+n6IeWBPpDSDvj4wuH3ya8j9kpytQF212iLFcNtKznlZ3?=
 =?us-ascii?Q?/bYXbLgB2fcgdTzyJ/9Bz7gu5GHuKxZgURsq78UGCtRwPo5Ucbpi+alJEhbJ?=
 =?us-ascii?Q?3ZdOuDxT7GvTOnQpRdXCRUU7FEEXmS8T8Sgq+jxayeV/74p56kRatni69NzG?=
 =?us-ascii?Q?zHQ9fYsejoAM7y8TYi6Uiqfj/mRaYLOrQ3W9zUyy8j1wffJqnM46OB+QwvaT?=
 =?us-ascii?Q?YOBRwGV15+mae+nuOWaF2unill7eh2bR+b4srrXnFQemfdvvzi2X1PeIY7hO?=
 =?us-ascii?Q?0FaZcX3tInGFU5UrqFfsJzPZzIk2VIRK5KkE/bQR4iP1ZjyCXSZUHRe3PC3l?=
 =?us-ascii?Q?OJAaH8iR0kNfJmW59SeTeTm0pU2RSzzyQ1BuKSX+lgOA/pBl/20S35H89xoD?=
 =?us-ascii?Q?Bv6EeZlD8Fisdg0VTQndb9ZQmWgpymuVs/Ag9/xmOoxs39EwwtKMaPYHs8Pa?=
 =?us-ascii?Q?WLzIwvXBFM1nVjoqHlkGOsF4HdlPDEiHIHAgAhP8QDg7upoABY3Q4QhFS1wc?=
 =?us-ascii?Q?215Tenk6U7TmyNHuhU37zl4/ZC0OkSdUGAqoilVY2X+ELxT/msErTjsBAbAR?=
 =?us-ascii?Q?lk/3zpBGYNShJljd8HwBjYnfgZ4hDIyXEdypW00mckCG93jDaOtmfHm+sD4E?=
 =?us-ascii?Q?wr8LJr+dyHPeShQIbJO0I0i3XJiiVloJOTcV2EKZoaxmlTXlLC2g9TitluCC?=
 =?us-ascii?Q?u7x7sfSOEIb42AkR78fr//OqTqXIiEXvOvdbn5rlnYlWA3OnRagqKhyYt2F2?=
 =?us-ascii?Q?5ywM/vovFc/cg0uJOoqfgr8gZAA2M7e4R96SCrgi+qOUJ5SDhtmdkPh9UcA0?=
 =?us-ascii?Q?Penv2HJlE1ik3PBMkCJs2DqlF9PXDTtZw9SoFFm0xcY1Ou5oOSUaU4N1HTb7?=
 =?us-ascii?Q?xjqJAXFL76mpKcwmHfrjP3eC6VKLqtfRRdGsy5jdk0wAcTIVqBryZS+p/AjW?=
 =?us-ascii?Q?9GboKAYxtq34Iz2LmX2WNS+7dascA9EOcdTO?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:44:20.7957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c1e805-16c3-457b-d72e-08ddcecfee5e
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 18:44:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17825

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
index 67e22f438..d2f11e437 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1854,6 +1854,15 @@ def path_is_descendant(descendant, ancestor):
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
@@ -1863,7 +1872,7 @@ def path_is_descendant(descendant, ancestor):
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
@@ -1871,16 +1880,16 @@ def lock_timeout(lock):
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


