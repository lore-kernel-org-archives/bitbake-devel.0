Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A6C36000
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 10:19:57 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.8])
 by mx.groups.io with SMTP id smtpd.web10.3920.1742465997040012999
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Mar 2025 03:19:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=XN5pm/g0;
 spf=pass (domain: axis.com, ip: 40.107.162.8, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9/kX8pYwm/cBCRfm9UiYaaVnMi8uTSe4zgrKciDZTeEEP6ni+rWYo6WjBLOs3KoebudsMwJRbPOnVgBTI+c+IRsKsPd6Gnej3GI/dBtg2M05pKEWQkyLBhRc33ZBV0WiQ2qDQtI763tsvs4rmSVwkoQX2pc5qwh2d21R1M8L1ByMIh2F/XNWAxDdMTBv6UXsH/ellXEU04vLHiW2qUdzbSyUwPi9QgOgibrLEhP5svmH84tDvSB5Q7zkiP4gyDtOsYk7RoFeZMdJxCVoZDDEE9iTqRZr5V46d2gABgys9WENWFlwYTCKrpLM4hOmmOZXh2NjiEw7HuX3iCjD0DmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shQaoul6vyfqn6rvt6n345FFYToHxlUgtHlH4eq7yy8=;
 b=IouAeEoPAcVqJAS1KL1KKlNiwU5Liyv/5Ox4qdj101/7X8WNFTRm/TJzr+wEcOTRhNijSWRFj+s51gxa66eFSRdzKXwil1l/OAXyCaT4rpuy1f819awIFiOaBuyqO/h1URtPuYquDgQMO7w4EKTByans5FRYGGWlblsPLT740BjBPGZ6BeWwxqtE+WIPrZrCm+0RHD9T1SRiE8bD1/dIVyc5tna0legzjPD5L6Mp859JyfC0BI82hzNvttqxukr/WxVDiyoJp3fJT5VzXcAdm0MTZMeuDXSH+O66ItAxJUnjERQwtJdtO0UoegSWYJvLrNkBnqpipa5DBnMOezqtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shQaoul6vyfqn6rvt6n345FFYToHxlUgtHlH4eq7yy8=;
 b=XN5pm/g0mN4Yjxo2C//W+za3jzSnSjP+VghC/VdZz01MsypwHfAJITh1uWTIz4qQ8eiZEq4wfwTGKZnSCy0wzuXSK8hJZrC0PnutW0fUW0LpCti3MbjNYiZLiPOOTOIe9JJQmDCVcGo9mkrrZn4ppr0kSboPSlPgbdtwrs6ES3s=
Received: from DU6P191CA0054.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::21)
 by GV2PR02MB8652.eurprd02.prod.outlook.com (2603:10a6:150:7c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 10:19:51 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::5) by DU6P191CA0054.outlook.office365.com
 (2603:10a6:10:53e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 10:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 10:19:50 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 20 Mar
 2025 11:19:49 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 20 Mar 2025 11:19:49 +0100
Received: from pc50740-2234.se.axis.com (pc50740-2234.se.axis.com [10.94.131.4])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 8D59A294
	for <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 11:19:49 +0100 (CET)
Received: by pc50740-2234.se.axis.com (Postfix, from userid 21184)
	id 8960A26B9749; Thu, 20 Mar 2025 11:19:49 +0100 (CET)
From: Christian Lindeberg <christli@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] fetch2/gomod: Fix mirroring problem
Date: Thu, 20 Mar 2025 11:19:49 +0100
Message-ID: <20250320101949.1680184-1-christli@axis.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|GV2PR02MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: a9524a4d-0a3a-4962-3c08-08dd6798bfea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k14300LMy8vVWU66kP/MX4UaGbZ6Uu9LyGU4RhdtX8WlvHyinU32UgGMr8Kw?=
 =?us-ascii?Q?LdRDIhoUBrMYM4w7wQyWQyEJbDS0l8simYbrAv/jENDsBI2SRYgpcPH7P/j2?=
 =?us-ascii?Q?mVJGyBzo79w2Erh0cEBrU0NsjuErHfFAN+IWFCGbHd8tJnC6a3EnFGm+Hn5m?=
 =?us-ascii?Q?tOtiIuFPwJev2yl8pBz5BEAXbRCgNjdCGsUM4dBNUHq6diVP+Dlg3/7ysqVh?=
 =?us-ascii?Q?10oI+Ev5Cmj67qkThQV9XX8DVS0eefKTagCV2l9nLimqKTa7FAua4nn7SGYy?=
 =?us-ascii?Q?5ttjRHVx2E9CiCXEYtwzB+I3EUW4U8HxF8fGEKihbFmwRHGTJjpaKh3z3SID?=
 =?us-ascii?Q?F5HTF8dnTKVw2isc5+lz72P3Lsfc7Wgi0qoE3xCXPnMDdCuIMlpvOHSzWewj?=
 =?us-ascii?Q?3nzHGnRBWzrUxAF8om2996SgR/Ds15+EXWcnN5AJns+ZAvCk0Ry7Ok7TuLRX?=
 =?us-ascii?Q?tW3gs8MRRVP5KmN6XOHq0Cr5POgoKugAEFTKOWo2bDdiN3+8v3YY/Hw6jVsv?=
 =?us-ascii?Q?LhXtN4L/3EViiyX+jwV1GrVOpDmW3dW16TpC0hIR3duwGyiIemCZ0wj+K/Cn?=
 =?us-ascii?Q?A3gpXLTOzpqJQ5dd5GNEtNWehJjIOuQ7Xn7+wqEVtpO17lR6I2WQTUERE5Kg?=
 =?us-ascii?Q?A7bV4GiogloG0EM5hh/vSRjR4QF1z1bAbx8mQDC5A4JiQIrbZxXYCeOkeQNM?=
 =?us-ascii?Q?+bT0+I+ARdFWjDg2Jr4oD0yDNhrZmTJVWUipaA4SFsRHcdra1TRwgM6UWSt4?=
 =?us-ascii?Q?EWsXS2EhaHL2qArqVMFCRqLTPgjY/A2dNY0TCOj4gOQ397aDvZhc10hfTtC5?=
 =?us-ascii?Q?vyUiTn2Zx3rX/Wcu1hWYOpLCuth8PunwI0u0OwxGM4eQ9qhyIzcz+1KjwAJT?=
 =?us-ascii?Q?VoHoCxmp24A+4IPjQxDydGpCv7skqbP09rzjOHP3b1HkW0CoqbU9D5/zISwH?=
 =?us-ascii?Q?mHxVZ+VsLbaBqmXVQrDeGyYPBFkheKf7Qc6at/kDVb1OPYAwWV+YJA+K66sZ?=
 =?us-ascii?Q?yWLy2AeJJshext8IMuEsLsoIdXFXRzUJhw3Os9DokUwO0yYXhFKX8eJJg0dI?=
 =?us-ascii?Q?XCc76+vWY2utecPQhTbI1SCIeMbmJj8MoAOtiBYcH2yA+Zbozj/dgVP7djOl?=
 =?us-ascii?Q?rk5XWnYKyRxnMe0Mpczo/Sc3zxLibEv4OSEeaoxrxV+14esNgrt3qffa/gI4?=
 =?us-ascii?Q?UwgNmp6SCmAxwbq7wfJDylnBLCs74MdN51vURQx28DosPMp7sT3pQ6/hHdm0?=
 =?us-ascii?Q?u+VQYGRz0QHBQ6EKHIGJckFKBpRP0A+zdpn9QLGGA86PFogKAy4yuWXDIQGD?=
 =?us-ascii?Q?tfcA/2JnU5OGSjlQnl/u2JByXRLmVnt9aeHxOPo+k3o2g9+AH/JTR4ClM963?=
 =?us-ascii?Q?YYFMvQ7H3y0LDoDMavZHKdScxh0rlZ8TTc3DolDG+B7JgqCvSFsaw+tvgcx3?=
 =?us-ascii?Q?PcQZUrZ1WF8=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:19:50.8342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9524a4d-0a3a-4962-3c08-08dd6798bfea
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8652
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 10:19:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17480

From: Christian Lindeberg <christian.lindeberg@axis.com>

Build the 'downloadfilename' parameter by replacing path separators in
the module path like the git fetcher builds the mirror tar ball name.
Copy the downloaded file in the fetcher's unpack method like the crate
fetcher instead of calling the base fetcher's unpack method.

Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>

Changes in V2:
- Add the lost unpack tracer call.

---
 lib/bb/fetch2/gomod.py | 35 ++++++++++++++++++++++-------------
 lib/bb/tests/fetch.py  |  9 +++++++++
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 6c999e8ba..56c2b1c42 100644
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
+        ud.unpack_tracer.unpack("file-copy", unpackdir)
+        cmd =3D f"cp {ud.localpath} {unpackpath}"
+        path =3D d.getVar('PATH')
+        if path:
+            cmd =3D f"PATH=3D{path} {cmd}"
+        name =3D os.path.basename(unpackpath)
+        bb.note(f"Unpacking {name} to {unpackdir}/")
+        subprocess.check_call(cmd, shell=3DTrue, preexec_fn=3Dsubprocess_s=
etup)
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


