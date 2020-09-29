Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.71])
 by mx.groups.io with SMTP id smtpd.web11.731.1601392496082054462
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Sep 2020 08:14:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=tniftulx;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.71, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDvhKYfY5IYsa9PHvfOr25vMhUGCvdA5j3f+TH3zzOSPwnOp1/HlU4LjgvfaLpJZF584iTNWapTTtPhjsyYIp2dU2TkepvoPiB0N+S+uv7kBOZacFNERHSPczG4U2E/wwtGdh5Gggyjt5hV3U4g2PwhXH4B7uf1+Xjcs0k4VNdOZX8ZSp4JCGvIbHSFZqJXn4JYV05VVqx0/azcLKf9s2o/8wLRLX1+xO/feJNbnigPvLTCrnRECvYFB9bRQbhEuCLSCZPfwu/rymE+MwAvIgS6WrWreCD4e1UDYbr3/8jE24blRgBBkLdT95sYDThTvGeCi5RZURR3g6WHtZ0GSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwJIOlQZ4R6n4JQzJaIh6Ie3xKwXZ6fRoL/oH3YJIRQ=;
 b=j/TU3Sp9HTAwCpFj5T5EGBKn4tAx/wnjfRMMiA66yCUXpt7ohVz2IcP71FRFzc4DTbJJx+wxfTJLyqBMOhrWKEn6l8IZ5v5dP0AA2If4YaKHvDSXMyd5+qmfeedvrcjfXe1RR00D5Yoq7vh5r3sfqJ1dVPVZPEWnjw+QVZRbO2xkNmSbqo51ddnC4zkP0JN88afTTEmEOQCMBxzYbyVHo0G4Fbcx9DnutSaHd1TIkmCNM8z+GPYQD5IIv2aQMGDTXuU6omWIcRIY9Pf7ZRRDnuxs70lmEt8WCZANwxoAkXzUSCtcAHuD6PBKurRC+6JpuFJ5DtNmOwhwa9lp53NUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwJIOlQZ4R6n4JQzJaIh6Ie3xKwXZ6fRoL/oH3YJIRQ=;
 b=tniftulx+WyjN4Lzia5onKy7Pq8eBFL3uCLf7WwM5b18PoGjPm6LxAGr9TBKeBhv5uamXy6Q7HWyALRAUcBXXfBHSmBodzUk7DyRkSgzjHooVptgV2pThg4msVcX5VSt8uhHrG2RYg+CaPNMRkbFXUEau9hGwazngrvLLBV0JtNIHidAgny8JTdrPFaO6kJxC0Plw/YXt6A41w2tfUfY9WLXL/KTODrVusjHtIvqCP1itx0+U/SgGdCdKyJrMn9z5PjybcKzRDw4yvQNQt8DytgC7iPkyg+Ot9t37w8UPoQJuJCEsESn6i+BNkFJt6UTVs4SIEq4EF6DJ/DjitJn/A==
Received: from BN6PR20CA0065.namprd20.prod.outlook.com (2603:10b6:404:151::27)
 by CY4PR12MB1158.namprd12.prod.outlook.com (2603:10b6:903:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 15:14:54 +0000
Received: from BN8NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::c1) by BN6PR20CA0065.outlook.office365.com
 (2603:10b6:404:151::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 15:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
 BN8NAM12FT003.mail.protection.outlook.com (10.13.182.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Tue, 29 Sep 2020 15:14:54 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
 15.1.2044.4; Tue, 29 Sep 2020 09:14:42 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] build: defer processing of cleandirs until after lockfiles are acquired
Date: Tue, 29 Sep 2020 11:14:37 -0400
Message-ID: <20200929151437.101901-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg3.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42f31035-411c-4bfa-985e-08d8648a6b98
X-MS-TrafficTypeDiagnostic: CY4PR12MB1158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CY4PR12MB1158CB81966D5CAD024D41FD8B320@CY4PR12MB1158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/QuUke1n3CKDcG2mKAnXg/8k1Rd8tu6VD49Gu+VF2DJiw9RoWjFFXynm5aYE1c/uNhj+qcyj0dSnxe8YbYdAl77wPl0RHoZYFB5r+/WXCiV++1kzHnI0VZ1GIz32Cm1SptwG/LSINqxPUtvaLRGPY+5S5R5Xw5CwtwxgyM1KJaofzFfsg9R9XnkeWs2rdhcezdA95/kQyQKDN+Sjbie3xZ/iA6a4pCncz7fMFYm6ZJc+K7btzDHQ//azWjNwHruwLULrOawZXXXNijZt0d/xCpT5Lr6eu/AP+2DxfIDAw6u718WpcxgUrGrWMXb7sSpk59hQ1jM30k2gtUNC3+ON3dM4STglDkYNkLhJbPkdB1OKjo5zmgXuXiCMByLqwYukWOOHM7nrL1yoNUPP5E8uBlb7ILZQzp+dPFS9C5qzqfm2l/6zseUgMkvxAsDxNJVxSorhO6btVZ9VlilNZPcKkIumVp3O24MFUAlRkZBna6Y=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(29502001)(46966005)(26005)(5660300002)(6666004)(47076004)(2616005)(956004)(44832011)(1076003)(336012)(82740400003)(426003)(8676002)(4326008)(6916009)(8936002)(82310400003)(107886003)(356005)(316002)(36906005)(83380400001)(2906002)(478600001)(7636003)(186003)(70206006)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 15:14:54.4753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f31035-411c-4bfa-985e-08d8648a6b98
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
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

