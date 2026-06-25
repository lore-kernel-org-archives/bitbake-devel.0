Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649ECDE002
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6004.1782371281365926738
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=lQLKPB7r;
 spf=pass (domain: est.tech, ip: 52.101.84.5, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UysKi7I1OpWa1IpPaO1vmN16dM9ns8EJbiuSCctekycZL9/MY51P569HdC3/ajv6qyFvDFenkeW6oznzYlKFJmrkEOKWAdc+RMuOGeJ92AljIZkCu565ZAK2NmgEfuZe+LMKLATMwdRNUJQL/hdqkDuMTzHlyaqb1oM0JQOAH/PVhhTq6Gipo4Fayv0KeJ+KSO99FcSM8gF4g2re4Y0Jqip0M1oz0jNtei5Tumb0wGGmtTNt2Z3yrbAc58qtvYCiuh8LCHy11g0TRiSlRMyeHfkTkdhn2dkb0E9RqiUjS/9cgFZpHzmqTYGGRqvMUfgE7IPAjJXPOrse/E4JCk6MBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQbGgqXhM1JB4QZjPNvRfr2FPpb7qkef9CNcshgY4Jk=;
 b=SJzfdSbf93PfRvgJwtltPBlbsfhmSKa2JbfvOsLXl+KT75psDHgpEkp5Cu/f1DoWh1uds3+kTCbulpURLtvvZVqlQO+BYYEs/bKdN+ZWipHksg3KwOynwQTIjSyF8KEXZxka8326fo2EfMI4dhVWUqzZ4cik+ciClbArzMp0SBzY1+KFKuj2tElvBDsptCwXtepHwuSJf4ZVR7NrXSQXYyYCiSZ90tQn3q1O9WIGY1xjEvQkGF14Uy8UwVKN9x50xvAsaoyORvyTzjpO/qmnuPLR6hDQz/lyZu+EddcADm8MzltO/CWCbm5ac56vVlliX5eoVGsZngalQM4ZwqsYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQbGgqXhM1JB4QZjPNvRfr2FPpb7qkef9CNcshgY4Jk=;
 b=lQLKPB7rYIcbM/+lM+D56Gw55iVMeRlti4CW2rs8EwalSWlEZBJ7/uF2nFjdVPrIr+X0mhAGkouIBri7o0KSebcf0IZ0lQ1071+H/J9x2Td81n1Nze6UFCrjRZvk3JcFE7eKciCExsi27cHR1lXtUKNmwNp326yYH85c3OJrKFwXEVnwKmKkIkKwCeqslc57JVbKuuD7/ddivGUqBwxYjfviC7BHZKHm4s3kkGq11gANTEF+XzzJfhtOWWN32Xj2MyHSeNJaH5q3+kn3wLZkV4FztHu3VHlStupV8srnz6MEe/9xz/qDi/RZTH4LBcgwxdB/6z32tfbLgiwS1mshhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 AM8P189MB1316.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:246::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Thu, 25 Jun 2026 07:08:01 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:00 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 2/9] fetch2/git: avoid an empty argument to git lfs fetch
Date: Thu, 25 Jun 2026 09:07:43 +0200
Message-ID: <20260625070750.2757558-3-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::19) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|AM8P189MB1316:EE_
X-MS-Office365-Filtering-Correlation-Id: 02de5b57-1357-4cdf-c844-08ded2887dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	mexoZtBYT7rMAMGlA2zNO8zWON7EcF7iTPkOke6FUrYqcqhqQIOV8S1IqEY5TVygvPsoR9MYEgsMWMQwjDlSfZ3nP8tPzcgd/fRZSJKO0RPCUzRhzdz3bH034RqTyKRhVkbznn89bx02QrNZ4dzF5JykxXazNVl1m3yDUouU7F2TXhGKBuQApyMM4wj0AV4SJezFdwANMVXPpSph3c6e0bxV+8rZPmr73gf4CvOyai9uKf9O5HWZevV2T8Oiu/EOUlbWL4LEpPW2e9bEnpnXIS7P+pIeZJTHBxYcS4fiPDmAmBQK2JKq8fHcstF874+3psZ+ar02LkuskmlcaorU+tWz87Z9xD2zsOdrwqc/HM7lLHC50MqPRLlteF34T6+8IjARTmnwn8GeI3lqzUR494tNTunaS2ICPPrrDJggUH3A7LocFhbYF9kzYBFOxD9kyu/I4Gbg53VNL/Fn7XxuBwEPoqSDDhiWvXsg7ayT7OOnd9W2548vkdnBXNpYWK26L3IL41c5e8o891n1EYfOiz8JysMqcVsepPSPhWtzcz6EyetfrBQ16qrYM72HvyeK3J/gFFBG0QABSxNUOsFSYqag6D7+JrE+3G1FDNjglt2/oiKSK4KzZHFtxgeNOvqDXBhWcvJzqzjAnvVjRu1sjpMB3CBAsBiCSo5xByiANxI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dyAmBm1NWmFeTdJQZsR+JclgPNiZ7l+kRQTvSn1u4I1E/q04E3BJKPlp/0D7?=
 =?us-ascii?Q?r4yMPxZXN+GWSKX46lfQCOr798Yv+LlgiJgGFhA2sRkK40v1i2cNQzikRo9O?=
 =?us-ascii?Q?EKREh395SRkqkwRT6e+P59+H1AXsPJMGqUuCkVk46tIwJEuURW402ebzDEsA?=
 =?us-ascii?Q?V19QhJeQaIXzFLUVxIAahrb0cjQezYlGqm1KsZukQ2YtDKg3dMxwW1G/aDk6?=
 =?us-ascii?Q?EsX/xzQBH1S9ojSOh6GIrvNCnjFRnCRWlOkbPdVoIDQgfRakbydAmdMLkmBo?=
 =?us-ascii?Q?HAKlhvHTRHLcDcemfmaZJu04RTfJLQvHYtvaMDYML+/epKMSqzPuZwVb2OpY?=
 =?us-ascii?Q?MrBKS5lmcD/07Z7RiIRewIRDsQBtJS8rGkqVGYwUNxgn9nZ5fjl9Mo+D80pb?=
 =?us-ascii?Q?C5KZbERIVDmYjmaLNd8ZJKWwjMbIvh4UstdNhz6bvuRgHWIL9Ju+5e+T9Gyq?=
 =?us-ascii?Q?0tH4VjJRB71s/5JSSR+48f/DhZ2eGQ6TjlaxesbzAc8eZ+dpHwqF3KOKWWZv?=
 =?us-ascii?Q?OXBNgQWkxmgRDlA0ukrxvvamIEK3DtvtXM250VfqO24ZTdQkRVbenFrhdgRU?=
 =?us-ascii?Q?W9RA7Yi5c7TqyIJ+Pg7VJch+xtAxb9ASaL8XmT84TC/fG2xv6a1xNdT5ejVK?=
 =?us-ascii?Q?BR8OgQlA+ngjkQnbIS/s79lFdtOnN+/cTRtlYuxRhTvSrnd2fummDXYkXQPt?=
 =?us-ascii?Q?yRpr/IHvP/ylga1eW2PkJoHKu2na3fj4c57aXghPkcYnqbTokD5fulGEVz/4?=
 =?us-ascii?Q?9qCsZkrbiUfNTN0NVSxJmduSbd+OYtWSiPvHnoIpyMse1prqfIWQ8q7fuYCE?=
 =?us-ascii?Q?qC5cCdZjofqwGqIT9eIbAU17uEZhh/W18Imio88J6BcmSTyefMxvaqO65Uhe?=
 =?us-ascii?Q?gu8l8PXUpEb9/tWDLYElDJgxsKWZ3ftf3sIu1+24HfsS+1UL9y8qAuU6LJWb?=
 =?us-ascii?Q?o8Oe6wuU5MFPSg5fstCias1Odoel0WTSu/XWK6kTy7xUxm0Sb1mmJYcM7UGx?=
 =?us-ascii?Q?U+j7KrW1oIA9SoAUv/I5IxcEWBAHevc7ECZVnpg+FyJ/NSjzIQkKybtWArVg?=
 =?us-ascii?Q?AHlaQGNv3T3qpMIMwen7W0hJcJWnsNyNWEHpi32CC8ezWJ/8bvZx9G7pnv14?=
 =?us-ascii?Q?JlOyfDNlZAGe7mJQktmn5rRbn9vdUoSlSRU0vEHRsHGUPjuXy2+ASqcWmyBy?=
 =?us-ascii?Q?L+sD01D36lI3LIUrFaceVG+FJq8ppie2E5R7piGEQ8fe5RjW4TJ3bGkNi8Ko?=
 =?us-ascii?Q?jElEESFNtbjKpUbsm6J/Yr5je2/cxTtPjlmswRekWfhdGeYmlF17D25cbtS9?=
 =?us-ascii?Q?OEoQDUe/a8qi4u4B7xb7tO8zErJko8o8YwoBWlMNUsEPJjF3nm/XKEnV7nEk?=
 =?us-ascii?Q?xbpz1zqghRzcaYkPRX7eXwCRznvdnbVxOxV6iUqI5feVe7aGf2bht52ypDlL?=
 =?us-ascii?Q?HghBMBtj8y8aB4Z7l7d45qDi8M4Iy0ehk03eqMXZ10K/+uuxis49JGKK5qC4?=
 =?us-ascii?Q?xH2QLHu3TrCMcNm8XdwQcGrdqchnVUeUIv95md1YsdZ6/2sdTb0A5Dgyt6Zp?=
 =?us-ascii?Q?1exFVM2eqVTfFiPLc/ps4MSCwvdV/xlhw476G6KQZLJ1o7qu8DR/qsNFVfiK?=
 =?us-ascii?Q?bBTBAMvOjVSe4MEX+DYaXFr6JU4YxiURDllH2dkHxhdd5anBIB4PuyUZm+Xd?=
 =?us-ascii?Q?AROh1r1Alf6RyXR+szzv5914uaiiZCEu/hmA7h0fNaHks0ihuuWHHZuul9hx?=
 =?us-ascii?Q?C3fdwzgzZw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 02de5b57-1357-4cdf-c844-08ded2887dbe
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:00.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoh744azNFIBQAL1d1se1839c7Z3X0C2jwK9jzEn1/pYRQM9cedTlbN15THmFnNI5HqOMbU04R9bIhPcMymz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1316
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19781

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fbd85441..a456465e6 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -505,7 +505,9 @@ class Git(FetchMethod):
                 # Using worktree with the revision because .lfsconfig may =
exists
                 worktree_add_cmd =3D ud.basecmd + ['worktree', 'add', 'wt'=
, revision]
                 runfetchcmd(worktree_add_cmd, d, log=3Dprogresshandler, wo=
rkdir=3Dclonedir)
-                lfs_fetch_cmd =3D ud.basecmd + ['lfs', 'fetch', "--all" if=
 fetchall else ""]
+                lfs_fetch_cmd =3D ud.basecmd + ['lfs', 'fetch']
+                if fetchall:
+                    lfs_fetch_cmd.append('--all')
                 runfetchcmd(lfs_fetch_cmd, d, log=3Dprogresshandler, workd=
ir=3D(clonedir + "/wt"))
                 worktree_rem_cmd =3D ud.basecmd + ['worktree', 'remove', '=
-f', 'wt']
                 runfetchcmd(worktree_rem_cmd, d, log=3Dprogresshandler, wo=
rkdir=3Dclonedir)

