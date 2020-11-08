Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.59])
 by mx.groups.io with SMTP id smtpd.web08.3132.1604873547022075617
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=EGvTMPBH;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.100.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZICkNRPoxC79Q+r6QgRshCRI2ZQHEYpd12Am/FtaWrhtpdCQUh3SbH+odwwtOuOyen0gw62NApcw38uL+S+owHsccZiaxub4MTt/mQRhwiY8rFC8j80fGExVEPQWr5FkB9LtOqhlu86r1Fb5FWolEy6IiROOMA6gPKztHgQ1hUQXJc1173QtmtOyr2Qi6+suOBAygEte9PkYikFtj9BdnWhtHZWf4ako6+nyRrL7a7OBfklfIZb4TDgxb0v3vFKWW1ag4W+GP0LQ8HHeZGUEsz8VygWRSGeHHyZ2dHtfhJuMBKJYvq1NpDByMv6Q+CmFbLUV8jwxbPKJOwVxiDliUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar9jAse4H2WSTyc+l8OHzrxOWvlwn1Bbbh4/ee/l+rE=;
 b=nsqhbfVKU2izbmlCnJ9G75AUENSCiLKr48NFtBR8Zd/kJCEeCQxoxwynuJ1bILbfLZIU6kJx7vtGvLIwK2dk7jld+guUcFOx23CReXx+/97zhK4mlfKOgsGt/UcQ6pCeuzaDz1TKoE64jDT0Mvel85IgS2ah6e8rvC7ehQFKy8JyB5fG2oNi4IEc0tapcaBHAbhrmExmvs7VIgjvAej/GgygJfac6JVvzSXzOGFBlW9db1yd8FEcW4uT8w9Ziebja3gB3MsaozPuwFcF1UFnIk1bPCwmKpXmUDx/P/3QeM5eiO9XNNfhQgDd2ofIDVcs2zxCXSfFglpE4X7nbmZEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar9jAse4H2WSTyc+l8OHzrxOWvlwn1Bbbh4/ee/l+rE=;
 b=EGvTMPBHS9tmP4KlthsbEqWlGgNCgfSZKgna59YYEBY6/XuE3yXAiuXyjLD4mRLV7YDM5NMIba0+TTeUpc7I9o9rX4MuycuaTf+Y0MzZS9MfjWdMg5Lc+DEWLzQkWqufK7PDSrpJpEayG0t7q4/S09vR7VPWryCvXoBurbsU6jmzB0L/Ct3rQKKOQYgXFyeO3kMR2Lw1Oo9KsNDtUnn1jkj8sIgwHRX79bOUN3lKl4+U7RjajcQZ3J1lx/qSyTN8cHaJXgVwFrQ/VNdF8lL0+Asf4osegbqNMrK81X+BONqQm5gt+ohMKOfHz0OjFF7mr1n3nanLpP1Bxm+4aKXBVw==
Received: from MWHPR13CA0005.namprd13.prod.outlook.com (2603:10b6:300:16::15)
 by CH2PR12MB3734.namprd12.prod.outlook.com (2603:10b6:610:2a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Sun, 8 Nov
 2020 22:12:24 +0000
Received: from MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::92) by MWHPR13CA0005.outlook.office365.com
 (2603:10b6:300:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT046.mail.protection.outlook.com (10.13.181.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:23 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:18 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 07/10] tests/arg_parser: add test for lazy loading of bb.ui modules
Date: Sun, 8 Nov 2020 17:10:56 -0500
Message-ID: <20201108221059.16854-8-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201108221059.16854-1-chris.laplante@agilent.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d51764c4-a919-4f22-5de6-08d884335e88
X-MS-TrafficTypeDiagnostic: CH2PR12MB3734:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CH2PR12MB37345BECEB88CCA8AA3A1F0E8BEB0@CH2PR12MB3734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c5ilCkmDxxyO1mFpGotpBuGWKFg2B/1FBReEhRGkN7ZGrMyr1CAJhROnJCKA5Q9oogCXWqmYnWCwLP7wlvdMwHygGUDe4Cvlp5Nn+5B7CPX/myiEm9/mTFOs7xSSA/9QrRH0x7hTDUWaZbWE6jh1iFfVaNFhmSSdyYxly5RbEvZlnyL/jSbRxbRjzizfQ0duLniBJ4/szuwavWTUwNSXwgwAuEw+ZxgtNE13Eg187Wh5XHgK+7Gk33NeuNQhJVG6NRy2fgtVVEfRWKMYFTwuPkkq+hKgH2njFPkd7N4RGn/3avkjmh4a64vuG1GY9wkFoM5oc+rA1OCzhhucdIDGRO1WVREw+vgnTOAJb/ymgGLs5hqzd/7xpq7sezkmBC9gVR2JuvJxnJgzHJQYzNGW/z9OJIuz/5xBYZCaM2PIegE=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(29502001)(46966005)(5660300002)(47076004)(186003)(36906005)(6916009)(70206006)(1076003)(26005)(336012)(478600001)(82310400003)(82740400003)(316002)(2616005)(2906002)(6666004)(426003)(7636003)(86362001)(83380400001)(356005)(8676002)(4326008)(8936002)(44832011)(36756003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:23.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51764c4-a919-4f22-5de6-08d884335e88
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3734
Content-Type: text/plain

Ensures bb.ui modules are loaded lazily during construction
of the 'bitbake' argument parser.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py             |  5 ++++-
 lib/bb/tests/arg_parser.py | 18 +++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index ccb844bb..f8a19bc3 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -98,12 +98,15 @@ class LazyUiChoices:
     """
     def __init__(self):
         # map module name => imported module
-        self._modules = {}
+        self._modules = None
 
     def _lazy_load_modules(self):
         if not self._modules:
             self._modules = {module.__name__.split(".")[-1]: module for module in load_extension_modules(bb.ui, "main")}
 
+    @property
+    def has_loaded_modules(self): return self._modules is not None
+
     def __iter__(self):
         self._lazy_load_modules()
         yield from self._modules.keys()
diff --git a/lib/bb/tests/arg_parser.py b/lib/bb/tests/arg_parser.py
index fd46fe8c..be2d86fa 100644
--- a/lib/bb/tests/arg_parser.py
+++ b/lib/bb/tests/arg_parser.py
@@ -7,12 +7,11 @@
 # SPDX-License-Identifier: MIT
 #
 
+import collections
 import shlex
 import unittest
-import collections
-
 
-from bb.main import create_bitbake_parser, BitBakeConfigParameters
+from bb.main import create_bitbake_parser, BitBakeConfigParameters, LazyUiChoices
 
 ParseResult = collections.namedtuple("ParseResult", ("options", "targets"))
 
@@ -41,3 +40,16 @@ class ArgParserTests(unittest.TestCase):
             res = self._parse_helper(arg_str)
             self.assertListEqual(res.targets, ["world"])
             self.assertListEqual(res.options.dump_signatures, ["none"])
+
+    def test_lazy_module_loading(self):
+        # This test ensures that the bb.ui modules weren't loaded immediately upon creation of the arg parser
+
+        # Find the UI action
+        ui_actions = [action for action in self._parser._actions if action.dest == "ui"]
+        if len(ui_actions) > 1:
+            self.fail("Found more than one 'ui' action in the argument parser?")
+        self.assertEqual(len(ui_actions), 1, "Didn't find the 'ui' action in the argument parser?")
+
+        ui_action = ui_actions[0]
+        self.assertIs(type(ui_action.type), LazyUiChoices, "'ui' action has wrong type")
+        self.assertFalse(ui_action.type.has_loaded_modules, "Creation of the arg parser loaded the bb.ui modules")
-- 
2.17.1

