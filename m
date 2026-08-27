Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1851C61DD3
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:02 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com (CY7PR03CU001.outbound.protection.outlook.com [40.93.198.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2.1787861877878808083
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=z5ACmVO0;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.198.46, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsHMFWt8Bo5ndDafMPOUNYPYXuQbXTWDpCVZtFfqdfTgAl3tBRHfuNEOmfVl97zdJklSyElvnRoOxgBUTsp9fh+PtsLPHpcvGvEMHSe0US+bE8V3UkE6OpgPfRK+4HtpguZINYAH2jQNQJkIX28T1jhOSsSDVRKyWNhBFE5scFPI4SEyIE8pny6O0snFHweLApkA1YeaWsplAHQdYp2oG9qOHkFl1omd5ukpm5+9V8oN3YFBIz01BmN/70jeM0FgVSb+VYrRJXDtVOexLUw9fk1fa+CDMsX9rBXh5Ge3wK2h9esN1UQAlvB2aXC0dHKCpn7wsJ5Gkzlmc3kP6BBcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSbx5gPEdsL1Yde5btScerQ6OFQb1TgKMsM601qMQBs=;
 b=Ue66vSn5+Ymd6GzBW66kOqH0dTvfBpR8vuUVyAusvnCG1cZs9z+uL6kfOoYRzYjVal8HmG8o3tZVFWvHcGp63esCHWPA1KJJtoVROwK9QB04Z+v+v/uFZDI5jxl2NC+hUIechLjMUzxrYdVsKu9yxBLJNzGrO7o6Om8MRJr1dB1Fsp5MezYAM7/x8Nd4ZKCBzixXRpdxRX7k9KTSvNQPAR0axwO5iGhHihELqaiv4AgHH1XYMlIsskgDhccOEuQh1RhKfMPcNVa6QnMNC0h27UGKVeZsCFKU6uJSfAxkhSUtm1z5SJ5ejG1gxIDco/V24c4/qWypehms+fHy1eoTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSbx5gPEdsL1Yde5btScerQ6OFQb1TgKMsM601qMQBs=;
 b=z5ACmVO0Sl6tGgtUAEM0gN2wlK0GPnW3XjHJmlbQW0e1glNyjRg7BQftueBFN4ftqKW7DOfSyLaK+TQrPDOcbq7U/e+cgu4K7XrM20qRhKRwwIunVJtd9liPsdJUt9ehrKVbCJb4plQgEurMeS8M4T7rvhjAuvZIS6Jwj46xgu1V0oDPnrZRzTpNSQWXmY88pDGcAE0eodaS3WWfdmz3nCpBIN8KCnrLsowcT4xUNKp+1vfwZCOUqPZaPZCNpUxyKKVTR0fVeqTzf0e0vKKUWePCtP38N7nnygOcRvUePBBt7wVaH4hH9nWUpG8zLVlQh4KVvvVp9fszgpNSZNMdLA==
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 20:17:51 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::94) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_3,
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
 15.2.2562.41; Thu, 27 Aug 2026 14:17:35 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 10/11] runqueue: clean up dumpsigs polling
Date: Thu, 27 Aug 2026 16:17:20 -0400
Message-ID: <20260827201720.698482-12-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5a1171-b554-4c22-803c-08df04784574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|11063799006|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	joj/ZE0ZMm3cUmfcg/CVwCDTOnODxW9Ee33bLKK1Uw+Fc7oOuFfcyPd8Oewiti0WZbBvI7BcZYI3cVk28ZajH3IB77u2eS0mWW9FCoN6+hjNWYbKpGeG/KZ5USIeFjMJ2M+OvUyiwhx33UXkaQ1TKEFh9ycc/SZMSDtpA45Zhcjl0gDLwG9Nknp4yfC5ZraWwkM1NGcNZDopfFfaCtBmw1EflyoRjjQA86KGdB0V6eLh98x4VvjGmtKr8OFyvziUypirFb1NwVIWtLqXObRzAuvsbequ/EtWrG03CMYJDnfXBftuE120svzoZ/pgezZfm1TGTAPNEp9tzbSzV4CRTewZScxQLKzTDhYb3zRrjZYZnbKXn1EI/rO14v6Hxr1vRhaL5OnOXW7wLq7it+zNTE9OOunb06E4vvg7t9OOC0LPUVk/8icfj6ideEwGUPVwG45PpAxhx0d6CQKO23+qVvUwgGOZRNF6KWCkUUL3esuGqbg3ebJFHGLvz/Rq6y1wbkK8uMJHOWSBTzMx8l6uKaC5/2XvkXmjrf3ck5KsDDQYoNpCzwm6nKQ9c5pwri+jJw42NYlWivfOHmAZAfyOjSHjZ5v435QijmIM44JsX5HfNKU0DuB8JPAn8z88En7pySq7PMi4mWTCNJtN2dK+wzeh9gEednCf8ry9T68NGSTyKEUAQDrbmfeiyLOuNdDGTxr9pcMftZLt22CaNLHVrA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	3l3qVoOQ1hNsdvZAgFolWz4zRClfxvj0qStiYOM/TX2hzGa81J14gmeIlYGJZF6TT+jiOJdb4fLDZsT6GwmQ/HFMsMnO4jGyleU5VfZMHgxwmHzjAHNa2vIuDE0xM2ZR9WmNQmBAxqlFhuZSw1Hju0Ui6I4FPrNVUzwLJfoOY0gyn9c6UuqPu1RXn4Tnu9vYbeOdPBGGRCSfBCFIsdkpHR5MUH5gQlTAa1grBNb7vWCbAclajPovFQPk/kLZvBNxAGe0IHMz5Tir3LZBhTNddBzjvxtR/x2Y8fdmhW4wudG60ZM3FktrvvguE9ysYnfa17iul8mY/5q3y7ILltC6TTEyfqoMgRapYQvLVTmgOYWd3sA39mNO9dlpog3vHCcITZX34SChi9d0DMYJQe/jPUKWwj1YOj3d3rTBCKxbXx7mXr1h4m3d2SNGERyp/YRG
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:51.6339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5a1171-b554-4c22-803c-08df04784574
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20095

From: Chris Laplante <chris.laplante@agilent.com>

Iterate over a shallow copy so removing completed processes cannot skip
adjacent entries.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 75b879ead..04c1c4d3b 100644
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


