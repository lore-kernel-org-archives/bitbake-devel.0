Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE65CD4F50
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 14:59:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10317.1779116357389699772
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 07:59:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=Whir7P4h;
 spf=pass (domain: est.tech, ip: 52.101.70.20, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNDqoPY10ScP2JPaSvuUd9eUuWTi85rHtG9WtXMGzxWdSCnv6Fqqq7YYxa/uW26rOioNVjHb8X//I8JolKHwb8CSWC36oeIa1oEm0/FFBaXH3FKide57e1vjGn8PeDqLEXi1RjRFbp875ZsWr6W+FBzepf9GYbjQI9sZV9qDqjcNUC+NS5CuzlxXAoluASKKwhdYMgjvCC7VSrXGDZgUC2ummfpn24eaMxQ8ZMxgstksWRXsbpaCDcQl6Kk3pj6c2aabP4t6zjSBagq4lvnrP5XdAwovu3rvpxpNkWcymTjOovXBd9wtR6eYGBbq4lfHkjajDX3UwbIwokONip7yQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIjMSk6uVa7pozlTGW3U1hDJxaw+wJ7m/UXBwsu9Jho=;
 b=s+dVGkumUtpD7B8nNriC8ArtsibX7psnPFMBboSpF49rfpK9WfD7W+xCk5Z2HraJsd90i2uBVeKx+XnEc68nvUNo6wE2U0898xtzNqBvFtCAgzpE8iRXgl7uQNpGkDBOeuJsv3bFuYtGfXtX9sC7FmwmG5jZFBTbxDHWHfJRqj8g3qZPgEjB9/UByW82rApaaMNCb38FhC8ZwZ2wsnSzi231bL70xL8dHH0mgl2kay3s1CXVsF0lP2EZX/BRn/yIEUEgWaWWm6wrUHz3mqLT6sHJF7xI/PJbgqz5eZ6sDc4hbreB0OFncV+7iz/T8YLRJ2rNLgCBjWNB1/F6MgVejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIjMSk6uVa7pozlTGW3U1hDJxaw+wJ7m/UXBwsu9Jho=;
 b=Whir7P4hJFeB5pk3M9f7gHTo9bvdI81Cw1uzEHTsP4Qat5ySdKTT2/LwsVYyTF/s4OBfWLw5wMufecG9sp3FBDIReq7pvce/+h0atjvy6xuHRfsm3r19HKm9ypCxFTnDulNrO+7gCPaAljqEiuUbRpvSFaDU75BKtuUIE7wX95HlpzUKemW87siCVvaPNvnHxBTQUVagvAR7Y9c45nSDExCvwPMPK/1sbcExObX3FOYg3pVfqPNElUigfzZejEqp3ekxFf7YBfbr7WCLKBo3bq3Phz5OtvAWPjDHvC4AOehTC6EIH1OEmUsX5+p/C918msyKHBMa2wceT2kHc8FmWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 DU0P189MB3274.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:59f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 14:59:13 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:59:13 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 0/2] fetch2: harden deb/ipk unpack command argument
Date: Mon, 18 May 2026 16:59:07 +0200
Message-ID: <20260518145909.1132755-1-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0143.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::8) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|DU0P189MB3274:EE_
X-MS-Office365-Filtering-Correlation-Id: a540e2a2-f935-41b3-709f-08deb4ee0643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	tYe3p4uzq7ads0XQDKtDrAhBCGCO26tQ0fL19rh4oBk6Z3lSixBoc8O+oQGFNwNJ3bjTxl9VoL59CE7JziTZkGbAegknoPonJpGIowXl+2QIcUiOs+pKRRrM9EEUc6tdMQrF8UcvwEEYvE2ZysQ6F9QijrFL6s0jbY1WA8LmKvFzbwo8HrbD2uqpSnCVUL/wEU7YGdmiPUwK8vO+gIwZXYNLDWEaPdrXA/P+otFwjmo8mT6fjR/GbHfK6uFhi+GtZd9JAxwo0BAqPiTDh0FXTDsCgYlnek6/O+/vu5MYuWxr94/IqU+jKGiEA028a/AWQNjZoZaF0V7bG5OEnHWe6qNb7no2NIYUQlRRkC2r7MCqPOkMawcucZnfgVhDwSN/X/LpfihP4pxOCRMtzn7z9l+A+W4cTkd6PtC7RcbHD59l47pVo1ue0Cip4/Pb2vTld3mMZGK4PMc0e+OsG80UcsZ95DNUzJ82KB49+rB3LXjsApurBuIuQaDMIz4KXj9Nf7E/bCa2P1EnoRkHzc+0xQSYtPc+SvZ5ERkyH5QQ+85IrXUmNdTtPpMkPBNzBf1AbDRJBY7jPPfmb3RYmViwbbmfw2ji2ohH32qr87PowEagJT82EBZiaQXOK/24I5GsqZ7j27E03OrF0sJH1Z7FR+VZkiAC1Ubb1adD1lvQEFbtiZHcW8leSY1iAXcsHN8JLdjWNQX3Wb6NnF5kCfKGPg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1bepG6XvRxOJEN7Avz/MRtJD7k8iMOsdOYP9XQJHDBE0/vqHPftzjrsn0JnN?=
 =?us-ascii?Q?LlXgVEvbGT63fHGxQmAa25o6yeMmguqD6pe44khukjXXe1Axgm1BLRHGUPHr?=
 =?us-ascii?Q?8avXhWI1DjCq7m9onYNYNpf1Qxaa9CIgPpxX4oFwWSMoTwEMWlV4PGFx5Mef?=
 =?us-ascii?Q?jhDv+JNaVta9x9uJJDt+rLXvmcbsfc4z5FcnMZ6XW3A0CQNBejv36arRE790?=
 =?us-ascii?Q?iiGS3njAC1TZz2tTFFlJvuA+k1NJUTdCkWdY2iYS3SuMaTERwQjcnPaZZVR5?=
 =?us-ascii?Q?gMDk/6Njre0v52Oa/gevugRXyfUc+WJCdqV1INBJPCkGVf43w/8JVoueHref?=
 =?us-ascii?Q?HsyL4O6eJ70PNB3nugKbrHF6bkRfM/nl0Hwt3UJB2eq3e3rQC/2lEpzTe1uc?=
 =?us-ascii?Q?mRlQV5Ka+kbdFfC/jIV/6koGFDuAymk0P64FpiKV/NFXcGIh9Tkx3YunBW/+?=
 =?us-ascii?Q?KK1kc02Bq4ivyR4PKQorrD8M8eQatW9sRjBqGABGgVpbW/lX1DNAbDdgg4I7?=
 =?us-ascii?Q?Wtjvk2u4A+zTVuqRdKlGsVOos2mpzbJbZJOXZqSgavt4Y/MQcnkcC4RItYnB?=
 =?us-ascii?Q?8C26EpWCq+SeVBDYdrL5yrrTluiLGC7AFj8vJJwjgj4IKJlplt1/IcxGe9Zf?=
 =?us-ascii?Q?shQ3VIPgqXM1Bxb9az0RQYcgujrF04fcKBQwpwjJupkmY/xMQeG8xOuwLICE?=
 =?us-ascii?Q?hkIvCcTC9S8+6lEMWES2PYsEYdHbxj+gOsYNWoOG1l974O86uOav9CeRI1wR?=
 =?us-ascii?Q?CJfY6A0NM1ZvdfNk7SVHQY2/umtZv5GVWCMBjWhONWu7HHOOD/3Ll3s6zcd8?=
 =?us-ascii?Q?iLje5yQq0oVRKwQ9uwTBJEKFLItd33utFFh/eLOMWdqqlQKpuUHpaKeOB9ws?=
 =?us-ascii?Q?LY7z02fkYJXUQ5nZoVkz+WzKhwaCU2VoKEFyTs7j7dkLZfaC4c0ImZA/XlxZ?=
 =?us-ascii?Q?gDpDG9ChyeThkPdhOKUOmBiujLSjBW5PYMP/jogOmwRF/f6v49DQEN7+yFTv?=
 =?us-ascii?Q?mzpPmnJzXeGDxnq5cLAX9YvYcBcq3FCNeBY+UD+JcUl2FkB8UgzfTMENV7cm?=
 =?us-ascii?Q?Y/KoeoCerhEzBfGzZxQQDLn/nHHcw9MI89Dw6XUKQZ5cG527ruxwct8GP4Pr?=
 =?us-ascii?Q?OiJLLjJ9pexRZRMKTkR4It96sQ99s/8clfR2OwWRqu0TxuK77RlcJCfuCp6v?=
 =?us-ascii?Q?vg0mFazEIz40rSecL32Q9L9pp4vUwNM8bDSM1pcvqQsbrQQLQBNLYCvCUQKA?=
 =?us-ascii?Q?g4va+ZEreaowL0HoU/+uE0mcraXbbNYV6TziB+aui6keFVYNY3hu5D3VNGt8?=
 =?us-ascii?Q?IYlpAsSmhKqdFxt57bKB2gtZsvcuO2Fle+t1my2KoR6Ljq3Ap4cVnHwPfzoM?=
 =?us-ascii?Q?0lCmEQWwYzw230fRPF040/NnD6kovQnb8I8BQFs8HclKglx6ls3XuTrjT8Ra?=
 =?us-ascii?Q?kVaLP64O20a4OiagXzSzHg+cC8Q88TH44g8IAbH4ERHHj1dYFy5xalH2TXvu?=
 =?us-ascii?Q?PyzhlwrLm287+QzBNgwj4x5AND4KGekUdIjDuFkHFlgjhZl9l8VUFfbnWzC/?=
 =?us-ascii?Q?YUOzf1Tp9WNKaIjg1EQFYTjS/8QSsz2UHuWdBZoTNnBHcYcvaTJeiph2dJkW?=
 =?us-ascii?Q?JnQqCOs6aIDXJ0EdMo2ez7E5UrXdHay4BPhITNOi+Elf7NtHJhjWle/1YmX+?=
 =?us-ascii?Q?eOK+pEGAkdENavPttDY4aWHafog94XxS8bNdMOsZ1LV6YS1N/lW/Rd0NPCvz?=
 =?us-ascii?Q?VGhyVqpbqQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a540e2a2-f935-41b3-709f-08deb4ee0643
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:59:13.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdNd4GNFAZ+s37cnWIwH43+4Q4e+Ekcnig/CGQSDqDS1lFlAvZBBFpHG6kvZneqtQsLKnT2UkRUXgtIKtrgsNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB3274
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 14:59:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19539

  Hi,

  This series hardens fetch2 unpack handling in two small, separate steps.

  The first patch fixes deb/ipk unpack handling by selecting the data archi=
ve
  member only from the set of supported data member names. This avoids pass=
ing
  unsupported ar member names through to the shell command. It also quotes =
the
  package path used by the deb/ipk unpack command.

  The second patch is separate hardening for the striplevel parameter,
  which is appended to tar arguments before the unpack command is run. It
  validates striplevel as a decimal component count before using it.

  Regression coverage is added to FetcherLocalTest for supported deb/ipk da=
ta
  members, unsupported data member names, quoted package filenames, and inv=
alid
  striplevel values.

  Tests run:
      BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fetch.FetcherLoc=
alTest


Anders Heimer (2):
  fetch2: validate deb/ipk data member names
  fetch2: validate striplevel parameter

 lib/bb/fetch2/__init__.py | 15 +++++++---
 lib/bb/tests/fetch.py     | 63 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 4 deletions(-)

--=20
2.34.1


