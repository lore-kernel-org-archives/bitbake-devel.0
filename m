Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD09CD3420
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 09:13:37 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.49])
 by mx.groups.io with SMTP id smtpd.web10.34581.1725268409229967024
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Sep 2024 02:13:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=kf3BW/7+;
 spf=pass (domain: axis.com, ip: 40.107.241.49, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb1yOEXHnN4Zwv7ApByTLjcKXU9B+ij3sqfVd5Cq9nJfyNxX7f1dBe4o7kwluqP8pmyNJgE0CBvK6HEta8DbvOl5iKwUi7zgdUHXuwa8uFjdts+ZgSky27fHb1Yx2XOrsrr+CsM6wkTEMnWhMWKDjnNCROPQhRO9oKvVN6DkqD4vnPygfCEzu7UJhFOLeRYFSuPdld/9EixZJ2bu7NWGnOpjxtw9YtoPY7PnLXCpz0NHWMpNHKntvyhHhXbJmtRJTrM9qiCEEdENhrUolKlgDfIes55sXQImQ2pFQ+9Z9Z4MbU68MA0tlOwFh8XE1qjGm41Rry6E/1Lfhr+/aEgD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um8jK5Dho+8+DOl7V+p6y+T3hcUrZu2bHXiApwPlV6s=;
 b=WV+GK4zioZ0m92aLQKadb6OXlz5fKW8aD102wwnpnfua3HHLD2+gPTizphxtr0/TO9nrO5zTIqKfTI+2FaSNu8bcJ/5oL7ELxHBk1VayFU6syS+zoWG2L9E/uSZGD8GaS7/6MCT7MJhVUR3DOw8Mvb70/K7+E6OktKLZ4eL8uqcRRQJYPqaqAYVzmiRsP97lKboDq0upz71jWyrjHeh1giU7QpG3GDLOK1tn6FicVBBjM6Ev8f9um5iEEZZ4LlkU3srOGWcS47JC/a/ubBvZ5Wd5rT0HA+cjgVbpZYzfYnSL0246JWxd9+GiQKgzmAaNZplxyJBa5BAe/NXvnAN2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=bestguesspass action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um8jK5Dho+8+DOl7V+p6y+T3hcUrZu2bHXiApwPlV6s=;
 b=kf3BW/7+fshNclWKnj0jEx9vk/hQ+zhQehALQGdQ1fztlYGzl0usUpybbp2bm/19vG/5XlF0Xmj/Vbk/ZHnHlCY8Hdn19wqZUtDh6ZO0NxEjWqMUfPkES06lSkrM3GOyO0i/ilZDdh+T3oW6Si3aCaMSm0uCoH+XRhNFxcRAZ9g=
Received: from DUZPR01CA0213.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::27) by DU0PR02MB9417.eurprd02.prod.outlook.com
 (2603:10a6:10:418::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 2 Sep
 2024 09:13:24 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::68) by DUZPR01CA0213.outlook.office365.com
 (2603:10a6:10:4b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 09:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 09:13:23 +0000
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
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 316C745F
	for <bitbake-devel@lists.openembedded.org>; Mon,  2 Sep 2024 11:13:23 +0200 (CEST)
Received: by pc50740-2234.se.axis.com (Postfix, from userid 21184)
	id 2CFA826B9862; Mon,  2 Sep 2024 11:13:23 +0200 (CEST)
From: Christian Lindeberg <christli@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] fetch2: Add gomod git fetcher
Date: Mon, 2 Sep 2024 11:13:23 +0200
Message-ID: <20240902091323.2241464-2-christli@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240902091323.2241464-1-christli@axis.com>
References: <20240902091323.2241464-1-christli@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|DU0PR02MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: d56516af-486f-493a-d16c-08dccb2f7f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k87Q/nHNeK6/mz2AAuc2zMVKRoQtVbDoApJ9BZJ8CaZlbq+/vxLR9g/0fSEP?=
 =?us-ascii?Q?gcCMrANGbjSKn1DdmAxE2QAkNwZxCH5LMT91+JaidYw8sfepOVkuF9iZAHmE?=
 =?us-ascii?Q?pPTrZA3bEqDFr1y4oJTZKdgAU3WLfy84mdx8ab961OvvuU8Bw5wrY8hFzTjl?=
 =?us-ascii?Q?7AU1DNe2RB2KKT9FW6X7hvCpUy6Z3uyS2B6xM6KZAKE5P712ccFtT8IzwJRl?=
 =?us-ascii?Q?YMaEs2iJo6A79zlFtLpRj8m80AJIqbb+v1gc4JPyq1+++jYQnJrhfL3BtXf+?=
 =?us-ascii?Q?v+1b6jVCUAfkCV+gbDiPG8YftdVQ5hJhZDt3iiRBUNzsu61y0xZFXlc4GEf3?=
 =?us-ascii?Q?94FF0x7aBul7v8CqcePUYtNm21+77sQdmJT49E9UorXjr++/PPmpz65BCdg7?=
 =?us-ascii?Q?Obj1zR5lYFUu2ylBMlAz0EIGoCWeTwFg1g8O/cXMTTTA5o2Uruy9KCCBlyRe?=
 =?us-ascii?Q?1fBf6tXSjIdAi2C9QJvp5pwYXBFrD4ndz0SYlE0X2RyyG2yo8O0St23TR8VQ?=
 =?us-ascii?Q?Z9O9Ik5KZt7ZGWkSuCCWCLom6dHQodsCqZHX2v38A3rFFGenWwDncTYgLF80?=
 =?us-ascii?Q?e7WfdNqvNmM9ZhJxPpGSUhKn72lcUftyNzq14TkkrRRAJFtJoZiYBbxk7grG?=
 =?us-ascii?Q?V18K6A29I6Ro5wgezDcBO2cdFd8kpsMaYw3LVq0UPUE7BP7dSu+SbPg+4NQW?=
 =?us-ascii?Q?c/WSSZ/rJZao9vWXhhcnsz2c8byXJIigt9cjb9yrXXUvUEcsOwIPJrHRCYo1?=
 =?us-ascii?Q?iuBnrdPhGTCDKu31tqKP2ApjMRiUYdN557UbRiu2JNsQ0Cl+Wqk12YhPGM+8?=
 =?us-ascii?Q?EJ98B6MuerJJ9WsQ1qNt3KGE3bg04/BvHhF5hoO2F3++vVgYUI4PUR0pL7tR?=
 =?us-ascii?Q?vSm/GU5nUmSFYVF70v35VTt2mPD9c20D2Uo+Y0lewQxIU/Lycf8HH14LA9dZ?=
 =?us-ascii?Q?RwKgiYvMo5taQzS7LEZZvdwg6hQhDF6Pj+TUHoId2oCK+3mwToZdPTCzcd/U?=
 =?us-ascii?Q?2Ek//V2n/e0/lSyj7WFDHUGvq0Ki0g5nP6MrMcxOTx9E9UQvjcFz5DfC0trb?=
 =?us-ascii?Q?AMWrlMrdl79vfmt/97OhxEhjW6dvOhQ1gLRxGbtGIsPgDq/eBRR37Tg07GVn?=
 =?us-ascii?Q?2FCTOk0PYhZXKL9dZtUGBWlmkyowlMlNR6XmXQ+FgGmhRwkbsO0XzztmAcQK?=
 =?us-ascii?Q?nyRnACGikJvBEpbuM+X3wGvZnRosk5tfNtvvHCmaHqyb4Wl63BdfSaa2JFAT?=
 =?us-ascii?Q?/un4m9InwsCStGAAugv3fTvqrwnxNLPkx0GwqrJz7o2HlH4hrUKgpEluTq2B?=
 =?us-ascii?Q?nmkRtaCYgK6JNfkHb4l/XFA9NgYE/Cs6XciFRmvqq8WaP607JN2EaTAEhNu3?=
 =?us-ascii?Q?PfFQB5HTS5bSUD+yn8BzDxBtqonf?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:13:23.9349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56516af-486f-493a-d16c-08dccb2f7f57
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9417
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 09:13:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16531

From: Christian Lindeberg <christian.lindeberg@axis.com>

Add a go module fetcher for downloading module dependencies to the
module cache directly from a git repository.

Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
---
 lib/bb/fetch2/__init__.py |   1 +
 lib/bb/fetch2/gomod.py    | 137 ++++++++++++++++++++++++++++++++++++--
 lib/bb/tests/fetch.py     |  97 +++++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f84ce5999..ddee4400b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2112,3 +2112,4 @@ methods.append(az.Az())
 methods.append(crate.Crate())
 methods.append(gcp.GCP())
 methods.append(gomod.GoMod())
+methods.append(gomod.GoModGit())
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 0675c87e5..50f1a4be6 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -1,12 +1,13 @@
 """
 BitBake 'Fetch' implementation for Go modules
=20
-The gomod fetcher is used to download Go modules to the module cache from =
a
-module proxy.
+The gomod fetchers are used to download Go modules to the module cache fro=
m a
+module proxy or directly from a version control repository.
=20
 Example SRC_URIs:
=20
 SRC_URI =3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=3D..."
+SRC_URI =3D "gomod://golang.org/x/net;version=3Dv0.9.0;direct=3Dgit;repo=
=3Dgo.googlesource.com/net;srcrev=3D..."
=20
 Required SRC_URI parameters:
=20
@@ -27,6 +28,27 @@ Optional SRC_URI parameters:
     only the go.mod file. Alternatively, set the SRC_URI varible flag for
     "module@version.sha256sum".
=20
+- direct
+   Fetch directly from a version control repository.
+   Supported values: "git".
+
+- protocol
+    The method used when fetching directly from a version control reposito=
ry.
+    The default is "https" for git.
+
+- repo
+    The URL when fetching directly from a version control repository. Requ=
ired
+    when the URL is different from the module path.
+
+- srcrev
+    The revision identifier used when fetching directly from a version con=
trol
+    repository. Alternatively, set the SRCREV varible for "module@version"=
.
+
+- subdir
+    The module subdirectory when fetching directly from a version control
+    repository. Required when the module is not located in the root of the
+    repository.
+
 Related variables:
=20
 - GOMODCACHE
@@ -41,13 +63,19 @@ See the Go modules reference, https://go.dev/ref/mod, f=
or more information
 about the module cache, module proxies and version control systems.
 """
=20
+import hashlib
 import os
 import re
 import shutil
+import subprocess
 import zipfile
=20
 import bb
-from bb.fetch2 import FetchError, MissingParameterError
+from bb.fetch2 import FetchError
+from bb.fetch2 import MissingParameterError
+from bb.fetch2 import runfetchcmd
+from bb.fetch2 import subprocess_setup
+from bb.fetch2.git import Git
 from bb.fetch2.wget import Wget
=20
=20
@@ -61,7 +89,7 @@ class GoMod(Wget):
=20
     def supports(self, ud, d):
         """Check to see if a given URL is for this fetcher."""
-        return ud.type =3D=3D 'gomod'
+        return ud.type =3D=3D 'gomod' and 'direct' not in ud.parm
=20
     def urldata_init(self, ud, d):
         """Set up to download the module from the module proxy."""
@@ -114,3 +142,104 @@ class GoMod(Wget):
                         # If the module does not have a go.mod file, synth=
esize
                         # one containing only a module statement.
                         mf.write(f'module {module}\n'.encode())
+
+
+class GoModGit(Git):
+    """Class to fetch Go modules directly from a git repository"""
+
+    def supports(self, ud, d):
+        """Check to see if a given URL is for this fetcher."""
+        return ud.type =3D=3D 'gomod' and ud.parm['direct'] =3D=3D 'git'
+
+    def urldata_init(self, ud, d):
+        """Set up to download the module from the git repository."""
+
+        mod_dir =3D d.getVar('GOMODCACHE')
+        if not mod_dir:
+            raise FetchError("The module cache location is not specified i=
n the"
+                             " GOMODCACHE environment variable.")
+
+        if 'version' not in ud.parm:
+            raise MissingParameterError('version', ud.url)
+
+        module =3D ud.host + ud.path
+        ud.parm['module'] =3D module
+        if 'repo' in ud.parm:
+            repo =3D ud.parm['repo']
+            idx =3D repo.find('/')
+            if idx !=3D -1:
+                ud.host =3D repo[:idx]
+                ud.path =3D repo[idx:]
+            else:
+                ud.host =3D repo
+                ud.path =3D ''
+        if 'protocol' not in ud.parm:
+            ud.parm['protocol'] =3D 'https'
+        ud.parm['bareclone'] =3D '1'
+        if 'subdir' in ud.parm:
+            ud.parm['subpath'] =3D ud.parm['subdir']
+        key =3D f"git3:{ud.parm['protocol']}://{ud.host}{ud.path}".encode(=
)
+        ud.parm['key'] =3D key
+        ud.parm['subdir'] =3D os.path.join(mod_dir, 'cache', 'vcs',
+                                         hashlib.sha256(key).hexdigest())
+        name =3D f"{module}@{ud.parm['version']}"
+        ud.names =3D [name]
+        srcrev =3D d.getVar('SRCREV_' + name)
+        if srcrev:
+            if 'srcrev' not in ud.parm:
+                ud.parm['srcrev'] =3D srcrev
+        else:
+            if 'srcrev' in ud.parm:
+                d.setVar('SRCREV_' + name, ud.parm['srcrev'])
+        if 'branch' not in ud.parm:
+            ud.parm['nobranch'] =3D '1'
+        super().urldata_init(ud, d)
+
+    def unpack(self, ud, rootdir, d):
+        """Unpack the module in the module cache."""
+
+        # Unpack the bare git repository
+        super().unpack(ud, rootdir, d)
+
+        # Create the info file
+        module =3D ud.parm['module']
+        repodir =3D ud.parm['subdir']
+        with open(repodir + '.info', 'wb') as f:
+            f.write(ud.parm['key'])
+
+        # Unpack the go.mod file from the repository
+        unpackdir =3D os.path.join(d.getVar('GOMODCACHE'), 'cache', 'downl=
oad',
+                                    escape(module), '@v')
+        bb.utils.mkdirhier(unpackdir)
+        srcrev =3D ud.parm['srcrev']
+        version =3D ud.parm['version']
+        escaped_version =3D escape(version)
+        cmd =3D f"git ls-tree -r --name-only '{srcrev}'"
+        if 'subpath' in ud.parm:
+            cmd +=3D f" '{ud.parm['subpath']}'"
+        files =3D runfetchcmd(cmd, d, workdir=3Drepodir).split()
+        name =3D escaped_version + '.mod'
+        bb.note(f"Unpacking {name} to {unpackdir}/")
+        with open(os.path.join(unpackdir, name), mode=3D'wb') as mf:
+            f =3D 'go.mod'
+            if 'subpath' in ud.parm:
+                f =3D os.path.join(ud.parm['subpath'], f)
+            if f in files:
+                cmd =3D ['git', 'cat-file', 'blob', srcrev + ':' + f]
+                subprocess.check_call(cmd, stdout=3Dmf, cwd=3Drepodir,
+                                      preexec_fn=3Dsubprocess_setup)
+            else:
+                # If the module does not have a go.mod file, synthesize on=
e
+                # containing only a module statement.
+                mf.write(f'module {module}\n'.encode())
+
+        # Synthesize the module zip file from the repository
+        name =3D escaped_version + '.zip'
+        bb.note(f"Unpacking {name} to {unpackdir}/")
+        with zipfile.ZipFile(os.path.join(unpackdir, name), mode=3D'w') as=
 zf:
+            prefix =3D module + '@' + version + '/'
+            for f in files:
+                cmd =3D ['git', 'cat-file', 'blob', srcrev + ':' + f]
+                data =3D subprocess.check_output(cmd, cwd=3Drepodir,
+                                               preexec_fn=3Dsubprocess_set=
up)
+                zf.writestr(prefix + f, data)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 652907af5..70aed9f49 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3463,3 +3463,100 @@ class GoModTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
+
+class GoModGitTest(FetcherTest):
+
+    @skipIfNoNetwork()
+    def test_gomod_url_git_repo(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://golang.org/x/net;version=3Dv0.9.0;'
+                'direct=3Dgit;repo=3Dgo.googlesource.com/net;'
+                'srcrev=3D694cff8668bac64e0864b552bffc280cd27f21b1']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'go.googlesource.com')
+        self.assertEqual(ud.path, '/net')
+        self.assertEqual(ud.names, ['golang.org/x/net@v0.9.0'])
+        self.assertEqual(self.d.getVar('SRCREV_golang.org/x/net@v0.9.0'), =
'694cff8668bac64e0864b552bffc280cd27f21b1')
+
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+        fetcher.unpack(self.unpackdir)
+        vcsdir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'ed42bd05533fd=
84ae290a5d33ebd3695a0a2b06131beebd5450825bee8603aca')))
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'golang.o=
rg/x/net/@v/v0.9.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'golang.o=
rg/x/net/@v/v0.9.0.mod')))
+
+    @skipIfNoNetwork()
+    def test_gomod_url_git_subdir(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/a=
zblob;version=3Dv1.0.0;'
+                'direct=3Dgit;repo=3Dgithub.com/Azure/azure-sdk-for-go;sub=
dir=3Dsdk/storage/azblob;'
+                'srcrev=3Dec928e0ed34db682b3f783d3739d1c538142e0c3']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'github.com')
+        self.assertEqual(ud.path, '/Azure/azure-sdk-for-go')
+        self.assertEqual(ud.parm['subpath'], 'sdk/storage/azblob')
+        self.assertEqual(ud.names, ['github.com/Azure/azure-sdk-for-go/sdk=
/storage/azblob@v1.0.0'])
+        self.assertEqual(self.d.getVar('SRCREV_github.com/Azure/azure-sdk-=
for-go/sdk/storage/azblob@v1.0.0'), 'ec928e0ed34db682b3f783d3739d1c538142e0=
c3')
+
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
+        fetcher.unpack(self.unpackdir)
+        vcsdir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'd31d6145676ed=
3066ce573a8198f326dea5be45a43b3d8f41ce7787fd71d66b3')))
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
+
+    @skipIfNoNetwork()
+    def test_gomod_url_git_srcrev_var(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://gopkg.in/ini.v1;version=3Dv1.67.0;direct=3Dgit'=
]
+        self.d.setVar('SRCREV_gopkg.in/ini.v1@v1.67.0', 'b2f570e5b5b844226=
bbefe6fb521d891f529a951')
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'gopkg.in')
+        self.assertEqual(ud.path, '/ini.v1')
+        self.assertEqual(ud.names, ['gopkg.in/ini.v1@v1.67.0'])
+        self.assertEqual(ud.parm['srcrev'], 'b2f570e5b5b844226bbefe6fb521d=
891f529a951')
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        vcsdir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'b7879a4be9ba8=
598851b8278b14c4f71a8316be64913298d1639cce6bde59bc3')))
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
+
+    @skipIfNoNetwork()
+    def test_gomod_url_git_no_mod_in_zip(self):
+        self.d.setVar('GOMODCACHE', os.path.join(self.unpackdir, 'pkg/mod'=
))
+
+        urls =3D ['gomod://gopkg.in/ini.v1;version=3Dv1.67.0;direct=3Dgit;=
'
+                'srcrev=3Db2f570e5b5b844226bbefe6fb521d891f529a951']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'gopkg.in')
+        self.assertEqual(ud.path, '/ini.v1')
+        self.assertEqual(ud.names, ['gopkg.in/ini.v1@v1.67.0'])
+        self.assertEqual(self.d.getVar('SRCREV_gopkg.in/ini.v1@v1.67.0'), =
'b2f570e5b5b844226bbefe6fb521d891f529a951')
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        vcsdir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'b7879a4be9ba8=
598851b8278b14c4f71a8316be64913298d1639cce6bde59bc3')))
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
--=20
2.39.2


