Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15718.1794780602862821189
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Nov 2026 14:10:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=lefMZ1/k;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.194.59, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMv7Xldf+Wi+W9Lr1SrA76wrjbeQCFg9NQDB+pVRWSex9FrzOgy803m6anD4mSRqNHGDYxew3ENSICKke4pQHgaVW4B3SkIhJuQ3qW9FpdDYc5L/v+uVyMnP1OIpK10xdBzcgmdWqI8WTqqYa+5qHP4BqkudmnOE4Psrtzf2+uWnSKBAzMBGc7qyj1sqqpJyMmwjCgLfoRnmxaCUeGYCL3WKIclAJQHGgnT4Yh5XtGUDaRCdckfH+TO9uFvshFbF11ulY3ynukhXrydED3Qu0HGz3SYopHIKwfmjdTG8DgL1FRMgq/T2S2Xa0gHomXx4qsXYyK7OWGvLhsv1zWZxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etXFbrVd2Ej4h8/JWzRj5ftS1GYX34gXWXppkNrJfoc=;
 b=DI2cXT5K88KIJphz2k7jf8O/0VTVJkFBchQ+/BoRY0EeqeFMZODYYdOYRLYrof1mYtU3LHker9qFeFX5Yo+CZCT4BX9wIuKOopYfg2S/eL63yJXeZoHTC5zVFzkYSqh2vnQL78L1h+A2pUBXKn1Iyk50PUls6JvnFpo6doQzu4f1wM/QHOrWBCHU3BX0WgMj7uqamctFsch1iEN7NVga0uh6RJrqHO1UBxWz4gYG9KMmFVzlBiA6Ntgpa5SNrZbVCupDjGzQzsYJkY//742DbsFrqM5fqEhQcQTh5gUewEvi7go8EiVqrmweOhttSue6z2SoYHxtFhcnld7A0OfSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etXFbrVd2Ej4h8/JWzRj5ftS1GYX34gXWXppkNrJfoc=;
 b=lefMZ1/kxrqrO/L9LLyRuzKRpzuH/FC4sojNA7Lo+Vit2VKC3CGI/+lecxkwafCuQA2gV0s1c8mJUJ1v9XLCjYAQBXgYU/L7ntjS64TMVZPl1e0ON0Y/rXvutodYrummtrKes8bHh+WiVd5mXVIH19Q+4JtZ7hjB92UJJdghWaM=
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 22:09:57 +0000
Received: from CH01EPF000BE948.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::44) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sun,
 15 Nov 2026 22:09:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH01EPF000BE948.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 22:09:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 16:09:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 16:09:56 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 16:09:56 -0600
From: "Mark Hatle" <mark.hatle@amd.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] runqueue: Don't defer setscene tasks behind already completed tasks
Date: Sun, 15 Nov 2026 15:09:56 -0700
Message-ID: <20261115220956.758312-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE948:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 197c6b8e-beb8-4923-5693-08df43652f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Et996ZjkkP2N5vhMv8vwbqHGt6LMIs1kebgsBRA+pxeEmd5r//DorvoMzEUFJcTkamV1OUHSvcN7oLxSSXG+2SK52N+mNNUlYvFUNEsQqc85/cHPhXY8vXZM5Kzc/8NjDaD95I0A1K4DhxrMqLYdUBuaLfAf2FlW9rpUXiVIbcC5knAPFqzyjUddRKZIg6mnotn14iVpt1eIo2xnRA0Qkb9x1Tq7g4LoQhvVJvcZsnar5C6ruzmHDZ1rv8eRRTlyGSYHAj7DzxuuxBfCvWdeKnHhycZ0ElMNWl4AZIFmuV0orvBKNmUe7HAS2wxb/2doSgN2qbDjo2e2FjrMDHTADPfnN3aW2+Bup/GgTXDNn32RNUvF0n/wFyNRc0EmdV5dHrrYzMbZg0H2OtZ1XDhel/GhTI41451YUU5eB4+ax7dFM8skIaGfrG0K80rbelDe2dPm5/2PEW58aOeCGKzOnpRCFG9Lk3g58wVQnFESPWu4RE+Sj/D0A9R3Wd9/3OuFo6UxRnFEM7oYkSLhgnsrU8+/7CJeAu6tXKO6xVEcIhiOkcFBGixaLorG8Heav+1uvaJOW9rVF8pvT3btTDb3XIP+HmEDicVZfZ+1GnqrASrYLZMS+J6pTz8xDQHPbDmloafLSyOa6RRlmcC/QMaRoBZ3NUm7abvVWN0jIH5iqTr16sWxH95QlX7IYAGahJRCsP1WuVGxjMlMN+AgJyaVVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ixeikqQaJo8nX1fF3jCIhUSEnSCMNo6PfI/e/AM+g0wjT0KPvIEORHdebV8WJZWNvTSHikgNDcA5wSIp3ksjnjzF5AWNLYaOKYR6i0GLvEq6u5TYUC2kobTjt2QwcEVGJ37/XtfvaC9lfl72YemYa3KH0wCQz/MnhhMHVv8YkMlzfG+KPTE/p925NKxCrefWivZXuUvGkrBMtoNNfN2lAFhmcuJhjbIwO1tWzdajEPz34pM7TcZTEVJJMpc8MRUfxfcgm/18XDFpYsadGfq7W3nJUwzIJLxnLgmlTW3fRIVJ/62D8kLST5yqhRpNTjsx9GLJW06u1SvSvVlwEAhueR6lG3KTQglNqWDqXGdQhMne4RkSQ0XxFcJUzRez+T6yPya6ffe7T8Vt2dTAUadw7IoLsn/9zjMHkcDLf7EDUcSlXzw/iqGGC0FhQ1zNTx2q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 22:09:56.9466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197c6b8e-beb8-4923-5693-08df43652f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE948.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 22:11:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20438
Content-Type: text/plain; charset="utf-8"

When a task completes, the first setscene task deferred against it is
released and any others are re-deferred behind that task. If the released
task had already completed (e.g. its setscene was skipped due to a valid
stamp), it never completes again, so the re-deferred tasks are never
released. Setscene then can't finish until the deadlock fallback forces
each one, printing "Runqueue deadlocked on deferred tasks".

This shows up with three or more multiconfigs sharing a task hash. Skip
already completed tasks when picking the new blocker.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef95eb46b..2a6b099b8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2112,6 +2112,10 @@ class RunQueueExecute:
                     bb.debug(1, "Deferred task %s now buildable" % t)
                     del self.sq_deferred[t]
                     update_scenequeue_data([t], self.sqdata, self.rqdata, =
self.rq, self.cooker, self.stampcache, self, summary=3DFalse)
+                    # A task which already completed will never complete a=
gain so must
+                    # not become the new blocker, else the remaining tasks=
 never get released
+                    if t in self.runq_complete:
+                        continue
                     found =3D t
                 else:
                     bb.debug(1, "Deferring %s after %s" % (t, found))
--=20
2.34.1

