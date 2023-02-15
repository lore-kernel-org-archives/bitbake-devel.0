Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD0C64ED8
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:26 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.57])
 by mx.groups.io with SMTP id smtpd.web11.12145.1676457750437552896
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:42:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@criticaltechworks.com header.s=selector2 header.b=yojIQGml;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.20.57, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1gNNr0bxN2ohIXGOIUjIiwDIGWSZFQjkLJ5nQvZzRFbKHHV4EHA2JLlLF4QoorE00kShPZPW5b1ejGtvTiiGMlNs0UkCYVpf2yTeTr0LvkpOlzfCzfBhyjtToU79fn2usg5diOj4pnm+ljgkOeVfFW2gmWgmeJAd2b78PFk6NBrqhi+ea/uRsVJcRLGAs+R1zN/S3c44OQEg/sbehWtgJ0w8L7ZwFvK8Zn/YZLPkxyEUK9s1FFKXwBLSJT6+IsFc/Ip8o55+lg10JX2oVqWPy3rmNfT9Bqk9y9cwxhW3hXTyA9xBCejisnu6gR2vsefjeONuOZinXiufBHaZAvnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35kSsyS+kM6LZmWpCoabv+RBeUK8Uhl2tvHuaDgvP2g=;
 b=nh98MqKsT3sXD6Ns87FPIrGz0oEn8xdv5Q0v1YpMzhMNUaXexJJPmLvlzpvV48TMWnEUOfwpfOcInamzKOIybqsVxs93Eb2J3u7c6KYZA9UBwuMKGs9W6ze0OANA6QbILmw4qA6EB40+wOAJCmwESDRJFqTmVQdSPcj/wnYKoE2veKMD56b8xuivXJd58oCbPCBs6VVmZonZMcL0Ld7xk9tEJpg5IB1MdBMK3mY4oxg1Zh8W81rFFP14W8OpBwwqyDEOyb+eEfZHmRGeCkOBHo4PqjOLY8AsX8IqmaGLjsFCeCeQwPBaQ+z9/RHguI5ObJJadOM0tvOmhr79kjYLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35kSsyS+kM6LZmWpCoabv+RBeUK8Uhl2tvHuaDgvP2g=;
 b=yojIQGmlWW7b6Z5VSdsouJ0GyKjWX5T+0OUV6zxY/sTfhUzj3xbXO4CoCVp1PQalOIuxBsJjqwglEINCUM21w+J4LILhy7So9e6suwrvv6htQPvFiLxeca2xByUnJjc1u4aS8rm713yPJPA1kADcyQt4EgF5Tnfn3HXUy1AG6oTqAjUckqGxDxKPmMOrvhtRAd9jvwHQfycxV7cTqZCDtwLSaNtPysgGCh8/G2TxRNII608YCm0C5yU8Bd5u/05CXFtkb8+hE6NcXsqAWzW4voX8sw/6XLe6HJ0G7WAXmOKj7ZwySv8lNj9o96C1RIGiNgFFhf8FlJesXhhStiZt4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criticaltechworks.com;
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13b::14)
 by DB8P193MB0712.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:152::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 10:42:27 +0000
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8]) by PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 10:42:27 +0000
From: "Fabio Berton" <Fabio.Berton@criticaltechworks.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.46][PATCH 6/6] runqueue: Ensure deferred tasks are sorted by multiconfig
Date: Wed, 15 Feb 2023 10:43:21 +0000
Message-ID: <20230215104321.1665505-7-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
References: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DB8P193MB0712:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5ece0c-9bb4-42ea-6699-08db0f4154c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5iMoAV/SsGHQ5I0wR3wFiziT2tgRK9Epd3aN04Yysji82jIoIERTLS2+6txA9EQNSKQ5+xQMbk3UD8OmNa/gqB3dWr89wvMcmvRzx5TbaU+fSsd6PuaJhnS2QXn05FE2dQUyq6JrWTQr1UvKeKMdRMwv9eK+kW/FYvHuYc+YqQbStowa+y/lpIkHYL0tLLU5zBRcx0uLZnof4NZ/eP3Nh/Ck7aCwxFvQzt0MyKIOtU3NySRimO/R6hbfw9n7BHBrxtl+HuYkIlO9v8fqkwjJ4MaCPVHkQa7uhLXynpKtb8X4rCZnUS8WU+87jLg/tiMQVJ97l5dzWDDVVOwsrOKGgJG0/jPyTvsOy8Eq0KzFMIc5ilUyNkmPEffZqq6KBjNfMr9FZ6xkHfnMMkdOWL5QErfZAYR1xQw2MR+piJDkiDhk+UAJbmIztuGKVqYtegH3AziNSli7KLdto1hp++c+yQaD2gqnhXAUvNhBVtRx0JrR8YIZG8ay+s7mG6BKHlFceGAXGqdubW6TlRUB6PbOyx06cNEqlq2ZLjCEi5CcgMWJSf+cqETFmNA0I3bloQLR4xLjxjcUkJKKX8owSMieLKrlVf3QawkpOiSPoet1N0tqQST5G+FBNNNknuOpNLPC3aHDgE/jdzF9phk0ou6rccK+m+zsZ438BLMebUILAi7pYpG2hBf2QUwjK7EEXYaszioJVO1POVy5buV4kwlp5w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39850400004)(366004)(376002)(451199018)(186003)(6512007)(26005)(2616005)(6506007)(478600001)(6486002)(316002)(1076003)(6666004)(52116002)(66476007)(66946007)(8676002)(6916009)(66556008)(41300700001)(83380400001)(8936002)(5660300002)(2906002)(44832011)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g3EI70CZRquo4QllK9GsGD8YS1Rq2DQZtkt2x0nACnHGWvSh1fyvYc9aC4AR?=
 =?us-ascii?Q?YIYqPzLeVRJmGhrmWsKVYUewc7F2ErH+zE0GHLXPWP15nros68p42b6HfV+4?=
 =?us-ascii?Q?nG9coHunmPZSbKzX3wsfQX1Ldcvqh1lcfAmv/TfoJuEXzKczNm6l3EXKb7EW?=
 =?us-ascii?Q?dGqZfjfQeosiQ2jPNxU+YFZ/n5NlSrlpI9mYpVS8lDepTMx/PZALs1EhfBxr?=
 =?us-ascii?Q?Gke/gADB7NPjEDLkpRhIL3ruDHCxfA7l+CYZAf+IJVfqT9twhZtQFPgZgQgb?=
 =?us-ascii?Q?67ThElVmciMDOwJTVrlCepnNw5SoQVK5VYdqfkRlxOFeredlEcSb8JdhEHT3?=
 =?us-ascii?Q?RjugEP4GG55YdIlJPXANixBdeqzWdRuoHjTBLn5pG0TkLzMPcRwdZYEWNxFM?=
 =?us-ascii?Q?jzYR+o2K7V6ACamzZ7wokDCVcSQIMXMUNjVqmtxN46dFAOPr4x/cX3YWbTaO?=
 =?us-ascii?Q?cdk00UqWkOTEo17mo0y2OFTGnzuw15b0GWkAr1vsqLxek6R2u5H7jYqOBj5I?=
 =?us-ascii?Q?k0XeLdQ7eW6p0QoR2/DG6ccYO3kIzSvfOewCiEuqT9N92LnilpGN+z/xelut?=
 =?us-ascii?Q?cWK32u9cmCUEaOa7k6l7MTIk3QwrzsEdMxSSRALx6FvOvLDVgH2fTnoh4MyU?=
 =?us-ascii?Q?s1+vGGdTBKnPXGsTbHD/CLEdDuQH7rjGmP8h2MODdOM4B2pm/idvsJ6seVll?=
 =?us-ascii?Q?s1kmPUxyy+3whIf1d2vfoVf2hVzRAHlrS65I65cVdHa/oeDjFuXa66v9aWx6?=
 =?us-ascii?Q?RrVsTxL4124CVuPEDEw1xRtC6k2y/naUDeImvVDpmL1xJyU5DVcX74fPdrQJ?=
 =?us-ascii?Q?PEGG6rM7PQh8lJm/S8eHnFcGuQLhvuZ2hxhUoSLQ1TR4WyJ/1bkqEiuh38rm?=
 =?us-ascii?Q?/kfQ47ncjtfpt5pSsLC7hmcn2vtcdrj1WwTBXrvxrY2h+g7OejDxBbCN3slt?=
 =?us-ascii?Q?g1k+7uDH8LZSV86ukgiSWtmdSu9ZZk6f50hwZzcsIoSxFdBOotxVtVewpHSU?=
 =?us-ascii?Q?dj1LhO8wVagdtBEj0Bepmd5EiiAQL+0eeQKg1E6AF3st57XpepjVfcgJhNqi?=
 =?us-ascii?Q?aT5uzJZ15Fw2pijrV3fytP/ido2i7D9LdEG+JsdVH8YIOwG6/xLO3VHjQf12?=
 =?us-ascii?Q?xES0XbaCpchVh6l0ptM7AHINOHZ3bkt5jU6aQNtS9IiLc/6lfFBSP2yIqOLt?=
 =?us-ascii?Q?0Dp6jH8cMHVbYzze426yDfoyPjH5eSyyTRe1QZrtIAkBgLyrf7rlqMZ7InDX?=
 =?us-ascii?Q?1nTgkKqSgAcYpaZCjNfF39GA5P1zzupzpXHr80VH/Rqyjvcd5pdw4E6NQsIM?=
 =?us-ascii?Q?uKBMsLm0TXnBj1GHcSP1Tlc1bu0bjALwmZZxTNy+z6YHN/LXAgEdi5T3nFWD?=
 =?us-ascii?Q?tYEFE2SgLkAPYaa4pla9tbkX1CpG+JYeJfiBJ2H3MIV2hcbvmhpsUliez4DS?=
 =?us-ascii?Q?lMy3aCmXCJPq0CuUajUNSDLpQXE694MTd0Deb+A2KGiGdIdl9VXrn+tNzLKb?=
 =?us-ascii?Q?34bD6TvOUrGOTHuVa3UCnNoiaHbqtJ9Vei/iJKstYpI+EgAkzvulfkCJiwwR?=
 =?us-ascii?Q?Zwju0hi4i69SxnSxl917Ynuzlyvs6awKT9FX4vi48rYX/4rJdYETzwvZ/FKk?=
 =?us-ascii?Q?LQ8pvxa9+IE1nnT2kkQ6IeA=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5ece0c-9bb4-42ea-6699-08db0f4154c4
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:42:27.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwQ0PwFVwPw3P77f768RdVsSl9Nj3X54FJytsDlrWCFtM0ULN7awKafxGadgWzspdafA1wJNXnK8/skLmdCGLmIubuwrrNVExtaHfEu2kSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0712
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14430

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We have to prefer one multiconfig over another when deferring tasks, else
we'll have cross-linked build trees and nothing will be able to build.

In the original population code, we sort like this but we don't after
rehashing. Ensure we have the same sorting after rehashing toa void
deadlocks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 27228c7f026acb8ae9e1211d0486ffb7338123a2)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
---
 lib/bb/runqueue.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f63a2191..2a1299db 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2503,11 +2503,14 @@ class RunQueueExecute:
=20
         if update_tasks:
             self.sqdone =3D False
-            for tid in [t[0] for t in update_tasks]:
-                h =3D pending_hash_index(tid, self.rqdata)
-                if h in self.sqdata.hashes and tid !=3D self.sqdata.hashes=
[h]:
-                    self.sq_deferred[tid] =3D self.sqdata.hashes[h]
-                    bb.note("Deferring %s after %s" % (tid, self.sqdata.ha=
shes[h]))
+            for mc in sorted(self.sqdata.multiconfigs):
+                for tid in sorted([t[0] for t in update_tasks]):
+                    if mc_from_tid(tid) !=3D mc:
+                        continue
+                    h =3D pending_hash_index(tid, self.rqdata)
+                    if h in self.sqdata.hashes and tid !=3D self.sqdata.ha=
shes[h]:
+                        self.sq_deferred[tid] =3D self.sqdata.hashes[h]
+                        bb.note("Deferring %s after %s" % (tid, self.sqdat=
a.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqda=
ta, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=3DFal=
se)
=20
         for (tid, harddepfail, origvalid) in update_tasks:
--=20
2.25.1


