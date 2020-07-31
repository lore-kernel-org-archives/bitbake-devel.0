Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.68])
 by mx.groups.io with SMTP id smtpd.web11.168.1596234890104750377
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2020 15:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=WbNLCJUs;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSPjAZk4NzK7ALUAJ07fbMroN6BGlSV0HBqTz1d2wywnJKCH8IxrT7bTtRZ3axLZRZxij99LpJQ/eUkjph8G12drwiziwQLo4/kPgNhdKRVRbCZHik2xHiR4mLpVeIQbl+V60fMsbojEU/69LfTBc4mbSVGBdu2Dw11n6xFAwxNKTiq+m5i/Z3g3ZHWfII0Oj67aWwgYXo8j822SeZNx37xLF0lET0bjlvp04m6Yu1U5jfEwL+7dOJLIofuvGOfLFlxA6oo29K6LyaASZqfVHYf/0AmnGMbxo/SY86f9Fd4UQ1DoktBt9QZljTMCv04QtzDTuaOQb1pBo6RRPfJt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0msclTf/Z18vYk5vmxMZ0hxpHGWIWQZOrg+vJEa0dk=;
 b=M07Ff+UhsWPdwVUUqWvY9IlS4arpZlMQCmNubW7zJUVA5t37jWM8Vjq9nOXp4Ex630CigtlE6VTommlq/rpl4Z6yhSvckvetYu++NfNUfECvBbuHO9xjOd7vyH0Oj9oxANpyIp60n6vYiQGtqzHSq6SsEMF77ZLz+103dCg596Atz4ji/VeZezKQTtuoTyW4UNYzmSBP91axl5IZSe6PFV42FAQ0T1Ie6O0mk8E+fUlGe5bsiKVqBjVuCo8BuU/tmfdMnxxNxUJPqx5T5Ob8iXFJC44pkP0vxWewGRCBENbixuRZ2CjFOV66YScPzEED7mUb31+dLMst+FfqmPwmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0msclTf/Z18vYk5vmxMZ0hxpHGWIWQZOrg+vJEa0dk=;
 b=WbNLCJUsLjPVZdkFELiYZrPtnb+C7q9P2+nQ6SLuFwEFHm2h0gSgd/HHxEqSE6/mnGfJ7gTNDw1p5avWFLBNrPgPNJZB7sDHmwCWmt81lufy482lxg5xwn20aqptUABg6pwPgLZxjJGexsSsH88KO4sPJEoJbSr1v1uM4J1KBsouNOgX8dohNTJDkwNA2eOAO45LjfvDiVTHVlLFAT2PnpoamawZaZ4V+spRNsIw0vWPxpbYoUqBxTFAgaF3xxmIPh5sLLWZwXzxlU/dHYzDqwi6sv+tcoZ0Pcjz1OEeKY6w0fdgzsb3TU9A47P+z9plwJN7zaZiWz/slAuS20G1iw==
Received: from DM5PR07CA0101.namprd07.prod.outlook.com (2603:10b6:4:ae::30) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Fri, 31 Jul 2020 22:34:48 +0000
Received: from DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::e5) by DM5PR07CA0101.outlook.office365.com
 (2603:10b6:4:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Fri, 31 Jul 2020 22:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 DM6NAM12FT006.mail.protection.outlook.com (10.13.178.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 31 Jul 2020 22:34:48 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 31 Jul 2020 16:34:46 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] data: emit filename/lineno information for shell functions
Date: Fri, 31 Jul 2020 18:34:41 -0400
Message-ID: <20200731223442.102095-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb215efd-8d02-4c01-be03-08d835a1eead
X-MS-TrafficTypeDiagnostic: DM6PR12MB4372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM6PR12MB4372F4D37B7236E6371DB7918B4E0@DM6PR12MB4372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gFLGRCaLZJEDLM9mPP5EUpASsMwrpu+Q739zzkvue3b0H1wfggxnlGCZ5JDvd1Pyucnk4z6OCsaj/SFmL2iP0Nv8l3WcysWYNKacjlhXQaumjFZNRuTyeo5R8NcyEIYaF/QtlAsqkQWgs+LP2xyTk0Tk307VGfH7HZCOLekmoiuaHfYwtyAXQYP0KlQrNukwdRDFU7xwiVfHbp7AJlmsOa3m6KItfZUyw49ZPd6mwtZqrxMWAlEsBD2KGy9JdezpZKAcsUSjygZ2fxIJPRy0tCLb4QR+acOLj5r6D5rIzlaxoGp4ZR04quizYXpaOzC0kgyDW9egc+QxIlMkX9HUs+lf3H24LtPGWARkzyfRedXujgx4DcfnAaACq0eFW/nqlhEuX32gNH+DS1XeNU4PexBrtdXbhDHE+zmlNyj3jVM=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFTY:;SFS:(136003)(376002)(396003)(346002)(39860400002)(29502001)(46966005)(5660300002)(2616005)(336012)(6666004)(2906002)(6916009)(426003)(956004)(36756003)(44832011)(8936002)(82740400003)(26005)(1076003)(356005)(82310400002)(478600001)(4326008)(86362001)(70206006)(7636003)(36906005)(107886003)(186003)(316002)(8676002)(83380400001)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 22:34:48.2146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb215efd-8d02-4c01-be03-08d835a1eead
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
Content-Type: text/plain

Make it easier for users to debug shell task failure by including
some breadcrumbs in the emitted .run file that (hopefully) points
to the .bb/.bbclass file where the shell function was defined.

Unfortunately this won't work with functions with _append
or _prepends, since BitBake wipes the filename/lineno information.
This shouldn't be too hard to fix; for now, you'll just see
comments like this for such functions:

[YOCTO #7877]

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/data.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index b0683c51..d71e2fb4 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -161,6 +161,12 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         return True
 
     if func:
+        # Write a comment indicating where the shell function came from (line number and filename) to make it easier
+        # for the user to diagnose task failures. This comment is also used by the shell trap that build.py generates
+        # so that shell tasks can report better line numbers in case of errors.
+        o.write("# line: {0}, file: {1}\n".format(
+            d.getVarFlag(var, "lineno", False),
+            d.getVarFlag(var, "filename", False)))
         # NOTE: should probably check for unbalanced {} within the var
         val = val.rstrip('\n')
         o.write("%s() {\n%s\n}\n" % (varExpanded, val))
-- 
2.17.1

