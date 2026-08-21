Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E3C5DF8C
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 20:49:37 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98.1787345375953928328
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 13:49:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=qKA9dVzu;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.196.7, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGCxbBkUvu0w53WlzCDImjgn9maxvkQL9Yu+sJ8mP72Trge8JWyo6fK4aWjV8l9ohloUvosoDp192A11EBT7N6izqW/aXQxDD7CEs/fodHDBldDrKf1hJKibpv6T7ObOens7ZmsunfutnT5o0ZVaFDEXuSAP7tUCF3fWyeoJsVit6LJgcjMToFE8cxTAXvFEUKower3xaurzSrRgvFJS/A/ML6zBHxIJOdRg2+RlUGtUC2Ysdcy7Fu7GXLKDAFm9/H4R5zzbgxXHh9CN69wE7PTXnoucWJKsrVMsgebbLX2LnHeFVUjOItR5TC4de7jfYbOUYMVS8Jy7JDdfy3Dpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUbldKkI+B0XRYrC3eUAVMwn9q9vctFimuCToJNS0Yg=;
 b=LRPsrxawj37gFFaZrULxhmRIaINmEuaNtageAngmhZKPUe9r8C3V+JpDGB8ccJXgI7H6pSlZqQbiX5Myoi3yZfMplvrPO83lzhOeSi5JG3IAwsS8FEn3Bhv/Kefu+0rcIYX+fMOI/wbSNnB5WPfzc1AAhqcNg9oZKX7G1kZwnc6IhmfRTGuv2YXE759+nd2jriyzGWCKIz/JFxdhi4YyyeQB1PmX/UN8gTtemrJfHJh06qLI0eVr6FS/d6EiblijXgWj5+XQJUQGPQVmGbIj/vQ1r+dJgKrqmc5R65ps/qzLyxJ+EleZ9D/UOFeo7r4mIR+goJRvsLmlAa68lU1eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.35) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUbldKkI+B0XRYrC3eUAVMwn9q9vctFimuCToJNS0Yg=;
 b=qKA9dVzugrRvSaB7kTfnpTRRg6WtqtCddVxHEgh13CilQfPXEbci13j0TOIfv8c6qkNhlYFxaQuhlGG+CpOeLFOlSDt9+7QVbLuKPKc9pRfAOc8K8etf6Dontiqy2ZmI73TWUTjShD4z3WdxtHejm7wo+Wm3PG8loIiMwRpZV2hLa8rUvadgV14JnVs8xwOGKmY1rkHftwVunRusYwRPZF+eGveHeX1szrEhnwUYujEl6kJp+aXwIzURBKvvs7c8oxJWMxg7Ownayx1dz5/f/4rhJzKT7L1AKHZlRsexZVG/xIILA/Hs//uMpETQ2x+rq1whWf1iQuWAnBBzDYq/xQ==
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 20:49:27 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::4d) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 20:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.35)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.35; helo=wpcosapexchedg4.windmz.agilent.com; pr=C
Received: from wpcosapexchedg4.windmz.agilent.com (192.25.218.35) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 20:49:25 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 21 Aug 2026 14:49:17 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] runqueue: Fix pending_hash_index not including taskname
Date: Fri, 21 Aug 2026 16:49:01 -0400
Message-ID: <20260821204901.48802-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: a22e4f88-839b-46c7-f0a3-08deffc5b010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	zt6CTsBEpQH85gNfA4GA1Vb9AbCdAMRFYcXvZmCrG/1FdsIoWSHRW4yVWVp0bnFKsfsYTGfLjSOhEJBx+plq5j4bmIx++bpto7GF4/9J8eMmc1NT0Hs3f4uxzkAhEQfg0iJa5Lj3WvUF2TRh3kGmiGJHPoB97uNNCx1gM+HMmVQEMrMgKxe853R/UPD44moXopyuoMUAy1rupn9dIm0kNsJ8N/FKpyxfHY4InQ48v/dsc2qgtydOzkcMdz5HUl6DQCBo8sKNBSD/bL5XEPaHrM1W20B87l1EcAy3tZU3MDi0Z2jirbf3ShXkQ0OB6euqf3TIvxpX07GzRFF1LeFrEy4LGIKdnGUIt+1tMhRVj/ltZ2cOlQe6Y7MCJO1QUGkLgq8hPEPI/gPA8GGX6HBqWI897TAsBhcf6U5rV+5WbbOgRGm2Nma5B+XjMmUz09ZuVLwQv29rOL+IGsm5INQO7t8GmDk6P0o6W/tlYlhxl3cwmxSCr1CPNvAiiIQp20Q51fMRtCr9c7kxFlDgTAXyQcUAvs0bc/3oK+NhYNYhuZu1bpjIi3siYH9CIUpdxnOmHL31tSWpeoW+o3U7NB3rHiyjh5eA33zYZjJ/pybsg0M8UrQ6uvTux+Ujwzm8d7N0NCuIS2tHtP/iBaOCBGtTRCNliWX5XuIco4JU2rR4oJZ/zrElyzhcT2Vvuc/qONXff4qiWUWQvKQRRrkT8hgi0Q==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg4.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	KoK1tG9C++mP59MOGVROV6RCFscJNdf6v6kXRMjQ4UnKZfr0eUwg+W8LUY2PpNkhfWMT5E1KN/NsAWYUZY/v/r3UX2m93pQVRxiiZv9vt3feWpFLL7/riD49XxX14lSE63Cflk+BmM+6JcAY+fUDgrAX+zvrSMOziScB6lZ/46mqdIw/z5Ki6re49wgO2hpsod+XIFyIIiZKLcgUr0MCioP/8ZPSlZ0qN3i6VhcXyhzvPefwyeCO93QLbBHZicmdLjFbKCvfNtxn6ycDbthrHOsG6yk1wJZPTe26lXmrptZibY1qHdW8mtlCxpjUzvKuROo6nAUMtw/RoaFdyupd3zqShg55QRh9I/yd8WVMfUm5vyG0EengW6B/IBjQzVUulOB6+TRvRmbt+acao2BogVFomy3uv90AIyhUWA+M5RAT3a0lauMspkLG4/hnxz1p
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:49:25.9315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22e4f88-839b-46c7-f0a3-08deffc5b010
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.35];Helo=[wpcosapexchedg4.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 20:49:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20014

From: Chris Laplante <chris.laplante@agilent.com>

The intention was probably not to use the literal string, "taskname"

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a4689e134..544081053 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -84,7 +84,7 @@ def pending_hash_index(tid, rqdata):
     (mc, fn, taskname, taskfn) =3D split_tid_mcfn(tid)
     pn =3D rqdata.dataCaches[mc].pkg_fn[taskfn]
     h =3D rqdata.runtaskentries[tid].unihash
-    return pn + ":" + "taskname" + h
+    return pn + ":" + taskname + h
=20
 class RunQueueStats:
     """
--=20
2.43.0


