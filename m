Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A340C88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:29:33 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4556.1789410124949907937
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:22:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=kIPK/D08;
 spf=pass (domain: est.tech, ip: 52.101.65.30, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh19soFJ6z+KYFvvWa6YlfKdkkVANHuuok11Ati9ZV56aA+U6BKLEi+4Q5rgODiuH7ngO2FYpeaQe0rWZHQ0XKIqpFHKcdH2Zx7gTlzPw+x8pSTTnkqFMi2SypPr7e5ZKWd3CnJ2FA3azRq8dr7M07N27mAlAL3dfK0FqnTK7GLaztsf38g/F5XjEj82RxurWxi4jswDakbdarxYNA0IzFvcfZC1e4lMxN+a6B0f+g5+XCInmdCJURGQ8kWa7LDXe7dPpyz7UZqNZlCA+uUquc2SVrlEHbuQRvyFLr8jqv26uA3q88EMaqEi5mg5RfHimptY8y5qZHkk2brddk69jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVJid1fz9VK+CSsmxZbkeKFMoUeFrlD7JkKrvD0dGGk=;
 b=jmx5Sz2RsK6kUL6zT/zqBj3V22lT52gltMkJ4eRdrQg00moGkV3UCdg4cH1WjHJZZsvsU3jC2qoqhvasojALkpKVDAUQ+u4HXQC5aHF8Qc5QjJmAPlOvCmCPtqc0J5x68kfRpKkWk5Q3nRNA7TGpSOhkscXzHkL28lKVXYf/aNElREPOw6AbxCt69U5iEfeMgCQRo39TnYvWMflclBHvN1Tr7v/PLX289ORa/+fbSA6sH0hWLelhthjY8huvM1gsQE+SywkrTuiPE4gLg7hA9jiJ6cDywPeuzigC+Ad5RrEJRh0503YJhrC6GztKmdkmjtOdpPsAtTUJRBVzVuv8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVJid1fz9VK+CSsmxZbkeKFMoUeFrlD7JkKrvD0dGGk=;
 b=kIPK/D086Qk/oTA4jOI/rMM8RYEx5GZtGskJ8MdC3VX8AgpAxnszEPQ5T0mg3PiRwBtcMhxU7E6fJX6EXHsgZZ2D49id8d6Ol1RVD4QDNV1mSdNi5BQpcvygotRyTgc3DZP5K1Z8JLZw3zjL38inhqYVWt1f1dDqdpQYDDZmwFuGuyGfb2niANWan7tp3Xy7xR8QAt46MKh0fHNTTPO0GAEOGFs644FrNEUOtkxczsjVg4DigoOMA4TJCqKNwsnp+o3aYvLN8f9NbuBHvUszRSn1Q6Pr6hyU5SWmcmChSphFZevJad/NUFjI3pOCmeO3nQZqHcBwH2e+8Pzx8eBdow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by AS8P189MB1302.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:22:00 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:22:00 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Subject: [PATCH v2 0/5] bitbake: Add basic landlock support
Date: Mon, 14 Sep 2026 20:21:39 +0200
Message-ID: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBSA4VfRubaaEfEqktgODhptI5J3N1x+F
 /9/gUVDaKEILjC4k6VFe4gwADk0ukdGyhsEFynPI87mRqt5kVPtzClYlidtnHElE1Tgm9VgR8f
 3K6vfdmtHlO6dwH0/qvuMK3EAAAA=
X-Change-ID: 20260910-landlock_try2-794b370dc4ed
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789410117; l=2595;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=imfnDn/M6bKN8DJ7DHe4sLvaAMIxII2pCih0A5lQT2I=;
 b=4ve+dBn5HM2TLrBZxH4hw/MXTBmwc1bV3N1peCOO4ZgqCkMGW1X+SWWQ+ELH+G76IyjI4JZSh
 sGSvAdxm6aRAlObY5MKvGoYhhsc42CoDVmyJ10odXPOJx0/htojvoAJ
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV2PEPF00023954.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::351) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|AS8P189MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 089a7edd-493d-48c4-1e53-08df128d1195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	n/jnz1fnmrYtRBCip9kTrmRkXgBcOQbmLvaYxO97RehIL5Tvgaywzqtv4teA6RIQ74Cpscp5DErmFUoC4BHRmEG43GUiHLZ+GEkCFSMmfmaf46jMZ6Fsd19jO2OfeIsxGlo8RP4HrFgU9Rjw3xQMdTlxcGuq1HfVMQj+M9OA+M+c3Ub7oBjG7uk606Z82c4Sg1tTofd4KpqjEOHyYA6qNhwa1D97aXx5e92nGCHbTMhDXHEzL0k+aondGVkYwMWB1C3QoTuSkFibwG9czYsdUqslMBIzT2p36f9B3q15Uey7uCKOTiVH9WfhCIxqTH6XViiFUWvEH8iXMCaqc7qwghlXq7TeMbcQyKZ5v0SIWO9GDOaHDCmd67AZ6V2+t32lR1tggQNQAsanYL01j2fAaAts7IyyE75rJ+7utqylGC28QD82Uy/T6kbhl5X2Rgj/hu4RK/tpTx6hKMKp5MwNQtWGNxWA40mT1HR0JskA3q4jPl6IMCnmbQEcuOHraic2X49Djx4sA5RNd5lmbpoZuJzRF45u/vFvwAjvnwPmIvS7wwgvmr7N7/XL6CtLF1Mz/t5GBJ1LW7fDTL+xqJeqYYbu8YQe3/U5NI+Fy6V9qektE1oCU8qvi4EZTh25Pt+RSfQFsbBG8UmbrCADhQjWOgPS32Ztgz9EeN16HN9dZ9k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bKZc5rBep4lEvHw4fR+oenKvfXEzdPUcgWyt2kBeGYMR5wENdafuyrRnuCxu?=
 =?us-ascii?Q?2bC6u5fzh2JJIyMJqfrXUwQEmxTF2RWvn2nn4QW9rieYPsT8fVIA7fDf0ouu?=
 =?us-ascii?Q?AiwpLGOt23KJWAOdwZir6Hjpi+oyOaway9pSwjc8vtf4c2L+4LL5H/hIS+1c?=
 =?us-ascii?Q?4I4O5Hf9IjWzM7m12jMz/9QF885OapKTCfMwcQsMKBVxNyWEiDkttAwJ4NHD?=
 =?us-ascii?Q?toLPX7vYEW2BjceCByrn46bYsIVE7r32I/5Mq+JQA81M3VxWY+YRDeXlrpBN?=
 =?us-ascii?Q?+bPcGCNSCoI8v1fNFUbsxh+5m8hKrpKc+KsdnVbHdVhoSjNl/omibJykAseB?=
 =?us-ascii?Q?LmfeH9eI0fm7VFa4bpq6P+MlWzlYImboLcSZe4vvvi6L24yci0gsAd4fphds?=
 =?us-ascii?Q?P0OHDDYdrFSMpTthJqFcwSAhE0p8/ZhHvHKdwDGEfbIQYiPoJTdNtkMZWSoZ?=
 =?us-ascii?Q?Er4fu1kO4xEGBbkAoyOHsKYBGi0KP1I4coJfuo4htje0CBDLZOJek1OrmLh/?=
 =?us-ascii?Q?qqrzWYTwpBKeiLqeYPEsph5iVbCZHj18kqBKmp7kO66/3AszRdaReD9cLTvE?=
 =?us-ascii?Q?Plqjvmqmy5ts6CJNlBfG5adVhuyLKIy1bqr6w/dTxP+ohzdHdye2rvBUSM9c?=
 =?us-ascii?Q?VA2qOJQmZZEoRZOkaN8NGM41r10YQVm2BK9enrYe5+lki8NxGPx5lYs7xGrH?=
 =?us-ascii?Q?zY0q3cqiwmt95n9axSW3WLYccdSPc9CrHiaEu0gpH3uwqiUVhMBLx0ARgYv0?=
 =?us-ascii?Q?WoUff0iCUXVWvknZR0J4lxDM002MLa6M6IOFVFbPCLE1moRzdW+/TrFuVx1L?=
 =?us-ascii?Q?e2vJUnleSI4djkZTlalt2R4q5TrUluFTPRO3Tz6hmdjaGlve2R2A+z7nruvE?=
 =?us-ascii?Q?vdcsIFK+XM9Zps0A5xyEovAKLfKAdw0Nn1+tru0myaI/h9VCCm6eGoeYvlPi?=
 =?us-ascii?Q?RQYNuuRX+Cfy3xUuTWTOKaI69GCw5G/JnKfY5HmpfrI8+MZZd/uF4AXd5g/k?=
 =?us-ascii?Q?0MOZqeTBiBGbVniDKAOkFdK/Fdka43USgsE2jTk47OKS7BKQB2do/rOReear?=
 =?us-ascii?Q?H9f/NAdBZCw+R/T4SnV32coE+lKBHRNGdPkD55EfWW6l7qVSAQYpPEfQ/wYQ?=
 =?us-ascii?Q?zjxwVyLFDwl16QowlFVqLYUkSBgkRNKe8jVVwmaljKfACbUCWM0sJ9k2G1u2?=
 =?us-ascii?Q?he+6f9dewy+ABQjSWZQqQjFAHr0XoE4yH7bX9lGbI1Rzjpdn53cEtW4wF3kX?=
 =?us-ascii?Q?87myZhar70e/qvhHzorTthdABiA1WLagJfeugGFKnUBvmGv880hSosu46QnF?=
 =?us-ascii?Q?BMnG5nLkDeA1lm1Ui9Na52U/qI8ANLAD5I3hhrsYABpY6pY2R/HX5kd4nSIU?=
 =?us-ascii?Q?ORJbsBFPn4gCQxeU64GU11UkeBgKugkoS0jPztPFVu2T667nYxtX8Trk15Rj?=
 =?us-ascii?Q?mYfolBfaj2cfL/wYUHA5qpju40iGEsqU6Pe4+Oi0+ABYvsPTULzb5C36eQEb?=
 =?us-ascii?Q?IUaj9hbSciOKVfW1yuXp/1mBzX5YruIU971fTmFEaAtqmgkdMwpwHtPXk4C7?=
 =?us-ascii?Q?KVrzY7KafwxlS8D4D9fbH0S8nB97h52J6c3JzR/N6RixvFBXzNfiVxaIdY29?=
 =?us-ascii?Q?htC/npnRKgaNVEuD+jYDVRVx4xHUs0RzY2RsxilFRH2H5Qhsy9vpTwvfCnS5?=
 =?us-ascii?Q?VVFmO8ngEFDVq/E4hOzSvFtUz7coi4jyQr8nDiUV9XHFRiHPnYExTCyNX3Jp?=
 =?us-ascii?Q?rQ8NkRhrL2j5YWA+YrHZMtfljtAXCsCbLaSvk9f4C9OAL9+jVWlfNcBuxgDY?=
X-MS-Exchange-AntiSpam-MessageData-1: 3T/8d+2Z9qx9iODg+xpod4eVHuLudc477oE=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 089a7edd-493d-48c4-1e53-08df128d1195
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:22:00.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aL4jboul7etb7TsjftpR2kI+tYPg1ReR9bQr3JFqZdFc50bT1jl8vSx22rF+ZxDpRzex4P/Ts+48OD8pKFT7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1302
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:29:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20200

When current implementation runs in an unprivileged docker container,
basic networking will be allowed by default in all steps, ignoring the
network varflags intention.
Introduce support for landlock blocking of bind and connect, providing
basic support for blocking TCP.
UDP is corrently beeing worked on upstream, but not yet supported.

Landlock requires PR_SET_NO_NEW_PRIVS for unpriv usage,=20
which is also attempted. devshell and related are already tagged=20
with network varflag and can sudo at will.

This changes the default task behaviour to set no_new_privs, and=20
the 'network' varflag to exclude no_new_privs, which is needed
in a few places, like do_testimage.

syscall ABI is asm-generic, 6.7+ for all archs except alpha.
On alpha, we leak 2 fd:s in the childs context before graceful exit,
which is cleaned up at child termination.
x32, MIPS(except LoongSoon) will fail gracefully.
Don't have an alpha target, so this is not tested, evaluated via=20
static analysis only.

Adding Bruce to CC, due to fusermount usage in vrunner.
There might be fallout in other sublayers as well,=20
give me a CC and I'll try to help out.

Adding Peter and Mattias for awareness, since they seem to be=20
users of enable_loopback_networking

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
Changes in v2:
- Make no_new_privs unconditional to linux version
- Add landlock-disable varflag, and document it.
- Addressed review comments from Paul regarding constant naming.
- Link to v1: https://lore.kernel.org/r/20260612-landlock-v1-0-77891f63ed7f=
@est.tech

To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Cc: bruce.ashfield@gmail.com
Cc: mattias.jernberg@axis.com
Cc: peter.kjellerstedt@axis.com

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>

---
David Nystr=C3=B6m (5):
      utils: Add landlock_restrict_network function
      bitbake-worker: Call landlock_restrict_network for tasks without netw=
ork
      doc: bitbake-user-manual-metadata: Doc change in default behaviour
      bitbake-worker: Allow tasks to disable Landlock restrictions
      doc: Document the landlock-disable task varflag

 bin/bitbake-worker                                 |  2 ++
 .../bitbake-user-manual-metadata.rst               |  8 +++++
 lib/bb/utils.py                                    | 38 ++++++++++++++++++=
++++
 3 files changed, 48 insertions(+)
---
base-commit: 046a90b0e9b7b914b7a95aec579cdc3fc9c7617a
change-id: 20260910-landlock_try2-794b370dc4ed

Best regards,
-- =20
David Nystr=C3=B6m <david.nystrom@est.tech>


