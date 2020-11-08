Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.53])
 by mx.groups.io with SMTP id smtpd.web12.3230.1604873548077024011
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=uUqW8xUS;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.53, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq9YyzwtM+MHu0miMvgtDU8ulJjt9IGzQiheKweQkqd4EhZpKOCX4MKQsh8WLGGmYuWGGYVhEwrjQ+gRK0oEJ25w5Ufx5Bi9nANVq+v4BTsuuxadduSYI9w9yvChU/6RmwME7AIGGsAAs/iwqCbXn5fUsPKgTiXd1+cBc+wbxu9jFrKXjSUanzWY0ln7a7sqNqnKvAttZ8rqTqLCg6k/Zc6B7sltLePLk8Ko3rJu90pqs8NRMeSCgUwGXtwGoOHNaMPuN9DL2BgycDi10Bq2rL0p+0c3KQFQGh2Li+3tv0w+uQUYvpqSbqsD2ODzz7fkF1gx0rhMd5zufbtVGGPAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK/fdHHB3RJxQBXEHHfmL+ZT3DywGXV6M/w2rVLKd3E=;
 b=mPDWtGP5jqMGJcMOZ95d38z3nS/WuIyhdY6r7rV3WfB0xczh4whK+t0xdk2tdlPceyoT6ifjYIif7m1R8XAVBsBqgIl0POWl1i8qQU0YqXdX37CVd/cMNHqpRcuEbmMBSpcqwHJS/l0cmgq8Gcagn3OEUoM7Gn5IM1EuBlq0GZb8DsWnPKgbn//LAY9iwaXpAfrx15uhshXGvRtGGDoMGfP3J3kb4diQlqmXjfmkE1CImYvVJ6ad4rbJBiUDBp4tpFNiW+kkjCLraMnPBaaVM/QB6W3H8VCcPaqKk/m1tc1U+laIIlhy9Z1BRODnhrjFGXBIv79A4OQUew1DF3Wciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK/fdHHB3RJxQBXEHHfmL+ZT3DywGXV6M/w2rVLKd3E=;
 b=uUqW8xUSOrOglnHbTzGQoEVu/iInjyWjzvrz21Vt6SZloVkJWhGX8AlkK1RDQ2wl7RdGCVY+vToDFd32rsPQh5YOSF6/pe+M4EWL0LzZgxs0ytcXD1gmfELyn4kSwBqwT6v9hm5CEoBIwHf7EvAX4kAsqdF0AoUKJ3nFlzaJFYzHnRVmduj5ZUSD7TtZmztpLSoJcDD2MB/fwf8X0KgLeSuttPbv7jTNyLSQRFNLgA8n81JMTxh89jnReqhtBPh1VaXvgAdNvpCMGdhlCKR5vPguq1UQtu2caIkiultgLbdR9gPJRzyonatMZOHqfsXWYuemEf4bW1oM8JcWi+R25Q==
Received: from CO2PR04CA0157.namprd04.prod.outlook.com (2603:10b6:104:4::11)
 by MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Sun, 8 Nov
 2020 22:12:26 +0000
Received: from MW2NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::aa) by CO2PR04CA0157.outlook.office365.com
 (2603:10b6:104:4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT004.mail.protection.outlook.com (10.13.180.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:25 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:20 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 10/10] tests/arg_parser: add test for default TinfoilConfigParameters 'ui'
Date: Sun, 8 Nov 2020 17:10:59 -0500
Message-ID: <20201108221059.16854-11-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b36ec8b-9de5-43bb-5396-08d884335fe7
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MN2PR12MB2863435FA7396A11A28EC29C8BEB0@MN2PR12MB2863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JVo09CGnr3MtifvxyMU+3QTsNw9rKg6w2AAmxPwowGP1WjrxMMsAdYs5AYvjTszEVmqKTGzF8QcZmPOzeI0OQ6vvglmJYbgRSR3kQVjd9bXKoFVqTqR3QhzTKjqyLwf9sDlOovC7HnJiWZOtlWZl1xqPpn0bARVa0e2LJ1ajI83ZDg2E9x+jyxvOyZAcgpS50IPnC1LyH78cVfIpCetO8PcDNpmF1ZCDXB0g2rBDiV0rJKh/vS/6QA1VcdYdKBohR/P4IbGiFdUNdgsGVU+knX2/bqYMZsFS0cD9JxMYU1A/PQSaojLhyKY3m4vXO5UNOhRw+QHCo4NxA6pFCGMGpCsjDJxcWQaUd0cdsfJQxXqV6yt5uAr68oTRQTd0AEAu5T7tifd4HVNpUuvq0G2zpJCbTdDDCU16NLtl4tja+Gw=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(29502001)(46966005)(5660300002)(8676002)(82310400003)(86362001)(356005)(6666004)(2906002)(1076003)(47076004)(4326008)(8936002)(107886003)(6916009)(7636003)(82740400003)(36756003)(36906005)(316002)(70206006)(426003)(2616005)(186003)(26005)(44832011)(478600001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:25.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36ec8b-9de5-43bb-5396-08d884335fe7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/tests/arg_parser.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/tests/arg_parser.py b/lib/bb/tests/arg_parser.py
index be2d86fa..73264066 100644
--- a/lib/bb/tests/arg_parser.py
+++ b/lib/bb/tests/arg_parser.py
@@ -9,9 +9,11 @@
 
 import collections
 import shlex
+import types
 import unittest
 
 from bb.main import create_bitbake_parser, BitBakeConfigParameters, LazyUiChoices
+from bb.tinfoil import TinfoilConfigParameters
 
 ParseResult = collections.namedtuple("ParseResult", ("options", "targets"))
 
@@ -53,3 +55,8 @@ class ArgParserTests(unittest.TestCase):
         ui_action = ui_actions[0]
         self.assertIs(type(ui_action.type), LazyUiChoices, "'ui' action has wrong type")
         self.assertFalse(ui_action.type.has_loaded_modules, "Creation of the arg parser loaded the bb.ui modules")
+
+    def test_tinfoil_default_ui_arg(self):
+        # Ensure the default 'ui' parameter is a module, not a str
+        params = TinfoilConfigParameters(config_only=True)
+        self.assertIs(type(params.ui), types.ModuleType)
-- 
2.17.1

