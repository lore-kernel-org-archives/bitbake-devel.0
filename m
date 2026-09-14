Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD4C88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4568.1789410146914145815
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:22:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=QHUoW/4R;
 spf=pass (domain: est.tech, ip: 52.101.65.31, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQNYNHR5B4sIjw1XVKuLMXPD398qc5K+rBTHTyhJC4DT5HmBqIVv2ez80YYbtWnrCfKuCsFqIPF/EUzht4FkvTJdk9AA01MrAErZpFlqF/DyfcOh0Z2pGIV18BRokNeimQtScpFLFqnWQhpwJmpH7EK4qqgeYC1UZ9d4HsU12ubLpm+Vrv6Z3sbEiNlhDdS79/08tvC5JvjiPkNjfBBzu0cO5/IrMakBR+HUl3pHNycPc3zPb4vz5J4lqEiUcNknVBBLjULzAuYM/6vS73aL1e24d47CoV0+ZD+pexank6UPx1hqj5kgJa8tJ38RdbHE4DZHPm35zzxdDZyobWRHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2fUMcUWAfJJgsLCxF8S4VfObF+ZeJE2Kr1b8AGs2zM=;
 b=wscda+kams4JcS4XgQF5/U80lXNFs7RdxhrB841ZY1BMs5o91SoNbcWz+k5brHUp5E+xib/0e5p+FvA+Kwz7lsY/FGi6k6wGx4/fpdi4NwC5ezHB4/vDnbk60EzSOg7fqXJW4zlkevsA3Q8OF3KSjNV6OLWRkm2VLjefnENSDlG2wK7U0JZwcd7adSwkeNcqMZmWgntnAAjC6S4PflV4abr+DVukNLjB60p9JcXQsbsw1QGPED5T55HXFUyxnZF3H8Qkb+bl3mQKAeSvf6NXNlNxnEKutDPawACAFAr/8Y/Jq9ak8tDaZbtP/Po3y0YDfmGbkmx+KRuWh2GoTlDXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2fUMcUWAfJJgsLCxF8S4VfObF+ZeJE2Kr1b8AGs2zM=;
 b=QHUoW/4RG3feJosK4S0L0IfyF9dT7q32Ixq2GgzLhW+bQpxa9NzB35ZejDWVqgVhH29i/9AodUzoVFqTcHbLXFe7bcr844oFKqFSUvP3INhF3epaQDJXkchu3tlHhJyMY77IUtigAVNus0ZNg90MRcw233ai/8qhHOnLEJWUp7DIWuE+E+60p+FvZxemd3oIeHYtpPzNHKTHr88qIsvD6pfODblGPklMbeV78jZf14I9A1awJloAdfIMRUE0aesPmbKq0TqHNJoCz60Ytf+TYqxCGiTU21YVLoeyQPaP9SbZCFg8rsYbDKBitT5H0wCh/sqS0VbX0RsVRBIuvb0OGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by DU0P189MB3184.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:59f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:22:23 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:22:23 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:21:44 +0200
Subject: [PATCH v2 5/5] doc: Document the landlock-disable task varflag
Message-Id: <20260914-landlock_try2-v2-5-0a1bad3579ec@est.tech>
References: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
In-Reply-To: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
To: bitbake-devel@lists.openembedded.org
Cc: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789410117; l=1990;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=+uGR07Sz+MTefqsxiXqRPZ4WOHRmLR9sn/dPelhGNRg=;
 b=IZK46gl3Dml3/LeeKU9XJrHGL9iugVhmZVbGfRO3NWGZSkR+5oDjCfyzEP0hO6XaSzM7LLOi2
 kQVsL9uO0r6BZBESifTS0vwKwZ1Fu8g4qN9WZ6Rz9v9FPAPpGbe0RVu
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVZP280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::11) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|DU0P189MB3184:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fd87e4-16cb-4129-01b1-08df128d1f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|6133799003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	0ZQhRBw+xgkjAyxD6DNlSu2pGiKlab02KA3C05sFl6JL4jWcOp0pSMI1xgkxt6sB28UudC3Pl1igTVTWrLHpGTjLKecMOgTYmHhOWwsNQq4KhRCo/7GHQrWOG9RdJb/iuX+gns0GXdsUjx9CH6XbcS30FKARlOSHzuKF782sqmC4h4Q2XBtjY8CSXLgt1IhvGPbKlvNyheO5qS5D/FCAg8B5kt46BknWHKnJcZTmaSHcOzhLdY3JQMXcvsH9dFy92ZH4/cSNKQ77Bsx3rzr7p7CyFzDtWLINv3mYiDuslcQ8jnvsl0x4AEBrIbZPgzdK2sYvkH50HAkpzAbDW93xSWFijDEkEVEfwZ9b9la3hFTAmZZEdUb5OCkuKIG3ZnNXzhvpkDqro2HjZBsL+2jF8sdtskXpcOPTGHnRJHiu4B168/oNwzW4cKyRtIHi0WiFnrIROKMXUHhxxI9XcqvwNnOzsYNfAaJNPhIGUDU8SX/RqDQgdlFchMBORLvnbKMKNrhkpozmkAaoOvA9UVWP2GFy6n+JeGwQ9wuIxGAsPQsEyLP1q8l1wLRUtMhK1QBAMedsnbJg5kKRwZqwVl7iDbSosFxLs1MqQQseonZn7Bcjkjy21Q2JCwBGSLGDYlVBQljbgPJ2hlg3XixXGsAEFuiRQPn3h56dhpxU/zJefVI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkJHVDNOUXMrMzJGSnpZSWVrSFV0R0JHRWRzZlpXd3dTR3hYT0orWC91NG9B?=
 =?utf-8?B?Z25sL0JFK3lLR0pVUnkxT1duSTNaZnkrdGFsaUtPbDZ5OS9IVlpiQU9YYktq?=
 =?utf-8?B?dmI1bGsrWUw0TXZxdzRadGJZdjQxQnMrVVZrUGZlbE5OeTMzK1JCYlhveVdr?=
 =?utf-8?B?aFFkVnZQcVNNMjBEYTJxUG5jYzNmZ1VqcTA2bis0Y3B5RWhMZW8wdE85Vm1X?=
 =?utf-8?B?WjBqM2Rmd2NrUmU3dktPL0NoaUwxcm5wS1Ixc0QvYldiRXk3dkQvS05ZaHVU?=
 =?utf-8?B?cllWaGxFOTVPaC9YREhRZ1hiRmZHUHlUT1dZWUp5cjB5aGJPZGhsamYzdXFU?=
 =?utf-8?B?Q1BnOTh6aFBkQXNqS1NzcGt3aXgyNEo3UjdadFZqcHU2akhnUTBTTTY3WWF3?=
 =?utf-8?B?UW1EVU8yUVl3MjZJRit2enFUM0d1Ri9lVGk1dy8zaGVyR0Y4Z2R3MWZZeDhq?=
 =?utf-8?B?bUkwS2xVNUVNK1p5Y1ZldnIySzJwNEdOeElFM2E3ZmlZTW0wYytmVWc2NjFm?=
 =?utf-8?B?Ymp5OFQ4TmpoZG9sNXk1OEhVNGt2SlIrd2pua0VmQlBUYnYrZ09rWGRGMUdX?=
 =?utf-8?B?STlVdmRCMVlsRWtKRzhQZm4vcUNINTJ0S08zZlNyQUhKc2c0Q29aR3ZQanlv?=
 =?utf-8?B?Mk1Tak1sNS92clVTb1dSZFJCRTIzVlBLcVRyQ1RWOU9waUZZS0dRS0pxbXd4?=
 =?utf-8?B?Qkt5Q1dybWRmMzUzcWpCZ3JpTmdzT3duaUQ5bmozY1JsUFltUnAyTi81NllQ?=
 =?utf-8?B?OExOM0V3bkRRWHdxVVdLM00yZVZKTGwrTmwrQ1ZvTkpaUWpzaUpSMFAxelVY?=
 =?utf-8?B?MGQrM0JFdTNBMmFPSk9Rdm5ZbHVhZ0Y0OWg3dXU3aXdvWnVqQytpbDIvdUNW?=
 =?utf-8?B?WU1BeW1IMkFGTkxMdEJraXIyQjBrSDlGODJDY1M5L2hVZ0NhbHpsMHRGZDRw?=
 =?utf-8?B?YjFvclAzY3BOUTl5YXZwYUFxdjNQdWNkTElsN0M4MlFXZlVSekVvUzJvZ0dY?=
 =?utf-8?B?ZTZnYXg5a3BvdlVCd1psY0U2N0NBK3hEdlF4U1gxcU9GdFRVYy85U2FKS0RZ?=
 =?utf-8?B?RU5LMEpNc1UyaGRqOG5iS01hK08xaFNoSjNSbUo3ejFLSUdITzR3dldDSWFo?=
 =?utf-8?B?QTcxV2ZyR0RBOUg3VGttWVNkMFI2bHVBMnVsZEdjZkRlUG5tYkNlN2FtYUF2?=
 =?utf-8?B?b3B2R0NUQmQ3bXFJUnlISUhPbDA4WG9mWFZZSERHU0ZwR3hTcjBlRDRJYkNj?=
 =?utf-8?B?ZjAxLzd1clJnUEc4Um84TGhLemNEVWhqSURYbWtlNTB1OUR1c2pkRnJ1dnNH?=
 =?utf-8?B?WUtPbFlMck9EcWR0L1lYbmg0YTdMcmdZYzU5ZFJPRnc4QlJ1dWpwVVMvYWZn?=
 =?utf-8?B?VHU1azlXcGZoVDRVbXhCVzhQZkhSZTcyQzlEeERBTUsvWnkzN2JncEYrNnR5?=
 =?utf-8?B?ZlpaMjQ1S3l3RWp6MUs0bGl0aUpkbDBMQmFYd3hsNmVrc0J4MVB4Q3h5VkFH?=
 =?utf-8?B?bjdWb0JoZkN0SVZnODdINUtkQjdOQXZSUHp5NklXRGEvQXpHOTN1STBYN2dK?=
 =?utf-8?B?L1hnaHFtUTJ5UjZ4TGpQN1ZmS0lObFozZllpZ0YydjJJR2tXbHUvRldjaWRX?=
 =?utf-8?B?RWJhd2dSVzhyZHZVSVNDTW5EUXJFTllCSy9PQllMOTZER29zZW9NSEgwRWZT?=
 =?utf-8?B?K214alZ0dkJyUzVOdCszZVJ1Zk9GK0RpNUt0aDNiS0RCMkNhbm9PbWtDcXBD?=
 =?utf-8?B?dTJhNklRV0s0R1N2VkdqemxvRHdvM1IrVjlEWjB4M0o3T0p2TFo1NTlxNTJs?=
 =?utf-8?B?QVNVVDhpc0RaZkpWcy9nU002VFNSQ0c3c2YwOGlod20vSEZrcjNaenFtQUhI?=
 =?utf-8?B?c1ZOV3U2TG8yTG9tRERaSmZBVEY0SmZSUmliUG9ZRzhLd3lmeGJ6dnNZbXI3?=
 =?utf-8?B?Q055NEs5U1lyYnovMnpoRHpqYlBCZ3U4Z1F3NWsxK0VpQkpZaHNSZnA4K3Ni?=
 =?utf-8?B?WHBYbExRQlYwS1BkNll6M0ljQ0JoMGhjYlQ0TDhuVEFlY0NhNURlRUpCc0Fv?=
 =?utf-8?B?NWR4MzFkaGZtSkY0T3FJM0E2eVBNc2NhdmpoemFHY3RMa0JIcGR3R2prMlZB?=
 =?utf-8?B?RUQ5bmh0bStNOTc1VGF2OVNVNXR0VWU2Y3ZBM0l6b1VXNFNEQjFoUUhrQ1ZM?=
 =?utf-8?B?SlFURFo3dmxDaGMyRXgyakU4TlZBWVV2K2RLUzR2eW5xNjh4SldLK3E0dmM0?=
 =?utf-8?B?ZitZNkR6cTYxYjMvSVUrOW9tMHBhOTdjcHhaUWh6UVY0bW9NYzBzTlRyL3ZT?=
 =?utf-8?B?R3BkMHFvc0l4cThwVVNRQjFST2RKVkUzMUZUa3p2QitLWlE0bm5nalhrTjE1?=
 =?utf-8?Q?RH4HaliClMEDoNpYP6KVr5MDv5hkB2yW1uzTYzROlE5Fa?=
X-MS-Exchange-AntiSpam-MessageData-1: 4SmE+L2z87zMhvyxqMpivNNV3VuZOM5ApOg=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fd87e4-16cb-4129-01b1-08df128d1f60
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:22:23.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/Mj+iKZWdUCLszocB/TJxKTjLFvQn9fAipmtM63e2oqxcjwHgwGwZuaMYy/W8veobXSu4GwV8EkTUhrS/lbOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB3184
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:30:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20205

Document how tasks can opt out of Landlock restrictions
and clarify the resulting exception to PR_SET_NO_NEW_PRIVS
behavior.
Also, needed by users of enable_loopback_networking

AI-Generated: gpt-5.6-sol
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 621aab253..b67320f47 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1780,6 +1780,11 @@ functionality of the task:
    "exists" True or False value after the path allows this to be
    handled.
 
+-  ``[landlock-disable]``: When set to "1", disables Landlock
+   restrictions for the task. This can be used for tasks that need features
+   incompatible with Landlock, such as gaining privileges through file
+   capabilities.
+
 -  ``[lockfiles]``: Specifies one or more lockfiles to lock while the
    task executes. Only one task may hold a lockfile, and any task that
    attempts to lock an already locked file will block until the lock is
@@ -1791,9 +1796,9 @@ functionality of the task:
    shouldn't access the network outside of ``do_fetch`` as it usually
    undermines fetcher source mirroring, image and licence manifests, software
    auditing and supply chain security.
-   Tasks without the network flag will run with PR_SET_NO_NEW_PRIVS,
-   which prevents executables from gaining privileges through
-   file capabilities.
+   Unless the ``landlock-disable`` flag is set, tasks without the network
+   flag run with PR_SET_NO_NEW_PRIVS, which prevents executables from gaining
+   privileges through file capabilities.
 
 -  ``[noexec]``: When set to "1", marks the task as being empty, with
    no execution required. You can use the ``[noexec]`` flag to set up

-- 
2.53.0


