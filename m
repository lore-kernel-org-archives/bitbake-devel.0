Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B2EE77190
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.149745.1734693993938884026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=bWvwy3aL;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT/8M/2cfZP4CUWOkpjxTCLt/ZrriMISP+lqDcKxl8R+lgQx6o74ToUpWXR+pBOpGVMllUq48WfQ5/q3kHwtIoszqVuwv8f1WjXOaZRoFvDK1WXDeg8m5creZukDfYfFGqpn48vy3lYgA1ZqoDm5ab/k9JuWBogilOoDfJocLAXq/DXg9mfGFo98ETOVwqvzFrYI3WuOybdsJfzRQv9uT1priUcC6f/iAFFlmhoFheoxt18Nq3bAgIwAB5rz/Iu+J8IdpH/e27YKIzpCB3nR+xXqEruR/uoMhBeGOpbAO+gitZ32bi6myyUBAA12Cgl119ixFtPp3Umh7ugyLsD8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF/1cmfyQar4RmGSIuctJzlIqWaTxq4P++PXjMRTXrU=;
 b=yVqxFq0KCZ7BP6dZNmeIedB+n1GxGny90erSgHoxlOXYT5OC6iSkWs3YfaojGhZlqGkY7MVRD9bjl42YFHpqRsKjlKLQpm7TlkSBs8n4rtyCvUT+w2LY/5ltE4uJJxg3uQsr/qYO1BgC5C+BA/V9S2Iyv86nFZc3DfSduhPu1vtF2Lj9f4BjyHSmXTqUp9ImnPw+drpIzaelIa+4goQCB00qrUqfU+/12KrVpnx0Z/Ggbv96LyK1TCijPuapXzx4s9SkczpOZmv27RlIoQOT4gbcGoPgXn9N1Jzk7QjbkWQclgPF+W5odGLdyMnQMDYMO6qBPUjW6KeEc8WkFTq7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF/1cmfyQar4RmGSIuctJzlIqWaTxq4P++PXjMRTXrU=;
 b=bWvwy3aL5cd5/errXLNJ4He3KGgxHdBEdb7TL3DQBn/n3Mw7kQP2mrblBy2yWAC/ZoEx1sIv36KOj32mK07bME93mtnUwntnxNRm/XF18vYHCQY8P78LBatyUo3pN3AxlJEczgz685uBbIqyfM7apUhrWXRiUiShn1Npf9htBO9JedxGhxKY2bSPnzydxtg2XZHwGtmtuHmLocPV+P8wqAwwWDPRlwHVeiePuAUWSGaSx2JJaXpennzS9fopM9qv3lnyrS7CRUMcSyEAWAf+rTIlXLenYzA12qENeVGVTEWM/3bqTIVAAvFE44ZD83OSpohM5Yq8w1IUskDqQiiOCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:26:31 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:31 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 17/21] tests: fetch: adapt npmsw test cases
Date: Fri, 20 Dec 2024 12:26:08 +0100
Message-ID: <20241220112613.22647-18-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM8PR08MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1481bb-bf7f-4a4a-eb8d-08dd20e92625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fVxrD1iLfWeaanXQQdEAGy4qv0G35PWwDDYCr4+kv+BI8H3OlveVvpJ0t+kW?=
 =?us-ascii?Q?3TejxZhQjtgS1vjoGOAvYaHtbIqKz0Gh/mPq2LKdHWzjE/hIVtgp84Gi/2+a?=
 =?us-ascii?Q?zPQT6IahHndJEnt5VRgjLZZIsg4pjJLvRZW941vKZeSBZyy5G1bSXuZScH3m?=
 =?us-ascii?Q?kAuwDFJeh8AbaaBWXd8mRdavwDyfiWHqfXrHYm5ytlckrP1PzG9XJBj4VsRM?=
 =?us-ascii?Q?Aih+zEt9XWOA7SrizGSL2YoKJd+pQ4B1pmn0LldBsNpSyV+oE1rvRWpfEMWJ?=
 =?us-ascii?Q?Of64bB41GasqpRgrQX/0ADMjKWmVHbMoXjEJJc5qhfUXKT8ZnbEG0FASXKf5?=
 =?us-ascii?Q?7YUY8mH+m5yxqkLHL+ZTzzl0GMcbBMqD58n5GGY7VXNYxKu7Aunc2wcCT+YP?=
 =?us-ascii?Q?dFf3qtTS0i4s5+w5lc4aTV4WfJ8x3jzXhvpeQrSap/P+IX+MTOY0tC3PVORl?=
 =?us-ascii?Q?U/tQbMu0nQxMc5ME79/Liic61d0Cxl6PcnbVjZlmG6jUmuiHCD8Ro8lHwfwz?=
 =?us-ascii?Q?DRqGiVrnmQ/BmGdmyY1MXJ7IG2oc/bwBzepFUnWboKWwnNSc3OYDc2sNf1ui?=
 =?us-ascii?Q?DUAOJq3lapr39P4MGh+Ht2qdobaI95jH0YNrh5nm7u9a6jmzRDWlLioMA7pg?=
 =?us-ascii?Q?in9dcYAbA6f3rgEiFr3fIgAkHffCA5O9vTMGbVygw8k7IubfYl0pv8pRhrGe?=
 =?us-ascii?Q?OB4PO8iL8IQGJA3AUyNNPZ77x2+7op3V8JEQKGW/HcHQJWeBR2levLQcFfRx?=
 =?us-ascii?Q?UY1yXLPbkHV6oWzwu44p8IOXxKiJJcy/O1gGl7o337io7zt8gO2uWOIiGpYW?=
 =?us-ascii?Q?6E/5HKAktLge2QPhSC2cn2vttoZz/Djz2FjgqfONDq8Prw4p32cR8Rz2e/S8?=
 =?us-ascii?Q?kz9mPgRdbN476nAuklibSXpqgCKkRqBoZR6Uxo32sQRGW3KMyL9Pbhj5nyHY?=
 =?us-ascii?Q?SfOCQ0rwkXEA87SLzJNCOWQ5ky+hFUQYi1k/ZjClXMNg+42uzLs8f2xmmMJf?=
 =?us-ascii?Q?k+mpAOKCp7W4o1H5drv/V2o5HCZqIbBOScpfKgnm8ERnMAUMzN3vWn6d0cK+?=
 =?us-ascii?Q?80ggc8WAF98oVq++biNP0X+TRqdMlG7I0s6fl12cEOfM8Pi1K6q6M4w+uIZ7?=
 =?us-ascii?Q?oftwx+W0DTH6EtBuXdBuu3nBacp+c8A1uWHlFxbd7wztYAeVdNnQc2KK9jkA?=
 =?us-ascii?Q?+8//RIXgt27v97J14r8f6Uy456RlV/eBtDqeMl35CXAzEtF5NbdpJIecmX7Q?=
 =?us-ascii?Q?yictOPtaDwZ6uPctJZLOXwCmtfx9NhhVSBoC2I9RqzdrX71ctwzeoPhLaXUx?=
 =?us-ascii?Q?ru4EEkFRPZLnfkaBAersnU+4iRVwNAxtw+T5MRYYdYLaaW9k8GPMOne5K53s?=
 =?us-ascii?Q?PsKbuM+gxrlGkI2Oh2M7aGcftSSeiW90zzsmhwBFBKHQ9AdjTQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tzCeWBIHKc1GDHON7ficET7MP0Oq4X2OcVziPq/LFzLbWRpy4ZmQawFm4n4N?=
 =?us-ascii?Q?pLvwijlkgqNqHz9Kw5NmXzljiLFjN8R1YtqnlaCAdposWXvfbEE2GGzeHRZZ?=
 =?us-ascii?Q?Sfc2yaDn7j0/kwsMgOmW+wvkuVdgqfeBZ3aprp3GtljBQP4+azwBU5bgoYxu?=
 =?us-ascii?Q?OGUcMgTEEhm2IRc9UYnXnEAkVqIc4TYOlq/u9d/g3vvRh7qLOkEbfXSPMI80?=
 =?us-ascii?Q?Z+qQUf/ys0yktT2/9Hw6LTpYAUkqFXM78mB3RULyjsdtUeyCNr303LZk1hkq?=
 =?us-ascii?Q?ve9Zz78zru+Xd89KEcqoUVNLoca9ljL8iICGCbauEmoRRyFzodCW7Yy/FbeO?=
 =?us-ascii?Q?V/aPBlUwTmH3z9nPpBtKP/RyAXTeCU6pggytA6I2fD90niwPPqf3vM+BpXlv?=
 =?us-ascii?Q?4fJUaLzmmzfdBJw/65puC2tpGd20i8eZe2sTi0/xNlBs+DJSP1ZuncZn4vHv?=
 =?us-ascii?Q?N8xVBloXJJ7hnfow20LAP7oDc9zaL62SLM+O6c7K4MI1keVVuqfyZZWyRWr0?=
 =?us-ascii?Q?NoqUqzobKsdLYejHKQA75+i2r9brbBb47xIgMfXaj8E6ELrWzvuqHIwogmdk?=
 =?us-ascii?Q?cyZlHnTAJDqTnzJ+xzXJ46vZD1JzlKx8jWHxgXTTMuUm+FEubNNUMjPVulsv?=
 =?us-ascii?Q?iE8QtJj4pXqlHNMSBP54pmDVFm3HEFS6eaSeN1nYtLp4ngc3soeZlfEJaaN/?=
 =?us-ascii?Q?CHCvJ7W+rv70zaBmixOI6A37C613+dlovkyti+SGUAFsvOJ9Rd/MSMwlXrqr?=
 =?us-ascii?Q?FeHn1sLry51PBmbkpxNpXEiPBxk/WMTAMaEQzU73vvp8CY3CfXdlFfCxy24g?=
 =?us-ascii?Q?/38LJP8bCZ3M+ON2zsyivP/R3F7Zp/teGjnrKvnmPKkrNvhEORESLbRcs6H1?=
 =?us-ascii?Q?VlmHwao6sgGE+1CMi0U/9Um0EwecXf5NBk/1Mphf8UAWmWRtu48WOwKxLJzj?=
 =?us-ascii?Q?alrZw0XUsLbEUIQMv7zRij9U32JXun6CRVDoVYdj7rLZKQuEF5k+SSFTTWco?=
 =?us-ascii?Q?QjUEHwYUbjUJnG+mWGrAUfqu2wNOIqSvYQhbRLshlTURLum+KmlsTbObTmTZ?=
 =?us-ascii?Q?3zg+SXq2u2bjMb81c5Aw+A2rmBcZ7jeQiPEwhRRg9BQwCfEHaguaYwepAr/z?=
 =?us-ascii?Q?e0wWTMj4mF0n7u7pExD50xXueAxBjeJBJmi5w/8nnGJXm9Ra+CElRsh+0zFf?=
 =?us-ascii?Q?uSOhGZJjy247BaKJdIvYYho3O5qpQFyjAMX22S8gjXHjrlvRqDLKsG1zuVdK?=
 =?us-ascii?Q?JLULTirFo4zjx+h+yLNdwzTYqWcr2BHIObU9YLvehVQXGWj6HDhhSYrJihOm?=
 =?us-ascii?Q?mDKD/txGzRNFqS0YqmCklVcsjcpGz+OrLtwxAka4LMGQedDU9Lt2CMPm1Cu/?=
 =?us-ascii?Q?htiZGSWU6KxU2jPahL7ldba47JofHN2kRsa/jaeFpcDdtdrH2hnlsVBGKW5P?=
 =?us-ascii?Q?X9khbeG29RE0cE4jxg9JwIyZ0U7amEXWlQHwqzaJZwr14pvFPOa9NQLvk5zM?=
 =?us-ascii?Q?cUM0SFnjKT4qonAEIX93zqeVvcoRQW3r60qkJM7FbLuHxhtmV4rvHxHtCTzU?=
 =?us-ascii?Q?1yO0y4YBkw8ZYO1gUwDfnH+RUGA9PLGfheMEJ9EuycmjQQ9wRRh1sTUz2r57?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1481bb-bf7f-4a4a-eb8d-08dd20e92625
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:29.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGXIuOfo1mwCe2q3RcVETkgdJsnqarlW/C0I/2QNoPyvbXkl5xBpsMyjM8nrWHFoSSi45yNlq1AQPJWXA2UjGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16933

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Adapt the npmsw test cases to the reworked npmsw fetcher:
* Remove decorator for npm binary check
* Define excepted file names
* Remove test cases for (pre)mirrors, network and invalid urls because
  the reworked class uses the npm, wget and git fetcher.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 255 +++++++++++-------------------------------
 1 file changed, 65 insertions(+), 190 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 903095746..437571f1c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2683,24 +2683,22 @@ class NPMTest(FetcherTest):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
 class NPMSWTest(FetcherTest):
-    def skipIfNoNpm():
-        import shutil
-        if not shutil.which("npm"):
-            return unittest.skip("npm not installed")
-        return lambda f: f
+    def setUp(self):
+        super().setUp()
+        self.localsrcdir =3D os.path.join(self.tempdir, "localsrc")
+        os.makedirs(self.localsrcdir)
+        self.d.setVar("FILESPATH", self.localsrcdir)
=20
     def create_shrinkwrap_file(self, data):
         import json
-        datadir =3D os.path.join(self.tempdir, "data")
-        swfile =3D os.path.join(datadir, "npm-shrinkwrap.json")
-        bb.utils.mkdirhier(datadir)
-        with open(swfile, "w") as f:
+        filename =3D "npm-shrinkwrap.json"
+        with open(os.path.join(self.localsrcdir, filename), 'w') as f:
             json.dump(data, f)
-        return swfile
+        return filename
=20
     @skipIfNoNetwork()
     def test_npmsw(self):
-        swfile =3D self.create_shrinkwrap_file({
+        filename =3D self.create_shrinkwrap_file({
             "packages": {
                 "node_modules/array-flatten": {
                     "version": "1.1.1",
@@ -2720,13 +2718,19 @@ class NPMSWTest(FetcherTest):
                 },
                 "node_modules/array-flatten/node_modules/content-type/node=
_modules/cookie": {
                     "resolved": "git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09"
+                },
+                "node_modules/karma": {
+                    "resolved": "",
+                    "link": True
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch([f"npmsw://{filename}"], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz.done")))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/cont=
ent-type-1.0.4.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/cont=
ent-type-1.0.4.tgz.done")))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gith=
ub.com.jshttp.cookie.git")))
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "npm-s=
hrinkwrap.json")))
@@ -2735,21 +2739,8 @@ class NPMSWTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "node_=
modules/array-flatten/node_modules/content-type/node_modules/cookie/package=
.json")))
=20
     @skipIfNoNetwork()
-    def test_npmsw_git(self):
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/cookie": {
-                    "resolved": "git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09"
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gith=
ub.com.jshttp.cookie.git")))
-
-    @skipIfNoNetwork()
-    def test_npmsw_dev(self):
-        swfile =3D self.create_shrinkwrap_file({
+    def test_npmsw_resolve_dev(self):
+        filename =3D self.create_shrinkwrap_file({
             "packages": {
                 "node_modules/array-flatten": {
                     "version": "1.1.1",
@@ -2765,19 +2756,23 @@ class NPMSWTest(FetcherTest):
             }
         })
         # Fetch with dev disabled
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch([f"npmsw://{filename}"], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz.done")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "npm2/con=
tent-type-1.0.4.tgz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "npm2/con=
tent-type-1.0.4.tgz.done")))
         # Fetch with dev enabled
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile + ";dev=3D1"], sel=
f.d)
+        fetcher =3D bb.fetch.Fetch([f"npmsw://{filename};dev=3D1"], self.d=
)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz.done")))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/cont=
ent-type-1.0.4.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/cont=
ent-type-1.0.4.tgz.done")))
=20
     @skipIfNoNetwork()
-    def test_npmsw_destsuffix(self):
-        swfile =3D self.create_shrinkwrap_file({
+    def test_npmsw_subdir(self):
+        filename =3D self.create_shrinkwrap_file({
             "packages": {
                 "node_modules/array-flatten": {
                     "version": "1.1.1",
@@ -2786,170 +2781,17 @@ class NPMSWTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile + ";destsuffix=3Df=
oo/bar"], self.d)
+        fetcher =3D bb.fetch.Fetch([f"npmsw://{filename};subdir=3Dfoo/bar"=
], self.d)
         fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz.done")))
         fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "foo/b=
ar/npm-shrinkwrap.json")))
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "foo/b=
ar/node_modules/array-flatten/package.json")))
=20
-    def test_npmsw_no_network_no_tarball(self):
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/array-flatten": {
-                    "version": "1.1.1",
-                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
-                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
-                }
-            }
-        })
-        self.d.setVar("BB_NO_NETWORK", "1")
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
-            fetcher.download()
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npmsw_no_network_with_tarball(self):
-        # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
-        fetcher.download()
-        # Disable network access
-        self.d.setVar("BB_NO_NETWORK", "1")
-        # Fetch again
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/array-flatten": {
-                    "version": "1.1.1",
-                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
-                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        fetcher.download()
-        fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "node_=
modules/array-flatten/package.json")))
-
-    @skipIfNoNetwork()
-    def test_npmsw_npm_reusability(self):
-        # Fetch once with npmsw
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/array-flatten": {
-                    "version": "1.1.1",
-                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
-                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        fetcher.download()
-        # Disable network access
-        self.d.setVar("BB_NO_NETWORK", "1")
-        # Fetch again with npm
-        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
-        fetcher.download()
-        fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "npm/p=
ackage.json")))
-
-    @skipIfNoNetwork()
-    def test_npmsw_bad_checksum(self):
-        # Try to fetch with bad checksum
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/array-flatten": {
-                    "version": "1.1.1",
-                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
-                    "integrity": "sha1-gfNEp2hqgLTFKT6P3AsBYMgsBqg=3D"
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
-            fetcher.download()
-        # Fetch correctly to get a tarball
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/array-flatten": {
-                    "version": "1.1.1",
-                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
-                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        fetcher.download()
-        localpath =3D os.path.join(self.dldir, "npm2/array-flatten-1.1.1.t=
gz")
-        self.assertTrue(os.path.exists(localpath))
-        # Modify the tarball
-        bad =3D b"bad checksum"
-        with open(localpath, "wb") as f:
-            f.write(bad)
-        # Verify that the tarball is fetched again
-        fetcher.download()
-        badsum =3D hashlib.sha1(bad).hexdigest()
-        self.assertTrue(os.path.exists(localpath + "_bad-checksum_" + bads=
um))
-        self.assertTrue(os.path.exists(localpath))
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npmsw_premirrors(self):
-        # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
-        ud =3D fetcher.ud[fetcher.urls[0]]
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-        # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, "mirror")
-        bb.utils.mkdirhier(mirrordir)
-        os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(=
ud.localpath)))
-        self.d.setVar("PREMIRRORS", "https?$://.*/.* file://%s/" % mirrord=
ir)
-        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
-        # Fetch again
-        self.assertFalse(os.path.exists(ud.localpath))
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/array-flatten": {
-                    "version": "1.1.1",
-                    "resolved": "https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz",
-                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npmsw_mirrors(self):
-        # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(["npm://registry.npmjs.org;package=3Dar=
ray-flatten;version=3D1.1.1"], self.d)
-        ud =3D fetcher.ud[fetcher.urls[0]]
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-        # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, "mirror")
-        bb.utils.mkdirhier(mirrordir)
-        os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(=
ud.localpath)))
-        self.d.setVar("MIRRORS", "https?$://.*/.* file://%s/" % mirrordir)
-        # Fetch again with invalid url
-        self.assertFalse(os.path.exists(ud.localpath))
-        swfile =3D self.create_shrinkwrap_file({
-            "packages": {
-                "node_modules/array-flatten": {
-                    "version": "1.1.1",
-                    "resolved": "https://invalid",
-                    "integrity": "sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D"
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
-        swfile =3D self.create_shrinkwrap_file({
+        filename =3D self.create_shrinkwrap_file({
             "packages": {
                 "node_modules/array-flatten": {
                     "version": "1.1.1",
@@ -2964,10 +2806,43 @@ class NPMSWTest(FetcherTest):
                 }
             }
         })
-        fetcher =3D bb.fetch.Fetch(["npmsw://" + swfile], self.d)
+        fetcher =3D bb.fetch.Fetch([f"npmsw://{filename}"], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/arra=
y-flatten-1.1.1.tgz.done")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "npm2/con=
tent-type-1.0.4.tgz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "npm2/con=
tent-type-1.0.4.tgz.done")))
+
+    @skipIfNoNetwork()
+    def test_npmsw_git(self):
+        urls =3D [
+            "npmsw+git://github.com/karma-runner/karma.git;protocol=3Dhttp=
s;"
+            "rev=3D84f85e7016efc2266fa6b3465f494a3fa151c85c"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gith=
ub.com.karma-runner.karma.git")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/http=
-proxy-1.18.1.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/http=
-proxy-1.18.1.tgz.done")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git/p=
ackage.json")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git/n=
ode_modules/http-proxy")))
+
+    @skipIfNoNetwork()
+    def test_npmswhttps(self):
+        urls =3D [
+            "npmsw+https://github.com/karma-runner/karma/archive/refs/tags=
/v6.4.4.tar.gz;"
+            "striplevel=3D1;subdir=3Dkarma-6.4.4;"
+            "sha256sum=3D3cbd3b72da3b0b8aa650a90ac3a97aa5d0995ad2415989b9b=
8b59d09c460a6bc"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "v6.4.4.ta=
r.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "v6.4.4.ta=
r.gz.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/http=
-proxy-1.18.1.tgz")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "karma=
-6.4.4/package.json")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "karma=
-6.4.4/node_modules/http-proxy")))
=20
 class GitSharedTest(FetcherTest):
     def setUp(self):
--=20
2.39.5


