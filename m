Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 14169 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 08 Jun 2019 00:54:44 UTC
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690070.outbound.protection.outlook.com [40.107.69.70])
	by mail.openembedded.org (Postfix) with ESMTP id 8ABAD7D3AD
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  8 Jun 2019 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=G1Nh+xfZwzFBR9ZBqDnZh/y7ivXeBefc0netX/ccf+s=;
	b=cb016d2YXJQwJkLVUQZ34gd2edOassNZD64RwxPmV5KOYvxUQNFaobmgeuHjSp+6SK7bQHsNHT8ZfzqwsKBnbM2w5ttRg43d5WEqdSqSUCl+tTrRS80yvWu5qVKIDxa4A0mt6JTRCdL6jKClHhPlYy2c/EW3bHFgrEWltcAQ9XY=
Received: from MN2PR12CA0026.namprd12.prod.outlook.com (2603:10b6:208:a8::39)
	by DM5PR12MB2535.namprd12.prod.outlook.com (2603:10b6:4:b5::26) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14;
	Fri, 7 Jun 2019 18:24:35 +0000
Received: from BY2NAM05FT003.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e52::203) by MN2PR12CA0026.outlook.office365.com
	(2603:10b6:208:a8::39) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12 via
	Frontend Transport; Fri, 7 Jun 2019 18:24:35 +0000
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
	15.20.1987.5 via Frontend Transport; Fri, 7 Jun 2019 18:24:34 +0000
Received: from localhost.localdomain (10.46.26.152) by edgeappmail.agilent.com
	(192.25.218.41) with Microsoft SMTP Server id 15.1.1713.5;
	Fri, 7 Jun 2019 12:24:30 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 7 Jun 2019 14:24:03 -0400
Message-ID: <1559931844-116966-4-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
References: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(29502001)(70206006)(73956011)(14444005)(446003)(11346002)(86362001)(50466002)(426003)(126002)(486006)(47776003)(48376002)(336012)(76176011)(44832011)(51416003)(246002)(16586007)(316002)(6666004)(49486002)(356004)(4326008)(36906005)(107886003)(2351001)(2616005)(476003)(50226002)(478600001)(106002)(6916009)(8936002)(5660300002)(8676002)(186003)(77096007)(36756003)(26005)(7636002)(2906002)(305945005)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2535;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,exch.smtp.agilent.com; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1654bbeb-8c4b-43f2-e208-08d6eb75647a
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
	SRVR:DM5PR12MB2535; 
X-MS-TrafficTypeDiagnostic: DM5PR12MB2535:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2535E8B939C6C8E3925FACA48B100@DM5PR12MB2535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0061C35778
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JW5Ahv8TabWLj68CULax0V1azCVtEh4Lr0VqsJO0puPJzm3EntEc1VLZoMDxrX6vRxrs/7+jQY9y2G6toyQ/xa7MWpOoSA3osKHWWYaIQWY3GD34qO0Pc1KYWiGarAIc8pGLzu7dYaub4c0XhCJBx3HwIXFr5raxZLzuXNhfsPxEHyY3QsD6iIz34QOS9d5T7w4zIa3Ochm6Us7Fqm3Iz8j270n5MUJq5W7gS41UKalCJOkNzZjTHDcd3EI0Dscs4v6CKM8gep9la4iD22gA9ONv8UWUbzYCF3X5r5Td2rSJIyiS+ieJ9KWHkI/f81e0IrBRLd9RU0xTTBtO1el8odc+EWxktFVPcabDA53mt8zQ7vLHpSFLGHNpbr/3S7gD7MS7wzqF/N6lMhRRdhahtOmJJIiqtnGdI/WMxSCdlLA=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2019 18:24:34.4826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1654bbeb-8c4b-43f2-e208-08d6eb75647a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2535
Subject: [PATCH 3/4] bitbake: build/progress: use context managers for progress handlers
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
X-List-Received-Date: Sat, 08 Jun 2019 00:54:44 -0000
Content-Type: text/plain

It seems context management support was half-implemented, but never
finished. For example, LogTee has __enter__ and __exit__ but they
haven't been exercised until now.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py    | 31 +++++++++++++++++++++++++++----
 lib/bb/progress.py | 16 +++++++++++++++-
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index a0a764a..85ad8ea 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -163,12 +163,35 @@ class LogTee(object):
 
     def __repr__(self):
         return '<LogTee {0}>'.format(self.name)
+
     def flush(self):
         self.outfile.flush()
 
+
+class StdoutNoopContextManager:
+    """
+    This class acts like sys.stdout, but adds noop __enter__ and __exit__ methods.
+    """
+    def __enter__(self):
+        return sys.stdout
+
+    def __exit__(self, *exc_info):
+        pass
+
+    def write(self, string):
+        return sys.stdout.write(string)
+
+    def flush(self):
+        sys.stdout.flush()
+
+    @property
+    def name(self):
+        return sys.stdout.name
+
+
 #
 # pythonexception allows the python exceptions generated to be raised
-# as the real exceptions (not FuncFailed) and without a backtrace at the 
+# as the real exceptions (not FuncFailed) and without a backtrace at the
 # origin of the failure.
 #
 def exec_func(func, d, dirs = None, pythonexception=False):
@@ -375,9 +398,9 @@ exit $ret
             cmd = [fakerootcmd, runfile]
 
     if bb.msg.loggerDefaultVerbose:
-        logfile = LogTee(logger, sys.stdout)
+        logfile = LogTee(logger, StdoutNoopContextManager())
     else:
-        logfile = sys.stdout
+        logfile = StdoutNoopContextManager()
 
     progress = d.getVarFlag(func, 'progress')
     if progress:
@@ -433,7 +456,7 @@ exit $ret
             bb.debug(2, "Executing shell function %s" % func)
 
             try:
-                with open(os.devnull, 'r+') as stdin:
+                with open(os.devnull, 'r+') as stdin, logfile:
                     bb.process.run(cmd, shell=False, stdin=stdin, log=logfile, extrafiles=[(fifo,readfifo)])
             except bb.process.CmdError:
                 logfn = d.getVar('BB_LOGFILE')
diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index e9b72e2..4022caa 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -13,6 +13,7 @@ import time
 import inspect
 import bb.event
 import bb.build
+from bb.build import StdoutNoopContextManager
 
 class ProgressHandler(object):
     """
@@ -27,7 +28,14 @@ class ProgressHandler(object):
         if outfile:
             self._outfile = outfile
         else:
-            self._outfile = sys.stdout
+            self._outfile = StdoutNoopContextManager()
+
+    def __enter__(self):
+        self._outfile.__enter__()
+        return self
+
+    def __exit__(self, *excinfo):
+        self._outfile.__exit__(*excinfo)
 
     def _fire_progress(self, taskprogress, rate=None):
         """Internal function to fire the progress event"""
@@ -147,6 +155,12 @@ class MultiStageProgressReporter(object):
             self._stage_total = None
             self._callers = []
 
+    def __enter__(self):
+        return self
+
+    def __exit__(self, *excinfo):
+        pass
+
     def _fire_progress(self, taskprogress):
         bb.event.fire(bb.build.TaskProgress(taskprogress), self._data)
 
-- 
2.7.4


