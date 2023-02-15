Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE2C64EC7
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web11.12143.1676457746724761121
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 02:42:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@criticaltechworks.com header.s=selector2 header.b=zVQvCvbY;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.241.85, mailfrom: fabio.berton@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju75+1xwZ8a8LfhQpBA/vw1uBtdDgX8HedmnFRKUEwVNruV5HL/x1fkEFqDGOxtobaGs7gZ/Ib0lriCm1ZvDoEm9AevA/Wwtpzap8vamPURYgknpMXS83Y9P22WjzJYCzBSRyj9Fj7Sa/Ghn1sz74Nv8G1lltOj/3zuJzsx6bPA1fHCijiefIU9T+rxWpvJljaP8MPA0Z3HlZvYY3QXbmTWVSqtVSCzhOeRjrgjvK+oZcIdGwslnwIriAZguLRWGXGbU/9VUESSnciEiYFBYIv8GV1qjBsHiAYve4qctYZ5364tPk5Qj41Y7EXS1aVJVcQeJmUI4maOlSaKqCOnNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQr6OaCpDNdFsBvKZ9VcNiSYUb/L4iB5IH2ykF8IduQ=;
 b=LnOqRek6Kwf5fpNQRwBWXuF+UlFnoeAgYJ6zn833QryzEi2X+0HbdlmrCx3PcVMEv1WndabUVOdvknxfe6T85RJlnPAqe/04aZl4z0FWlyQ2Wo6W8qGbYEeOKQvucnPJnIi0kooKv597j/nwLMUY7Udpg3VsrBEpfEWK8bPwFiIRQipqaoshEpNscXSN41vGqzc8Z0ej9KyIxNHWihpw29+2N2ulh5anW+U7Z2ORsnzCS/gYhzLJAbubJGNcWwSF5PavFVwUJzPLOnFVTfRxB4qhGTBVx83OAe5HH6MmCTz5sJVvFjKiKSBMMH8lUYcKUWD0DkeCSOQp+sDGdJxDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQr6OaCpDNdFsBvKZ9VcNiSYUb/L4iB5IH2ykF8IduQ=;
 b=zVQvCvbYOXm4jD7mBqYhZ1MgXGOi8B9puc3T0PCV2wM5sAWZppMKMcNh7r8yi6C7PPCvPCc8K7xTk7TIitr6Q82TAoko7Qj5jiWds12iNJNMYLbO6vruZ4rDEXuPZwaOVysU26hxvD42HcD7Mqe6zXxzNmPGx0f4k5OSSvjsL0H0vJXsQhGesJrCeSKG7/LwYUdKXE6t+vxKG0quVUZTG9EHSbdTPtNi1FW1I8bLZu7jTe7hwstllSCR2KOprgE5SNy+5MKz1XXXsCeuuSfZdrraJi8T4kBxsQtj0bFkhlZqWmtBn1jTbVuzfMfc6hbDXxCUeOzI5QrFRkwWn1uWcA==
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
 10:42:24 +0000
From: "Fabio Berton" <Fabio.Berton@criticaltechworks.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.46][PATCH 1/6] runqueue: Fix multiconfig deferred task sstate validity caching issue
Date: Wed, 15 Feb 2023 10:43:16 +0000
Message-ID: <20230215104321.1665505-2-fabio.berton@criticaltechworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
References: <20230215104321.1665505-1-fabio.berton@criticaltechworks.com>
X-ClientProxiedBy: LO2P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::29) To PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:13b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB1519:EE_|DU2P193MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: a29019f0-f384-4ad6-9d4a-08db0f4152e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GCQCzEhgrqLvzptr4t4aTbbj1x7TWDhKZvPkFqmdwy/+Ut9DNkCEcnDjOcv9EVdjLqDyGIm2+Vej+j4qYndXcV0Go1CMXsyP9ZA1uIHbOwb0Ko2KeNXblmNl93MwFZb3Fc6dI2863NCbV8Ef5sEDbrQKYDl//FKltdZvTDK5n+Ce/flj03rvlzlAROLrrywU0lqu2ik+rUyXRIhgxwPF8doC6riI7HHPMKXtCwf3FUhKpfIN5dTGatrchrqYCQQQt2BNUC3Rj0dNRbf4wFwWng+ExB1FMNpUZNRP+NV4l12dgnO+Ru+1hLk8QM5C71fcKJN1xbiX0n3BsmiZSw/6TFqfMoL7ykzFCIWAc4fkaciCV6cwu3o5hkNEuegzUCBDqjHp/AZaj56S/2/5KV6tg4a8e1459F+1iPupBPW6K6CUUQFV2zjoHDI1s3RcKutAApar24xq2DycQuixLTg5+DHqnFe3Ja6b/x7uogP0t6bS2rzR8Pt91xJacYsbR2SzyHcMJJJYM0V6utmG7TDsS8NQ7ZawOUcfnMeAPCDmYzQPP4wvx1SUpHb2zPUzYqVDCR1MaYvUT5XX9O09oIOpCqT/Ndu5Qb7D6xpZZkC9epqJ++lfSd2i1mtcfOaIwMZt2VLQSSMofZPzpnWKf9poHiDIW9RsRh8D4pk4fDcfmjtNOmiFLRNJII0Dio1F/5LheMtV1ldIt2JfVHc7zUfeEA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP193MB1519.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(451199018)(83380400001)(478600001)(2616005)(52116002)(6486002)(6506007)(1076003)(6666004)(36756003)(6512007)(26005)(186003)(44832011)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(8936002)(316002)(66476007)(6916009)(8676002)(66946007)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ioFawyqEkZaV1/8wzkDuTCJy1NSePsGrjDSMEOODacX4ibpiWD1XmLkALqHm?=
 =?us-ascii?Q?ec074//prhYRU0+5U0u5tmHO0HgKi+L8lncU6ravF8gsUg1W5TEGI4tuPA4p?=
 =?us-ascii?Q?u9w4NkCEjEn31r9tXr66DDeZvVLv1hjTZmZxGKVlpM7lHGZhlwtZFiGAqzfE?=
 =?us-ascii?Q?K9agfc3NP0kZrduYgcbttewNfpvTNaIV1ZClVzLRjCl+WesnXkwpDycqqjQj?=
 =?us-ascii?Q?11SEOnH8cIoH+Hkp/+Dx5kzYmrESXMCHJpj4BzHj+fGsWQSEUd43/5A+ZVnV?=
 =?us-ascii?Q?S2GLMLYcJyirRG77BuBvE9ziMDTvKTSS6ADwsNckiq2tdR4gzZGSebIUDxah?=
 =?us-ascii?Q?7MD2qy9HkFZo8tUeZPdA0/VVENmo+znpxUq22N+oh9y0ZB12h2tpfnN5rI85?=
 =?us-ascii?Q?WUPC+7WgABh7KmcdOd22dIakUxz+Wkj1EgSl5HmOYd020S6o+nRPsC46tgrh?=
 =?us-ascii?Q?CNGrVFVMtuKL7SAKDmgtMuCqlx2/vDJn5FmHwjWA7ZXHUuyCOajYPeBmpMrn?=
 =?us-ascii?Q?+fyLZl2ANJGG1IbZ6Re7WYMScyPa+QH74ZPqLq+IaAhxqR/C2yJkubNv8iWs?=
 =?us-ascii?Q?t8cULL4Rn2jCrAu/KRVm5KA95TX7S5d/StrkQ2qgNUDsxCF2nK99rfKgdKZU?=
 =?us-ascii?Q?9r4a4dhL02pcRLpfMqt5573nRCCC+IAGzl+sjT+tHLOixeMC/RdaNpSLmHBW?=
 =?us-ascii?Q?6d9BZB8D8MBKEavNNTyb9JD4VWWSdnKnBU3ySzjUwkgYDNJKHMjyDgbGVFy4?=
 =?us-ascii?Q?cpd8+96CWZq4V7HS/Z3HO1+USJD1huC9/7NnxmCsTyVnabuyq9W3VRedD2fs?=
 =?us-ascii?Q?IcJDW5jP9mPBfyaNbNUkEuYZ75lH6JzhKCN5C+Gs7hU/BKTS6nBauH5evZKw?=
 =?us-ascii?Q?ury0EFXLXoS8icHgJMEklZgDIl+WhnlfNFfRxxdD3jP1N2ybhXAyddhVoeQH?=
 =?us-ascii?Q?mITifP1rvBYi72eL3dIg+1f3xQkBlm/xEoOO9oNDXmP5iNslmheMAZ69DO1Z?=
 =?us-ascii?Q?rszz6o6bR0p50tH7NGRTPUCGVTdcA+/gfCPDWWH2ACj7Mfi3z2qmidrSW6yl?=
 =?us-ascii?Q?Jt0idOGf9RVJi/SmLoBuWklZc3+Tm2QQk1roPhKjWAdt3uVr0+91wxRkAGRR?=
 =?us-ascii?Q?Ssu4bSk3PMrh0NEFUiB2fwDNWDdDpZx5deX7JWxP8jYorYJvZYpJTPHthGTK?=
 =?us-ascii?Q?26c2mhlq6j+LgERbCwqNZan0La/UfslrT6Nsb8oukMQ/z8hIV+8dTdzHGANU?=
 =?us-ascii?Q?kJMo8X8g3D8BmZDVpV12TBInYn3Hhy0eY8xdVVPFnpktia0YN33wZ2JPWNaq?=
 =?us-ascii?Q?KK7rRDg962sEk5w1SLoCq9+pSPIgauVOF4Gujj3YZYmH6nXQUU1A8XKOlFod?=
 =?us-ascii?Q?qlnUFISJMASyIEM7oCk9NTgz8F2OoZjJXFPqPV/LHbjCrQpjpXtfgmtzv22U?=
 =?us-ascii?Q?2t4hJrcimBmglfhuNNwSmhcMkaJ+RZqelcWZsViXlq6Whmj6uv/YLtK1OsJa?=
 =?us-ascii?Q?QDKg1sBRWjdzbBUi97vtS1tQ7T0bwp4nqeBIFV49AjQz/3ySXuUyV2UzCOyS?=
 =?us-ascii?Q?I0M1GuK0PHjPpimRy8fqBkGQ6N/LtQB1TKVEvZU6J2AolAxJ1ktak7reyX0w?=
 =?us-ascii?Q?15hUll6RDr+CQMAZQXLMoRM=3D?=
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29019f0-f384-4ad6-9d4a-08db0f4152e2
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB1519.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 10:42:24.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1TNlm+SuuStotpv+YxT+IUmqWOFc0tdTUVbVza95XdCPUcx5UxDuu8cbXN6mKe2clz+NRhudelv0JYvmyV0jRY+23JNW6hnRadBc6GODo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2034
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 10:44:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14427

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We were testing the validity of deferred tasks setscene status "up front" w=
hich
is very unlikely to succeed and leads to cache invalidation issues. With th=
e
change to rebuild the deferred task list, this status becomes out of sync. =
The
result was tasks being executed when they should not have been leading to e=
xtra
work for the build unnecessarily.

Instead, don't process validity status for deferred tasks and assume their
data will become available. If it doesn't, this will now result in a build
error as the setscene task will fail and the main task will run instead.

In theory we could try and track the state changes in the deferred list and
re-test validity then but I'm not sure it is worth the effort when the othe=
r
code path and errors in setscene tasks will give a pretty good idea of what
is happening anyway.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit edcafac13b3b241b6687419e59018d21811507a1)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
---
 lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6cdc72a8..f82bc413 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2084,8 +2084,6 @@ class RunQueueExecute:
                             logger.debug(1, "%s didn't become valid, skipp=
ing setscene" % nexttask)
                             self.sq_task_failoutright(nexttask)
                             return True
-                        else:
-                            self.sqdata.outrightfail.remove(nexttask)
                     if nexttask in self.sqdata.outrightfail:
                         logger.debug(2, 'No package found, so skipping set=
scene task %s', nexttask)
                         self.sq_task_failoutright(nexttask)
@@ -2843,6 +2841,8 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, =
cooker, stampcache, sqrq, s
             sqdata.stamppresent.remove(tid)
         if tid in sqdata.valid:
             sqdata.valid.remove(tid)
+        if tid in sqdata.outrightfail:
+            sqdata.outrightfail.remove(tid)
=20
         (mc, fn, taskname, taskfn) =3D split_tid_mcfn(tid)
=20
@@ -2887,10 +2887,10 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq=
, cooker, stampcache, sqrq, s
             if tid in sqrq.scenequeue_covered:
                 continue
=20
-            sqdata.outrightfail.add(tid)
-
             h =3D pending_hash_index(tid, rqdata)
             if h not in sqdata.hashes:
+                if tid in tids:
+                    sqdata.outrightfail.add(tid)
                 sqdata.hashes[h] =3D tid
             else:
                 sqrq.sq_deferred[tid] =3D sqdata.hashes[h]
--=20
2.25.1


