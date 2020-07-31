Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.77.83])
 by mx.groups.io with SMTP id smtpd.web10.21217.1596210217556797681
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2020 08:43:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=1u9ZMxR5;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.77.83, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0SQRfQQv7hX2S05xYG/BGSEDIaIngOF051wPIvIhj3ekhYgxs52TKUYkTWHxrelkTvrpre35aZCM/lcW6inVTzOMd8R/Rtqv22uwJFIrriq+5m+h1/ysitrDQ9Ua+HNEBDpfIqqyDSATyQy9MFGDlslLjjjw4jOfnjvYTGwX2k7wp8c5p4QmCIep8nqzSQJF02GSCyNj8NosBkBui70EB3MOLkDAMqmFEfjJGFxDLzOajygBE+R+fvrkqYynGjCrpjqQ8vtyj9s6dCSmEIWUA2jXtH1J4uHCD4vtbmDfDEAP0gShtDofrSs/MYjoBeDgG+B7aozTc97wDsaJI/SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+iPL/jm63wnWZ/5kToAR9VxolrNGcg/0H9scII1ilQ=;
 b=Q4+ughAmnkTDefdWcIR2UIlvMUcZwVtEVR1X71GbP0Ct0U2pYNPX5Tr++N7aA/2lhe+jv/V0vSpH2aV5AEnJDWdVKmSo8XsrBp2gZmuDmHgLSvkOYxH87qVI8gNOfgdbnsk1+13Zfv4XBhHRUE4wEkIKEPP7oBpSKdUDBSz5cIO42WR3bgND3l5nKRJT4Vj/gtruC0UuBgK+nBOjbint4THG1ZK7+NqxbxAhQB/kGd3/tCnbqaha/XqCFwMyXixh33dJ8ev5ZP58lrZNW5v1EY4kFYmAKry1P4TygsI65kvDTEJBALvxlPggTSZBWnwGOnM8un+JQ2DrxL+sFZHJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+iPL/jm63wnWZ/5kToAR9VxolrNGcg/0H9scII1ilQ=;
 b=1u9ZMxR55n/1f83rmizs+Wh40xxD1wnoHEZvEo85YSQf/rlabbxU9/Ne4lBOs/LXM0b9BeFrQiStkEkBjJhPsGZHLU1i/XPdy5lebYyoaPxDag+4sGA+iaBJ6PVVJroKvw/e7DPNpPrFBvSfedMWM+ZAQwStSv0PP0QdtmTfpUkHarMQqknjrlOQj7cCQsiAuFnhgimDuP9Qb6fhMRJ0vH2HaRxOmEOxytA+a9H9ZQqF8p9R4DN/Y8n4VsB1Z+AR6pLbIP8AsNnwhmJfWdLJdFn7o470ic60gOIXksVNXQ065gu1xsbJtJmy8EN5TVwpOKRUzjywSoqLdveU95phTg==
Received: from DM5PR04CA0038.namprd04.prod.outlook.com (2603:10b6:3:12b::24)
 by BN8PR12MB3123.namprd12.prod.outlook.com (2603:10b6:408:42::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 15:43:30 +0000
Received: from DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::34) by DM5PR04CA0038.outlook.office365.com
 (2603:10b6:3:12b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 15:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT062.mail.protection.outlook.com (10.13.178.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 31 Jul 2020 15:43:30 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 31 Jul 2020 09:43:27 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 1/4] progress: modernize syntax, format
Date: Fri, 31 Jul 2020 11:42:46 -0400
Message-ID: <20200731154249.89999-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731154249.89999-1-chris.laplante@agilent.com>
References: <20200731154249.89999-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f3bd384-1537-4f02-9b0b-08d835687979
X-MS-TrafficTypeDiagnostic: BN8PR12MB3123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN8PR12MB31238DC39913DFA6CCD6BD8B8B4E0@BN8PR12MB3123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BlbujkxoKX1GxLl28OkQM3n8CWSpiWsPAHjSfD74bXfswDDmZaXyAVlw+6q8CnQq0sFYRo0Tb4hAIZ9hoGFZQ0+eG1YYMYxeCqKd4zLtcbxcwJ97RgCNcpkzpqZke2o0MzV/unMakjH+zoLG0HFIgDJSR/hWjKpW7NkZrRi4lfH2WCKDJ4AeBjAjTPkHexdXR3PH0f5THe8pV9U2fSUXR9c0TCcz6v3/TATVHClCr2cZCAOxji0ZFTTkWntnscjrBpdUWHRPDTDvp/OEytY93J/HTQepgRNssN646jYijVEOpHrH+aFv2qGN8UW3rTCLXkujedtlM4zKWUjLVhjvu5N+qiTv+MIm+7FP6GGLAyrd3uQASpjR/4zRFM/is3lliadqbJk41g5vSQ4LEFZAW77k0gCYPi0OXjKz6gqaric=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(346002)(39860400002)(29502001)(46966005)(2906002)(356005)(2616005)(4326008)(5660300002)(956004)(336012)(83380400001)(186003)(1076003)(7636003)(26005)(426003)(82310400002)(6916009)(6666004)(70206006)(107886003)(316002)(47076004)(36906005)(86362001)(8676002)(82740400003)(478600001)(8936002)(36756003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 15:43:30.2689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3bd384-1537-4f02-9b0b-08d835687979
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3123
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

