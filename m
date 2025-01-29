Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F1BC02193
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 11:24:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.31])
 by mx.groups.io with SMTP id smtpd.web11.10287.1738149872854193926
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 03:24:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wGk2yFQf;
 spf=pass (domain: siemens.com, ip: 52.101.70.31, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALjiGCALJlq8JmFdNqvAZ0zO1pe0q5s6jmyzKv62kARx2eAPkKA0i10hTCm2fXOcY1bjZOZc6hiSvth6meRxudGTMNlZJAjlSVRFW7kE8Cq8WMhxHaOm/e6LOUGeWo6y7OtrJ5O6m5XXslPQY10kqDHnveF2OJ3bFlL6XgV9PdFueuZFrvLg/g6X8F0oY+OptuDsqTuErgqgtMjdFjRpWVUlUoTDHzZ2J0Q1dvLvlUUd51gEZltRTyX/qTCLQImnMfms/bvMziFLId0qcWyT0Z8ibwzSxakH5LeHuJQYHVuZALTFt9CeUvCSqsFFBtYhkMnJiSRaA0HEbFh2i3ECwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tNlCAi9Lby90d0H2KjFaOq0euYL1mpv4fN27HDAcsk=;
 b=vVMcSQ9cuSZcvR503F1PimwF6cagzjEZqMWTHBHR2OmkEYLYCV1HnfxdhUGf+iYWkfXKap5Mnjsn1q0NYgF+GR7s2uf2Kir1y5/hlq22RS/UnQwwScaLAXv0UXunum48j+zov/bTBwQ7idqfbQAtANO7wefjXUwJLB2z5K3wtCWffIVeV4jnKamASA8mt3TAJWWpL3Gh3HPX51WO3fJ5N4yaZQ3nGay9EXFpDVdA1gwwNYiGUVZW2IENqCTFRvIBegLupWvDdpLekGmIbGr50SO2em9+jBGZaLkM0+SBtYC9sy3UZkLfCZh8gzlH1BQPpcf01CamVfz0LBJ+2QyKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tNlCAi9Lby90d0H2KjFaOq0euYL1mpv4fN27HDAcsk=;
 b=wGk2yFQfA7ZpQwUFOktBlB2oD/OQIQIMb2Gdf9kNwW8veikTLsi4Ew0FRBjRZ1K/iR3FXo7NVyoUSI8I2pi8X4W4TRpGBVV3/TLiY/f5pjvl4BhCC3/3LLEhwJdTerwZyEZoxzR1M8ay/BPccnHaAR7WcEGabtfpi0RZ/XS+dmxXkUy/4sbrXXuXybXA5jEObzPYEGsTzEt8Akrn7Tp1EpJmi+IaYd+4ifuE5a0xeb1SDzHZu4s0uwFtvvHf7yO5UZJSUQ2tB+2t6qaQR2VpQdutoSypAQUdBwwGGrem/2/ql1q9MVFxrkjWPBuBraT0JZDEQNBQLLDQVluantwVQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 11:24:29 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 11:24:29 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH 3/3] fetch2/git: Add offline build support for LFS
Date: Wed, 29 Jan 2025 12:24:06 +0100
Message-ID: <20250129112406.1660522-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129112406.1660522-1-stefan-koch@siemens.com>
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: c339a6b2-0cc3-40c2-03f5-08dd40577f27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UlusUnhT3QnKuFZzXtQODlljdCoEuyujH5B15OOZDrsc1qBqt1vavj8Ych08?=
 =?us-ascii?Q?9DQWCA2A2SjwBtg0njxqqMgeLlbXkC4VO3Gmf/sf16uLtMCJ1O1WeEkIn5Xh?=
 =?us-ascii?Q?HNfuwIGEolopSxePLcnb1bfofuhe62EvAy0IQZ9NKP9qSvs6vMwkiMsqr+72?=
 =?us-ascii?Q?qIoAsyqDkRxxzS4t38O/fsBguDQHVeg0UHC5KrgD+LPAWny8BHEmD8B2lICD?=
 =?us-ascii?Q?LNBAN9fChCYUejDl5SJIjPTMC8i6T6683bpqoC3iGiZcfsRL0RO29/44Evsy?=
 =?us-ascii?Q?VOmB1U4XlbDWGpZE4sNqeHobXCewyLnDhLIYYifkhVWQ7BV0iedzDHv8PukS?=
 =?us-ascii?Q?cpL3JzX+HYTCj6KI/XrC6NL7/j4MK2zl3G8PyvJTMS+1/QCSSkVNRFWb5rIN?=
 =?us-ascii?Q?ExpBx281D07SPHa0VmvjbIFZUgW5z8o6Kqrp3hoGStaYfg1rsqOh8cYkytzG?=
 =?us-ascii?Q?25PqB81qGWASKKYVujLtUrCCvs+TaUyD73QQwDdW7gGhpkOeX3LPCIVak1DF?=
 =?us-ascii?Q?KmP29v2n2IUmPW3/WY3QGoreyaO2T5R14VdYLart6nQ6Y9fFJ/7ScGQGmkV9?=
 =?us-ascii?Q?3PRYDWjtNLJCFk1DiWFGmhxZ3SsL31AO30XvjmlqeOurwJpWTSQmC97iQXpJ?=
 =?us-ascii?Q?/ay2PQnPeXgTc4fQi0i8Tw9R9HNprPd5WTufgVldiAP7M99OmTHmeuBAEOmq?=
 =?us-ascii?Q?1QK5amfKmdd4miDi389z9maFtepFuwwqQRo5mlhgmhRrq3DPyPIKC5ugUk7V?=
 =?us-ascii?Q?eGLFOUls4EWS6ng1StAe5+W/HOR+1JtVNEST3PaLN3nYj50p4nY2ImBXlNig?=
 =?us-ascii?Q?XLqfqyXZIKlSW3qj8jEZeiw7rUQMfexJVdqu6edca42JgLyY2+ljTjkZSwaH?=
 =?us-ascii?Q?TRhP51cx+/VFZK1k7hkPt6c8GcB0YVDFw8cj7DOWcZOW7MImqmQFTFBevhCW?=
 =?us-ascii?Q?YMJt2VKTl2quyx0c89ASwUERa6RxGG6b/CEDbYJTrYl5kte6rlUZgXI+dH4Z?=
 =?us-ascii?Q?YVRdi7rDcm86utY12s0sXFi/6p0yiR4N3GkZFoUaXWIBfQhH+Ni8v625NKQ8?=
 =?us-ascii?Q?f/r8CCwvIpnYXP/8bOsXmkPrzajONuzIlMkKK8r9IAVqFJkt4BimZvYGFmSv?=
 =?us-ascii?Q?jvUxdlelkezy2Eysz05f3y46xw1O5yC7mIDIGeeyxjaV0YsJav5ymydwkoZK?=
 =?us-ascii?Q?9iJREgGPjquSAai1lFnaFs3x1KpIiuhmZA3BBSM0GtbWgkfgizcJtjq2gBqn?=
 =?us-ascii?Q?U+vBuTk0aaURMYoXjRev82CTsuu6E7r79B1Lf7OmMmyCJLrqgQ9t/voiNKyP?=
 =?us-ascii?Q?VHMoT/ptB/QTG6kTRyvadYN1h9B/7+SvCKTkLODSbFQpTyWI0x4lmaY09+vP?=
 =?us-ascii?Q?Ffmm39MU7tamMfOYtGsRtsrYABI7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t5Y852fHB+wwTIjxI5tMCL6VLOE7tT0YG4meehv/aSX4lGMSTKXA6Ju/oBAM?=
 =?us-ascii?Q?v4m0Gd49S45IU9i/oyn6yQIhiLY/x0jtDnjfvVwRUDm5h2nBXmDonIJC7v1E?=
 =?us-ascii?Q?7F9fyzZX8kZzXa79Gt5Up+LEv7FbaakYKhOU7b/JLjQi2qlOHsJ5WXpmD+bz?=
 =?us-ascii?Q?6QiRFdjjHyBXQ4Ihi5oFq2U0a5qOnT2yVuBCtUMMdxt4orLbaLUcTNqUaTJt?=
 =?us-ascii?Q?Tg2nImEBZmUz9vz165r++ul0KKhNQcY37DB8l/TNXJWyJzXPAyJmV32d/aLy?=
 =?us-ascii?Q?vMiHw6XcE6MrWBlHA90IvTfNDWeb94OLAUiua9gJz2qDuCj0yzmuw35ZIhVR?=
 =?us-ascii?Q?Q6oZLid//Y7BLC3gUw7CoE4QDJ6Ik3LlbODCD+GAFFuPHKDiN5rJyveEglyz?=
 =?us-ascii?Q?Y6psBYVpnrPB/wyA7ZRFHdseDM3qDlkdBxL5Dy1c6woR0Qpw1aMIOEonTuzy?=
 =?us-ascii?Q?kVn9ZlvxcpumbTrdhUQ2Mkb2X6zUciC3EzmcMMfWIzAr9vAIiyQ1/xwfdrpG?=
 =?us-ascii?Q?B7a9njNtAJZ1bFfDhonQL9wjtrUPIY6kFanTJjaeeMbwfBAI5s6C6TfnbUfS?=
 =?us-ascii?Q?bI7UkAyJqEaDR9PRIzkeVjdl53SHpFjQf1TpFxvAFS6ul+mvY3HmfiFCad04?=
 =?us-ascii?Q?vftq9l4J7S5KaxIzvDp0ozpmPEXt00nWrInkB4spLRqe1REHOHkcd97qOyHz?=
 =?us-ascii?Q?uoIrhm1+OoPl6/xayARw/HUMwV3b5P8XFuoHxLgW28Z01BgjrsmQ+zN4DeZg?=
 =?us-ascii?Q?h9dQb1q0ysOQhbD3sppijzcFqFEQS/XQXSx3lTej2Z10TE1ARQGInyQUzl0Z?=
 =?us-ascii?Q?OrYqGZh3uEzFAm7hzcQaJJwJaaiS9it6XbgHwj8TEvQ4jyRLnNo4yN8TwEeM?=
 =?us-ascii?Q?t9KqECK2wKZ8fot+5eZDDSQTGNQ3mlX8MA20LrAWpg+LC5/QOpAlX7oH+Xpq?=
 =?us-ascii?Q?HWf+Gyoe2hjTXPhJO5NfC9vYVb7Yx/w+cb0mDg0+vlfoeqHAlJWsKfxDMkHk?=
 =?us-ascii?Q?JdWR1nd1riRzl5utIf79DtW+6i4nOgtdZFqIXJe2xTGI+YRcvJp1856PhPHh?=
 =?us-ascii?Q?rBg9mrtFJ8zDnM4wwQAtblF6ANDhzhj5428pli9G/tRZbdX7v+kThIrpIUW0?=
 =?us-ascii?Q?asx+eu6G3tm6i26MeYEY/NvlJ3Jg+lGize56zHD9hgXnI3Z0jYRhiAsp1NYc?=
 =?us-ascii?Q?5l8Ze+AfxaQ2i8XoHZGiJUGwmkLKOeZYBx2/gM/Nx1AAe9c94DxJDEAkPg6s?=
 =?us-ascii?Q?3BtaLCgri5SzCrL/31h4iCdJ9kvON5u5Nbt2t5P8YDNxyFu9rf6iL+rgcw3j?=
 =?us-ascii?Q?6FpyUqD1/4Xu5x5upPGLB6DH0n+aMLn14i94ibQT/QSvrYXTwBumRN6ydaC/?=
 =?us-ascii?Q?iU6A+B/bMsbRieiDazJqAJ4fdyq1tMBloY3XcNjnZSc2CbOtpq+zUu0CgBy6?=
 =?us-ascii?Q?EgnAF1+rb6w3FmJV0s48ms79+2x5N/Vl7wrl1juFXU39jTeLrrGo5T37+I7O?=
 =?us-ascii?Q?e0ys1N+NE5bqped5rfMQO0V0AJsJ5YWSwFJMgBlyeuaGT+gKc0NbK6/TxUnj?=
 =?us-ascii?Q?OouUccdDtMtWZRw9oW9xqKsH0hiFYCNhphZPcYCLpIJH/qL4bP9gZC3MtUtK?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c339a6b2-0cc3-40c2-03f5-08dd40577f27
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:24:29.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mn+dCKcgx+4Y16UckC/u1RuIW2kbs5ZMaIUmHSsU6f0Om9hxJrythXuYlubdkK7vg2iu+hS0stQE7/0XcIYefQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 11:24:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17111

This adds support for offline builds for repos that use git-lfs.
Offline building is enabled when `BB_NO_NETWORK =3D "1"` is set.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/git.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 7ac690bbe..b7d36c3f3 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -507,6 +507,7 @@ class Git(FetchMethod):
             # Create an initial regular clone
             if not shallowstate:
                 runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
+                self.lfs_fetch(ud, d, ud.clonedir, ud.revisions[ud.names[0=
]], progresshandler, True)
=20
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
--=20
2.39.5


