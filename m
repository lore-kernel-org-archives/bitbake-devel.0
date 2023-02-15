Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4819EC636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web11.12143.1676457746724761121
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:42:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@criticaltechworks.com header.s=selector2 header.b=srT+ysbU;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.241.85, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1WsK/s0Bb31S9z9heVmuWL6m6jJrAWgedtpcvK4ESH1A8JkLJXlOFfh7UzMNI0bBHUv7VqeZUcsV311uUNcsdkmT9OyBQYFM9Ekvdkv9sOl7GGA1n5Tg9RCR3A3UdB8Nf42kkfbcAuHYDeqWsMaX08vM0a4XUpDmkkQ9lq86bea6MQ86QI8YHMfZZJGjtDZjaRMrCRUUZl9LhdHhxeTI1gZ/kQCz8p/DywRjWeoDKOCcfOvRjSn9jzpEF8MTguGBwnU1xQL2YQwBjt02KMVIj1CWwsAUFQ0WurvKNq3DNd0fnEjqJnFeaE9E02YY9WJZezfeoIuLC8Mj9T4z+UVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtEOaUsvmqUyNdKzWK/Gq7ckd77NWpiL8I6PNk6uRLQ=;
 b=Hv8+8EJBCgE9U38h3UFdTr60Q1+k0yvrouxMrG5eQELcnLSzpHaC2RDXNXxFPtPbnQW86ZMr8AHaRIWJ7rWXpALie2r4oL4U+24lXqfREEqC4ASBOlqsi1hx6Q1gb1onPHx59aSoAqVzExYbTHyDh+xfDqeo8Jz8l9gwadAq8lAuvytFLPwAiAi2C0zEyr5XtI9rHuPVhEWVlFIQiR2C0DhKG6IqzsEVkf5S1zavxvTCx/EVdg9+x9NKV7z6E9uW10K1NSpZl2rnqpSOt2VjYqX/qP4VgHpZBbLoOaNFNR7mB7lKsp5xdfu5bMmGrrw+QRAKUCcx5SNgYyEBvguvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtEOaUsvmqUyNdKzWK/Gq7ckd77NWpiL8I6PNk6uRLQ=;
 b=srT+ysbUyrnOXtr3Kbx+WB8J7l1Doe03pbBQXmcc0f1Sj6mdCTXle6K1pbMSCiLivvis5yntgjP+IIK098LdVKa8+hpKIuWwtl/Rj6jV5FdqEoLCNNuQvpFZHHdCcuSyjTt8V1upNL1pY2BPsCpTuLIsWOKNkEXGTW2//926ePFbicimb2xU1jZjGd6fl6craOcA7IeDJsk3tN+iq+6SNqey5WCsu1uaBPA1c7p238YMxDpqVF/KKW5YnSE8vZaAs0kuAexOWPTAWttxfejXVrOE1awjWvfdqOmhQa/2veZ+JCaGKsou+JmS70TYkL6rfQRKJL3tUKnhAItxlzdBbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criticaltechworks.com;
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13b::14)
 by DU2P193MB2034.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 10:42:27 +0000
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8]) by PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 10:42:27 +0000
From: "Fabio Berton" <Fabio.Berton@criticaltechworks.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.46][PATCH 5/6] runqueue: Fix issues with multiconfig deferred task deadlock messages
Date: Wed, 15 Feb 2023 10:43:20 +0000
Message-ID: <20230215104321.1665505-6-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
References: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DU2P193MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: ef37e3fa-18c7-40f2-8345-08db0f41545f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	13nr31d+DWwQaZGLsMp2u8SpeHlG+Jfm5fXfw+mO9hCX4JpNv4HG7MwSSRvKOyhYEHFoO4VgnrAQrpHC8Cdri5IaNxCpmmM4LfbHbcJEbZbbodTlXXBHQGAMklRrLJRxjGc371QXRsnDN8isn5CA5Z7KnuV/Spxd0N+1tiaNE9SEIGakT6mKLq5q1i/WJF5iVdDDc8IJ4KhPAmW9BkVXWU8D0towfNhh/Lj/ucxEOlaHIdMmbPl3ZkMC917byHNXtp74x/lAQBgdJPgL6HeVT8JQKa2yPLPphbiNueH1B6OcsouiFBFMNvsXYBFg3HfeQmnkW9nAze5tA6hcIz8ozaOedsHJVuHyXh340KgZPpcRbZ/PavHvV3K1byjLZi4ed6Q1YOH0FvsgT46q12sJBGUsdsUqbxJzLSqijREKeMpWuGEkrsa4OLkdyx1OmChE7PHcIMMtJR0xGnqdaZgl+ipXGZ0V4AG8cdMwIoZT0fX/NI+0/T769r4jLSthtrDO1qtt4mUuNRDNszj9+JjEaRFX2u1wIzhGGRqhQlLj26W0BpAn0JmCDLObLdejWx4R+sQOhnYbjxW6p5+KCeJx1uitrUKcB7Kmq/mJTrLgd6f6+4teuGDFyvdi0OpFjRTpRbnOPLje3+vOuvIwM9QXmvo1Xq2ZFhZ32/g3NNhQ5HXaBsVDT2TQgP8StEtGXCUCeknVKfVNEzoKKhjMEK93Yg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(451199018)(83380400001)(478600001)(2616005)(52116002)(6486002)(6506007)(1076003)(6666004)(36756003)(6512007)(26005)(186003)(44832011)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(8936002)(316002)(66476007)(6916009)(8676002)(66946007)(2906002)(66556008)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wg/Exg3ho0QSXj7Hms+koo/IGu3CJQv3rMeRHLwVWlP59JDHzyEDPwPzhghX?=
 =?us-ascii?Q?LhONWVvx745IxPDWZ8TnAQFfvwyuzxbygaiElvJFQAVjEucdUNyldqhUnlvC?=
 =?us-ascii?Q?mj8CKS/+hV73Hq66H1eneTrfGIWLq0M/J93hT4IYfkbspgLifJEfOEUy4iBb?=
 =?us-ascii?Q?fVWYvzAD1TgWzuaKVwxak3fixR/2qdl+xEDgrTuW4d3oDUlTpu0rPVFIoQ6Y?=
 =?us-ascii?Q?m/XV0qiZND+oUcHeA7Txe/sIsVQEu40Iwna+YX1gJU5GL77y+PdQcXE34tx+?=
 =?us-ascii?Q?+jcySTyagqRsKRCmejEDDhVtd2sWgoCmesGUns0xIemA77HyQJVGUovpIKqW?=
 =?us-ascii?Q?KNS1DTouU5CmAEAw95vHEYhjRU94uAfuOtxsGt13I0l4JgvANZcUfAli9Op5?=
 =?us-ascii?Q?3Z5KZxTuZvPDtmOOrmPIb5Nd8WqjL9fe+KhyhPS+y7qGYX/FHpGoBoUiI1OG?=
 =?us-ascii?Q?Yrsufp09ZeLba3mNh5QHcMBpCw3+mKPavfT5e5Pn5kMUIw7nSFtjKlqprIjE?=
 =?us-ascii?Q?Y5xbNRj2TKbzx0vH+8jcx5I2NBIiVDeAuZfBnqI05QMQJX5L6LFD1SiIrVcd?=
 =?us-ascii?Q?gVZeHdsgvB9oACu1W11z+zFFNJ8WOORF4/Ws3kh0QMuaajG5Jies+nt0xPDP?=
 =?us-ascii?Q?Nc/DdKU9s2FNMocTVTJdJ1hU+FQQESyzu1/FLL1iannE2X11zWmf1TI4Z19x?=
 =?us-ascii?Q?lCnXJoJ6Amc9u3k6UVcYaWVclMabkPBAb9s/30edPWJw0P0BFasuzf5h9+it?=
 =?us-ascii?Q?r0xJ+IW+mGLpfv71fdv9msPvJUjlMw7etoEu5Ozurv6edlY9YV9m1Dwlcdxy?=
 =?us-ascii?Q?eWitEpRALsRLDG04ssc2e3CBYP+UUpttuLO19LVgRZXas8+kN8MSu1OmMMVx?=
 =?us-ascii?Q?KerxSaQzUWtTEUW1WG96Ah9eXH3ASVOx01GH8PiYXCKOUqiPFEZbrgCodJuA?=
 =?us-ascii?Q?WRkSBZVLsKH0Sr1eAYukMfbA4GbcQeN1Y10KaQV7KTu2fMBz16pVrj+zIhy2?=
 =?us-ascii?Q?SBiax/fjaa3Bp+pUpuJgzXW3OPRzh3+M6BUitszF25Wc+nD9x+uD6igj4aMs?=
 =?us-ascii?Q?2QVQ+TKQ8SaSVCNsfIvKKgWjIoIuYSeN4Ama45BXoQvqHp2ZVTKaW++wiKBp?=
 =?us-ascii?Q?7EVejxe0PaVFkGATmaPQIxJFhJ6O9M3gFn527c3Bpr1/i7LkW+EyBeEkrBV8?=
 =?us-ascii?Q?8WhQgqRU2HPjERrBRxqyyYRMLY8WjpJAeYGtgrudokUDHAtVe54js0e8GNM2?=
 =?us-ascii?Q?5zRTCqgbmY04PMchRBVElgY16E5QqBCyIwUyatqKoxK/FDSeAXh2iSVlZrSP?=
 =?us-ascii?Q?TaKPY1/acjk40XJosvoWab258xtNoZNtMJTD4I2vbTFMA4yp3lUqQDwN1X1a?=
 =?us-ascii?Q?jOj+Yi0HzhzDABliDpk+bXeBBKCQ1x4nSP42vZRhK4U12B7nzAmx2r8pjh6A?=
 =?us-ascii?Q?P32TxJ9ErWzK7UErDyhpaGAuusjkRFWSvF6flQ+6QPAL8zWRuW4KqzefCUUR?=
 =?us-ascii?Q?jFHW9kWWqG/hLx+7irxJYTTJVLbUav/NENnoJ9DAnpmwGxaLZLvjX1WOqkJp?=
 =?us-ascii?Q?aiOiNZC5eKGrmkDTdI/hKPQ3bb3KzFGFCS04jdWkl9bcbTcxR+UVO1whJoFW?=
 =?us-ascii?Q?a7p4VxWvR1eOVirCkeWarN8=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef37e3fa-18c7-40f2-8345-08db0f41545f
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:42:26.9693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFgPGOaq8XrdM8cFSKqEgkV6Zl5prDmLyl4pPhPaIMf0c4dw5sIgoojxi0NTkqXyZPJTanlMMCQT8OEMVNR0n7C94V+ktugGsDxwA+c+IMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2034
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14432

From: Richard Purdie <richard.purdie@linuxfoundation.org>

In multiconfig builds with large numbers of identical tasks, builds were
deadlocking after recent runqueue changes upon rebuilds where there was
heavy sstate usage (i.e. on second builds after a first completed).

The issue was that deferred tasks were being left indefinitely on
the deferred list. The deadlock handler was then "breaking" things
by failing tasks that had already succeeded, leading to the task
being on both covered and not covered lists, giving a further error.

The fix is to clean up the deferred task list when each setscene task
completes. I'd previously been hoping to avoid iterating that list
but it appears unavoidable.

[YOCTO #14342]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ae24a0f2d2d8b4b5ec10efabd0e9362e560832ea)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
---
 lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c7f50fde..f63a2191 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1975,6 +1975,12 @@ class RunQueueExecute:
                 self.setbuildable(revdep)
                 logger.debug(1, "Marking task %s as buildable", revdep)
=20
+        for t in self.sq_deferred.copy():
+            if self.sq_deferred[t] =3D=3D task:
+                logger.debug(2, "Deferred task %s now buildable" % t)
+                del self.sq_deferred[t]
+                update_scenequeue_data([t], self.sqdata, self.rqdata, self=
.rq, self.cooker, self.stampcache, self, summary=3DFalse)
+
     def task_complete(self, task):
         self.stats.taskCompleted()
         bb.event.fire(runQueueTaskCompleted(task, self.stats, self.rq), se=
lf.cfgData)
--=20
2.25.1


