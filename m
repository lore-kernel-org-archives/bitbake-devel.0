Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8036BCD4F4A
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 14:59:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10317.1779116357389699772
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 07:59:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=Kvet3/uS;
 spf=pass (domain: est.tech, ip: 52.101.70.20, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSU+i/tKvNThIXYm3HsRMGQpGWuneLxAefX4Rm57ygzNfWM/omibT3boNQSpLdqyDPtl8vDj5C8HzJHKUn1Qou8QxsukHvF8ZAmJ64SHP1ALk7m/9RvzKvcHNmWcrsefRqegFzEutkSdVFtN2yMdtcm4YsCXbdw2ZKck0zUfss9X0c+YYzjviA4tnxkf7gfdum22r+TLyPPu3c2FtYmM5cju3Y3AM4cHWVydtDgT05SVpVFj9yM9iV7qZ6Xtgc9qjYvysbSkDiJd4All5J6SFRVQjsAKeAXiX7oG2ipesDy7aPt0gu28+gZkxE2iSjI3paXyQzI69pXcGEDsMA7DBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S06YRm87dN4J52cQtOravWliOfXOYCxzo2/aoBobTc=;
 b=m04LaawgEpVNrCokXGB6EfjOax5JBFO/YyZNRrR7Y/fdnY5BtPAm7CfUfex5fMtgYpW7XVtni1JxCrYCBkDV+0a7JLevJ8jhGcSZhEo+QHAdwaUduUw0k8G0+o4+QXfyMD3+zjO4cZxGCwzMDse5xF7FjRlMe3Dv273KEB/RQySgJQdA1dWpbedQ5lVBnAipEJ/l0gkVcjMiwdFYTr2lq88HPpLoxtzaZw+LBsWZsvgxOM9qM7Nbx/Yb84PdktinzCarDSJMS80KOZWZvNU+po8ERPcqKx1XPCIs4Y0PSwkGclkyQAuO9tXM5GWsZrXVitt26eujdJ3ZzTQ2NSK1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S06YRm87dN4J52cQtOravWliOfXOYCxzo2/aoBobTc=;
 b=Kvet3/uSYVNZZqXD2JqcnTrbm22iAKlWwiHmjGXHjoHDyqHxN2CUT5sO4C2d1dfKT7eFoqNjvkJH00luRLowpZYWt30enUWRehLZQAs5pjl9wrLA47HbNP0e/IgVsMbuD6KVaRe0ZBfrGeAEbV3jCDbY/59nlc8Ev79IsEhuir0s/My6ke+vYAIsfDH8UTpyYzSOlUGQ4Gto7NWY/07SF7sYr5080cioYtoVqFwm2C27hU4olkaD5Xz9RSiFIP6oLQV1H7qXR7I0Cw+LAKe9E7rYDHspbaL2RoFranT7yToFxR+pn3/gby+YN0cji8WGPTG0mWC56/8im7erMzEItw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 DU0P189MB3274.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:59f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 14:59:16 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:59:16 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 1/2] fetch2: validate deb/ipk data member names
Date: Mon, 18 May 2026 16:59:08 +0200
Message-ID: <20260518145909.1132755-2-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518145909.1132755-1-anders.heimer@est.tech>
References: <20260518145909.1132755-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DU7PR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::26) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|DU0P189MB3274:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ad05e6-be93-43c0-0e75-08deb4ee07df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/eenJYS+lrwpjGWYk+JdSZnwbZE1iNEO0xmm5rP21Zqk2GcV6Xcz3u1OnwFh5k5VAXphuiC/0AtldQ3AwbNWw70n+OguhQ3Wh3CuOvkPNbKXZ+dTcNBu2DVGPOGW2zlz0Ht8RXMVe/GQkgYuernXdV+Qwa9nZ8HkCT7prhgPFzkYT4fStXdmWQZK9mNjZyLLnSHprznOMlYtxORv4zcfMMiZIJmSZ8jwioHaJC2XvZlBizYQyxy+fn5P6/qqcq2Tz0S3dVhfWTc7d9b0/0m6XqFQL8qBRYT37ZAkFohQcYqa9qbe1lNVPRVCXOPrma8YBMzm+eJk3g1H7JeaPmqKPkCx/Wae7v8shjquAfJzfUHL6Jvc8iluSeB9Hxu3ElGaYfl7nau5HAtKm2deLfu1b7LCc+5fmWy4td3RpJYtoj3TiuXJDx2wyWpwUBlxIlh9p6cLJdoaWjikYlMa1GxyUQmD/bpQriObgeGCjqwHKA/rqC71PEZteX+NmsjRD9Vp2t1pI2PHwkuhnFEaBEeJw2f87Oe8AHKyXDzF1wtKXsHTvc5IFyigdRiUpzvLjIMpRMFNZsislMJ83PtSEGrvUPCCwmW7aIKwQsaA2LtV0FYslKyuFE8GQYDvyrRovSQkTamlxSaX65D78Zv+ru8mmneRhc+23KhE9H2peqTy1YdR/9CVJtnLUEjXbYFH41nMnCVBXksctEumAWM4K4cG1w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2G0SofC0KuiKf0ifRAziChzDhEv3V+WBg6lpetUj6v1jGPNPyxDsMaUgQn5R?=
 =?us-ascii?Q?KFMTZKWyWI9U2gEjD3oUrOYwFeiM0HLPABmSiVzj5C7/wx2/aABxf5uMP/Ys?=
 =?us-ascii?Q?D3qnM/OaPSluzFEJ3YXkhAyPYKsV/EJtYCt9lQXMFANggUpTGQLUNqAzbhCp?=
 =?us-ascii?Q?Au4MYBhdQqHNWBUAIRfyQ+63P+9xzFfKDi107crA/wUE9GxC/ttz1+MK7Vs5?=
 =?us-ascii?Q?R5jrKZf9fQ1YdD04hICbk8ObLyuw5qHoAaa/MrbcRCyacbhanyfao7ac+4Pz?=
 =?us-ascii?Q?sKwmxQAmuRSSKo22CQtENRUoI7no07W0kI4o8LOTFkzAzz1H6Hqey141OC+M?=
 =?us-ascii?Q?RXzlWQbqICdTiRHf5wGspOqNk0HvQLM7HNTWdlHmZe+cOYj4aD3w2+RDQo0j?=
 =?us-ascii?Q?x7wrpUCxxsy/WluhZBGfnfBhDGoThKcegRTg6P3ut6V0sP+ehvsxap85WWaM?=
 =?us-ascii?Q?v55pdem/oVL6wJZ+kEFgp66kqagkNIcHr/D5C4beCcdA7X1EB09+MG6M6ghy?=
 =?us-ascii?Q?IrMzAp9qpPnlJtF4r32OWWTgaQu6XGP3pfD6oWt91MaNvdYeSIDmdPRhTKjC?=
 =?us-ascii?Q?3y6jGUchB6330Ilz6ZW0iSH0/u6EI0vthYT6VwBq8oWEYVLocsHE24EQ8BtF?=
 =?us-ascii?Q?eNa5dfobh9SqDP/kgbWCnWHAfaWcDRo+ph9atn4nU28u1lEFZpxfCbgDwd8Q?=
 =?us-ascii?Q?d1e/XDvSYsInnRo7WdJcArIQ+npTXapI2XxAgm2pa5WvAuMt1MlYf3W6tdFa?=
 =?us-ascii?Q?BxdF/ffHwDX5I5mhGm7oLL8my5o4aMsBjwVqaAVfiTBJd03m/xgsdSspZ/Jt?=
 =?us-ascii?Q?uvHgbmU/L/9I1O7EtrunCFYmF+TJeLEnLrr2v05L0iVaq6PNrxFr7769NZNE?=
 =?us-ascii?Q?a6HFPjJYAQ5FxeFXNxrWbv0D/DULuqoasWkv/mFQqEicA0C+VqIzGsahqKQZ?=
 =?us-ascii?Q?JhdP3EGqvwQ6YVwKkjpvMmTjaHda3JFS2DFMF9e+723DHU9mCDic7iJ+Fw6S?=
 =?us-ascii?Q?+0/2OKoWrJ2sYbHQeHwjP2SB2pGAK14Ihzy0zqUsdE59Cp5WhDAKJNwpAkW9?=
 =?us-ascii?Q?E5S7sOQXUyaMU7jkJ+7smTowHlUdVqFMQ4JX17BhKDjz9SWbBsDUjn+f4BTV?=
 =?us-ascii?Q?w2rqsF91Juz8GICyRr54CjgN1MlsE5nYOJyvyB9e3Ga3a1Rd/0wmMgRMFIax?=
 =?us-ascii?Q?opI+kCIUNr4OsbiguLPjguJoag3LL1dHUFKtXWPHsTd9mZaWHB0zCo+VK/Fk?=
 =?us-ascii?Q?0e7ZcbbdR6ehQ+QNbSkHkEMOKpEbl6bIsU6K26lNULJoF/wx4SWh/SffZbeU?=
 =?us-ascii?Q?P1tzjVKvfcMcnqBppQYbXrjqCgpi0UJ2fxSV2qDDfaTnzwwhMahHhowDkdd0?=
 =?us-ascii?Q?TfKNFVieOyjRHidRrHr+0Z/HPgLhHPoj/XT8zhuqASkmNUswmAPpp5J654q9?=
 =?us-ascii?Q?rg3DEboHu2OpxBXX7/TlpSodHff1LPyE37vva0qaCe73hc1TPeITh3vPEkGl?=
 =?us-ascii?Q?+sSuYf5JLXVLFxBorPe6RjzbhyO2ioqGFn6bO+KsMqr6cRIsUEm+s3VUByGt?=
 =?us-ascii?Q?KEAqHGazJeuvIwA5FLhHsOAZXvHAFPIuMEVaDNegjqwT28HFvewaWvR0nwHD?=
 =?us-ascii?Q?90G7YzOVcCfrRIVxxx/Hw6YYH6MhsqAJEYT2Y93B5Xka/d/qVUNgGX5/bIl7?=
 =?us-ascii?Q?ysg8TJUZ81Ya0E1mGsbWQuFmKQKfTOGYdo4i7iVvxMhKgzX6v5Y6QI/+JgCV?=
 =?us-ascii?Q?y/ew+Ys38w=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ad05e6-be93-43c0-0e75-08deb4ee07df
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:59:16.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wddUTPN4s6JiEBnD0lL49agnF9OliQbKei/YsQCbHfiN1CFteYsRRUJ8kMeMVNo6Hx7D7wfr9TNau9iedPqOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB3274
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 14:59:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19540

The deb/ipk unpack path selects a data archive member from 'ar -t'
output and then passes that member name to a shell command. Previously,
any member beginning with data.tar. was selected.

Only select known deb/ipk data archive member names when datafile is
created. Quote the package path used in the shell command as it can come
from the local fetch path.

Add local fetcher regression coverage for quoted package filenames,
valid compressed data members, and unsupported or unsafe data member
names.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/__init__.py | 10 +++++---
 lib/bb/tests/fetch.py     | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index b6cb4c530..dc93e64a9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -23,6 +23,7 @@ import collections
 import subprocess
 import pickle
 import errno
+import shlex
 import bb.utils
 import bb.checksum
 import bb.process
@@ -1592,16 +1593,19 @@ class FetchMethod(object):
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 output =3D subprocess.check_output(['ar', '-t', file], pre=
exec_fn=3Dsubprocess_setup)
                 datafile =3D None
+                valid_datafiles =3D ('data.tar', 'data.tar.gz', 'data.tar.=
xz',
+                                   'data.tar.zst', 'data.tar.bz2', 'data.t=
ar.lzma')
                 if output:
                     for line in output.decode().splitlines():
-                        if line.startswith('data.tar.') or line =3D=3D 'da=
ta.tar':
+                        if line in valid_datafiles:
                             datafile =3D line
                             break
                     else:
-                        raise UnpackError("Unable to unpack deb/ipk packag=
e - does not contain data.tar* file", urldata.url)
+                        raise UnpackError("Unable to unpack deb/ipk packag=
e - does not contain supported data.tar* file", urldata.url)
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package - =
could not list contents", urldata.url)
-                cmd =3D 'ar x %s %s && %s -p -f %s && rm %s' % (file, data=
file, tar_cmd, datafile, datafile)
+                quoted_datafile =3D shlex.quote(datafile)
+                cmd =3D 'ar x %s %s && %s -p -f %s && rm %s' % (shlex.quot=
e(file), quoted_datafile, tar_cmd, quoted_datafile, quoted_datafile)
=20
         # If 'subdir' param exists, create a dir and use it as destination=
 for unpack cmd
         if 'subdir' in urldata.parm:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 969e5f876..bece59e62 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -16,6 +16,7 @@ import tempfile
 import collections
 import os
 import signal
+import subprocess
 import tarfile
 from bb.fetch2 import URI
 import bb
@@ -740,6 +741,34 @@ class FetcherLocalTest(FetcherTest):
         bb.process.run('tar cjf archive.tar.bz2 -C dir .', cwd=3Dself.loca=
lsrcdir)
         self.d.setVar("FILESPATH", self.localsrcdir)
=20
+    def make_ar_package(self, package_name, data_member=3D"data.tar"):
+        if not shutil.which("ar"):
+            self.skipTest("ar not installed")
+
+        workdir =3D tempfile.mkdtemp(dir=3Dself.tempdir)
+        payload =3D os.path.join(workdir, "payload")
+        with open(payload, "w") as f:
+            f.write("payload\n")
+
+        data_path =3D os.path.join(workdir, data_member)
+        mode =3D "w:gz" if data_member.endswith(".gz") else "w"
+        with tarfile.open(data_path, mode) as archive:
+            archive.add(payload, arcname=3D"payload")
+
+        with open(os.path.join(workdir, "debian-binary"), "w") as f:
+            f.write("2.0\n")
+
+        control =3D os.path.join(workdir, "control")
+        with open(control, "w") as f:
+            f.write("Package: fetch-test\nVersion: 1\nArchitecture: all\n"=
)
+        with tarfile.open(os.path.join(workdir, "control.tar"), "w") as ar=
chive:
+            archive.add(control, arcname=3D"control")
+
+        package_path =3D os.path.join(self.localsrcdir, package_name)
+        subprocess.check_call(["ar", "r", package_path, "debian-binary", "=
control.tar", data_member],
+                              cwd=3Dworkdir, stdout=3Dsubprocess.DEVNULL, =
stderr=3Dsubprocess.DEVNULL)
+        return package_name
+
     def fetchUnpack(self, uris):
         fetcher =3D bb.fetch.Fetch(uris, self.d)
         fetcher.download()
@@ -813,6 +842,30 @@ class FetcherLocalTest(FetcherTest):
         tree =3D self.fetchUnpack(['file://archive.tar.bz2;subdir=3Dbar;st=
riplevel=3D1'])
         self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
=20
+    def test_local_deb_quoted_filename(self):
+        package =3D self.make_ar_package("archive$(id).deb")
+        tree =3D self.fetchUnpack(['file://%s' % package])
+        self.assertEqual(tree, ['payload'])
+
+    def test_local_ipk_gz_data_member(self):
+        package =3D self.make_ar_package("archive.ipk", data_member=3D"dat=
a.tar.gz")
+        tree =3D self.fetchUnpack(['file://%s' % package])
+        self.assertEqual(tree, ['payload'])
+
+    def test_local_deb_rejects_unknown_data_member_suffix(self):
+        package =3D self.make_ar_package("archive.deb", data_member=3D"dat=
a.tar.foo")
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            self.fetchUnpack(['file://%s' % package])
+
+        self.assertIn("does not contain supported data.tar* file", str(con=
text.exception))
+
+    def test_local_deb_rejects_unsafe_data_member(self):
+        package =3D self.make_ar_package("archive.deb", data_member=3D"dat=
a.tar.xz;id")
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            self.fetchUnpack(['file://%s' % package])
+
+        self.assertIn("does not contain supported data.tar* file", str(con=
text.exception))
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir =3D tempfile.mkdtemp(dir=3Dself.tempdir,
--=20
2.34.1


