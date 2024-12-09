Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFF1E77173
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 10:32:31 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.108])
 by mx.groups.io with SMTP id smtpd.web11.98025.1733740340477353303
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 02:32:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=TiETe9hh;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.108, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgTiZhzdp5qQEU/rRYigf24aIFykl6405zYW6iZoD/nLdva65K3iZb1+EDWR3B5JdxoHlwA24lJ5xeXhLmDqzpG/NEj/5WRuLQtiSgLROlozKiF3MtsVO1kiybi3kUSLqPcrkkyYg5fq3NHkzvUj2pbRFOYQq7IGWEOkAPeAPiPTB/uCFmivgNnBxAozpRDYmrmJ0W7p7xMYqqVPuBt2zQYA5kpFHk+5WjLbyqogk6MivmkQNN+S3ixB/IFYFH0pXnEfiTHZbzHFeD3r07vCbAK4dhsOYcqRAUaXgSO8TUXIci22yiWohU53TEjfnLT72atL+CXloCybE8AbC1gM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjWhncvXsFib/Bit/zWrbYcrltn4jU9HphHweNL0oWo=;
 b=CWd1VzwJHRPx7VX5ZNjdEdpn1lJuUEnzHJy7VpKl09JqlBXEYos0ZT9F5h/GpLQlhw7PUXVZbqp46iC1CpKkVDCXdHImCNgMmTCqQ23vcszGKvswAMQz9Ixg7jdGBdT8wfoJY/z/QA4w7rWA7Oc/NiV7/dblDHMWJaDzK8+FZWw3DqjqfSwaACgMao9oYAjvEoHLmgc5/nAZ+c4mv/gC//0ynsCbKbrEzUvIXNFUWRdnWYpU17GlHWRjLIOYZnuWmiTUPooWEWOASTxm8sdzXDzJEixFW8YV1SiV+22IItuFS+9OmPuKCUcXbGXdL/e2cIsWBpH4NJJnsUUvM1ye9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjWhncvXsFib/Bit/zWrbYcrltn4jU9HphHweNL0oWo=;
 b=TiETe9hhISZ20nRxDpctGn60KOlyM+EAbQvHa3QkpdR8T+FPRX6nd++oTEgAjWbncmCiLHuVfCJprbJ7emrY8nc+cTQQHcV2v7iybErfQd7QFp7ymClgnfq7u9n9ZkwubCegLp5wfy/TqlbN7q77SWZ2KLWpNcTEUaJs1Zw4Q4Of25pMe3Lq9JzIS2EmVssOzgTH6WPtgSbLKGCfJTC0lKCvc9RfToJTsJxKHBzFUV+FzwYOjib5yKjW8cSloodAdHePLe1aJ6QaTIfFzpS19xZx1/l1NRUmLe9szMSSfVhyiBJiuKUnVvSZNXBmnD0Nc+zJYlvLkufRb/Sg4NegEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS2PR08MB8384.eurprd08.prod.outlook.com (2603:10a6:20b:55b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 10:32:17 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:32:17 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/4] tests: fetch: do not skip plain npmsw tests
Date: Mon,  9 Dec 2024 11:31:56 +0100
Message-ID: <20241209103158.20833-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS2PR08MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ca92b1-7ae2-4c2c-b6ad-08dd183cc0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?F3XuRpjU7mnxrdKG0VQ8eOw6f8outnMSItQTVXXyCCqm8nfZkSQjSnLgyRgO?=
 =?us-ascii?Q?oajeG6lROQwAfDU4SzEn7k9L5I5SsBr7dbOs6gpL0i48YdSUNUFUkHx1csaL?=
 =?us-ascii?Q?/zR7LU8eWMfeZFce0/N3OVta7jeAUnt25BNMKfJ0FBdgNCa8KkieRN/stJsq?=
 =?us-ascii?Q?1cswSFKpCAzfgx0GXolGXvUYkLqfdC9w5jqLpVBXudzpgbjpCL/fEys0sIhi?=
 =?us-ascii?Q?sSQp8w2rP40tDwTvDfngEXEJ9Cbt9U2+3AE8tBf7DfOXlHZmC0HD61JIdW+Z?=
 =?us-ascii?Q?NmhPi4NELga7+FsiBTzC6z4X4QIpagvlvHqDgrsqUZem4uDl6sfhvA3fK22c?=
 =?us-ascii?Q?pw8d9oq7/JJ9smDjU9lEThf8lh0Ji6ejJqM3jkPk//d1VelaUFZIWU21gnov?=
 =?us-ascii?Q?sD9v4DpWZrKlp3492YwXQBsWS08xLTU1wIwkBlTECKgf5R6HySt2k2m2wyJz?=
 =?us-ascii?Q?4rzkJn20s/QrgPJAnPXfOGcWteVLGaOTMxLxt0Ly4L+wPnrNSmhzf9JL4DLu?=
 =?us-ascii?Q?bU9wJ0KOoMgN49IHM41zkgYjFv5Xmd35yjNol2mGSN2JRzeJjP1f6P2oVGq3?=
 =?us-ascii?Q?Qtb4bpKdS9jmhDd6gkIb3bNf2Hxh0Ibua/DL0FJs2goyrMzsjiOvY4NnmBoF?=
 =?us-ascii?Q?9SG9BiIuYBOsaPf+Agetl60sGA6hg7QJPiv/CocXxVZG0sOswD92b5akrZxU?=
 =?us-ascii?Q?MurZUHOpKl3r/F71MtTe2rXdtXwT4i+hVndNAE+6yYE2yAabslGqA8HeyI28?=
 =?us-ascii?Q?DHoHGIg302YTiTPFCRHlnzZ0TxNVYVfh1CNrEeekBSgsnlFfED3RkSM/2rPK?=
 =?us-ascii?Q?1FsexjhbUbv3iGlYNoyAGUR+i+GfsN8EnblPKArI2m+cu4TcO24hCDUbkb/5?=
 =?us-ascii?Q?NxJVCxaCYmGSXEc2o2RobG2ZA4Y8Ef1wuwETdNe8ZC5qHq/HwHC1aS8wFhdG?=
 =?us-ascii?Q?r+/pYGkzTb6aMgmOjKXCnb1XdPaLP4pnZXcGAvL0xpG4KVtMjwoUU/WtyAY/?=
 =?us-ascii?Q?wmto7Tq6jfgluXF5v8XMyHdIuiFMU4+xVoK4woLsybv/frWpRbf4YGkt8qLi?=
 =?us-ascii?Q?se4VgDiRdgMmXwwjZ/N3E02IbLFWA5+BC/zqCyEqlSyffPbdgvFqWioDU/L9?=
 =?us-ascii?Q?7KKaIgQWMafQ0BHHPaSrUOlnRhW+GaEtSrY0YzHtDwrmtDamLkbbfP/4BNhz?=
 =?us-ascii?Q?HFLfDr6A+B4xeywfuM8Y4W186bAo8Vdqh536qgRU9ldBH+ynHOECECB0+zy/?=
 =?us-ascii?Q?7pSCOnmgLilKgF/0eqG6+MMX0dnZpgGECZy0qx5i67JblgGt9FowhsEZ4EuJ?=
 =?us-ascii?Q?TU8KzLUpxUfQQjDYV9LzIDdjKH3MID+KXoKPFO0jNSsXsZVensoQ4+Jkod9x?=
 =?us-ascii?Q?cm8ROPzHiwNh7qjnLeNV0tmoF88GC5LG1X8vBaWOxSo/Z0cq4A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zZMTjCzV/2/ddYuUrhIzrryoCUwlNyzAkpjV3aXoJBzFydbn3srplE1yAQMQ?=
 =?us-ascii?Q?SYgmLUkb8Nsqohi1YpBCYyb74tnN0I8Edsq5vJMWh68rPokHElDTa+PIyYDH?=
 =?us-ascii?Q?/UE3oqJ3aHjst4Jr4QkwbNbouE2a5smhNi0vc7/4VqEL0HCQ+aKfe9BiR01f?=
 =?us-ascii?Q?TP597pGjturHBDMLgY4jfh9GHVzQLyxqgc5cqc8uaAGargVSv6UoAUkpDHyQ?=
 =?us-ascii?Q?ozEJRHtAdDXGVTSmLN5TvOKtON//Ce1QeBW6xz3I9q341551e2d/azzCDS8o?=
 =?us-ascii?Q?d3z+WcnD6YTBus82l/V95o8roVRqs89e/OmFKgoMg7o99QwkGOaodpbS/EE2?=
 =?us-ascii?Q?m/xu/+WqJTvCh/HPrVduOcRDhNUCyQQyw502s9XfgcmrzqGkS6wHpaeSqMsz?=
 =?us-ascii?Q?Den2mb7HR7dq1CDTjAcHL/6QZBTt+hG51CUzRIl8iin/01VdJGeJfkk4B8s/?=
 =?us-ascii?Q?N2CWG+EuHsPKf8txNkOkV8chwrmiKjU19hW7iXEOkeQpwRltA3Bz648RqmIQ?=
 =?us-ascii?Q?bCGTV7iY/YLfqqm0qrqQU/pI1yy+lqKaKai/pe5P0xmVH/EhB2Y3WgGRAZEl?=
 =?us-ascii?Q?74r6sYfzzsvFwSvv5HvIzCsGgI8WxzY78fTgyFw6QtGc1r5hJTsSK8/vku5w?=
 =?us-ascii?Q?XaNliLe17dIksXXvGjhm6VG8Y7h8M8RjTmLjDPCv2a11M1sbLzOp9jaU9izL?=
 =?us-ascii?Q?cmUT+iefOPwgYNa79He5+dlpbKdqM3qhZZFZZZMpq/00ERtb3maMniuY1Wfr?=
 =?us-ascii?Q?tBUINt41WOuf0ebVzaFiDveev9XbrugqBkKVi0/zLukRwZ7NUsjelbs8hEEn?=
 =?us-ascii?Q?lEWrci2+yd3gkSPYlDV7pKUtu4eY4ea4N5opEZcS/FBVL9cfO/zKzSHeoEWC?=
 =?us-ascii?Q?PI4aCDL3FKgrdJ1fK2jPoIfzbavXxykNklYNyXgNOyYhDl2V443WijyHgNzt?=
 =?us-ascii?Q?7I4D2ggPdhjjF8XrC0KoHnGZbEjII1qF2NpSIln8n/FCE9J3+rkHv/7U+uJ8?=
 =?us-ascii?Q?T5eWl7KIPM/uO8TDcgdofxHjrZcwnqhTWjPm1GhYaSsFESQuW6lG2rvkNKFk?=
 =?us-ascii?Q?8n3oZDF1cs8fhdj5E+iRu6/2TleH4kqan5NuqPXR5YT2NKbDb5GTcBWGp8a7?=
 =?us-ascii?Q?FCrSHw/LvWpTltr5Gr4XO2VTjOQoTLc1Rh5UM8H0ozD9/anWVgdoeatkFpd2?=
 =?us-ascii?Q?yvmyECnI8PqXF4x4BMiij3MF6RnXJs4kEBvmSB0ScfjT4WhBOIGpVrqaBxg/?=
 =?us-ascii?Q?Kau10GgbKkF5oH/ldacL2HgIsDig9VUGM3UpJw51FI2058RsShflKhgS93G0?=
 =?us-ascii?Q?BnZrL7JHbPXZDjM4XoR8N4M6q5rCNG51IJfwYta+lHMAO+zCDLhZRfc2s+o+?=
 =?us-ascii?Q?ckw66Up+VLdu5NO7uamfaqJLwnjMWB5kGXom7h/Q9XXPgavpvT08ca1QlI7g?=
 =?us-ascii?Q?jidKZc8q9ZioB+8xeaIWjBAh/nN/3ShXnImj9glkDSEPJmnBSUsB/wG4D+gC?=
 =?us-ascii?Q?DSgI/xYhHv9d1Axxvbg9lT7kaVijS3j+jgm94QtPruqVboGVqlhKZ8qQSQ/p?=
 =?us-ascii?Q?CW2JcuLkQpY7o8k/PxYOCP/N8e4biB0NedLsSZyNB4JdgRwYxP/Kr59r/LUF?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ca92b1-7ae2-4c2c-b6ad-08dd183cc0d1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:32:16.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCwlCszKuhB4S0dbxmjEy4OxFEzQEWaPockAJYlZGJhPcWCfsdLAEL0FeIuHgwtqIz9HomF5elFUoSz/p/RpLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8384
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 10:32:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16894

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The npmsw fetcher doesn't use the npm command. Remove the
`@skipIfNoNpm()` decorator from plain npmsw tests which don't use the
npm fetcher.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 01ca80724..3eaaa8362 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2840,7 +2840,6 @@ class NPMTest(FetcherTest):
             json.dump(data, f)
         return swfile
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw(self):
         swfile =3D self.create_shrinkwrap_file({
@@ -2875,7 +2874,6 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'node_modules', 'content-type', 'package.json'))=
)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'node_modules', 'content-type', 'node_modules', =
'cookie', 'package.json')))
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_git(self):
         swfile =3D self.create_shrinkwrap_file({
@@ -2914,7 +2912,6 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
itlab.com.gitlab-examples.nodejs.git')))
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
         swfile =3D self.create_shrinkwrap_file({
@@ -2943,7 +2940,6 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'c=
ontent-type-1.0.4.tgz')))
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
         swfile =3D self.create_shrinkwrap_file({
@@ -2998,7 +2994,6 @@ class NPMTest(FetcherTest):
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'package.json')))
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_npm_reusability(self):
         # Fetch once with npmsw
@@ -3021,7 +3016,6 @@ class NPMTest(FetcherTest):
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm',=
 'package.json')))
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_bad_checksum(self):
         # Try to fetch with bad checksum
--=20
2.39.5


