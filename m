Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4507EC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 06:50:26 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.52])
 by mx.groups.io with SMTP id smtpd.web11.1811.1742453415646210708
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 23:50:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=mqlpOjG1;
 spf=pass (domain: axis.com, ip: 52.101.67.52, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqI15WmLm0TB5ECdF2cGcajSxLAO1hjpNsJNC8K9lx7RWWJf/DsItfSLkJ3wcEGIdLJCZmp1dGg+AUBSPsrOTX8TtJAfwGqwe0tLUWLwUiaMGGKiJQdsf69unVaJRfHRVoGJQnjdVOsh44v/EpECGLWVC+CWR4cWaaD9VjtvyV2NVBwVAPs+HI3fFOI4lJnPHRgS+YGGPKdfoV8qY/SMBATjqWBGtRd+GrzXbxMGx9+TnNrZ4qbSOb2dvRzvOf1Q+xMRBTzcMP83QBNlhy+rE014DhjLsBtkt747C1KJzPJxCFXv+nfoWx0yQZJAXTbg+jSzIdr1aX+FNZ7W9kF13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfcYrNDqntmo9edRCzapiq+koHJDzwg+DjbR4PS8HJg=;
 b=Q0MeWA5jfP2aeqm+M/0eKPCL7rcknYYZyctqFmHw0s2zFcJ4DuDeAhdY7+gpckCWDBoul5j9Xg5ESqjrsCTnq+vXyHbhJ1iwFmlkOfoEV2fw0q6tWvNGrhdu68zS6FTy5QBA53M9HqwpjdX0XJ1LJWzIghG4vVtFBHSSWnnLU1gWmapc+j796FlCi9+Y2eC1i0kpe0Bs0D3K4RzJpIZ01+wx7fju3w6ZAt8pZ8zYGNEGcT+RO0HsnwowAfHgxCqCrObzWfytb/krZBayMn3wf5W/eIvdDrdQHmAiA6O2VisakU1pSwNHGle2KZGoW24xGdrbBp0948VFquDMs2HL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfcYrNDqntmo9edRCzapiq+koHJDzwg+DjbR4PS8HJg=;
 b=mqlpOjG1lI+yyhwiwIA1eU9BF8H07NoXPVaW51ndsNTb7qEm9Xfn2z7ILUGMo9NjR3JCiVGmd9vp6riNsmL7QZ/QkNw7j9UekEm7uoKu0SLvVvDY3QDeTIZU5ITvEl5gEyMiKcMpab6IPSTl93oidj0/1EWj/6QWuQOwte3Wc9c=
Received: from DB7PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:10:52::46)
 by AS8PR02MB7769.eurprd02.prod.outlook.com (2603:10a6:20b:440::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 06:50:12 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::4f) by DB7PR02CA0033.outlook.office365.com
 (2603:10a6:10:52::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 06:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 06:50:11 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 20 Mar
 2025 07:50:11 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 20 Mar 2025 07:50:11 +0100
Received: from pc50740-2234.se.axis.com (pc50740-2234.se.axis.com [10.94.131.4])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 46E34E1
	for <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 07:50:11 +0100 (CET)
Received: by pc50740-2234.se.axis.com (Postfix, from userid 21184)
	id 431EC26B9749; Thu, 20 Mar 2025 07:50:11 +0100 (CET)
From: Christian Lindeberg <christli@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/gomod: Fix mirroring problem
Date: Thu, 20 Mar 2025 07:50:11 +0100
Message-ID: <20250320065011.1560156-1-christli@axis.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|AS8PR02MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0357a1-2139-47a4-a35d-08dd677b762f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZoObM4u5zCejLSaLyzH7KmnnyJs0+W7J15hslr+w/kVj/I8gfCJA87LMWDhU?=
 =?us-ascii?Q?yJx0p8OM+o/JS1r0xXDl7H3dU5IPRHf+7qt/cRqxKPUCo/O3Nx53QXIk4/Qg?=
 =?us-ascii?Q?puBXEtwdtD/1vkaE745ZO3EEmUNuiofeimEomEiprCZsyM/27I9x/SaN5kaT?=
 =?us-ascii?Q?EHSV/UlTxMU6ByfhzyIdxizJmbXSBJFsTujXL3DGkxWa6HmxMrLjPb68ajD1?=
 =?us-ascii?Q?pgl4kgFNsLk+oIzEWiY1WQwIilklHJwCh85VJuy7j1WFX8Z1rEsfn+QmjigC?=
 =?us-ascii?Q?/NNv+2X4Z+stJrSBfObwD/uXtfskpPEq9vrofV+/7Un8mFwk5AsxUlIoiy4b?=
 =?us-ascii?Q?9w1IocYlYwO5ffS5bPD9PORQqpY/6D9hLkbrX+l2dxOFUEomffCJlUSmtKpd?=
 =?us-ascii?Q?th0E9D6Ez/JM7+dLn2IHR3m0P7WBEOSDQ7f1snRmuoiAak4otj9VTrIsagoW?=
 =?us-ascii?Q?NiLTGGDT9Ylr5C+mBASrRb+k3hhEBxCMflCV0U/bLZOr4FdGERBDm/Xjatcq?=
 =?us-ascii?Q?fY6y1RRtDciOjPQii5S+FTVuqaF11qZ9sV8Qo24btOXUA1E8z5MnO2hdbDyo?=
 =?us-ascii?Q?hR6RQH5EoKV2NuyHquAag9FgDe4XcCZq+QRGGucoQIq6taXrWfP4QFWD5ZFy?=
 =?us-ascii?Q?wxxCS5zerTyVO8v+AYl7f+PWkJBOCtzjd5Atc6NvCcvAJsQi/5ymY773ddZS?=
 =?us-ascii?Q?Upg9wzFG62cSpBrmw8cRKhDmYAoG32vH2G6swqvm2EkA5EgdS4g47Z70xMpi?=
 =?us-ascii?Q?EhslOO4dS+e70zT2p05fGnwe044FXQoBLLAKy/1fhTf4EhZjWYatOzHKgbKC?=
 =?us-ascii?Q?ICuT6xUJ284fNah+JuouGW95bnhpfpqcu+H+hbXRheWZMxAyj+BSHl/gusQ+?=
 =?us-ascii?Q?mEXy5VZDtWwVP5izmo6xqhnVejqzMUuNwb5w4brywnNkiJqPThRWGPzbMlqh?=
 =?us-ascii?Q?7s98VymaAbEAo7kSbPJIR7vK6utOUZnN/gQV8LYdDkfaOdec22D3t0nd8Hsg?=
 =?us-ascii?Q?WHHXVsGdIOwXXC12Qunr4Tu2sXjq90feEqF9xtvhciJrBjw6s+vdcxiNEmnW?=
 =?us-ascii?Q?ErOCsYOC25TsRvr3ANHLAhW/MvYTUxt1gH+wMjeoqGoG33m7CpG2hfqp7s0m?=
 =?us-ascii?Q?4m7YxYDX/W9eojhR6rQFq+1nCSx6ThwMP2DxVD97nC8cRbYwodEIyWk0PHVF?=
 =?us-ascii?Q?i8DhvFhwYcIeWd/XyZ7GrkeO1Ofgm8CQ8x7uR+i87Rt4p24jP4hQK4uRkvsJ?=
 =?us-ascii?Q?A4tpjM0qjpO0zXVHdY+46WWJ/bugEmR1lpPLyVCYkMDE13TItI8GCSkmu95P?=
 =?us-ascii?Q?wAMogqP/iyfVhNpnoS9BTP18sv6CPTcxUI595bb5c46eQqdPjPDgnLF0KBCp?=
 =?us-ascii?Q?rc7qzE3eB8YH2Y7uy7mOZIW8oQwfzNsvEKfEUmaHY7qHu8Hld9a69lGMTxly?=
 =?us-ascii?Q?gT5s02BH8/w=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 06:50:11.7325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0357a1-2139-47a4-a35d-08dd677b762f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7769
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 06:50:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17476

From: Christian Lindeberg <christian.lindeberg@axis.com>

Build the 'downloadfilename' parameter by replacing path separators in
the module path like the git fetcher builds the mirror tar ball name.
Copy the downloaded file in the fetcher's unpack method like the crate
fetcher instead of calling the base fetcher's unpack method.

Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
---
 lib/bb/fetch2/gomod.py | 35 ++++++++++++++++++++++-------------
 lib/bb/tests/fetch.py  |  9 +++++++++
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 6c999e8ba..933a897c7 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -107,23 +107,23 @@ class GoMod(Wget):
         if ud.path !=3D '/':
             module +=3D ud.path
         ud.parm['module'] =3D module
+        version =3D ud.parm['version']
=20
         # Set URL and filename for wget download
-        path =3D escape(module + '/@v/' + ud.parm['version'])
         if ud.parm.get('mod', '0') =3D=3D '1':
-            path +=3D '.mod'
+            ext =3D '.mod'
         else:
-            path +=3D '.zip'
-            ud.parm['unpack'] =3D '0'
+            ext =3D '.zip'
+        path =3D escape(f"{module}/@v/{version}{ext}")
         ud.url =3D bb.fetch2.encodeurl(
             ('https', proxy, '/' + path, None, None, None))
-        ud.parm['downloadfilename'] =3D path
+        ud.parm['downloadfilename'] =3D  f"{module.replace('/', '.')}@{ver=
sion}{ext}"
=20
-        ud.parm['name'] =3D f"{module}@{ud.parm['version']}"
+        # Set name for checksum verification
+        ud.parm['name'] =3D f"{module}@{version}"
=20
-        # Set subdir for unpack
-        ud.parm['subdir'] =3D os.path.join(moddir, 'cache/download',
-                                         os.path.dirname(path))
+        # Set path for unpack
+        ud.parm['unpackpath'] =3D os.path.join(moddir, 'cache/download', p=
ath)
=20
         super().urldata_init(ud, d)
=20
@@ -131,13 +131,22 @@ class GoMod(Wget):
         """Unpack the module in the module cache."""
=20
         # Unpack the module zip file or go.mod file
-        super().unpack(ud, rootdir, d)
+        unpackpath =3D os.path.join(rootdir, ud.parm['unpackpath'])
+        unpackdir =3D os.path.dirname(unpackpath)
+        bb.utils.mkdirhier(unpackdir)
+        name =3D os.path.basename(unpackpath)
+        cmd =3D f"cp {ud.localpath} {name}"
+        path =3D d.getVar('PATH')
+        if path:
+            cmd =3D f"PATH=3D{path} {cmd}"
+        bb.note(f"Unpacking {name} to {unpackdir}/")
+        subprocess.check_call(cmd, shell=3DTrue, cwd=3Dunpackdir,
+                              preexec_fn=3Dsubprocess_setup)
=20
-        if ud.localpath.endswith('.zip'):
+        if name.endswith('.zip'):
             # Unpack the go.mod file from the zip file
             module =3D ud.parm['module']
-            unpackdir =3D os.path.join(rootdir, ud.parm['subdir'])
-            name =3D os.path.basename(ud.localpath).rsplit('.', 1)[0] + '.=
mod'
+            name =3D name.rsplit('.', 1)[0] + '.mod'
             bb.note(f"Unpacking {name} to {unpackdir}/")
             with zipfile.ZipFile(ud.localpath) as zf:
                 with open(os.path.join(unpackdir, name), mode=3D'wb') as m=
f:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0c87730c5..40c8448d2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3431,6 +3431,8 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.zip')
+        self.assertEqual(ud.parm['downloadfilename'], 'github.com.Azure.az=
ure-sdk-for-go.sdk.storage.azblob@v1.0.0.zip')
+        self.assertEqual(ud.parm['name'], 'github.com/Azure/azure-sdk-for-=
go/sdk/storage/azblob@v1.0.0')
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3448,6 +3450,8 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.mod')
+        self.assertEqual(ud.parm['downloadfilename'], 'github.com.Azure.az=
ure-sdk-for-go.sdk.storage.azblob@v1.0.0.mod')
+        self.assertEqual(ud.parm['name'], 'github.com/Azure/azure-sdk-for-=
go/sdk/storage/azblob@v1.0.0')
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3462,6 +3466,7 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1=
/%40v/v1.67.0.zip')
+        self.assertEqual(ud.parm['downloadfilename'], 'gopkg.in.ini.v1@v1.=
67.0.zip')
         self.assertEqual(ud.parm['name'], 'gopkg.in/ini.v1@v1.67.0')
=20
         fetcher.download()
@@ -3480,6 +3485,8 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1=
/%40v/v1.67.0.zip')
+        self.assertEqual(ud.parm['downloadfilename'], 'gopkg.in.ini.v1@v1.=
67.0.zip')
+        self.assertEqual(ud.parm['name'], 'gopkg.in/ini.v1@v1.67.0')
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3497,6 +3504,8 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/go.opencensus.i=
o/%40v/v0.24.0.zip')
+        self.assertEqual(ud.parm['downloadfilename'], 'go.opencensus.io@v0=
.24.0.zip')
+        self.assertEqual(ud.parm['name'], 'go.opencensus.io@v0.24.0')
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
--=20
2.39.5


