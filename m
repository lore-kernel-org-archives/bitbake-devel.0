Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2700FC0219F
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.110])
 by mx.groups.io with SMTP id smtpd.web11.6855.1738739758488645702
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=o2DDDqjH;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZVFIKPl6CqtL2whf3dI4ehTkxuew+RA3CnllrlMPNuz1d/V62aAnuXJ+sLXf9Xl9R1XaV0m0CSkMZXbeUH3K6ZrvTL9wfkMV175lnJXbcSL+zo6iasHu2C0dTa9CO3tlsJ9r/uFe1Qs7yDnzH88EFM6lQUnpdl0xBmNbwRvAfIjMf8eKjuWAt4b8rQ1EOKnngZ2VFbQAnWpXW97B0qssplr0ATSCUAXo0PRVh1rMWFVUuL0XTmL/68rneHGccxGhjxxNUfyFozjsuWNPEw2xIgOuGUJ1IHviwWBC9d3GuHt32d/qASN5ZhX2aaDO+PJnbCZpzhCmSSxs4R90lx+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfgLaK2SL/N0CUgD7/XNkKodIIjE0qHqVsEmyhaxUM4=;
 b=mDu4/t7nschXLujd0jZbVc55al9b79ujLDFfeTxM9Dqmg4aUgb6Bhk2fnvjOXapOISyyIi9cRnFg7eCfSvZBYp8oZpMDoHg3jfJGQdIV50jhdO2XPhKOJBzdhhao/1j8bE6PHBukficBqmuYIcpH3OjzB87oxnPrGWRAN1lF8h71Nba3MfZF8AVLKo+mnjSa1a/iCepRcjsqjD4sUadFuJIRkgETpJg7KD20UJZw0CZRKsJ4+M0hg7Kl0VGdFROICncQP2SdJyY6fz/6l6SDYCJiV4dijIC+PJTfuuLG7tAIZIQbyiwuMF4/O7sdHbcaXW6jrKHkS+j5ryy0uMMAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfgLaK2SL/N0CUgD7/XNkKodIIjE0qHqVsEmyhaxUM4=;
 b=o2DDDqjHSjP1hPdfrJtXHARzYYx979kKbDIorE8gC7oURviflk/ILhy3tmHCMgcjmpicRNfmLc0RovFlvbO/yEPWmbWGSns05ZZZ/YleV7JnrmW+kIL/eqNNmA0ApcEnmABDSkNkgHjAccqKb7FRF2ZZfCs/3THCN97Nv6cqaJLpCPoSgvSFc+EpgcIXb7z17LqsbLDe/JY7td/fts5i44EXwL/GXdqBnNl4jG/DhE8qigsMI81drHVjtXCTG6v36PJ9aAXib6MeLrHP+heFdIBIexvhsYyvPGISOpKiQZNhCEK+sngjchuRkb3ik5TPvy0l19qtHT2/0pzbFTK7zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:53 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:53 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 07/15] fetch2: remove basename from FetchData
Date: Wed,  5 Feb 2025 08:15:30 +0100
Message-ID: <20250205071538.2681-8-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 369dfb77-d58c-4bc4-415e-08dd45b4ecdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6JjEg3AWPUPJRJ9AfEAnnGlKL+QG3ZR/+QzpU0V6dTe2ltZoWlJet29cM2Py?=
 =?us-ascii?Q?0FhHon1/1IFSXpBSDNpPRJHuL5IFQPC7EH7TscbAZf8G3u3zjmu7w+y+oHaF?=
 =?us-ascii?Q?RZpDx90cdqfKYZcwtixmbbOHg/0U9W4whAI8Rx+ZWdA4hzfnlEOnwHSvWkGz?=
 =?us-ascii?Q?qYpb7fkZsX3K3xeav02TZYOfqqazdzGZhS27h6/uxVFC2F8wYL/TJSGSSHFU?=
 =?us-ascii?Q?B8ay2Tg13rtGGjTpjuGYYg/8jMZR+iM5B1vdLTjb2N7R6wPUlWhOgUO/1ai1?=
 =?us-ascii?Q?pZj89qIXHO3VPxsPO50LLWDtygP4de0SNq0cpKPp9b56zDKjY7sNLlxuJdJy?=
 =?us-ascii?Q?QjlT3uEWpsVRo/NT+D6p+loj8ZFzuJQ9DnBo4rDfFVKsexir7jBy8EtS4wpv?=
 =?us-ascii?Q?Y5Y5pIm6HBrmgO4bsQKvVW0jqKDLHLFYo9HkIllV5ZQ4KL3AdA3VZcoGZl+E?=
 =?us-ascii?Q?SgrOTkTPk6oAKwtcIIWVLE0l5Qiyxzds+CEflah85Nf2xG+IY49ZIcdHyRvr?=
 =?us-ascii?Q?4D1lYPXUW0UpmxaqUbnuLPVNOVV/4JlYxZeGk/m5rfadLgyxFu+6YHQLL1Z2?=
 =?us-ascii?Q?t9f/Spg8y1fIck+xdIgMtbz2aOGnT8J91Kv4t+EcICF8+dCcnO5hYn7GOzQ6?=
 =?us-ascii?Q?Geddqam1CEmQE4VE27xvEqdGEV3CTYd83PiuXQe3UmLuLR/OsQ2Cgvpz5XKs?=
 =?us-ascii?Q?kgbgPV9mICyWbUs5/A/9VjsMhh6ei37yLCjYfbw8yQ9foCRaJnJWNPRGWZGB?=
 =?us-ascii?Q?oYh5jgopVPqrPvCtKhi+ps8bsSQTHOS96rQoRRnLsJ4DY/SrC7IznUbY0GB4?=
 =?us-ascii?Q?OYIebVNWXXNphf8boKXzZtCc2dn5wooBO75nmrBYkt1/3OSgIXbRRs6dDgks?=
 =?us-ascii?Q?nGUFX8g5izAWxjSbm44Rvbh+KdLWGfMS5nv2K/qRsT0t46vlp7Gms06C1s3b?=
 =?us-ascii?Q?hqes1Xm5BonCoAU1ppgqs8KVhRaVoeFGMcwxadH/9RkeVbwvsGd3geOFivdv?=
 =?us-ascii?Q?6ipWZSdDzjiRMhoNWGEggMKEXKwM81YTAGkFZJceaG2jaUAh+en5QdpQJbYr?=
 =?us-ascii?Q?vHgyAmvsA18xdDIBUGjaAsghZmvtPcAc+bHKsTpbN9DilHUaLi8tpJE9rOE4?=
 =?us-ascii?Q?tWQkFz+RSA/UAabJJzDS8wEpx1Yx5aLjgQ9BXT7GUJ6d/dTonq0/al07G72i?=
 =?us-ascii?Q?uRBP3ymvfxOffIuBuBndJh/M0sKJ1q+/8LSr349Q9hAeKcNOC5snY6YfV19x?=
 =?us-ascii?Q?GquNBHXX35+twCmz+3FsyourLA+e3Q6/qYy6KqTQIr5bKhFSDa8GDbjRb++C?=
 =?us-ascii?Q?75V8IoUZCjeoxuPX0dysDBcr5IPC3nUSa2Xr12UqDXOCe5p4w9d1vFc69EiF?=
 =?us-ascii?Q?71AxDl0KjABbnUHLTzvm7VzYbEi7nzMEPYyakgAnESYH55y9GsBVoJY8R+RV?=
 =?us-ascii?Q?mmGgWGfRMOX2gYBgIyFWYGRkKnGBcY3g?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NlMio+iCB8EUe5gkTcmvrdo7IXH/KX/UmGJHmklSZDK6GfXG7CTvJNmzzDNt?=
 =?us-ascii?Q?MLceqMwgZ0aQwhxN7zfEaf/vWL6vn3TUp75Fu9G9kRUAOE34Ox49GEgkmxaE?=
 =?us-ascii?Q?k+BxETZWiXSNgbucrGFpvGkUuKNaN7t1DXN7raC1tncg7zZ4GYgcaXkvZNyw?=
 =?us-ascii?Q?O2PXuR2Wr9XDeo4Ki3H7QIt5e3mD/ZiyoCJWPeuouGBJc83mnBtSsLalgp42?=
 =?us-ascii?Q?THUCji87k5dXeURs6eU5gXTFWCvP0NMYM44Yrbmx3yu2z3U4hV5D4aO2cbvn?=
 =?us-ascii?Q?1dDppXQri6knHAql8myGXj2atkBZ8OQ1HII9TuDPooij5jxPA98BPJLrjO/o?=
 =?us-ascii?Q?+a125/x4+xppvgVaTg0vEqvwiMuLS5aBmEkpAXGW//QiPYhWyqYqeKK1tF6M?=
 =?us-ascii?Q?ZqKI2ts45mUZY1Jd3kZLDjxCt4W/gX8zN/6DTAdRc5PRmcNKl3Y+rRMvTozI?=
 =?us-ascii?Q?SEh7Y3lekifrLWS3wdCLZnYtoxoNhZmwfmXedE6UQNgZJXUL1TAOJ7aUbsuc?=
 =?us-ascii?Q?Mg1TZUlqqbDJtER3pVD7IpDMumlLghz8kIgQLNcjpgcndG7Vf0pDzvaO2xGK?=
 =?us-ascii?Q?dnFoZCQbUhwTelE1bjvDTEzYq9M1+8u7kee79QH/3FuLjKAvHIPObuZHjTir?=
 =?us-ascii?Q?RtIR0zr+ih2neJPdbFMBEqAUTtx5dANsQa21wcPWYCzXB9GYoN4RPCij+In0?=
 =?us-ascii?Q?RJZKg0hyXSlGur++wZWy0OCtSiF/bCHABpuAfy/j2rLr/sBDsnks1xTDekvR?=
 =?us-ascii?Q?mROALTxBqD2XZX77odh3RVwOHmsDJe3g/I/SAfDFm0rkS9q4fbs9ekkgr7Ui?=
 =?us-ascii?Q?tlhEB/LSdDbMu/QajuH1UIWxNxZRfMvA3fyJaErH/dGczgUdrIB+Oj4MW8DO?=
 =?us-ascii?Q?PqGjqeOtFYy4VcwC46kwbfXq7ehD40eT4bXGYyqNE9Pr87LKNPFdB1SKCM86?=
 =?us-ascii?Q?5xr1XL4TsKMHsL6G9xYYe7A7s3ejS5Ceicc88kdacFHQG+xZSyVEGmqcWiKR?=
 =?us-ascii?Q?Vvziv7F8U7xCaODZlY+nvlHOIHCXJLWdIIKRBCSjISImO5kvyugcUiMsSsdb?=
 =?us-ascii?Q?Ax9T4VhSdE5Xu6h7KFe1JAmp2CPKkl7BtQCWzXkl2D/rQloR0QsIIV+k84TK?=
 =?us-ascii?Q?vKdJEUWCBUgmVRBjps5aNMxZOQuGSQAfic5XQxBQH0UFZcZ7f9cRx3kW7gT0?=
 =?us-ascii?Q?MagsmdUdelDE5AAnd2XcMt58H4BJdnwI5J1YnREJ3HLv61dtXAsJF3Ki0jiC?=
 =?us-ascii?Q?v610COVGQFVTFaNQ3X3HXttCwGVy6PBORBxhbSVBWq5Pr/SQWTmFRCH5EkAY?=
 =?us-ascii?Q?2vSufQ7SUZJ06M+CQGfCmzvQUxHZR81laeCwYiLXruubBEFYwH6EGWswJqJR?=
 =?us-ascii?Q?TtQS63w+pg2GPBtJdrwFMRsU3xTL/w4DMepxPivI5KKcVkJUYrBnhCTywSTL?=
 =?us-ascii?Q?2D8ka/b8wKK2sgWATuYHkUiRsebl+9KckJ9O1tSHdebjayyFfU0tDQ/0qSnD?=
 =?us-ascii?Q?HhiPsUNMRrw6ZwtThRwunOA6bwJqKdX2lzSmPgROK19SeG7PeZk/4wKfAmAm?=
 =?us-ascii?Q?L4dMbj8RJkKMI5/kAYbF4Xb6awpBvMKmXXt+LDC2R+YbENL5pIrmbpAD6BNJ?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369dfb77-d58c-4bc4-415e-08dd45b4ecdb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:52.8006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw6ZEQst6pAFMdK5rIJJQinoEOtN5PLYc05XGeHXIMZwIQIr7G4DRXhgEADvrLdTcIMeEN7Nd48FrBdMaab3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17140

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the basename variable from the FetchData class. The variable
contains the same information as the localfile variable and is mainly
used by duplicated code. Consolidate the duplicated code inside the
FetchData class.

The variable name is also misleading because it doesn=E2=80=99t contain the
basename of a file.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 14 ++++++++++----
 lib/bb/fetch2/gcp.py      |  8 --------
 lib/bb/fetch2/local.py    |  1 -
 lib/bb/fetch2/s3.py       |  7 -------
 lib/bb/fetch2/sftp.py     |  7 -------
 lib/bb/fetch2/wget.py     |  9 ---------
 6 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f4cf25cfd..2328a8fe3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1304,7 +1304,6 @@ class FetchData(object):
         self.localpath =3D None
         self.lockfile =3D None
         self.mirrortarballs =3D []
-        self.basename =3D None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm)=
 =3D decodeurl(d.expand(url))
         self.date =3D self.getSRCDate(d)
         self.url =3D url
@@ -1360,10 +1359,17 @@ class FetchData(object):
=20
         self.ignore_checksums =3D False
=20
+        if not self.localfile and self.needdonestamp:
+            if 'downloadfilename' in self.parm:
+                self.localfile =3D self.parm['downloadfilename']
+            else:
+                self.localfile =3D os.path.basename(self.path)
+            if not os.path.basename(self.localfile):
+                self.localfile =3D self.host + self.path.replace("/", ".")
+
         if "localpath" in self.parm:
             # if user sets localpath for file, use it instead.
             self.localpath =3D self.parm["localpath"]
-            self.basename =3D os.path.basename(self.localpath)
         elif self.localfile:
             self.localpath =3D self.method.localpath(self, d)
=20
@@ -1377,8 +1383,8 @@ class FetchData(object):
             basepath =3D self.localpath
         elif self.localpath:
             basepath =3D dldir + os.sep + os.path.basename(self.localpath)
-        elif self.basename:
-            basepath =3D dldir + os.sep + self.basename
+        elif self.localfile:
+            basepath =3D dldir + os.sep + self.localfile
         else:
             bb.fatal("Can't determine lock path for url %s" % url)
=20
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 86546d40b..62715f746 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -40,14 +40,6 @@ class GCP(FetchMethod):
     def recommends_checksum(self, urldata):
         return True
=20
-    def urldata_init(self, ud, d):
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-
     def get_gcp_client(self):
         from google.cloud import storage
         self.gcp_client =3D storage.Client(project=3DNone)
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index fda56a564..0e9357968 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -29,7 +29,6 @@ class Local(FetchMethod):
=20
     def urldata_init(self, ud, d):
         # We don't set localfile as for this fetcher the file is already l=
ocal!
-        ud.basename =3D os.path.basename(ud.path)
         ud.basepath =3D ud.path
         ud.needdonestamp =3D False
         if "*" in ud.path:
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 22c053813..2cf181442 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -72,13 +72,6 @@ class S3(FetchMethod):
         return True
=20
     def urldata_init(self, ud, d):
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-
         ud.basecmd =3D d.getVar("FETCHCMD_s3") or "/usr/bin/env aws s3"
=20
     def download(self, ud, d):
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index bee71a0d0..2a2a70a1b 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -72,13 +72,6 @@ class SFTP(FetchMethod):
                 "git repository using ssh, you need to use the " +
                 "git:// prefix with protocol=3Dssh", ud.url)
=20
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-
     def download(self, ud, d):
         """Fetch urls"""
=20
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6cb728ab4..161c66bea 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -73,15 +73,6 @@ class Wget(FetchMethod):
             if ud.parm['protocol'] =3D=3D 'git':
                 raise bb.fetch2.ParameterError("Invalid protocol - if you =
wish to fetch from a git repository using http, you need to instead use the=
 git:// prefix with protocol=3Dhttp", ud.url)
=20
-        if 'downloadfilename' in ud.parm:
-            ud.basename =3D ud.parm['downloadfilename']
-        else:
-            ud.basename =3D os.path.basename(ud.path)
-
-        ud.localfile =3D ud.basename
-        if not ud.localfile:
-            ud.localfile =3D ud.host + ud.path.replace("/", ".")
-
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -=
t 2 -T 100"
=20
         if ud.type =3D=3D 'ftp' or ud.type =3D=3D 'ftps':
--=20
2.39.5


