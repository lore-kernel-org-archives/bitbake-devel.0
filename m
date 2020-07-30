Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.84])
 by mx.groups.io with SMTP id smtpd.web10.5148.1596144507175472946
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 14:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=PWB+8Ftq;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.84, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+JuiNxJxXAnhr0+EOhkCdFegbqh55r7ORqhLmsKdT8jCqQ3mermlGZpxkW+SiTmCiuZQDHD2Ly4UfV/l6u2UzbvPh4CHwo6pBS+xDTb/7jZo6YW/p8jTP5aJ3MNRZ8tj5j4ms1mJ+VWmY3byUJBkoeTn//blo76O8LpWJeLO6jY9uOWL3JSBCAgHDw2VLkFnIz91jHCXZ72gd8oyk+uGzicABobHaTELVRdu6QXbzrY67nauDR7Jhh5cuDyqB7AUT+9AskkYflSzl+3Jkc9tF5mrUPbvNwcie4nfSTygAWkxHTaj78fR+1gYh2stXfQfDh1QQoqAuJ65KzNlWwknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+iPL/jm63wnWZ/5kToAR9VxolrNGcg/0H9scII1ilQ=;
 b=WrxtSjjf2zlLQeJq5doqjGLczJ25GB+VXm/uF6eX3MNMBgr6imon5LHe4BuLaNol5sb3+DhQoJKZqCuu09BigqD+y95c2ldQ/HnKlPZ+eDoJpOMISEcGcdujMSW4Itw5BTK+SA7nBzA1my5TDsMuKSI+489kI3ZH0K36OScdMDnjkBu5KlniYQCvSPyL6RcppJv60twP2o9VD/pnWlzwkoDAYg7K/MX/ol3p/XUmQrsKowkRnAswmwzA6aZ67hlqc074XvBPsbLYUGGoe3uF/xWDJlARmzh7joOlhowsJR1VGZqF7db2iVN7ZnFCOwyu51+ydYpKZv4oF/h9G22ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+iPL/jm63wnWZ/5kToAR9VxolrNGcg/0H9scII1ilQ=;
 b=PWB+8Ftq/uN0xGsh+ohwt3AKWhs2AGdehozcVlYR99OUu3onF8HUjrUf+eRZ45x2KDdySWW38YoAFvq8EKZlqU3plgLNdVdUDguREYOVXQkL43T0vcvcG/OfYV3QcJW3i2sO/Ji0DpuiddFcSga6M5gwAeQuQ4aBv0ITT/P6t5UCMtPzz4zn1sy2gLjViknpKw2z2Rkofme49pMUN7e++Fe3AA9Rv5/GytIGf50HKnaLITrMhxTTtq6loNFi+MrSeoHo73uuSQBxX1NFJOyaCFxEPBYLXwIaLbziIga4K00NhdpyEIOE6K5GybhNqwqWiF0dyZoZ1nV1Po0W251Fzw==
Received: from DM5PR19CA0022.namprd19.prod.outlook.com (2603:10b6:3:151::32)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 21:28:25 +0000
Received: from DM6NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::44) by DM5PR19CA0022.outlook.office365.com
 (2603:10b6:3:151::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 21:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT055.mail.protection.outlook.com (10.13.179.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Thu, 30 Jul 2020 21:28:25 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Thu, 30 Jul 2020 15:28:23 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 1/3] progress: modernize syntax, format
Date: Thu, 30 Jul 2020 17:25:59 -0400
Message-ID: <20200730212601.80181-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155dbe2c-070d-401d-f63b-08d834cf7e5a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MN2PR12MB4583AB793661F3E5096170538B710@MN2PR12MB4583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U7+iOnTgaUesYVqAEi/Ycm4lGr2dDDL1PIDD9CwQyQP1d/I/JG3wFm1utodw+FujQKDSkPKw+yZitP3+m/k04Vo7RhsnPJkNn4UD6xSY7/KLssweUuzbVv2TNF7VNejAjh4JGGH9QfKvIZOjrfgm1YjFRGs+oAxz6SEFy4ltwQQnXB05i5b3dfsY1SgD1+v24wPtx9Ko4Asl4Pp1Ba/wh5rFwbTeAJumLfGBndvF0XSpVK0eGT2gMM/Jt0qzL7EVzcs6MJMirZn+U+PO0TFA0bUkCeBBsjpNhhJQzmebkA2RNl7JFPr00FQo52w/fyERIpFiuy2oFnvQqfDrJ0OoRTqtT8wuhMYAdpKq7hvLw45K6oqXk1gBzWBOkDX9nTamg1FPwznjJTlswfBjQf0ZVpKKJ0Y4h0RPpiiSI0R7zKc=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(346002)(376002)(136003)(29502001)(46966005)(83380400001)(82310400002)(82740400003)(6916009)(47076004)(8936002)(316002)(2906002)(356005)(1076003)(36906005)(8676002)(5660300002)(7636003)(6666004)(336012)(44832011)(956004)(186003)(2616005)(86362001)(4326008)(36756003)(107886003)(478600001)(26005)(70206006)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 21:28:25.4461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155dbe2c-070d-401d-f63b-08d834cf7e5a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT055.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
Content-Type: text/plain

Also fixes DummyMultiStageProcessProgressReporter calling the wrong super __init__

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/progress.py | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 9c755b7f..b4e9bf0f 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -14,7 +14,8 @@ import bb.event
 import bb.build
 from bb.build import StdoutNoopContextManager
 
-class ProgressHandler(object):
+
+class ProgressHandler:
     """
     Base class that can pretend to be a file object well enough to be
     used to build objects to intercept console output and determine the
@@ -55,6 +56,7 @@ class ProgressHandler(object):
             self._lastevent = ts
             self._progress = progress
 
+
 class LineFilterProgressHandler(ProgressHandler):
     """
     A ProgressHandler variant that provides the ability to filter out
@@ -66,7 +68,7 @@ class LineFilterProgressHandler(ProgressHandler):
     """
     def __init__(self, d, outfile=None):
         self._linebuffer = ''
-        super(LineFilterProgressHandler, self).__init__(d, outfile)
+        super().__init__(d, outfile)
 
     def write(self, string):
         self._linebuffer += string
@@ -81,14 +83,15 @@ class LineFilterProgressHandler(ProgressHandler):
             if lbreakpos:
                 line = line[lbreakpos:]
             if self.writeline(line):
-                super(LineFilterProgressHandler, self).write(line)
+                super().write(line)
 
     def writeline(self, line):
         return True
 
+
 class BasicProgressHandler(ProgressHandler):
     def __init__(self, d, regex=r'(\d+)%', outfile=None):
-        super(BasicProgressHandler, self).__init__(d, outfile)
+        super().__init__(d, outfile)
         self._regex = re.compile(regex)
         # Send an initial progress event so the bar gets shown
         self._fire_progress(0)
@@ -98,11 +101,12 @@ class BasicProgressHandler(ProgressHandler):
         if percs:
             progress = int(percs[-1])
             self.update(progress)
-        super(BasicProgressHandler, self).write(string)
+        super().write(string)
+
 
 class OutOfProgressHandler(ProgressHandler):
     def __init__(self, d, regex, outfile=None):
-        super(OutOfProgressHandler, self).__init__(d, outfile)
+        super().__init__(d, outfile)
         self._regex = re.compile(regex)
         # Send an initial progress event so the bar gets shown
         self._fire_progress(0)
@@ -112,9 +116,10 @@ class OutOfProgressHandler(ProgressHandler):
         if nums:
             progress = (float(nums[-1][0]) / float(nums[-1][1])) * 100
             self.update(progress)
-        super(OutOfProgressHandler, self).write(string)
+        super().write(string)
 
-class MultiStageProgressReporter(object):
+
+class MultiStageProgressReporter:
     """
     Class which allows reporting progress without the caller
     having to know where they are in the overall sequence. Useful
@@ -230,6 +235,7 @@ class MultiStageProgressReporter(object):
                     out.append('Up to finish: %d' % stage_weight)
             bb.warn('Stage times:\n  %s' % '\n  '.join(out))
 
+
 class MultiStageProcessProgressReporter(MultiStageProgressReporter):
     """
     Version of MultiStageProgressReporter intended for use with
@@ -238,7 +244,7 @@ class MultiStageProcessProgressReporter(MultiStageProgressReporter):
     def __init__(self, d, processname, stage_weights, debug=False):
         self._processname = processname
         self._started = False
-        MultiStageProgressReporter.__init__(self, d, stage_weights, debug)
+        super().__init__(d, stage_weights, debug)
 
     def start(self):
         if not self._started:
@@ -255,13 +261,14 @@ class MultiStageProcessProgressReporter(MultiStageProgressReporter):
         MultiStageProgressReporter.finish(self)
         bb.event.fire(bb.event.ProcessFinished(self._processname), self._data)
 
+
 class DummyMultiStageProcessProgressReporter(MultiStageProgressReporter):
     """
     MultiStageProcessProgressReporter that takes the calls and does nothing
     with them (to avoid a bunch of "if progress_reporter:" checks)
     """
     def __init__(self):
-        MultiStageProcessProgressReporter.__init__(self, "", None, [])
+        super().__init__(None, [])
 
     def _fire_progress(self, taskprogress, rate=None):
         pass
-- 
2.17.1

