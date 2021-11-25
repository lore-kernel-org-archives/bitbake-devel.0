Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B22FC433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 13:00:20 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.59])
 by mx.groups.io with SMTP id smtpd.web10.11801.1637845217309637017
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 05:00:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=Iov0nSsZ;
 spf=pass (domain: weidmueller.com, ip: 40.107.2.59,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd8cv11B+H2V2UlCKCj4HLTDmkRTIEnrW4PL5l2A+KQTxgkYMsPHHk3srK3zCNdB0iniQmAvftOrZc2f/HdfCmwLLxA6ix+4RjDIefEKLw1r9bHcTJNUilesl98CsjkzmDd0KQ6WJ57N4VHeftWZVYI3vR+5Gn+vj3qHUmu6KzsMfBt+j6fwXymsrApy+uBt5LKNBy1NNnCh05YiuSiFFXk3PdMTN8gYxxuY3hPkoePoRCo6QG90W7mfWNDXg3EbAUWp2urLoKBAFY2dfCDhnFRPiCLY1euW27CVDGInVTFyW3uEg47EmhjwQgmD0WJOHRXkHdibuNfrr8d0qw2Hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z2xQ5E38EvVALRJiU9UnUKA/0swZjqTeYDX2SMXtak=;
 b=VBjLBuYB60W3vbPvtuHpcjgBoM0ceunSZ/3/0QZ2e+42IwKAqV1ro5Q/nIcuF8WMp4rycKFcavrFSff8xT/LUTWeCV9wJ2bl3RC9Vo1t6wcxVeEHg48w9x0ijKFynYOq8mOq4PziBB3N+1PtwX2STd1XcfrWRa+D0hsuU1Ku9lZ3f0HAvqLuQFtvU00poBRQIN/rndMQYhwTmBU68eyPnI/bQXwI3m4V4msJ8ThOlnbcfZMDkrJp5uYsKVS5gcCijVBfVSgzpOta256tQWImDkYOnUAGmuPBM9yqcvY9wXohv1HheiAlrElRsI0Kno58Bxwp2mvTZ6TVVHHNtUVcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z2xQ5E38EvVALRJiU9UnUKA/0swZjqTeYDX2SMXtak=;
 b=Iov0nSsZY/6YPx2pc5UfYJ9sz6V1iarcnewlR9mZAdFjjrbKDWAcCQqZs0X07XocWE1iJhDM0aIjER0C5kHl+miEBu+TgEv+0U4EfEOqRkuom5kq9ETTywJobhD5Mokb2gPWzzfKZef+Yflt12DenTILXaztx4wPuEGlV9qzsIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB7020.eurprd08.prod.outlook.com (2603:10a6:102:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 13:00:14 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%7]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 13:00:14 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	Martin Koppehel <martin@mko.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/4] fetch2: Unify tar command in unpack
Date: Thu, 25 Nov 2021 13:59:51 +0100
Message-ID: 
 <20211125125954.15890-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::27) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (94.134.181.29) by
 AS8PR04CA0172.eurprd04.prod.outlook.com (2603:10a6:20b:331::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 13:00:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d80d4a-8f84-4c36-d8b3-08d9b013854d
X-MS-TrafficTypeDiagnostic: PAXPR08MB7020:
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB7020E9C8180FED8BB05B4C51D7629@PAXPR08MB7020.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	83ikpFSN65dsfEGGEPRjvEhQTJs/DSlENHZY0ezzybc/sGOaG9Utrkf57CO4yb9+XwhNcDfuuW3CJGBrAo/c0YUqGHBkGDtzXzHJ6Ok+sxQa1mhKnWgL68skY+lAP+fN1ckhTaXFlh8O9jrnpd3A1hu51pgCTgoK8w4s/Q7S5xAMGOb08jYmxV/0TfgfUdA7rDvrDHvp3CJz5yKbOiW0Hd6UFFvapXcr/Z507tyhIZT4UvM6DQN2JVVyYAKvjI1BiXa7gA5tG8xwYotNaWm3A2JXCz8u80d9gnMQOFXhQoGVNUNMQb7Uu5pHqnj+SRu7ZnhADkh7NThwRHeuWRBlYF6yaME2H5LoTx8XYwatZZMjq0YZkBsGkyVoCec1U9btalAHBCMjyL/CpARFtZYsPqMHchYgml8fknSWS0aaUlFnb+a+z17M91AX1rLWcsWYRJGw78PaZo/UYdnNmJ23GUsxLa9YuQu3wfNxDcrqRynq3/O/6MrAReTFtKRyG2H+tyW5vpExojdzdvOVNZP4ejbjve6YVHKl1rB+k8ECyfFf7wjEOVG8kfYN/z4C+dPgivpYAahQXbj2HUedcuTK2QaM3qRRvayh1gdXtpCKts7c/LTeRxfRYE006UOtmKJCFeC4UcLyi1KyPHG0gXRUNL63uzz/MgQwbae76kMJmko6d0qYXHI2h9OP1oM0OZ+3r5G9/IUZaJz5Ug5puCVRZg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38350700002)(66556008)(2906002)(1076003)(8936002)(38100700002)(83380400001)(107886003)(66946007)(110136005)(7696005)(5660300002)(4326008)(36756003)(6666004)(8676002)(52116002)(26005)(508600001)(2616005)(316002)(186003)(86362001)(956004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rj4t+e5WA5/5Vz5iqWhOZwwhi0zRmg74kv++Pvma1j9fc5sAa3R4QI1cY/Tk?=
 =?us-ascii?Q?atqKOL0FArqPwu/Xx6f6ICAIEHBOCg7hrxs1Qz8wnJL5z2anj2tk1GUZHCvS?=
 =?us-ascii?Q?660frX1nPNqIphFnMpseJoWZl4dDai9jmbqDIcyDF4AE7Xs/ZMOkthC3AtCR?=
 =?us-ascii?Q?/z+ofeOdb39rM1wie5A9K6WY35QZ2eee6N8RccLDKXoUiacFzKjrQuGmRpp0?=
 =?us-ascii?Q?ZSlAJcEcuHkJ5J+8vt+YiVuZiBJ9bxlKt1Aw4v+tls8/JnMkfovLOqn8VXMm?=
 =?us-ascii?Q?8d7PkPHlxhPI6CWkMcpsmu3oAdDa8sYAnyD5hKEMb4kkeNJ+ijqLRYvxJ/YZ?=
 =?us-ascii?Q?6b3sYGOQtenPfosFLVo2RWGGb+9/fXbxyEGNTDWsC7Lee9D1MJ1O9WDeq0oh?=
 =?us-ascii?Q?PlI/xpzgZllY7DaljUtgZZ2xSUciaLU0DDKIUUfa4rTNMH5hRmn2ayBTarNT?=
 =?us-ascii?Q?+HEfWis/dykWYMQyeu1sdjOp7cqDSGSvy17KzZXLCpSqyG8aH4KEO7Imp2nn?=
 =?us-ascii?Q?E/Ds5M7coxBz93xDXDhFFfxU3eOS7uTwOuM4FBpsyB5//vMIXWb6NfiyaLdD?=
 =?us-ascii?Q?U4YCQLuiBYG+9t+T0hlHUgFsXaYdwawSNmhy6zGWJZTY/ybhqA2M1GH4lD2R?=
 =?us-ascii?Q?ZhmrnigMz75EI9N8QI2M+YE85v+A2WI172ZkGeCZyyay5bHUUxgSsNvGxI2F?=
 =?us-ascii?Q?E3SPlZruoN7aQv0pYzpUG52vvJBsc0NmaJytVNcMWWUMplYvDk1jPM9+xFFI?=
 =?us-ascii?Q?/lzam4eLuLP5gHhPwYbMNbF78SVYqc3JzbwaKctUBlQEWQBHTJO20DznfX6g?=
 =?us-ascii?Q?lw6e026P3CzB6vDgKycvxlKw2hxgYzlZokHz36lbLONk2nuCe5QJtSau7QqA?=
 =?us-ascii?Q?atMwwFnaLU07l3pHgsUZpU6rNgUEjHsOe5zdgM/tQ4tqwlmq5GTw/S8SNl3D?=
 =?us-ascii?Q?dVC4xXIISqjN2jnxS/yh1c5lZhAjD7Zgmcj01g8oZnmR9OvZhoKZKDMEpusU?=
 =?us-ascii?Q?ufDsofQFos+l9dHcOkWx6WUMzuojCNQHGiUB6swv0aKujy2Dp4+AipCSEk6L?=
 =?us-ascii?Q?7WSXWetYFakOc3NhwSXhC7g4j94kQY+ekxdQ5g6TWilt+PZW4O+K3k/8aKNO?=
 =?us-ascii?Q?AmFfEDUnLBiCWxKTGHI2mcUdMrwRWDT+C9kuRrtZq+s0Uihl8mx2v6fD+Wwz?=
 =?us-ascii?Q?JfcegJQuefjbYluQFSvSvHiIj/6/Fu1Qjjjt3VbBBTanmHmbK43P4YYBuoUP?=
 =?us-ascii?Q?DihkAMRd9jTeuT5Iu7tjhryRqsWSF/hCyBvsN4iRVyVIhjP7aUlhMmvqalLP?=
 =?us-ascii?Q?JmrWFKPFKAJcZJtODy8hpqJtvwCHLE4RHapKiD2zIcRABY/g0UGoox/EKFwN?=
 =?us-ascii?Q?v9FvDexGOd/5P88O0LGkP3L1BaGwFgnfZlU3YU9kierAYbYujdIhrw/P9PlU?=
 =?us-ascii?Q?fV3IelC1fhjzTlRaZKqpkcDaClaACJJk8+RTD2VBuP9DB9RmIP+5JUSy3q9n?=
 =?us-ascii?Q?8B4jg4y/8VRlyRzPUbtEUrEs18TntvkjTU3zi/1mM8l5AJs55hkk0HNaDX0X?=
 =?us-ascii?Q?1LPy2bZtvGMMAAeRFH7XIvyG1ZaFwT/XDE0gBKKxKazlkvh0rBSyebz7N8NH?=
 =?us-ascii?Q?rF0wY0qifU6DE4UqxnAEI8M=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e5d80d4a-8f84-4c36-d8b3-08d9b013854d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 13:00:14.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ylzzHVkIdc34u4fX05Y+fXoGNeSejmhWrNbqnLSKDYsYY0BhalcnU9xU5OSP9y9mJlSh1xdYTXODaaTihdI2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7020
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 13:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13107

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The tar command and its arguments are repeated for many archive types in
the unpack function. Unify the common parts in a variable to prepare
further extension.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ded31061..b0d5508d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1458,30 +1458,31 @@ class FetchMethod(object):
         cmd =3D None
=20
         if unpack:
+            tar_cmd =3D 'tar --extract --no-same-owner'
             if file.endswith('.tar'):
-                cmd =3D 'tar x --no-same-owner -f %s' % file
+                cmd =3D '%s -f %s' % (tar_cmd, file)
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file=
.endswith('.tar.Z'):
-                cmd =3D 'tar xz --no-same-owner -f %s' % file
+                cmd =3D '%s -z -f %s' % (tar_cmd, file)
             elif file.endswith('.tbz') or file.endswith('.tbz2') or file.e=
ndswith('.tar.bz2'):
-                cmd =3D 'bzip2 -dc %s | tar x --no-same-owner -f -' % file
+                cmd =3D 'bzip2 -dc %s | %s -f -' % (file, tar_cmd)
             elif file.endswith('.gz') or file.endswith('.Z') or file.endsw=
ith('.z'):
                 cmd =3D 'gzip -dc %s > %s' % (file, efile)
             elif file.endswith('.bz2'):
                 cmd =3D 'bzip2 -dc %s > %s' % (file, efile)
             elif file.endswith('.txz') or file.endswith('.tar.xz'):
-                cmd =3D 'xz -dc %s | tar x --no-same-owner -f -' % file
+                cmd =3D 'xz -dc %s | %s -f -' % (file, tar_cmd)
             elif file.endswith('.xz'):
                 cmd =3D 'xz -dc %s > %s' % (file, efile)
             elif file.endswith('.tar.lz'):
-                cmd =3D 'lzip -dc %s | tar x --no-same-owner -f -' % file
+                cmd =3D 'lzip -dc %s | %s -f -' % (file, tar_cmd)
             elif file.endswith('.lz'):
                 cmd =3D 'lzip -dc %s > %s' % (file, efile)
             elif file.endswith('.tar.7z'):
-                cmd =3D '7z x -so %s | tar x --no-same-owner -f -' % file
+                cmd =3D '7z x -so %s | %s -f -' % (file, tar_cmd)
             elif file.endswith('.7z'):
                 cmd =3D '7za x -y %s 1>/dev/null' % file
             elif file.endswith('.tzst') or file.endswith('.tar.zst'):
-                cmd =3D 'zstd --decompress --stdout %s | tar x --no-same-o=
wner -f -' % file
+                cmd =3D 'zstd --decompress --stdout %s | %s -f -' % (file,=
 tar_cmd)
             elif file.endswith('.zst'):
                 cmd =3D 'zstd --decompress --stdout %s > %s' % (file, efil=
e)
             elif file.endswith('.zip') or file.endswith('.jar'):
@@ -1514,7 +1515,7 @@ class FetchMethod(object):
                         raise UnpackError("Unable to unpack deb/ipk packag=
e - does not contain data.tar.* file", urldata.url)
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package - =
could not list contents", urldata.url)
-                cmd =3D 'ar x %s %s && tar --no-same-owner -xpf %s && rm %=
s' % (file, datafile, datafile, datafile)
+                cmd =3D 'ar x %s %s && %s -p -f %s && rm %s' % (file, data=
file, tar_cmd, datafile, datafile)
=20
         # If 'subdir' param exists, create a dir and use it as destination=
 for unpack cmd
         if 'subdir' in urldata.parm:
--=20
2.20.1


