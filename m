Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.86])
 by mx.groups.io with SMTP id smtpd.web09.3149.1604873539629214629
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=2EypuMST;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.86, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeGPnLG916jUTOEI3cmzvkW/ZuMhWooFjPKCsi240L1haOMy0U9A/LU7FMzsz8elJuX96v77C1i+gwBcO5Yc6QjxAdbp/AmooxLYlLfvqf9DcO4uSrz8cA53l+ljhRmI9qu19e7FdlunYn+G5Gououoq5/Sl6HhllZlavaSs2NowW1vh76tiSkCowZXVT2BO4cBCQjiDPGFZOhWGqbzdp5cMwUkQ36iaW+W7i1qZY8nYV4mzW8/U3KlBKy79vmyEYXo2IjbzUDmLcack7RS7r2QPJcpvAvyHRuIcR7Icb0OKCX3hFHWm33Z1kTGuO9Gszu4AH+YmJGOSpY5bGU6YYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee6PThRVgjcI3TaOSZH4oKdwiNrmOPhcJPsyE/UrRko=;
 b=Jp4p/wuFo+mb6Np7o3ptRaJ4hCoKOlH7Y2lIy3yFBMxjGMcB+KppD5Cg6mPHiuJyQXNgYhfhPyJqeYQoldQkzyLN7lA9FpVsgBO7vJKbfOxrBN4TNLhS8bwf0FLmtaJl+AgFVpTjuyxn2Yl+7pwT/+duRefiEztzY9VAQ+VCIHzSUXg6JGix0OlNehhx2zHrAF5uBVFOaILk3yMbkjT8DHYKK92NvGWuv0sVghD7nvPuRvf7i3pMqB7BzbEtDz5rvTvUuMcRNsoBPx9x4AbCmNKtxqXr7UtgIUUOD6JPaFQQiRdaVv2cUEP4BGHDNmnRxNExUNmNAG62Q6OCVegVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee6PThRVgjcI3TaOSZH4oKdwiNrmOPhcJPsyE/UrRko=;
 b=2EypuMSTVjQJU7wOhs9xjUHW461lUtdMQmSShteNE2FDZ2N3Eomtvi/lEIx5nHEVlhryAQ4rJX2YBptepr3YZwBPVpniuq8xVfYKdQmJZqtTaxOfLryFGpPwpAY9P1GcJl/+ICXGsNYJFL9JnHtbldcU2fVwtXM9FpCEdyVy3vVP3/wGpxlALv+a8anbAXUgqmSYWDF7Gw72K0RNn0eWGlF/ippTJRjZtrHbEq3M6anm6OopikP/z6qg+uUkuuLpI1UnjkI242xYNRDWcSAYmGMUslcGL7nQYNv830RG5Xcb+im4DcjDBwyhf7yUiOGQQZDXRMREXSLdT4ei+/4p9A==
Received: from MWHPR12CA0049.namprd12.prod.outlook.com (2603:10b6:300:103::11)
 by DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Sun, 8 Nov
 2020 22:12:18 +0000
Received: from MW2NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::2d) by MWHPR12CA0049.outlook.office365.com
 (2603:10b6:300:103::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT049.mail.protection.outlook.com (10.13.181.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:18 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:16 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 03/10] tests/arg_parser: add test for 'bitbake -S none world'
Date: Sun, 8 Nov 2020 17:10:52 -0500
Message-ID: <20201108221059.16854-4-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c8042a6-3451-414e-b34f-08d884335b3f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM5PR12MB2533DF9530CBBB97881B51328BEB0@DM5PR12MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oImDohxoLLZsp+NlUzepkAhsUFZGaZuWdwLr8hhUsBMd9zZ4OzyC0EaHXB38RbYrr//We8bpyveDeJE/p3TFpag8QNoijnEWo3J7Thg1oXbEgVWaDP1c+1gROPPIwXDl+de6+tD4911w4guGZoZy7jIqi9ZGar+nlOF2B1zSFZlB059GGJJSiJJc2VBhl76dtT/QtRppfGJjjSkUwnikuUEcyxwENihC7WIAr/hJZE/jrUmXd8o4t5aC93FsNJ3pMztw8Ptll9dXwCC4sQUVGnNv02cwYu6McWuHGHgUJpt6Wca1Ov8Aq1dLehYomaAoaxVwv5jfvAmfsTmHQCr6ttI4dFIJz6pNszl8wAdBgwVaRkRtMrcHCixip1CMIHo/B+LurzbT1pI8QWLgb/b+qtrSz0ZsnmTnHQwnyE4uB6Y=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(29502001)(46966005)(44832011)(316002)(6916009)(2906002)(6666004)(36756003)(86362001)(107886003)(1076003)(5660300002)(26005)(70206006)(478600001)(8936002)(4326008)(7636003)(8676002)(82310400003)(426003)(82740400003)(83380400001)(36906005)(47076004)(2616005)(336012)(356005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:18.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8042a6-3451-414e-b34f-08d884335b3f
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT049.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2533
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/tests/arg_parser.py | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/arg_parser.py b/lib/bb/tests/arg_parser.py
index e6b55f69..fd46fe8c 100644
--- a/lib/bb/tests/arg_parser.py
+++ b/lib/bb/tests/arg_parser.py
@@ -7,11 +7,37 @@
 # SPDX-License-Identifier: MIT
 #
 
+import shlex
 import unittest
+import collections
 
-from bb.main import create_bitbake_parser
+
+from bb.main import create_bitbake_parser, BitBakeConfigParameters
+
+ParseResult = collections.namedtuple("ParseResult", ("options", "targets"))
 
 
 class ArgParserTests(unittest.TestCase):
     def setUp(self):
         self._parser = create_bitbake_parser()
+
+    def _parse_helper(self, arg_str):
+        self.assertIs(type(arg_str), str)
+        params = BitBakeConfigParameters(argv=shlex.split(arg_str))
+        return ParseResult(params.options, params.options.pkgs_to_build)
+
+    def test_parse_s_none_world(self):
+        # All of these should give the same result
+        arg_strs = [
+            "bitbake -S none world",
+            "bitbake world -S none",
+            "bitbake -Snone world",
+            # optparse doesn't handle =
+            # "bitbake -S=none world",
+            # "bitbake world -S=none"
+        ]
+
+        for arg_str in arg_strs:
+            res = self._parse_helper(arg_str)
+            self.assertListEqual(res.targets, ["world"])
+            self.assertListEqual(res.options.dump_signatures, ["none"])
-- 
2.17.1

