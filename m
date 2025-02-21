Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DADC021B6
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:26:15 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web10.29015.1740158771028340956
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:26:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=EAAvSKHz;
 spf=pass (domain: siemens.com, ip: 40.107.22.71, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYzberVLvnyWe81aCQ4K3mJYcWCctip7imnQyOaFvJdbtySnNOI2Pa1hSYTB8EOZEgC7LM2Vwpu2dZCyzKrM4n1CDKUfUWabSuoxHdgOlEPiiVM8dsxV/P3s62vKw849fi6dSUGTiCbcoBFAF3mj6pZ4A7/qchIfyAXeOfUPGwTCpyiJBQo9ODSoPTK7/4GjgA/3dKQPLCn7EN90QDGznly6/2N6tfLKVMHEoloPnOtWkaSjCOItmrJVaUqoMlzXpy3Lii1MB8HZCJ26Kw+GvumKpaRafmxylrIJhXmOKIcia0WQisaVEy4hDyMFTOT9MrJT2MF3YynGfMi6uSlxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ1xQNI7+4lQGUeKabrkZnRlyiuO6amkDVfvyn0PtSs=;
 b=JtQXE+o+B/teuED8W7GrXmlKuTR/pGI1NO+FvAlxc0p3m2ARL0XpUImcypXUi+8p8vg0nxwlxI5EH9dPYe291ogDjuEnCjYqw/6gS5p+jNriPQnR5CQmyah2OjJ/zYOhS2btFkaB6QgAk8DHqu7auU7YNrWMlGXLXRaXtOG2FKnq5hgt1BBTLpUyVeD0r7vxFHTxphFHAleta2jtf3dKWc1f2MRrOoYhnNmttx38PSAp+H5gd0fgGh7aPw9T+1SuHmnFXvp/smuhxVaAEI7oSJwH7UHZ9StgDOLUB/xQ9bwd1HRAJsO1I9e8uZpO0s2jB/5alzk2FNL9y/C5J/6E6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ1xQNI7+4lQGUeKabrkZnRlyiuO6amkDVfvyn0PtSs=;
 b=EAAvSKHz11veaXvNFbU72i/vVAvnwCMYmCVYRLlL3dxdNZX871JITxJ8YCjiZktWaCAunuQe0D7bZllByL9BmAgHw9nMTensQBJQaf3YJF3gTN3QVifm+34GJaHf+RUQkNvNnOAOqrg48JyCHMVTv2hyHTRtwYJD0oLDoFqHXcyJy/QocMIMV707GPSIen8FwYmv1Hqm/dHSLpB7A56ckBRv5F3rCTcbHxdtbB1lKZtsbRgKwLJjUF9tSg0VDJ9Jj/FsPZmaiNQqD28xhPCJ8YFBK+zXX0jS4HVfkyqa62NpmXrGqI2LQfD/zDDO0PYOralJQUPgEs73kZQBzh5ZQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DU4PR10MB8514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:26:06 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:26:06 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	quentin.schulz@cherry.de
Subject: [PATCH v4 3/4] tests/fetch: Separate test classes for default fast shallow and skipped fast shallow modes
Date: Fri, 21 Feb 2025 18:26:01 +0100
Message-ID: <20250221172602.527924-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221172602.527924-1-stefan-koch@siemens.com>
References: <20250221172602.527924-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DU4PR10MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b07f482-74d2-4016-ccab-08dd529cd30b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1LeKjg0VhlF0ECOOJ9yUle3O8qMZ1Tp8N44KaKoIVtilo7PPfqEMAeD2jf+A?=
 =?us-ascii?Q?Jqcknw7aRg1UELLqhKX7nMVaddRpb/X3vOGn8+FHNecDv/y0UvHZd7fw8VpH?=
 =?us-ascii?Q?GCg3HyEpvyMXdA8wnF1MBViD/zqrKQ0jhGRuJGoV5gCJrtUHwYylLGPvvuhf?=
 =?us-ascii?Q?FogElRVBuzGEnRdLJzlZ+coWrsD89KFBuUwfw5Mk8GYXzv7ehBXZ5ML2IrO5?=
 =?us-ascii?Q?IETRj0hQSlOqf+fmXZtTMqJ2sAtYWyph+CkK3sJj60Gm1BKGJ97soS6hQLEQ?=
 =?us-ascii?Q?oX/Y3e4QN+DS84C5cCDzXrtqYrv/VUPkXNKoohTh6J0OOEsW4iDcJk8NCL4r?=
 =?us-ascii?Q?Q/85YIlNi5s5G5d7cmNZE5iSTvsApflQTnU4rdqIJBUCOjB5p7HQIYZrH+lF?=
 =?us-ascii?Q?Pn3mpVEQLBUsxf6WyMG13c+5jcf84U28Ezm6g0oofIU78PQF+p/XIlpp61lD?=
 =?us-ascii?Q?UJBTznb7kiueb2YjB/V3QPaW+Z4epL6hZQWp2bOmZqnInxYv3YQnZnRNTjnz?=
 =?us-ascii?Q?vozukdT+VpPsnBpkAeWQHjnAuHfYit/5j4gXYtmQ/uyh9FsMMPYs6e+iImxw?=
 =?us-ascii?Q?PJXPQt+YZ4zhyjmhhAvDkVtcaD3xIQBjl6qfDJgXy229sfXDOYyOf5KSQD7X?=
 =?us-ascii?Q?jX0cWMEMelfxua+jDweS9qrRvqqOy6D9Qzk/C6vsZyU38gP9Hn+O/CRVGGMV?=
 =?us-ascii?Q?hvPPhxCk5GZf3WFG3Oi6k8MCOC0cx3SEGj7g0NfLkITyfeZ2EeS1JAxHXXUe?=
 =?us-ascii?Q?srEffxHasnyDVFhro/4uCr/TIhajQmHFXg0JzEDs0rvCOsWklPbkNEYgXY1G?=
 =?us-ascii?Q?3uBGnXp7zLVkyO6nmcSEUpoh3qVq2z4gIGrT98jWTPgIyKv7hjRXf/kzIeo7?=
 =?us-ascii?Q?nCzJcWJ2acV9uuj4WiDi30oKEBN2ZsHNVaghZ9bfXqyQ0qqzh6Hl6czoBv0d?=
 =?us-ascii?Q?HCNEWqfU2rk4zBYZDvC8rA9w0Qx5aIiiVm/oA6U2e7YH7vXCrqGXyDEPPgVJ?=
 =?us-ascii?Q?xxTpkEl93iaNJDxc4ep/i6jukezWD6nXXuIzJtNcc5DyubDmWr6MotbKGEMw?=
 =?us-ascii?Q?2c9HOtClR8JBsZQZY/p0GaiinQf7vHS8E4lfL1wSRJqHBHXWUSDtXcDljSSD?=
 =?us-ascii?Q?I7C7Ch+Y4f1FlRIlBHmPRQn6FkoykY+ZXzBMPdY8YOi0elBz0Sl2KQAGTFv5?=
 =?us-ascii?Q?RuWm6wUN0+ih2yiae+5tExMGqNmYG2qDH8PJAYCOkCwoRnPCzjX3bIuNX5Lo?=
 =?us-ascii?Q?OX5a9E8cNmlpdLVzW0E/eW+TFAuDEAoteL+ZqYxcaCBHuQPl3hqUdGMQjxrU?=
 =?us-ascii?Q?y+uK2XdeymR5HlMOPkcuGlTUBWFm/ge2TKTazCrv8rDWJ0+LCqM+TaDcXgLt?=
 =?us-ascii?Q?B3woqIfcLuJ2DWpgOJn85zk5j6lV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/N2C+yNmSSl7gi4O+J2C1jRH/a3VwI4R3smNVqluUdkGTAbeRjDrLpKuNESc?=
 =?us-ascii?Q?3z2UhpBYk9VpNn+vQzq0TgYFCWdsb8KuXV8O3Ox5lsptIWtbtFRUES1SwBFM?=
 =?us-ascii?Q?qnePv1W8MAyh9UiW7vVeU+jB89fNflvMNB+s3B5p3doiKe9IxzOF+Zt1ano4?=
 =?us-ascii?Q?v4RW5sg9EMyaH91hJ9iPRPwl/sUpOTrOja90AOKmiD0uzTLjVNsXxuPAdXpo?=
 =?us-ascii?Q?lvClsBjjTBU+znJKFbnbw7faLUz92W7yM2NLT+u3fXSi7wlXGiZVf7O7sAA3?=
 =?us-ascii?Q?NgNKai4gYTML0L7LPa2gSrrDsWa+eoJUNLbc+YwRnuaafnXg8dhrGus77K4y?=
 =?us-ascii?Q?2eJ35auVp5SIMKnJZfSBM14S2TvDjHonos/sIdCH4+NaGgIghDn97cEzBwB9?=
 =?us-ascii?Q?SU0iALJQ6yO4Y3X0FLJ1he9IB40P/yFN5Dn6O+qRteJrT3/zTNCj8CjIeAFh?=
 =?us-ascii?Q?BjPDqxKqlnvQTPUn4Ib6JRjpOyLHueSH+tsTE5nZQHEOQz0vzGoXoMM1sokb?=
 =?us-ascii?Q?UWpdyqJswXtU5Xv4OavWHg4jcrbEoee9O1QS63zKjh17kohxvNWSoBiT3yca?=
 =?us-ascii?Q?KGjKrNrPKXIyPzOq6idSme+TtCvsAX6NDMaV6yJnZyoYLhN8mDvyb1VP1kD/?=
 =?us-ascii?Q?PJutcvbr2cx5hfj64shgw3QaPDee3bduCVDFctPB7ioV7B4gb8kL9wwiqKEF?=
 =?us-ascii?Q?ewPtkk0Iyq8IU0Ix65vYb2hj49Zaw255eDR9TeeWSwui03L6eM8NBKkNLaeu?=
 =?us-ascii?Q?H7WoBzWYEuOzZLwP+uuQVmrwG4PQwE9++OmVkMQ9Fj/fFWpB5F2Is+jJx8MQ?=
 =?us-ascii?Q?CuZUFxBlJGEk1mArcaxUULJvoi1puFXmO533TYYG0J2hjCdGJc2HzB3yZhju?=
 =?us-ascii?Q?rbjTqAhO1ouDEOf09VyjGMGvv94ECOJDpzRlzwn8vdYp1hGe6Jmr4x7WH6Bm?=
 =?us-ascii?Q?z4xnZJr9+wJgrjXyRM3/HTHhV1GRg3pO2GQZtS69VYzug2A2vTFJGvzmuf+a?=
 =?us-ascii?Q?4u0zAlh59u+mwkI3h2ckdAv8TulFxJPWhGZbEMmThbmB0H4FZCribSb5qbbD?=
 =?us-ascii?Q?ziEZ7s5HPsh2YvTvlo+uP/O02ZYX4iGv/dA+35TnymGou5eaxFT4L8CcUUOL?=
 =?us-ascii?Q?jFurSg3R3hhvj30/qGrB6pAgGJwaWKef/4BczRIJgOHXf5TZPuhHZpknRhHa?=
 =?us-ascii?Q?h7jNUMZu7wKIhqef7ytygYY2jQd1ejCF9u1h6z+BkSKpey27Ns9w/3+u7JIU?=
 =?us-ascii?Q?AJyfUrzKBtrFjDfGU7svNP78NEXItVppIqAWDh+LPuCchHGL3L9GJ2BWf5h5?=
 =?us-ascii?Q?UQrGH/PUYucNL7+vpebl0EQp/QHUn9cXyYIeigjO9PTsbfZX5zh5pD/llIxz?=
 =?us-ascii?Q?e87c+WxFlgIwLpoKpPxmPgT4ZcvetJpIIi0QYYy0SSQWhu/GCaAYTh2q3DfL?=
 =?us-ascii?Q?mBjZmqNZMbJ6gWIsHahH7jT4bkffBRISb88QmbNnXM1qoOUkLh9OlUpgNRL2?=
 =?us-ascii?Q?nRuH8i6dfN8JHkSVrkdz+tU9njQzFNycKNJPBkZJX5DlpLiPsuBVGmrQQzKX?=
 =?us-ascii?Q?6uSeqTpRJlCD+qZStCFlpMBLUOhTA2fK0GGUCIU+nun7FSEkVTuzCSClrBKf?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b07f482-74d2-4016-ccab-08dd529cd30b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:26:06.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxB8O2RZP2VRZI75gKq3evCKAU8c+2eDdCTuvTnrzMF6B/Y0LYqofp03LUi5ApM7k0absGpgFrmvAIMy7m9BsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8514
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:26:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17289

- The base class GitShallowBaseTest contains all test cases for the default=
 fast shallow mode and the skipped fast shallow mode
- The class GitShallowFastTest contains all test cases used with `ud.shallo=
w_skip_fast =3D=3D 0`
- The class GitShallowSkipFastTest contains all test cases used with `ud.sh=
allow_skip_fast =3D=3D 1`

Adapt test cases for fast shallow fetches:
- Address the absence of an initial full bare clone
- Utilize the initial shallow clone
- Modify existing test cases for this behavior

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 49 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 48b9e4af1..ba08cee1f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1739,7 +1739,14 @@ class GitMakeShallowTest(FetcherTest):
         self.make_shallow(['refs/tags/1.10.0'])
         self.assertRevCount(orig_revs - 1746, ['--all'])
=20
-class GitShallowTest(FetcherTest):
+class GitShallowBaseTest():
+    """
+    Test cases for the default fast shallow mode and the skipped fast shal=
low mode.
+    Test cases must succeed with `ud.shallow_skip_fast` set to either `0` =
or `1`.
+    The class GitShallowTest contains all test cases used with `ud.shallow=
_skip_fast =3D=3D 0`.
+    The class GitShallowSkipFastTest contains all test cases used with `ud=
.shallow_skip_fast =3D=3D 1`.
+    """
+
     def setUp(self):
         FetcherTest.setUp(self)
         self.gitdir =3D os.path.join(self.tempdir, 'git')
@@ -1814,7 +1821,8 @@ class GitShallowTest(FetcherTest):
     def fetch_shallow(self, uri=3DNone, disabled=3DFalse, keepclone=3DFals=
e):
         """Fetch a uri, generating a shallow tarball, then unpack using it=
"""
         fetcher, ud =3D self.fetch_and_unpack(uri)
-        assert os.path.exists(ud.clonedir), 'Git clone in DLDIR (%s) does =
not exist for uri %s' % (ud.clonedir, uri)
+        if ud.shallow_skip_fast:
+            assert os.path.exists(ud.clonedir), 'Git clone in DLDIR (%s) d=
oes not exist for uri %s' % (ud.clonedir, uri)
=20
         # Confirm that the unpacked repo is unshallow
         if not disabled:
@@ -1822,9 +1830,10 @@ class GitShallowTest(FetcherTest):
=20
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=3DTrue)
-        bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
-        bb.utils.remove(ud.clonedir, recurse=3DTrue)
-        bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), =
recurse=3DTrue)
+        if ud.shallow_skip_fast:
+            bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
+            bb.utils.remove(ud.clonedir, recurse=3DTrue)
+            bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule=
'), recurse=3DTrue)
=20
         # confirm that the unpacked repo is used when no git clone or git
         # mirror tarball is available
@@ -1907,7 +1916,12 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('c')
         self.assertRevCount(3, cwd=3Dself.srcdir)
=20
+        # Clone without tarball
+        self.d.setVar('BB_GIT_SHALLOW', '0')
+        fetcher, ud =3D self.fetch()
+
         # Clone and generate mirror tarball
+        self.d.setVar('BB_GIT_SHALLOW', '1')
         fetcher, ud =3D self.fetch()
=20
         # Ensure we have a current mirror tarball, but an out of date clon=
e
@@ -1919,6 +1933,7 @@ class GitShallowTest(FetcherTest):
         fetcher, ud =3D self.fetch()
         fetcher.unpack(self.d.getVar('WORKDIR'))
         self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.d.getVar('WORKDIR'), 'git'=
, 'c'))
=20
     def test_shallow_single_branch_no_merge(self):
         self.add_empty_file('a')
@@ -2116,11 +2131,12 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('b')
=20
         # Fetch once to generate the shallow tarball
+        self.d.setVar('BB_GIT_SHALLOW', '0')
         fetcher, ud =3D self.fetch()
-        assert os.path.exists(os.path.join(self.dldir, ud.mirrortarballs[0=
]))
=20
         # Fetch and unpack with both the clonedir and shallow tarball avai=
lable
         bb.utils.remove(self.gitdir, recurse=3DTrue)
+        self.d.setVar('BB_GIT_SHALLOW', '1')
         fetcher, ud =3D self.fetch_and_unpack()
=20
         # The unpacked tree should *not* be shallow
@@ -2295,6 +2311,27 @@ class GitShallowTest(FetcherTest):
         self.assertIn("No up to date source found", context.exception.msg)
         self.assertIn("clone directory not available or not up to date", c=
ontext.exception.msg)
=20
+class GitShallowTest(GitShallowBaseTest, FetcherTest):
+    """
+    Test cases for use with default fast shallow mode.
+    The class contains all test cases used with `ud.shallow_skip_fast =3D=
=3D 1` only.
+    """
+
+    def setUp(self):
+        FetcherTest.setUp(self)
+        GitShallowBaseTest.setUp(self)
+
+class GitShallowSkipFastTest(GitShallowBaseTest, FetcherTest):
+    """
+    Test cases for use when skipping fast shallow mode.
+    The class contains all test cases used with `ud.shallow_skip_fast =3D=
=3D 0` only.
+    """
+
+    def setUp(self):
+        FetcherTest.setUp(self)
+        GitShallowBaseTest.setUp(self)
+        self.d.setVar('BB_GIT_SHALLOW_SKIP_FAST', '1')
+
     @skipIfNoNetwork()
     def test_that_unpack_does_work_when_using_git_shallow_tarball_but_tarb=
all_is_not_available(self):
         self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0'=
)
--=20
2.39.5


