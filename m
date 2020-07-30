Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.63])
 by mx.groups.io with SMTP id smtpd.web10.615.1596127027380754623
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 09:37:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=h2j2Enml;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.63, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0QIuft/4Y7HtOXobs2pRbPJ2AwMjiHJZOvfnAt4DMFgRDJ+yslTf4AX9QPWckdzm8LL9KPj74ti/C03m2bZrrFQ/dmgkLVFgK/TUGN1Ez7f23tDdccSvsDeUrvE2b1VJ8dDZ6BOEaOh3yxVglSVea/mSlNQOOIdfYf2pPy9g7VaOrvXz16KTnbzNVM13BQBITW3QYVuA9rgmtoEJoZPiq7bJEWljshYahhLLzlBKJ7oXs/aD1Xh2oebDkzTDb319N3UP4CnzEspALPP0b+9VUtHTozB63YZODNcH49NqAMTiqiNoVte4tqeXM2wDaYo/E+Vfx4ySaE6VliQwzoc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9neBD2Qc1laY1/fTavYwy1OBP1vM6XLqGHdcCv820M=;
 b=JPOFdStclJyI270oMaLXcMnsqdirLzphh7q62KIF/rhhU5BsAQtTSEYM3A87FS0i5IsdVUyJmwxvcnG4sCWDhK4sDKa9VTtREEJHgHKi5aiwyO6AQZkfxH0/EXbDkU0XfRlJpStUygDm09nTcOpq5oxqff0waQA9XTYgkgEv1mpr9O+oa6R/2yY/RCrOzWK6M2YXvHWwz6ZPEZm4Cx99fCxshQo/IDu5iKr+scROclDTxgGbEM16Cgx/l2NAdj4LG5LcVMtQU3h6Fa+hufSF+9VV2m2hzdBqwQGNg+NgF3dw0LJqbqzDle4ElYF/gqpRg61fRbNUEPMbtktVqXcPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9neBD2Qc1laY1/fTavYwy1OBP1vM6XLqGHdcCv820M=;
 b=h2j2Enmlw1kFdM+4L2Dmtqouiy4yLrNb/bZbPbTg6jRCjHY/m/hM9VviaeLiQSP7iw7xjvwRMS2TZ78X/CUNmsF6ynAsz1Zu7qdJbsyiV8udVEiKYLj6oBSmu/f4DkF7c+3wBT8zEjXBIYYH/5qchAIDGLaVjB1TG8D8GpLQacek5Trd+hweMANZ9OcM0qGAkWSrKPo8ZPYz1TorS7hn1r5OEgP84QX7dgpvmqyE10qnqfabW+e16XZHQXkb2CHcjomkCV8mhK7uur8XCBKdBpxBtYzp47j3tCao2ambvAv66LNMMyLUWuXA0J9TvOQWymF/5dd/jSCoQ450K2nIKw==
Received: from DM5PR07CA0029.namprd07.prod.outlook.com (2603:10b6:3:16::15) by
 BYAPR12MB3223.namprd12.prod.outlook.com (2603:10b6:a03:138::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 30 Jul
 2020 16:37:05 +0000
Received: from DM6NAM12FT035.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::f5) by DM5PR07CA0029.outlook.office365.com
 (2603:10b6:3:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 16:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT035.mail.protection.outlook.com (10.13.179.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Thu, 30 Jul 2020 16:37:05 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Thu, 30 Jul 2020 10:36:52 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] progress: modernize syntax, formatting
Date: Thu, 30 Jul 2020 12:36:40 -0400
Message-ID: <20200730163640.96830-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9064c140-6acd-4adf-3299-08d834a6cb54
X-MS-TrafficTypeDiagnostic: BYAPR12MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR12MB322381F101BC91ED1C7F1E3C8B710@BYAPR12MB3223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Gfob/WXQXKA858+kuz+EtBHVo7Le/1HM/0cQ/Ko3vDadGvpNrhWUr92BSygqfgsDzPdXZi6iZOuI4JcpM0wpcjC4o3x3E3zrZ2q3f1O+qwBldImaeNspUQBFYFgw94CL2ulyi0VriV9YCQcgJ8EvkhBZUI+FG/8odQQyN1AC0w+i+kpgKTUdyJkDyzBJ/okEoToueaqmUnF5+9jseF3GnQVBMWD214ZHfdl/PoqoJ0dAOb5UgRygndNKi0tP605I6UkUdjZp8XA8xIy+mcEu2vP0v6EtYy/SbzkMIFtezdfV+MtF77UQHfyGSLWxZlzp/U2Ao3dUZI0rCZROo2XgVwqD4c1P6HBDfTFUv4P7ZIEi6i3DgXzt4rF++JLUC9+sLn39QABUxL1BCgk0FwwoZjtH5e67fKMlF7CbLMvdgRw=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(396003)(29502001)(46966005)(8676002)(70206006)(956004)(82310400002)(8936002)(86362001)(83380400001)(107886003)(2906002)(356005)(6916009)(2616005)(5660300002)(336012)(186003)(36906005)(4326008)(316002)(36756003)(1076003)(6666004)(7636003)(26005)(426003)(44832011)(47076004)(82740400003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 16:37:05.2104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9064c140-6acd-4adf-3299-08d834a6cb54
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT035.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3223
Content-Type: text/plain

Also fixes DummyMultiStageProcessProgressReporter.__init__ calling the
wrong super __init__.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/progress.py | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 9c755b7f..1b0d3ae2 100644
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
@@ -98,11 +101,11 @@ class BasicProgressHandler(ProgressHandler):
         if percs:
             progress = int(percs[-1])
             self.update(progress)
-        super(BasicProgressHandler, self).write(string)
+        super().write(string)
 
 class OutOfProgressHandler(ProgressHandler):
     def __init__(self, d, regex, outfile=None):
-        super(OutOfProgressHandler, self).__init__(d, outfile)
+        super().__init__(d, outfile)
         self._regex = re.compile(regex)
         # Send an initial progress event so the bar gets shown
         self._fire_progress(0)
@@ -112,9 +115,10 @@ class OutOfProgressHandler(ProgressHandler):
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
@@ -230,6 +234,7 @@ class MultiStageProgressReporter(object):
                     out.append('Up to finish: %d' % stage_weight)
             bb.warn('Stage times:\n  %s' % '\n  '.join(out))
 
+
 class MultiStageProcessProgressReporter(MultiStageProgressReporter):
     """
     Version of MultiStageProgressReporter intended for use with
@@ -238,7 +243,7 @@ class MultiStageProcessProgressReporter(MultiStageProgressReporter):
     def __init__(self, d, processname, stage_weights, debug=False):
         self._processname = processname
         self._started = False
-        MultiStageProgressReporter.__init__(self, d, stage_weights, debug)
+        super().__init__(d, stage_weights, debug)
 
     def start(self):
         if not self._started:
@@ -255,13 +260,14 @@ class MultiStageProcessProgressReporter(MultiStageProgressReporter):
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

