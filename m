Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C2C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 15:51:10 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.23])
 by mx.groups.io with SMTP id smtpd.web11.24156.1739548268282327099
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 07:51:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kKt0IjAu;
 spf=pass (domain: siemens.com, ip: 52.101.70.23, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvpE90aG+dKd8zHhUF+6UhaHuB7WFK0TmoEkX1GGxrUAIIEFATC0vcDl+xrH1wMys7n6KKaaIgyb7nSgHcRoV0b1kADFCWQOn0jfoK6lVbRCsRJ15oeBGnldXoCjrGkG882kjrkwRhOINYEGmc+SssajUHhrB8i1N/PB3KectN7X1ArotC6T1uHvzrgz/MawhFqzk1m0B6C2sBfB8YZ//a0N8UPrN+KD2f9JcBLA5DKi/+K+gghuKDhcFwfRD8NyQvKW8kw5moZ6NIOFOy2E9Xr7oDXcGub+WFSNtTMFQ5w5/ibKFANdlic/4e+yhSWnR+FPwLs6lG00aUeD9yFUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiyXOuX20uy+LH207lz6VlG7K2RapUL0oeXFrYdf9AM=;
 b=UD+HcD2spSZO3l2UfpPjPtjgtkMP8BNBCfaectS3qfVXH+QJe9/wdo4BmW7yfVWIxTVNkqN3dR4xF+u/WRRQz5VsuHCyrPZXydQA6vXWmdEqOlJ5AahQUT4addlsMySI+i3MuoRKzlAth/UNmGhzfxdgFvZyzJ/2X7V2PDOm6oCXk7x8KTNHJi18vIeugi4yA6qLc7oATSOW5SbEgjoLCd+pHGT5f6a5wUWwbOUnjEw8yPVrsFqgP7HlLRum2cstKcvUyNUXujduqgLRHVr4luJqkhyQj734hur1MtuwhBPwcErna9WUAHW/tbSLtKdI3dTs2qbKjITBdrPXZWAIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiyXOuX20uy+LH207lz6VlG7K2RapUL0oeXFrYdf9AM=;
 b=kKt0IjAuZUCsMU5tRhuhAV1rrgfjqbkvTlb+nW8oeYmGCNL/WrAmiljcyQuPYPlLa6WC5fQ+8/ybAs19bX4mbJNUeXM4nDB0F3s1us+qc1gmwYkIk4J1+rNO3oR6t7I/DzCc+9LgDwXoDiGPgngZEBXL1LD7Bv5OZXSUjk/bM++WviFIIeD42eYpO3gwreIirG8k8D4r/YopTE/BPeidaJTSCk/ST3ltH7jIh2/tbqmryVk5S1DtwakNUbFcJyoYNziM9S8zw0o7Y7Zde2BtHR4rO23GBmqXKnpxaGK3z8ajt3jdOfmjpMj8g01QWX9TS+YAp2llv+tDWqVAF6+uSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM8PR10MB4081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.5; Fri, 14 Feb
 2025 15:51:03 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.009; Fri, 14 Feb 2025
 15:51:03 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com
Subject: [PATCH v2 3/4] tests/fetch: Separate test classes for default shallow and fast shallow modes
Date: Fri, 14 Feb 2025 16:50:56 +0100
Message-ID: <20250214155057.1748020-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214155057.1748020-1-stefan-koch@siemens.com>
References: <20250214155057.1748020-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|AM8PR10MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df7f69f-5ac3-42fe-82b0-08dd4d0f62bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nK4V+vxPly9LEKUSzfwOguCIagQ6WwbX6aeTYTsYJhHt15Nt8cvWriYHYEQg?=
 =?us-ascii?Q?feAV/WadNp+qI98xdsvnewojBZ0/+/C6nth6ROkV6+teFDdomV+nagTw/xyy?=
 =?us-ascii?Q?yqGT5dMeRjpGrUD1xVAgrUh73z1mrdUzaXbOMw9v82B/jtMK8WEE1F+3qRul?=
 =?us-ascii?Q?hhwoKIhxyGg6z2lrJ7glTXrViEk1m/1WStNjfLw96IZMBlKnILY23bHwQbw0?=
 =?us-ascii?Q?UABU22f7HMom2P08/iXbykdV9+HLthd4pgbFaUN5dTUB/O9HhbGlpYwDLdNk?=
 =?us-ascii?Q?kBzAtYF4+uSnKroVn3IvPIUi9k/oUg6av+JC02nAqoUcI1eVlvlwr+9B0gY1?=
 =?us-ascii?Q?xQ7cN1JOZNM5XE+c5fxGGB1lAOEbDqMrTUx6zxjOwCQSqVfN4a6GqE48iyOC?=
 =?us-ascii?Q?Tohxy3h9ZhjDBozpsXUuMsDYsLU7tQyqpiLP5iy6CGL0HMGmdX2n0ilvW+24?=
 =?us-ascii?Q?HejGLvlIXn4TpvHiwsZmtqqu1o3Z3h6NB23zxicEyll9RnAKLAbu7rV75WPt?=
 =?us-ascii?Q?Jl0YaNyekUw2WzwBSLM1VY+2eRoJtWOegq/QlObqclAeyLdpnlwKdVTjjHhp?=
 =?us-ascii?Q?Srnt3a2+B0GDf1U+ZWDm9oB4CeTPRqz7C0YIVpxC71oDrmom9tHTOJPA1Hwo?=
 =?us-ascii?Q?vaIKNiV5jLOb+IUZ0q986jDrQPU26g1AeV9iQki6XV2k9cavKMeJHTtnqwqt?=
 =?us-ascii?Q?fW997tS7+gIXZnIVUVsYFuFrWBVfq+CGEeaz9nMTd9JRGgynxvfPDPsE2B7+?=
 =?us-ascii?Q?/m8uyy0qu4KDO49s/G+aZSb602EgqtBo+hInxBIxhO11jdyVhdxZ+6ruuMw2?=
 =?us-ascii?Q?Rz8puqJ4CUinj2arZRqPIzCn3F0EPzR7ChkLzTDDLRDp8rhkwcA0vMavbGk9?=
 =?us-ascii?Q?3Shu+25FkOKdUpn6zGZ4oUF0Z6IKkIi6qQizdewc9Xfc+wcuBFmrHZaUdjNa?=
 =?us-ascii?Q?t71/PxslPn8qCiK0WSmZxg/cTZkikIagBAggTWme9BR344r8Qkgnnc5D4HK7?=
 =?us-ascii?Q?pJHF3qk4igztrCY4tWpIpy5m7YvDIGmt/He8YvWnbN7vXM4nG3lkY9kRT37Z?=
 =?us-ascii?Q?oCWAtqXY3qm4qKAEsdEyo8zXr/u3kt+2KUCCdeRExRDR9gqMx0lpCQLjC/qZ?=
 =?us-ascii?Q?mTLHgBnNmEKwYi/LgUl5M3Hs+OgKD0+4C9h3TU5smEdFsFBx+ATimTy41m36?=
 =?us-ascii?Q?5cM899NNj/j4hWa+ePKRgwi7/DrlNmSNUk6V3eoSfhsDCV6DoVKY2yNj03fa?=
 =?us-ascii?Q?h47l5bueMt7nVtANSL/W3SabT7dvc/Qso1+sk2Cglo5F00ciNM49N95FjgoQ?=
 =?us-ascii?Q?i87HpWR+j52rYzsUXtx4xC4DkFilu5O8rWTexKoMQgEgN57d5ABD0xgR75bI?=
 =?us-ascii?Q?NkbwmpEdcQIPNTQPIsUpV8m+XGzI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?D+GJlfkYmt+14kqhewEIhFTpoxdexzFEOZZyn0J1TUk27jpIIIVZO4cUfLqz?=
 =?us-ascii?Q?a29jWJZLY87WwGxBJfaqpi6bBcwQeuFNdtYP2b2bjMzpSw/PyAifPuZKGAoH?=
 =?us-ascii?Q?apE7FymVBdljncCL0V29rDNrkGLE59g24BUsdOVfo5PihdMuHi2jabgJz4DB?=
 =?us-ascii?Q?YOlWmyfs4Rm8t3hhKcw3ES+IsNXCjMkC7Zqtg8QwQZjBf6/l5iYIRj6XiZr9?=
 =?us-ascii?Q?r8YIJkzdcoggFC461LxM2hJx4Aw/edjaowdBTN3o+Wt+edtDu8oC8ojnjL5m?=
 =?us-ascii?Q?y88ZoiZ6sos7AhqXOgqD8U7jU7DPuncmlE5ywkcG9gYZ3zEFXDNBRkacbNk2?=
 =?us-ascii?Q?Ii7dRsBPo/vBjJYOhrJZEaAWH45yyVzryo1glJHeWhZOAIoEpVwGssUOPLPv?=
 =?us-ascii?Q?vi3V7CSceaBSXTMNa5OeruVeBW5yfRqfvnHTujeOFU/w1+qs6FbL/fPunWfF?=
 =?us-ascii?Q?EK/SeCdHRnMu7y1tL1bn1My8Emzp83DgSkEHAmCvTGK+SYsHA58HqgPClwgo?=
 =?us-ascii?Q?461CLbzfDdEh2EJ4ZzawTgUeo7liV/KAYceo7Pea9gYERznBkDS7doe6o6nX?=
 =?us-ascii?Q?d454S1m03Pp1xPMont7Kk+AgYJBCPuafybNkyAdbfqv2/sPRsnmF5sJXHu+l?=
 =?us-ascii?Q?5D/YmN8vTa5mq1FqVZqBir7vsvSTgT8QWP8EN0CmPbWE6KipLfcpbFD7b3sh?=
 =?us-ascii?Q?weD3y1tqaXdgXHzAKRljfvCrdMfZh7CvpH1E/qKXKK3SKFfmYbcTHFHW//J+?=
 =?us-ascii?Q?BzmJmC10/ByYthC62Gos3p57Q+EmZaJXTHWNWjGl63tgx7G9DDgRXpgKVUbs?=
 =?us-ascii?Q?9isqmX6Vn3gz+e3hLrdOQqgXXdzO67CB4jbM+ITb0MSrLA02qb9LqgczypJT?=
 =?us-ascii?Q?1ZbNzSp2PTXuvqRmVr2UNF68PEjYDrOoahoiATovz9Tu8EXm3jc5nX/LSw9d?=
 =?us-ascii?Q?0rOm1mBBzl12DFaUMO9gZA6fftMLdQh+itt0VE5mh6syL51yzvKLxUVyjJEg?=
 =?us-ascii?Q?yAJe23Qu+ZVWVuum0E0irxxlEM/oifdrvjB/nV8WXtFQsi1kpF9lKGfQS1G0?=
 =?us-ascii?Q?/OWGGFLPFlKiXhB7wz/R8O05LGM3eG8knl1/QJB+B/xpqOkxtTTgNdtPGKfT?=
 =?us-ascii?Q?fxabh+2LTjYUdCR7yiy/oh+g1uNhx1bNAnkFByg6DakrZmCzyc2nIU2k42Ix?=
 =?us-ascii?Q?GB0MqoyBTFpkC7in10HwN7+PtIjDjlDtSdRxXYE4SJdp5UXHHi0UWRXR0Yhu?=
 =?us-ascii?Q?U5qPCZhF8n5DRMR3HXBw/FFcqbZW7eHA7PnzAvvF8yRBh59EUUSffFSEsw8y?=
 =?us-ascii?Q?qczrszEjwGEJS2jiL22BnZ/dTheCz8Twg1qvE26qsL8X3VX2L3sDHrpQbmtP?=
 =?us-ascii?Q?x8nqE8ubM8VqTMk3viD+VhRNGulYq7Z9LXCj7qB26Lm7gLmGRsXa8+OcXeWm?=
 =?us-ascii?Q?wJQkMLsP0OJlOoirP4Z3JjCeaPF9ZcgYleav1Snr9kTADuBbokjBcy7fMO8h?=
 =?us-ascii?Q?mvZ2qs4g+wCZ7oe4/ghUrcL7w5HOucrKyQn9RE4x6pYzsUHHVA+kwUo7/fWR?=
 =?us-ascii?Q?1DBUeeaEvQeQ60pf+3kGvAO67i+KzuM6m7OEIyFR8upXsoSFKIdg1Ld2WALe?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df7f69f-5ac3-42fe-82b0-08dd4d0f62bd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:51:03.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXC5O8HfQoUms6J/TYUT8IBdYeFftsiGXLOIv+3KG6VqbP4ayg+NbyQOvCg/EHKsEHd2rtNUFEWMoBNlsfXF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4081
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 15:51:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17224

- The class GitShallowTest contains all test cases used with `ud.shallow_fa=
st =3D=3D 0` (disabled)
- The class GitShallowFastTest contains all test cases used with `ud.shallo=
w_fast =3D=3D 1` (enabled)
- The base class GitShallowBaseTest contains all test cases that are used w=
ith both default shallow and fast shallow modes

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 119 ++++++++++++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 39 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 48b9e4af1..2891cf9e5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1739,9 +1739,15 @@ class GitMakeShallowTest(FetcherTest):
         self.make_shallow(['refs/tags/1.10.0'])
         self.assertRevCount(orig_revs - 1746, ['--all'])
=20
-class GitShallowTest(FetcherTest):
+class GitShallowBaseTest():
+    """
+    Test cases for use with default shallow and fast shallow modes.
+    Test cases must succeed with `ud.shallow_fast` set to either `0` (disa=
bled) or `1` (enabled).
+    The class GitShallowTest contains all test cases used with `ud.shallow=
_fast =3D=3D 0` (disabled).
+    The class GitShallowFastTest contains all test cases used with `ud.sha=
llow_fast =3D=3D 1` (enabled).
+    """
+
     def setUp(self):
-        FetcherTest.setUp(self)
         self.gitdir =3D os.path.join(self.tempdir, 'git')
         self.srcdir =3D os.path.join(self.tempdir, 'gitsource')
=20
@@ -1814,7 +1820,8 @@ class GitShallowTest(FetcherTest):
     def fetch_shallow(self, uri=3DNone, disabled=3DFalse, keepclone=3DFals=
e):
         """Fetch a uri, generating a shallow tarball, then unpack using it=
"""
         fetcher, ud =3D self.fetch_and_unpack(uri)
-        assert os.path.exists(ud.clonedir), 'Git clone in DLDIR (%s) does =
not exist for uri %s' % (ud.clonedir, uri)
+        if not ud.shallow_fast:
+            assert os.path.exists(ud.clonedir), 'Git clone in DLDIR (%s) d=
oes not exist for uri %s' % (ud.clonedir, uri)
=20
         # Confirm that the unpacked repo is unshallow
         if not disabled:
@@ -1822,9 +1829,10 @@ class GitShallowTest(FetcherTest):
=20
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=3DTrue)
-        bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
-        bb.utils.remove(ud.clonedir, recurse=3DTrue)
-        bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), =
recurse=3DTrue)
+        if not ud.shallow_fast:
+            bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
+            bb.utils.remove(ud.clonedir, recurse=3DTrue)
+            bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule=
'), recurse=3DTrue)
=20
         # confirm that the unpacked repo is used when no git clone or git
         # mirror tarball is available
@@ -1841,6 +1849,7 @@ class GitShallowTest(FetcherTest):
         self.assertRevCount(2, cwd=3Dself.srcdir)
=20
         self.d.setVar('BB_GIT_SHALLOW', '0')
+        self.d.setVar('BB_GIT_SHALLOW_FAST', '0')
         self.fetch_shallow(disabled=3DTrue)
         self.assertRevCount(2)
=20
@@ -1900,26 +1909,6 @@ class GitShallowTest(FetcherTest):
         self.fetch_shallow()
         self.assertRevCount(2)
=20
-    def test_current_shallow_out_of_date_clone(self):
-        # Create initial git repo
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        self.add_empty_file('c')
-        self.assertRevCount(3, cwd=3Dself.srcdir)
-
-        # Clone and generate mirror tarball
-        fetcher, ud =3D self.fetch()
-
-        # Ensure we have a current mirror tarball, but an out of date clon=
e
-        self.git('update-ref refs/heads/master refs/heads/master~1', cwd=
=3Dud.clonedir)
-        self.assertRevCount(2, cwd=3Dud.clonedir)
-
-        # Fetch and unpack, from the current tarball, not the out of date =
clone
-        bb.utils.remove(self.gitdir, recurse=3DTrue)
-        fetcher, ud =3D self.fetch()
-        fetcher.unpack(self.d.getVar('WORKDIR'))
-        self.assertRevCount(1)
-
     def test_shallow_single_branch_no_merge(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
@@ -2111,16 +2100,20 @@ class GitShallowTest(FetcherTest):
         self.assertRevCount(4, ['--all'])
         self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
=20
-    def test_shallow_clone_preferred_over_shallow(self):
+    def test_shallow_clone_preferred_over_shallow(self, fast):
         self.add_empty_file('a')
         self.add_empty_file('b')
=20
         # Fetch once to generate the shallow tarball
+        if fast:
+            self.d.setVar('BB_GIT_SHALLOW_FAST', '0')
         fetcher, ud =3D self.fetch()
         assert os.path.exists(os.path.join(self.dldir, ud.mirrortarballs[0=
]))
=20
         # Fetch and unpack with both the clonedir and shallow tarball avai=
lable
         bb.utils.remove(self.gitdir, recurse=3DTrue)
+        if fast:
+            self.d.setVar('BB_GIT_SHALLOW_FAST', '1')
         fetcher, ud =3D self.fetch_and_unpack()
=20
         # The unpacked tree should *not* be shallow
@@ -2240,18 +2233,6 @@ class GitShallowTest(FetcherTest):
         with self.assertRaises(bb.fetch2.FetchError):
             self.fetch()
=20
-    def test_shallow_fetch_missing_revs(self):
-        self.add_empty_file('a')
-        self.add_empty_file('b')
-        fetcher, ud =3D self.fetch(self.d.getVar('SRC_URI'))
-        self.git('tag v0.0 master', cwd=3Dself.srcdir)
-        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
-        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
-
-        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs("Bit=
Bake.Fetcher", level=3D"ERROR") as cm:
-            self.fetch_shallow()
-        self.assertIn("fatal: no commits selected for shallow requests", c=
m.output[0])
-
     def test_shallow_fetch_missing_revs_fails(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
@@ -2295,6 +2276,51 @@ class GitShallowTest(FetcherTest):
         self.assertIn("No up to date source found", context.exception.msg)
         self.assertIn("clone directory not available or not up to date", c=
ontext.exception.msg)
=20
+class GitShallowTest(GitShallowBaseTest, FetcherTest):
+    """
+    Test cases for use with default shallow mode.
+    The class contains all test cases used with disabled `ud.shallow_fast =
=3D=3D 0` only.
+    """
+
+    def setUp(self):
+        FetcherTest.setUp(self)
+        GitShallowBaseTest.setUp(self)
+
+    def test_shallow_clone_preferred_over_shallow(self):
+        super().test_shallow_clone_preferred_over_shallow(fast=3DFalse)
+
+    def test_current_shallow_out_of_date_clone(self):
+        # Create initial git repo
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.add_empty_file('c')
+        self.assertRevCount(3, cwd=3Dself.srcdir)
+
+        # Clone and generate mirror tarball
+        fetcher, ud =3D self.fetch()
+
+        # Ensure we have a current mirror tarball, but an out of date clon=
e
+        self.git('update-ref refs/heads/master refs/heads/master~1', cwd=
=3Dud.clonedir)
+        self.assertRevCount(2, cwd=3Dud.clonedir)
+
+        # Fetch and unpack, from the current tarball, not the out of date =
clone
+        bb.utils.remove(self.gitdir, recurse=3DTrue)
+        fetcher, ud =3D self.fetch()
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+        self.assertRevCount(1)
+
+    def test_shallow_fetch_missing_revs(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        fetcher, ud =3D self.fetch(self.d.getVar('SRC_URI'))
+        self.git('tag v0.0 master', cwd=3Dself.srcdir)
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+
+        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs("Bit=
Bake.Fetcher", level=3D"ERROR") as cm:
+            self.fetch_shallow()
+        self.assertIn("fatal: no commits selected for shallow requests", c=
m.output[0])
+
     @skipIfNoNetwork()
     def test_that_unpack_does_work_when_using_git_shallow_tarball_but_tarb=
all_is_not_available(self):
         self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0'=
)
@@ -2309,6 +2335,21 @@ class GitShallowTest(FetcherTest):
         dir =3D os.listdir(self.unpackdir + "/git/")
         self.assertIn("fstests.doap", dir)
=20
+class GitShallowFastTest(GitShallowBaseTest, FetcherTest):
+    """
+    Test cases for use with fast shallow mode.
+    Test cases must succeed with `ud.shallow_fast` set to either `0` (disa=
bled) or `1` (enabled).
+    The class contains all test cases used with `ud.shallow_fast =3D=3D 1`=
 (enabled) only.
+    """
+
+    def setUp(self):
+        FetcherTest.setUp(self)
+        GitShallowBaseTest.setUp(self)
+        self.d.setVar('BB_GIT_SHALLOW_FAST', '1')
+
+    def test_shallow_clone_preferred_over_shallow(self):
+        super().test_shallow_clone_preferred_over_shallow(fast=3DTrue)
+
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
         import shutil
--=20
2.39.5


