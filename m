Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B082C64ED6
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web11.12143.1676457746724761121
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:42:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@criticaltechworks.com header.s=selector2 header.b=XtZotCNw;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.241.85, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgwHCFxn7K7XoZYGuY85A07B1oXNwTizW0eT8c0xFRLbpri+IugkBT9OHGICiFUT+Cx14Ag6brjJtQeWF7CFZ749i002Qzy03zy4Y312xuJ2+dMv8Nyo++5CZGdsmynRbBh3vkJOA6et3m2XcnwlPEH353iVyXRfsgwXlyuxX3ni8gNFm3zvNBOx8T2NR4mzMYc0E4mJOToLCQGzzAF1tx5BurvgFNaxzUFutesD5bAp0bn7xTvuD5gMPAaABdHSJuDSYs2DA+tW/icVMkA7cNF5gXx510X1aqx85iK9FYOLVvZU/XswPvVJrtJpeGmHP61BMJ6VH7ANMsJa6yfmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px38mVwyaZJxkmhHu0w19XXqwBdo9bv48HlQ4IG5FB4=;
 b=Sg8XNZbD1h0onmpd3lkkxwzDtgfOotuDQgD6WyOGHCIU6W3PXFqWJme8emOpbyvj0wDJm2VClP6wfkiBGmkHeZK1jS5U3gtF7WpDsuIOaHSEX7KpdVlvWlXiX6uBBtRQTwsfADHNg1xbWDoehZoYwA2ZouIoP/55Jew83lieWw1812mypWEynW6iONayXJcU8dXLUZRI8gxTuFgDyiLycnE+XZ1Fm2XJGpQlF/Are0d/mH/pWBReFLF/uWBKm9heCrhQLUxEdP7YyphhowU/KeeKm+t5f0tqtktYsw0UKiADc9dygemp/0Aen0tbtX1JmjmuUvVLij5vtROQjn/HfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px38mVwyaZJxkmhHu0w19XXqwBdo9bv48HlQ4IG5FB4=;
 b=XtZotCNwzoubUbK1XMYlf+SJ0Tf7WvXnuL3eGBaldL36xF3m0bCCM/yHW8deWDPc8G01sLStUql+DPPYpTRj9Pcl6zfXIpIGVB75QzrEs9e+HIHUkYKTmHBPnHHYbBlW4Erm2wzb7F08aOfHk7xqxAmNzr0WDZkytSZySKBpSX1FT33rIhdtsW151FmFwg6u2zuRj65OiDHynB9UHX+g+k7ZlxufsVKfmKOAnNdds1mYWICiAL9zAxFjeiyB1yqXFJ1qRHTCRjw0eASbQQjeCr6O6RqVct8X/xRY6rCjVp/24mY9yO6NSBD/VjLmVVkt15l/+RskpQgungTMW4vecA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criticaltechworks.com;
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13b::14)
 by DU2P193MB2034.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 10:42:25 +0000
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8]) by PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 10:42:25 +0000
From: "Fabio Berton" <Fabio.Berton@criticaltechworks.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.46][PATCH 3/6] runqueue: Improve multiconfig deferred task issues
Date: Wed, 15 Feb 2023 10:43:18 +0000
Message-ID: <20230215104321.1665505-4-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
References: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DU2P193MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c2a10d-f2dc-480d-b781-08db0f4153c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KeG1Ll0qilMrwobLf08vMxw4u6Q2MOjCT0c5OeZU4thtb9Nf+BmtzVmmMJI5zyucoWde+oNANMLeBBLyC5QnBqDChK2gIxodAb4+P/FFplDZP9x1qEE/ans7PghSlrBpCIXgeSgFuiIN3TR90IE1HHKstJrakUWJy59eaUcBuJva+3AiL6F9wBaU6C5TiUYUeQl1KsFOcwvjCekGNJOuPlEKPQaf7OKDB67PZnz+Q/SkSW2gJsShNGYp3G2XxfKm8IvpF4neBDo7cg655h2Ac+YsDLEk2Ae8IhF4PdB3rgntE4pyUjpQP8tmrrVGR+jysVOw+x/ovZ8cSv1uoYBH21UuEXLbyGYrKTX8pIJRNtpjC8IPPtv5lWr644ycrO3KJeMY5/MFSYh4nLYBHI0moeosm0nEgiOYdW8aeJCGRcplGxpyLkBiB3+bneV+p/weNI5fH7VdcSAEcV1GNt2tUFRRxb3jPe4vMzADzBKk0C+jOUT/unz2mHpPb7WrIIQiX2REH7vXZJR8Z5JOSsx9xXxpgp14NYK59UFS8/wlSAfEQCJglH4UqLlW4RxqFf9dD3ZLwx61b/6zByi2PSdsrjTCBShDkOpbYqfY6K0FP5AKVELHGjB9ZrvaDh3t1KVsSdBtDO9YGFaWg8LV/6g/ilU5h6MjzFc7TzyB5XuDbPDoqc74S4du+S2D1Gl2EJziBw9qmAss8/vWLyu6FXEPhw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(451199018)(83380400001)(478600001)(2616005)(52116002)(6486002)(6506007)(1076003)(6666004)(36756003)(6512007)(26005)(186003)(44832011)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(8936002)(316002)(66476007)(6916009)(8676002)(66946007)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qPvqxWfdD6X5ghsqLRlNM1VBDnIs8g4IzoaGz6xStarkSbmP628TuCyJY6oj?=
 =?us-ascii?Q?wMmGd+OyPX3GqzjkEnoTkR/ijH7M5tHScYQDld48MVOIVI47nFF57aRApDD3?=
 =?us-ascii?Q?vA3NMH7US6WVP000nbnlQ4V1xDTSiNnFI+nkvioE3RDtbHEGY3jOBzQxuqsH?=
 =?us-ascii?Q?+4uBDv4GV8RJHEyntJivEKcc+0418AcfQY/ILJ+kNsqUz8mLHMaBxZ97WslN?=
 =?us-ascii?Q?JAwqOHVHLaQ9ea3lAZwWpo4MWyfxtNKrHH6apXEGwY70pUsEDAr5XO2RiMIS?=
 =?us-ascii?Q?vtAtbi5UzmZTeiTWfdhSCCvEfBdpFuLTF6W2Ty0UWVF3w7yarucdB3CKNSJQ?=
 =?us-ascii?Q?wjHSvzcpP9F7XRWHlkbPf9+VyKK64eStPc/ntcoS2YuKo+1H5B82sNzyjrvr?=
 =?us-ascii?Q?UHI2otJ1Y5/BxT9Oq3XobuPqm4eE50jTxrSL4BF0N5zj9pBSor2un5Pzde+r?=
 =?us-ascii?Q?pfCNf9T+A84X73o9n0EFqnVud2A7YSxfweDacAXlhovGyc7W94vtJSJNCYUO?=
 =?us-ascii?Q?W3jj++M/1nYQei4PXpq0ppzyetTYngQEyFdFSa7TTkiR7NFLfnkGCXRB/jNv?=
 =?us-ascii?Q?jln5OjvnrPxIq2dFxaL9GK9rWeDH58i96hMPF/wEc1IrdDlEWAC2KTaXnyQ8?=
 =?us-ascii?Q?mBuQEX5vwtpACX8PxULl+TdaV1A/9T40RxRGMN93tOYN2/2yen9/bIku9kig?=
 =?us-ascii?Q?otQ/rxnG0WONj9M4dFsmnTwuk2WJWnov3MXUw7nq5XGO3ieYL+bzyKbZnwm/?=
 =?us-ascii?Q?1NqN9YPLkWKdxU/3grcfIwiRfqED+1ZrEUoVq8G9cfcupqxIRcwNfw6jkZmr?=
 =?us-ascii?Q?2w49k0aZKHXVD83ewGaKcK7Qp9LDTbl1G5NReujirsvWN29PEjkeh7gAXGa2?=
 =?us-ascii?Q?Ckz/X57Ohs+ibvJOd0JRSBn3xEDMUMuAjgLokfWQLY0VvFRWfZo7jirKKR3d?=
 =?us-ascii?Q?5FxcAN24SxSDsUlgOlN4+Aw8AxDdIhYaJOWjp8tYGCNlSjwz1uD+YAUU9guL?=
 =?us-ascii?Q?wc/Q3x75NTTsl+xn7IdNjUC5Hl2V7G2wy6SOGiMyr9wRBUsHymWS+hu4cN+9?=
 =?us-ascii?Q?qb7+QJYAZ0A+RYDZvNWvNPj7E5Ea2hsNiMEhr+2T1pY1SXAjJ16l0f7RXaNH?=
 =?us-ascii?Q?rlkTiAJsyzGZFlJpGj8BulpZgy/c4zgJM7S2K40pMrOSG1/0xyQNx4k5CMNh?=
 =?us-ascii?Q?dRZmeQuXt1807yVovbsXJzo/KYOooAyP9207eApY9Pcf9f8XJAqvOypJ/dSc?=
 =?us-ascii?Q?1Iwd5ssrbs2lX6L5/oK/7QbqOM3mC6FF37Fzln1BptYLO9FChH3dI7MYbBlz?=
 =?us-ascii?Q?CaPlTSWd2mzZFa01jr8+tBHwqugpYeqCar0YP4ar+yf7ouuJDqNp6FNX/k53?=
 =?us-ascii?Q?MLUJky6jSbid/Yqi+1oH7uyYjNGeACn0Cpkbh+TUHJ0dQ7ZIXYVTyQZeYT3t?=
 =?us-ascii?Q?mxn5Rr5o4SiO6rXo7V5fBPc7F+33c5r71R7I2/buo8A15sEWY+6n7bs8WGDw?=
 =?us-ascii?Q?Umaxs1xqRegFb4h9o4IBeWvWTIpLMDTrwIskl97CLOcxb4uU/7gmnTmejjEl?=
 =?us-ascii?Q?EICWEtTLZbUdxTnf0N47Ft2AYonKClHvy3R/47UhYUs3UKNaFd10G+oR2rzF?=
 =?us-ascii?Q?JTE15oysJm6VJvUk4QpX9rQ=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c2a10d-f2dc-480d-b781-08db0f4153c7
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:42:25.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yc9SG0Hl3273xZ6IPxxfw//o2Qa5kE1SZMl5jEQhdMrPeQ6zIzOUvdtdDNd6EoZhqReRlglZSwmBXOtOW5dOd3oWK2vbKb4Jj8bDaKdcJpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2034
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14429

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The previous patches have exposed new issues with this code path,
the issues being around what should happen when the hash of a task
changes and the task is or is not on the deferred task list.

Rather than rebuilding the deferred task list during each rehash
event, build it once at the start of a build. This avoids the problem
of tasks being added back after they have run and also avoids problems
of always ensuring the same task is deferred. It also allows the
'outrightfail' codepath to be handled separately as the conditions
are subtly differnt.

One significant win for the new approch is the build is not continually
printing out lists of deferred tasks, that list remains fairly static
from the start of the build. Logic is added in to ensure a rehashed
task with a hash matching other deferred tasks is deferred along with
them as a small optimization.

An interesting test case for this code was reported by Mark Hatle
with four multiconfigs, each the same apart from TMPDIR and running a
build of:

bitbake buildtools-tarball mc:{one,two,three,four}:core-image-minimal

which is interesting in that the build of buildtools partially overlaps
core-image-minimal and the build has a rehash event for qemuwrapper-cross
even without any external hash equivalence server or preexisting data.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit bb424e0a6d274d398f434f7df63951da9ce305b3)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
---
 lib/bb/runqueue.py | 58 +++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a437aeef..9efd1c86 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2496,6 +2496,11 @@ class RunQueueExecute:
=20
         if update_tasks:
             self.sqdone =3D False
+            for tid in [t[0] for t in update_tasks]:
+                h =3D pending_hash_index(tid, self.rqdata)
+                if h in self.sqdata.hashes and tid !=3D self.sqdata.hashes=
[h]:
+                    self.sq_deferred[tid] =3D self.sqdata.hashes[h]
+                    bb.note("Deferring %s after %s" % (tid, self.sqdata.ha=
shes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqda=
ta, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=3DFal=
se)
=20
         for (tid, harddepfail, origvalid) in update_tasks:
@@ -2836,6 +2841,19 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker=
, stampcache, sqrq):
     sqdata.stamppresent =3D set()
     sqdata.valid =3D set()
=20
+    sqdata.hashes =3D {}
+    sqrq.sq_deferred =3D {}
+    for mc in sorted(sqdata.multiconfigs):
+        for tid in sorted(sqdata.sq_revdeps):
+            if mc_from_tid(tid) !=3D mc:
+                continue
+            h =3D pending_hash_index(tid, rqdata)
+            if h not in sqdata.hashes:
+                sqdata.hashes[h] =3D tid
+            else:
+                sqrq.sq_deferred[tid] =3D sqdata.hashes[h]
+                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
+
     update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, =
stampcache, sqrq, summary=3DTrue)
=20
 def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, s=
qrq, summary=3DTrue):
@@ -2876,32 +2894,20 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq=
, cooker, stampcache, sqrq, s
=20
     sqdata.valid |=3D rq.validate_hashes(tocheck, cooker.data, len(sqdata.=
stamppresent), False, summary=3Dsummary)
=20
-    sqdata.hashes =3D {}
-    sqrq.sq_deferred =3D {}
-    for mc in sorted(sqdata.multiconfigs):
-        for tid in sorted(sqdata.sq_revdeps):
-            if mc_from_tid(tid) !=3D mc:
-                continue
-            if tid in sqdata.stamppresent:
-                continue
-            if tid in sqdata.valid:
-                continue
-            if tid in sqdata.noexec:
-                continue
-            if tid in sqrq.scenequeue_notcovered:
-                continue
-            if tid in sqrq.scenequeue_covered:
-                continue
-
-            h =3D pending_hash_index(tid, rqdata)
-            if h not in sqdata.hashes:
-                if tid in tids:
-                    sqdata.outrightfail.add(tid)
-                sqdata.hashes[h] =3D tid
-            else:
-                sqrq.sq_deferred[tid] =3D sqdata.hashes[h]
-                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
-
+    for tid in tids:
+        if tid in sqdata.stamppresent:
+            continue
+        if tid in sqdata.valid:
+            continue
+        if tid in sqdata.noexec:
+            continue
+        if tid in sqrq.scenequeue_covered:
+            continue
+        if tid in sqrq.scenequeue_notcovered:
+            continue
+        if tid in sqrq.sq_deferred:
+            continue
+        sqdata.outrightfail.add(tid)
=20
 class TaskFailure(Exception):
     """
--=20
2.25.1


