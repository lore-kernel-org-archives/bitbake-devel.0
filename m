Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.41])
 by mx.groups.io with SMTP id smtpd.web10.16246.1604948205969378589
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Nov 2020 10:56:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Kr0ig5l1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.41, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDdy9MQE6cftjtWahtD4GrCAZVy3Q+VDbAw4oO1QzDCUCWZknEVttMws+v2V12EhEPicP/y4RkOaIBt1M472KDi++rLsMFnxnueqXTEqsO/qJLK+SHPMBcSI+GbEbjwvX3OIRXEDLxuJIzv10yMvGjfEhB0vdJaoDm7tGj3g2V7XWicq7aFS+nCjn2SVeLWoUQ5cPKKCZbfudgL5+aBgHXaQ5g1j6ewjUKhaaU1a9+rAQGX3SaV5JQJtLzubITGtOwkX3VpAitWVUNlT07HXXWNYzqAaG7t78nvEPTUXnFPik0K4t+AAQwKC9+2TApSCqvORWt2u0NGTx3hNSlEc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTuBFPmLqmWmAfrlWXpYMf1i8PP/N6G8eC5imnuso18=;
 b=fZhlj/Wic9LYtylFHBdChcLePmV2fSMDJGRJr/vx0zIoB/QxwG+YAw6mZIrwjwmBnWh6iGcIlHgCI81VC1HmGzadcJTM5ICDTCed/ptBESvcRNzzLfNxYUDtwcOsajW6iU8NcJ9k4kqYFNg1k3sMRYpbkklQOjwYNkVcWoSQqxZXB8n2p1jHenJd7uxgm+1svPpJ5xp/UdHUJoXXymKWNYSsScyOfWR6Y+R85ddLm+OicqnNpz1frf0OlQr371Fnd6r7gRlmb5TxtJfKPBduV1K8F7cVSy5r1hiCwz8n1UAQVyl9GPFSi4B+26jtbas6BISXIGPgJCe+r19/WC4Yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTuBFPmLqmWmAfrlWXpYMf1i8PP/N6G8eC5imnuso18=;
 b=Kr0ig5l1yQxL5ia3Apfqzvfips0k2kyFaG2eN5Sr3RETNLbgH4tL7g4Rtmw8gjbD9ugB0B5i6UGOckV3TC2yaIf3YCuet09keVagV9ok8OwgDDI2g96gDHOwAvQcRPlro4BxM1Uwjg9GqyivfJ/hCNOmVO/TBapx5e9WuqeiQLeo8XaCdrGEWmK1T4LfA/Kaf28TR1by0x/TRMJYWXJrjvGDGMDhNm/tcQN2OAs6ITxrzRShfI1IhHgbbttXe3e7GNhJ/JQKbfswofm8IiEOPqW04hAdXnJcOulh6OwuGyHN7a1SmGVgM8ME7HkZLIvlwqwlaQMEWSDIN5AoZFuUaw==
Received: from BN6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:404:10a::25)
 by BL0PR12MB4660.namprd12.prod.outlook.com (2603:10b6:207:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Mon, 9 Nov
 2020 18:56:44 +0000
Received: from BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::1f) by BN6PR13CA0015.outlook.office365.com
 (2603:10b6:404:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend
 Transport; Mon, 9 Nov 2020 18:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BN8NAM12FT059.mail.protection.outlook.com (10.13.183.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Mon, 9 Nov 2020 18:56:44 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
 15.1.2044.4; Mon, 9 Nov 2020 11:56:36 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2] build: defer processing of [dirs] and [cleandirs] until after lockfiles are acquired
Date: Mon, 9 Nov 2020 13:56:38 -0500
Message-ID: <20201109185638.59226-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg1.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebede198-1b68-40ce-f53c-08d884e133ff
X-MS-TrafficTypeDiagnostic: BL0PR12MB4660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BL0PR12MB46602BADE67FEEC0102981598BEA0@BL0PR12MB4660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wP3WcdNZ8RHb9HlpLtz8WX1IVm850RjVHkPjeAv4uYgvAnqLh+pTaIwXoG8y5w/BNSOSJkTXX+4SeJ4N7rzsNeWLgU/mdKwqboNG/ht/uyolnGLuEHyETj5GeAplStm/ZFtw6G7G+rQB0eZufKfUhV2wQJFGW+q6FNrTk7AvLwSqtaTxvyDzeiexfiWZqxCRfZhRoqBnPUa2rch4k5YwRPAw6pcuKuPwn+KwN0hc3A8+0j82rBon6Yf3LElCw3hyf9wqnYVOCQcp+GaLI+KkFriG9fgdCV04TEvYhm4my+Yph2dYfo9QqamzDFo0OsH0St/d29i4WdKyNBaafRV2o6mzQodVjWp4vEyrzskbGdbmJ22kX7tcA7cxdQGNfpe/UGEFL3agNr6X7KeRRHkhQmIPGYvEuq4A3kRAqke6Etc=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(29502001)(46966005)(478600001)(356005)(86362001)(316002)(26005)(8936002)(7636003)(83380400001)(5660300002)(1076003)(2906002)(82310400003)(82740400003)(47076004)(44832011)(426003)(8676002)(186003)(2616005)(36756003)(6916009)(4326008)(107886003)(70206006)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 18:56:44.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebede198-1b68-40ce-f53c-08d884e133ff
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4660
Content-Type: text/plain

This is to avoid potential races for tasks that use both [cleandirs] and
[lockfiles].

Note that [dirs] cannot be processed until after [cleandirs], since
the two may intersect, e.g.:

    do_task[cleandirs] += "${WORKDIR}/my_clean_dir"
    do_task[dirs] =+ "${WORKDIR}/my_clean_dir/subdir"

This patch also adds sanity checking to detect attempts to create
lockfiles under directories listed in [cleandirs] which, as of this
patch, would make no sense.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/build.py | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 974d2ff0..d3a43778 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -179,7 +179,7 @@ class StdoutNoopContextManager:
         return sys.stdout.name
 
 
-def exec_func(func, d, dirs = None):
+def exec_func(func, d, dirs=None):
     """Execute a BB 'function'"""
 
     try:
@@ -188,24 +188,11 @@ def exec_func(func, d, dirs = None):
         oldcwd = None
 
     flags = d.getVarFlags(func)
-    cleandirs = flags.get('cleandirs') if flags else None
-    if cleandirs:
-        for cdir in d.expand(cleandirs).split():
-            bb.utils.remove(cdir, True)
-            bb.utils.mkdirhier(cdir)
-
     if flags and dirs is None:
         dirs = flags.get('dirs')
         if dirs:
             dirs = d.expand(dirs).split()
 
-    if dirs:
-        for adir in dirs:
-            bb.utils.mkdirhier(adir)
-        adir = dirs[-1]
-    else:
-        adir = None
-
     body = d.getVar(func, False)
     if not body:
         if body is None:
@@ -249,7 +236,39 @@ def exec_func(func, d, dirs = None):
             except OSError:
                 pass
 
+    cleandirs = flags.get('cleandirs') if flags else None
+    cleandirs = d.expand(cleandirs).split() if cleandirs else []
+
+    if cleandirs and lockfiles:
+        # Sanity check that no lockfiles are under any of the cleandirs.
+        # Since cleandirs is processed after taking the lockfiles, we want to guard against deleting the lockfile's
+        # enclosing directories.
+        import pathlib
+        for lockfile in lockfiles:
+            lockfile_path = pathlib.PosixPath(lockfile).resolve()
+            for cleandir in cleandirs:
+                cleandir_path = pathlib.PosixPath(cleandir).resolve()
+                try:
+                    lockfile_path.relative_to(cleandir_path)
+                except ValueError:
+                    continue
+                bb.fatal("Lockfile {0} cannot be placed inside {1} because that directory is set to be cleaned (see "
+                         "[cleandirs] flag)".format(lockfile_path, cleandir_path))
+
     with bb.utils.fileslocked(lockfiles):
+        # Process [cleandirs] varflag
+        for cdir in cleandirs:
+            bb.utils.remove(cdir, True)
+            bb.utils.mkdirhier(cdir)
+
+        # Now process [dirs] varflag
+        if dirs:
+            for adir in dirs:
+                bb.utils.mkdirhier(adir)
+            adir = dirs[-1]
+        else:
+            adir = None
+
         if ispython:
             exec_func_python(func, d, runfile, cwd=adir)
         else:
-- 
2.17.1

