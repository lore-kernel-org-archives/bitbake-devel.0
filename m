Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C631CC433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Dec 2021 11:14:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.51])
 by mx.groups.io with SMTP id smtpd.web12.9975.1639394067412531688
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 03:14:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=vRCeMwDD;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.51,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdgE7MTuod9/d53qaC5GnIeu5Y7ocLDoL2ulmB8Mc0KFstZtmhcx7AeHTsbMBA+3joAQTzNLU6IbAkB/1ko10z7Lm3JeWV+i5fLvHXemm9xcaxCz6Z7iARu0dpcORYCHsV6owr8kP3/EFHow25r1KeR/D9YBB2+S4BYzcZZR6KAXxSMve1V6Wx4mZ0KzXnDAfT7AKXyBohGB6dzZ4vavoD7E+CWfP/gOpKqS05rqw2ImY+uk8hiEhl3z16jijGqaamYubFltpezLiZMqtwkO4TxVtA3p/w67XfgBXxcsNE6ckC0bkxSGIPxlwdfy2fovt8RHM5JDjAVchdtCPB/xJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaeY+WcBa/kj+dXeXaH7I8YX+cLbpbvCSHS6mK10wvE=;
 b=nQblcyw+jW364D6UqU90N5SCbgc4Iwe97tXEgizyJTlC+xQwzW7tPWzKMS0urAmt+fvO0knyj8vL0B8rC3gpZCdJLj1ePy8fkV0fn0rPofKxaUtWEphBwsPjchlDQpTtRSzmjGAXtm7obb5Si+DnDoq3VNQMibln36n5hTr2/Flt/U5FiH5EvduC2RUS/xcprYreLKgszi3yn6/LBTSNuKUqxGVR+rhcQ0uzAH+FNA6JR7PB/R5tVTfi0r5yHDy4ho4VPVCxkpnwZQwFpIouK7rr1+T9HnM+LT2/I84eNjdZ7um/IGiW6jRer5xGMMSGxSS/TiiaEvG+PmDx7+sPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaeY+WcBa/kj+dXeXaH7I8YX+cLbpbvCSHS6mK10wvE=;
 b=vRCeMwDDbVpHQe+dAN0+2LhHrcGz5aoEvcsFPpr9psRt2LqgtcWi0R4q2pd01mANbm0qQhkvCWfJXdiYKfFv75FmNBnRBwbRZ1I3xJtqmDRg1YZMOeePfWbJuzfL0pWfM6Xt5tWb2zcuFZlSDYFmBqeDzpohRV1ir7UVH9Ap9lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB6926.eurprd08.prod.outlook.com (2603:10a6:102:138::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 11:14:24 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%8]) with mapi id 15.20.4734.032; Mon, 13 Dec 2021
 11:14:24 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/2] fetch: npm: Quote destdir in run chmod command
Date: Mon, 13 Dec 2021 12:13:52 +0100
Message-ID: 
 <20211213111353.28402-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0084.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::25) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (89.247.126.92) by
 AM6P194CA0084.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 13 Dec 2021 11:14:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1300cf16-aeb0-4a96-5a8c-08d9be29b828
X-MS-TrafficTypeDiagnostic: PAXPR08MB6926:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB6926E64C948D1BBC59002F07D7749@PAXPR08MB6926.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:239;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c0pNnx3jL8XQzzQ1jnhxCbUWXFR9D33VRTUitag22YeOuxTSj/ZwmgXc4giNeWlTJmd8QfjzKlydQH/ibfUS6w/uAHQvFrH0qQx1DbYVP2HLkHngHEw8CVHFW0rFce7oXBpzullD/088BjxYtyQ4nDJiAV0S5lYmoFTPp2eRMQZpBxuJNGBVMP/O5OWosX33/0YxnoXf+XJkWMjkCgvghzF1j8c0eEb4uz3uL/gmqxcM78e71RkIFVkduWOct+rkczEKZ3AMvlM4YvMGxYohhscfoY4Pfo34SFoRR+49EXQ5GSJHcKkQa+rdFCq9ra22rre1FRWBwqpCpNiMqlrgnIfpW217JRRpv/A2hqdw7VyehZWl9NqNqFT8yfvESII6CMTFVcCkMFYLwuiZDhR+8cem3fpvMx5zoITAtMlvjTBB5IQQBVWsC+oaHPv7ja9TAZKZJTkjPARdgsjv4RjZy92Fl7iRqGBAN+PLjyuVZTwNaKKpdgo83iYOVL9lVnNauobSbOk4oIHbHtn5y697n86AVywlLwUPnN9wbLTpL+449Di8VVIXXBotPvyYkEKeMzC4hod/YcGSTbe+qt1vxEFi+2ki5rH1pYW7tmoTNWYNfqGn/l+nPn8DUx7Ak6tTX5wfsGviINvr7hj+awXtnrhnVv3NLj5q9aYcMFSDBOmroxB8vQXBlGRjGlXTRLGqfhCPwqbhtMxGBapULi0y9Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(4744005)(5660300002)(6486002)(508600001)(4326008)(2906002)(6666004)(8936002)(83380400001)(66556008)(38100700002)(26005)(66946007)(36756003)(38350700002)(66476007)(316002)(7696005)(8676002)(6916009)(186003)(956004)(52116002)(86362001)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DjwtB6jLQcyM0tbsr3aZ3VWGPet/DzOLm9D96sNtWCgR7UxaV3DoyTrZWo+z?=
 =?us-ascii?Q?RNRAQpX3BM9LtchsI6AJfcdx9iY72sgdSSumY4qrkxya7XnIrETpfH0CB76n?=
 =?us-ascii?Q?oYnwNUG+yngA6FvF5wh5llV+qSKioKqLcQa433gmTGYfEaqqwAPlPih/FPWa?=
 =?us-ascii?Q?sZzSxG+z5dBvr1RvdHR9hULkgyvlcOe3Td4RNpUMhwMxn92yOMnADyV3UnZV?=
 =?us-ascii?Q?PC9VYVaDfn5ZRJ5lbuK+Yejj7AAMyi+Tac+kBxal65YQh4Ms1AR1qOPUW2f2?=
 =?us-ascii?Q?I8VwMX9KNNjelqv5tSFGKjT3FN8jX+JE4NZsrNnxwvNBZVR2s1yLKnWQMfrG?=
 =?us-ascii?Q?dj2yEKJcuCmbPYeIxpPpQAB9Pc/3e8Apgb8ty3QppMqplBmpcWsK+8h4/Trc?=
 =?us-ascii?Q?yc4SWuoHiJvHYz9THPgMgIYGRQyVq09rC1rNhYl9Yq41hXSAiIu2oy1p5HuN?=
 =?us-ascii?Q?tAioCgWY/l12bEmW2djHJ+zjm4Ja4se9tneJb28xEiq4OMOIrF9hPMj/5l8K?=
 =?us-ascii?Q?HYhJEQUOs1FQgRTe5+OXLsD70/zcVZZorK/+tYLYaqpI6Cis1fod+mMlF/YZ?=
 =?us-ascii?Q?owRyUv0WdjXVclC4t9E9PHOOOf2vg/Hkwrum5GjzWBKa2Gu0P+OMR0CBcujA?=
 =?us-ascii?Q?htdwfyC6nuqZ6izacx4iT3VK6iNO4IXsYQKIkcH8HjhW34KJEVedANBjMHyK?=
 =?us-ascii?Q?vc8Yz3l5FuwSW8YnyYyWa+Jvo/wYPZye7NjIph0oiCE//8ciVO399O4egP/G?=
 =?us-ascii?Q?1tmiucq2dyWeBUNdWTqiPTRm4WgFtNSeLT7r1j3zNBKf63XzkEV1uNdEy/4E?=
 =?us-ascii?Q?YYwpNMZaPuVWnaYhmfBciLVsljFRygv5MdiQtW3pC6Ugj0ur1r2QkaUWPynE?=
 =?us-ascii?Q?ZCFEZ7DNcKv+3rJE8vzvRxzf/SL5fVyg6CSPXjBQZxIuqPaP66zGJEAh8M1s?=
 =?us-ascii?Q?9nfU29oQMH6ljYphEa5ViuAgHx3gvxyidyG8vLf2lJIcIgUIiMaqesS1MgIT?=
 =?us-ascii?Q?y0ZVi36sXv+lm/U4GK4E/Ntd+Y91CeXOCz0ZbhTr3g2TrvsW6+deWjT1uIFq?=
 =?us-ascii?Q?Yijvhk1L8r1bX/yNnsGEzcdjCUCYs5N2/7xZmEOgpJdg023QpjtOs1YtxIZK?=
 =?us-ascii?Q?HxnzuNPiv52GRYd3YsPnb7OWVUd/FQL5gkc3VIEu79GDBQxEtbfNdq/rdkVa?=
 =?us-ascii?Q?zzLZUkkFHlBnx7OYqdbuiTesUXkDTlE/KuUuBVWC2yEN6UEI5z1QCIjEvvw+?=
 =?us-ascii?Q?d80IhUQ8yUScNNRNNuxm9I7flklpyvixWmk9HdNZ8pajdbgfaH9JjRm0Qep6?=
 =?us-ascii?Q?xzHHP2M9Ao1u0dV7fmXMMlAGp8PeRCcbt/UZcWwgB/6IghQ/jhazU8nFdqcW?=
 =?us-ascii?Q?hpr/hWHpjusi5mZflfv6jhgLr3wvBARPqbDPkcxLX3lG3XAWLzR3YGyIgiRa?=
 =?us-ascii?Q?v91qo5s6yiyZ6UfM8Ny2m+1az9ICrGOUd2NsmOGL+dZXjqZptDs3u/F0do94?=
 =?us-ascii?Q?N4LPN4qTVmLcWApGiYQz9hjbuVSyRxflPax9duiyPjxuBi/2fQnCQwaN1LPp?=
 =?us-ascii?Q?hxEQktugE4YpzGArO1EquLt9pOf6hOxHfF060eSmBqkA42wYbwV3anb+9L9l?=
 =?us-ascii?Q?5ZDituNdC7btYILQofdTzJY=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1300cf16-aeb0-4a96-5a8c-08d9be29b828
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 11:14:24.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 TXGTGsA/m3ewUhDCdpQt5bLGV/TdL/Mg1hW9WqZp758HSorPESgjbrYvIsznmSOri/teTJ9Ja7ei9JpVoAL30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6926
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Dec 2021 11:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13148

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Quote destdir in run chmod command to support special characters in
package name and to avoid syntax error for packages like
'@(._.)/execute'.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e497c38d..d9daec20 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -72,7 +72,7 @@ def npm_unpack(tarball, destdir, d):
     cmd +=3D " --delay-directory-restore"
     cmd +=3D " --strip-components=3D1"
     runfetchcmd(cmd, d, workdir=3Ddestdir)
-    runfetchcmd("chmod -R +X %s" % (destdir), d, quiet=3DTrue, workdir=3Dd=
estdir)
+    runfetchcmd("chmod -R +X '%s'" % (destdir), d, quiet=3DTrue, workdir=
=3Ddestdir)
=20
 class NpmEnvironment(object):
     """
--=20
2.30.2


