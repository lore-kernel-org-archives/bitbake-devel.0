Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.45])
 by mx.groups.io with SMTP id smtpd.web09.5548.1604416633401517036
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Nov 2020 07:17:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=1zjwpk2s;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.102.45, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdA/ucJa/IhdIaSeC/THKSed6uIt/s1EYiIMOg/D+AHXc3JeWOldDiFRlPsseYFvS9RRpL41bFpK0Ym8ffhlOyqTyYwPzg3dGc3otZXcG5B3pC7tlE3hrTv1ZfjjjXe0uCWtfNqdTygGdRvIhMNSGMSKEw+vTyWHjyrnonWcGtjcU4cfYIWKFjWxiMwYyVfzjzhH0n/T1LEMvC/WybvGJSnCMDW5fygom76eJW4Tts80jViXFLLtVU0APn6KLYGCQtCkhUw9f3qv837++nwvVK9YQIubnPX+NJdslqZl8BMOTJmaBC46hSi+tgkmsdW0I/mH93cNqwnNDLbcfCpchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwJIOlQZ4R6n4JQzJaIh6Ie3xKwXZ6fRoL/oH3YJIRQ=;
 b=XzEQxiWvUrfARwIltB5Tq9JFUUCbeAbX0AtfhPmI/VsvnHNX8wO1TeTj/9d1SBM6h9WlLstgBP+S6TqWJRKpuj3xm2R29o7NAMR8rGzx7WLuzEdsG28Nh04X4ZbANNjsJmEnoWhPSmn9KKYFx2hdvooBursr6zRnSzJRypOL/6qQnwTNiLzBMPj/N6cI+zp20NwxxeMffzZRz1a7zRjQR4RQJUGC1xT/vprVyV2UoTl6JXjGB45jyTn1ipSCLl47hStZD4l9/9Z3DOcQPmPJ/jm5MzYBD9UoR3i4x8JHT9zpECTrlD+VyZ5KrRTpOMx9JahNCo+IGdJUI65EmL9ilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwJIOlQZ4R6n4JQzJaIh6Ie3xKwXZ6fRoL/oH3YJIRQ=;
 b=1zjwpk2sHeHDf/K+uWsrWL1pWqwpzIqfAlaOpmH+HYlXIVcVu55wbjT5zalm/r8SpPF77gYmDCykjvKvquYchc9KGkQF3eGPycbOsAbre64TZ0jtF/DAVzFy+HJbRic3duyaCRaKRneNkCQlMOubWxc57sR6woUiDU+ujJjKxU1gDByrLlIqCbXcu3yuznZJmIrw0hrg4sNw8iABsvy5IaT7kUsKBR/m2r1xTdlCkoeZUbjqzVBR1IH+N8ueUf3DVQEbyoJ7hcElGcbha1LzWkI1qSO9mgqppEqV0oYgxh+DHV5iFTxLSo1IJm4x9epd1QxWrejm/yLFT9rmQ9u7Zw==
Received: from MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30)
 by CY4PR1201MB2469.namprd12.prod.outlook.com (2603:10b6:903:d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 15:17:11 +0000
Received: from MW2NAM12FT036.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::71) by MW3PR05CA0025.outlook.office365.com
 (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Tue, 3 Nov 2020 15:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT036.mail.protection.outlook.com (10.13.180.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.9 via Frontend Transport; Tue, 3 Nov 2020 15:17:11 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Tue, 3 Nov 2020 08:15:54 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] build: defer processing of cleandirs until after lockfiles are acquired
Date: Tue, 3 Nov 2020 10:15:37 -0500
Message-ID: <20201103151537.19348-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bcaab64-96e6-4690-966d-08d8800b89ae
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CY4PR1201MB246932EF255CA016B661F8848B110@CY4PR1201MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qiQ7LDewkHW71q9atmr74mbGhmXBAxPABWTry/te7ObinZWaPrRgYVq3F+2Llw9MbHiBspjj26G/LXpCt8Z6ZRaka32fijmnE3WPEN385oePyGgKpZjx4B3ZVQmUSIWf9jVsqHTR1Dj3jGhc28ocyjbQrffndQNrZcrT87yPPWCggsx5Euw7MKNh2Z/oUF5BD9vrYaJwW8CBj1fdp+o2E2ekNbPTRK0tVYiLvcTJ52Teq9VxNiO8LkeXi3hZQd0cjt+wW7F5BibDindGHsXA7C9LvQVvIVxdXAGS8jLNVHk7kdGlAoNsldEFacCVcAri+mm+LqZN4vFymazOT/hUChs+hx2JwchiNy18I95xImjuF4Fpv4FNxbTxWxoJSUQNRl1i4b7FEFev/8cEBvamtMO03Tfk0ON93wS9n8fW5vA=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(29502001)(46966005)(36756003)(86362001)(36906005)(336012)(2616005)(4326008)(44832011)(356005)(8676002)(1076003)(5660300002)(6916009)(8936002)(186003)(6666004)(26005)(498600001)(82310400003)(83380400001)(2906002)(426003)(47076004)(7636003)(107886003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 15:17:11.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcaab64-96e6-4690-966d-08d8800b89ae
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT036.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2469
Content-Type: text/plain

This is to avoid potential races for tasks that use both [cleandirs] and
[lockfiles].

It is currently believed that normal [dirs] handling is fine as-is.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 974d2ff0..51bcad96 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -188,11 +188,6 @@ def exec_func(func, d, dirs = None):
         oldcwd = None
 
     flags = d.getVarFlags(func)
-    cleandirs = flags.get('cleandirs') if flags else None
-    if cleandirs:
-        for cdir in d.expand(cleandirs).split():
-            bb.utils.remove(cdir, True)
-            bb.utils.mkdirhier(cdir)
 
     if flags and dirs is None:
         dirs = flags.get('dirs')
@@ -250,6 +245,12 @@ def exec_func(func, d, dirs = None):
                 pass
 
     with bb.utils.fileslocked(lockfiles):
+        cleandirs = flags.get('cleandirs') if flags else None
+        if cleandirs:
+            for cdir in d.expand(cleandirs).split():
+                bb.utils.remove(cdir, True)
+                bb.utils.mkdirhier(cdir)
+
         if ispython:
             exec_func_python(func, d, runfile, cwd=adir)
         else:
-- 
2.17.1

