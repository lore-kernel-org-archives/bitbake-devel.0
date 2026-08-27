Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01CBC61DCD
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:02 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3.1787861876751414198
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=jhsGG71r;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.201.63, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+WaEKiPGLT080N03sQH0mNx1yjj6MKgjFxaQlrSjz8i9tjPgZFUiHNEQsT8hbzX10oMBE+akwOWt0bKodtabZLEf/05/Hte2QkFIgPxocAVORgvrwtcmSuXDbYRXASNQVNuM9Y26FsSbaznLzuCUnXw2JKkrpNexME8CCG6TdXqJAMeXi+fmUtYPE9ou1Y1uLCX833aHRuMIIP4yLfgqGJrI7JQ1sB8PmebQWDJzDSHdVpSKzuSXfrhKBfOkpzNHjNobU6jKZkU32swz/e38YJJdohlZ/7Ai8Dy9nInm3xC1M/60cParc2uPc6mowVKQbsMswQQCrfaAnjvFVmykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5roj8SHkgtuK8sm1ryTVlzF2OcVjiQJ6xI64eNFyUk=;
 b=g5nPXK605uWd6V8vnnLzVuDi4+tG4mfL6uJhUvoaa95S3Umm0Tn054B9RMjdnE+sHkRbVc3iug/sWa2TApKP4LXXsMM0+mA2iPQJQTYUGisfcSJdk9eACfzD3g/Gq7GqVnqiqoKKHtLs34+soJlnZ+/Ki6xiRnn2ft7DeKh6JO0kWFGWeMblFgDzdnXpr5IaWvDOLqQ+LIW5oI5qpcyR4DHgCjPNxMPXW0RGywKE+MOreraQtWaJAczFGeAHh4w85n8pd8ecfDPyzzqneGMUcJJtZ7bxElwh4Se0qyEk8SIP1BhLPwZvGCgAVMEgqaTlOy8FsZM0yOxN8pfMJ7pkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5roj8SHkgtuK8sm1ryTVlzF2OcVjiQJ6xI64eNFyUk=;
 b=jhsGG71r0+VBFTpFyUy+oiSGZ8c4jK8eZJtoiv1wQlKs8HgpGYwtPT18grHOyWcI4JxyWDE9KAtSYSVq7oSc60U3vTscw+peJYmw5lhKw5Lf196lQsYx6upD4H6syqyHWwlrda8lpwCcxVJDHL/2uuOpFnWU8EPLoVO4XRl+0EjMXFcusY0U+LHUDvxbBI37fp4GV88Q9zYopBh/YwFxIExnCZitYEvGDhTUoT4aHDTCr7sTRGUmQIJVNx753lB6hAT0JHqT/Jmts4uEqzMDQgsQ/0IQYKjsWVfQMxwmG6kUP3tb/DhHlE4wCZZESpLoVwRpMzEttetqeFlsU7rnHA==
Received: from BN9PR03CA0291.namprd03.prod.outlook.com (2603:10b6:408:f5::26)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 20:17:51 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::12) by BN9PR03CA0291.outlook.office365.com
 (2603:10b6:408:f5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:51 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:34 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 09/11] runqueue: wait for covered tasks before setscene
Date: Thu, 27 Aug 2026 16:17:19 -0400
Message-ID: <20260827201720.698482-11-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da8a884-e520-4b73-eacd-08df04784526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	TURQlqwe34IOpU0uy+g0h11eJiltoB3USn82HYq9o2Cifxgx8evPBa+dbNkAC6hls0GIc/2X49zusEL1NRoHtelNe4NG7dEdmq/evg6LwAi0P3s4q09HcIaphIHzlRc0aQreKeGOVaGj1MQVY0C37BfSuFwxap7RRPRAaIUwZkr0BdHy/sY8wYZ8neri6Xj64YgwOrPqj9Qld3bT3DDHdZOMb/wUTm2dPoQbuoTqGIud05REknzEo2F+yQcRJh+onoZBt3DwQDbrKPhScOY1DONLSFEWr+4/CLLJs2liUCssqSZ7PJLKPXM2WkIMZJl0IYDGitQQj41e+IZZDBI7nWNzZI7FydviwUiyKvFMvatnQxjFYQG6onARADnkEIzlyMqSEU6hSf8qTQiOEIPAGCqJqutgLWZ+U0z6aCze7BfZIgq9huO1o3AehQ4EfiUN7qhQwZ3QosfIGjNpTjBZC8mHAp3N5/0rKo/UOZHJmNP6boWJ1PGyYi87fiyG1FqPuRQd9I+nXjOCdBoQQfyTCDzOX4u6zAW8qVXuBn6QrwuWY5vP8CJvbEOXe5fSrnNEN+7iMCfWfhP9OXU8Ci0CHh1A4NuNJQx4RiKcRZHqsxPavIBfvx8nl+LQ5BxXnvSOOCm8/lE9RT2DS6VUgUEKoWigshM2BA++fRYKEGuPfXxBFZmGIim0bZVpKP3Cd9qV6gUHK5l7jjQItY0yO+6KMQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ivmctlCVfn6aBfdKPc5lTvimGE0tC299JxV5t4dPNuBbCAw8idYz05qnQftECFUoRl0fHv4wT+FnIp2aQfIX4QldTtLIbrE5xdGaxV4Vt1jORbHryWIMq+0grtrybTMAMauA3qKOYgGAgb1ohjM785GCWZ9FyfdMusmzV+S6DXqnd34CHGoMqvO+jfVkisWmVmRORk5Sdw93gX4fUHtQUuqKMrEF6RqMWhfqn35rGEM7pQXA09QSQ89XCLmUgV+Cbyj8nYPd8aPM3unz6VrRKG2dndH1daL2dBZhFhZjSVQphKTCx0cgdr8bm8xBjQrJoKOdC2r2HBVht8iGOffRh2FjKPxbrYMNgWY1F7hxvIUwOO5zhDN+67RSClmS3M0OAeWwdo9JQUJ30Lf0nQGeVmp4rCueODQuQrh3volAt7pHiO9sb+yO4Arwr1JL4sHU
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:51.1297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da8a884-e520-4b73-eacd-08df04784526
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20094

From: Chris Laplante <chris.laplante@agilent.com>

The existing continue only affected the inner loop, allowing setscene
execution while covered tasks were still running. Check the collection
directly so candidate selection waits as intended.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index dbd69b055..75b879ead 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2252,9 +2252,8 @@ class RunQueueExecute:
                             return True
                         continue
                     # If covered tasks are running, need to wait for them =
to complete
-                    for t in self.sqdata.sq_covered_tasks[nexttask]:
-                        if t in self.runq_running and t not in self.runq_c=
omplete:
-                            continue
+                    if any(t in self.runq_running and t not in self.runq_c=
omplete for t in self.sqdata.sq_covered_tasks[nexttask]):
+                        continue
                     if nexttask in self.sq_deferred:
                         # Deferred tasks that were still deferred were ski=
pped above so we now need to process
                         logger.debug("Task %s no longer deferred" % nextta=
sk)
--=20
2.43.0


