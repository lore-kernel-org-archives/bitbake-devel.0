Return-Path: <bin.lan.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF49E77188
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 02:00:25 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.38056.1736388021511910908
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jan 2025 18:00:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3104a232fc=bin.lan.cn@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5091e2DN000743
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Jan 2025 02:00:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 441fnkh94p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 02:00:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tU/rk6UtFhoqndfb91wYbj4R2QelPddB3XQA4V48L9U3X9ZR7x/uTQEKvupBULRfdglhwc1IQUqax07L/TUparfMw+004j1HO/Z2HhFwSxrr3EQzzIQmsX51yX9kTLtxjCWnwkecpnSBCnZZbFchT1pgN7F5GlOrkB2gDi5XwQQkfbGlI+02NU6LltrDZkySJp2kUp7aLcEL7Y9S2QMeFgAc6SM1rSx8ecxeBtS2UdUXPQggdPWhQXn2AYt2yasF6/zyRXCVo54smmArdnwT55pBtpT6iuo/0QduW9+PJONAtwBlg157egO2w/LbfDgBogYZGhcEpPh6UL0OjNX8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBIGEGAXcvD7h/B5CWdgleSXQnCBrGVPK7PsJIqmzGM=;
 b=P2b4CmzF8mVFALQpj190ZEu7tFDTgaTZeNxtaIjI5azQTm9v0WszpmrD2OYM2/xRc8EqJ8gyWNy+GLA+S4CdEUfusN6kc176rbif9lJ/500n8Lp81qljzvT8fGBcgK36NP81iszoKnSq4e3bO/CtdFlROaGrFFpX3/zOh0DyNTB8Dg6T8lt7QRJaXZnQ/Xli05YUtjZQnE5L0hGBbnIkSYYoxtrhrRmJw0oGggziJCvm85iS3tZfo0yIgLAtR2gSnZSOhBq/9SaA2GQRM7RrH1sHw3rB80sSqu5H+Y6rPhG1+ThVHrte2vCsMXiXC5dC0oE9J9wGfQwGjgh50a02kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB7427.namprd11.prod.outlook.com (2603:10b6:a03:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 02:00:16 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8314.018; Thu, 9 Jan 2025
 02:00:16 +0000
From: Bin Lan <bin.lan.cn@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()
Date: Thu,  9 Jan 2025 10:00:02 +0800
Message-Id: <20250109020002.1103585-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::21) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ce5758-5d20-4f84-3538-08dd30515c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UPP8YFx4L4TdgF7YjQQ+avI4T2MWR32Qr7dAhFjf3rcTTQBVy6vpfse6W2bL?=
 =?us-ascii?Q?b7kLHkjPq6zaP8QkQ7Bn85S0bINnQgxP6JGSXk/hsxYRq4cmGN0oDQJv0V1S?=
 =?us-ascii?Q?b/YyPdZm2MpsgosfEzj/njPkHwkPDPUDyEU9QgS0FowS88WDwpMt5tvqht5i?=
 =?us-ascii?Q?cmZeJUavZ8Q2trMb74L+XcJh351U1vfvIUvn5OQX3M73YtcOHYael2sOx3KD?=
 =?us-ascii?Q?CVqU7YWPNh3h56mT4sDgFwQdVVsheyFoYke9D8pqzdnweath02ngk8CH0vZt?=
 =?us-ascii?Q?QoOyk9+9MKjtFz48IXrpCwPul035eAJRjChX9N/nDKcgbtYplX5Y1Jwv+aJM?=
 =?us-ascii?Q?2DXVtsbO85HxrHl6CjejhtYgVk5uI/timh7nwZ144Bdsb6BNSXFU+C62QPD8?=
 =?us-ascii?Q?9p9ALkQoPO5DKt8BqOOiO5oCk7tNHz7fwXKpq3IjiKvN0mf4xobGlwwWr56d?=
 =?us-ascii?Q?E6sjKrWpCUqOtQQTk+7fpLTlO/gBu9qiIAZx290EcWjQua0HKxLRhePCugBu?=
 =?us-ascii?Q?9dsvhdBz8BGo623Fo8rOFIsyhPxjh4Yg5EUomnbwyz/Ixb9vnyD29n5c2gt5?=
 =?us-ascii?Q?3hq5Y0s+8KK6NAUIkgiTYmnNpwRzaRoOROnzHfTv663HpIiqoIOrZGtDpYeH?=
 =?us-ascii?Q?NLTt0SqfGWcNeJTCROqy3xD+h3qpEtBqrvlRubmc2Q9Ky3CoFfad2rkxwL4F?=
 =?us-ascii?Q?ujMke+bWH4/dEo/z0uppDJFX1T3zYd+eRd1S3bFFEbR6NVyETzxRCW9+h5ME?=
 =?us-ascii?Q?7E0nqHOvC6gZNcTNP6BRUo7JdYoB9OEDJYjx5X5EjOwrdeVcxNqNmhUAxDb8?=
 =?us-ascii?Q?Yy1RqEpUa47bjKmWIhkpJKW2oDzuHHILFiYTg3PjwN2/QyQxFV7VCKHWB8Go?=
 =?us-ascii?Q?FwUhdNvIimH44GOrkdaN7cixc+H7lGJvoD3GBLlaecLMgd7mVatE+UWQvbm4?=
 =?us-ascii?Q?44YrEX5F6R/wIE5n5Q6tfpFGpTc7bjOMD4cruJ3TpFRSxNYZSlwrw7RGuF1T?=
 =?us-ascii?Q?hFiY6D8c2697NaFyw+shPkr37d0SEyroDvmjxb3eRldZPpuzlW3alwZ0gB8Y?=
 =?us-ascii?Q?ECeqTBTEFApDY9MJhreW2DseHorM3TDF/I75tQy2K9QXALhyLXdf6onZDic4?=
 =?us-ascii?Q?8AdqlIKr3OFF35XGIHXE/RavLtfkRlfIICM5hmlHAciItujKRRNrisuPDAwD?=
 =?us-ascii?Q?OJKj1EjIynl7MMjEL0ml/ChXXskzNvmy+KP1b28KUOEWzu+0sGCCRPnJf5KH?=
 =?us-ascii?Q?U0iCDum0iYxwKADNY/289I9SprFhp17XqiAHhygivBx/Bc5s3BqFPzEQwZCB?=
 =?us-ascii?Q?ZJHSp/N2XpzeN6S2jArVpICBNADRWG8E5HhsWqsJq4e/R4tW9e2omzzV6+Qm?=
 =?us-ascii?Q?95cMqKcEgqKov3ZeZCkXXD+xEIIfagFmTk283UrbZxqBfgMtQXsMENT+O2xr?=
 =?us-ascii?Q?XIyLW00cs2W51UBSlNco0Teo7mK4+R9S?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OqT2DeBVT31/p6YpgW1/AtsuXCLnqKh6tcJEJ4CNKvI8UTEcqYFfcrm//oOh?=
 =?us-ascii?Q?hN/n1tRJOrtlOXoK+1zCjHoi74niXqCExCaVWmmU8tZaKHwUAbN+d3NJzsgx?=
 =?us-ascii?Q?HlNbzWkZ3CC+hSXPLVJy/5vKSSiyG2pIdG1DQtPFlIl6LW1RYS4CzFZX0hQ8?=
 =?us-ascii?Q?c1Gpbb8A0JWiT8h/Np4sYA4KO39TI1PhftnHsBS+ur1bpKZQL5SWOBi2j8Bu?=
 =?us-ascii?Q?Rwm6Zob1y1cnp786CbDGJZPkv/fepO6dnon/TEVWZeePhAgj+Hs+tPkdndI1?=
 =?us-ascii?Q?oyHl5Lzm0E/6JywTSZ2I58mBM9Y48EmLHw92WFn4552WS8+dgAqt0/39FgRj?=
 =?us-ascii?Q?k6yKKds/NrjYN9iu0/YWEy9hoGIBv1cuegSj0yNZx1JbHhA/nL1TlQWpn7p8?=
 =?us-ascii?Q?d1FLAMoxE4oiirCC7qKdpoHRKTkPTTq6lPO0paw6nYyDYdyA1aQd6j/uVDSm?=
 =?us-ascii?Q?PaRxdEeXIDpruKvddgim4fgu/zOqmQc3OPa8b8cGMCOvBjotjoJ9N/lzSnn+?=
 =?us-ascii?Q?r/mmZ9Tiwk4jsQ7JXm64SODr51haoSkhU8YgVxMzUr/8x9z6+O+U80PLNhaB?=
 =?us-ascii?Q?8wft78BPccYbX9M+W20LeDAmnok5i/18yVg21NjU56Hp8/OkYbR02pmSernD?=
 =?us-ascii?Q?v/98jNwrL5mPvRh+vi3DvvKDdBebBwRD+HihhjdZ0G/nKqf4iZiRPYuHLr45?=
 =?us-ascii?Q?982ziB00KsuChJ9V2XHZ6rt3iiywYC7vT1oo1PJ6sAgGGzWZKFhE4cWwLwh7?=
 =?us-ascii?Q?TKf8gQx93sZgKcgt6u5imGhc0yzvWcYVPMKHVAu35LsURFcHW+QHUoBQMMyl?=
 =?us-ascii?Q?5uBGBy8bcgXG0zqY6vLpBD4xC++1MgTffp6WRHv8vEyM1yWJKuAiNtF6xLq6?=
 =?us-ascii?Q?AJe2vsBYfhGICXAlGvAskETBsWVR9S8K6/I1IiNvI1V8O+kYqoEioJYG40Ib?=
 =?us-ascii?Q?d/eU0JIlTzoLADcbtUVNP7cSWUPV2g1oNLdvOHryHPIpNUQ6ubjPrqKt3ISx?=
 =?us-ascii?Q?el5Sm95iJOou6hDvkjd3GmVExNJaCF5BRqEgccrQEn92GA/O/rXyM0zmSJA+?=
 =?us-ascii?Q?uG/SdlMWfZbN26yguWow6NG6WzWwY9C75oXhKyBH36SGHZdTjfOO6HfCRoF6?=
 =?us-ascii?Q?PoPljTqFvcO+KfAIBUwPuiORc1kGXRrn6FtoDHqJrZdWfVkJ6l1DwUc2vvLr?=
 =?us-ascii?Q?mmljrQMevL/zB0eH336yOjPNdDJUV+Jvo8RnWd3sHMZ/uEB4dWEFMJZnb/bB?=
 =?us-ascii?Q?tABnbyf2ilgnSXn1nw3KqeO9FtzDBUpl9ppP7f/Qrpiv0IhwL3a2oryOuehU?=
 =?us-ascii?Q?f5wcJyfMXbexwnhmxOHU0BgoB8Y7zo6RljmYeMPclUb7m4YPbvrS0D0dJW5F?=
 =?us-ascii?Q?Ap09F9le1zrxkfAnR5J45Xp8+rkgKC10wDG3HAtNJeTrCewY20ZCSIDcQnX/?=
 =?us-ascii?Q?hVOeP8YFZ3iw906qk+KoQMLvqH8U24NZVcVn1r2Y8HawQ5jOAANo87ko0NNr?=
 =?us-ascii?Q?0yNUweF+HF/4hkUgXyzbqLuY0mbnhcdHDfxEpD0IgNqpCaW5j/JHBmOuZJN3?=
 =?us-ascii?Q?SBJip4JKPHUzcRyN315KjzZ0IWJgIL/s6YW7zfH9uEi5awFTdCRw34JqTp+V?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ce5758-5d20-4f84-3538-08dd30515c9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:00:16.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbQEBfXWquNrFGRKSo60IPxCzgGXCK5SFyqem68heU7a9dtDxVutMuWKEI/JGcKyqGuJniqvflxBBTxAuy0EMNIBNJG/iPZSQUJDVUmtZ2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
X-Proofpoint-GUID: hejNJX6MJxNnutZLMlIm55-7IQW148Ru
X-Authority-Analysis: v=2.4 cv=bJjsIO+Z c=1 sm=1 tr=0 ts=677f2db4 cx=c_pps a=6H1ifQWhBrriiShMtbI+RA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=OYs6iF2dZqSYgr0tlWYA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: hejNJX6MJxNnutZLMlIm55-7IQW148Ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_08,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=833
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501090013
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 02:00:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16990

There is the following warning when executing to bitbake linux-yocto:
  bitbake/lib/bb/fetch2/__init__.py:464: DeprecationWarning: 'count' is passed as positional argument

This is because the 4th parameter of re.sub(pattern, repl, string, count=0, flags=0)
is a keyword parameter. We use keyword arguments for parameters that are not positional.

Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f79e278b1..3c9b90eb7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -461,7 +461,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                 for k in replacements:
                     uri_replace_decoded[loc] = uri_replace_decoded[loc].replace(k, replacements[k])
                 #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc], uri_decoded[loc]))
-                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], 1)
+                result_decoded[loc] = re.sub(regexp, uri_replace_decoded[loc], uri_decoded[loc], count=1)
             if loc == 2:
                 # Handle path manipulations
                 basename = None
-- 
2.34.1


