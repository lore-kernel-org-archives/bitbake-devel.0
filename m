Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F022C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:46 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3296.1787861259500976342
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=qmWtr5pk;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.56.39, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekOcrHAy/bjDSaYb97sdgcr9498YO5z2r9kCUrONtvg9yCkajwocendKjHTZ/vkyG93LGC3yMiqZg4PXcW3b2/4/9zVr28SK0BF8y7/8fHNvOTpNQZ0693vbA5QzD7vKCMhEYJFP3HudFrPmF7lRbFxrcxpgW+LF6Buo5PAoQiBMf28IrLwJUukxk/p/v/C/hDoaZaycQezBKBPV2DBXI5hEaMzggmax9+3b4uNFMp+m4EJSa5a0J9M2x+j+CLkoLxpDXkNYYNFTz2rCxzoqYi4Y0Zn/sYbiFBK4DaYO420ujN/RbXgIyNXxjFVNNzF7Q7d3XZyOdEDmyr2u5a1fbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ykq/7vYypGbZnsC8+zUfDZtVB0kwoJ4V97ca9UhNs9M=;
 b=hlLwmZQjG6tjXlxYWOK0FZL8/Y0eE0gpk0JQHqB6F46aRXzJoE/EsWhuu8lF0g7kmN1VTq0cCTeO/frSe9mhFUT2LNWWylxK6/p3OAfslA9kiKJxr0NgHYZCOCLCGkSBcCHrLfvpfYH+ZJDLfP3hWMzpMl5o80aJen+5fKt+WNYw9LNloeQk0DCA/0M6sqBHE5okG8UXtI9MLFZ4o60WXQiELuUPX8gPltFK6SXAx4S6w/iMT44EUigKv/eXquhowMHlBOQIUS798RxdqW/jM7+u6Z9q/iZUyn3e9bJy6AoA9taiGRffUcffP7h3Lt/Py/FmB8w7liTX4wAz+IrUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykq/7vYypGbZnsC8+zUfDZtVB0kwoJ4V97ca9UhNs9M=;
 b=qmWtr5pk9vMMXBO4iovcehhAEFC86iCjitMapaAmFGZy1MsyXGbSUR5oljU6Cw3KdW+zeL3gcLB8mD+touf7hFATpMPB3EnGvY9fK8rRz/DBk/SQv7veQSE0UpBbhgdoMZkZuIws3xguS9w3T7Xt1qMJfCAfB+gUUn7D4JY0t3V0rer0mN0QZ2eM0NIkHLDc+v0/FzRxH2UF8EQb2533cDpPywEgG2qQfgqV7f7p2L3htczPv52EYLJpzSKYtC2BcQ133ct1VGHnnZrNWLLVcM7AEobKGAHlOs1vA3PWwt6Kx/e7DBfc0km7kTR5ElW5OT4G6JAbKZyTOhosxLPYug==
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:07:31 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::21) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:30 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:04 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 10/11] runqueue: clean up dumpsigs polling
Date: Thu, 27 Aug 2026 16:06:02 -0400
Message-ID: <20260827200603.688796-11-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b80439d-9921-4a92-6ad1-08df0476d363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ui/WL7KPe58VA5MPLqgVwLexTWyBTLmQ42i428Eor3nzO27MpiG6kS/QuWYm0n2L/QLTpLdNXyaH5V2hk8FhgDI6VrxSFQcEVV+bejQNZHz8Yx+FVeL6yykTniWGjtYGY1HgWe1ctqRQ5Ba1tb5MUO0GutvBpW8zTb04imgzJeVx+dCStbSUB22uLPP0UqbnLVvNfje3+78UEoag93A6bIUh1dM5ZvZav/UHURPsXG3hrI3e03SewlT2eLeouzelkWvG7vshH7pqLhJEJNaQezex4INIfQaWb07SLidy7WoxD8vWWSTPLOuPfweWUv8kBG1TsLo6svE7v6mz25YReRPaob05SaMVW3D4vvIiFjOv1WcWVGd6tIxu0mGR+Txm54Z1Roma0TX3QCD/fivKt+0HfWNjGPFX+Pu9Chdb50EuXXwpBzSrkMSiPdZishlwdT4y26Au0RaROyRx0NPaDCywwqkXdQzxQ4aqX7ibReB9N1b60mzWmxm6tFubfUrdNORh4UKqBgmbRrU5VTCxOao4WTQg4FEg7M7TDepcMNtWPeyylYu11Yk7h8lZDJnmF4IIKnopWQsGLjR4TAkUF54pJb4r+VdoMYclbXgiSQ0sYNImUKDd4xiCPSkZSCu4RByBIc85aOT0X8jFnB751mJJRVqrGluot2GlX6wgzIWBBjHA6A5gf2AtMloPqy0cYuDJ7sng5txFG+1gEoQQZw==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	626XsevPs3b0YGwDc4G9wWL3UkAJyVQWFXsh3k+Wkh4CVNM8haE5C+5wwKJlGnJMRcpqAgw0Qd2ZCZAY30UQ3rET48yoXihyP3rxzdcFi2vJlZ3cqatq3ajOyUkFX/+j00f8EI/ulLa4sXvSxAOmbTF/8zHMcNOHNhuPcxWNHU8UqH3JpyNaeDIKwd79jV572/lW6v4bUr2xlt40lf134V+H0NRnJuYR1VwkuDPKJrXEGfhEGPlBCflJfjWrwXf/ROD8pwidSgVJpofpg/0bUIX5SYcBq1LtDkLD2gUfCuB/bdJxBn1Ghp1bVGAZ4mwOFlVeB3ZYgm/+U8fj0LNKUNGeYfH83cBPFchbRxBADnM+8Q2jmk2SKIlfWJERTCX46krW53rwp5a4WpEP+7NGfxZ/rp9KDtqsR1339L06IfTqjL/Qy6cxEn/9mZuAoXYw
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:30.7675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80439d-9921-4a92-6ad1-08df0476d363
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20085

From: Chris Laplante <chris.laplante@agilent.com>

Iterate over a shallow copy so removing completed processes cannot skip
adjacent entries.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7de6c8636..43a7f17a6 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1724,7 +1724,7 @@ class RunQueue:
=20
             return 1.0
=20
-        for q in self.dumpsigs_launched:
+        for q in self.dumpsigs_launched.copy():
             # The finished processes are joined when calling is_alive()
             if not q.is_alive():
                 self.dumpsigs_launched.remove(q)
@@ -1733,7 +1733,7 @@ class RunQueue:
             return 1.0
=20
         for p in self.dumpsigs_launched:
-                p.join()
+            p.join()
=20
         bb.parse.siggen.dump_sigs(self.rqdata.dataCaches, options)
=20
--=20
2.43.0


