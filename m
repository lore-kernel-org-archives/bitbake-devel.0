Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18404C88E7D
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:43 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5047.1789411388358949529
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:43:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=obfDWote;
 spf=pass (domain: est.tech, ip: 40.107.162.21, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpyBl2xKXULKbwfjhiCqCmM2Kp38FjDyGKYozSig3EhxciV6JgyYeiQUE7Kz0Fzs5nN7ptqf7EmOraWu3M7Q6iGwLeNgN1desAIyflx+CwDMETwqZUZXsiTbs/WIgUrp5X7yCHNirqEXFLH68o9smIoau9Pzo+tLudw0Fs3l7MPVa3PzN67nx92NH1We8GBgEgEfyNA9ScLeoU8vYijdGKOkRY0gs8mII2GmBdqeKgCN7nuIu7RdiIGsis6FmVG01tphzKV0jJrnE+qnA8bRlH5nKlou4npa6HklON6eva2S8HF1BbmjI5bkRcXDKZoquzdm56QDFkz7q37eBrGjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//SC/l5gOO8vmiLZ6qujTqe+inm6GaJasOoE9xKREoc=;
 b=ZyohqGLdvzi9eCYC8k1i+NGMQVgcoxxzCZH/UMFcbr2tN+murMk7MCljmEzKBy5nMbpBGGluO66rL0axQjeV1fsFoEX0q5fKqhH3TLvjptjABmFmjbGuvqmvogY1rPQMJdx/Hl3r4FpDRGOZ68/IA5ayZwN/ZqT0oUp/Ua6cfE0J5vNHkuzfSq4EBqvwefkF1K0SXemBTeP69gVxEH0LFhBlBGAUbfztlhzkqvVhItUXJ5f4K5chHNM7zfmTge9+aHCJyUyCvYRaijhlsn2o4QGaK+ra8xD7iNMU1FuWZ+9qHW9nAwARkyhwJ0/3b6eCxZoYBxIdgRGFd+SIXuRnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//SC/l5gOO8vmiLZ6qujTqe+inm6GaJasOoE9xKREoc=;
 b=obfDWoteVNOVEGHMEBIKL/zJt2sr2qhBApT4ErM9pleLl5PUzdrslLsG7AWpIatnDf6GSCSx1nrwmg4acRWRv9OjJDPyUFMAxkBNeKStsZOVE1wRv3eAFqLX/5oZ6wqjY9apHfp+WuXq2IxhUlq2+wNAqg/7R6OXg3dDj9ffHwB7U2h1WHm7eZGjhP78bTlcbKyZfQPl5LZFpTkvG/go50ibUGOCBD719zOPs3VbP3IhGpfLxSKBYNUKXr9HP2z7L0kgpf+VxzNBMkLmoKbmrHEHSICJyXWkS78D6Wn7pRYoZWLMWNp4FFeyEpf1jRcNqEWHOZhkqxN0JT4+jXDX+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DB9P189MB2051.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:393::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:43:04 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:43:04 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:42:25 +0200
Subject: [PATCH v3 4/5] bitbake-worker: Allow tasks to disable Landlock restrictions
Message-Id: <20260914-landlock_try2-v3-4-4ea504789675@est.tech>
References: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
In-Reply-To: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
To: bitbake-devel@lists.openembedded.org
Cc: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789411368; l=1230;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=ef0X2Wg2ArQRvqZ0GTthttmsbUtOMkPGiAU0GNdi7kA=;
 b=cFPhFtBOT/IkrDheqayx4QpQqg29nVryOzuN2OA4XCBSZlpAGS7h7kdv9FFK6Ts6q/+r8n9D4
 E19LjcGtV3/CMViJh52si9mZJ9ruoPo9UFngf+dgtLRUZYy8heRgbAG
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3PEPF0001DBB2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6e9) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DB9P189MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: 2349d889-b1e4-4f76-15eb-08df129002a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	mZCSZwytgzE1Uf2AwM2tZ88UQpZ8YSxxUZxVjbNakg81qWcb4brQy/nF+SyYtwR8FlY4uANsvPHujHYKnhvZ6NaTtyHlwaufL5m+QuP0nyb3SYhe67LCywsq8+wP2mABWoDOpmL3z41wCuyn5Rck7ZlujVHt8TyItfyF0Wrks1UVks3p8E2MsSboox2bu/XFK8wUXBIn8UKi3K7kMMq1cNpwV8s+ub9CQU7jLRyWnk5EFHvxo1dnhAZqAYwbeIFO3bwPSgmLGAljwMqUPuH+AwyUU6C5/Hdd56amn8dlSfvzv2qOnDqTw82vHCo5EsNSTPnpcZGV9ewVvpLeR8KIGfDGhTWQ8NoyuzqwNmqqhadk3OthORIQ7IxS47Dl2b92Ch4iZAK0VJxiw2Rp++5GWtwizE4PkQjoR3dKIWut4uXWz9mvkowXIs22+ZUIbjVP5jxBPKRxt8JBI//Klzru32Jb4P/HoYnC2YIg14OuhyjmWq9BxFj4hUvYZiaUBOrVHf+p9a6vR8Dy4GSM4Hj05ImAGzeVKsHBX8+IBStD8Qm+bNl5uQM221wCIOPOuCF2EN94jj14cNlItDhPOwU8mfRadlPlXwXizst8oOD7Sslxj29oVqVwzNIbnDN+ywWZK85s7YCx+8qemw5SwNh2ISmbiheyBGAe5Nb3e8gu9po=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFgzbUJqVFgwbHFIYlV0TFRsSnJtNmZ6T0UyQm0vNk5uSWpQN0JEZVlsL0M2?=
 =?utf-8?B?NG5qdmxRb3YzYUpGUVRWTWdHb2ljNGJDQlJkR014Snk0TVREeGVyR2l6b3Vz?=
 =?utf-8?B?OVcyYU4yQ3NnUUk1TXJ1QVE1cDcybEJVa0hhY0tWZEpWQnhZVjZEa2pVbWw3?=
 =?utf-8?B?M0xxL2xudWRMR3hnMmVQVDJZbWVHZ0drL0w4MDFLbTZDL0xOVmhaWGpKNU01?=
 =?utf-8?B?bExVMmQ2MTZIWVdDMGswWTZuc1R4SktiOFlsbVpTNldwamJNRUZ4NDVGeWNY?=
 =?utf-8?B?VmRvVlJDTXppMHFCZlFteDYrL1VjVEtsejcxU09FZUhXbjNpTndCNFZwSDYw?=
 =?utf-8?B?em1LbDVySFh0R0h6SDVtSTBVcHVxZ2JCbXZsbnAxNm1KL3pWUTBrTDRER2dw?=
 =?utf-8?B?Q3VGM1IwSk5PeGJaMEZXK05SdUNpSHF5OXhUZDZzSVd2ck5zejB4Y3V0L1hK?=
 =?utf-8?B?SWxuRmhoOU9CU1MyTGlESjBBODZBN0hUMjhZc2hUSEU3SmpsczJuUW0yenBp?=
 =?utf-8?B?U09yS0tyVjY1REExOEhzb0xkak14UWxSeFl6RlZJZ0lyZDVMMVlVZUJGN0Ru?=
 =?utf-8?B?U1JTRDZJRlczRE5vVUxSSlI5dEtMaEFDd0d2MjcxdnFEWktUWU9pTDdvQ2VT?=
 =?utf-8?B?eWJ3K25HelFvVGcvMUh5N0lhSzdMd2ptYVNwa003VkhicjJZSm90aWc5Uzgw?=
 =?utf-8?B?UVp4M2J2c0Q5a2lTUU1lQ1JkZzNkM2txNllWaUJ5Q3pvcEpVdjB4T29UZlFi?=
 =?utf-8?B?T2c1SkJrVFRoL2w0aitYN0grSHJhQVBjTVN4c1FacCtUMTlZTzV5ZlRORjBa?=
 =?utf-8?B?WFhpOWxhNCtnRzZjRXl2ZkgzbDNsNkJyMHhRMVBkN0ZDS05QempGUmF2eXli?=
 =?utf-8?B?K1F2aVUvR1FwYzJ2NnBKT2NNRjgyNnZzSk1waXBvNm1Ic1EwNWo5azd3dU1q?=
 =?utf-8?B?aEd4OC9TT3FqYWtETkxSaG9EV3NITldMMjRYNENuNFFybjRjaFJIZmhYMWdm?=
 =?utf-8?B?c3RNWExnZENqSmwwa1c5VlJZNDZmVTVCS3dPMTZ6WmxjR29mL3E3aGNIaUZo?=
 =?utf-8?B?WGRlOHd4QWpHMjA5VzMrNHo2d0NNRGJFclg0VVRhV2grMkE1aHN0bndMWGFJ?=
 =?utf-8?B?RlJ4WTZwcC9VWkxXMDJNWmF1OGJlOExOanBUYVBnSkVHaWVFT1M0T2ZOdkRm?=
 =?utf-8?B?UTgxRTVzOTB5ZEFBd3JkenZydkd0dDZ5T1luQ3Bad05sVEZRRTRpamp4RVNP?=
 =?utf-8?B?eDZKR3AvLyswL3R5NDB0QlZDMXBvMGYyemxsVEVQa1hKb2FIdUw5STN5ZUxM?=
 =?utf-8?B?dmVudjVxVXBta1RRK2d5Vk52UkVGcVFDZDR4NS9Jc3hZSDN6S01kYVBJbjhE?=
 =?utf-8?B?Z0hsaDNIYUZXL1B1TU80Rjhha3pjV0lYWU5CbzBFUGdEMXpqQUsvTkJFYjRy?=
 =?utf-8?B?bXlDZ1ZaRWpIaFYzSlI1aTdDQSs3aWlhQnNoMWVJNWR5SzRLOWNsa2VSNyty?=
 =?utf-8?B?NnRIY2d3c2pqUEp3eU9UNCtYZEd5Z2RyeFl4akowOFRFUmQ3Q2czeHlzWktT?=
 =?utf-8?B?d0tvWmZwYVJnYk8xMEMyZnQwSmQ3aG1yanoySmpzditQUWpnc1dYSnVmTE83?=
 =?utf-8?B?QnIvZUFjUnV1T1dsUXhUNnB0dWc0WHRLbTZkcEtXdHhtYktxTzA0SWpucW9T?=
 =?utf-8?B?T3I5cXh6bWJXelF3bEo4ZmgvTEhiL1pDdUdRZ2EvcEZBeXhVRTIvUFRXMmoz?=
 =?utf-8?B?THNtb09lSmFvaWJSWGRNVGpndStGZS9mVmFyR0tsak55bXQzYkRMeXZzRnhr?=
 =?utf-8?B?MTFScXM4QlR1TzcwYmJ3dFhzQ0ltYzJLeGlpNUZVODZ5cTFjWnFzUmg5YWlj?=
 =?utf-8?B?UGwyRitWZmVZVzRDM3Y5ekJzT3lUbHQ3UlRTM0JMSnhoU0ZRZUswMzN1TVB5?=
 =?utf-8?B?MW1jU081eEszbDBNSGJXbithRHp1akxpMHNOZGpENDIvQnMxRU9kWDdIWFgy?=
 =?utf-8?B?ZVBHTVFHWEtYeDdFaFNTeGRBNVc3bHZTeWhHbkdjTkZWc2x3L0dOd2xvUkRT?=
 =?utf-8?B?K2g3SUVjd2ljQWVWMU1pM1RWSHc4ZFFGL0VldFJWdkJrQXFoakFpVUZESzhP?=
 =?utf-8?B?ZVM2MWpydTlxYkFTcXNZa0lveHAxQ095YW5UQ0ZOY3N5N0JHUlYvME83VFNk?=
 =?utf-8?B?L1hDSFBVK2JaVmUwbFYrbEgyWVZmd244dHNnNEhvQVdyby85cVpDQk9GNi9D?=
 =?utf-8?B?UG92anNablRxK0pFNTM4bXRSM1dYVDZkclBWUmc3NUFWRkN4RjYzNk9NN3pS?=
 =?utf-8?B?STZaWHE3b1lMMVNvd2tmWVoxNWJ2QTJ0V21IdmhReGZXMmpHdDdORzBoU1Bn?=
 =?utf-8?Q?ixvNDyW2a6NGpLM2deucKNxH2MDb7KHWvZ8bPMCuOCmi6?=
X-MS-Exchange-AntiSpam-MessageData-1: RjqVQjHP7xHfYzmm/lXrKGrTlcQpXJlAmxI=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 2349d889-b1e4-4f76-15eb-08df129002a8
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:43:03.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XN7e7H+8cNNy9wO15/XDPcCXVSFkTnorCwXt2bfBTV80q9+qsticIVl+v7Fzp+4Beyol5cfknM4fMzKGMBKD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2051
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20210

Honor a landlock-disable task varflag so individual tasks can
opt out when PR_SET_NO_NEW_PRIVS is incompatible with their
operation.
Network namespace isolation remains enabled when available.

AI-Generated: gpt-sol-5.6
Signed-off-by: David Nystrom <david.nystrom@est.tech>
---
 bin/bitbake-worker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 50380201c..9a744ce56 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -293,7 +293,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                         bb.utils.disable_network(uid, gid)
                     else:
                         logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
-                    bb.utils.landlock_restrict_network()
+                    if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'landlock-disable')):
+                        bb.utils.landlock_restrict_network()
 
                 # exported_vars() expands each value, so it must be called before
                 # empty_environment() below: an expansion that shells out needs the

-- 
2.53.0


