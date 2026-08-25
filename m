Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2354C61DBD
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:46:56 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30473.1787687210782652885
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:46:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=qwPDzCVG;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.56.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWxNcpsJscy3aBmtuGkheKAl8NfPUSRkiZA06LVGDoYp4w8HPA1qJIo888DgpfU431NfRcZc+xvnucDFgE/tymRDk8u0/FlE6g/QxFhk3wj8W1jRfmPgV97ISl2uVsYkYyyhwEhWgTk0MxeokhOJ6elHrTZJppcd3yYlV/wmkUqCWHbwZbXPbIoH8XIsfS7Uu7Jr0CHHeAFFp/PGajwOsiwL7mg8/WT8uc5lYj3IwL2G4dZu4tvBBIcHYrv5fngOhvS9P+yDZG8DvsJv3wZizNk31Pn2JlSNelHqi8XL6Wgss1zL4cDKPPNO2A95vYjck7ZTbp3DlhT910OA/KzYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzFT6f1BwYJEGw52P0vqlgd6oELZ46KARJ4+7DpKiaw=;
 b=yCpqHwypRBjMhvNGKE+O60j1q4zJAkfNrEvJmZklEO07nW5UU9tMbFR2hvecUPO56laz7wr/GneF7mU1WQJiOhazLOnujNTfdHqN3Xpn2dnKniJ+5i9Lqrnk2zCvZ8fjbcm+QbbN2URBauMv+PN0/CsYSvEtZ0FFRm6z97SrOo6ehGDHVavZ26JsVzBDdh7UncK8Olae1yLB8wZG5SLsFTeufjBbn8vguad4rYpKVWmc7QeYk1PLCW2acAo3iquQG6O7EFlVwIBgNeihAQRhObj3fjzW8To7X+Egi0lsiORmJfBT8mYM/pKsGTJGIsBSF4eCfNCKugYSRiiSuY5Duw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzFT6f1BwYJEGw52P0vqlgd6oELZ46KARJ4+7DpKiaw=;
 b=qwPDzCVG05f3WK1ANo0F5fEyVRiWxDmI9B/KPnYL9d5kqk5M7f2f/ws2FTaDqzOxPq7JcitIQtczRN4464CTITnaoxdubt3GliXY6oAt/I4UybqIlgX7hPqZX8rN/nZ/3X3z1Dpd0WqM58pMopSqjBS4aX85l1fjPU1K8uigtX0G2um6dLjiQ9ZHlmOrFHO9ONUKe+O3fwi08G0eH2Qj6CAxg4+bzOgv1VTeIOZ/rrY/PJnfAu44/7W6+HEiAjPw4UtMih66XMNGVGpu61KKrhS/35aW6vIpO5gT5VYixObEDiz7QQ6L+O2HrcqB0OF1qYxVfKUbrBGKf2waSA+LFg==
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 19:46:30 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::5e) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 19:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 19:46:30 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 25 Aug 2026 13:45:58 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 4/6] build: localize import of bb.progress
Date: Tue, 25 Aug 2026 15:45:47 -0400
Message-ID: <20260825194549.152553-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825194549.152553-1-chris.laplante@agilent.com>
References: <20260825194549.152553-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d55545-2d44-4b5e-096d-08df02e18f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	dwHOPwNAC2nrg7ayuMX6sQf7jWX21l1WN6iKwy/axlnt7FVgKhZjWs27cFE5dWUROVclUo04TxYkA9P+lKkdlSb+h8XvfWXl+jkZZRZStr+HdpHcy7EPNi1j8GiojK/G3K+0zQbXACJfMckUB5pFjksPq43FCq+4R70Enrm0ezl6SmoB3yGbvINuE36ekM2ACHD+4Qnc47/LzHy49CUod/ZefTQq4YimU/Vo5UytISenNdXrYfAIpjb34TXhI4ikeTBNPtoXj+kMVeL8XbBsY8yH/lpnB69phkScy+9AkF9bqbdg84+1YKWd6vpMYLhVhS1/C/hGCsxcBDo45vg2wXzQm32l4oAP9KY88QNbR46DAH+/3b616gFp1QsSd6nDw7He9CLXhXoNfshSPKvrK6J0zxQAj1ojTBxcuFY4xMties2ixafkpB3L13fnd8br6TOvwgv/gBHJkA58NGB8N6iqtHqB1wdt7NbefdCi3fBOknWOdX6J+ALnVymbe8yHws7LuNpHx0C0422K8VoJYZOToj6GakyfRhqREiHrl4eU9EMLHBV5Z9qyvMgbTJz7EgYuM3X63UMKg4jfgVel2eVcsEdMV+fQXRKK0gdwhJ8Es3JF9zCEgYNiGzrY8N9ptU4YfLITF2jlbB1vYIpVc5N2YjNCgzW62sRMqoh9IHXgfnPu4LbEOOnz4c5S5LzKrTJqXlm9Qi0Jmn7s5eUVyQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	0OwLvO+SklLmL20xGLP9aPEkNI6QE6Mr6jtVzKZxqFCqK7Q8oW7VtsGOakxHjpPcPYcnntB3OhDoajrRNYtLIOyKxJ6oHXzDSoiijE1hxECe2KKci9HNKSrMUzYqloLlcconTppHEHq/IgcQA5tMXHw9uXiAYZcBekKMDYn/DN9pEG1nNB+ig705MjXgZnoIklQ/jDJSES/zeNcetDB0ZYqj71NDoAq8K0OC2rkRUpKqSsEhohyvd7ENMnVae1h3k38GjGiEDafS5MPgg7TlMIHMxdGhGkRlIcXK0AnIX0oT29ayJjjpLytDNmx0yb/5GNPaUqWx+CAwkUBSQJJ9S4mf5bqFmqzJpEWMJYxS5Nb3veGab67dmeC/RoK6oW59rdviBeDIEXUy2pWbY+rAojCqAyG71JjvmWuOXiAsbZfJ3TSoCZ3rY9rcRyPAxTdE
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:46:30.7317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d55545-2d44-4b5e-096d-08df02e18f81
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:46:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20048

From: Chris Laplante <chris.laplante@agilent.com>

It is only needed by create_progress_handler so just move it in there.
This resolves a circular import between bb.build and bb.progress (currently
being masked by the 'fetch' vs 'fetch2' shim in bb __init__.py) as well.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 40839a81b..8b49721d6 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -24,7 +24,6 @@ import datetime
 import bb
 import bb.msg
 import bb.process
-import bb.progress
 from io import StringIO
 from bb import data, event, utils
=20
@@ -387,6 +386,7 @@ esac
 '''
=20
 def create_progress_handler(func, progress, logfile, d):
+    import bb.progress
     if progress =3D=3D 'percent':
         # Use default regex
         return bb.progress.BasicProgressHandler(d, outfile=3Dlogfile)
--=20
2.43.0


