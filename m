Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.79])
 by mx.groups.io with SMTP id smtpd.web10.6756.1604715679477722393
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 18:21:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=iW7e98fB;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.79, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwSLjsVH3raY37JdcLlkvJfN+Fune5vuZni1/xqsgzdtHwVyud4d7/Nd4y44R1TqhIEORJm/vKyl+ACqt75UPnxro12EpqsRpv9uPiP2jU9ijP4Bp2GN9XE4gOJfyecd5OjEr9veQcHgaas9qBRKv1f67NeY1n26ZZW0K7h29wnQ7hlMJ8grYDrbLBeU3WPaUAB6Wr8S9lFU2/VsEOOdmxfRnNJQ28jm+mbsSfPld0PK3nnwu3foxvknIPhv19tg2QTqa6EJZHqaSaJCorAcjmz8CM976Sg/+P/kc6R2vfFeToodDNkhYG3JB5lvtEMYp1Zp/3jYSBsrb+MyEdEzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eABP2U/kxTMedTqfwSt09dSdT1dHyxwbA8+BeUsYJ0=;
 b=CRknCwg27zZGg8WiIe89qbz7dXP68e2GrYdvm2gUunpvT0Zhk/k8jxe2bzcydxc+GXtzypbgkGmNqJJ1uMwtwJB5mq8xdaikWKs5lRbPr98vwMntHoATNWcM2bPRiQuhuLgMI/baTIZuthFD+fqJBNTgwC8EahLZwc8mPjRiUW7TQMe1YfP04w/UXZ8ts3r+0TLplL3+0bc0y5iJmIAd3+2DdjeLdmJh1wY5Ku9lj3V08rlXB8cLBn+slR5MeDtmTPoLylAMxcCfCefr6LGYcRnAIvqqWr6ZXxuFGaoB6Hph9JyJr95QE8aOdMZsbVdRiiy/QIewM6ILrnczQnSGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eABP2U/kxTMedTqfwSt09dSdT1dHyxwbA8+BeUsYJ0=;
 b=iW7e98fB/pRfbUy87iB0QS9hVgeeSrFvR6jAs4aKfm2O0YZ12Tp/8PrQ39KJ2h7dDph4tFZYcPeFcTRn4xKjJ4/EWsyFVMhumQ1kFVIwaM8y44B2f91eLLAcymUAMlmwveT2Qp9CJnJyq+hT8+uSlomgEA9KZZYXDFc9oFfxdC2GOSQv7LPdXhQeyUXitWpEJWVsjfkYuwW9cfjwAJdxFMen9cTo3VYjSdGgl6pYmX1E5VDXyijFNgNmtwghhzzP4WNUXLS68+1XFKgi+PFcTNUavMjBMWi/YX+3jxf8aI4KSp6vF8kLSHNP7mjMRyg9EheQdrNHUo+q4TfGTBR5Pg==
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sat, 7 Nov
 2020 02:21:18 +0000
Received: from DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::71) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend
 Transport; Sat, 7 Nov 2020 02:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT058.mail.protection.outlook.com (10.13.179.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Sat, 7 Nov 2020 02:21:17 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 19:21:13 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 5/5] main: fix parsing of intermixed arguments
Date: Fri, 6 Nov 2020 21:21:06 -0500
Message-ID: <20201107022106.84056-6-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201107022106.84056-1-chris.laplante@agilent.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa0de84-65a5-4476-fa94-08d882c3cf1a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2907:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM6PR12MB29078C63BF5EDE273297E5A38BEC0@DM6PR12MB2907.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LqHpAm+sbAF6pGYa7kDfuWO24DQHo5a0ZZ+s1xB8YvHykKamB54qhZAtS8UVG8rgKp7SJAunlgjzPW/5SEmTRW0so3oMd6srmruhf0z9xm3duHDQBLtpV+AevxGL0tK7BLB+BGIFtxivYMfMWLoHUpIBmxAOc2M/HE2aRRI6iu25L8o6Xbg3VXV1Jbece6Pf6g0Dcd4kxXHFWJA3Fpg05TH4H9KXh7ldEPjXvGrn1vvCFnkGL9l7BoA8SU5gTmi1NB/a+4mdZ7IzuKdLrzFYEAHoNkoaJsC2sN909sbIsxav7ICA6MieroKedY224ANrTu1aiFVBmgIE9Ty9pAEuVsotWtDXU6qDmcVGoL+JT5EwuWdZnv4kdOGXRQTqgFEpNC0MJMebaA6SJs9cjHZet9GU5zSWaTXtb07lK/425Cg=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(29502001)(46966005)(8676002)(1076003)(336012)(7636003)(86362001)(6916009)(2616005)(8936002)(426003)(107886003)(2906002)(6666004)(36906005)(316002)(82310400003)(478600001)(186003)(26005)(70206006)(82740400003)(36756003)(83380400001)(44832011)(4326008)(47076004)(5660300002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 02:21:17.6501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa0de84-65a5-4476-fa94-08d882c3cf1a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
Content-Type: text/plain

use parse_known_args instead of parse_args. Otherwise, argparse
incorreclty interprets (for example) 'bitbake -S none world'.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 16ff6e59..4648a8ea 100755
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

