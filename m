Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.68])
 by mx.groups.io with SMTP id smtpd.web11.21097.1596210212646406204
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2020 08:43:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=mP1hJg/g;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M84vRd07kmbKdVjsxfEp1HXZImfnf9HQ4EomqAdpPucxZNPdIn1snRdsUreZ+51Yn62FZfGpwGPeHZfdBSn2I8kmXovcsQ+geW35GoByVGpTbPYZsHzcoZsD08nSDtc/m2vK24WCIamFpcKFWPbrPqiot1UzNdrkzLok5CxIw5rfXP4EXtDxRQ2BR6S8IvhdRcgpJJbSTGLbz34dEKSfosbnMBak565gYXIFVLyL5YWHoibZZIOLSsUOzgYIs6B12467uTwUIIfW8uevHQHv0vG/wor3uo4Osq3f++r10n81ntAbF9rZh62B5mZB/ewy2EzUWT6LQQcVu3hdb8IibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO6aDo92ROtBNE5g+jrYcmZgoLZjLuBjF+LU8WELdf4=;
 b=Q5zQBuq6K3EuzDtYWkLD99mdvvmSTkoGKMzUuBTTn13Qwou/PxC6pgjaDf24slrerS/Q5jMdHFLSMrTgG/Vq3S4N5QP8BR5azR0w+4uUMNfCqUAU2XdKc+eoszRBFWcTtpXlhzqK7NrtQjw01FmQfA+cBwKge9qNd7owRB0uiyWDRYZEhD5L5Gqzix3k9IUKqePzyfCMUjz3CZBHdWdMULEmbpCXCMovX0i9sDOrQ++TlK8MLM007L0I/PH/zC+keMqGQDVOtCUqwQx+8J77oJxE7dO4MAfKMp0+Nxuf3eb5be7ld1E2ycM7AHmzFTFiscHbrAFvA3nX67/UEmWYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO6aDo92ROtBNE5g+jrYcmZgoLZjLuBjF+LU8WELdf4=;
 b=mP1hJg/gfRYTmUwadaGP1Rd1AVbrzlb2XHGTC1MiW09j/pEvSqmElvK4j7BLYJ0a3bQ4aiCbZPzCo6e1NcdgoxLWx9qx4dL6cgCayrsiHq5WrgtvfiUykinlninIR2m/+MNTCho5HGPHEhk67cbLqzArbzgZILY8BdkFP5XDZDWBYexFtN7dt/9vj11dCyzKu6lL90kOsLXWDUYl60zFYxYzoCXDJLiho5DOtefOc09+5z2+rOchm/wa3bDtOLHX8Fnxvdv/TnENuLMXfsD64zPl0CCRfX0YJg/VhxHFMUdt3kR4puNqvcaqHouKCjjS12SFBP3kB+1u0SqklWLe+w==
Received: from DM5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:3:12b::16)
 by SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 15:43:31 +0000
Received: from DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::d) by DM5PR04CA0030.outlook.office365.com
 (2603:10b6:3:12b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 15:43:31 +0000
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
 15.1.1713.5; Fri, 31 Jul 2020 09:43:28 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 3/4] progress: filter ANSI escape codes before looking for progress text
Date: Fri, 31 Jul 2020 11:42:48 -0400
Message-ID: <20200731154249.89999-4-chris.laplante@agilent.com>
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
X-MS-Office365-Filtering-Correlation-Id: b49aeac9-c94b-4810-121a-08d8356879d9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SN1PR12MB2528E9D3F806912E175FF9488B4E0@SN1PR12MB2528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4bQKdwPP1ct54/1aOggdmIGMPAOf8J99lfYKjEavZV+hQkA8eloWKMXYmmCeYkR9w61dBCCVHwWue5apvATltmd3jMdr/UtCxEoTj7WY4n00R7JGsZ+UBLdLMHbgAAh+DikPeuY9f3UrcGizTiQ3jn/N1v6E6RT8lI60xgW5Ht/UENO8o6fuY/j9j726/JNaw/OmMr1CXvHbkw/Ci6NMX9T8u/+1vgobdiJmJn0bUlsRAPMFXQTXjExwI8Decr76Bdkz9uOzye4DMaXm35EFUrNdpSlgJs/t40QJ+/BCHyu82PwgodDDG23bZEciLuoYV7ZJ+WBd79v+nT7HjEyax/8bWJByiD07QECPK9wF60zcalENvaCsMA8Tgg2hvJvivNH+62122Dck/23rI03cN4F2/WYjo+XOoqPHqwiX+mZnqKGSe1tRQgPhXAdd+liPVDB/4RW4jRZUEN0a4Uy6YtiF8LJH+Oo2jQl+V3A3gmeby/KHMOHRtbp5WXb1yy9y
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39860400002)(396003)(29502001)(46966005)(6666004)(8936002)(956004)(36906005)(1076003)(2616005)(356005)(7636003)(426003)(107886003)(8676002)(70206006)(82310400002)(44832011)(86362001)(316002)(36756003)(47076004)(82740400003)(6916009)(5660300002)(83380400001)(966005)(4326008)(26005)(186003)(478600001)(2906002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 15:43:30.8835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49aeac9-c94b-4810-121a-08d8356879d9
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2528
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

