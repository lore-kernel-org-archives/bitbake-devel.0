Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.76])
 by mx.groups.io with SMTP id smtpd.web10.5149.1596144508964858969
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 14:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=anTCPpQ6;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.76, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCAiKS9WwCqiTLoCpAXOFeNtcRquK64PT8HCuttRa6cqXxRHE2buIrKDO8i4mYhtAIkfissTgemZfx1fe1Uvt3cO3M1UF3PmtCnM7t0PbofL7y606U24ggSOBQ50ujiFSVKdLKTSrwzlGRlmLC1IH8jrVg/mEO9SvaFvG6Jk/NexBpnk6fkEbqFxZk/j4Kw26YR+H2oiqI+xvQMtAo2UFpB61kMF1AuyZfJu1/+dsGMxf2Z5iTISC3UI2gL6tDfxlxOS3Uo6rJ6mo9KAVitsVIVwVbkeBSCC9RKU05wNptNT2dCt1RistWOmCO03napOClc7R4J0Mtxc/I0TztDWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO6aDo92ROtBNE5g+jrYcmZgoLZjLuBjF+LU8WELdf4=;
 b=AoCjJ/80rNZKfn5eQQu+RAqS53PyWF/P2jRgt+tLyIdrj0n/HQuq64GXVgM9yhSO80f+fIG/3Z3hNgjA/ifleNqQ4iPXfUJc7/B8jQ7KTIuvPATtk/krEEFIYmNSXnycCNfH4VebrOAG/grbJDlm+1CYsWqTdf125Ub3r3Mu1I80mKGJWVZgR63EQa+vpbu87Ac6aiPiIbFr3Ak6/bye05hVsUB0QHqUgoq3XRa57IgDGeEdVWoOydUA0gL4VUDTkpRTyoq3brZE4Lqr5A6lVGPNtmAQ46DlM0E62pDAzWRa1gZMcIAN2GpZ36nVgBpnpZCR9yUkwjzZwykB76nv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO6aDo92ROtBNE5g+jrYcmZgoLZjLuBjF+LU8WELdf4=;
 b=anTCPpQ6p//kpErQi9VkmtGa7/ZiGcZIlDyipCL1irRyK5Hz2iZ0NMD7lssWnXPycQvgN8dO++kBHiDdKpzElsJVveN7Gm6JQoIWdyC223YumDHHqg5NuxYyw7pBGgriIbKf6iX97mU1qrBpUf/Xv8AGgZ8HrvqUYG1xeWcWBa7pYCmOTIZ4U5TBxNJtSRbKTrhN491VgTWRsO2Lk7uADemG7L12AvX4/vbeyQOaOyDcwNCNbGiconz1GEMTWyf8oymL9Vhz2sQ2t/uHNu5J3ezeUSsx3bgQyiyHWyymXpKhRFymiWoc2zpP1EOCzBYc8IrlgHgIFpVacRLGvBApnA==
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Thu, 30 Jul
 2020 21:28:27 +0000
Received: from DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::ad) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.0 via Frontend
 Transport; Thu, 30 Jul 2020 21:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT051.mail.protection.outlook.com (10.13.178.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Thu, 30 Jul 2020 21:28:26 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Thu, 30 Jul 2020 15:28:24 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 3/3] progress: filter ANSI escape codes before looking for progress text
Date: Thu, 30 Jul 2020 17:26:01 -0400
Message-ID: <20200730212601.80181-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730212601.80181-1-chris.laplante@agilent.com>
References: <20200730212601.80181-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1c89b22-e0d4-4462-116e-08d834cf7f32
X-MS-TrafficTypeDiagnostic: SN6PR12MB2782:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SN6PR12MB2782A6D4CD7202FAB639EB788B710@SN6PR12MB2782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sOx0UNwq2/Ise5uPn+JWxmP4I2dDMxBztGGcrczn8CWhNtm2Wv3kKnFpMKNcaapI0xqtpIX1H5Kbj5pkZD6uthsPs/4emut/oJZbl4uzQsFMVpaL1YWk+BKlg1aYLYux2XSDlS8oGYQHOPWyutU3B6ZDcMR7zN6cOBEr1fwUjpu5muo2Vs50Uka9KOepP13Xxj7hmRDGjK/OpvaJGQXkiRld903Jih1DoXtuP9BMH6DErc3i5PA77AY7Hi0s2zpUv8IRtdenuMdl4d3d97qqr6qgcjP6AcGjTJjYaYx56hzB4t7nSP862TYd2b1HTLRsECs2kTXyLlHgvB4BDplOfSnzX1v/xzrhLlI0QcNshikwsHniBc1YRmP0XC6m2vfbqW335Sf8jjTlG/p2lY7oWo3F6oxBDHPFZBauZhlsfrYcKsJxb7TeYJC+/KtHw2DJ8aru5SaLp/n2rJjpTz1EkBbUzUhXGWD+Bon337uc4npSeueW4RUcYvwTCxR6/LXN
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(376002)(39860400002)(29502001)(46966005)(356005)(966005)(82310400002)(478600001)(36756003)(5660300002)(36906005)(47076004)(316002)(6916009)(956004)(2616005)(426003)(44832011)(7636003)(1076003)(82740400003)(336012)(86362001)(2906002)(83380400001)(107886003)(8676002)(4326008)(70206006)(6666004)(26005)(8936002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 21:28:26.8658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c89b22-e0d4-4462-116e-08d834cf7f32
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
Content-Type: text/plain

This is in prepartion for introducing the log-colorizer bbclass into poky.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/progress.py | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 8cddefae..d051ba01 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -15,6 +15,25 @@ import bb.build
 from bb.build import StdoutNoopContextManager
 
 
+# from https://stackoverflow.com/a/14693789/221061
+ANSI_ESCAPE_REGEX = re.compile(r'\x1B\[[0-?]*[ -/]*[@-~]')
+
+
+def filter_color(string):
+    """
+    Filter ANSI escape codes out of |string|, return new string
+    """
+    return ANSI_ESCAPE_REGEX.sub('', string)
+
+
+def filter_color_n(string):
+    """
+    Filter ANSI escape codes out of |string|, returns tuple of
+    (new string, # of ANSI codes removed)
+    """
+    return ANSI_ESCAPE_REGEX.subn('', string)
+
+
 class ProgressHandler:
     """
     Base class that can pretend to be a file object well enough to be
@@ -82,7 +101,7 @@ class LineFilterProgressHandler(ProgressHandler):
             lbreakpos = line.rfind('\r') + 1
             if lbreakpos:
                 line = line[lbreakpos:]
-            if self.writeline(line):
+            if self.writeline(filter_color(line)):
                 super().write(line)
 
     def writeline(self, line):
@@ -97,7 +116,7 @@ class BasicProgressHandler(ProgressHandler):
         self._fire_progress(0)
 
     def write(self, string):
-        percs = self._regex.findall(string)
+        percs = self._regex.findall(filter_color(string))
         if percs:
             progress = int(percs[-1])
             self.update(progress)
@@ -112,7 +131,7 @@ class OutOfProgressHandler(ProgressHandler):
         self._fire_progress(0)
 
     def write(self, string):
-        nums = self._regex.findall(string)
+        nums = self._regex.findall(filter_color(string))
         if nums:
             progress = (float(nums[-1][0]) / float(nums[-1][1])) * 100
             self.update(progress)
-- 
2.17.1

