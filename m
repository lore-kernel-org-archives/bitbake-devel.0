Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 18020 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 07 Jun 2019 23:57:14 UTC
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr820087.outbound.protection.outlook.com [40.107.82.87])
	by mail.openembedded.org (Postfix) with ESMTP id 3AFAF7E54C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2019 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QCngRZ+Z+8643igSmFnT5m57vkNKVdCublb0f+nw6/E=;
	b=Be3hX8nxmLhKUxCb+6anuwBBTfE5u4/hH/48Ogr9r0O8OJrWCG7ee06uPfSBVpP0I5VzJXIRKW1iKkgdJlSgrStwsH9vI+hOKYhhXm5gPZ1rDM+xB87PwlowCC+u1t8z66MgtNvEtIJCUh51bfHZS2JRqzauqby01E5/wfbElN4=
Received: from MN2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:208:a8::16)
	by MW2PR12MB2538.namprd12.prod.outlook.com (2603:10b6:907:9::29) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14;
	Fri, 7 Jun 2019 18:24:33 +0000
Received: from BY2NAM05FT003.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e52::207) by MN2PR12CA0003.outlook.office365.com
	(2603:10b6:208:a8::16) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22 via
	Frontend Transport; Fri, 7 Jun 2019 18:24:33 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	BY2NAM05FT003.mail.protection.outlook.com (10.152.100.140) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1987.5 via Frontend Transport; Fri, 7 Jun 2019 18:24:32 +0000
Received: from localhost.localdomain (10.46.26.152) by edgeappmail.agilent.com
	(192.25.218.41) with Microsoft SMTP Server id 15.1.1713.5;
	Fri, 7 Jun 2019 12:24:30 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 7 Jun 2019 14:24:02 -0400
Message-ID: <1559931844-116966-3-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
References: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(29502001)(47776003)(4326008)(76176011)(5660300002)(49486002)(186003)(8676002)(6916009)(48376002)(336012)(107886003)(246002)(486006)(126002)(16586007)(476003)(2616005)(2906002)(44832011)(426003)(73956011)(50466002)(316002)(11346002)(70206006)(446003)(36906005)(7636002)(2351001)(77096007)(478600001)(8936002)(86362001)(356004)(6666004)(36756003)(50226002)(51416003)(305945005)(26005)(106002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2538;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e4a1f1-31b5-4680-c551-08d6eb756387
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
	SRVR:MW2PR12MB2538; 
X-MS-TrafficTypeDiagnostic: MW2PR12MB2538:
X-Microsoft-Antispam-PRVS: <MW2PR12MB253880253C37F64AFDDFD86B8B100@MW2PR12MB2538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-Forefront-PRVS: 0061C35778
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8a091jYGYwC/OmDRTo1DbDxZiGXD9H/MfXaKPb0zutJqx93KGM6ClvIGAKPu7CngrK3FqYFQP0IajE1Kcjn/YzwEI+wjCFprV3xTpBZF4APVJVbh0v5BMwe+X6op+uY2sBMgdM40Ukl8Onu0yHL8hjPaOCCkOfYlrIR/dm9/M6fEIyzm2IAZhE4K0OmavShIYzcIleyOVXj9k1BM5w3JrHPfsGUTV277dbpNE5WrTHSFAjwZucdMgYtA6MeT3NXamcMqj64ZDnganhUp+u/QsAxfT3OOawF8F00P2YSz+kIu0sJ6BfMIxdNfYEMOb8ohIMtGUa76v1yxBAoNiBTpIltlLxEaaknaoRckfLFvg+e10GgwhS6S4xYd0HMtDZBKNGAEvseGWVgIZMZUHOcIyI0mUFCxiXVtodat/lw5omI=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2019 18:24:32.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e4a1f1-31b5-4680-c551-08d6eb756387
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2538
Subject: [PATCH 2/4] bitbake: build: extract progress handler creation logic into its own method
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
X-List-Received-Date: Fri, 07 Jun 2019 23:57:15 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index dae42ac..a0a764a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -323,6 +323,21 @@ trap 'bb_exit_handler' 0
 set -e
 '''
 
+def create_progress_handler(func, progress, logfile, d):
+    if progress == 'percent':
+        # Use default regex
+        return bb.progress.BasicProgressHandler(d, outfile=logfile)
+    elif progress.startswith('percent:'):
+        # Use specified regex
+        return bb.progress.BasicProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
+    elif progress.startswith('outof:'):
+        # Use specified regex
+        return bb.progress.OutOfProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
+    else:
+        bb.warn('%s: invalid task progress varflag value "%s", ignoring' % (func, progress))
+
+    return logfile
+
 def exec_func_shell(func, d, runfile, cwd=None):
     """Execute a shell function from the metadata
 
@@ -366,17 +381,7 @@ exit $ret
 
     progress = d.getVarFlag(func, 'progress')
     if progress:
-        if progress == 'percent':
-            # Use default regex
-            logfile = bb.progress.BasicProgressHandler(d, outfile=logfile)
-        elif progress.startswith('percent:'):
-            # Use specified regex
-            logfile = bb.progress.BasicProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
-        elif progress.startswith('outof:'):
-            # Use specified regex
-            logfile = bb.progress.OutOfProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
-        else:
-            bb.warn('%s: invalid task progress varflag value "%s", ignoring' % (func, progress))
+        logfile = create_progress_handler(func, progress, logfile, d)
 
     fifobuffer = bytearray()
     def readfifo(data):
-- 
2.7.4


