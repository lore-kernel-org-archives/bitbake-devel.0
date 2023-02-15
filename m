Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D32C636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web11.12143.1676457746724761121
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:42:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@criticaltechworks.com header.s=selector2 header.b=Y/Rn7MzL;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.241.85, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huHMu1k6V9cGRg6q1hRp5I7UKxvY0x6rd0xCfuRluAx9lzNyb5Pq7UQmkkuHic/4f/UJQRjysO0RcZ7HolGkcFK68xiUO2CplnkEqaFz052BQv+0rM+jUc+/yL5JLyX+gkWdtu4pCbN9AE08L+xWHxjmNqfWC6nu1wKxs2AoAqO3N3RGu23zMWR6IZkw+5RjIxsMvMqv4fZzjm5EWefzB9hSJLgGLLQTkGACLGFq3IaHbT+NdZoM8lNEa9aLNhz9MIhkM7B07oGc/BXedijXkU8gt2tL8Zvnt8NfDNXQQFCz+2Qk9Jp3N5XqrLsHyGtZFp3f66Wt5IR2tjHwM0dHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mivc0Q2IimyZP1H6e4e/Q3m865Y//aHybwU23tKd39g=;
 b=hycBYYI/1ZfdQNMg8i+RbbRy1jPo9lisu+Wk645WmX6fe5h6BzxaAcnBAka+vaUf0A4VzFsB8M7mKbRZ1aarQy43yi3qUyWDbQ1HwT5t6Ojqeh1GXi4XrVyN2utlWwsV0G20LXsoIFH5mC+gxw4a3vJy3Y/srOtyy3vO6fAIkr59V21wRMMa95uZchfvnC0gI0iPWGOnIDXg28Ox14Vy0oMUcz3oxec+zUXyPWkwqBG6tZom/k4JPtiKsAHjakCmILF2ZP0tnr1vP9144YK7YRwRFKt5bcqEd/mt4F/dQlsl0K8PkeAL5ppfLIxXKtU32pQFARLmgStJQqRVyGPgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mivc0Q2IimyZP1H6e4e/Q3m865Y//aHybwU23tKd39g=;
 b=Y/Rn7MzLXstsEx2iECnH2//QnWiJkP37kcPzdtV+nlLAfjrDT11sTkU6GNe7jcecgTjRlaVqpijr7nMIMbJdXwE/mLa40Ojj8hi7pfHpUFZUUnOP/vwPxdMVBrzmlOQjbbgPIkRzd4A+cBJgOk0Tj+e4rPlv/D6YL4AM9CmVGdwmn5ziYbW48gFl9YlI1b08tsPOJVwolGTfccFbmN7cbGRHvpQmhpUuxBRJEJMVIiyQVeyE+/fWDS3JSSfbBeWzp7HZgLpSe/osVQUBDoKaJthxoEkMLBeYr4MiU8pcWkri3qk8aMk80PKNd1fmkfctVdZp7lf5stRvXISW/3xB1Q==
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
Subject: [1.46][PATCH 2/6] runqueue: Handle deferred task rehashing in multiconfig builds
Date: Wed, 15 Feb 2023 10:43:17 +0000
Message-ID: <20230215104321.1665505-3-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
References: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DU2P193MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dee73d-3ea8-4f6f-f8d7-08db0f415384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wEezKxKaOa4cXyXFj5RsOTlRK1X3QsBMmFhfuSZLHqKzPEu66nV/9JPfOlYx9fMN0ds0GfUyEhtkw0xPlvuth40zP4jlavtP9t4gc6LdQAHj/sh4aK+PPnQwc8RK+8cqXtOWzlTKX5C9o1x9fiuLcdNuGKz0WiolifaTsWVqJs6nTrvoaZIlj915GpBrFtTERUGJ5uWx46AyahQi9SrY21g+QguAr53llzVXYsWG7IECFD7xFD2+qycSHSRjXEz7WeuRXp4dxT1LzfXH+yiK33P5ctino63wdShIznKMUb71uE46/Bf8K5zb84Pb07NeIVNzPi1eMPlx24h+pFG7cLngf/76+L99DsJ6gbFXDyMMepA/npj1oKKiZomD7bZdXabzOVMj0kG1Mj9NNCFpuCM536Bajf7UrPXCJRUI2iFrKQ1ZOveUDd0QHnLegiV7h4k2OCahHDCQ/r+/yLlgnfNbtWZho3QhHklecNx0YVCjMejxrelDaOUAlDIt5ftjnXC/FKrhb+ofC/0Ujdbrya93udIszjK0IVEAvnV5jiIGQTU0s7aFleyd4y20tEoUrLYnCJMYm2PbE+wzgFQb2rs02FvFuGy0+kaRnXs9mpMRQFwL+v/rPdd+9ZSja3iBItSGR2dAGOH+P+mJHpUhbN5SAMy6UrVc1ZkTnE108r6Fy5ZP0p60MvoblIFGQA86pmdR7skoXN0XSEKKqVQvIQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(451199018)(83380400001)(478600001)(2616005)(52116002)(6486002)(6506007)(1076003)(6666004)(36756003)(6512007)(26005)(186003)(44832011)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(8936002)(316002)(66476007)(6916009)(8676002)(66946007)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fCJ0RLUj4sc9oiLuWewNLBQ80P+Un5SCCKkCGIAuwbipzOZhnDzHDxjCYgxp?=
 =?us-ascii?Q?4K/hpGU+cU05g/PfPEeSuZvjZ3zmgEwM1mh3AFH5DGObKyzXpEuBP+/NzcdU?=
 =?us-ascii?Q?NCBiqLuouHJtpIotrAiEOz/uHc22B4pIohqzFNIuZdle3VxVv4QRa6uRbdW/?=
 =?us-ascii?Q?oJIn25V4BiIdjtMloH1tqC1pvx5+pXlVhzTyRldmemF5+cg7Yqj1Sray7pTR?=
 =?us-ascii?Q?059hNEcFPNANzRSJEzP6SwsI9PVQ7h2V6JnhicrKVWxIRO2cSz04/UL8e08g?=
 =?us-ascii?Q?oHMXe+y0Ay1Aaod5BeqWieoi75G2jpM/90luJU8f+il39G4cZJdm3s6kK0xb?=
 =?us-ascii?Q?SDCOtxZRJpVQt3yhIQKUmD2SO9D6FDZbFWLLAzQFjIFDMziSVJiovJfUKrtw?=
 =?us-ascii?Q?Jho2hsrHQE2cTLxz5Z95VDtD3XggR+qWMKGMvtLW+XdBXul+Y8t2SI72IC7j?=
 =?us-ascii?Q?eCyLlK6dUT3dMaTWZRLENGpiOa/4tk49HebicCuno/cnyxyDGlVadOlE40yj?=
 =?us-ascii?Q?wcDzJDQrYF+S/c9GcAcMFS/Y+aR3uwZRIjmiagvacVzgndsTsb5Hmo5KoAER?=
 =?us-ascii?Q?d9MmdWvsk2nOFkQEYFOfbP2vg9n0b0bLZOYVUq9/Gy8XLFfrck+Uu4Y5prXJ?=
 =?us-ascii?Q?hW6zFj5yrJW+fJGyFxZ5UwqSFrA4uoxOvecYtI/ATzY0KBvDp/Xwq/wG5cyV?=
 =?us-ascii?Q?8d/TZzcA5j6FBGNO/UtDPZw0z0kr7JVMjgOKsSkTa8uSsa9lFC0H7FxpEpbL?=
 =?us-ascii?Q?7MPHgSMuJVu2oNW6u44zfTIgrSIJ2mvqRXUhpqBwxmZFGI93Jz/utJtF03GJ?=
 =?us-ascii?Q?8rIYXi7RBCNHd2jWdpdLjFDutN0UWI5tB33xw8gf+iYcEQD0mnEzSu5PBvpm?=
 =?us-ascii?Q?+h50Byz/EBYlu2hTVfw9eFqucaQRLaNzwrBJ/IXr8wzWOU3xsJSKSPIiGhEX?=
 =?us-ascii?Q?aaJWr6FbSrdg/kmLapw7iPAcAvqeEUGXu3Br401mP8QM5Rzf2v57aGMKsWZf?=
 =?us-ascii?Q?ED5BUQPRNJOMbEeyKFxgoQJR2WiEEduSo3U2lco9hMoRiqQK4LEb/fOwbW9O?=
 =?us-ascii?Q?fOR4LWYGgV4FhxDS8ymeVL6GJrIzUFDRvSXFJUn9o43hwpAIhvcrWRETJ60n?=
 =?us-ascii?Q?EAht1ciuHH/MxNTVyTwSL5Fj6j4SyJSBjIJEIc8gttyVdoqTAWEy2tu1ck1a?=
 =?us-ascii?Q?fjMZkiAjgDD1RGKs2cjSHt1O7xbwcDuE90syB5ch150bQvQsYgfbgiK1u/0j?=
 =?us-ascii?Q?IcSRtZwoc+/ODYzLnaESQm60/J1lD+0mCvixATGD5erMgy4VnXfIQRt3p4hR?=
 =?us-ascii?Q?1qeU69nXJZ7vpsHj9/bw37uWw8o9GzzYKcBtGww1ZQFF6nv81Q75TqCz+8EV?=
 =?us-ascii?Q?EEWT3QIz6bUx1v9I7mxupj6m5o07O7OeLpeA4diE0vB/CUzI76Jd94nmZujU?=
 =?us-ascii?Q?MYzkAktTCSvUwd3J2LlHqxkrSy1y9uutrJlhnIDVuE8SSgyl3F1PCbX8UGh3?=
 =?us-ascii?Q?2n5Dfw0oNnFhdFKdL9drUxlwifKO4fR0b7PXAHlCUWnu/ymHhvFQturPkvpj?=
 =?us-ascii?Q?LFozrxFX9j6MGbzH8+JS1oFQH36ETP3qFfc7v0TQSdRsPIBqTYyuOKIf2xgQ?=
 =?us-ascii?Q?Lp0HutLoF65zmhmYp37nlIs=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dee73d-3ea8-4f6f-f8d7-08db0f415384
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:42:25.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwmPun5FOuS1YyxlZbuoceL8Fx537MNFXnenTqsaCe/M3V9PgQ80OLwTfW9kEKkx80sTgMXtcZcTOvusi6JjKLtrWlqMv9OMLyOXqvlSVdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2034
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14428

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the hash of a task changes and that hash is a deferred task (e.g. a mult=
iconfig
build), we need to ensure that the hash change propagates through to all th=
e tasks
else the build will run multiple copies of the task, sometimes with oddly d=
iffering
results as the outhashes of native tasks built in differing locations can c=
onfuse
things.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2db571324f755edc4981deecbcfdf0aaa5a97627)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
---
 lib/bb/runqueue.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f82bc413..a437aeef 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2348,10 +2348,16 @@ class RunQueueExecute:
             self.updated_taskhash_queue.remove((tid, unihash))
=20
             if unihash !=3D self.rqdata.runtaskentries[tid].unihash:
-                hashequiv_logger.verbose("Task %s unihash changed to %s" %=
 (tid, unihash))
-                self.rqdata.runtaskentries[tid].unihash =3D unihash
-                bb.parse.siggen.set_unihash(tid, unihash)
-                toprocess.add(tid)
+                # Make sure we rehash any other tasks with the same task h=
ash that we're deferred against.
+                torehash =3D [tid]
+                for deftid in self.sq_deferred:
+                    if self.sq_deferred[deftid] =3D=3D tid:
+                        torehash.append(deftid)
+                for hashtid in torehash:
+                    hashequiv_logger.verbose("Task %s unihash changed to %=
s" % (hashtid, unihash))
+                    self.rqdata.runtaskentries[hashtid].unihash =3D unihas=
h
+                    bb.parse.siggen.set_unihash(hashtid, unihash)
+                    toprocess.add(hashtid)
=20
         # Work out all tasks which depend upon these
         total =3D set()
--=20
2.25.1


