Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.47])
 by mx.groups.io with SMTP id smtpd.web11.818.1604686139684230910
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 10:08:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=oDMaOxtY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.47, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3Qg9VdWihc1FW1+M9okgZRUoA2HKjU7ZbaYR7/p+7CzJt1B7FeADYSv/Y0Kq87hgXKBDb6zUADfb/n5FILDBXLleDWRINbBwpgFmGwDVrBNEm8CqlaareRnvOdPifpxapLPwc8ZfQJ5A1MhKycup/DvbLVi81ig+BTsTIMW5klssxO0kNaOa7vjTy9K1AJLkj0MBjfKLVTwfaYBzKWUAW8GsulCzj2BkN3CHpooVox7ekT5/kxDQyxKADw9fgG8/RipnlTFAxQIjsqZauWd3ADu2setcTHY1pR2ms6FqqaB0lER8QYif4smPAUlrjf2/pUY0vYqMpxwIyqcxh47Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UtS7yLUcamG6q9/TFWq1RMv447na1Y0V79xO/Nn8iA=;
 b=QWefiQf9Jz5AnYFcyc8DQuR1Piehn5Bo4DfY1Yn8V9iKsZtjOp48GlgQTYqpocbvtBqRRZLwy2q1dg0ZoZ/d+hzCVTrD4oQAB/8FsPgDzbNZilRY5xgtKHQsv1wfjyiD/CuOv67JYKZsrM1NKPPUZG33Gwk2mQ5mo8XGOmjgFC+uTST6D8Ie4TPqYxwajdZsTxavT0DaayK3AqAK9bw/CusO2T/G5VYbqAcj74PeMnkWdq1gc7mxrxzgHduTwnkoiAmtEgEgl3TjBhoNqFKm0fC0frJ3J4pCgZR4ctI5Ne2iQNpvQzXToEeHpYzMatSs+CH/Agc/67oSJU5EfpA/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UtS7yLUcamG6q9/TFWq1RMv447na1Y0V79xO/Nn8iA=;
 b=oDMaOxtYSVcQjWni9PrYaDSFBwE85RQaqqKQy6R5MkD57I8hvbltcmmgqjFOA5+LR+1TWIhZSLFNDVDJGedevc5t6qEh38Ov9bRk8Ms+rDUWkAZ4e5/kGbM5da6a2SNeF1EbfU/ufBNMJTz2MvlNBvTTnJB+7ruN4Dt1/f2HGPubOrkAHUz0TdUdknDrJKeh/rbCjJNhxXKh94OCYKKYe21qeMrkqCzvAEsdGiiMTad8ApwUIMiG4NYNp+VvJceANm6tiD3E/vmH+yfdxiFb6NAJtkod1LvjHqdCZboYuYgEeU4KYgfn2wswmcJeYvXl6Q/DHoNYL3VKtxouXY4w2g==
Received: from DM5PR21CA0038.namprd21.prod.outlook.com (2603:10b6:3:ed::24) by
 BYAPR12MB3239.namprd12.prod.outlook.com (2603:10b6:a03:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 18:08:58 +0000
Received: from DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::bf) by DM5PR21CA0038.outlook.office365.com
 (2603:10b6:3:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend
 Transport; Fri, 6 Nov 2020 18:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT053.mail.protection.outlook.com (10.13.179.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 18:08:58 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 11:08:51 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] main: rename list_extension_modules => load_extension_modules to clarify its function
Date: Fri, 6 Nov 2020 13:08:48 -0500
Message-ID: <20201106180848.87402-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28567960-66f6-4c66-391a-08d8827f0842
X-MS-TrafficTypeDiagnostic: BYAPR12MB3239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB323926AE1E5EC20541830B008BED0@BYAPR12MB3239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Kxszdgae9XzGjB6BmIwTEjlDbc9NJR4tMc/StuutJYSILorVhjSVgVRrKRTX5ZIgeXk27LrS4bUuid/ej6/+YXdEsozWim3786MLFT5Vll4VGSSJ4YBtkN8+QKQtyKpQkX+YtTqUV4Bkai5mlDm/pDK8oLneS1VmfD9TNYfJ6v01W5FYRJUV11tY158gnmlX96vENbUukDIKuiXpOFFAfx9kdGjA+euEiJLGlkYMgcXSf/MKrccSYTzShGX1pH2Yr9Xg11OIVA/ZDgzgKfUFIcJjn6v2L9dG8poez/2qkVsuORt35sPoyXx/iXEwTxtsJqCDEKtFXar62jV1tFjHUdBOpOl9QLs/eeG5EPdJjRt7OOyKkYJfBYsW3/mw2HQFI+15N+v/xL1cM+bjeIvl2NJdEV9GoAOQl/VU3eDfbFo=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(29502001)(46966005)(478600001)(336012)(186003)(5660300002)(6916009)(6666004)(82310400003)(26005)(82740400003)(47076004)(7636003)(36756003)(36906005)(107886003)(83380400001)(1076003)(2906002)(86362001)(8936002)(4326008)(2616005)(8676002)(316002)(70206006)(44832011)(356005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 18:08:58.2940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28567960-66f6-4c66-391a-08d8827f0842
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
Content-Type: text/plain

Also clearly document in docstring that it is the modules themselves
that are returned.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index c53da851..2fb81a23 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -40,9 +40,9 @@ class BBMainFatal(bb.BBHandledException):
     pass
 
 
-def list_extension_modules(pkg, checkattr):
+def load_extension_modules(pkg, checkattr):
     """
-    Lists extension modules in a specific Python package
+    Loads extension modules in a specific Python namespace package.
     (e.g. UIs, servers). NOTE: Calling this function will import all of the
     submodules of the specified module in order to check for the specified
     attribute; this can have unusual side-effects. As a result, this should
@@ -51,6 +51,7 @@ def list_extension_modules(pkg, checkattr):
         pkg: previously imported Python package to list
         checkattr: attribute to look for in module to determine if it's valid
             as the type of extension you are looking for
+    Returns: list of modules (imported via importlib)
     """
     import pkgutil
     import importlib
@@ -101,7 +102,7 @@ class LazyUiChoices:
 
     def _lazy_load_modules(self):
         if not self._modules:
-            self._modules = {module.__name__.split(".")[-1]: module for module in list_extension_modules(bb.ui, "main")}
+            self._modules = {module.__name__.split(".")[-1]: module for module in load_extension_modules(bb.ui, "main")}
 
     def __iter__(self):
         self._lazy_load_modules()
-- 
2.17.1

