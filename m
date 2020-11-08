Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.73])
 by mx.groups.io with SMTP id smtpd.web09.3148.1604873538416410811
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=C8yydYRg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.73, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwmX4iwBxnQDrfkNOMD66FIelnNmuwgIBANohTQBT60o7s+XJQ4DE+Z+8s0cwBw4y10RSGxOpd9Bw+Oc4rIIRfGueDevxphc1qFTSdRSDVO22WOlsH7ZnywCUnVJIVS7SEJYtcySqkGPJpDBh1LZkbcZXFt0JgbxOjP8ctC6UBdeh2nOaS9Qvg9QlE62nvxC1j5mvZU48poJHKZ0FiOKl4Vn6gqOu+OwksGKGKMhfC9UrfOrr0YO5nXeVuAk1zbY5CDpBdd4CUNT8KKzBgoOGV3Y1ThpVxTUAmAAFDON39xncUTwSPken1CibTMGHasr9tSCXWHs0CwCuFU9gQT4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gn3OYV/ecYduf8PpF3iUBZOqX1hm7pYbYDLJY+kiro=;
 b=f04pBKodnkZRSsEahxbVPPPw0zvmA05TTCi3/T4xmUjSn5dkfA9OMaZ66H0usFZpWH6jqaSbXei7mm3Gyxmeg+FlbJdAupfgP5Se/roWJaOKrHmayISYplZ56xdVxyodhH34mTOqSwqz1Lyr8CSNk1vz/5vrS5Lxn0XtVWz6bIN+13EvmYIVPLQH4VXbKVrdBiGwKLRphQiCqPWc7MxkE7VU74BeSq4qrOSc8Eua3AABQRO2VEiPkgIZNri7UxTkyFontESfPil0GyZ/bfqWFBcN+71XK4+G5b1ePA4ZlIKymz1TD7lv6flc432bqcVgHcJFdoVjhkt7SRwSXd/tKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gn3OYV/ecYduf8PpF3iUBZOqX1hm7pYbYDLJY+kiro=;
 b=C8yydYRgizvndp++ZUEBZZyGIIPdYhsNBdU2XMwXk2OVydCAZz7W7MlsR7DIqErKvH2nIoru6xlOPiqaJPHAVkVoKNMY6QV+h9/ou8sZ/Ha5zImEkzbYo2kmdtg8DcR313PjA94h/+YHl4Qc8FtuXHx3xxaX9u1oPJhOz+PYYBAMgBljCDhBEZb7gG0HYCJLW6kuvnwz+m3eblOQN5suFDQnwMC0WuasfUz+wOSYrCqSknecN03TVcbPv62Iau7OFv3D0Szaug3Mpvllk50vQj8grg6nI6Agu5RqWrh8Nny1721kRDuSN3k7kfUxy/bWDkvJ5qYrK9zLQzGJqCFQRg==
Received: from CO2PR04CA0064.namprd04.prod.outlook.com (2603:10b6:102:1::32)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 22:12:16 +0000
Received: from MW2NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::94) by CO2PR04CA0064.outlook.office365.com
 (2603:10b6:102:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT060.mail.protection.outlook.com (10.13.181.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:16 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:15 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 01/10] cookerdata: tweak to avoid mutable default argument
Date: Sun, 8 Nov 2020 17:10:50 -0500
Message-ID: <20201108221059.16854-2-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9042db20-d5e1-489f-fca1-08d884335a5b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB3414DF3EA0C538E17BB703168BEB0@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xHlm1168Xdr22YtLRZSkXtoYkzkECa4uz9BAwf0sS6AxqTYbA6oOgAv/BbPqM0joctZj24SXIr+OXABNM16/nMVj17U3TZeADzQ9BoLvqUd8fR6YDf8Kytv644uq6D6cQsm/yoFSnpDePv+QNjx34gNJ6NbYyzNq+vQQ8ORZBMaFiR2ndvlEJcNxnjHzP1rUiOCRl6K9iq1c/kZeDqlJIH46xWdkCRNhSqcKIpiOn0ZEHFUwIpRmnmpRzz9grwU/IUShn0sKdJ1hh0StBm8qWpDAla4v8G6o72Z0iTpsOyg3Z2s2snzFaMoXFP/FFKtpwuVrUcDop/V/J5BM4I1/xcwPmduDJu6GVy3lFUIWfZtEQc+pafIZYjN1u0sL6ILIoUyNI9WaE6O/fDhaG1+Uqex7oNsUyarS1paDqhISLFg=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(29502001)(46966005)(8676002)(36756003)(7636003)(336012)(82740400003)(6916009)(316002)(2616005)(8936002)(2906002)(107886003)(426003)(6666004)(36906005)(82310400003)(478600001)(186003)(26005)(1076003)(70206006)(356005)(44832011)(83380400001)(47076004)(4326008)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:16.5842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9042db20-d5e1-489f-fca1-08d884335a5b
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT060.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/cookerdata.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 91cc4347..c39b5681 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -23,8 +23,8 @@ logger      = logging.getLogger("BitBake")
 parselog    = logging.getLogger("BitBake.Parsing")
 
 class ConfigParameters(object):
-    def __init__(self, argv=sys.argv):
-        self.options, targets = self.parseCommandLine(argv)
+    def __init__(self, argv=None):
+        self.options, targets = self.parseCommandLine(argv or sys.argv)
         self.environment = self.parseEnvironment()
 
         self.options.pkgs_to_build = targets or []
@@ -209,7 +209,7 @@ def findConfigFile(configfile, data):
     return None
 
 #
-# We search for a conf/bblayers.conf under an entry in BBPATH or in cwd working 
+# We search for a conf/bblayers.conf under an entry in BBPATH or in cwd working
 # up to /. If that fails, we search for a conf/bitbake.conf in BBPATH.
 #
 
-- 
2.17.1

