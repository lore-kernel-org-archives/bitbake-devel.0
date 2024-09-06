Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE8CE7AF9
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 09:27:54 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.84])
 by mx.groups.io with SMTP id smtpd.web10.31069.1725614868331835284
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Sep 2024 02:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=CD1+zOJT;
 spf=pass (domain: axis.com, ip: 40.107.22.84, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lld813aV9bMGw7WlWGXlbn6AQOH2YkvOrSFWmxBOxHsmoTw1B7jhkRGsudLRLUJ95w9jJCvhhD1TiHkvzPC9jegXuUeyI63PQ409L6ZIFaTDSCSAW6G9p7uWGvpjfDy00vgqSOLMj0Y9YKhiGsLdBOPUpn01yh4GsWrGebJGr7pz/nZry6XOWxGMkLZ/F64kQdxw7t4g4reA6EkVc2huQ8FnrBqSs3DN7sxTmhM6yCyYUN+xYtyNHL3zFYe7Dn/BLe/ZSDREHQNYWqYv//imqoReigvAsSCws1XLhiC2QtXpMRAUEzN+rOHHZIGozpO0rSgzO0Vmu/0BMxYBCOdftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kfy1qE/o6leAYcn3EQhIWgZPOGGyaRYAZvSpekzUFJY=;
 b=Wp1wHAyKYrdIl1YbJOdl0Y1TJEIRwQU+i8xCtxxrqAO93tNSyhDYfs0GoT5M1j1ujD3Vc71kmkaad/OXTFJ4gDqRO+TzmzkkEuFYO8LYe8Tjn4RpcO7uxQ8m6TrwC4W/J9FvajJdgEysRFGYpcLFFR+OWNaodKfiVdYOv1YZGry4TavlfOce2uwEFYz4K6y8Y7RCx/p23KfvPX07A4raM1HgjHiIExbGrGYTQtAEEBdCPZVcoQIlsnPP+NJ/xQTKsy/hUtDmRs3GGgM4krPkMaZq2B9+2auL/orvRpApTqkrnfNzG3QCqnMt9O4JW8NkMTIbxT3PLGHvL4YZssrzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfy1qE/o6leAYcn3EQhIWgZPOGGyaRYAZvSpekzUFJY=;
 b=CD1+zOJTkTV/163JwwifWe74Suh4S8AintwP+3k5XRPbyA/BLCQtWKj/vf2483w8KuteDrvHdhXqp/uQZVZurap3Ev3oY5WB+txdwbTH1PxXqRbOnqTnca136lCKn4FmZPQ2aA4auYEPAKK3CgaLsoU65F9cLJtxfRzboAz2suM=
Received: from AS4P190CA0051.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::25)
 by AM0PR02MB5905.eurprd02.prod.outlook.com (2603:10a6:208:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 09:27:41 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::6) by AS4P190CA0051.outlook.office365.com
 (2603:10a6:20b:656::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:27:39 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 11:27:39 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 11:27:39 +0200
Received: from pc50740-2234.se.axis.com (pc50740-2234.se.axis.com [10.94.131.4])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 712093CD
	for <bitbake-devel@lists.openembedded.org>; Fri,  6 Sep 2024 11:27:39 +0200 (CEST)
Received: by pc50740-2234.se.axis.com (Postfix, from userid 21184)
	id 6AE6B26B985F; Fri,  6 Sep 2024 11:27:39 +0200 (CEST)
From: Christian Lindeberg <christli@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 2/2] fetch2: Add gomodgit fetcher
Date: Fri, 6 Sep 2024 11:27:39 +0200
Message-ID: <20240906092739.930765-2-christli@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240906092739.930765-1-christli@axis.com>
References: <20240906092739.930765-1-christli@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000042:EE_|AM0PR02MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: bf26b752-21d7-4d65-8f78-08dcce562736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pupOr6iRlszddrgKmIwt+3Wzo0dYWWLchkda4RX+21FJuEY3Bj/aPpwy9VPo?=
 =?us-ascii?Q?Pe3pCIgJaF8fJ49K1cGMtFrEkRuL/mfHy7Ot1l1pIHExd/qy8GYgY00F/Map?=
 =?us-ascii?Q?1dgVLJqF4cYDABIOcLZ2WjTeh+DxPzgjCNrMF0yuUZvZKxAn0hwnKOJILWaz?=
 =?us-ascii?Q?3yDTfipwo1APQVMYFx9qV4pY8kmr7H9V+ICZXV4TXhgUIHCNTAHth9e7jgDg?=
 =?us-ascii?Q?tVdUw6lXoUN/IhU/q8A2Ds21k/jDu2voaUEi1HQK1A0VC1iqxn8fhHazGr52?=
 =?us-ascii?Q?O02nJL7rm1p1q5DteUw1z4QlHD5mued0GzBMJBPO8eM4VnQJDRtv7r43BgOa?=
 =?us-ascii?Q?Q/MNuGnorllV5ByRROX2lVa3bBpbuJdpiK9fGw9BhR61Y9aixf3I6GfvKKG5?=
 =?us-ascii?Q?a0apzSZIjBXeML4M74ZVyp/LX4ttvnhOfCAOO8Re4IjN2F9dQ3EZ3KrLAeRs?=
 =?us-ascii?Q?R+3Pi96loxHiaKXJGq1xr0cRXh7qyl6td9UylJK1N+ckH5p3C8E9OisSUuJB?=
 =?us-ascii?Q?zbVA43KyuMKAlBYUi14rj7k7n4DNAT4yf9M8gajJJKhsgK8/HGey3YrBJZua?=
 =?us-ascii?Q?26/LXQINuyVmLsCBQNOqRFENOfnUaQcKD1mJgvRRaqh7/LDzktiXM7dlN+BF?=
 =?us-ascii?Q?WNk3mzc3wk3D3OdSnbd/DfS0z9Odwb9J74PUL94ztdBdGHJz3BgD32YaqV4v?=
 =?us-ascii?Q?2T6u2oCyGqegJenk8qHztZNQouNMG9jW+iGjaxpzVJRfEXHz+e5jQjU+1aYF?=
 =?us-ascii?Q?UOqB0Sby6l2pTPZmGiWK/FqMAkBecHdGz8XCizwjnYC2uHMravPBa55bcVSm?=
 =?us-ascii?Q?GPi+1HPwyABAce7uou0bUfGlxZR7m4V50Alib93BtnSD0eObm6oJCvJrNF5D?=
 =?us-ascii?Q?g+XBr+a93Nqv/H7YOelF9K7T9Ajroq4esagmcc89p+pDuxU/0Oq2a0RW0hN5?=
 =?us-ascii?Q?gnZRUybhE1Y3t/fFFuq2E1CdbNenXPafC5n36vZ3Wb0aEHmn2qfBX8mj4QiA?=
 =?us-ascii?Q?B5Zq7iWLj4htdrwhM0h+a+TYpN9jEMLgPmoHHLHHIj3L8DXh2UQxVwgJsE/8?=
 =?us-ascii?Q?ECM2x9EOTzhVFZsgGv3xOIPqu6ipJUyrUh0d5xb2/U0OVkh7dVuybBiGUPDZ?=
 =?us-ascii?Q?NdxctCn2ucHeHJ9rBvokGW+OTd36Up7KI/FuOzKYKTGn/55ZuGmpra0y9XHK?=
 =?us-ascii?Q?Ig+WRgvrnIh87x8ZtCCjcWEYG2KAFkI/43MqSYzZ75b2sJ2f6ZlxC7UdUBAH?=
 =?us-ascii?Q?tMjegY8ennLkfdUBal+NTKTtQ/05FgtPrGawcGNUwhBhkN5+n0XLieouL1W3?=
 =?us-ascii?Q?8swbqu8bkYYtM0jymTSx46DcTDNKTQhXoCc85AYk+QUA77JsyiDylX7mivkR?=
 =?us-ascii?Q?G7dXZiqhL0YJT8kNQLVaQm8QMluc?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:27:39.9695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf26b752-21d7-4d65-8f78-08dcce562736
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5905
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Sep 2024 09:27:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16544

From: Christian Lindeberg <christian.lindeberg@axis.com>

Add a go module fetcher for downloading module dependencies to the
module cache directly from a git repository. The fetcher can be used
with the go-mod class in OE-Core.

A module dependency can be specified with:

  SRC_URI +=3D "gomodgit://golang.org/x/net;version=3Dv0.9.0;srcrev=3D..."

Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
---

Changes in V2:
- Use separate gomodgit:// type instead of the direct=3Dgit parameter.
- Use GO_MOD_CACHE_DIR variable or default instead of requiring the
  GOMODCACHE environment variable to be set.
- Add more documentation to make it cleared what is downloaded and what
  is unpacked.

 lib/bb/fetch2/__init__.py |   1 +
 lib/bb/fetch2/gomod.py    | 140 +++++++++++++++++++++++++++++++++++++-
 lib/bb/tests/fetch.py     |  89 ++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 2 deletions(-)

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
index fe025e367..1b532d03f 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -1,12 +1,13 @@
 """
 BitBake 'Fetch' implementation for Go modules
=20
-The gomod fetcher is used to download Go modules to the module cache from =
a
-module proxy.
+The gomod/gomodgit fetchers are used to download Go modules to the module =
cache
+from a module proxy or directly from a version control repository.
=20
 Example SRC_URI:
=20
 SRC_URI +=3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=3D..."
+SRC_URI +=3D "gomodgit://golang.org/x/net;version=3Dv0.9.0;repo=3Dgo.googl=
esource.com/net;srcrev=3D..."
=20
 Required SRC_URI parameters:
=20
@@ -27,6 +28,23 @@ Optional SRC_URI parameters:
     only the go.mod file. Alternatively, set the SRC_URI varible flag for
     "module@version.sha256sum".
=20
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
 - GO_MOD_PROXY
@@ -41,14 +59,19 @@ See the Go modules reference, https://go.dev/ref/mod, f=
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
 from bb.fetch2 import FetchError
 from bb.fetch2 import MissingParameterError
+from bb.fetch2 import runfetchcmd
+from bb.fetch2 import subprocess_setup
+from bb.fetch2.git import Git
 from bb.fetch2.wget import Wget
=20
=20
@@ -126,3 +149,116 @@ class GoMod(Wget):
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
+        return ud.type =3D=3D 'gomodgit'
+
+    def urldata_init(self, ud, d):
+        """Set up to download the module from the git repository.
+
+        Set up to download the git repository to the module cache director=
y and
+        unpack the module zip file and the go.mod file:
+
+        cache/vcs/<hash>:                         The bare git repository.
+        cache/download/<module>/@v/<version>.zip: The module zip file.
+        cache/download/<module>/@v/<version>.mod: The go.mod file.
+        """
+
+        moddir =3D d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
+
+        if 'version' not in ud.parm:
+            raise MissingParameterError('version', ud.url)
+
+        module =3D ud.host + ud.path
+        ud.parm['module'] =3D module
+
+        # Set host, path and srcrev for git download
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
+
+        # Set subpath, subdir and bareclone for git unpack
+        if 'subdir' in ud.parm:
+            ud.parm['subpath'] =3D ud.parm['subdir']
+        key =3D f"git3:{ud.parm['protocol']}://{ud.host}{ud.path}".encode(=
)
+        ud.parm['key'] =3D key
+        ud.parm['subdir'] =3D os.path.join(moddir, 'cache/vcs',
+                                         hashlib.sha256(key).hexdigest())
+        ud.parm['bareclone'] =3D '1'
+
+        super().urldata_init(ud, d)
+
+    def unpack(self, ud, rootdir, d):
+        """Unpack the module in the module cache."""
+
+        # Unpack the bare git repository
+        super().unpack(ud, rootdir, d)
+
+        moddir =3D d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
+
+        # Create the info file
+        module =3D ud.parm['module']
+        repodir =3D os.path.join(rootdir, ud.parm['subdir'])
+        with open(repodir + '.info', 'wb') as f:
+            f.write(ud.parm['key'])
+
+        # Unpack the go.mod file from the repository
+        unpackdir =3D os.path.join(rootdir, moddir, 'cache/download',
+                                 escape(module), '@v')
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
index 2365a5096..832e0dd6a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3455,3 +3455,92 @@ class GoModTest(FetcherTest):
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
+    def test_gomodgit_url_repo(self):
+        urls =3D ['gomodgit://golang.org/x/net;version=3Dv0.9.0;'
+                'repo=3Dgo.googlesource.com/net;'
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
+    def test_gomodgit_url_subdir(self):
+        urls =3D ['gomodgit://github.com/Azure/azure-sdk-for-go/sdk/storag=
e/azblob;version=3Dv1.0.0;'
+                'repo=3Dgithub.com/Azure/azure-sdk-for-go;subdir=3Dsdk/sto=
rage/azblob;'
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
+    def test_gomodgit_url_srcrev_var(self):
+        urls =3D ['gomodgit://gopkg.in/ini.v1;version=3Dv1.67.0']
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
+    def test_gomodgit_url_no_go_mod_in_module(self):
+        urls =3D ['gomodgit://gopkg.in/ini.v1;version=3Dv1.67.0;'
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


