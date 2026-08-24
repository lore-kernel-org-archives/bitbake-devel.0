Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33574C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 15:51:41 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.832.1787586700525168089
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 08:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=UgYJHrLj;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.193.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqhfQt1r88vHKp3O+Uq+JfC0D6Oo1Z3WBjwnyu13GWf8fkALSVyzGfrVfmoL2lS4/P+eHZMarFS0TXoAu3fR5qQCIhEXO1SiCmYaeCQdk7FVVb12lWo/xxEfTzfsI+kcOg+5u8Y5AIq6JKzCO9JvcY+mtraSPd5zhVkdaDdi3FI6ODw+ucS1j0U6HHQPfPZOvl/iPBIJR8NusfzdhCmzYSv/xAa922oKd3VO3X64cQ4D8MipxtHxT3TDf2X5o52KrfiHP2W351PbOiY9xWTbpmIdsmWdYkihArMDH2c61acYgPIX1ajloVNw1yRCMBJBqkhB1ZDbkklxA/KzugE3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lOsN9a+RQD2ysnI+XwG2OB9w+dARucRKocFkrB9F5w=;
 b=XAYgIdwvwGa7e7kGe4YJOEZOBH7DT8+XypbqhBe/uEVpTWBBJ9kYBMtvBv+Gp1fsqp3ZH/2+PL8MWE78Oea0CPO+iA2RyrfkF5hlmzl93cMR7EbCfHa097JMnomETygRwl8ZJoqKKTkpwba6vtqhw51YMmL7uTGvDF8na1acP+/T06hCIzHlo5EnTMZ9Tj56Y6DUMiizhRN9izeszp4s9iknmhdFvyWf9ONxaNM8HBN78jvWJyAaC1Xx0qy09x++a0KdLHhMDy4rh6Kn523UJC+WUPVG6ol3Td/8hONElJbmNrVHcg/Apoaf0l/yN4uMtFiuY+zbz59vr8JIHLssCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lOsN9a+RQD2ysnI+XwG2OB9w+dARucRKocFkrB9F5w=;
 b=UgYJHrLj8zG6ZMDs2HPvXGWD17bZofbM4yJmvKKOCTs4BeZNjx1P3GwHhwwQGaamyrPCjHe8j1+M28RHxiFIBIdxZ21zP+0yHqdYKnXa+n2oRflaPKg8rPJ7tr5Zr4hlswrNFS6HyAchtkjtEfb2t2SQV67DrhdRICsx5cuwQKr3pPOaf4jgP7LPadkNcQ+cyszk/u1uzqoR/jws6duwRb4H6h26V8qrOs6JY8jd7RNzFBk+S3j3md9K27oOlFChM7UaSUbws8gl1gpK1ngocN8+vhxW2Sl1rE7781Qp56q3B6RuZNtcdOESEhAAGXw/GYuIjAdDXUELN6/xZ/xTmw==
Received: from CH2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:610:60::40)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:51:30 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::73) by CH2PR14CA0030.outlook.office365.com
 (2603:10b6:610:60::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 15:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 15:51:29 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 24 Aug 2026 09:51:23 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] runqueue: fix bad check in process_possible_migrations
Date: Mon, 24 Aug 2026 11:51:16 -0400
Message-ID: <20260824155116.1209591-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: a8faa2f8-3dc4-4789-b403-08df01f79017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Al0tB/DgkOycrNguSP1A0lxFeFKoXPBHsAmG5yhPUPC+O8RY3uTm/Xd1QSRhQDXQebVd0/SJ1yjIddf9Tr3outQCzQK+8woMpOoyMJJRWTHKVD5hXIs+6BvOmRVTanMDtngKqxyh1CNu/l4vqm1F/Sg0DjYO8b5INrpom69181ZbukXw90hYbNB9P2Ux4BtbqGYAmXqgBfJL2zZ88+MnxkOHVWyWRtm0qQrbp5iUwYT49pNnH1M1lYTYd4SdJ3nnOAKYw3X7TuJJ+xjUQvUBYhkJkc4r3DrYy1lvr/dKuuSeKKweB+6cmJuk0YFUonb4YKXNVBnsgKeXNDqmHtwzZRhWtsTcAmAlrA/fL85QimKTPmxkdeOMfWMLzsD4Ga+U7qrQWTniXgQSS2x1+5PS3R63gdADNv4ntSjUOtNbZIwL82RORofveeQpe3G6AHkVZBk6X0CbaEmIeQCjsyCF6oEPUPMgRFqTlPxYdptPslLN/3GdEQ3gv0lqNgjyq2iXh59KbYdrHMbKil+idk3cIJ3oz1SzqHT7JxEf68RrypNGeosp4BVVxmsgnceaa/ULvsGuDQinnn4MvEc1ppRrHgDWK29w1nk71wRW/guYOoyOFKHbzKSHJQeat/zMI5dcrP83TW8J4i2V8yFg9JBQr65c0yhdE9SeC3pcqq+ysklp+faTG2CH2bpOyCZdRR/xIL8rE6dvCqM5Ve8+627QUw==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5EVau6t/6JtJYv/x4FQW9dIwy/ObX67UTiKb55oi7vcgpoNtaxgin0DOp4HVFeMIaAcj2rlEQixuUYCkDEQxzMRXPDAgcfFYOkKLZ+Aq5BU+t+JPJ7IiWsPTMptRJRHdjazgoa9ldIm1HAfAkoRppTkQ+/cka/47RL/iuSGNjyzbPqo7K3+Nc/peyhlykGY3d1P24IgYTIwaEV0LcHjugRux1/IxOgXkLUxrHtl2y3zzFv09xULr95ao3LIJEUVZoub6LhHhGsQj3X+VFQQMe0ZyMQMjN1+LPi6XfctZkKbeI1AM9IilLtZRO0Gsa6RvzwD6mVp2LQfKMjalhZqju3Zv1QQp9QUESnI+l/UowAj0fiWq3rNifmywmrut1i43GScsKKI26kPWcxxo14ocnC1zUs4gD21MAfENxCQ/CjVpEDWUEPJjXFlZYNXMu9uX
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:51:29.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8faa2f8-3dc4-4789-b403-08df01f79017
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 15:51:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20029

From: Chris Laplante <chris.laplante@agilent.com>

This was probably a copy-paste error from above. Detected by PyCharm's
code analysis (Local variable p might be referenced before assignment).

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a4689e134..ca0fd2945 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2610,7 +2610,7 @@ class RunQueueExecute:
             next =3D set()
             ready =3D {}
             for tid in current:
-                if self.rqdata.runtaskentries[p].depends and not self.rqda=
ta.runtaskentries[tid].depends.isdisjoint(total):
+                if self.rqdata.runtaskentries[tid].depends and not self.rq=
data.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 # get_taskhash for a given tid *must* be called before get=
_unihash* below
                 ready[tid] =3D bb.parse.siggen.get_taskhash(tid, self.rqda=
ta.runtaskentries[tid].depends, self.rqdata.dataCaches)
--=20
2.43.0


