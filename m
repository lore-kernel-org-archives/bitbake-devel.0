Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A09EC61DBD
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 16:26:58 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4760.1787934415848099159
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 09:26:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=K0AThDPg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5Er/7qcn27uHPng1DJqhg36/M0G+WI8QX90fx7l3D5hAx5WjJLmiJdD/jzL3PFrIsaSzod2z7B2opyww5XexoyHWftTZ8J9IWcvxd98IpkllZPu+NzKmAe1cW3kDfTWTkHd/A7u0/ptf90qZuIej4I9TkNw+qodh/y5Doun2xIWb4f6sH5lOxM+pFIorfolueNQ3jtAqpSbvYj8HSrej+43n8/E2UurLP+1EIkdsbGO8cxKXEDfOZEPBO+GwgYKhMFoDLf/2HE9DSckYpljcRFKeYL9I9SEqTlO5yehtkkXomAvEYuoprIImKXbLx7ZLf9StxPOjLqGD3NaNBZKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VU2+MWkSe1UgcVSu5oPp4N9AyniUpj+/khcdVsdcWQ=;
 b=Ja79R1sghQvUcOSmJEx55vRHseagYJ0zfJgz7r7HthQFOKFzcHDMMOAVImGl2YZcuNFUP81DsGtlL8Qn1dRCPICJWkOrS4v0Wz+k0dN2i8WwSSavmBPegaRO3yrvZUtgO8OWuMZigm6gMbX2CX9QB5d6LqR2ZbGLqAQCyQIwyCS6vECYLI+y8js8v5ZqMIV06peK9LAbcOdYlLdBGU62FrGyXOFCxz3NfLexDQHeRzeMgy88yDUCxVWqG/6v7+vnDgy9zttu4nLjAm10gT3Q4IdeOK8VZZpVSi1vRfIQykpZFvzLEvnFgJ/2wQfo6TL984asbzWyXIvptbklag679g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VU2+MWkSe1UgcVSu5oPp4N9AyniUpj+/khcdVsdcWQ=;
 b=K0AThDPg4y1aJLUvDkCKpeNe1Z7NvCswr+VIEj1VZ1IpGhIFOCHNtzPiZ3qsaOzz1LC73VdRiLxiADeNlnGf4Qnq52Wc4FQfVfQjEXo8Bow3GawRtdDMxAgyT8h2qcu9l11M8ggLF8TUYxM9QcaB7+OX+ym5JGffKRL72ekKH4iRzGPIb0aPdHDu3rtheX923n70SeVS0ERqJ24TF24u6STGOPR6DEVpC4qccYU6x6ADKEKWVvkHTYJ5laH5Igz7IQZAchxqxFplQMVZ9l9SGni61/CQqfWaB6fxAbewItqndIPEuc7GwjFnzzopL87tfTX/GzHvSrtasaPCozA38w==
Received: from IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::6)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 16:26:49 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::78) by IA4P220CA0008.outlook.office365.com
 (2603:10b6:208:558::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 16:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 16:26:49 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 28 Aug 2026 10:26:34 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 1/4] lib: rename fetch2 as fetch; invert compat shim to make bb.fetch2 = bb.fetch
Date: Fri, 28 Aug 2026 12:26:09 -0400
Message-ID: <20260828162612.753815-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: cd392d23-6935-415c-dc7e-08df0521291a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	vrvD6tf2gKFy1Gh2dtvQIMhGIP2/CAZ7Wv44Vd5lnll3vXILCXIv7QzY1npTr+ogklMbOJ+vW4vQfyPGUSjh2q78H5K2e4RjsgcyTk3h0llu5HEIFECfUeyyV8O/OkTS2CMrKPOZuHkTrDIHMvxNdz8zXEZXe4T8nQk1FPRSUrn91jtKUGB9ZwZDrPuuESJrXHkIAou9m22t3HQl+V+bhuK0XSy12edNplHv98NBMLQ5umF52RaLHsaS0wnD1F33+0dlrGPX1ARbvV1CVviIRYKBdGyP9MwdoWYUCG+MTc+MLw4FpYt1UpRzd8gV+7ZVuqR5VBVtJPXON+lM5vrltILWCC4B7uaApdpIBGQEEINVFGqScs89imNhiLU6WqCGhn04fm1IgepQVImD9yxKzu1k9kZOGfsOF+xUT1PP4/T5zNyjC+QxbrO+Trfy17E7C/vjUlEgau75Cau7tSnL0G2+LRttUXGPYd7aFoK1IEMP9yhqqAC9VYPkw/LNu1/WfLg/FCbbjPM8/evjbbj8/lxmnJtB63BS7jdKMFSFnqsk2Uqz5MPJkBR42ZAJcFRKVF2dt9n98babVE688A4YB06ev/jAhkCyQfnnSjOT3u1erqpo6hjuXtGnGgrxoFQCeOApnb6v0c8xAG+InBQ6xg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	nD/+/D9h4aC03f6zS4Tq9VmtS3kcxMhTRZ8D+11UgdkkaIyz3FA8hVDB09h+MA/j+pX7SnmSClTql9xMTznhuke9Gsno82nMhV05VLxjVXzcbJhyk1+usNAb8OCyelyYafotdyVZ0zmLU6/zEPU+xDGnGnLz+JlC2r2C6+t0ti29J1sMHbtzxPNcCNpRJt4v9K3UkEGiGTzZkPOU64osT48dZXuKTLFVnAuQJ9E55jQUZXEPkdIfryDRNbm7rPO3ml3HGh/nt4yn4fWyVJmETLdABRIgQ5k0N0wuYKYcB9uP75fbTd/euH4z/jQXvtyQ+VqrNU5wQK9+kaKUZbLDsxQW9f5d1CblwL0qxqtp0hFvKPNmQFN1zVNU1O4XlUj5LB7ZLyo5WMckFwh53PFQKpw4OYEAdk1NB7OzAcD+FUlJVavuFjvFi9aTWS5ojQfq
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:26:49.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd392d23-6935-415c-dc7e-08df0521291a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 16:26:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20118

From: Chris Laplante <chris.laplante@agilent.com>

bb.fetch2 replaced bb.fetch back in 2012, and the compatibility shim of
bb.fetch =3D bb.fetch2 has been in place ever since. There's no longer a
good reason to keep the '2' suffix, so lets drop it.

We also invert the bb.fetch =3D bb.fetch2 compatibility shim to now make
bb.fetch2 =3D bb.fetch. We do this by creating a new lib/bb/fetch2.py.

Layers are accustomed to accessing bb.fetch2 without first importing
bb.fetch2, so we declare a module __getattr__
(https://peps.python.org/pep-0562/) to keep this working.

Finally, we add a deprecation warning for good measure.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/__init__.py                    | 13 ++++-
 lib/bb/{fetch2 =3D> fetch}/README       |  0
 lib/bb/{fetch2 =3D> fetch}/__init__.py  | 20 +++----
 lib/bb/{fetch2 =3D> fetch}/az.py        |  8 +--
 lib/bb/{fetch2 =3D> fetch}/clearcase.py | 18 +++---
 lib/bb/{fetch2 =3D> fetch}/crate.py     |  6 +-
 lib/bb/{fetch2 =3D> fetch}/gcp.py       | 12 ++--
 lib/bb/{fetch2 =3D> fetch}/git.py       | 80 +++++++++++++--------------
 lib/bb/{fetch2 =3D> fetch}/gitannex.py  |  4 +-
 lib/bb/{fetch2 =3D> fetch}/gitsm.py     | 10 ++--
 lib/bb/{fetch2 =3D> fetch}/gomod.py     | 14 ++---
 lib/bb/{fetch2 =3D> fetch}/hg.py        | 18 +++---
 lib/bb/{fetch2 =3D> fetch}/local.py     |  6 +-
 lib/bb/{fetch2 =3D> fetch}/npm.py       | 18 +++---
 lib/bb/{fetch2 =3D> fetch}/npmsw.py     | 18 +++---
 lib/bb/{fetch2 =3D> fetch}/perforce.py  | 16 +++---
 lib/bb/{fetch2 =3D> fetch}/repo.py      | 10 ++--
 lib/bb/{fetch2 =3D> fetch}/s3.py        | 12 ++--
 lib/bb/{fetch2 =3D> fetch}/sftp.py      | 12 ++--
 lib/bb/{fetch2 =3D> fetch}/ssh.py       |  2 +-
 lib/bb/{fetch2 =3D> fetch}/svn.py       | 18 +++---
 lib/bb/{fetch2 =3D> fetch}/wget.py      | 18 +++---
 lib/bb/fetch2.py                      | 19 +++++++
 23 files changed, 190 insertions(+), 162 deletions(-)
 rename lib/bb/{fetch2 =3D> fetch}/README (100%)
 rename lib/bb/{fetch2 =3D> fetch}/__init__.py (99%)
 rename lib/bb/{fetch2 =3D> fetch}/az.py (96%)
 rename lib/bb/{fetch2 =3D> fetch}/clearcase.py (95%)
 rename lib/bb/{fetch2 =3D> fetch}/crate.py (97%)
 rename lib/bb/{fetch2 =3D> fetch}/gcp.py (92%)
 rename lib/bb/{fetch2 =3D> fetch}/git.py (92%)
 rename lib/bb/{fetch2 =3D> fetch}/gitannex.py (97%)
 rename lib/bb/{fetch2 =3D> fetch}/gitsm.py (97%)
 rename lib/bb/{fetch2 =3D> fetch}/gomod.py (97%)
 rename lib/bb/{fetch2 =3D> fetch}/hg.py (95%)
 rename lib/bb/{fetch2 =3D> fetch}/local.py (91%)
 rename lib/bb/{fetch2 =3D> fetch}/npm.py (97%)
 rename lib/bb/{fetch2 =3D> fetch}/npmsw.py (96%)
 rename lib/bb/{fetch2 =3D> fetch}/perforce.py (96%)
 rename lib/bb/{fetch2 =3D> fetch}/repo.py (89%)
 rename lib/bb/{fetch2 =3D> fetch}/s3.py (93%)
 rename lib/bb/{fetch2 =3D> fetch}/sftp.py (93%)
 rename lib/bb/{fetch2 =3D> fetch}/ssh.py (98%)
 rename lib/bb/{fetch2 =3D> fetch}/svn.py (94%)
 rename lib/bb/{fetch2 =3D> fetch}/wget.py (98%)
 create mode 100644 lib/bb/fetch2.py

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index a9c31815a..16db930d4 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -153,8 +153,17 @@ class PrefixLoggerAdapter(logging.LoggerAdapter):
 # can result in construction of the various loggers.
 import bb.msg
=20
-from bb import fetch2 as fetch
-sys.modules['bb.fetch'] =3D sys.modules['bb.fetch2']
+# There's lots of code (in OE and other layers) that accesses bb.fetch2 wi=
thout
+# first importing it. It used to work because fetch2 was added to the bb m=
odule in
+# bb/__init__.py, as part of installing the fetch =3D fetch2 shim. But now=
 that
+# the new fetch2 shim is an actual module, this will break. So, provide la=
zy
+# access to bb.fetch2 via __getattr__ so layers keep working.
+def __getattr__(name):
+    if name =3D=3D "fetch2":
+        import bb.fetch2 as fetch2
+        return fetch2
+
+    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
=20
 # Messaging convenience functions
 def plain(*args):
diff --git a/lib/bb/fetch2/README b/lib/bb/fetch/README
similarity index 100%
rename from lib/bb/fetch2/README
rename to lib/bb/fetch/README
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch/__init__.py
similarity index 99%
rename from lib/bb/fetch2/__init__.py
rename to lib/bb/fetch/__init__.py
index 9cb268be5..153700dfb 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -543,8 +543,8 @@ def fetcher_init(d, servercontext=3DTrue):
     try:
         # fetcher_init is called multiple times, so make sure we only save=
 the
         # revs the first time it is called.
-        if not bb.fetch2.saved_headrevs:
-            bb.fetch2.saved_headrevs =3D _revisions_cache.get_revs()
+        if not bb.fetch.saved_headrevs:
+            bb.fetch.saved_headrevs =3D _revisions_cache.get_revs()
     except:
         pass
=20
@@ -578,7 +578,7 @@ def fetcher_compare_revisions(d):
     """
=20
     headrevs =3D _revisions_cache.get_revs()
-    return headrevs !=3D bb.fetch2.saved_headrevs
+    return headrevs !=3D bb.fetch.saved_headrevs
=20
 def mirror_from_string(data):
     mirrors =3D (data or "").replace('\\n',' ').split()
@@ -885,7 +885,7 @@ def get_srcrev(d, method_name=3D'sortable_revision'):
     return pkgv
=20
 def localpath(url, d):
-    fetcher =3D bb.fetch2.Fetch([url], d)
+    fetcher =3D bb.fetch.Fetch([url], d)
     return fetcher.localpath(url)
=20
 # Need to export PATH as binary could be in metadata paths
@@ -926,7 +926,7 @@ FETCH_EXPORT_VARS =3D ['HOME', 'PATH',
 def get_fetcher_environment(d):
     newenv =3D {}
     origenv =3D d.getVar("BB_ORIGENV")
-    for name in bb.fetch2.FETCH_EXPORT_VARS:
+    for name in bb.fetch.FETCH_EXPORT_VARS:
         value =3D d.getVar(name)
         if not value and origenv:
             value =3D origenv.getVar(name)
@@ -1059,7 +1059,7 @@ def build_mirroruris(origud, mirrors, ld):
                     newud.setup_localpath(ld)
                     if hasattr(ud, 'unpack_tracer'):
                         newud.unpack_tracer =3D ud.unpack_tracer
-                except bb.fetch2.BBFetchException as e:
+                except bb.fetch.BBFetchException as e:
                     logger.debug("Mirror fetch failure for url %s (origina=
l url: %s)" % (newuri, origud.url))
                     logger.debug(str(e))
                     try:
@@ -1154,10 +1154,10 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D=
 False):
         update_stamp(origud, ld)
         return ud.localpath
=20
-    except bb.fetch2.NetworkAccess:
+    except bb.fetch.NetworkAccess:
         raise
=20
-    except bb.fetch2.BBFetchException as e:
+    except bb.fetch.BBFetchException as e:
         if isinstance(e, ChecksumError):
             logger.warning("Mirror checksum failure for url %s (original u=
rl: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warning(str(e))
@@ -1814,7 +1814,7 @@ class DummyUnpackTracer(object):
 class Fetch(object):
     def __init__(self, urls, d, cache =3D True, localonly =3D False, conne=
ction_cache =3D None):
         if localonly and cache:
-            raise Exception("bb.fetch2.Fetch.__init__: cannot set cache an=
d localonly at same time")
+            raise Exception("bb.fetch.Fetch.__init__: cannot set cache and=
 localonly at same time")
=20
         if not urls:
             urls =3D d.getVar("SRC_URI").split()
@@ -1934,7 +1934,7 @@ class Fetch(object):
                         # fetcher still have chance to fetch from mirror
                         m.update_donestamp(ud, d)
=20
-                    except bb.fetch2.NetworkAccess:
+                    except bb.fetch.NetworkAccess:
                         raise
=20
                     except BBFetchException as e:
diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch/az.py
similarity index 96%
rename from lib/bb/fetch2/az.py
rename to lib/bb/fetch/az.py
index 81fd14468..76c411adf 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch/az.py
@@ -5,7 +5,7 @@ BitBake 'Fetch' Azure Storage implementation
=20
 # Copyright (C) 2021 Alejandro Hernandez Samaniego
 #
-# Based on bb.fetch2.wget:
+# Based on bb.fetch.wget:
 # Copyright (C) 2003, 2004  Chris Larson
 #
 # SPDX-License-Identifier: GPL-2.0-only
@@ -15,9 +15,9 @@ BitBake 'Fetch' Azure Storage implementation
 import shlex
 import os
 import bb
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import logger
-from   bb.fetch2.wget import Wget
+from   bb.fetch import FetchError
+from   bb.fetch import logger
+from   bb.fetch.wget import Wget
=20
=20
 class Az(Wget):
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch/clearcase.py
similarity index 95%
rename from lib/bb/fetch2/clearcase.py
rename to lib/bb/fetch/clearcase.py
index cb3f8b650..54f347952 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch/clearcase.py
@@ -52,12 +52,12 @@ import os
 import shlex
 import shutil
 import bb
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import MissingParameterError
-from   bb.fetch2 import ParameterError
-from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
+from   bb.fetch import FetchMethod
+from   bb.fetch import FetchError
+from   bb.fetch import MissingParameterError
+from   bb.fetch import ParameterError
+from   bb.fetch import runfetchcmd
+from   bb.fetch import logger
=20
 class ClearCase(FetchMethod):
     """Class to fetch urls via 'clearcase'"""
@@ -189,7 +189,7 @@ class ClearCase(FetchMethod):
         if os.path.exists(ud.viewdir):
             cmd =3D self._build_ccase_command(ud, 'rmview');
             logger.info("cleaning up [VOB=3D%s label=3D%s view=3D%s]", ud.=
vob, ud.label, ud.viewname)
-            bb.fetch2.check_network_access(d, cmd, ud.url)
+            bb.fetch.check_network_access(d, cmd, ud.url)
             output =3D runfetchcmd(cmd, d, workdir=3Dud.ccasedir)
             logger.info("rmview output: %s", output)
=20
@@ -215,7 +215,7 @@ class ClearCase(FetchMethod):
         self._write_configspec(ud, d)
         cmd =3D self._build_ccase_command(ud, 'mkview')
         logger.info("creating view [VOB=3D%s label=3D%s view=3D%s]", ud.vo=
b, ud.label, ud.viewname)
-        bb.fetch2.check_network_access(d, cmd, ud.url)
+        bb.fetch.check_network_access(d, cmd, ud.url)
         try:
             runfetchcmd(cmd, d)
         except FetchError as e:
@@ -227,7 +227,7 @@ class ClearCase(FetchMethod):
         # Set configspec: Setting the configspec effectively fetches the f=
iles as defined in the configspec
         cmd =3D self._build_ccase_command(ud, 'setcs');
         logger.info("fetching data [VOB=3D%s label=3D%s view=3D%s]", ud.vo=
b, ud.label, ud.viewname)
-        bb.fetch2.check_network_access(d, cmd, ud.url)
+        bb.fetch.check_network_access(d, cmd, ud.url)
         output =3D runfetchcmd(cmd, d, workdir=3Dud.viewdir)
         logger.info("%s", output)
=20
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch/crate.py
similarity index 97%
rename from lib/bb/fetch2/crate.py
rename to lib/bb/fetch/crate.py
index 830612c98..16ea02d8a 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch/crate.py
@@ -26,8 +26,8 @@ import subprocess
 import re
 from functools import cmp_to_key
 import bb
-from   bb.fetch2 import logger, subprocess_setup, UnpackError, runfetchcmd
-from   bb.fetch2.wget import Wget
+from   bb.fetch import logger, subprocess_setup, UnpackError, runfetchcmd
+from   bb.fetch.wget import Wget
=20
=20
 class Crate(Wget):
@@ -76,7 +76,7 @@ class Crate(Wget):
         # break the URL apart by /
         parts =3D ud.url.split('/')
         if len(parts) < 5:
-            raise bb.fetch2.ParameterError("Invalid URL: Must be crate://H=
OST/NAME/VERSION", ud.url)
+            raise bb.fetch.ParameterError("Invalid URL: Must be crate://HO=
ST/NAME/VERSION", ud.url)
=20
         # version is expected to be the last token
         # but ignore possible url parameters which will be used
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch/gcp.py
similarity index 92%
rename from lib/bb/fetch2/gcp.py
rename to lib/bb/fetch/gcp.py
index 462b8e97a..dd85b9fd2 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch/gcp.py
@@ -10,7 +10,7 @@ Additionally, gsutil must also be installed.
=20
 # Copyright (C) 2023, Snap Inc.
 #
-# Based in part on bb.fetch2.s3:
+# Based in part on bb.fetch.s3:
 #    Copyright (C) 2017 Andre McCurdy
 #
 # SPDX-License-Identifier: GPL-2.0-only
@@ -20,9 +20,9 @@ Additionally, gsutil must also be installed.
 import os
 import bb
 import urllib.parse, urllib.error
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import FetchError
-from bb.fetch2 import logger
+from bb.fetch import FetchMethod
+from bb.fetch import FetchError
+from bb.fetch import logger
=20
 class GCP(FetchMethod):
     """
@@ -62,7 +62,7 @@ class GCP(FetchMethod):
         if self.gcp_client is None:
             self.get_gcp_client()
=20
-        bb.fetch2.check_network_access(d, "blob.download_to_filename", f"g=
s://{ud.host}{ud.path}")
+        bb.fetch.check_network_access(d, "blob.download_to_filename", f"gs=
://{ud.host}{ud.path}")
=20
         # Path sometimes has leading slash, so strip it
         path =3D ud.path.lstrip("/")
@@ -101,7 +101,7 @@ class GCP(FetchMethod):
         if self.gcp_client is None:
             self.get_gcp_client()
=20
-        bb.fetch2.check_network_access(d, "gcp_client.bucket(ud.host).blob=
(path).exists()", f"gs://{ud.host}{ud.path}")
+        bb.fetch.check_network_access(d, "gcp_client.bucket(ud.host).blob(=
path).exists()", f"gs://{ud.host}{ud.path}")
=20
         # Path sometimes has leading slash, so strip it
         path =3D ud.path.lstrip("/")
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch/git.py
similarity index 92%
rename from lib/bb/fetch2/git.py
rename to lib/bb/fetch/git.py
index 0bb2ea39a..30618f073 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch/git.py
@@ -76,10 +76,10 @@ import urllib
 import bb
 import bb.progress
 from contextlib import contextmanager
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
-from   bb.fetch2 import trusted_network
+from   bb.fetch import FetchMethod
+from   bb.fetch import runfetchcmd
+from   bb.fetch import logger
+from   bb.fetch import trusted_network
=20
=20
 git_hash_re =3D re.compile(r'^[0-9a-f]{40,64}$')
@@ -162,7 +162,7 @@ class Git(FetchMethod):
             bb.warn("URL: %s uses git protocol which is no longer supporte=
d by github. Please change to ;protocol=3Dhttps in the url." % ud.url)
=20
         if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'=
):
-            raise bb.fetch2.ParameterError(f"Invalid protocol type: '{ud.p=
roto}'", ud.url)
+            raise bb.fetch.ParameterError(f"Invalid protocol type: '{ud.pr=
oto}'", ud.url)
=20
         ud.nocheckout =3D ud.parm.get("nocheckout","0") =3D=3D "1"
=20
@@ -174,7 +174,7 @@ class Git(FetchMethod):
         ud.usehead =3D ud.parm.get("usehead","0") =3D=3D "1"
         if ud.usehead:
             if ud.proto !=3D "file":
-                 raise bb.fetch2.ParameterError("The usehead option is onl=
y for use with local ('protocol=3Dfile') git repositories", ud.url)
+                 raise bb.fetch.ParameterError("The usehead option is only=
 for use with local ('protocol=3Dfile') git repositories", ud.url)
             ud.nobranch =3D 1
=20
         # bareclone implies nocheckout
@@ -185,7 +185,7 @@ class Git(FetchMethod):
         ud.unresolvedrev =3D ""
         ud.branch =3D ud.parm.get("branch", "")
         if not ud.branch and not ud.nobranch:
-            raise bb.fetch2.ParameterError("The url does not set any branc=
h parameter or set nobranch=3D1.", ud.url)
+            raise bb.fetch.ParameterError("The url does not set any branch=
 parameter or set nobranch=3D1.", ud.url)
=20
         ud.noshared =3D d.getVar("BB_GIT_NOSHARED") =3D=3D "1"
=20
@@ -206,10 +206,10 @@ class Git(FetchMethod):
             try:
                 depth_default =3D int(depth_default or 0)
             except ValueError:
-                raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALL=
OW_DEPTH: %s" % depth_default)
+                raise bb.fetch.FetchError("Invalid depth for BB_GIT_SHALLO=
W_DEPTH: %s" % depth_default)
             else:
                 if depth_default < 0:
-                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_S=
HALLOW_DEPTH: %s" % depth_default)
+                    raise bb.fetch.FetchError("Invalid depth for BB_GIT_SH=
ALLOW_DEPTH: %s" % depth_default)
         else:
             depth_default =3D 1
         ud.shallow_depths =3D collections.defaultdict(lambda: depth_defaul=
t)
@@ -224,10 +224,10 @@ class Git(FetchMethod):
             try:
                 shallow_depth =3D int(shallow_depth or 0)
             except ValueError:
-                raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALL=
OW_DEPTH_%s: %s" % (ud.name, shallow_depth))
+                raise bb.fetch.FetchError("Invalid depth for BB_GIT_SHALLO=
W_DEPTH_%s: %s" % (ud.name, shallow_depth))
             else:
                 if shallow_depth < 0:
-                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_S=
HALLOW_DEPTH_%s: %s" % (ud.name, shallow_depth))
+                    raise bb.fetch.FetchError("Invalid depth for BB_GIT_SH=
ALLOW_DEPTH_%s: %s" % (ud.name, shallow_depth))
                 ud.shallow_depths[ud.name] =3D shallow_depth
=20
         revs =3D d.getVar("BB_GIT_SHALLOW_REVS_%s" % ud.name)
@@ -343,7 +343,7 @@ class Git(FetchMethod):
         for rev in ud.shallow_revs:
             try:
                 runfetchcmd(ud.basecmd + ['rev-parse', '-q', '--verify', r=
ev], d, quiet=3DTrue, workdir=3Dud.clonedir)
-            except bb.fetch2.FetchError:
+            except bb.fetch.FetchError:
                 return rev
         return None
=20
@@ -415,7 +415,7 @@ class Git(FetchMethod):
                 if not bb.utils.path_is_descendant(toplevel, ud.clonedir):
                     logger.warning("Top level directory '%s' is not a desc=
endant of '%s'. Re-cloning", toplevel, ud.clonedir)
                     needs_clone =3D True
-            except bb.fetch2.FetchError as e:
+            except bb.fetch.FetchError as e:
                 logger.warning("Unable to get top level for %s (not a git =
directory?): %s", ud.clonedir, e)
                 needs_clone =3D True
             except FileNotFoundError as e:
@@ -438,7 +438,7 @@ class Git(FetchMethod):
                     repourl =3D repourl_path
             clone_cmd =3D ud.basecmd + ['clone', '--bare', '--mirror', rep=
ourl, ud.clonedir, '--progress']
             if ud.proto.lower() !=3D 'file':
-                bb.fetch2.check_network_access(d, clone_cmd, ud.url)
+                bb.fetch.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
=20
             # Try creating a fast initial shallow clone
@@ -473,7 +473,7 @@ class Git(FetchMethod):
             else:
                 fetch_cmd =3D ud.basecmd + ['fetch', '-f', '--progress', r=
epourl, 'refs/heads/*:refs/heads/*', 'refs/tags/*:refs/tags/*']
             if ud.proto.lower() !=3D 'file':
-                bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
+                bb.fetch.check_network_access(d, fetch_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
             runfetchcmd(fetch_cmd, d, log=3Dprogresshandler, workdir=3Dud.=
clonedir, extraenv=3D{'LANG':'C'})
             runfetchcmd(ud.basecmd + ['repack','-adk'], d, workdir=3Dud.cl=
onedir)
@@ -486,12 +486,12 @@ class Git(FetchMethod):
                     raise
=20
         if not self._contains_ref(ud, d, ud.name, ud.clonedir):
-            raise bb.fetch2.FetchError("Unable to find revision %s in bran=
ch %s even from upstream" % (ud.revision, ud.branch))
+            raise bb.fetch.FetchError("Unable to find revision %s in branc=
h %s even from upstream" % (ud.revision, ud.branch))
=20
         if ud.shallow and ud.write_shallow_tarballs:
             missing_rev =3D self.clonedir_need_shallow_revs(ud, d)
             if missing_rev:
-                raise bb.fetch2.FetchError("Unable to find revision %s eve=
n from upstream" % missing_rev)
+                raise bb.fetch.FetchError("Unable to find revision %s even=
 from upstream" % missing_rev)
=20
         if self.lfs_need_update(ud, d):
             self.lfs_fetch(ud, d, ud.clonedir, ud.revision)
@@ -595,7 +595,7 @@ class Git(FetchMethod):
=20
         # The --depth and --shallow-exclude can't be used together
         if depth and shallow_exclude:
-            raise bb.fetch2.FetchError("BB_GIT_SHALLOW_REVS is set, but BB=
_GIT_SHALLOW_DEPTH is not 0.")
+            raise bb.fetch.FetchError("BB_GIT_SHALLOW_REVS is set, but BB_=
GIT_SHALLOW_DEPTH is not 0.")
=20
         # For nobranch, we need a ref, otherwise the commits will be
         # removed, and for non-nobranch, we truncate the branch to our
@@ -673,7 +673,7 @@ class Git(FetchMethod):
             # If 'subdir' param exists, create a dir and use it as destina=
tion for unpack cmd
             if os.path.isabs(subdir):
                 if not os.path.realpath(subdir).startswith(os.path.realpat=
h(destdir)):
-                    raise bb.fetch2.UnpackError("subdir argument isn't a s=
ubdirectory of unpack root %s" % destdir, ud.url)
+                    raise bb.fetch.UnpackError("subdir argument isn't a su=
bdirectory of unpack root %s" % destdir, ud.url)
                 destdir =3D subdir
             else:
                 destdir =3D os.path.join(destdir, subdir)
@@ -721,35 +721,35 @@ class Git(FetchMethod):
                 source_error.append("shallow clone not enabled")
=20
         if not source_found:
-            raise bb.fetch2.UnpackError("No up to date source found: " + "=
; ".join(source_error), ud.url)
+            raise bb.fetch.UnpackError("No up to date source found: " + ";=
 ".join(source_error), ud.url)
=20
         if update_mode:
             if ud.shallow:
-                raise bb.fetch2.UnpackError("Can't update shallow clones c=
heckouts without network access, not supported.", ud.url)
+                raise bb.fetch.UnpackError("Can't update shallow clones ch=
eckouts without network access, not supported.", ud.url)
=20
             output =3D runfetchcmd(ud.basecmd + ['status', '--untracked-fi=
les=3Dno', '--porcelain'], d, workdir=3Ddestdir, extraenv=3Dextraenv)
             if output:
-                raise bb.fetch2.LocalModificationsError(destdir, ud.url, o=
utput)
+                raise bb.fetch.LocalModificationsError(destdir, ud.url, ou=
tput)
=20
             # Set up remote for the download location if it doesn't exist
             try:
                 runfetchcmd(ud.basecmd + ['remote', 'get-url', 'dldir'], d=
, workdir=3Ddestdir)
-            except bb.fetch2.FetchError:
+            except bb.fetch.FetchError:
                 if ud.clonedir:
                     runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', 'f=
ile://' + ud.clonedir], d, workdir=3Ddestdir)
             try:
                 runfetchcmd(ud.basecmd + ['fetch', 'dldir'], d, workdir=3D=
destdir, extraenv=3Dextraenv)
-            except bb.fetch2.FetchError as e:
-                raise bb.fetch2.UnpackError("Failed to fetch from dldir re=
mote: %s" % str(e), ud.url)
+            except bb.fetch.FetchError as e:
+                raise bb.fetch.UnpackError("Failed to fetch from dldir rem=
ote: %s" % str(e), ud.url)
             try:
                 runfetchcmd(ud.basecmd + ['rebase', '--no-autosquash', '--=
no-autostash', ud.revision], d, workdir=3Ddestdir, extraenv=3Dextraenv)
-            except bb.fetch2.FetchError as e:
+            except bb.fetch.FetchError as e:
                 # If rebase failed, abort it
                 try:
                     runfetchcmd(ud.basecmd + ['rebase', '--abort'], d, wor=
kdir=3Ddestdir)
                 except Exception:
                     pass
-                raise bb.fetch2.RebaseError(destdir, ud.url, str(e))
+                raise bb.fetch.RebaseError(destdir, ud.url, str(e))
             return True
=20
         # If there is a tag parameter in the url and we also have a fixed =
srcrev, check the tag
@@ -763,14 +763,14 @@ class Git(FetchMethod):
                 output2 =3D runfetchcmd(ud.basecmd + ['rev-list', '-n', '1=
', ud.revision], d, workdir=3Ddestdir)
                 output2 =3D output2.strip()
                 if output !=3D output2:
-                    raise bb.fetch2.FetchError("The revision the git tag '=
%s' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag'=
], output, ud.revision), ud.url)
+                    raise bb.fetch.FetchError("The revision the git tag '%=
s' resolved to didn't match the SRCREV in use (%s vs %s)" % (ud.parm['tag']=
, output, ud.revision), ud.url)
=20
         repourl =3D self._get_repo_url(ud)
         runfetchcmd(ud.basecmd + ['remote', 'set-url', 'origin', repourl],=
 d, workdir=3Ddestdir)
         if ud.clonedir:
             try:
                 runfetchcmd(ud.basecmd + ['remote', 'get-url', 'dldir'], d=
, workdir=3Ddestdir)
-            except bb.fetch2.FetchError:
+            except bb.fetch.FetchError:
                 runfetchcmd(ud.basecmd + ['remote', 'add', 'dldir', "file:=
//" + ud.clonedir], d, workdir=3Ddestdir)
=20
         if self._contains_lfs(ud, d, destdir):
@@ -830,7 +830,7 @@ class Git(FetchMethod):
             cmd =3D ud.basecmd + ['branch', '--contains', git_ref_name, '-=
-list', ud.branch]
         try:
             output =3D runfetchcmd(cmd, d, workdir=3Dwd)
-        except (bb.fetch2.FetchError):
+        except (bb.fetch.FetchError):
             return False
         return len(output.splitlines()) > 0
=20
@@ -876,7 +876,7 @@ class Git(FetchMethod):
             output =3D runfetchcmd(cmd, d, quiet=3DTrue, workdir=3Dwd)
             if len(output.splitlines()) > 0:
                 return True
-        except (bb.fetch2.FetchError,ValueError):
+        except (bb.fetch.FetchError,ValueError):
             pass
         return False
=20
@@ -885,7 +885,7 @@ class Git(FetchMethod):
         Ensures that git-lfs is available, raising a FetchError if it isn'=
t.
         """
         if shutil.which("git-lfs", path=3Dd.getVar('PATH')) is None:
-            raise bb.fetch2.FetchError(
+            raise bb.fetch.FetchError(
                 "Repository %s has LFS content, install git-lfs on host to=
 download (or set lfs=3D0 "
                 "to ignore it)" % self._get_repo_url(ud))
=20
@@ -930,10 +930,10 @@ class Git(FetchMethod):
             if search:
                 cmd.append(search)
             if ud.proto.lower() !=3D 'file':
-                bb.fetch2.check_network_access(d, cmd, repourl)
+                bb.fetch.check_network_access(d, cmd, repourl)
             output =3D runfetchcmd(cmd, d, True)
             if not output:
-                raise bb.fetch2.FetchError("The command %s gave empty outp=
ut unexpectedly" % cmd, ud.url)
+                raise bb.fetch.FetchError("The command %s gave empty outpu=
t unexpectedly" % cmd, ud.url)
         finally:
             d.delVar('_BB_GIT_IN_LSREMOTE')
         return output
@@ -943,10 +943,10 @@ class Git(FetchMethod):
         Compute the HEAD revision for the url
         """
         if not d.getVar("__BBSRCREV_SEEN"):
-            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch =
'%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch2.get_sr=
crev() (use SRCPV in PV for OE)." % (ud.unresolvedrev, ud.host+ud.path))
+            raise bb.fetch.FetchError("Recipe uses a floating tag/branch '=
%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch.get_srcr=
ev() (use SRCPV in PV for OE)." % (ud.unresolvedrev, ud.host+ud.path))
=20
         # Ensure we mark as not cached
-        bb.fetch2.mark_recipe_nocache(d)
+        bb.fetch.mark_recipe_nocache(d)
=20
         output =3D self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other for=
m
@@ -961,7 +961,7 @@ class Git(FetchMethod):
                 sha1, ref =3D l.split()
                 if s =3D=3D ref:
                     return sha1
-        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git=
 repository in git ls-remote output for %s" % \
+        raise bb.fetch.FetchError("Unable to resolve '%s' in upstream git =
repository in git ls-remote output for %s" % \
             (ud.unresolvedrev, ud.host+ud.path))
=20
     def latest_versionstring(self, ud, d, filter_regex=3DNone):
@@ -974,7 +974,7 @@ class Git(FetchMethod):
=20
         try:
             output =3D self._lsremote(ud, d, "refs/tags/*")
-        except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess) as e:
+        except (bb.fetch.FetchError, bb.fetch.NetworkAccess) as e:
             bb.note("Could not list remote: %s" % str(e))
             return pupver
=20
@@ -1031,7 +1031,7 @@ class Git(FetchMethod):
             commits =3D None
         else:
             if not os.path.exists(rev_file) or not os.path.getsize(rev_fil=
e):
-                commits =3D len(bb.fetch2.runfetchcmd(['git', 'rev-list', =
rev, '--'], d).splitlines())
+                commits =3D len(bb.fetch.runfetchcmd(['git', 'rev-list', r=
ev, '--'], d).splitlines())
                 if commits:
                     open(rev_file, "w").write("%d\n" % commits)
             else:
@@ -1045,5 +1045,5 @@ class Git(FetchMethod):
         try:
             self._lsremote(ud, d, "")
             return True
-        except bb.fetch2.FetchError:
+        except bb.fetch.FetchError:
             return False
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch/gitannex.py
similarity index 97%
rename from lib/bb/fetch2/gitannex.py
rename to lib/bb/fetch/gitannex.py
index c378cc36d..d5917e54f 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch/gitannex.py
@@ -9,8 +9,8 @@ BitBake 'Fetch' git annex implementation
 #
=20
 import bb
-from   bb.fetch2.git import Git
-from   bb.fetch2 import runfetchcmd
+from   bb.fetch.git import Git
+from   bb.fetch import runfetchcmd
=20
 class GitANNEX(Git):
     def supports(self, ud, d):
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch/gitsm.py
similarity index 97%
rename from lib/bb/fetch2/gitsm.py
rename to lib/bb/fetch/gitsm.py
index d4340e116..734b35364 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch/gitsm.py
@@ -22,10 +22,10 @@ import bb
 import copy
 import shutil
 import tempfile
-from   bb.fetch2.git import Git
-from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
-from   bb.fetch2 import Fetch
+from   bb.fetch.git import Git
+from   bb.fetch import runfetchcmd
+from   bb.fetch import logger
+from   bb.fetch import Fetch
=20
 class GitSM(Git):
     def supports(self, ud, d):
@@ -115,7 +115,7 @@ class GitSM(Git):
                     proto =3D "file"
                     url =3D "gitsm://" + uris[module]
             if url.endswith("{}{}".format(ud.host, ud.path)):
-                raise bb.fetch2.FetchError("Submodule refers to the parent=
 repository. This will cause deadlock situation in current version of Bitba=
ke." \
+                raise bb.fetch.FetchError("Submodule refers to the parent =
repository. This will cause deadlock situation in current version of Bitbak=
e." \
                                            "Consider using git fetcher ins=
tead.")
=20
             url +=3D ';protocol=3D%s' % proto
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch/gomod.py
similarity index 97%
rename from lib/bb/fetch2/gomod.py
rename to lib/bb/fetch/gomod.py
index 5cdf8f998..a62d643fb 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch/gomod.py
@@ -67,12 +67,12 @@ import subprocess
 import zipfile
=20
 import bb
-from bb.fetch2 import FetchError
-from bb.fetch2 import MissingParameterError
-from bb.fetch2 import runfetchcmd
-from bb.fetch2 import subprocess_setup
-from bb.fetch2.git import Git
-from bb.fetch2.wget import Wget
+from bb.fetch import FetchError
+from bb.fetch import MissingParameterError
+from bb.fetch import runfetchcmd
+from bb.fetch import subprocess_setup
+from bb.fetch.git import Git
+from bb.fetch.wget import Wget
=20
=20
 def escape(path):
@@ -115,7 +115,7 @@ class GoMod(Wget):
         else:
             ext =3D '.zip'
         path =3D escape(f"{module}/@v/{version}{ext}")
-        ud.url =3D bb.fetch2.encodeurl(
+        ud.url =3D bb.fetch.encodeurl(
             ('https', proxy, '/' + path, None, None, None))
         ud.parm['downloadfilename'] =3D  f"{module.replace('/', '.')}@{ver=
sion}{ext}"
=20
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch/hg.py
similarity index 95%
rename from lib/bb/fetch2/hg.py
rename to lib/bb/fetch/hg.py
index 5c65a1985..9813b0edd 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch/hg.py
@@ -16,11 +16,11 @@ import os
 import bb
 import errno
 import shlex
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import FetchError
-from bb.fetch2 import MissingParameterError
-from bb.fetch2 import runfetchcmd
-from bb.fetch2 import logger
+from bb.fetch import FetchMethod
+from bb.fetch import FetchError
+from bb.fetch import MissingParameterError
+from bb.fetch import runfetchcmd
+from bb.fetch import logger
=20
 class Hg(FetchMethod):
     """Class to fetch from mercurial repositories"""
@@ -159,13 +159,13 @@ class Hg(FetchMethod):
             logger.debug("Running %s", updatecmd)
             try:
                 runfetchcmd(updatecmd, d, workdir=3Dud.moddir)
-            except bb.fetch2.FetchError:
+            except bb.fetch.FetchError:
                 # Runnning pull in the repo
                 pullcmd =3D self._buildhgcommand(ud, d, "pull")
                 logger.info("Pulling " + ud.url)
                 # update sources there
                 logger.debug("Running %s", pullcmd)
-                bb.fetch2.check_network_access(d, pullcmd, ud.url)
+                bb.fetch.check_network_access(d, pullcmd, ud.url)
                 runfetchcmd(pullcmd, d, workdir=3Dud.moddir)
                 try:
                     os.unlink(ud.fullmirror)
@@ -180,7 +180,7 @@ class Hg(FetchMethod):
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
             logger.debug("Running %s", fetchcmd)
-            bb.fetch2.check_network_access(d, fetchcmd, ud.url)
+            bb.fetch.check_network_access(d, fetchcmd, ud.url)
             runfetchcmd(fetchcmd, d, workdir=3Dud.pkgdir)
=20
         # Even when we clone (fetch), we still need to update as hg's clon=
e
@@ -203,7 +203,7 @@ class Hg(FetchMethod):
         """
         Compute tip revision for the url
         """
-        bb.fetch2.check_network_access(d, self._buildhgcommand(ud, d, "inf=
o"), ud.url)
+        bb.fetch.check_network_access(d, self._buildhgcommand(ud, d, "info=
"), ud.url)
         output =3D runfetchcmd(self._buildhgcommand(ud, d, "info"), d)
         return output.strip()
=20
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch/local.py
similarity index 91%
rename from lib/bb/fetch2/local.py
rename to lib/bb/fetch/local.py
index fda56a564..dfc5b564c 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch/local.py
@@ -17,8 +17,8 @@ import os
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
-from   bb.fetch2 import FetchMethod, FetchError, ParameterError
-from   bb.fetch2 import logger
+from   bb.fetch import FetchMethod, FetchError, ParameterError
+from   bb.fetch import logger
=20
 class Local(FetchMethod):
     def supports(self, urldata, d):
@@ -33,7 +33,7 @@ class Local(FetchMethod):
         ud.basepath =3D ud.path
         ud.needdonestamp =3D False
         if "*" in ud.path:
-            raise bb.fetch2.ParameterError("file:// urls using globbing ar=
e no longer supported. Please place the files in a directory and reference =
that instead.", ud.url)
+            raise bb.fetch.ParameterError("file:// urls using globbing are=
 no longer supported. Please place the files in a directory and reference t=
hat instead.", ud.url)
         return
=20
     def localpath(self, urldata, d):
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch/npm.py
similarity index 97%
rename from lib/bb/fetch2/npm.py
rename to lib/bb/fetch/npm.py
index a429a8292..c8995ba6b 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch/npm.py
@@ -35,15 +35,15 @@ import re
 import shlex
 import tempfile
 import bb
-from bb.fetch2 import Fetch
-from bb.fetch2 import FetchError
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import MalformedUrl
-from bb.fetch2 import MissingParameterError
-from bb.fetch2 import ParameterError
-from bb.fetch2 import URI
-from bb.fetch2 import check_network_access
-from bb.fetch2 import runfetchcmd
+from bb.fetch import Fetch
+from bb.fetch import FetchError
+from bb.fetch import FetchMethod
+from bb.fetch import MalformedUrl
+from bb.fetch import MissingParameterError
+from bb.fetch import ParameterError
+from bb.fetch import URI
+from bb.fetch import check_network_access
+from bb.fetch import runfetchcmd
 from bb.utils import is_semver
=20
 # Preference order matches strength; the first one present in SRC_URI wins=
.
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch/npmsw.py
similarity index 96%
rename from lib/bb/fetch2/npmsw.py
rename to lib/bb/fetch/npmsw.py
index f09ea5794..fde4fe65b 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch/npmsw.py
@@ -21,15 +21,15 @@ import json
 import os
 import re
 import bb
-from bb.fetch2 import FetchError
-from bb.fetch2 import Fetch
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import ParameterError
-from bb.fetch2 import runfetchcmd
-from bb.fetch2 import URI
-from bb.fetch2.npm import npm_integrity
-from bb.fetch2.npm import npm_localfile
-from bb.fetch2.npm import npm_unpack
+from bb.fetch import FetchError
+from bb.fetch import Fetch
+from bb.fetch import FetchMethod
+from bb.fetch import ParameterError
+from bb.fetch import runfetchcmd
+from bb.fetch import URI
+from bb.fetch.npm import npm_integrity
+from bb.fetch.npm import npm_localfile
+from bb.fetch.npm import npm_unpack
 from bb.utils import is_semver
 from bb.utils import lockfile
 from bb.utils import unlockfile
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch/perforce.py
similarity index 96%
rename from lib/bb/fetch2/perforce.py
rename to lib/bb/fetch/perforce.py
index 52ea061c0..aa46e0ebc 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch/perforce.py
@@ -27,10 +27,10 @@ Supported SRC_URI options are:
 import os
 import bb
 import shlex
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import logger
-from   bb.fetch2 import runfetchcmd
+from   bb.fetch import FetchMethod
+from   bb.fetch import FetchError
+from   bb.fetch import logger
+from   bb.fetch import runfetchcmd
=20
 class PerforceProgressHandler (bb.progress.BasicProgressHandler):
     """
@@ -97,7 +97,7 @@ class Perforce(FetchMethod):
             logger.debug('Trying to use P4CONFIG to automatically set P4PO=
RT...')
             ud.usingp4config =3D True
             p4cmd =3D ud.basecmd + ['info']
-            bb.fetch2.check_network_access(d, p4cmd, ud.url)
+            bb.fetch.check_network_access(d, p4cmd, ud.url)
             output =3D runfetchcmd(p4cmd, d, True)
             ud.host =3D None
             for line in output.splitlines():
@@ -201,7 +201,7 @@ class Perforce(FetchMethod):
         'p4 files' command, including trailing '#rev' file revision indica=
tor
         """
         p4cmd =3D self._buildp4command(ud, d, 'files')
-        bb.fetch2.check_network_access(d, p4cmd, ud.url)
+        bb.fetch.check_network_access(d, p4cmd, ud.url)
         p4fileslist =3D runfetchcmd(p4cmd, d, True)
         p4fileslist =3D [f.rstrip() for f in p4fileslist.splitlines()]
=20
@@ -234,7 +234,7 @@ class Perforce(FetchMethod):
=20
         for afile in filelist:
             p4fetchcmd =3D self._buildp4command(ud, d, 'print', afile)
-            bb.fetch2.check_network_access(d, p4fetchcmd, ud.url)
+            bb.fetch.check_network_access(d, p4fetchcmd, ud.url)
             runfetchcmd(p4fetchcmd, d, workdir=3Dud.pkgdir, log=3Dprogress=
handler)
=20
         runfetchcmd(['tar', '-czf', ud.localpath, 'p4'], d, cleanup=3D[ud.=
localpath], workdir=3Dud.pkgdir)
@@ -254,7 +254,7 @@ class Perforce(FetchMethod):
     def _latest_revision(self, ud, d, name):
         """ Return the latest upstream scm revision number """
         p4cmd =3D self._buildp4command(ud, d, "changes")
-        bb.fetch2.check_network_access(d, p4cmd, ud.url)
+        bb.fetch.check_network_access(d, p4cmd, ud.url)
         tip =3D runfetchcmd(p4cmd, d, True)
=20
         if not tip:
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch/repo.py
similarity index 89%
rename from lib/bb/fetch2/repo.py
rename to lib/bb/fetch/repo.py
index 9b96cd824..c7eaf8b3c 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch/repo.py
@@ -14,9 +14,9 @@ BitBake "Fetch" repo (git) implementation
 import os
 import bb
 import shlex
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
+from   bb.fetch import FetchMethod
+from   bb.fetch import runfetchcmd
+from   bb.fetch import logger
=20
 class Repo(FetchMethod):
     """Class to fetch a module or modules from repo (git) repositories"""
@@ -63,10 +63,10 @@ class Repo(FetchMethod):
         repodir =3D os.path.join(codir, "repo")
         bb.utils.mkdirhier(repodir)
         if not os.path.exists(os.path.join(repodir, ".repo")):
-            bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s:/=
/%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host=
, ud.path), ud.url)
+            bb.fetch.check_network_access(d, "%s init -m %s -b %s -u %s://=
%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host,=
 ud.path), ud.url)
             runfetchcmd(ud.basecmd + ['init', '-m', ud.manifest, '-b', ud.=
branch, '-u', '%s://%s%s%s' % (ud.proto, username, ud.host, ud.path)], d, w=
orkdir=3Drepodir)
=20
-        bb.fetch2.check_network_access(d, ud.basecmd + ['sync'], ud.url)
+        bb.fetch.check_network_access(d, ud.basecmd + ['sync'], ud.url)
         runfetchcmd(ud.basecmd + ['sync'], d, workdir=3Drepodir)
=20
         scmdata =3D ud.parm.get("scmdata", "")
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch/s3.py
similarity index 93%
rename from lib/bb/fetch2/s3.py
rename to lib/bb/fetch/s3.py
index fdd450429..ea3dc28fc 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch/s3.py
@@ -8,7 +8,7 @@ The aws tool must be correctly installed and configured pri=
or to use.
=20
 # Copyright (C) 2017, Andre McCurdy <armccurdy@gmail.com>
 #
-# Based in part on bb.fetch2.wget:
+# Based in part on bb.fetch.wget:
 #    Copyright (C) 2003, 2004  Chris Larson
 #
 # SPDX-License-Identifier: GPL-2.0-only
@@ -20,9 +20,9 @@ import bb
 import urllib.request, urllib.parse, urllib.error
 import re
 import shlex
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import FetchError
-from bb.fetch2 import runfetchcmd
+from bb.fetch import FetchMethod
+from bb.fetch import FetchError
+from bb.fetch import runfetchcmd
=20
 def convertToBytes(value, unit):
     value =3D float(value)
@@ -89,7 +89,7 @@ class S3(FetchMethod):
         """
=20
         cmd =3D ud.basecmd + ['cp', 's3://%s%s' % (ud.host, ud.path), ud.l=
ocalpath]
-        bb.fetch2.check_network_access(d, cmd, ud.url)
+        bb.fetch.check_network_access(d, cmd, ud.url)
=20
         progresshandler =3D S3ProgressHandler(d)
         runfetchcmd(cmd, d, False, log=3Dprogresshandler)
@@ -113,7 +113,7 @@ class S3(FetchMethod):
         """
=20
         cmd =3D ud.basecmd + ['ls', 's3://%s%s' % (ud.host, ud.path)]
-        bb.fetch2.check_network_access(d, cmd, ud.url)
+        bb.fetch.check_network_access(d, cmd, ud.url)
         output =3D runfetchcmd(cmd, d)
=20
         # "aws s3 ls s3://mybucket/foo" will exit with success even if the=
 file
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch/sftp.py
similarity index 93%
rename from lib/bb/fetch2/sftp.py
rename to lib/bb/fetch/sftp.py
index 82c76bb66..4054382d7 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch/sftp.py
@@ -39,7 +39,7 @@ SRC_URI =3D "sftp://user@host.example.com/dir/path.file.t=
xt"
=20
 # Copyright (C) 2013, Olof Johansson <olof.johansson@axis.com>
 #
-# Based in part on bb.fetch2.wget:
+# Based in part on bb.fetch.wget:
 #    Copyright (C) 2003, 2004  Chris Larson
 #
 # SPDX-License-Identifier: GPL-2.0-only
@@ -49,9 +49,9 @@ SRC_URI =3D "sftp://user@host.example.com/dir/path.file.t=
xt"
 import os
 import bb
 import urllib.request, urllib.parse, urllib.error
-from bb.fetch2 import URI
-from bb.fetch2 import FetchMethod
-from bb.fetch2 import runfetchcmd
+from bb.fetch import URI
+from bb.fetch import FetchMethod
+from bb.fetch import runfetchcmd
=20
 class SFTP(FetchMethod):
     """Class to fetch urls via 'sftp'"""
@@ -67,7 +67,7 @@ class SFTP(FetchMethod):
=20
     def urldata_init(self, ud, d):
         if 'protocol' in ud.parm and ud.parm['protocol'] =3D=3D 'git':
-            raise bb.fetch2.ParameterError(
+            raise bb.fetch.ParameterError(
                 "Invalid protocol - if you wish to fetch from a " +
                 "git repository using ssh, you need to use the " +
                 "git:// prefix with protocol=3Dssh", ud.url)
@@ -106,6 +106,6 @@ class SFTP(FetchMethod):
=20
         cmd =3D basecmd + [remote, lpath]
=20
-        bb.fetch2.check_network_access(d, cmd, ud.url)
+        bb.fetch.check_network_access(d, cmd, ud.url)
         runfetchcmd(cmd, d)
         return True
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch/ssh.py
similarity index 98%
rename from lib/bb/fetch2/ssh.py
rename to lib/bb/fetch/ssh.py
index 56e455fb4..304872ad0 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch/ssh.py
@@ -31,7 +31,7 @@ IETF secsh internet draft:
 #
=20
 import re, os
-from bb.fetch2 import check_network_access, FetchMethod, ParameterError, r=
unfetchcmd
+from bb.fetch import check_network_access, FetchMethod, ParameterError, ru=
nfetchcmd
 import urllib
=20
=20
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch/svn.py
similarity index 94%
rename from lib/bb/fetch2/svn.py
rename to lib/bb/fetch/svn.py
index 973f76f00..73ce83f4e 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch/svn.py
@@ -14,11 +14,11 @@ import os
 import bb
 import re
 import shlex
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import MissingParameterError
-from   bb.fetch2 import runfetchcmd
-from   bb.fetch2 import logger
+from   bb.fetch import FetchMethod
+from   bb.fetch import FetchError
+from   bb.fetch import MissingParameterError
+from   bb.fetch import runfetchcmd
+from   bb.fetch import logger
=20
 class Svn(FetchMethod):
     """Class to fetch a module or modules from svn repositories"""
@@ -141,7 +141,7 @@ class Svn(FetchMethod):
                 except FetchError:
                     pass
                 logger.debug("Running %s", svncmd)
-                bb.fetch2.check_network_access(d, svncmd, ud.url)
+                bb.fetch.check_network_access(d, svncmd, ud.url)
                 runfetchcmd(svncmd, d, workdir=3Dud.moddir, extraenv=3Dext=
raenv)
             else:
                 svncmd, extraenv =3D self._buildsvncommand(ud, d, "fetch")
@@ -149,7 +149,7 @@ class Svn(FetchMethod):
                 # check out sources there
                 bb.utils.mkdirhier(ud.pkgdir)
                 logger.debug("Running %s", svncmd)
-                bb.fetch2.check_network_access(d, svncmd, ud.url)
+                bb.fetch.check_network_access(d, svncmd, ud.url)
                 runfetchcmd(svncmd, d, workdir=3Dud.pkgdir, extraenv=3Dext=
raenv)
=20
             if not ("externals" in ud.parm and ud.parm["externals"] =3D=3D=
 "nowarn"):
@@ -164,7 +164,7 @@ class Svn(FetchMethod):
                             bb.warn("To disable this warning add ';externa=
ls=3Dnowarn' to the url.")
                         else:
                             bb.debug(1, "svn repository has externals:\n%s=
" % output)
-                except bb.fetch2.FetchError:
+                except bb.fetch.FetchError:
                     passs
             scmdata =3D ud.parm.get("scmdata", "")
             if scmdata =3D=3D "keep":
@@ -199,7 +199,7 @@ class Svn(FetchMethod):
         Return the latest upstream revision number
         """
         cmd, extraenv =3D self._buildsvncommand(ud, d, "log1")
-        bb.fetch2.check_network_access(d, cmd, ud.url)
+        bb.fetch.check_network_access(d, cmd, ud.url)
         extraenv['LANG'] =3D 'C'
         extraenv['LC_ALL'] =3D 'C'
         output =3D runfetchcmd(cmd, d, True, extraenv=3Dextraenv)
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch/wget.py
similarity index 98%
rename from lib/bb/fetch2/wget.py
rename to lib/bb/fetch/wget.py
index 0d2b7f5c8..7b05a9ef2 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch/wget.py
@@ -23,10 +23,10 @@ import socket
 import http.client
 import urllib.request, urllib.parse, urllib.error
 import subprocess
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import logger
-from   bb.fetch2 import runfetchcmd
+from   bb.fetch import FetchMethod
+from   bb.fetch import FetchError
+from   bb.fetch import logger
+from   bb.fetch import runfetchcmd
 from   bb._vendor.bs4 import BeautifulSoup
 from   bb._vendor.bs4 import SoupStrainer
=20
@@ -94,7 +94,7 @@ class Wget(FetchMethod):
     def urldata_init(self, ud, d):
         if 'protocol' in ud.parm:
             if ud.parm['protocol'] =3D=3D 'git':
-                raise bb.fetch2.ParameterError("Invalid protocol - if you =
wish to fetch from a git repository using http, you need to instead use the=
 git:// prefix with protocol=3Dhttp", ud.url)
+                raise bb.fetch.ParameterError("Invalid protocol - if you w=
ish to fetch from a git repository using http, you need to instead use the =
git:// prefix with protocol=3Dhttp", ud.url)
=20
         if 'downloadfilename' in ud.parm:
             ud.basename =3D ud.parm['downloadfilename']
@@ -118,7 +118,7 @@ class Wget(FetchMethod):
         progresshandler =3D WgetProgressHandler(d)
=20
         logger.debug2("Fetching %s using command '%s'" % (ud.url, command)=
)
-        bb.fetch2.check_network_access(d, command, ud.url)
+        bb.fetch.check_network_access(d, command, ud.url)
=20
         runfetchcmd(command + ['--progress=3Ddot', '--verbose'], d, quiet,=
 log=3Dprogresshandler, workdir=3Dworkdir)
=20
@@ -167,7 +167,7 @@ class Wget(FetchMethod):
         # Try and verify any checksum now, meaning if it isn't correct, we=
 don't remove the
         # original file, which might be a race (imagine two recipes refere=
ncing the same
         # source, one with an incorrect checksum)
-        bb.fetch2.verify_checksum(ud, d, localpath=3Dlocalpath, fatal_noch=
ecksum=3DFalse)
+        bb.fetch.verify_checksum(ud, d, localpath=3Dlocalpath, fatal_noche=
cksum=3DFalse)
=20
         # Remove the ".tmp" and move the file into position atomically
         # Our lock prevents multiple writers but mirroring code may grab i=
ncomplete files
@@ -177,7 +177,7 @@ class Wget(FetchMethod):
=20
     def checkstatus(self, fetch, ud, d, try_again=3DTrue):
         check_certs =3D self.check_certs(d)
-        newenv =3D bb.fetch2.get_fetcher_environment(d)
+        newenv =3D bb.fetch.get_fetcher_environment(d)
=20
         class HTTPConnectionCache(http.client.HTTPConnection):
             def cache_id(self):
@@ -568,7 +568,7 @@ class Wget(FetchMethod):
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=3Dworkdir)
                 fetchresult =3D f.read()
-            except bb.fetch2.BBFetchException:
+            except bb.fetch.BBFetchException:
                 fetchresult =3D ""
=20
         return fetchresult
diff --git a/lib/bb/fetch2.py b/lib/bb/fetch2.py
new file mode 100644
index 000000000..e64017016
--- /dev/null
+++ b/lib/bb/fetch2.py
@@ -0,0 +1,19 @@
+#
+# Copyright (C) 2026 Agilent Technologies, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import sys
+import warnings
+
+import bb.fetch
+
+warnings.warn(
+    "bb.fetch2 is deprecated; use bb.fetch instead",
+    DeprecationWarning,
+    stacklevel=3D2,
+)
+
+# Compatibility shim for code using bb.fetch2
+sys.modules[__name__] =3D bb.fetch
--=20
2.43.0


