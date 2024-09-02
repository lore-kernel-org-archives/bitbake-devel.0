Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786ACA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 09:13:37 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.47])
 by mx.groups.io with SMTP id smtpd.web11.34692.1725268410315014791
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Sep 2024 02:13:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=mkXrWATf;
 spf=pass (domain: axis.com, ip: 52.101.67.47, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCrSjvSIFvEHJgqZsWHw7vn2z5NNkT7mNKHLc/ceNLoCT2i1oI30dv38UraGgkVXhCPruxPQGcA5OXSOYu86Wk0n/dPtLUHjR/6fOG7alT7TL+t548kAFWby3fERv0UYdEHyQtNey3Je0W6k5D6xBjWOUyEEIqTYEPhCcsE3pYNKqYxRnFFf947EyozPIGkPB9oP4NSFigozweLxrB+7RMvtWMR6rBLv+P/bGzDjjR403czwxOchOTxY9Fl3drRe0dLmen7doqlzYSd+iwAiJpNNmMHMJqolaOKh3+S2bgV+Cr4aUd6a3nNHbUAwSUgqZ258IU8gHVaKLdOYSHXn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq5zUGZiygJlC83HcbU78L3HL0m0POckPMwLc5QsVFg=;
 b=G9FmQAAk00W28ZuYUgw2ae3NKxyHWaAwsvzsGIpSOoBgZN37Tp4Q9ilVZmiIehoMTdSNts+x2yq5DjUfrpIBwV47pmIKgYCpxJvBXsZ2dhn0U1wCQR3gfQhh3Ac2HWY09g6X85S2dQl4adErmB6c0B3jQ+IbdZf2UTMHPf0qYKs/qOJR241GU/RPI/+ZmNlzFBkuTgiib5BATq/26DU/7s/wOxaW1PNN1GV4SMaqJ5U93dkQYSq1ni0gImgybGbuvryk/D2hiVpcN2nnoU+/RN60lgS8zxZ80dWkSeJUBF/uEaGUoVSrhUT0BG4sBZgLane5RqjCO8QAKVKhIQa8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq5zUGZiygJlC83HcbU78L3HL0m0POckPMwLc5QsVFg=;
 b=mkXrWATf/926WiOkR93tY2+yU1xvmV+OjOkw/DUFe2q4Mno56ItC+YwCDSTA1oQwxazb1zA/lqJjhEb2E9EDfakCitxRiU3S7zUnnFm3Ki7SkvKqdPYeB6hY1v5gqA+HeqOx5NbLdvX9JMj9xE8nNm2RlLcHYrLg+lrYprqyHcg=
Received: from DUZPR01CA0232.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::6) by PA4PR02MB8239.eurprd02.prod.outlook.com
 (2603:10a6:102:270::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 09:13:25 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::71) by DUZPR01CA0232.outlook.office365.com
 (2603:10a6:10:4b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 09:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 09:13:25 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 11:13:23 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 11:13:23 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 11:13:23 +0200
Received: from pc50740-2234.se.axis.com (pc50740-2234.se.axis.com [10.94.131.4])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 306E424B
	for <bitbake-devel@lists.openembedded.org>; Mon,  2 Sep 2024 11:13:23 +0200 (CEST)
Received: by pc50740-2234.se.axis.com (Postfix, from userid 21184)
	id 2BBEF26B985E; Mon,  2 Sep 2024 11:13:23 +0200 (CEST)
From: Christian Lindeberg <christli@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] fetch2: Add gomod fetcher
Date: Mon, 2 Sep 2024 11:13:22 +0200
Message-ID: <20240902091323.2241464-1-christli@axis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|PA4PR02MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1a1ffd-a75d-430d-043f-08dccb2f800d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s+PbENFNh3/GMbM5EV8Ppr66MCyYwaA2SCyYtOoXgNRvQDNhacMKAUB83oU/?=
 =?us-ascii?Q?qcHOCGznszNezeYTiSoFSgIgGHzjuYOp1ROLpCiFLTddOaaTSTqeja6ZtVjB?=
 =?us-ascii?Q?3EJUOWlg7fyO5NvAqyMe3jqrSY76Ac1vB1Z5a+M0kvHqBKgPZPFsBc2DvTKb?=
 =?us-ascii?Q?7NqdnpJSn3Ckyb5qmYwnAy1ZlC+yuVBMd+2N0iXgcpaqO0fNPTfmFwXDcJEU?=
 =?us-ascii?Q?zP1D/aQWXFwN6mu4xRwJz8AFDl3/mIboEa9BUgJtozgVqrZUmrA9Lc9dDnAV?=
 =?us-ascii?Q?weARSGx14n/anfzX3D4hBJOYLNDxVcss18nZfW8BjVoP6QhpYRAKEbzQz4Ml?=
 =?us-ascii?Q?be1swK9/KHJRxaj21GiKVV06/ImPSog2I80d1rxd9N5uJVHbZIlmY5xOBJ1N?=
 =?us-ascii?Q?aIQ6C+BjLujZCaLgO0kCgn8N0e/mn+tr3JMZhzPWbT2FKC1GtL7na0IzirHo?=
 =?us-ascii?Q?IAs6+0xoF8S7Eay8XNLQoqXvUlP9pcKj4q0/Qfdp0/CYp63aAwsxDqRjbisu?=
 =?us-ascii?Q?BVEB7zzpcthgx86XJel143S27B20nSHlaSOLc3jI24wp0XVE5TrwBJwqJqRM?=
 =?us-ascii?Q?00ngxVmg9XY2Kx9ZaaW7EKl5+Z/pnP6mtVe2YeslkwFJmMYOqLd9OiOY4yPE?=
 =?us-ascii?Q?z9Jp89J7zIp0IztMUJaIOXP8Bga720KAtrmK2kux3ggFR+odLhFR7VIf5O+K?=
 =?us-ascii?Q?kkN6aW5IqbG7VIJ36bDevlR5pT1MmCRgaCCaIIiUZHdrxTVClYu5e6XVJLBl?=
 =?us-ascii?Q?9qfhbDXXKZXDJV65KSfUaBCzs3mR56g//I07mHXvP/56WpBh9Tigqv6kVabR?=
 =?us-ascii?Q?1tiEH7LMOlEdrZUr6MzKiqVTafSKMp/tXnjwCSpt4ORGMHbvbukRsWqMU4P4?=
 =?us-ascii?Q?aTorXcOAnU32T+SoLJpuZqT5oF14TFlCdbzvuj4e624gDvFEo0cz7IJ678ED?=
 =?us-ascii?Q?sDyY0UpTgRUEutaPrn7VMNCxASq60xCOIM/DdhrFlzNhAluggDIE85tjywkQ?=
 =?us-ascii?Q?4O7MaQBRXrbHoxc54Z6uaZPLc1OBuPZqYu28QKOzsFxqIL1lER7Mu6KYxmAT?=
 =?us-ascii?Q?ju8/CMuAbpaeN3ma20Yh3rfY19NMgeqQrvRJolHtKyWT3Q4HNPd6Q+FiLTNk?=
 =?us-ascii?Q?PVBLJt7osenpF3O7ffEMweCFvQHIOyBQpphJEyMSF58/Sz+glllE1CT8g9wl?=
 =?us-ascii?Q?sOeihCZ8ceq921GR3n485xs6QKPYCAJVmPomRXBeiwJCcp8ij4/tz89vFWq3?=
 =?us-ascii?Q?eKaOmAWOLTziQOkhpojA0utyYrBS50EpwzAq4P1sARjdf53X5p1Ol3Dg9rWB?=
 =?us-ascii?Q?vG2Yhk9KA7dw/h1o7knqp9RzigUoICzAiPrDWNQOGFGnERj7s6dx6vD5uT/E?=
 =?us-ascii?Q?AWTdIJ4BIkUAMeTbWyFjRpPcZHGg?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:13:25.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1a1ffd-a75d-430d-043f-08dccb2f800d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB8239
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 09:13:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16532

From: Christian Lindeberg <christian.lindeberg@axis.com>

Add a go module fetcher for downloading module dependencies to the
module cache from a module proxy. The fetcher can be used with the
go-mod class in OE-Core.

A module dependency can be specified with:

  SRC_URI +=3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=3D..."

Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
---
 lib/bb/fetch2/__init__.py |   4 +-
 lib/bb/fetch2/gomod.py    | 116 ++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py     |  73 ++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/fetch2/gomod.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5bf2c4b8c..f84ce5999 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1317,7 +1317,7 @@ class FetchData(object):
=20
             if checksum_name in self.parm:
                 checksum_expected =3D self.parm[checksum_name]
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp",=
 "s3", "az", "crate", "gs"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp",=
 "s3", "az", "crate", "gs", "gomod"]:
                 checksum_expected =3D None
             else:
                 checksum_expected =3D d.getVarFlag("SRC_URI", checksum_nam=
e)
@@ -2088,6 +2088,7 @@ from . import npmsw
 from . import az
 from . import crate
 from . import gcp
+from . import gomod
=20
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -2110,3 +2111,4 @@ methods.append(npmsw.NpmShrinkWrap())
 methods.append(az.Az())
 methods.append(crate.Crate())
 methods.append(gcp.GCP())
+methods.append(gomod.GoMod())
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
new file mode 100644
index 000000000..0675c87e5
--- /dev/null
+++ b/lib/bb/fetch2/gomod.py
@@ -0,0 +1,116 @@
+"""
+BitBake 'Fetch' implementation for Go modules
+
+The gomod fetcher is used to download Go modules to the module cache from =
a
+module proxy.
+
+Example SRC_URIs:
+
+SRC_URI =3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=3D..."
+
+Required SRC_URI parameters:
+
+- version
+    The version of the module.
+
+Optional SRC_URI parameters:
+
+- mod
+    Fetch and unpack the go.mod file only instead of the complete module.
+    The go command may need to download go.mod files for many different mo=
dules
+    when computing the build list, and go.mod files are much smaller than
+    module zip files.
+    The default is "0", set mod=3D1 for the go.mod file only.
+
+- sha256sum
+    The checksum of the module zip file, or the go.mod file in case of fet=
ching
+    only the go.mod file. Alternatively, set the SRC_URI varible flag for
+    "module@version.sha256sum".
+
+Related variables:
+
+- GOMODCACHE
+    The location of the module cache.
+    The variable must be exported for the go command to find the downloade=
d
+    module cache.
+
+- GO_MOD_PROXY
+    The module proxy used by the fetcher.
+
+See the Go modules reference, https://go.dev/ref/mod, for more information
+about the module cache, module proxies and version control systems.
+"""
+
+import os
+import re
+import shutil
+import zipfile
+
+import bb
+from bb.fetch2 import FetchError, MissingParameterError
+from bb.fetch2.wget import Wget
+
+
+def escape(path):
+    """Escape capital letters using exclamation points."""
+    return re.sub(r'([A-Z])', lambda m: '!' + m.group(1).lower(), path)
+
+
+class GoMod(Wget):
+    """Class to fetch Go modules from a Go module proxy via wget"""
+
+    def supports(self, ud, d):
+        """Check to see if a given URL is for this fetcher."""
+        return ud.type =3D=3D 'gomod'
+
+    def urldata_init(self, ud, d):
+        """Set up to download the module from the module proxy."""
+
+        moddir =3D d.getVar('GOMODCACHE')
+        if not moddir:
+            raise FetchError("The module cache location is not specified i=
n the"
+                             " GOMODCACHE environment variable.")
+        proxy =3D d.getVar('GO_MOD_PROXY') or 'proxy.golang.org'
+
+        if 'version' not in ud.parm:
+            raise MissingParameterError('version', ud.url)
+
+        module =3D ud.host + ud.path
+        ud.parm['module'] =3D module
+        path =3D escape(module + '/@v/' + ud.parm['version'])
+        if ud.parm.get('mod', '0') =3D=3D '1':
+            path +=3D '.mod'
+        else:
+            path +=3D '.zip'
+            ud.parm['unpack'] =3D '0'
+        ud.url =3D bb.fetch2.encodeurl(
+            ('https', proxy, '/' + path, None, None, None))
+        ud.parm['downloadfilename'] =3D path
+        ud.parm['subdir'] =3D os.path.join(moddir, 'cache', 'download',
+                                         os.path.dirname(path))
+        name =3D f"{module}@{ud.parm['version']}"
+        if d.getVarFlag('SRC_URI', name + '.sha256sum'):
+            ud.parm['name'] =3D name
+        super().urldata_init(ud, d)
+
+    def unpack(self, ud, rootdir, d):
+        """Unpack the module in the module cache."""
+
+        # Unpack the module zip file or go.mod file
+        super().unpack(ud, rootdir, d)
+
+        if ud.localpath.endswith('.zip'):
+            # Unpack the go.mod file from the zip file
+            module =3D ud.parm['module']
+            unpackdir =3D ud.parm['subdir']
+            name =3D os.path.basename(ud.localpath).rsplit('.', 1)[0] + '.=
mod'
+            bb.note(f"Unpacking {name} to {unpackdir}/")
+            with zipfile.ZipFile(ud.localpath) as zf:
+                with open(os.path.join(unpackdir, name), mode=3D'wb') as m=
f:
+                    try:
+                        f =3D module + '@' + ud.parm['version'] + '/go.mod=
'
+                        shutil.copyfileobj(zf.open(f), mf)
+                    except KeyError:
+                        # If the module does not have a go.mod file, synth=
esize
+                        # one containing only a module statement.
+                        mf.write(f'module {module}\n'.encode())
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 2ef206343..652907af5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3390,3 +3390,76 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
             fetcher.download()
         output =3D "".join(logs.output)
         self.assertFalse(" not a git repository (or any parent up to mount=
 point /)" in output)
+
+class GoModTest(FetcherTest):
+
+    @skipIfNoNetwork()
+    def test_gomod_url(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/a=
zblob;version=3Dv1.0.0;'
+                'sha256sum=3D9bb69aea32f1d59711701f9562d66432c9c0374205e50=
09d1d1a62f03fb4fdad']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.zip')
+        self.assertNotIn('name', ud.parm)
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
+
+    @skipIfNoNetwork()
+    def test_gomod_url_mod_only(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/a=
zblob;version=3Dv1.0.0;mod=3D1;'
+                'sha256sum=3D7873b8544842329b4f385a3aa6cf82cc2bc8defb41a04=
fa5291c35fd5900e873']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.mod')
+        self.assertNotIn('name', ud.parm)
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
+
+    @skipIfNoNetwork()
+    def test_gomod_url_sha256sum_varflag(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://gopkg.in/ini.v1;version=3Dv1.67.0']
+        self.d.setVarFlag('SRC_URI', 'gopkg.in/ini.v1@v1.67.0.sha256sum', =
'bd845dfc762a87a56e5a32a07770dc83e86976db7705d7f89c5dbafdc60b06c6')
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1=
/%40v/v1.67.0.zip')
+        self.assertEqual(ud.parm['name'], 'gopkg.in/ini.v1@v1.67.0')
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
+
+    @skipIfNoNetwork()
+    def test_gomod_url_no_mod_in_zip(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://gopkg.in/ini.v1;version=3Dv1.67.0;'
+                'sha256sum=3Dbd845dfc762a87a56e5a32a07770dc83e86976db7705d=
7f89c5dbafdc60b06c6']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1=
/%40v/v1.67.0.zip')
+        self.assertNotIn('name', ud.parm)
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
--=20
2.39.2


