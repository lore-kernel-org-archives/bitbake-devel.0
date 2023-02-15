Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6835DC677F1
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web11.12143.1676457746724761121
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:42:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@criticaltechworks.com header.s=selector2 header.b=dW61MZjm;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.241.85, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izv6eAqZUTH9Q8sQd5s9/0wHaFO7C9mHItrHO4aminUkqY0nPEOi9vnEm6vLzjTdTTr1udScz0KYW1Irwm79Z9rtMNFAn4ol6QnuezdQiUsU2pXXwFkAGd8nwilJtYS8kn1gkFD6RIwuK4Rywii0i3wzqygiW8jjoDEyNnISp4mkOQ4GjKE8KatOUm3hMJih/Ntnb0ACxOX8xCy2RDQl1ivMWuTnFa27nGlKtWJI8wgLurQ7jOceyVa+Yzqfik/kAJVHP1OtvB8rgnD9TrybjTnFjq4tJMSRdQ2nmELosJ+ZDkLJXVWITmjO+xvpvFxYIU0PjldNVNJ6cuPLkgBJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miHKIMl2vakxB+gQwYNNBV0XugD6hbxWn7nC9QC6mOk=;
 b=aOpdkrEvZYLH5L84inobT88L93XFYvl9r6n16bHXtt4HtfORByr8ZXUbnOqJT9iesR9EQFebP4tU3Nliq4Gic6WOVSOOyY2T4vdhgLvxxWAmpMDMp7GkycxFuYr4kTt99ofgK8l3LY+hIvqLLGrRLUmMBnYN55ZoPA/saT/ImmWE+ZX2bkQAyj8hQTS4sE09VIiObr7tHmOiW0COwAbGoTD+QV6Ca0Q044VzHtV5Z3P8R5vJ8sAQaBmXJELg4MhPuKNsosIj1l3WK2MqQFsvJ2cTZisJ64e85hcWZ4ME6VU8cA5E0N2TwUA1B5qly0Y55rLvBI1CH1Wtr5Mk2gpKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miHKIMl2vakxB+gQwYNNBV0XugD6hbxWn7nC9QC6mOk=;
 b=dW61MZjmXiTCGyZ95zzdPhRzL/48MsLXW7jBbOeoCPAcdVpYvVrZ1QLnomGtI+gMzdiRVK7lB2Io/PF84Z4n2qOENQVa/1T7nQIeU+GYWhLLIFxiFUPuWHObOn6og6hkBqMRNpj9VnDHLUOJP3WHGM9aukBjEWq3Gzm4NM3UurlOG/cCirY1cJ7/Q+gi8uz/hmunsFaRmgjCP75we6toMiyLP8IGUobqhJ/NiW+ycnRp+vUxJ/iFVcStPo0vpDp+2+0nrVL74tUECFXUJGdI7OOIQ/bhtB+kVSi6/gyH1hnaigPMyfvQvl97gF9WrZ5vGqKWAEx6t4SRKDc38+VVLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criticaltechworks.com;
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13b::14)
 by DU2P193MB2034.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 10:42:26 +0000
Received: from PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8]) by PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 ([fe80::2d2f:75be:a1a1:2ed8%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 10:42:26 +0000
From: "Fabio Berton" <Fabio.Berton@criticaltechworks.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.46][PATCH 4/6] runqueue: Avoid deadlock avoidance task graph corruption
Date: Wed, 15 Feb 2023 10:43:19 +0000
Message-ID: <20230215104321.1665505-5-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
References: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DU2P193MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: e56635dc-1ec8-4840-615e-08db0f415416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YQV1lMwdLJk4UnSmo6ma9pG4LKBvNaO08IUyo1Ia/QLMrxon1a0vA7eA3ZTyguibit7fbUIxcs5Z4PPzKvXTz3HkQKEZxaI4sHLyCmpdExRAH3CfJKTOJylOsod5229hZqHuudonm77+u2TDUQZKfbjIP18BmtV2DNx1wyydtKf1519zOZtxiD+BBGz7JRr+uAWR7WQ2BVeqUxa648R5IHmjajNvRwa0FjiG7ChzRNfQgCaUr3TScoA0OAb/00+cORf6Fzg4tSRyke1G+oWoExMDVT0lcyh6GfLDtfSvmWz39gQ6BE0XlTIs5sHNbCRgu4CFX78Df3PRJKmmTtcI7RIFmrbLLNmMQs8gvHCZleg6Vn+mC7eV2QxXsEYedo9Rmhh9LHHfaZFpjYfw08Fy5yXWPEUn2oxqLrdiWUW8LoI9/ZrjRUVhiQpYs7wmXJDaDIv3/KMFUNF+CRyEAMGVp4TAVEK/5HTmAKyJND9WZ113+naBsqy1f5+kQvCOdtlOsiuUU+OvfqbuNw5d7fuBy6HknLxV75wXIR0F4my04hZifpE6MM4gECTMta7exUi/MQIm4nf5fMQS4cwJHy69B5iIHof2x8fBu/f0R0PCLv4Gb43vzbybI0YtwHEsJC1diUsBPwMA2plfdlLugGFjKLC8QsY7j+Npv/LrTdmTSQUQSjDx91H6m8EnRzIjMyItH2/SeDas+dz8aJxsve/xeg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(451199018)(83380400001)(478600001)(2616005)(52116002)(6486002)(6506007)(1076003)(6666004)(36756003)(6512007)(26005)(186003)(44832011)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(8936002)(316002)(66476007)(6916009)(8676002)(66946007)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CwNjA3iwso+Zce3Of2HqL7QLcyMqMKPMELcgp1tqW2yjeh0OXbZHl6URBPk2?=
 =?us-ascii?Q?moMIyKZjikj66G8xGpZnX/1R7YcCZUPHoEJz/BM5cDBm/IvqDymztYRhSo0U?=
 =?us-ascii?Q?FZ85PsjlLkJY9jUJjqO/GzzRXqUeMBe6LtI3iU1kV/gZ0rM33j3eVIqW0kkV?=
 =?us-ascii?Q?QAehzSl9pm8FkNPfPq0cjnT+bXfcADIm2f0Fu7mcRWE798bN9BuYDIH5oAMv?=
 =?us-ascii?Q?3Ey4bhYl5p203dqIpehC0g03mNtjmMpVBgK/wu5vzZhm5YjdyYHhgE1NpKlT?=
 =?us-ascii?Q?db3d6+2LpayhinM52I+NUJeXxutGPOULl35Trac2jDINrtcP/5ITaT3thvyU?=
 =?us-ascii?Q?SVaNnin1Uj28ZvTr1qOGJ/by2+MS3EnIW4qO8mtgJVOuycxYpCQofl0+p3pR?=
 =?us-ascii?Q?Jl7nbKKe2AyjNXvk/FD6omn/hgXhIlJXejfmZuLiK21Q5AE1Y8RqJB0tBbOK?=
 =?us-ascii?Q?+DCwtYwWqILWSooHOWes/+/fHkErIEtoWORUE/x9cOAJLjugr1r+ewZTQpMk?=
 =?us-ascii?Q?s5tTNwAoFERu/e3oT28x3dtuw03CJDBwNJvA9riIOniybhgphX+8cYMk1sZ/?=
 =?us-ascii?Q?UyS6OOy+jZffGDiSD69PiU7CdCzB7hPiRH9QopAWapB343qjkK4hLeVW5R6u?=
 =?us-ascii?Q?irBNRoXfFtr27+EcWBWfvFIizi8wgGn1eu5ICsLEnnsSPUTKes8u2XIJvO/t?=
 =?us-ascii?Q?68wDc9ZQ3Vi2IiGpSTsJVQDFAN4baupDBQu4xM2JzQ5S24Ys/TNPRjQMUUs+?=
 =?us-ascii?Q?h6VIghONwtXm1BfrJaq4k5IYskqga4j3N2bHQQislL/cD47eUgSyFGEdkXv2?=
 =?us-ascii?Q?g0vJOkHiZGUknEhQWCTnuv+ji5ZZoUHsbgRyGxlJb5gLC1nvfEAFmTtkrN5T?=
 =?us-ascii?Q?bZEgG8LvhEbhY6MIExzlhGwz+8owRcmI12WJX2p2SKWs/6rQyaXnNDSmAd8L?=
 =?us-ascii?Q?QCWaJSXtWpyQdTGlMoOUdpmWtaelk/Kca+7+PHJEMpdVxpobbIDDgrwi7M23?=
 =?us-ascii?Q?JW5oJeIMC+4heoh+xX4UJ8rR2h6G93G/i5cXrgXDyNywNlHIOXGC515wtZOV?=
 =?us-ascii?Q?/V3Z3T3haJvQPZLUoFodT/oviorz6MPJHM0BAxjnGBdfPYnuX3beDBRY5+9D?=
 =?us-ascii?Q?e4l8HJOFsaGzASX3w69CNXqt+ZywQNwF50lVnEJpgmmDoOK3QavPCQJeoDkZ?=
 =?us-ascii?Q?TEV5Nr5hkY0YITSmVEoMIZBWEAWDUiNca85LNigBas+Mdv2DmIX+q0LVL2a5?=
 =?us-ascii?Q?9YQnVkLlSBTUqflDcswil4l8Vxxch1c0cOMs2/V2Ux3HFZ2Vz1eiBfTGT08l?=
 =?us-ascii?Q?/9wDNkaf8RY6BQZWPv1d7HcVcR5HwpX5SEi6zGbTouR2ot7SZhkLZEeLkElZ?=
 =?us-ascii?Q?lUjMDQchNMlWr+wSzY2I7rShGjs/l/joUb8eb/S2YiW1qnVgotvtUu7l0Epw?=
 =?us-ascii?Q?WOhm/e9hrNfZHPm+Bk/ARgHuoYw+g11N8KcfTStMn2p/IPIK47GrdGUUfpkE?=
 =?us-ascii?Q?X/0UGNIWL3oFc9m2Ir84dfDOn54Ga09dft8MpVaBXiJncIBJrCA/JbSkiTQ4?=
 =?us-ascii?Q?EcMS101CK5cgIKYqfM9pRdHsA7E/MftINv5f2/x5QYt0u9N+nx/JxmUoo7r+?=
 =?us-ascii?Q?sVdM3DKlkvwo0nZ8k4vKQhU=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56635dc-1ec8-4840-615e-08db0f415416
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:42:26.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QMP6ydamzN5Dua0l2ci/qlSmW7ow8aqMg1SyZBCA53GE9k2/TImGEMNx8y1ykYC3vcXc4WctLSqA5CI/bB2fhlSGODUCWA+ge5kTGhUBsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2034
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14431

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the deferred task deadlock avoidance code triggers, it could mark an exe=
cuted
task as failed which leads to "covered and not covered" error messages. Imp=
rove
the logic so if the deadlock code is triggered, it doesn't cause the errors=
.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 51bdd6cb3bd9e2c02e261fb578bb945b86b82c75)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9efd1c86..c7f50fde 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2234,7 +2234,8 @@ class RunQueueExecute:
         if self.sq_deferred:
             tid =3D self.sq_deferred.pop(list(self.sq_deferred.keys())[0])
             logger.warning("Runqeueue deadlocked on deferred tasks, forcin=
g task %s" % tid)
-            self.sq_task_failoutright(tid)
+            if tid not in self.runq_complete:
+                self.sq_task_failoutright(tid)
             return True
=20
         if len(self.failed_tids) !=3D 0:
--=20
2.25.1


