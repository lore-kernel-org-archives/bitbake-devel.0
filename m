Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680089.outbound.protection.outlook.com [40.107.68.89])
	by mail.openembedded.org (Postfix) with ESMTP id 110717FA42
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2019 19:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=nmw+aoCsMfOeC3IIwZY/XImloFIKqygEKkcmTA29ky/+78wDAR7y26/c4hc7Pmty+MHczOZdFlx59+98Ka+bk3nWqzAn5KLeR6LqQzVI07vLbEzpp8ZWSs44Y9tmtwRB3RDMMUNDRrJO0UfAzczegwx8BR9jI2D7PJV96UCD7hTG2p9l1il2nkvwlw5Nkt/2GYNW2kZkI4cpbxziZ38VOiopxeoMybPLD4QARmzd4bMPoKsNHAyzsFk12RgSNdxMyL8OaLF3OpXmkDJEL0ZoZuOiPvTjjqLfeGmZeTiUeAvIem+FLqrgt4NIMrNXQ7DfZZZHotIUX6vHlW1bOWFgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WDzNePPQd4mq9XVLkzlWV9fIW7EMGg9weU/b3VynYTY=;
	b=OBKcu2uwo3ZchPr/A9QN9hfWd/pyxAvF+pOz/zcCCaMohEv+L2Na5zOZrpfkNL9vVx/hPDu8Uh3USXp43/QQgM0uIKWWgLupfitUVX6SBktQTprFUjhZFvuUaaSwzDwIwPvp534muvLBhZeXHx55lpeLEbY15t3qbV1I5Rx4vB9g/RnW6s5Jk+61nLbCXDU9Ct7+Bj7V8z8PNtBDf8p5WdCOzuhpz36JMHHUZuOpIxWxbxWyLwoWxjiY01dSo+LlV0rsXHpfyPD4Zja7z7QRNd65hFM8nbgK8Y61pHQXT/3yvE8CuM8JeeX4muxt46Q+vnrqK6Yl1N+8TuaBNIIdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WDzNePPQd4mq9XVLkzlWV9fIW7EMGg9weU/b3VynYTY=;
	b=QvtKbBgvbx7KrClO/zh6S/SUmdaei+ifU/gdtbUvQZFDhyHxB9CfsB1OSKoO6BeFgHrudqrDBim8kOm0LoFUbvsLcBo4+w5O6kT1hWJ8VK67KhmcWc33C5YW5WLdq/5XuyOf9nvsQbz7/Af0hk2fMu6zElrxeL1W55S7QROdack=
Received: from MWHPR12CA0068.namprd12.prod.outlook.com (2603:10b6:300:103::30)
	by BN6PR1201MB0100.namprd12.prod.outlook.com (2603:10b6:405:59::9)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14;
	Mon, 9 Dec 2019 19:20:45 +0000
Received: from BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe5b::206) by MWHPR12CA0068.outlook.office365.com
	(2603:10b6:300:103::30) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via
	Frontend Transport; Mon, 9 Dec 2019 19:20:45 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	BN8NAM12FT004.mail.protection.outlook.com (10.13.183.58) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2495.18 via Frontend Transport; Mon, 9 Dec 2019 19:20:45 +0000
Received: from localhost.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Mon, 9 Dec 2019 12:20:32 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 9 Dec 2019 14:19:52 -0500
Message-ID: <1575919192-7887-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(29502001)(956004)(2906002)(246002)(8676002)(8936002)(2616005)(44832011)(478600001)(107886003)(26005)(36756003)(70206006)(4326008)(86362001)(6916009)(5660300002)(7636002)(316002)(426003)(4744005)(186003)(356004)(6666004)(336012)(36906005)(305945005);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0100;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e933f9b-4391-45e1-0a74-08d77cdce3c9
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0100B7EEC10AF7EF3BAFB0BF8B580@BN6PR1201MB0100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 02462830BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxCRJ+lYmTiuIn7bwrKrAoovfIJenaGA/oPBgxxlz95igMBV0ncN4h+TLbiwAuLEYF+2HjwWjFL7JMtjLUuLSiDdkLFuEEj9l3CobGwKoJd+7fmWCGfzCRyi6VDEP5T+9qjAiRMXVVCqPe/pMdJvKV4LZU4lONdnHyFVGeZIrS/xF340Bb9KgcwrgC9anRI7zWHrlTLYFPPUX/+9nmg6dLYqBHtGMmaPv+2LSVlA1QgnBQKJDj1+4Pa1Y75cizmNuPha5lok+LIO6SFBo0JXkRn5AO3hgV/gm2El6rlqkbhbCl/NxnxLaQiqhT5raKcswn8Ept88sundFq/TeY4z7f35F9rB2SGKyYqWne4oN2rVD6NuyIGvRtexPKUtP8hxvnNaf+IkouHAUNBeegUXGhkGH1J+hFRNoimeg5ChsfJrdRewe5Pk1ZaEK92/yeCX0cajkBZxH5i6xqAcodSaqobRhDl/xZOHRCXqZZ/gSZJKCStc7bWBeIoxOISFlzDC
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 19:20:45.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e933f9b-4391-45e1-0a74-08d77cdce3c9
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0100
Subject: [PATCH] bb.utils.fileslocked: don't leak files if yield throws
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 09 Dec 2019 19:20:48 -0000
Content-Type: text/plain

Discovered with a recipe under devtool. The ${S}/singletask.lock file (added by
externalsrc.bbclass) was leaked, giving a warning like:

  WARNING: <PN>+git999-r0 do_populate_lic: /home/laplante/yocto/sources/poky/bitbake/lib/bb/build.py:582: ResourceWarning: unclosed file <_io.TextIOWrapper name='/home/laplante/yocto/build/workspace/sources/<PN>/singletask.lock' mode='a+' encoding='UTF-8'>
    exec_func(task, localdata)
---
 lib/bb/utils.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 8d40bcd..d65265c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -428,10 +428,11 @@ def fileslocked(files):
         for lockfile in files:
             locks.append(bb.utils.lockfile(lockfile))
 
-    yield
-
-    for lock in locks:
-        bb.utils.unlockfile(lock)
+    try:
+        yield
+    finally:
+        for lock in locks:
+            bb.utils.unlockfile(lock)
 
 @contextmanager
 def timeout(seconds):
-- 
2.7.4


