Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D42C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:03 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4388.1789410138144222308
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=g8t2yoNG;
 spf=pass (domain: est.tech, ip: 52.101.69.64, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcZzt0tqkcYW3CrmVLdiODamauwEaeLvewZuCkHIIQDws3r+8mZCTsQnaDsjo4kTFpJv1h3u/aQesc4yF5/Bv26vF5Q8cqnxeuJYKn9viEVOGZ3i8RcOFH+7e1O7oMghl9Jud4HQYR/nLZI2YZW50fwLtggyc35I63mP1FonOH08wiEZfGv9+GQ2ZIVdysf+/bchhzIkn/uuQS6g91I2kCwlz1jIN0W7Ohw530cjzEBYfDv5QEHeEe1gE6Fp+BGxFIszS1Tx/se/O2I9RYADXsKHCekc6IWyrsMN9J/m0smbBGJsthZBXCSMMj33d22AWtBPnynGj6xzanoONVPFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0rZllqUst3ccBn24Jt3r7rDewJmP9jAN43f/dLmUnk=;
 b=yFd4Bj0ViPJLosIEEm5F85LZwUQs2oE7qWI2jaQReJCKyqo79T4jxuL7B0rrdJAWwv5/66kd+2B51muEO49eI0GmvSsvmvGq1gc4LZnuTg2uWmyPOZbmb5zjf70t5DFzhGASObsk77mW4Nv3A+C8+v27fFAuaBvbCeBwIJ9UA1mSEzzpX1iuG4VctUfWm82HTzSU+KrN1n8spfEMGSIus8TT+rB3Fl6Io84Gl0nM9Hb5wkukcbjWgE+1IZbmLC/nFBaNUTSyjM1ZELwuVxOMpABSbL/zH7EeH/fTpVdJyUBImY8hQCRMFxIldMWZ+dzUledAJx56q158g+JNfc+zCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0rZllqUst3ccBn24Jt3r7rDewJmP9jAN43f/dLmUnk=;
 b=g8t2yoNGTLSX9aF9HsEgV9dAFx2EFAEiWHuXyJn/A2OtrLuwfdwcoZMGtgSneVfd/69T0z9x+XcnfkTMhn3zN1CTGdaMjyT658Tv7IxDKGjjAC/j9M8BZ8f0cXtYcjoTnpqzrde2zWmtvhD/GnkPaUHsfdGMKPYB1u7GnbXzScwPD7VmzitJaWfDEei4e3/ICtKqqZ4hCs3zCDGrCee25WZN++XSnm1UMyd01tYvirdNQzKEA5Os2/JyroNpTh+S/8ejJ1sNLH/9jL+slLki4BhXR5PcwNQgcykn5z+dDKYXav1HopyHT+PPyFff+yVgMUIFhIhsd4zXwOZ/gYk4Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DU0P189MB3184.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:59f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:22:13 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:22:13 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:21:43 +0200
Subject: [PATCH v2 4/5] bitbake-worker: Allow tasks to disable Landlock restrictions
Message-Id: <20260914-landlock_try2-v2-4-0a1bad3579ec@est.tech>
References: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
In-Reply-To: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
To: bitbake-devel@lists.openembedded.org
Cc: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789410117; l=1175;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=5m8xZkun4kXpNzoeNSMFv6rl+zaoXnBmb89UPGpqhZg=;
 b=xpVGJ4PXGtJiS1pSsxCXbPjyE5UPjPa+xFylzTZDdLVwe4G9c+mV3VUHKZue7lJBesvEELgGB
 pYjM2C9TyRxBbkh7lCCAipdVENlsQ592kYwzsOF9HiEvb/IWVqtWM7d
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVZP280CA0019.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::13) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DU0P189MB3184:EE_
X-MS-Office365-Filtering-Correlation-Id: 8832c907-42e6-4eef-d6d7-08df128d1984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	KWboYo/glFuHuYlibrk/vBfm1hD/TTzHIrc0+1AZA7mJQh6yP4H/Mn1l/r+TvenXOBzNn+iV2jZffZuyxx46JL14BNsnNHL+UbI5o/iF9QfeQ+3CLoLa6r9fJjmroSPFJZfS75N6/xwwVt6cSDqaGNOF7OHTbJOeXhVE/uFVnDsVVxdOFwsBqnlqF2u0zgleXNAwXJ4mdEImtsTD6kodjHC/J0Al39mFtk2HkX/7RMTOj7J6jfJRriivvvaSLfEHMgH+yNA5yyUk0QvwMGbdV+gaf0ETwNR2Z74ZTqZ1w1wMIbPMRtnyiUnIHV1QOpZYh9gHQE/ewfqnXdblN4sW05mylWFzgJF9xfeDtCiFhsRpvAUEO8Dgn5KxiBA1dj8Zbuhsy/YElbDLLBCBhCRf7gPwbi1Vg9RdUnLCVGQx7USM4GENH9IK4Fnjvae4firx1WVH8Ym88e/BusAamw3rXzEvw8SRH+UO+NKtiQE459G3/lP3ieBnCE2iwj3OE7t01B4U+8jbeJhP7PuODC57W2S7Y4pKVitxMCCSgpxP+iEaugjvtirN99QUcHL4OocuwYhXIBDU5MJaCOTFpU5bz/ZQ881kxqXYGxUS/QMeEQIgVJdAZjJwaug8hIMAOoXILxQrJf2pJg+ZFGlwy/RfLZgr112VOb1CMLU/TqRryhk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTJlSDVrN3djZ2g4OGorRkY3ZmY5MUlLaDYwZUVWYm83dGRxd291WE1rNGdR?=
 =?utf-8?B?MUwrOG5vcFdwSlZ4aHRWM3loSlBHUW53Tld1VlU2NmNPb3ZJcGpYVHJxYWVM?=
 =?utf-8?B?VFdONkVxa1lpbTVtWWtFRzNXYkVFVWJhNXNCRmN3ZVdsYWQrSVF6Q1BwbmZ6?=
 =?utf-8?B?VExjbGVlZG1peStSSSs4WXIzMlM3RElMd3F2WTBFejVZMnJ5cW9YVEtSL2pD?=
 =?utf-8?B?QlB2RnR0L0I0Q1VEVWZmZlNiYnZOajdsZ200K285WmJhT0lHZVgvK1JtK3J4?=
 =?utf-8?B?a2QrOGptR1owS2kxMnpVdXZHYVFPOWNHZFlTMGFzQW44dXJrdkhhK2NjcnR1?=
 =?utf-8?B?S1NVM2tPNmRKWHVxNXBaSnduSHVwc2t1Ynd2cW1pK3FiUUVSazE3dXNFZEs1?=
 =?utf-8?B?M3VFU2ZpUFNOemZkb210OEZZanZCL25hKzIyRVNwU2E3OWhPS0xQRmFvSnE1?=
 =?utf-8?B?RXhoNUhzQUljTTRKdlYwaFR2dFpnaWxyYzE3SGc2c0c0SU40bXVvOXZqK1pK?=
 =?utf-8?B?TENxZTByaS9PUDlOSE5GZERYQWVoSE9VSFd3dkdSTTl4TzNiRDl3d1ZvVDJz?=
 =?utf-8?B?c0ovZkxjVjUwQlBXeHhteUZIcGlvTGp4KzluOHRvdXY5bTAxWG9obEdiZ00x?=
 =?utf-8?B?K0o2VHJhN2RlN3lhaHlTa25nZk1KQ05qd0UvaTNDVlI3anFvWkNrL00xR2tC?=
 =?utf-8?B?d3hMdmZrNXlkYVhZbmprS2NBcy8rTzdJVGk4VnJLSjRrMXJxTGNKb1VkMHRZ?=
 =?utf-8?B?empCdytIT0Q0WG5aL29ucVM3ZlJ4djFzRHdZSTRZSmROa0ZIaDRoU1dFdUl4?=
 =?utf-8?B?OGpjSHZ1Vm5xWWl6bWsvanZxbEx0V3dhT1VCeTFGQy9hTm1rbW9EVDRoVjlI?=
 =?utf-8?B?ejNxWUxCQTNxbEJ1NnpWWm5qZW15dGNoQXQ5Um5RSWNjRXMvNVNSbStvK3FJ?=
 =?utf-8?B?MFNSdUZFWHlDVGVzd2hiRm1CaG5pUHRNRWFRMSt6S254YjhReFowZjlpUHNs?=
 =?utf-8?B?KzdPa0NBZHVuWmEvdkNkcHJLU1gzYTBaSGJYWjYwNGNFKy8wQ2NPNXhTNFFu?=
 =?utf-8?B?dHRPUEJQckhsZjUzREM4S3lXSGgvcFkvdU42VUNOUVZTWC9HRmJoZ0RobzJQ?=
 =?utf-8?B?MTRzamNHN2ZBK0dtcnp3UUJXaEx4dW5Wd2VBc1dtbkxLc1RTNDlTSHBpb1RN?=
 =?utf-8?B?YjdpZFZueCtZdzViek1lWUZHMVQ4QXBnZTdQM2VrVHNHNmNJanphRWFaZjFG?=
 =?utf-8?B?bTBEMlNXeGJuNWQvTnhBKzJhQXYzMnM3ZDI5YXV6NFdzSHJTVkpkQWhkdGNv?=
 =?utf-8?B?UVcvaXJnYmx0MmNhbngxdGNTNExJRGJxRlJtWGRkK0RTdERlMUdNQ3ZUSmN1?=
 =?utf-8?B?M2ppTGNXQk1rZnZpNXlEM2RxY1Z6TzVmQktRRElvMDBCQ3o2MDJoWGo0YTIy?=
 =?utf-8?B?RVk0K29ta0VIcUVpNXFIU0pHV1ZaQ2FnSzFTV3VzSFg1S1lVNmtBNDJodzZh?=
 =?utf-8?B?OFNzUVlPL0JxR2NYVVI5WnU0VEZCWXdqVTliOG1sdTZGWUovUExvRlIrUXh6?=
 =?utf-8?B?RnRrbUpRdVo2ZC93UVkwZUM4eE4rS25GMDBiNXduY3R3UkVINWFxT2JHSHFv?=
 =?utf-8?B?L2NWaG56RVR0a0ZaN043dTNWMjA1cEdTaDVvYjl6U3l3U1dML05kSGMzT0Mv?=
 =?utf-8?B?WG5kbHBSZ2xmWVJNVWZ4c3FqU0tRTXhRN0tIY0tuTi9VRFIyYkJYOWlkM1dk?=
 =?utf-8?B?bFVZUldrNkhJc0llYWwxTzlKUWNEbThXTVV0RDFxbmhmOFFzaGduSGxiejZr?=
 =?utf-8?B?WGt6S1NYdkpwY2lkVXY3dklCeEtkMVh5dEhmek5DdEFxdVFocnR4MmlEeDdz?=
 =?utf-8?B?c3R5bDIxRCthY3pRRnQ0cWRsNE9qQVBwNmdoMXlzL3d6V0JodlNFTEZsa0lm?=
 =?utf-8?B?dnA0UGYwUXp1dkYxdW9oSTBoS3pGM2l0bm5nNG5hYWJhSDBvbVBpYWdxd1Ri?=
 =?utf-8?B?dzlYdDVzejBERVpsbit4YitPY05iSnVvV3JwcHE2RnpZVkQyWkFISUlJa0c4?=
 =?utf-8?B?MEx1UEJwWjFKVis5bStqOCtJSis5YW1OK2FRVnFvRzI0YkdNVTF3UWM5RjJY?=
 =?utf-8?B?ZEtlRkp4Z1BWYjdZcER5Q1FMNDdsVFgwTGdZRFRKNnBubVk4UWdNZHVYSXlJ?=
 =?utf-8?B?OVA5MFZXQlEybzNOeGNqS3pDdEg0dkpKdWU1N2p1VzNQNXR6WWJvM2xZdmxh?=
 =?utf-8?B?SHBmL3RpR3Z6dHE5VWF1b054RnFLZWtHWW8xVUh0dTNub0hZamU5dnRNZ1M0?=
 =?utf-8?B?Y0pNbDVxRXpSU3gyNEFGRGsrdXJnOUpwWWdOSXg5OGt4OGl6ZGNoTE9RdFJX?=
 =?utf-8?Q?L0COyQODmBpxeMWmsoVKqrUgMSO4p38D/ja9LFvpH+qkZ?=
X-MS-Exchange-AntiSpam-MessageData-1: 3zHYdmEbkw9IxLlf23boqrFtorVFJbLyasc=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 8832c907-42e6-4eef-d6d7-08df128d1984
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:22:13.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eW9OuWKb2CIn8uc9zl9E0Qk+kon9atEWqQ/5IPlkuJy2Y8Iurc2mVDnCN9NOqh1k33DNwYkXkDXMFUgPMjlFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB3184
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20204

Honor a landlock-disable task varflag so individual tasks can
opt out when PR_SET_NO_NEW_PRIVS is incompatible with their
operation.
Network namespace isolation remains enabled when available.

AI-Generated: gpt-sol-5.6
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


