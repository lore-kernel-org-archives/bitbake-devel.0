Return-Path: <chris.laplante@agilent.com>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
	(mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	by mail.openembedded.org (Postfix) with ESMTP id D62EB7FBCD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 19:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=muE4sbFVXSQVqVzqeAwo99ddiojvOb6Wh0NNkeYwHLMQvjXkUguXVgpUH1dLbRQbXdkcUQzFKSL6M6dF7zyY9+evEscVLE4Fke5YpGxJBltdyrj06SG418yuZ9muThIVy2wQdbDCvjQvN3LCkQf/qemmDfFPBp9fFxqjWkecdtzOGcLzpk8S2b7qoFKlbC8U5qRByUvNSG4xyXLCgQcKS/aY9maEo5Hr+6C53K1ybDbs+2BKTZufxWwdt7wz1UsBCPuMEmrKUPoZZpWtovYFemqUnJN9RSjRlXkiMivYtEacKqlj1/xoHWrMCikOh+uIvCPlsajI9IyuUXWwGwas9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=eHMLStukZ6wdPldgUb4gVsyetKG/KevwpmFDqzA3ny4=;
	b=l2jvlEZkyD+dfh9Mcl/vy7SVd3LC4V6IXuCe/LittkKVrSkZPfGELQ3offCoJymuixBBjc+O1ukFOWX42BxLU2HERqg3ifhaxMAl0AfEImnrAnL/Gc7haazcdhxgCLeh84GBWRKOIO5hDorG7dHN6TQM2GNbhAU15fImgSclRsHfJsgCLDadFihwhAvtu+RXWA1sl6ku7JYYPlZDUWqaocK4m5nG2Bq/C/k31cT9l58FFvf+izG3OdmsZwp4w6abN8PXeSmvbnCbtB5j6VdIchkv0MUonKrRe93CXoNZh8arSPkVYQaJqYsi9tWoH/UDmPzFDAHuuz4Czj6pMSoBBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=eHMLStukZ6wdPldgUb4gVsyetKG/KevwpmFDqzA3ny4=;
	b=LFUSoKVzlgc0fc7Rden2WVVfOJo64EgSdPB6aHFauwT1iMWxN4fqQVeGWmTxBeNhvarlpG+Utq+mQogD7K/zoYgXzwH1knWGHHtmE56g8kXaRg1WMCNTnS2b5WKFOjjc1ByFhSoDoi5k+0pMUJWq1PtCOg/rtPuaTVgtOhDQD4Y=
Received: from SN1PR12CA0084.namprd12.prod.outlook.com (2603:10b6:802:21::19)
	by BN6PR1201MB0227.namprd12.prod.outlook.com (2603:10b6:405:4e::7)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.21;
	Fri, 17 Jan 2020 19:40:14 +0000
Received: from BN8NAM12FT027.eop-nam12.prod.protection.outlook.com
	(2a01:111:f400:fe5b::202) by SN1PR12CA0084.outlook.office365.com
	(2603:10b6:802:21::19) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via
	Frontend Transport; Fri, 17 Jan 2020 19:40:13 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	BN8NAM12FT027.mail.protection.outlook.com (10.13.182.138) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2665.6 via Frontend Transport; Fri, 17 Jan 2020 19:40:13 +0000
Received: from lm18-laplante-laptop.localdomain (192.25.126.27) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 17 Jan 2020 12:40:05 -0700
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 17 Jan 2020 14:39:54 -0500
Message-ID: <1579289995-70510-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(29502001)(189003)(199004)(8676002)(7636002)(86362001)(246002)(186003)(26005)(44832011)(2616005)(336012)(316002)(956004)(426003)(36756003)(107886003)(478600001)(8936002)(6666004)(4326008)(70206006)(356004)(36906005)(6916009)(2906002)(5660300002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0227;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32c5b918-87f8-4eb8-a785-08d79b85121d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0227:
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02274AF420BE10ACAB23D2118B310@BN6PR1201MB0227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0285201563
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Luh/gk2qp5FLHIWxLTr57WsO2NRYn5HtatrShiOHmZSEkI/B9r046P+OhU6HgBNEoqVAUnBqycXDJkeLWluyks8iO77cEx9UfvklDWKZey+2bbW5rDj1GUJ6i7de/1xdHqV8cKM6WoCzWXdOz+B/TJ3dYDtCvuZrS74w6dT5KaMWJQVZ0EMfiJKCu7ZOqmUQxsNMxxQhik9YqILDTTngNgmRcfDBd5ANza4hw1jgQ+Kj4W1wtz+YodbWi/ngv0ta7BEqO2GwtF7rvODxUHFrNId1ZWiUlf9NV9xl3WCK4ZDjE35Y9DBDzXiOBt8ax5b/nYbU9JfmqES/vClUz5Tbsvm6uPPjx0vPSiwhamBNEKtpKhhFVL+NR+FtWzpReAjX3rwxe/u1Lgio3umyxY9Ru+srcPxrn8LtzkXmRr8/mktyhfoX8OZAdaNooJMLQJqP7Dp5Q7VfjlQ0fzKyA5lnSWHFV83o2pk5xRgI6Zs5x5RMY6ByxkYWxcVc8x+frSoH
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 19:40:13.1554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c5b918-87f8-4eb8-a785-08d79b85121d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0227
Subject: [PATCH 1/2] bb.utils: add get_referenced_vars
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
X-List-Received-Date: Fri, 17 Jan 2020 19:40:16 -0000
Content-Type: text/plain

Given a start expression, bb.utils.get_referenced_vars returns the
referenced variable names in a quasi-BFS order (variables within the
same level are ordered aribitrarily).

For example, given an empty data store:

    bb.utils.get_referenced_vars("${A} ${B} ${d.getVar('C')}", d)

returns either ["A", "B", "C"], ["A", "C", "B"], or another
permutation.

If we then set A = "${F} ${G}", then the same call will return a
permutation of [A, B, C] concatenated with a permutation of [F, G].

This method is like a version of d.expandWithRefs().references that
gives some insight into the depth of variable references.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/utils.py | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d65265c..a2fd1fd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1026,6 +1026,43 @@ def filter(variable, checkvalues, d):
         checkvalues = set(checkvalues)
     return ' '.join(sorted(checkvalues & val))
 
+
+def get_referenced_vars(start_expr, d):
+    """
+    :return: names of vars referenced in start_expr (recursively), in quasi-BFS order (variables within the same level
+    are ordered arbitrarily)
+    """
+
+    seen = set()
+    ret = []
+
+    # The first entry in the queue is the unexpanded start expression
+    queue = collections.deque([start_expr])
+    # Subsequent entries will be variable names, so we need to track whether or not entry requires getVar
+    is_first = True
+
+    empty_data = bb.data.init()
+    while queue:
+        entry = queue.popleft()
+        if is_first:
+            # Entry is the start expression - no expansion needed
+            is_first = False
+            expression = entry
+        else:
+            # This is a variable name - need to get the value
+            expression = d.getVar(entry, False)
+            ret.append(entry)
+
+        # expandWithRefs is how we actually get the referenced variables in the expression. We call it using an empty
+        # data store because we only want the variables directly used in the expression. It returns a set, which is what
+        # dooms us to only ever be "quasi-BFS" rather than full BFS.
+        new_vars = empty_data.expandWithRefs(expression, None).references - set(seen)
+
+        queue.extend(new_vars)
+        seen.update(new_vars)
+    return ret
+
+
 def cpu_count():
     return multiprocessing.cpu_count()
 
-- 
2.7.4


