Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4152C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:27:27 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.56])
 by mx.groups.io with SMTP id smtpd.web11.2757.1740072443352419987
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 09:27:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=eHON2IHM;
 spf=pass (domain: siemens.com, ip: 40.107.104.56, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/fXeOv4hXb3GjCkFLOmU6QRZZrUWWdpfukQV5MK1KW1ry7Gi5gDQ5f6dB+LYgIUfKWsiBT9ArzClxPz6ObpKnjX5GsE/zZb0eH32XSmXVpR1PuG6DO4Tgrz7DlKwpmo1B6ga33fvk9W9UCVXWhBvFSZ4FP6BqbN7ln5hcS/1JWe3agL6XOTzXQG4x71NbJYY0LbV3RI9sEPuE6V284XAmXi3COCeqhBDVMbPe5390rbzV3HJROJ0FHYJcaWxcGwP8W1+0Kh+PXell4Twvk13Hug0KamH6SiZydp/GExPZOswvJH9mtuR09WptCa5hVpKBnbwCStFkaKWnfFtPrB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsxrczEO4YFetLHXnXNy5nZF3OU81aT1xLFybME5Ldo=;
 b=Bet/XgzUp4UyA+KisszW+9DeeJBh9e60BSB7aAxGrXOXMLUy6jYWRiWTKKDleIB4W47rvRowMM6oidsIycmHCcUUh9UOpl5HfSIJgcX2fKLGhNlO/SXkWxE71utziWZA0Ul09kPxV9xi05REQWbSkSl1JAOqN97zhfHfCVT7d7li04hg4U9YR1Vtr1vgexJWhmSWM11Rn5XXJBsNJLrxwPejWa6pICfl8zBJhjEjZ01Xf3aES3FFAaGkExGTP1aOKfBR0+1ue8UmHO+pG0X5/4b2pW7jTmcuTiXNFVCKAk02T+MFBPHJu0K1UuJgiH+309LNmBa2JiPwFfaBsOJ45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsxrczEO4YFetLHXnXNy5nZF3OU81aT1xLFybME5Ldo=;
 b=eHON2IHM1XZNzuvtV8KQku5+QEX6Pz4jMCB2pcuE9BDCjhV/XmSrJGQMH9MQW8r9P3fEkO+hP1sWJpx56UPZncHpDwnnxlB6XWhxlYvRw7yrhatrxqbIinvR+lW/kIKN06BL8ABOcA77l0YKYABjKcmTb/w+yBRJw4v2Pg2QSLZMTbK1ZvVmz3L2VJSOo6K+Ja5w/Jv0OyBhUnCCra7Ztjfi0x7gRVzRLmmBOmcXOLW18SPztWqEf6aE7FVvwKzFq0+rkGR6QBWA6eoFKtkgbbnj8AsqM3ulAcV4HGkSjsUu/LEEkp05ipAw4IO8UAjD8g8cHDpGB5F7L8p4lfqHIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by DB9PR10MB5551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 17:27:20 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 17:27:20 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org
Subject: [PATCH v3 3/4] tests/fetch: Adapt test cases for fast shallow fetches
Date: Thu, 20 Feb 2025 18:27:05 +0100
Message-ID: <20250220172706.3850722-3-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220172706.3850722-1-stefan-koch@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|DB9PR10MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df2251f-a017-466d-91a7-08dd51d3d430
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?P68INBlnrXj5kZnNzEJaLrD7hiONf+kAJym/FedJpahQl2A33irtuH2YRX9l?=
 =?us-ascii?Q?+zXLZgdEJNSMqYogCj4zgMVcFGV3hfK6PO/kE7HwoGYtN91uoIZ7Zssyvhp+?=
 =?us-ascii?Q?YB1Hcv1QVzhy6WXe+DSXrY8swzjdD3wL77mf4JMm3FpQxzG6qNmSc8Uu7zp8?=
 =?us-ascii?Q?Q/fi0TJzHTAaO4ylNaD5jEqVwddyuyOOIjaVG/SqJ98GvE6smRaUJi8lDq6e?=
 =?us-ascii?Q?r2IrOvLxsiPe8yNNv8YhhRibCphYzujxkmyJHAxORfzKkVFOtzsSQL1kMQkI?=
 =?us-ascii?Q?OKXgPkt+XIggwZwsQusC3kvzeUrHG56FoHDxCX0iAZt1MXPUCpkfbQg5RDjw?=
 =?us-ascii?Q?4dV61yhLzbB0kbDAneC5XzB5/H7bTkrGfis07FT1Lj3w+iGtf/2jaT+NMz8x?=
 =?us-ascii?Q?KRNLrFStKAxG7hz+S0C22mROcaPGjTpr50TUg18G5NxAVjkv5HyseNqYgBKL?=
 =?us-ascii?Q?EIs2yixJ/03z1gOPefcnmrmORTPcVXLKpDwLClVSf5d7dGPHlElv4OMA/ghm?=
 =?us-ascii?Q?dR6YSbfxAlf9nw8hN2sX3WugvP6K0xb/iUNdXCj8ltGnqrrUq4wrRMppXqcO?=
 =?us-ascii?Q?dccEUHlQKcOE19ajslKUZgfXqoj4O6hJEflTczlri1zsCBsiTX22Ggd2fDAE?=
 =?us-ascii?Q?h/u8DYDugWRY2B+wi8s9pqozCwe7PEGlD4If7/GLsP2psO3GAhPbPRQ6Uapi?=
 =?us-ascii?Q?onlWO3jkgVz61U8SqDUgHg0tV1kCjiPCx/XDZpLxlS6dJhqbuys6JN08MIpH?=
 =?us-ascii?Q?t6YColPbceCwXmUIJ9ohiPTBFhPSopOLZsDbpAeyWtX7bLqyuBWM+lBZk4En?=
 =?us-ascii?Q?AL95NcAYjDM10KdbHcCAnzQFbzp+/WFEoTbtOh8/RLGgDDoTImAcJIS+iERG?=
 =?us-ascii?Q?kZN37hPrNBRLOECsqHJvgs0qYnIE+0fs59Z3f7L/LSHssAyZ5je5ggdBYhHY?=
 =?us-ascii?Q?jDVGg1m7tEIctpukkKlFWktsSNPRHZbK3ix9UMqYuRzxtzjdZWdwljS05hBq?=
 =?us-ascii?Q?+DxMPkMaGt4KDbtmoJADjfMYM9XqZpitj3tb//MrcvUnGdaKtRfc5hizB4F6?=
 =?us-ascii?Q?KztLEanwfjHDh5sGYihW/J7cEiQTTmkVaaZD7I3141UI2vlm6VAzRcZD054f?=
 =?us-ascii?Q?y2wE26PJ21H02j9bdxQzmRzT3PWtBK+zanoqnWofYmBvRphtJbKTZqHxGcBe?=
 =?us-ascii?Q?pylbXI6ccYkvqFGzAybxhL1BdU6ifMjPj6yTN+eprV4EgFJrKbf7JOT3C55p?=
 =?us-ascii?Q?LXMvCcvqtC6N0zTyAOZkh2pJkpEe7rHvpXbrmbj1J40G5MvPIZwEuSgSoE17?=
 =?us-ascii?Q?mK86TX/JZ0//TY0+CMryQahU5OetAcIDgODNTHrOdQH+StI0qSxIvt0TTF6G?=
 =?us-ascii?Q?eAD/agfjXJ3FwdTdQfKxyAjETPdR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oQq6s5ozXYf7MROHnOAkPzyYJ/emxkzkIuF/gLVtdBsZr+9TYvreVhOkyn6o?=
 =?us-ascii?Q?P+UiESVeC99AZBLUvcFzZv4ALk4yd02xA1mw9lzlG73TWqlNtVQwOM33pcs+?=
 =?us-ascii?Q?E1+hrvL+rm6e23ITukwib+CcDpgQVfBrTXtpe97yJD9CmoPhyVa8OyjvvuKF?=
 =?us-ascii?Q?sAw+eDyzaQxEYvTVStOiLstSUI0WF3HMv79T6z2rvB9+8PmtM+s5p1ciCDBt?=
 =?us-ascii?Q?3ZejI1qRCz6yn/6yw325UUWOTD2sIp81NzbI1EsFyQj2NposLbhj1smG7e1u?=
 =?us-ascii?Q?A32DGawhhoIew3vmOhffsd3nWcWyWbpj0u1WA36/mU43UI8lp+qLwtCIB6r3?=
 =?us-ascii?Q?uxHZQFThbihfJFRVV038BGLleQ3d+7yqOW55BtB0+4Seb+iPiQPriv6eZ9rA?=
 =?us-ascii?Q?DzvNVWPE621nxXN5IlNduEtR6uEr59dREzFq3GzwkRegRH4vuLhdtI+V4Zfr?=
 =?us-ascii?Q?yCJ5m7xJ80IlzTqqAzw5jq02UtyGaF46NBen0uzJNvBLshs9Gv6ennl7wdg9?=
 =?us-ascii?Q?r+8jC0Biu88jUrIb0daFLkfeawW/dmQK7O1+pDthjAICWLjbqxrtBgCUQAe7?=
 =?us-ascii?Q?Q/EcxgPds3cpm6kse1i1x/LdXpgozglTkjXM2Wphn6lL2rVombXvQEUQwl1f?=
 =?us-ascii?Q?0tg9DsO1OmQf+KNJ1x1pcZsZYwQ3LjCua03GX3+qIADGUwYg4o3Qi2UJIjVL?=
 =?us-ascii?Q?oRSNjgoDnKcCx5AKNIHT0amnhxDW0yPuNorG5W6jq2CBYe3oT9r6RBS/CRL+?=
 =?us-ascii?Q?gkZ3yDxYoxuq1d2wIdeBnCiPXUVSqXHN9vPtaJX5xEf3mlY3/fCQfxPReA4d?=
 =?us-ascii?Q?r0cnRmtz+vi1/FIcw2kw0STJ11cTGUhP7LZYk0w3fPJcyM3QtzDNAjRHEHyt?=
 =?us-ascii?Q?1AkIf1cqz8OKmJpENoyc08lbhCV0bdCNvmRg/ilnGXxedxZiqNQbSb3PatwQ?=
 =?us-ascii?Q?5mKbt+Emuq9icmC+mL5Kx95OuF3/h/Cj/xhrDT0ZrVosuwWOH5DXKADAkN4C?=
 =?us-ascii?Q?JJx3Zp1i4eyzzMUM/OY73Jx1OOj1TtFUt2p5S6j1NEUFZFdpR7fOkS6r89Tx?=
 =?us-ascii?Q?19aaGsfFNmZO67gGYLOksl/OeRv0h/aRo+/HvQmcWLk2DuUCvvOQAnIniUkP?=
 =?us-ascii?Q?KWA1zj63NLoIZeSBAL9Ff7xTv6uQbMSm29rfIayG+lYNdBLK3bD+bHxBqaZV?=
 =?us-ascii?Q?7leyAk9x6+lEyc72Zp+xpSUx1lfX9Jjpg8Ii5NFppR0dHMCLBlQbRLKEL775?=
 =?us-ascii?Q?dFWgogYjsCoZnJ3h/i+hM2KZn6bP9uLXbj2I/DZuHpMekel5G5Bpu0NCif4s?=
 =?us-ascii?Q?Esfp7kDbx+DWJYGVIpbFwzBu/gxCpBlNO2ks45Ee+ziR+yDgcFlL2zOFSoPd?=
 =?us-ascii?Q?SYvDZMbrDhBbiS6jASye/Bc2KnrwoNCgKjUkCjYAFCpyZBoy3aOclLBl1OmD?=
 =?us-ascii?Q?j/CtJwr2NFcSo51gZWUiOU+xYxcNdVztMhCI5xemDIn5x+T6BiaRttF+gxUm?=
 =?us-ascii?Q?pjPi0T3NNhs081OmYQAbyIqbDm1J7tRVxZo6vidWNHamOOBlUpf9UgIXAYx0?=
 =?us-ascii?Q?/fPJ4YebQKvQUnYl0FNE9TdhB4aTKP21J6wXwd4TBJUf51KG1261sMeE5SyT?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df2251f-a017-466d-91a7-08dd51d3d430
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:27:19.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jRvY70RiLUJXyGltDvJQratsTHyoYi3ozYzS0t/RIAH+nWKSQboiPI0rGhz0PzgyYwShFQ86Kq6x6C2PI8XBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5551
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 17:27:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17264

- Address the absence of an initial full bare clone
- Utilize the initial shallow clone
- Modify existing test cases for this behavior
- Remove incompatible test cases

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 48b9e4af1..c0b53da31 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1814,7 +1814,6 @@ class GitShallowTest(FetcherTest):
     def fetch_shallow(self, uri=3DNone, disabled=3DFalse, keepclone=3DFals=
e):
         """Fetch a uri, generating a shallow tarball, then unpack using it=
"""
         fetcher, ud =3D self.fetch_and_unpack(uri)
-        assert os.path.exists(ud.clonedir), 'Git clone in DLDIR (%s) does =
not exist for uri %s' % (ud.clonedir, uri)
=20
         # Confirm that the unpacked repo is unshallow
         if not disabled:
@@ -1822,9 +1821,6 @@ class GitShallowTest(FetcherTest):
=20
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=3DTrue)
-        bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
-        bb.utils.remove(ud.clonedir, recurse=3DTrue)
-        bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), =
recurse=3DTrue)
=20
         # confirm that the unpacked repo is used when no git clone or git
         # mirror tarball is available
@@ -1907,7 +1903,12 @@ class GitShallowTest(FetcherTest):
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
@@ -1919,6 +1920,7 @@ class GitShallowTest(FetcherTest):
         fetcher, ud =3D self.fetch()
         fetcher.unpack(self.d.getVar('WORKDIR'))
         self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.d.getVar('WORKDIR'), 'git'=
, 'c'))
=20
     def test_shallow_single_branch_no_merge(self):
         self.add_empty_file('a')
@@ -2116,11 +2118,12 @@ class GitShallowTest(FetcherTest):
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
@@ -2295,19 +2298,7 @@ class GitShallowTest(FetcherTest):
         self.assertIn("No up to date source found", context.exception.msg)
         self.assertIn("clone directory not available or not up to date", c=
ontext.exception.msg)
=20
-    @skipIfNoNetwork()
-    def test_that_unpack_does_work_when_using_git_shallow_tarball_but_tarb=
all_is_not_available(self):
-        self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0'=
)
-        self.d.setVar('BB_GIT_SHALLOW', '1')
-        self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
-        fetcher =3D bb.fetch.Fetch(["git://git.yoctoproject.org/fstests;br=
anch=3Dmaster;protocol=3Dhttps"], self.d)
-        fetcher.download()
-
-        bb.utils.remove(self.dldir + "/*.tar.gz")
-        fetcher.unpack(self.unpackdir)
=20
-        dir =3D os.listdir(self.unpackdir + "/git/")
-        self.assertIn("fstests.doap", dir)
=20
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
--=20
2.39.5


