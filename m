Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.77.47])
 by mx.groups.io with SMTP id smtpd.web10.3079.1604873545758881523
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=PIz0iV5J;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.77.47, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdIKdibuaoBQ44LSHReGkkyooTWz/LvV9Jb6ux00ClMMV9aWPMJaqemYxIzFu2TxtnuzLIZtOo+33gCx2GNaNy4H4ldr/LNGnEBToRTGaADqU8+9nFl798GMnWmeD8SS5KWZfCSGIHM5IIezcotjUoFlVc1UvFlBM0JNlf491M6fCm+WDZ5By/NChaFwPGZ+rDT+GXfpUxuyT8xTfv8i/eRu1+wAHNKTobi8rTHQTBYpSz6sLSU/6ko8FSdTJ9ozMrNSdXh5qpq4Ie6ltomugRNSivM8ORwfrDx20cqrGWYZrEyOTpg+2MRxXnfKGloA6EhGzNfbwjlXjBgHW6SD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7XHsaAxtKsaSl3qJ/OAanh5cUJSwAICR3WQStqoswg=;
 b=JAaDGrqVlS5jayUDRyu5B+2r8/sxsJwVUZUwzN11X/cUy9OsFioTMXEskbJzYzAXESaBQUxCuM0hMcid4Uk+Ykhv8HKlYA5Rk67U4N89osMZI+WjvzAskBrc5QLvtzSvd/eiLKdB0qn1tghIm+kaSRN0LSIdJnyGqZ+h5BWFBujhO8y5NBj1fvInNBjGkABz7+2rKMnYmb8IqQvlVMpThQGR0QNXYKjFA4/ELCKP/r+YgOpnZiFHgpsvyOaliHK+ru/QEKbLIziEWvINuk2ki4GplTYgRpQ/bpSqF0b/9H22NJdR4HDGRvsKVWaFMlJky5AvGKC0cekhUrJbaFwgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7XHsaAxtKsaSl3qJ/OAanh5cUJSwAICR3WQStqoswg=;
 b=PIz0iV5JNStGpJRcCnUWt9WgNxXDDOwz325ZhGF43D0tgcjIXHvNiYLqNQ2YMH8Wm95mgs0q5MaP5SPvXNhH+vemUGKG6LakFUf2wXWNBMu66+PwZNpwted+H6TbjwvCR7YaNLoFkfYmCfCKMDUMlXgy9rfCdlDGqKk6O0DHWrH1svwQPV5ICVIMfO2ST6/oeNgJ+3zLL4towI/ZMKWS6lpSxnTkOP7c68U0qzS7l8kAM3Xq4NUNOltYpUw48utpqzzLpNP58KQo/nbvWQxddOvLgumFpqVZGIT6R6rEP5LpYLdgdgXsR8hYlCwOD+777m0wLJw0USI2wQAfRJjUOg==
Received: from MWHPR18CA0033.namprd18.prod.outlook.com (2603:10b6:320:31::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 22:12:24 +0000
Received: from MW2NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::92) by MWHPR18CA0033.outlook.office365.com
 (2603:10b6:320:31::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT062.mail.protection.outlook.com (10.13.181.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:23 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:19 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 08/10] main: fix parsing of intermixed arguments
Date: Sun, 8 Nov 2020 17:10:57 -0500
Message-ID: <20201108221059.16854-9-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: f712fbc7-3be1-4db7-6810-08d884335ebb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BL0PR12MB249781FAFE72EA5D5FEB35738BEB0@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LDZTfXx0Y9iFUBMKW3bg+yOPheIlz0UZ4fPTVSR+CIJ286uO10IpVtyAJ6WVBvzmrg8qyupYgpEHkNGXy9TH57+6nGKaFNtM+6HPdxxff8OcQuK1b2jdw8vXMBqwFgVP3sfMADY2WXhdkEdZXPUBewrghahLK1ZaB2u0i/P4gM3rnieI+98d/vvPJa1OpT2PT0gmSwY4dehgxwRwbT/ad/W6LvQsSkmt/JgImNAehZ9bk6z2Cn2fOdIoIvf4yjfBSzxOp+cuei/w5a1btNLYvD2OesnLWq41EtMbM/1RQkH4GNKO5ktZL9uuehUYa8PsJUT2BvMLbBfGZUNgIpqsDdqrUuQ9zNQJy+0tCpxwbEOW6yZKa4AZyxv4lUhWe2gSaf619Cr5Hqfmk+6+37VaUTh9cCidYjfG44nuoHsReSI=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(29502001)(46966005)(8936002)(426003)(107886003)(83380400001)(82740400003)(44832011)(26005)(47076004)(6666004)(356005)(2906002)(82310400003)(478600001)(36906005)(70206006)(316002)(336012)(6916009)(36756003)(186003)(7636003)(1076003)(8676002)(4326008)(2616005)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:23.9284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f712fbc7-3be1-4db7-6810-08d884335ebb
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
Content-Type: text/plain

use parse_known_args instead of parse_args. Otherwise, argparse
incorreclty interprets (for example) 'bitbake -S none world'.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index f8a19bc3..9ce931d6 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -132,7 +132,6 @@ def create_bitbake_parser():
     It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
     will provide the layer, BBFILES and other configuration information.
     """, add_help=False)
-    parser.add_argument("targets", nargs="*")
 
     # List options that the user is most likely to use first
     frequent_group = parser.add_argument_group("frequently used")
@@ -304,7 +303,7 @@ def create_bitbake_parser():
 class BitBakeConfigParameters(cookerdata.ConfigParameters):
     def parseCommandLine(self, argv=None):
         parser = create_bitbake_parser()
-        args = parser.parse_args(argv or sys.argv)
+        args, targets = parser.parse_known_args(argv or sys.argv)
 
         if args.quiet and args.verbose:
             parser.error("options --quiet and --verbose are mutually exclusive")
@@ -336,7 +335,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         else:
             args.xmlrpcinterface = (None, 0)
 
-        return args, args.targets[1:]
+        return args, targets[1:]
 
 
 def bitbake_main(configParams, configuration):
-- 
2.17.1

