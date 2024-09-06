Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D1CE7AF8
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 09:27:54 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.52])
 by mx.groups.io with SMTP id smtpd.web11.30778.1725614868745324130
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Sep 2024 02:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=OYikjzvo;
 spf=pass (domain: axis.com, ip: 52.101.69.52, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoK4CBZ0MqXiIEjYEfyWlUPEpKF7nXW2KxPELWc4Ae3818sCiXuSJmzivKoPC4VowRnSZ8zh4c6wNEKK8M/zYJUQdUsfUfYDsXO4VIY3czIC97OVDaUWqgbtr4lNSKHERISezA9RVzU2eEGArAXb8zU+UMET90uqRM1TVHIHrdE6vBxp2I8vNHGo6XXpq/zES551sxaGQJQoVXMW+j5/l1+lI9oQ+m0uUS6LRpqqzDN+fztNMcy357hrUDumyQS+h2wg0smPxi6KgrLHGIMG0eNi9xwfTwA8HCYJ9h+Ou5EiHNMnuO8oGNaiVK6Vr++a6LYFwEV5fve828VvherLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUgbWR0u1UXHJQAszdXZ/ZTGdpXb57jf0sX13f/7EHQ=;
 b=n6NCUBl/RbCQbXwFTdlmyM2/VnuEdg4MLlUR/8YjvtzbZwL948hKf0ToDzqq1QdlBSUFyaL16ImKM5qK0yeR0B3Xaeat7/k9dpvjcWdrmQxcfp4TMVDDijciFKwGgiKSDQbTpU+HETIg6MbtwV/GrldYozHBV7cCpHS7AkJOBojYU0ksJR0fr1+nfN2cVdNUhcW71cWlcH0y7vJPD4aOkv5mVXet7uME68e5fzsc8SuAlXiHHmUKOOnIOSCmp4/5Nag83LLpAI5BKFZCescOl8lM+4LuVzgp+aW+986EiO7ZQaBq4XWNwTIleQvP1PAqkFdZlGJwF+NLgtn42bAyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUgbWR0u1UXHJQAszdXZ/ZTGdpXb57jf0sX13f/7EHQ=;
 b=OYikjzvo7Tfurj1ZicYqZ2+Ab6MvGanN650mRZ+prY99DS8qgy/AW+GRCDYbPKgqMUMOE8vyildQ+jPHv2EOLL5WFpb/FHg1KIrRIWCKlkSdBdEOEGlfh8xmhGM4dlOzkJXS3LDqqWzAvDWx4fLhGzmifjasnDP+gu1UXvy/B0Q=
Received: from AS8PR04CA0076.eurprd04.prod.outlook.com (2603:10a6:20b:313::21)
 by DB9PR02MB9828.eurprd02.prod.outlook.com (2603:10a6:10:456::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 09:27:40 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:313:cafe::9a) by AS8PR04CA0076.outlook.office365.com
 (2603:10a6:20b:313::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:27:40 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 11:27:39 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 11:27:39 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 11:27:39 +0200
Received: from pc50740-2234.se.axis.com (pc50740-2234.se.axis.com [10.94.131.4])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 704801CE
	for <bitbake-devel@lists.openembedded.org>; Fri,  6 Sep 2024 11:27:39 +0200 (CEST)
Received: by pc50740-2234.se.axis.com (Postfix, from userid 21184)
	id 694BA26B985E; Fri,  6 Sep 2024 11:27:39 +0200 (CEST)
From: Christian Lindeberg <christli@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 1/2] fetch2: Add gomod fetcher
Date: Fri, 6 Sep 2024 11:27:38 +0200
Message-ID: <20240906092739.930765-1-christli@axis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|DB9PR02MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: f8850301-50e9-41fb-b882-08dcce56273b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fCj8hnrWxCBFZZEAk5HhjIr/JbpKJXXPCeAexeO4TGlE3/tlkSf+rnUqtLGb?=
 =?us-ascii?Q?cNRP+u6M5wVUMQxNT8YgOq/KCIRMCs1WlvyCqv0e9hoGO4qERtRugP3CWGI7?=
 =?us-ascii?Q?yiWQeo5fjwBd1XwyftqNqbDBhuAxiW6WCjNJ8+01hWHGDLuK9n3FbH4xTDvQ?=
 =?us-ascii?Q?FuCLsXkXz8VUX+W6kYh+M3qm3DF2BKUJ30vqo6oOJ79drDIYROieOKRiJu8U?=
 =?us-ascii?Q?HMayk7/LY5Z6a/d3LaV0pBUpTJJi94Hygfo+1+ajooG0KwnDgKCYBQiBHeaO?=
 =?us-ascii?Q?DLrVuWL3EVfpc2AQd4pjWK4LRnXOkM4qAlNBicAVtJyCCIGHLXeBpUUza0/J?=
 =?us-ascii?Q?YtVOF59R2rg8cEel9pUXnQaz6uc5yThPcFPtuebR9cs9+evFHJlHNvO49zb4?=
 =?us-ascii?Q?w/CHLmMPI38jx1ACEH6vI8L/9UFDlPGxBLsVS15S69x01yW1D3z4BR9PM/qd?=
 =?us-ascii?Q?+gUMw8R0UXUutasHyQeAxZ9Qir+C+a5sb5CtfCF/CUO1HBZZCGFK35dCJWiE?=
 =?us-ascii?Q?0K/zH3y7qLKHUNeKe52g8eVF33BYPDQrryyd/dkXALq6EmLbWWrDLNYLBN8W?=
 =?us-ascii?Q?v3QZl7OE5L6PO/vxLxM8GWM5JOVp48qqGphoppL/VieGkGYZjHtHWayPHUNv?=
 =?us-ascii?Q?SO2TdiR58enl0Lu97CMTfU9wp6weS+Untza+EC0oZsD84/oXzCTABkY7OAMj?=
 =?us-ascii?Q?q1i/OJetOS1TX2iEX68PkswGsknXBxTPC0cfy+x95Lfjf0fmew3AL2AV2eGN?=
 =?us-ascii?Q?Up1vAjMd/X/MsE3YZLUXkTWVDofoyAxLv09JgyRjzz2ZISembZaVRM+K8dkq?=
 =?us-ascii?Q?sBD8kuCuPZNYBlYoEam6Z+ID2XtsyM2aJ0A7aJDcAiri4VNZNhW84NvuDk/O?=
 =?us-ascii?Q?dDF6Fse3LL+DzNXIN9fEO0xRJ/ww5JVhQ7WJWmjd0DPryEbsZMwAUP3iwjHQ?=
 =?us-ascii?Q?RdoCa21kcsUsPhC/O5hZw9LYPz1y4plE+hofVEhP+m50jNWJ8QqbhfnC6G/0?=
 =?us-ascii?Q?4SsPKjlJc3hWDjaotD1oN7uMbsyGNo4MVrb/qGfNxvVQgVIcBk9Rc6ohpAwY?=
 =?us-ascii?Q?ebN1HSQ5Rdz18Oq296/QuQvT8VF0DpQBTU84TTyhvoZmzlYI99hJTdwucbXM?=
 =?us-ascii?Q?uKDq9OZwT2MeH7ZsNVDWhrHw1I3qqasSQIZSwbYSaG2/Dy3OGJHHySBDLSM7?=
 =?us-ascii?Q?HEF44ONYUSD2jpCIKBvW6r8KBF39R0Bty90m0AF1nrY9KBEK9n3+TvvJBVBv?=
 =?us-ascii?Q?57OPEWliqXY1FKqsCb59QBGlUEaVv3kHB9orrxnAc11MFqfb7eIF8Bflp0OB?=
 =?us-ascii?Q?RV+Yc2sSMqaDQ8wDxNSHv4X56lvw5dX5gvcDqWxa6DXCiMsHAHXFO2oCeNNC?=
 =?us-ascii?Q?6FEZbh74dyTnde8GgXoG0c6zqG0T?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:27:40.0033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8850301-50e9-41fb-b882-08dcce56273b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9828
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Sep 2024 09:27:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16545

From: Christian Lindeberg <christian.lindeberg@axis.com>

Add a go module fetcher for downloading module dependencies to the
module cache from a module proxy. The fetcher can be used with the
go-mod class in OE-Core.

A module dependency can be specified with:

  SRC_URI +=3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=3D..."

Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
---

Changes in V2:
- Use GO_MOD_CACHE_DIR variable or default instead of requiring the
  GOMODCACHE environment variable to be set.
- Add more documentation to make it cleared what is downloaded and what
  is unpacked.

 lib/bb/fetch2/__init__.py |   4 +-
 lib/bb/fetch2/gomod.py    | 128 ++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py     |  65 +++++++++++++++++++
 3 files changed, 196 insertions(+), 1 deletion(-)
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
index 000000000..fe025e367
--- /dev/null
+++ b/lib/bb/fetch2/gomod.py
@@ -0,0 +1,128 @@
+"""
+BitBake 'Fetch' implementation for Go modules
+
+The gomod fetcher is used to download Go modules to the module cache from =
a
+module proxy.
+
+Example SRC_URI:
+
+SRC_URI +=3D "gomod://golang.org/x/net;version=3Dv0.9.0;sha256sum=3D..."
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
+- GO_MOD_PROXY
+    The module proxy used by the fetcher.
+
+- GO_MOD_CACHE_DIR
+    The directory where the module cache is located.
+    This must match the exported GOMODCACHE variable for the go command to=
 find
+    the downloaded modules.
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
+from bb.fetch2 import FetchError
+from bb.fetch2 import MissingParameterError
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
+        """Set up to download the module from the module proxy.
+
+        Set up to download the module zip file to the module cache directo=
ry
+        and unpack the go.mod file (unless downloading only the go.mod fil=
e):
+
+        cache/download/<module>/@v/<version>.zip: The module zip file.
+        cache/download/<module>/@v/<version>.mod: The go.mod file.
+        """
+
+        proxy =3D d.getVar('GO_MOD_PROXY') or 'proxy.golang.org'
+        moddir =3D d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
+
+        if 'version' not in ud.parm:
+            raise MissingParameterError('version', ud.url)
+
+        module =3D ud.host + ud.path
+        ud.parm['module'] =3D module
+
+        # Set URL and filename for wget download
+        path =3D escape(module + '/@v/' + ud.parm['version'])
+        if ud.parm.get('mod', '0') =3D=3D '1':
+            path +=3D '.mod'
+        else:
+            path +=3D '.zip'
+            ud.parm['unpack'] =3D '0'
+        ud.url =3D bb.fetch2.encodeurl(
+            ('https', proxy, '/' + path, None, None, None))
+        ud.parm['downloadfilename'] =3D path
+
+        # Set name parameter if sha256sum is set in recipe
+        name =3D f"{module}@{ud.parm['version']}"
+        if d.getVarFlag('SRC_URI', name + '.sha256sum'):
+            ud.parm['name'] =3D name
+
+        # Set subdir for unpack
+        ud.parm['subdir'] =3D os.path.join(moddir, 'cache/download',
+                                         os.path.dirname(path))
+
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
+            unpackdir =3D os.path.join(rootdir, ud.parm['subdir'])
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
index 2ef206343..2365a5096 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3390,3 +3390,68 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
             fetcher.download()
         output =3D "".join(logs.output)
         self.assertFalse(" not a git repository (or any parent up to mount=
 point /)" in output)
+
+class GoModTest(FetcherTest):
+
+    @skipIfNoNetwork()
+    def test_gomod_url(self):
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
+    def test_gomod_url_go_mod_only(self):
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
+    def test_gomod_url_no_go_mod_in_module(self):
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


