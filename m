Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF99C61DCD
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 14:30:56 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37440.1787841053950374392
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 07:30:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=cAhC/xbh;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.194.14, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed4HMG5Y9IVvQ8FTH4DeckMB6d/dc4muzdHa8mYJQmBguxKxIjVKeXDi5vBM0AFUJDE+je7/zO6CjCXsGmMMd85Rx8CjD1JE1qCfSVBKLHhUEQR9dA5H0MUCl//aP9e+cbCCFHpjmshtuPS+V4we4C9i5XRub0/JsFE+25x5eCNAatvrEJ2S0GKBKp4uQVxau/QqJuTmbHI46ry5Bn1r3tyTw96McTNuOg+yMhBO91rRS93sk88Y8DUfDAMoZvGvSlioBKUXI2grzultA2oZGK75nWh0rXpX2m9RIp1k2HUegRfKVACNiDkcoKvtTikGzMEyiOyayYOuNkPt1vezeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdXmxsBXyQJXP1dLQYs2T6czGQ/cOkZXR43n3b8+Rqw=;
 b=q9cZHRl28HnbcP+DvexAIkNSIzKO2HUkrvo7lMJqyXLN7gIcmnE8UwLOHuW25JRapTSN66BQ3nNhZ/Ga4MNziOzX+troPQMtDmIVtly0QUfFil6xlaLE/Gj5UwTKsGPOXym5F4kB3kvzFC0Lx5jX9kaEf1cM8ucYu6itpaTvEYVvbjQqLPtGjWNtZGGBdYQdkr0YY9UzPDGshelgU1lsNDZharYugzwEXHn1jzKGlAs2FQRBHdZ6quZtjokubzLE28jtjAjn40VxUdv6fMhEKY6X0vzmtMA4D6Fqt0luP3UALFThso0n9tYNpCbgrmYVHiKvySJh4D1LWEiIV3jO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdXmxsBXyQJXP1dLQYs2T6czGQ/cOkZXR43n3b8+Rqw=;
 b=cAhC/xbhjEuVG2GkieyJAR3KzSad01kJVf9EMDKxA97F3Tvbs+SowtwNDQ8ic5xhJG5JkyTpQQ/U4hMtbsW7m/DymfCCiNf6l/NqaYFBwY8Qj8ACYq+Xx0dD/Tzr4WBMcow9oO+N/DVt2OiOIIaTXjWKYQPEi3JZId7I0oSDBE2Qk6tvO3rU7RlzJ6+3BJ5QsenSK1+2f8I1p4ScJN/B/eKO6hkqI5aWSrln+qm2I9FdoXoVGqja9Ijw2MIEYPGESWixxxV2E+iOD2ouXBb22Wn9Z9QdLxh0uvlWaL25ET9fxRkzPTSjxsH4asLKuuusn7ZJWaAXAoH/s4/LDba4UA==
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:30:49 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:32f:cafe::52) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 14:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Thu, 27 Aug 2026 14:30:49 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 08:30:14 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/4] bin, lib, conf: use bb.fetch instead of bb.fetch2
Date: Thu, 27 Aug 2026 10:29:56 -0400
Message-ID: <20260827142958.547182-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827142958.547182-1-chris.laplante@agilent.com>
References: <20260827142958.547182-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7267f3-8dd8-4958-5c24-08df0447ca51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	9QcLWREzFxjZii8+tjfnrztgSPhrU+pJx5RzRqbpsh5kLiOXKZF4vpCH+T6z1CQR3GZ7D37Q03IlVD2kwt2Z+6owAlJwclpOlIBF0c5FUzccm5CAlWn5bmFk0efPIkmweIsRz/NgpA9nqktZUnUeYkNV4Chb3c11lltGChESE7kDpa+OY/+bC1GajxdZMhmwrCNIE/tBDggoprtp3+TE99frrllNMZA3aAShO1NEIPCikHvMEbxnngB1M5MVAu8l5232SMzJrnBIAeo5NcYRzybZPNitceY5l+o17ffwJbMx/fHS3JeJRG6RwiyZWWWZLJ+3qQGdAIuIE5MhzdcqFniHi/C4/ug75kxRD/NL3YxyMfvGQWZmkcGt3wNTR1NvkgY1w2iKICS1bjqAVsE3ocN1/GEhc12v/ZALVkCygIxrhmZ8DrEmgRS14WfwztpXPvEwDleX/lguJGSDwCBWIElKFSk/NZ/RpQu97wqzohJEeUaRxtDphyidroQbNJ4V0eeJqUQrUZLM4OSTHtx8FRrRt/5pJPriX5XlxwqCgzUEf+OUYPnbxyGVp8+O3aDRjkz28rtrw0jlNfkynzc/FbljleNmXVoi+rKr9HgVqM3m7dpJJ7LPDqkjvxTXf4s2Xnwg/cf0Jdn5cP5v2H0N3w==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	eVW0kz172RdytbqGdonu1zFJ52UfHSNj1tJGetwLCb/ouxbwpqmxfx92XBVdxoMNBW+UT95p0fflllIi8CQYZBHO7Cli7JXmHSnp+MX3YeU1JqTtUFiRvMhymOYW+25zV74J3M5RpEbQCOpFd5VoHKbb+/w5spTJUV8WXlr3RDbfz+JrBCmF3XiEf1Zsfm6BUdmUWYAhX7mTaasS+1+ZKUmo/uEe8L+ZWT8261dYhy3Un0MaIJzGVDqy5p3VjJiY+H9TsgAZRPQUx9JH5VCGvQRS8qpRXb6XpyGUPMtpkjo4a3Flpg0XfZR/ZDgvHsRfz5OGKMBLBsoV674cgTuFu9u9aw9syRSpbfwlJDahle3/ZYHqysH4yrF/r+NTbj5VW7Gqcqe2cuMqcpApJVdRrt172RGNPzLcgcNExLaRX56HtgSO9aWVSjjZITfAq2DV
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:30:49.2026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7267f3-8dd8-4958-5c24-08df0447ca51
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 14:30:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20070

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-setup     |  13 +--
 bin/bitbake-worker    |   2 +-
 conf/bitbake.conf     |   2 +-
 lib/bb/command.py     |   1 +
 lib/bb/cooker.py      |   7 +-
 lib/bb/cookerdata.py  |   2 +-
 lib/bb/siggen.py      |   7 +-
 lib/bb/tests/fetch.py | 230 +++++++++++++++++++++---------------------
 lib/bb/tinfoil.py     |   2 +-
 lib/bb/utils.py       |   2 +-
 10 files changed, 136 insertions(+), 132 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 92ed563c2..35d9730ae 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -27,6 +27,7 @@ bindir =3D os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), 'lib')]
=20
 import bb.msg  # noqa: E402
+import bb.fetch  # noqa: E402
 import bb.process  # noqa: E402
 from bb import __version__ as libbb_version # noqa: E402
=20
@@ -108,8 +109,8 @@ def init_bb_cache(top_dir, settings, args):
     return d
=20
 def save_bb_cache():
-    bb.fetch2.fetcher_parse_save()
-    bb.fetch2.fetcher_parse_done()
+    bb.fetch.fetcher_parse_save()
+    bb.fetch.fetcher_parse_done()
=20
 def get_config_name(config):
     suffix =3D '.conf.json'
@@ -192,7 +193,7 @@ def checkout_layers(layers, confdir, layerdir, d, rebas=
e_conflicts_strategy=3D'abo
             repodir_path =3D os.path.join(layerdir, repodir)
             try:
                 do_fetch(fetcher, layerdir)
-            except (bb.fetch2.LocalModificationsError, bb.fetch2.RebaseErr=
or) as e:
+            except (bb.fetch.LocalModificationsError, bb.fetch.RebaseError=
) as e:
                 if rebase_conflicts_strategy !=3D 'backup':
                     e.msg +=3D ("\nUse 'bitbake-setup update --rebase-conf=
licts-strategy=3Dbackup'"
                               " to automatically back up the directory and=
 re-clone from upstream,"
@@ -893,7 +894,7 @@ def get_diff(file1, file2):
=20
 def are_layers_changed(layers, layerdir, d):
     def _is_git_remote_changed(r_remote, repodir):
-        from bb.fetch2.git import git_hash_re
+        from bb.fetch.git import git_hash_re
=20
         rev =3D r_remote['rev']
         branch =3D r_remote.get('branch', None)
@@ -1108,11 +1109,11 @@ def install_buildtools(top_dir, settings, args, d):
     fetcher =3D bb.fetch.Fetch([src_uri], d)
     try:
         fetcher.download()
-    except bb.fetch2.ChecksumError as e:
+    except bb.fetch.ChecksumError as e:
         logger.error("Checksum mismatch for buildtools installer. "
                      "Verify the URL and downloaded file.\n%s" % str(e))
         sys.exit(1)
-    except bb.fetch2.FetchError as e:
+    except bb.fetch.FetchError as e:
         logger.error("Failed to download buildtools installer: %s" % str(e=
))
         sys.exit(1)
=20
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index a9946f067..d011b2af4 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -11,7 +11,7 @@ import warnings
 warnings.simplefilter("default")
 warnings.filterwarnings("ignore", category=3DDeprecationWarning, message=
=3D".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0=
])), 'lib'))
-from bb import fetch2
+from bb import fetch
 import logging
 import bb
 import select
diff --git a/conf/bitbake.conf b/conf/bitbake.conf
index f5a5a333a..a8cd5c079 100644
--- a/conf/bitbake.conf
+++ b/conf/bitbake.conf
@@ -43,4 +43,4 @@ T =3D "${WORKDIR}/temp"
 TARGET_ARCH =3D "${BUILD_ARCH}"
 TMPDIR =3D "${TOPDIR}/tmp"
 WORKDIR =3D "${TMPDIR}/work/${PF}"
-GITPKGV =3D "${@bb.fetch2.get_srcrev(d, 'gitpkgv_revision')}"
+GITPKGV =3D "${@bb.fetch.get_srcrev(d, 'gitpkgv_revision')}"
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 9c421aa9a..068d95c16 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -22,6 +22,7 @@ from collections import OrderedDict, defaultdict
=20
 import io
 import bb.event
+import bb.fetch
 import bb.cooker
 import bb.remotedata
 import bb.parse
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 00a6bac55..8a422e506 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -18,6 +18,7 @@ from io import StringIO, UnsupportedOperation
 from contextlib import closing
 from collections import defaultdict, namedtuple
 import bb, bb.command
+import bb.fetch
 from bb import utils, data, parse, event, cache, providers, taskdata, runq=
ueue, build
 import queue
 import signal
@@ -1600,8 +1601,8 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting=
, but this may result in si
=20
         dump =3D {}
         # Horrible but for now we need to avoid any sideeffects of autorev=
 being called
-        saved =3D bb.fetch2.get_autorev
-        bb.fetch2.get_autorev =3D dummy_autorev
+        saved =3D bb.fetch.get_autorev
+        bb.fetch.get_autorev =3D dummy_autorev
         for k in self.data.keys():
             try:
                 expand =3D True
@@ -1621,7 +1622,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting=
, but this may result in si
                             dump[k][d] =3D None
             except Exception as e:
                 print(e)
-        bb.fetch2.get_autorev =3D saved
+        bb.fetch.get_autorev =3D saved
         return dump
=20
=20
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index d307bff0a..d65e3c974 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -22,7 +22,7 @@ import bb.codeparser
 import bb.data
 import bb.data_smart
 import bb.event
-import bb.fetch2
+import bb.fetch
 import bb.parse
 import bb.utils
=20
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index a2ef38e17..76c82c684 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -11,6 +11,7 @@ import re
 import tempfile
 import pickle
 import bb.data
+import bb.fetch
 import difflib
 from bb._vendor import simplediff
 import json
@@ -362,7 +363,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             if self.checksum_cache:
                 checksums =3D self.checksum_cache.get_checksums(dataCaches=
[mc].file_checksums[mcfn][task], recipename, self.localdirsexclude)
             else:
-                checksums =3D bb.fetch2.get_file_checksums(dataCaches[mc].=
file_checksums[mcfn][task], recipename, self.localdirsexclude)
+                checksums =3D bb.fetch.get_file_checksums(dataCaches[mc].f=
ile_checksums[mcfn][task], recipename, self.localdirsexclude)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
=20
@@ -413,8 +414,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.checksum_cache.save_extras()
             self.checksum_cache.save_merge()
         else:
-            bb.fetch2.fetcher_parse_save()
-            bb.fetch2.fetcher_parse_done()
+            bb.fetch.fetcher_parse_save()
+            bb.fetch.fetcher_parse_done()
=20
     def save_unitaskhashes(self):
         self.unihash_cache.save(self.unitaskhashes)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a1e4b45f8..58aff7f67 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1,5 +1,5 @@
 #
-# BitBake Tests for the Fetcher (fetch2/)
+# BitBake Tests for the Fetcher (fetch/)
 #
 # Copyright (C) 2012 Richard Purdie
 #
@@ -21,7 +21,7 @@ import subprocess
 import json
 import tarfile
 import threading
-from bb.fetch2 import URI
+from bb.fetch import URI
 import bb
 import bb.utils
 from bb.tests.support.httpserver import HTTPService
@@ -520,28 +520,28 @@ class MirrorUriTest(FetcherTest):
         for k, v in self.replaceuris.items():
             ud =3D bb.fetch.FetchData(k[0], self.d)
             ud.setup_localpath(self.d)
-            mirrors =3D bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]=
))
-            newuris, uds =3D bb.fetch2.build_mirroruris(ud, mirrors, self.=
d)
+            mirrors =3D bb.fetch.mirror_from_string("%s %s" % (k[1], k[2])=
)
+            newuris, uds =3D bb.fetch.build_mirroruris(ud, mirrors, self.d=
)
             self.assertEqual([v] if v else [], newuris)
=20
     def test_urilist1(self):
         fetcher =3D bb.fetch.FetchData("http://downloads.yoctoproject.org/=
releases/bitbake/bitbake-1.0.tar.gz", self.d)
-        mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
-        uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        mirrors =3D bb.fetch.mirror_from_string(self.mirrorvar)
+        uris, uds =3D bb.fetch.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.ta=
r.gz', 'file:///someotherpath/downloads/bitbake-1.0.tar.gz'])
=20
     def test_urilist2(self):
         # Catch https:// -> files:// bug
         fetcher =3D bb.fetch.FetchData("https://downloads.yoctoproject.org=
/releases/bitbake/bitbake-1.0.tar.gz", self.d)
-        mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
-        uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        mirrors =3D bb.fetch.mirror_from_string(self.mirrorvar)
+        uris, uds =3D bb.fetch.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///someotherpath/downloads/bitbake-1=
.0.tar.gz'])
=20
     def test_urilistsvn(self):
         # Catch svn:// -> svn:// bug
         fetcher =3D bb.fetch.FetchData("svn://svn.server1.com/isource/svnr=
oot/reponame/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;r=
ev=3D2", self.d)
-        mirrors =3D bb.fetch2.mirror_from_string(self.mirrorvar)
-        uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        mirrors =3D bb.fetch.mirror_from_string(self.mirrorvar)
+        uris, uds =3D bb.fetch.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['svn://svn.server2.com/isource/svnroot/rep=
oname/tags/tagname;module=3Dpath_in_tagnamefolder;protocol=3Dhttps;rev=3D2'=
])
=20
     def test_mirror_of_mirror(self):
@@ -549,8 +549,8 @@ class MirrorUriTest(FetcherTest):
         mirrorvar =3D self.mirrorvar + " http://.*/.* http://otherdownload=
s.yoctoproject.org/downloads/"
         mirrorvar =3D mirrorvar + " http://otherdownloads.yoctoproject.org=
/.* http://downloads2.yoctoproject.org/downloads/"
         fetcher =3D bb.fetch.FetchData("http://downloads.yoctoproject.org/=
releases/bitbake/bitbake-1.0.tar.gz", self.d)
-        mirrors =3D bb.fetch2.mirror_from_string(mirrorvar)
-        uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        mirrors =3D bb.fetch.mirror_from_string(mirrorvar)
+        uris, uds =3D bb.fetch.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.ta=
r.gz',
                                 'file:///someotherpath/downloads/bitbake-1=
.0.tar.gz',
                                 'http://otherdownloads.yoctoproject.org/do=
wnloads/bitbake-1.0.tar.gz',
@@ -561,8 +561,8 @@ class MirrorUriTest(FetcherTest):
=20
     def test_recursive(self):
         fetcher =3D bb.fetch.FetchData("https://downloads.yoctoproject.org=
/releases/bitbake/bitbake-1.0.tar.gz", self.d)
-        mirrors =3D bb.fetch2.mirror_from_string(self.recmirrorvar)
-        uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        mirrors =3D bb.fetch.mirror_from_string(self.recmirrorvar)
+        uris, uds =3D bb.fetch.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['http://aaaa/A/A/A/bitbake/bitbake-1.0.tar=
.gz',
                                 'https://bbbb/B/B/B/bitbake/bitbake-1.0.ta=
r.gz',
                                 'http://aaaa/A/A/A/B/B/bitbake/bitbake-1.0=
.tar.gz'])
@@ -798,7 +798,7 @@ class FetcherLocalTest(FetcherTest):
         self.assertEqual(tree, [r'backslash\x2dsystemd-unit.device'])
=20
     def test_local_wildcard(self):
-        with self.assertRaises(bb.fetch2.ParameterError):
+        with self.assertRaises(bb.fetch.ParameterError):
             tree =3D self.fetchUnpack(['file://a', 'file://dir/*'])
=20
     def test_local_dir(self):
@@ -827,7 +827,7 @@ class FetcherLocalTest(FetcherTest):
         tree =3D self.fetchUnpack(['file://a;subdir=3D%s' % os.path.join(s=
elf.unpackdir, 'bar')])
=20
         # Unpacking to an absolute path outside of the root should fail
-        with self.assertRaises(bb.fetch2.UnpackError):
+        with self.assertRaises(bb.fetch.UnpackError):
             self.fetchUnpack(['file://a;subdir=3D/bin/sh'])
=20
     def test_local_striplevel(self):
@@ -854,20 +854,20 @@ class FetcherLocalTest(FetcherTest):
=20
     def test_local_deb_rejects_unknown_data_member_suffix(self):
         package =3D self.make_ar_package("archive.deb", data_member=3D"dat=
a.tar.foo")
-        with self.assertRaises(bb.fetch2.UnpackError) as context:
+        with self.assertRaises(bb.fetch.UnpackError) as context:
             self.fetchUnpack(['file://%s' % package])
=20
         self.assertIn("does not contain supported data.tar* file", str(con=
text.exception))
=20
     def test_local_deb_rejects_unsafe_data_member(self):
         package =3D self.make_ar_package("archive.deb", data_member=3D"dat=
a.tar.xz;id")
-        with self.assertRaises(bb.fetch2.UnpackError) as context:
+        with self.assertRaises(bb.fetch.UnpackError) as context:
             self.fetchUnpack(['file://%s' % package])
=20
         self.assertIn("does not contain supported data.tar* file", str(con=
text.exception))
=20
     def assertInvalidStriplevel(self, value):
-        with self.assertRaises(bb.fetch2.UnpackError) as context:
+        with self.assertRaises(bb.fetch.UnpackError) as context:
             self.fetchUnpack(['file://archive.tar;subdir=3Dbar;striplevel=
=3D%s' % value])
         self.assertIn("Invalid striplevel parameter", str(context.exceptio=
n))
=20
@@ -931,7 +931,7 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))
         fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-=
file.tar.gz"], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
     def test_valid_missing_donestamp(self):
@@ -961,7 +961,7 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz.done")))
         fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-=
file.tar.gz"], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
         # the existing file should not exist or should have be moved to "b=
ad-checksum"
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz")))
@@ -972,7 +972,7 @@ class FetcherNoNetworkTest(FetcherTest):
         # ssh fetch does not support checksums
         fetcher =3D bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.or=
g/test-file.tar.gz"], self.d)
         # attempts to download with missing donestamp
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
     def test_nochecksums_missing_donestamp(self):
@@ -985,7 +985,7 @@ class FetcherNoNetworkTest(FetcherTest):
         # ssh fetch does not support checksums
         fetcher =3D bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.or=
g/test-file.tar.gz"], self.d)
         # attempts to download with missing donestamp
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
     def test_nochecksums_has_donestamp(self):
@@ -1014,7 +1014,7 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file=
.tar.gz.done")))
         # ssh fetch does not support checksums
         fetcher =3D bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.or=
g/test-file.tar.gz"], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
         # both files should still exist
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-fil=
e.tar.gz")))
@@ -1315,7 +1315,7 @@ class FetcherNetworkTest(FetcherTest):
         self.d.setVar("SRCREV", "14e1138441bbbb584160cb1c0a0426ec1bac35f1"=
)
         with Timeout(60):
             fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
-            with self.assertRaises(bb.fetch2.FetchError):
+            with self.assertRaises(bb.fetch.FetchError):
                 fetcher.download()
=20
 class SVNTest(FetcherTest):
@@ -1601,7 +1601,7 @@ class FetchLatestVersionTest(FetcherTest):
                 self.d.setVar("PN", k[0])
                 self.d.setVar("SRCREV", k[2])
                 self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
-                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                ud =3D bb.fetch.FetchData(k[1], self.d)
                 pupver=3D ud.method.latest_versionstring(ud, self.d)
                 verstring =3D pupver[0]
                 self.assertTrue(verstring, msg=3D"Could not find upstream =
version for %s" % k[0])
@@ -1628,7 +1628,7 @@ class FetchLatestVersionTest(FetcherTest):
                         self.d.setVar("UPSTREAM_CHECK_REGEX", data.check_r=
egex)
=20
                     url =3D "http://127.0.0.1:%s/%s" % (port, data.path)
-                    ud =3D bb.fetch2.FetchData(url, self.d)
+                    ud =3D bb.fetch.FetchData(url, self.d)
                     pupver =3D ud.method.latest_versionstring(ud, self.d)
                     verstring =3D pupver[0]
                     self.assertTrue(verstring, msg=3D"Could not find upstr=
eam version for %s" % data.pn)
@@ -1642,7 +1642,7 @@ class FetchLatestVersionTest(FetcherTest):
         for k, v in self.test_crate_uris.items():
             with self.subTest(pn=3Dk[0]):
                 self.d.setVar("PN", k[0])
-                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                ud =3D bb.fetch.FetchData(k[1], self.d)
                 pupver =3D ud.method.latest_versionstring(ud, self.d)
                 verstring =3D pupver[0]
                 self.assertTrue(verstring, msg=3D"Could not find upstream =
version for %s" % k[0])
@@ -1657,7 +1657,7 @@ class FetchLatestVersionTest(FetcherTest):
                 self.d.setVar("SRCREV", k[2])
                 self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
                 filter_regex =3D k[4]
-                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                ud =3D bb.fetch.FetchData(k[1], self.d)
                 pupver=3D ud.method.latest_versionstring(ud, self.d, filte=
r_regex=3Dfilter_regex)
                 verstring =3D pupver[0]
                 self.assertTrue(verstring, msg=3D"Could not find upstream =
version for %s" % k[0])
@@ -1680,7 +1680,7 @@ class FetchLatestVersionTest(FetcherTest):
                 if k[4]:
                     self.d.setVar("UPSTREAM_CHECK_REGEX", k[4])
                 filter_regex =3D k[5]
-                ud =3D bb.fetch2.FetchData(url, self.d)
+                ud =3D bb.fetch.FetchData(url, self.d)
                 pupver=3D ud.method.latest_versionstring(ud, self.d, filte=
r_regex=3Dfilter_regex)
                 verstring =3D pupver[0]
                 self.assertTrue(verstring, msg=3D"Could not find upstream =
version for %s" % k[0])
@@ -1696,7 +1696,7 @@ class FetchLatestVersionTest(FetcherTest):
         for k, v in self.test_crate_stable_uris.items():
             with self.subTest(pn=3Dk[0]):
                 self.d.setVar("PN", k[0])
-                ud =3D bb.fetch2.FetchData(k[1], self.d)
+                ud =3D bb.fetch.FetchData(k[1], self.d)
                 filter_regex =3D k[2]
                 pupver =3D ud.method.latest_versionstring(ud, self.d, filt=
er_regex=3Dfilter_regex)
                 verstring =3D pupver[0]
@@ -1750,13 +1750,13 @@ class FetchCheckStatusTest(FetcherTest):
         return server
=20
     def _checkstatus(self, url):
-        fetch =3D bb.fetch2.Fetch([url], self.d)
+        fetch =3D bb.fetch.Fetch([url], self.d)
         ud =3D fetch.ud[url]
         return ud.method.checkstatus(fetch, ud, self.d)
=20
     @skipIfNoNetwork()
     def test_wget_checkstatus(self):
-        fetch =3D bb.fetch2.Fetch(self.test_wget_uris, self.d)
+        fetch =3D bb.fetch.Fetch(self.test_wget_uris, self.d)
         for u in self.test_wget_uris:
             with self.subTest(url=3Du):
                 ud =3D fetch.ud[u]
@@ -1766,10 +1766,10 @@ class FetchCheckStatusTest(FetcherTest):
=20
     @skipIfNoNetwork()
     def test_wget_checkstatus_connection_cache(self):
-        from bb.fetch2 import FetchConnectionCache
+        from bb.fetch import FetchConnectionCache
=20
         connection_cache =3D FetchConnectionCache()
-        fetch =3D bb.fetch2.Fetch(self.test_wget_uris, self.d,
+        fetch =3D bb.fetch.Fetch(self.test_wget_uris, self.d,
                     connection_cache =3D connection_cache)
=20
         for u in self.test_wget_uris:
@@ -1785,7 +1785,7 @@ class FetchCheckStatusTest(FetcherTest):
     def test_wget_checkstatus_https_connection_cache(self):
         import ssl
         from socketserver import ThreadingMixIn
-        from bb.fetch2 import FetchConnectionCache
+        from bb.fetch import FetchConnectionCache
=20
         class HTTPSRequestHandler(http.server.BaseHTTPRequestHandler):
             protocol_version =3D "HTTP/1.1"
@@ -1832,7 +1832,7 @@ class FetchCheckStatusTest(FetcherTest):
         try:
             url =3D "https://127.0.0.1:%s/test" % server.server_port
             self.d.setVar("BB_CHECK_SSL_CERTS", "0")
-            fetch =3D bb.fetch2.Fetch([url], self.d,
+            fetch =3D bb.fetch.Fetch([url], self.d,
                                     connection_cache=3Dconnection_cache)
             ud =3D fetch.ud[url]
             self.assertTrue(ud.method.checkstatus(fetch, ud, self.d))
@@ -1918,7 +1918,7 @@ class GitShallowTest(FetcherTest):
         uri =3D 'git://%s;protocol=3Dfile;subdir=3D${S};branch=3Dmaster' %=
 self.srcdir
         self.d.setVar('SRC_URI', uri)
         self.d.setVar('SRCREV', '${AUTOREV}')
-        self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
+        self.d.setVar('AUTOREV', '${@bb.fetch.get_autorev(d)}')
=20
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '0')
@@ -1963,7 +1963,7 @@ class GitShallowTest(FetcherTest):
             uri =3D d.expand(uri)
             uris =3D [uri]
=20
-        fetcher =3D bb.fetch2.Fetch(uris, d)
+        fetcher =3D bb.fetch.Fetch(uris, d)
         fetcher.download()
         ud =3D fetcher.ud[uri]
         return fetcher, ud
@@ -2294,7 +2294,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('b')
=20
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '-12')
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             self.fetch()
=20
     def test_shallow_invalid_depth_default(self):
@@ -2302,7 +2302,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('b')
=20
         self.d.setVar('BB_GIT_SHALLOW_DEPTH_default', '-12')
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             self.fetch()
=20
     def test_shallow_extra_refs(self):
@@ -2367,7 +2367,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('b')
=20
         self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/heads/foo')
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             self.fetch()
=20
     def test_shallow_missing_extra_refs_wildcard(self):
@@ -2406,7 +2406,7 @@ class GitShallowTest(FetcherTest):
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
         self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
=20
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             self.fetch()
=20
     def test_shallow_fetch_missing_revs(self):
@@ -2417,7 +2417,7 @@ class GitShallowTest(FetcherTest):
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
         self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
=20
-        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs("Bit=
Bake.Fetcher", level=3D"ERROR") as cm:
+        with self.assertRaises(bb.fetch.FetchError), self.assertLogs("BitB=
ake.Fetcher", level=3D"ERROR") as cm:
             self.fetch_shallow()
         self.assertIn("fatal: no commits selected for shallow requests", c=
m.output[0])
=20
@@ -2428,7 +2428,7 @@ class GitShallowTest(FetcherTest):
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
         self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
=20
-        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs("Bit=
Bake.Fetcher", level=3D"ERROR") as cm:
+        with self.assertRaises(bb.fetch.FetchError), self.assertLogs("BitB=
ake.Fetcher", level=3D"ERROR") as cm:
             self.fetch_shallow()
         self.assertIn("Unable to find revision v0.0 even from upstream", c=
m.output[0])
=20
@@ -2485,7 +2485,7 @@ class GitShallowTest(FetcherTest):
         bb.utils.remove(self.gitdir, recurse=3DTrue)
         bb.utils.remove(self.dldir, recurse=3DTrue)
=20
-        with self.assertRaises(bb.fetch2.UnpackError) as context:
+        with self.assertRaises(bb.fetch.UnpackError) as context:
             fetcher.unpack(self.d.getVar('WORKDIR'))
=20
         self.assertIn("No up to date source found", context.exception.msg)
@@ -2534,7 +2534,7 @@ class GitLfsTest(FetcherTest):
         self.d.delVar('MIRRORS')
=20
         self.d.setVar('SRCREV', '${AUTOREV}')
-        self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
+        self.d.setVar('AUTOREV', '${@bb.fetch.get_autorev(d)}')
         self.d.setVar("__BBSRCREV_SEEN", "1")
=20
         bb.utils.mkdirhier(self.srcdir)
@@ -2559,7 +2559,7 @@ class GitLfsTest(FetcherTest):
         uri =3D uris[0]
         d =3D self.d
=20
-        fetcher =3D bb.fetch2.Fetch(uris, d)
+        fetcher =3D bb.fetch.Fetch(uris, d)
         if download:
             fetcher.download()
         ud =3D fetcher.ud[uri]
@@ -2758,7 +2758,7 @@ class GitLfsTest(FetcherTest):
=20
         fetcher.download()
         # If git-lfs cannot be found, the unpack should throw an error
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             with unittest.mock.patch("shutil.which", return_value=3DNone):
                 shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
                 fetcher.unpack(self.d.getVar('WORKDIR'))
@@ -2772,7 +2772,7 @@ class GitLfsTest(FetcherTest):
=20
         # If git-lfs cannot be found, the download should throw an error
         with unittest.mock.patch("shutil.which", return_value=3DNone):
-            with self.assertRaises(bb.fetch2.FetchError):
+            with self.assertRaises(bb.fetch.FetchError):
                 fetcher.download()
=20
     def test_lfs_disabled_not_installed(self):
@@ -2862,7 +2862,7 @@ class FetchLocallyMissingTagFromRemote(FetcherTest):
         self.git(['commit', '-m', 'dummymsg', 'dummyfile'], self.srcdir)
=20
     def _fetch_and_unpack(self, uri_to_fetch):
-        fetcher =3D bb.fetch2.Fetch([uri_to_fetch], self.d)
+        fetcher =3D bb.fetch.Fetch([uri_to_fetch], self.d)
         fetcher.download()
         fetcher.unpack(self.d.getVar('WORKDIR'))
=20
@@ -2896,7 +2896,7 @@ class CrateTest(FetcherTest):
         uris =3D self.d.getVar('SRC_URI').split()
         d =3D self.d
=20
-        fetcher =3D bb.fetch2.Fetch(uris, self.d)
+        fetcher =3D bb.fetch.Fetch(uris, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
=20
         self.assertIn("name", ud.parm)
@@ -2922,7 +2922,7 @@ class CrateTest(FetcherTest):
         uris =3D self.d.getVar('SRC_URI').split()
         d =3D self.d
=20
-        fetcher =3D bb.fetch2.Fetch(uris, self.d)
+        fetcher =3D bb.fetch.Fetch(uris, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
=20
         self.assertIn("name", ud.parm)
@@ -2945,7 +2945,7 @@ class CrateTest(FetcherTest):
         uris =3D self.d.getVar('SRC_URI').split()
         d =3D self.d
=20
-        fetcher =3D bb.fetch2.Fetch(uris, self.d)
+        fetcher =3D bb.fetch.Fetch(uris, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
=20
         self.assertIn("name", ud.parm)
@@ -2969,7 +2969,7 @@ class CrateTest(FetcherTest):
         uris =3D self.d.getVar('SRC_URI').split()
         d =3D self.d
=20
-        fetcher =3D bb.fetch2.Fetch(uris, self.d)
+        fetcher =3D bb.fetch.Fetch(uris, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
=20
         self.assertIn("name", ud.parm)
@@ -3000,8 +3000,8 @@ class CrateTest(FetcherTest):
=20
         uris =3D self.d.getVar('SRC_URI').split()
=20
-        fetcher =3D bb.fetch2.Fetch(uris, self.d)
-        with self.assertRaisesRegex(bb.fetch2.FetchError, "Fetcher failure=
 for URL"):
+        fetcher =3D bb.fetch.Fetch(uris, self.d)
+        with self.assertRaisesRegex(bb.fetch.FetchError, "Fetcher failure =
for URL"):
             fetcher.download()
=20
 class NPMTest(FetcherTest):
@@ -3151,7 +3151,7 @@ class NPMTest(FetcherTest):
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         self.d.setVar('BB_NO_NETWORK', '1')
         fetcher =3D bb.fetch.Fetch(urls, self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
     @skipIfNoNpm()
@@ -3186,7 +3186,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     def test_npm_version_latest_rejected(self):
         url =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/nod=
e-server-example;version=3Dlatest']
-        with self.assertRaises(bb.fetch2.ParameterError):
+        with self.assertRaises(bb.fetch.ParameterError):
             bb.fetch.Fetch(url, self.d)
=20
     @skipIfNoNpm()
@@ -3196,7 +3196,7 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         fetcher =3D bb.fetch.Fetch(urls, self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             fetcher.download()
=20
     @skipIfNoNpm()
@@ -3206,14 +3206,14 @@ class NPMTest(FetcherTest):
                 ';sha512sum=3Df2dd7d88cb9a129fbb97eb87a8b5103bab24f783420f=
d7587f8000a355a12bf7'
                 '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc=
4de9223']
         fetcher =3D bb.fetch.Fetch(urls, self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             fetcher.download()
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_invalid(self):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid']
-        with self.assertRaises(bb.fetch2.ParameterError):
+        with self.assertRaises(bb.fetch.ParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
@@ -3221,7 +3221,7 @@ class NPMTest(FetcherTest):
     def test_npm_recipe_checksum(self):
         """A sha512sum param in SRC_URI is forwarded to the proxy and veri=
fied."""
         import subprocess
-        from bb.fetch2.npm import npm_integrity
+        from bb.fetch.npm import npm_integrity
         result =3D subprocess.run(
             ['npm', 'view', '--json', '@savoirfairelinux/node-server-examp=
le@1.0.0'],
             capture_output=3DTrue, text=3DTrue)
@@ -3249,7 +3249,7 @@ class NPMTest(FetcherTest):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example'
                 ';version=3D1.0.0;sha512sum=3Ddeadbeef00']
         fetcher =3D bb.fetch.Fetch(urls, self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             fetcher.download()
=20
     @skipIfNoNpm()
@@ -3267,28 +3267,28 @@ class NPMTest(FetcherTest):
                 self.d.delVar('BB_STRICT_CHECKSUM')
             else:
                 self.d.setVar('BB_STRICT_CHECKSUM', strict)
-            with self.assertRaises(bb.fetch2.MissingParameterError):
+            with self.assertRaises(bb.fetch.MissingParameterError):
                 bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
         urls =3D ['npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0']
-        with self.assertRaises(bb.fetch2.MalformedUrl):
+        with self.assertRaises(bb.fetch.MalformedUrl):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_none(self):
         urls =3D ['npm://registry.npmjs.org;version=3D1.0.0']
-        with self.assertRaises(bb.fetch2.MissingParameterError):
+        with self.assertRaises(bb.fetch.MissingParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_none(self):
         urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example']
-        with self.assertRaises(bb.fetch2.MissingParameterError):
+        with self.assertRaises(bb.fetch.MissingParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     def create_shrinkwrap_file(self, data):
@@ -3405,7 +3405,7 @@ class NPMTest(FetcherTest):
         })
         self.d.setVar('BB_NO_NETWORK', '1')
         fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
     @skipIfNoNpm()
@@ -3466,7 +3466,7 @@ class NPMTest(FetcherTest):
             }
         })
         fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             fetcher.download()
         # Fetch correctly to get a tarball
         swfile =3D self.create_shrinkwrap_file({
@@ -3634,7 +3634,7 @@ class GitTagVerificationTests(FetcherTest):
     def test_tag_rev_match4(self):
         # Test a url with SRCREV and rev=3D mismatching errors
         self.d.setVar('SRCREV', 'bade540fc31a1c26839efd2c7785a751ce24ebfb'=
)
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbak=
e;branch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca=
6757;tag=3D2.12.0"], self.d)
=20
     @skipIfNoNetwork()
@@ -3652,7 +3652,7 @@ class GitTagVerificationTests(FetcherTest):
         self.d.setVar('BB_GIT_SHALLOW', '1')
         fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca6757=
;tag=3D2.8.0"], self.d)
         fetcher.download()
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             fetcher.unpack(self.unpackdir)
=20
     @skipIfNoNetwork()
@@ -3661,7 +3661,7 @@ class GitTagVerificationTests(FetcherTest):
         self.d.setVar('SRCREV', '5b4e20377eea8d428edf1aeb2187c18f82ca6757'=
)
         fetcher =3D bb.fetch.Fetch(["git://git.openembedded.org/bitbake;br=
anch=3D2.12;protocol=3Dhttps;rev=3D5b4e20377eea8d428edf1aeb2187c18f82ca6757=
;tag=3D2.8.0"], self.d)
         fetcher.download()
-        with self.assertRaises(bb.fetch2.FetchError):
+        with self.assertRaises(bb.fetch.FetchError):
             fetcher.unpack(self.unpackdir)
=20
=20
@@ -3730,7 +3730,7 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         self.make_git_repo()
         self.d.setVar("SRCREV", "0"*40)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
     def test_mirror_commit_exists(self):
@@ -3743,7 +3743,7 @@ class FetchPremirroronlyLocalTest(FetcherTest):
     def test_mirror_tarball_nonexistent(self):
         self.d.setVar("SRCREV", "0"*40)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
=20
@@ -3784,7 +3784,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         ## Upstream commit not in the mirror
         self.d.setVar("SRCREV", "49d65d53c2bf558ae6e9185af0f3af7b79d255ec"=
)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
=20
 class FetchPremirroronlyMercurialTest(FetcherTest):
@@ -3849,7 +3849,7 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
     def test_mirror_broken_download(self):
         self.d.setVar("SRCREV", "0"*40)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
-        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs() as=
 logs:
+        with self.assertRaises(bb.fetch.FetchError), self.assertLogs() as =
logs:
             fetcher.download()
         output =3D "".join(logs.output)
         self.assertFalse(" not a git repository (or any parent up to mount=
 point /)" in output)
@@ -3861,7 +3861,7 @@ class GoModTest(FetcherTest):
         urls =3D ['gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/a=
zblob;version=3Dv1.0.0;'
                 'sha256sum=3D9bb69aea32f1d59711701f9562d66432c9c0374205e50=
09d1d1a62f03fb4fdad']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.zip')
         self.assertEqual(ud.parm['downloadfilename'], 'github.com.Azure.az=
ure-sdk-for-go.sdk.storage.azblob@v1.0.0.zip')
@@ -3880,7 +3880,7 @@ class GoModTest(FetcherTest):
         urls =3D ['gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/a=
zblob;version=3Dv1.0.0;mod=3D1;'
                 'sha256sum=3D7873b8544842329b4f385a3aa6cf82cc2bc8defb41a04=
fa5291c35fd5900e873']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.mod')
         self.assertEqual(ud.parm['downloadfilename'], 'github.com.Azure.az=
ure-sdk-for-go.sdk.storage.azblob@v1.0.0.mod')
@@ -3896,7 +3896,7 @@ class GoModTest(FetcherTest):
         urls =3D ['gomod://gopkg.in/ini.v1;version=3Dv1.67.0']
         self.d.setVarFlag('SRC_URI', 'gopkg.in/ini.v1@v1.67.0.sha256sum', =
'bd845dfc762a87a56e5a32a07770dc83e86976db7705d7f89c5dbafdc60b06c6')
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1=
/%40v/v1.67.0.zip')
         self.assertEqual(ud.parm['downloadfilename'], 'gopkg.in.ini.v1@v1.=
67.0.zip')
@@ -3915,7 +3915,7 @@ class GoModTest(FetcherTest):
         urls =3D ['gomod://gopkg.in/ini.v1;version=3Dv1.67.0;'
                 'sha256sum=3Dbd845dfc762a87a56e5a32a07770dc83e86976db7705d=
7f89c5dbafdc60b06c6']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1=
/%40v/v1.67.0.zip')
         self.assertEqual(ud.parm['downloadfilename'], 'gopkg.in.ini.v1@v1.=
67.0.zip')
@@ -3934,7 +3934,7 @@ class GoModTest(FetcherTest):
         urls =3D ['gomod://go.opencensus.io;version=3Dv0.24.0;'
                 'sha256sum=3D203a767d7f8e7c1ebe5588220ad168d1e15b14ae70a63=
6de7ca9a4a88a7e0d0c']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/go.opencensus.i=
o/%40v/v0.24.0.zip')
         self.assertEqual(ud.parm['downloadfilename'], 'go.opencensus.io@v0=
.24.0.zip')
@@ -3956,7 +3956,7 @@ class GoModGitTest(FetcherTest):
                 'repo=3Dgo.googlesource.com/net;'
                 'srcrev=3D694cff8668bac64e0864b552bffc280cd27f21b1']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'go.googlesource.com')
         self.assertEqual(ud.path, '/net')
@@ -3981,7 +3981,7 @@ class GoModGitTest(FetcherTest):
                 'repo=3Dgithub.com/Azure/azure-sdk-for-go;subdir=3Dsdk/sto=
rage/azblob;'
                 'srcrev=3Dec928e0ed34db682b3f783d3739d1c538142e0c3']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'github.com')
         self.assertEqual(ud.path, '/Azure/azure-sdk-for-go')
@@ -4006,7 +4006,7 @@ class GoModGitTest(FetcherTest):
         urls =3D ['gomodgit://gopkg.in/ini.v1;version=3Dv1.67.0']
         self.d.setVar('SRCREV_gopkg.in/ini.v1@v1.67.0', 'b2f570e5b5b844226=
bbefe6fb521d891f529a951')
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'gopkg.in')
         self.assertEqual(ud.path, '/ini.v1')
@@ -4028,7 +4028,7 @@ class GoModGitTest(FetcherTest):
         urls =3D ['gomodgit://gopkg.in/ini.v1;version=3Dv1.67.0;'
                 'srcrev=3Db2f570e5b5b844226bbefe6fb521d891f529a951']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'gopkg.in')
         self.assertEqual(ud.path, '/ini.v1')
@@ -4051,7 +4051,7 @@ class GoModGitTest(FetcherTest):
                 'repo=3Dgithub.com/census-instrumentation/opencensus-go;'
                 'srcrev=3Db1a01ee95db0e690d91d7193d037447816fae4c5']
=20
-        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.host, 'github.com')
         self.assertEqual(ud.path, '/census-instrumentation/opencensus-go')
@@ -4153,7 +4153,7 @@ class GitUnpackUpdateTest(FetcherTest):
         4. Verify testfile.txt now contains 'updated content'.
         """
         # First fetch at initial revision
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4165,7 +4165,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Update to new revision
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         # Use unpack_update
@@ -4187,7 +4187,7 @@ class GitUnpackUpdateTest(FetcherTest):
         and its URL must be 'file://<ud.clonedir>'.
         """
         # First fetch
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         uri =3D self.d.getVar('SRC_URI')
@@ -4225,7 +4225,7 @@ class GitUnpackUpdateTest(FetcherTest):
         so this test covers those scenarios implicitly.
         """
         # Step 1 - fetch + unpack at initial_rev
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4248,7 +4248,7 @@ class GitUnpackUpdateTest(FetcherTest):
         # Step 3 - advance SRCREV and download; clonedir must now contain
         # updated_rev so that unpack_update can fetch it without network a=
ccess.
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         ud =3D fetcher.ud[uri]
@@ -4281,7 +4281,7 @@ class GitUnpackUpdateTest(FetcherTest):
         the working tree unchanged. No rebase should be attempted because =
the
         checkout already points at ud.revision.
         """
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4308,7 +4308,7 @@ class GitUnpackUpdateTest(FetcherTest):
         untracked files untouched, so both the upstream update and the unt=
racked
         file must be present after the call.
         """
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4321,7 +4321,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Update to new upstream revision
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         uri =3D self.d.getVar('SRC_URI')
@@ -4346,7 +4346,7 @@ class GitUnpackUpdateTest(FetcherTest):
         dirty index. The caller (bitbake-setup) is expected to catch the
         resulting LocalModificationsError and fall back to backup + re-fet=
ch.
         """
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4360,7 +4360,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Update to new upstream revision
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         uri =3D self.d.getVar('SRC_URI')
@@ -4368,7 +4368,7 @@ class GitUnpackUpdateTest(FetcherTest):
         git_fetcher =3D ud.method
=20
         # Should fail - git rebase refuses to run with a dirty index
-        with self.assertRaises(bb.fetch2.LocalModificationsError):
+        with self.assertRaises(bb.fetch.LocalModificationsError):
             git_fetcher.unpack_update(ud, self.unpackdir, self.d)
=20
     def test_unpack_update_with_modified_tracked_file(self):
@@ -4379,7 +4379,7 @@ class GitUnpackUpdateTest(FetcherTest):
         the caller can fall back to backup + re-fetch rather than silently=
 discarding
         work in progress.
         """
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4391,7 +4391,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Update to new upstream revision
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         uri =3D self.d.getVar('SRC_URI')
@@ -4400,7 +4400,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Should fail - unstaged modification to tracked file is detected =
by
         # 'git status --untracked-files=3Dno --porcelain'
-        with self.assertRaises(bb.fetch2.LocalModificationsError):
+        with self.assertRaises(bb.fetch.LocalModificationsError):
             git_fetcher.unpack_update(ud, self.unpackdir, self.d)
=20
     def test_unpack_update_conflict_raises_rebase_error(self):
@@ -4412,7 +4412,7 @@ class GitUnpackUpdateTest(FetcherTest):
         to a backup + re-fetch.
         """
         # Fetch and unpack at the initial revision
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4433,7 +4433,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Update SRCREV to the new upstream commit
         self.d.setVar('SRCREV', conflict_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         uri =3D self.d.getVar('SRC_URI')
@@ -4442,7 +4442,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # unpack_update must fail and clean up (rebase --abort) rather tha=
n
         # leaving the repo in a mid-rebase state
-        with self.assertRaises(bb.fetch2.RebaseError):
+        with self.assertRaises(bb.fetch.RebaseError):
             git_fetcher.unpack_update(ud, self.unpackdir, self.d)
=20
         # Verify the repo is not left in a conflicted / mid-rebase state
@@ -4475,7 +4475,7 @@ class GitUnpackUpdateTest(FetcherTest):
             local file is untouched.
             """
             # Fresh fetch + unpack at the current SRCREV
-            fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d=
)
+            fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
             fetcher.download()
             fetcher.unpack(self.unpackdir)
=20
@@ -4497,7 +4497,7 @@ class GitUnpackUpdateTest(FetcherTest):
                 f.write('local untracked content\n')
=20
             self.d.setVar('SRCREV', new_rev)
-            fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d=
)
+            fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
             fetcher.download()
=20
             uri =3D self.d.getVar('SRC_URI')
@@ -4505,7 +4505,7 @@ class GitUnpackUpdateTest(FetcherTest):
             git_fetcher =3D ud.method
=20
             # git rebase refuses because the untracked file would be overw=
ritten
-            with self.assertRaises(bb.fetch2.RebaseError):
+            with self.assertRaises(bb.fetch.RebaseError):
                 git_fetcher.unpack_update(ud, self.unpackdir, self.d)
=20
             # Repo must not be left in a mid-rebase state
@@ -4543,7 +4543,7 @@ class GitUnpackUpdateTest(FetcherTest):
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
=20
         # First fetch at initial revision
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         # Remove clonedir to force use of shallow tarball
@@ -4555,7 +4555,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Update to new revision
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         # unpack_update should fail for shallow clones
@@ -4563,7 +4563,7 @@ class GitUnpackUpdateTest(FetcherTest):
         ud =3D fetcher.ud[uri]
         git_fetcher =3D ud.method
=20
-        with self.assertRaises(bb.fetch2.UnpackError) as context:
+        with self.assertRaises(bb.fetch.UnpackError) as context:
             git_fetcher.unpack_update(ud, self.unpackdir, self.d)
=20
         self.assertIn("shallow clone", str(context.exception).lower())
@@ -4576,7 +4576,7 @@ class GitUnpackUpdateTest(FetcherTest):
         update_mode will fail with a FetchError which must be re-raised as
         UnpackError so the caller can fall back to a full re-fetch.
         """
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4584,7 +4584,7 @@ class GitUnpackUpdateTest(FetcherTest):
=20
         # Advance SRCREV to trigger update_mode
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         uri =3D self.d.getVar('SRC_URI')
@@ -4597,7 +4597,7 @@ class GitUnpackUpdateTest(FetcherTest):
                  cwd=3Dunpack_path)
=20
         git_fetcher =3D ud.method
-        with self.assertRaises(bb.fetch2.UnpackError):
+        with self.assertRaises(bb.fetch.UnpackError):
             git_fetcher.unpack_update(ud, self.unpackdir, self.d)
=20
     def test_fetch_unpack_update_toplevel_api(self):
@@ -4609,7 +4609,7 @@ class GitUnpackUpdateTest(FetcherTest):
         fetch again, then call fetcher.unpack_update(root) and confirm the=
 content
         is updated.
         """
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
=20
@@ -4618,7 +4618,7 @@ class GitUnpackUpdateTest(FetcherTest):
             self.assertEqual(f.read(), 'initial content\n')
=20
         self.d.setVar('SRCREV', self.updated_rev)
-        fetcher =3D bb.fetch2.Fetch([self.d.getVar('SRC_URI')], self.d)
+        fetcher =3D bb.fetch.Fetch([self.d.getVar('SRC_URI')], self.d)
         fetcher.download()
=20
         # Use the public Fetch.unpack_update() rather than the method dire=
ctly
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 42385c879..9b9925e51 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -25,7 +25,7 @@ import bb.utils
 import bb.command
 import bb.remotedata
 from bb.main import setup_bitbake, BitBakeConfigParameters
-import bb.fetch2
+import bb.fetch
=20
 def wait_for(f):
     """
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 37edd4353..22e3f13f9 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2107,7 +2107,7 @@ def landlock_restrict_network():
=20
=20
 def export_proxies(d):
-    from bb.fetch2 import get_fetcher_environment
+    from bb.fetch import get_fetcher_environment
     """ export common proxies variables from datastore to environment """
     newenv =3D get_fetcher_environment(d)
     for v in newenv:
--=20
2.43.0


