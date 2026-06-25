Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2895CCDE006
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6004.1782371281365926738
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=txoLmtja;
 spf=pass (domain: est.tech, ip: 52.101.84.5, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itNKvOuzX7wg7o0XhU7/tKedS7y8vIdHHa5q2lvWCls8z/9jzvZxeAa63IApMwI7ztT7+WhHS26V2AxP6iJdXzYf8m4zBUjUt0zbYTjm+UmsYovhFYOesbQccCm2BqILJbZD7XJuWsvB0g3lW6Eik/Uw6IQ5vEt2CdEMW1i3QFiWMIIVtwIb0c5puy7M8mYym94/W2D+5na0PsdwEhfZ1jjKfLWudL8d8QdKWYcWUREaBalpB/tOzY5FoPcVInEM0y+ql8tYLtewc/060b031/cwCFErENHgCP8Nx3kGnX7BNY9bK0YfF3J6DoVLIiElllYyK81XGSJIQ+CYjtwzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+RYX9WsAZnfZlTgNXAlVfS/bc0VXpgHqUF3rnSCH+Y=;
 b=Yca8IzqZsi9Uln8TLABPzre9oEQO5Y9fgsdiZ0tDdIOSD1m4GLsGtbDSI7V7fhgdEJAWbgn4m91MyGkKW+c6antV+ZKKKX9N/uZDFgJZCwcCFXsggeUfAYB3jeRrga/6Y44Ud7JkanEQLGx8Fx9L7pawA4sRF7pu1Qa930D6H+vdu3eW2J/AO7fzsxbAsk01o+ccGxI+1+S3h5NLKsjGPqVkjckVkRv0R/BHq8v6wfD4ZEGhHKxS0s+HOog2XY3A6LNn+0RlTdctOMrHkXhFzZxzlnCh8o/2Yvb0s3bXlCzPK7tXE12q8Jo09URxcBpi8Tbimwdm8JmYA/7dyJfNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+RYX9WsAZnfZlTgNXAlVfS/bc0VXpgHqUF3rnSCH+Y=;
 b=txoLmtjakZVQ3Q+f8OjmcuapJ5ttd+Fb2RJG2m0ARTPupNzOk80y6UlJp1uVT+R5Dz108K4jtZie8Et/WAIYP3fbVeZD2UQuL8Mk2GBKHURvKPxog20X47cLtfHfKYUxfRTE+LuNgwquEap1lBcNZwrNRyp1oP8v+3lFAbPYq1kxHBaTTkf8bPnGJstMRe8ybvh3/n2o/5cIB8MuREeicPsAk+NO2aGK788PqM8pWnFhvtqeCB3imlymHVtmHSreXhrPJ5bs4PF+NH6Ai3CePRZwb8PZN3hP13D9/LDI5uprnl5sDFm3FdTg79A+LTB3rX/uPtCc1ig1q36S2hMwAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 AM8P189MB1316.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:246::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Thu, 25 Jun 2026 07:07:57 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:07:57 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 0/9] Follow-up fixes for command argument conversions
Date: Thu, 25 Jun 2026 09:07:41 +0200
Message-ID: <20260625070750.2757558-1-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|AM8P189MB1316:EE_
X-MS-Office365-Filtering-Correlation-Id: d2350eaa-a18c-459d-5e67-08ded2887bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	ry14QQ/LHCDbPsobRE8UD+dME/pbfZZVbkya68lqwwS/ri2jAh+kON6G2IE4Lq1saV/embP19so+Gf+wMXRcgQ/QAMixqHejxQkLeJhZaT/WwxGQ2RpE4iWe6KUxj5YyWaxYGTW8RadCM8QM6gsOhPF/M+BqXnJ4TFqKZIWLFpsbq8JuJsfoiumJWgtqRGuhTzVY3ChxGqWaWnkK3djT264vAf6WmFshf247aExvl4WwZUHXAQf2KIn5Wdn7w9UUDptaeMPHsInVhjkfMWd2o26WWWTnwKzDtt1ZOCv2ZvHf+Sa9SuW8A/xZSGwgvCLdJ2/s5IANhYgWnQGxUaGrrFYmwfIRp25x2HrxifUjSL/C1OJIFGNe6dTyE298sX1Q4CMIgXis/LSJke6A0ucyTDFgN1ciEgCIr6+RM7Gx+uCpVP1WxhWIoXInxBc0IpdjjKKWVlJsfWr4aafrff8AceIHHJwuUg1TviAiDWxuqPo4600RW6QSSlxZ8qso/ry3q4oiaY79FJ/PaCYzKvKayK/+ekUSRPj6bugkWEBxF2DrsWuG9B/p0SzqGGqqEeRi9TrAzt01vYCYPSciFQVyKhZxr2ksKSOXtsOdkI970dUcWDkcw0iFu4WkZ3+cxmQFiAbcbMagM7HCVUQT0ern9HNaY0/8Ic5lZCQiZM2GkLc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gT9AjYjp0tgPf9fYkKI+buZf7CD60X2Jif1l9ZpDxHL9GNP6lmrrFry/fqic?=
 =?us-ascii?Q?xs8pQioCE13cmOn5h2tQf4xEERTskmsVzAJsQFR+bPGK8bNmfxjGx8fIhJT8?=
 =?us-ascii?Q?3qEgoaYKefYccyaxuXD8y9PYMs94JWvczNPd23f7bM9ksombGkcvlbkCmqTk?=
 =?us-ascii?Q?IDSYzESjNloNk5KuZt79ZXgKP4CGTWgrja0LvhXivsLRL3M4xVkgwZfHgkN3?=
 =?us-ascii?Q?XdE33iCWhkzsEJ71pF4/WRxFv7Oi0GocxeKJGVXPNLqDkNeC3hLt1GRx1KTO?=
 =?us-ascii?Q?bW+hLIDk55QrYmeO55I2/ooAEVESL9SRnrFpoI2dLG0J+aeTgKxZ3vTdMQYG?=
 =?us-ascii?Q?DhErOxxw2i99zYJ4NYAZJ5E9hNc3DtDCqCv/9RmVw+yNAVBWrDZsNRo6GVpW?=
 =?us-ascii?Q?f8S0lqdN/ozh9pbxCPJuzOfk3LZJQ1T6eCWdNcFESvthGqlChegmkaPsc9Kf?=
 =?us-ascii?Q?wuiXYrsfgm9sUDsY7MnnUosXKepQH00eVPzliLcY5WHfsI3p4luoREsb87BG?=
 =?us-ascii?Q?Zol1W9xqpFHp92FYHicX2k+zIQRh3uGJ55OfjQkbO8kcp/IhHV5VanbclA59?=
 =?us-ascii?Q?APHOccD2IpkVsBTHf9VE+KQ2q4rC41WbRNXF2RVfMP1SCPedO5ruwRVGAD4Z?=
 =?us-ascii?Q?Njt9LD95q9DBQJIlFNI9XnMAkbsd9DBR16xoNDxDPzWLdVXRR+wLtWsoyxQg?=
 =?us-ascii?Q?uo8lmb8Rvv7TA31HZJyAUiAarzkWDXfw0+WQy+1Mtz75Dv8ozlG4Da5vIdn0?=
 =?us-ascii?Q?ezwf0vSH+hTvsx6tGZ12bDeO4drih7Is1/gxvu0s+BDe2kOQNUPWK+Ti56v2?=
 =?us-ascii?Q?7afAjf+HUjAGX8/H6ZfKpN9Y60wx8mRk3uVd8udhp0nt6SUt7SR3B20EGFFp?=
 =?us-ascii?Q?Cmr2/7dpzZt9oXIVhQOf3SXKBOMwxuGD6fcXxVmoqvydGqmxgNPimEClR7KQ?=
 =?us-ascii?Q?5GJdwn5godOCDCI1LnlQMlBCFoLugZok7rjwTsENNewBfJ6TMRb28AOkLZ3R?=
 =?us-ascii?Q?phkW5e0dunoh2RU8yS846hgobzV4rGi+/hIHwYqlQ52w1c242zTmxTO/2OpI?=
 =?us-ascii?Q?HeM/Utpb5IXmm8NxZPLQtxA/L8W1DLiB12M7cyMWeny4/IHrPDtMmv0REGYb?=
 =?us-ascii?Q?8gKeIxNuCCeUuwpH0AlAlzPQIbU6BTOOnTt799rM0AeoS7IdTXe0c3s7Q+k+?=
 =?us-ascii?Q?QR5D53z+XQNvDn/FfEL8jvzhVoDnK3D8ueBdcBSkjZwESlGwJT+ED/DZ7Sgx?=
 =?us-ascii?Q?Z3O+UNI4r1Y9cT9ji3f+hKogGD1s4VSzL0lUUQ6kwkOXtvlUWIx4BPfCgEw5?=
 =?us-ascii?Q?qYFHwwvJ02fJhW2aX7MEiYdqnnaknUMSnAcgYW4/E0HltlPK9s6m41Cw7PCU?=
 =?us-ascii?Q?q8iUrXdSkvOveoHebDlOPic/If0xirEDe/1iv1gaXTuj+arYKfbbYxpn58zT?=
 =?us-ascii?Q?b5OY40i3Etn49G2GgdNW7IvgadeFfGJUYL4sMZkRBIBN+okPbiVCuPGfewKj?=
 =?us-ascii?Q?/l+kNIryqXH86kzUkBivxhGuzVbrkwP5SlPG2uf6IX5MO/++R/SVbR6vy3bX?=
 =?us-ascii?Q?gDisPxMDqm7Yu4/G+gphIO9a0hzIyJPeZp/YfeV3iCgKHi5V7w8EK9XydhYH?=
 =?us-ascii?Q?UMVgnBv70CSlQjM/mnQsebQNRgzmR+dFKR8lGI7O+TFkrfMlRSChFqwQuHfF?=
 =?us-ascii?Q?dKDz0/1iHL3HHzUfdWU7t1+xepwNiodi59zqwAf0ehD8tafTtZASUtqIm7sY?=
 =?us-ascii?Q?vyjIRPSA/g=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d2350eaa-a18c-459d-5e67-08ded2887bfd
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:07:57.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktp4Zk3C/WX8O5tFO1v+KOFMh+3NwLzTA3ld2PspTWFlSn1Kxj2Wm4ixfecMcqEYbVNcwGb6JHFaBZEPryLu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1316
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19779

While testing the recent work to replace shell command strings with
argument lists I found a few places where behavior previously provided
by the shell was not fully represented in argv form. This series contains
small, localized corrections which is supposed to restore the previous
command semantics.

Anders Heimer (9):
  fetch2/az: fix wget command argument construction
  fetch2/git: avoid an empty argument to git lfs fetch
  fetch2/git: do not shell-quote the shallow clone remote
  fetch2/git: keep the gitpkgv commit count numeric
  fetch2/gitannex: split the annex get arguments
  fetch2/repo: fix mirror tar command arguments
  fetch2/sftp: fix port and remote command arguments
  fetch2/svn: remove shell quotes from the tar exclusion
  toaster: preserve shell execution for build launch commands

 lib/bb/fetch2/az.py                             | 10 +++++-----
 lib/bb/fetch2/git.py                            | 10 ++++++----
 lib/bb/fetch2/gitannex.py                       |  2 +-
 lib/bb/fetch2/repo.py                           |  7 +++++--
 lib/bb/fetch2/sftp.py                           |  4 ++--
 lib/bb/fetch2/svn.py                            |  2 +-
 lib/toaster/bldcontrol/localhostbecontroller.py |  8 ++++----
 7 files changed, 24 insertions(+), 19 deletions(-)


