Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B5C35FE3
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 06:29:37 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.64])
 by mx.groups.io with SMTP id smtpd.web11.15132.1726554573633000624
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Sep 2024 23:29:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=ieLq82gm;
 spf=pass (domain: axis.com, ip: 40.107.241.64, mailfrom: christian.lindeberg@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRPUEmUqVeQUYR5RX8BDuWolqoAIEc48ve/9bGtbcU//wK+sZjz//p6ud71CWSSlNOdSnqPjBw5G6ImvBj6DfXn8LkXqk21sNztXqT7fpYXt8iukNG2LhWU3Xws5KPENSJBIK3R9DmArEje1THDthsLfFl04p9O3/+r4UMHTcNvXNX3Eyx1JZqSjGnNh5gnsXV+ynhMqyL3C0cSDnBsnzkOO+LV+SctKMAWjOmRPg5BWy0/Fs0+k3VY2pqlAuxQ6o+72aD+M8EDvr91tqoMe1qAGFiOwhnHza6ZmAESQ6/oemd6x16+2M/sC2FaT4EzTJ7CVQlpG1Abh+JU23WPRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6kBp75khQGeWlIFzgYE7x/C3WYwZluNWV1zTp29eIo=;
 b=G8SHftiDkkXXGMeCxLHPKIKe96xQEtyCqIuI8OuRoxYo0gBqWex7TuEcElUCE31/pQ9qez2vlcnC/nr2S/vlvajDsV+x4N3LX5Toj2lTTLDEDM77UoKQCbkgp9tfgRN4Z7o0RdShw6OPTw6ZFmYI1hBjY8u0ENSYezoYlwr9aPXnqLc7lmGjW2tdEuK6IoJmfIcoRoA5ut+PJ6bK/PzI2eVs0aDdVDKU8mAs/Gvkiwm7EZj6yvzyZbaJ8raPRIwK+/v+mqVrTCDTipRTwTI+vuwRKMS+zrKsMlYtylz/wxoYT0NRi03D9XMCtx6C5rWssdRlSbhhBsi7le9i+FmENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6kBp75khQGeWlIFzgYE7x/C3WYwZluNWV1zTp29eIo=;
 b=ieLq82gmRB69qhTy3uqO2jQMhPRdDETotuCB03Iukjo9AV4dJoV1MbfgLh94nM6I/NC70+lcbnYA7Xn2ezsKoOrzCmvJLHxwZnpDERQkH3burJ0T4JMXkANz1fA8ps/4xwRdtWIq41pfeud8j8wadjsWSmy+806TtYNjdM56bcg=
Received: from DU2PR04CA0314.eurprd04.prod.outlook.com (2603:10a6:10:2b5::19)
 by PAXPR02MB7375.eurprd02.prod.outlook.com (2603:10a6:102:1bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 06:29:26 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::1f) by DU2PR04CA0314.outlook.office365.com
 (2603:10a6:10:2b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Tue, 17 Sep 2024 06:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 06:29:26 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Sep
 2024 08:29:25 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 17 Sep 2024 08:29:25 +0200
Received: from pc50740-2234.se.axis.com (pc50740-2234.se.axis.com [10.94.131.4])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id E3006106
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 08:29:25 +0200 (CEST)
Received: by pc50740-2234.se.axis.com (Postfix, from userid 21184)
	id DF5F926B985E; Tue, 17 Sep 2024 08:29:25 +0200 (CEST)
From: Christian Lindeberg <christli@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] tests/fetch: Update GoModTest and GoModGitTest
Date: Tue, 17 Sep 2024 08:29:25 +0200
Message-ID: <20240917062925.1033766-1-christli@axis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|PAXPR02MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ab2746-fffe-4082-fb15-08dcd6e213e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ScB7umKzh6tEJeNr6SDqA7MStcifNzbTJElqMNHvM46sM1If5djZDHQNaEIz?=
 =?us-ascii?Q?81MTotx2FqeuUxPnDCfaqSsAsAbA4v88/RjUTnE/E2Z77B0Cmzes7Z/oxG4e?=
 =?us-ascii?Q?lpfIOZmlb5iuk/6CE9QYozF07gSBUojjWPKOpWHaGWfFmcJpr9BJZcGOl77a?=
 =?us-ascii?Q?XHARWvJa9JXiSNVnMiTxUrdaQIXsg/PXVeSMYVJJCmzCRTCZcCC/ZdWwiHim?=
 =?us-ascii?Q?ryqmcA6zKFb/kj1h+xVUt5tT+AsPlyHMd7ImMWAquNxbTJbsVJZGvExy9kGG?=
 =?us-ascii?Q?4I4rBGP/1P/htdAo5M7ndWrhpnjiACfgTcpH6EAD2N63iVXV50qNVe4X6azw?=
 =?us-ascii?Q?fXkX7ko6bVtMx3F6iUBc7SxKpnXULUlxczyBJXknUNcKnz/CN03soU9zdI7m?=
 =?us-ascii?Q?GBt3FEOh549jDk7jOTnpoBZvxprDEi9UabaH4aXzsfjBJBPdd19r5QrdNh5Y?=
 =?us-ascii?Q?H81UmoUG9llFFBkfwaTl8UkOGD5J+gdIAzJtBG2WyJK0POKWb5SR6tF6NWzB?=
 =?us-ascii?Q?Ii7gDk9DmvQ8NWksn+m68qztutEMoatDugLXEfR+eFdKvCyj4WMIecOEuQJz?=
 =?us-ascii?Q?nePIesUheQWKnqSRfBGhMbZ3WPUBtFd8PRAphyWgMoypzI8E7aYhDV+3/NRs?=
 =?us-ascii?Q?Dgt9SlQaiGoTGTMmA62Se8dAG9S4QKPtDaDdJgj4e7sBKaM/2vweUPGEEdp3?=
 =?us-ascii?Q?7BIvdJBY4bYEB0aE+A62r5wIAwCjpvAntaw5pJh3D5tCY/BRZ+F7yoh0aKOi?=
 =?us-ascii?Q?UGfQOR/h/N4nTk/THjuHR05sh7JHDh6V8rc+QEWaxFdjiRGdsgOfuOW4gbbb?=
 =?us-ascii?Q?UJWDeJz8eD5FB/uYlbbinL0jLPfKA+icjBqszQ8WeoX3FUk5YZenWvycN7jr?=
 =?us-ascii?Q?lYl97hMC4xFiabEhV8meYYga3u7xfG+Rkxeu+CkqUXzmYWW33SVM86LYS2lT?=
 =?us-ascii?Q?Lk/DDX1CqKAg+TccZrLzKYdxBG+qR4U7qTSs/5BNDpLYA907r1d1TAm2MVgE?=
 =?us-ascii?Q?gcPvu5W4mYMpwt5REfv51Ip8UlcnyI97/x4A9eBuKYQ7ElGAzt4nshSWOpHM?=
 =?us-ascii?Q?kHejxRfEAVcn2U0RZbLaH1Sj+iKx7/9o2HdYRkFoyC1jocYiB79tFP7FcOd9?=
 =?us-ascii?Q?GCIjAxxfZL8+Mro5Lx4LpLRTQzVW3azREP+FnYHUrR7kdHFy9M7GjbVqr5G4?=
 =?us-ascii?Q?O2lfWJT9Xv9b83XrogYante9atyYAJx343fA/Ph6JDo8GyxYwxSX2+QApO2z?=
 =?us-ascii?Q?6h6irVaFIcHC+/ffjv/ADtZJUUT/W3hfFUukco9ZOr3wsGKwp4OH/K9Aq35o?=
 =?us-ascii?Q?JOLtmnj7092ttELKUf3G/n/29i5lbhirH3rEOsjGbedgDFiupG72AUFbrfHZ?=
 =?us-ascii?Q?VPsz4+cDVNg61VQwW36i66JD+ks7?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 06:29:26.3647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ab2746-fffe-4082-fb15-08dcd6e213e3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7375
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Sep 2024 06:29:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16563

From: Christian Lindeberg <christian.lindeberg@axis.com>

Add test cases for a module path consisting of only a hostname and add
checksum verification of the unpacked go.mod files.

Signed-off-by: Christian Lindeberg <christian.lindeberg@axis.com>
---
 lib/bb/tests/fetch.py | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 832e0dd6a..4e26e3881 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3408,6 +3408,8 @@ class GoModTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
ithub.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')),
+                         '7873b8544842329b4f385a3aa6cf82cc2bc8defb41a04fa5=
291c35fd5900e873')
=20
     @skipIfNoNetwork()
     def test_gomod_url_go_mod_only(self):
@@ -3439,6 +3441,8 @@ class GoModTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
opkg.in/ini.v1/@v/v1.67.0.mod')),
+                         '13aedd85db8e555104108e0e613bb7e4d1242af7f27c1542=
3dd9ab63b60b72a1')
=20
     @skipIfNoNetwork()
     def test_gomod_url_no_go_mod_in_module(self):
@@ -3455,6 +3459,26 @@ class GoModTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
opkg.in/ini.v1/@v/v1.67.0.mod')),
+                         '13aedd85db8e555104108e0e613bb7e4d1242af7f27c1542=
3dd9ab63b60b72a1')
+
+    @skipIfNoNetwork()
+    def test_gomod_url_host_only(self):
+        urls =3D ['gomod://go.opencensus.io;version=3Dv0.24.0;'
+                'sha256sum=3D203a767d7f8e7c1ebe5588220ad168d1e15b14ae70a63=
6de7ca9a4a88a7e0d0c']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.url, 'https://proxy.golang.org/go.opencensus.i=
o/%40v/v0.24.0.zip')
+        self.assertNotIn('name', ud.parm)
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.openc=
ensus.io/@v/v0.24.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.openc=
ensus.io/@v/v0.24.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
o.opencensus.io/@v/v0.24.0.mod')),
+                         '0dc9ccc660ad21cebaffd548f2cc6efa27891c68b4fbc1f8=
a3893b00f1acec96')
=20
 class GoModGitTest(FetcherTest):
=20
@@ -3480,6 +3504,8 @@ class GoModGitTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'golang.o=
rg/x/net/@v/v0.9.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'golang.o=
rg/x/net/@v/v0.9.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
olang.org/x/net/@v/v0.9.0.mod')),
+                         'c5d6851ede50ec1c001afb763040194b68961bf06997e260=
5e8bf06dcd2aeb2e')
=20
     @skipIfNoNetwork()
     def test_gomodgit_url_subdir(self):
@@ -3504,6 +3530,8 @@ class GoModGitTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'github.c=
om/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
ithub.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.mod')),
+                         '7873b8544842329b4f385a3aa6cf82cc2bc8defb41a04fa5=
291c35fd5900e873')
=20
     @skipIfNoNetwork()
     def test_gomodgit_url_srcrev_var(self):
@@ -3524,6 +3552,8 @@ class GoModGitTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
opkg.in/ini.v1/@v/v1.67.0.mod')),
+                         '13aedd85db8e555104108e0e613bb7e4d1242af7f27c1542=
3dd9ab63b60b72a1')
=20
     @skipIfNoNetwork()
     def test_gomodgit_url_no_go_mod_in_module(self):
@@ -3544,3 +3574,28 @@ class GoModGitTest(FetcherTest):
         downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'gopkg.in=
/ini.v1/@v/v1.67.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
opkg.in/ini.v1/@v/v1.67.0.mod')),
+                         '13aedd85db8e555104108e0e613bb7e4d1242af7f27c1542=
3dd9ab63b60b72a1')
+
+    @skipIfNoNetwork()
+    def test_gomodgit_url_host_only(self):
+        urls =3D ['gomodgit://go.opencensus.io;version=3Dv0.24.0;'
+                'repo=3Dgithub.com/census-instrumentation/opencensus-go;'
+                'srcrev=3Db1a01ee95db0e690d91d7193d037447816fae4c5']
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.host, 'github.com')
+        self.assertEqual(ud.path, '/census-instrumentation/opencensus-go')
+        self.assertEqual(ud.names, ['go.opencensus.io@v0.24.0'])
+        self.assertEqual(self.d.getVar('SRCREV_go.opencensus.io@v0.24.0'),=
 'b1a01ee95db0e690d91d7193d037447816fae4c5')
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        vcsdir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'aae3ac7b2122e=
d3345654e6327855e9682f4a5350d63e93dbcfc51c4419df0e1')))
+        downloaddir =3D os.path.join(self.unpackdir, 'pkg/mod/cache/downlo=
ad')
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.openc=
ensus.io/@v/v0.24.0.zip')))
+        self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.openc=
ensus.io/@v/v0.24.0.mod')))
+        self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
o.opencensus.io/@v/v0.24.0.mod')),
+                         '0dc9ccc660ad21cebaffd548f2cc6efa27891c68b4fbc1f8=
a3893b00f1acec96')
--=20
2.39.2


