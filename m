Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B1CD98CE
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 12:02:00 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68479.1781264355057812423
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 04:39:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=NwwAI9uT;
 spf=pass (domain: est.tech, ip: 40.107.159.13, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIcbJ1qot2BtcXrpwTRQ5j8yJOg53jV74N2gq5WrGCsR15+4KNYXk6Z3lvz1w/K8SN2aFZnds/2uqX85jcYonnGElLXGY32g48rLtehJbF9wB7BzCmzslFImrFJqEIpTeu/d1avL++k7Udub04/5hnsO1rNmoUIIvkBdywnZJLKzLDCUy2+yWce9PiskMoM33zU6v3dES5PQ9ZOsZew2JfWri2smg95WC17Ty1ZQFrDbSMU/U+MfytswI8sYsPS8dcdGDlEv09A41L0QaldQrMOwYbWXQAyW5/FFVXVtb7hvz2eAcSfrsGJ+rbl5sZFqPLKxCyWutQ4RDGYUDkI9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9tpAEHvAV+Rd36NOLs66uw+IKGTh7UlGyK09GC8huk=;
 b=Tv8GbtculbroTW8uvSRnHQIetNTap05ZkZ68CqzJ+nqCPwJq9+nrHgxs1vACUswcym2jOAShbUPhpFUUmQxw3KbVUjkgmdpBVaPTRaInE0DMxRCgpws3aBXWe42onxibQQA+8f7TZmR1/VBrsVxg+lvZm+oCl05cgGhDiKhVp5+iznJBDBlwPmHFX3tfWKKlmOCfJVUokugyfiHpKvDJLbQd8KKNQVegqkEE3ScnOVx5Abn+dnktjEST/+7BQTUkqFdK097GLyGn68fRls2oO+zF/LjAfRwn87f+JZHVPBsGAPa7Dmta+HlfahUSY/9wyjQVeJoV48GV/no2PXlFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9tpAEHvAV+Rd36NOLs66uw+IKGTh7UlGyK09GC8huk=;
 b=NwwAI9uTKxkPIiHnPVPiezEf6/wIfe3jCLqhMGhGkeRaPuj6N2C2WGJrYG3nTJIFFV/4cX3XdaS5nNr78hbj/7usoICS7YK3JwPxZSoizKgf7m7g9OeNe1PsmW/qibbC7ptWsEj17mWnhfxMrQa/wry6tDG6omj3aBLwZedHN4bRgyTMnV7wf4sSIzV4keygWihCRgDoWBa3DM1tbszWvSrYAGNAADau3xvm5Rg9/UQnuAIzoN0OR0VHQ1x/m7pBaaU2X4lqU/H7heDi1x9PLSgtbr4+DfnHjGqm5Pz+jpyzkd2FyflvK/7xeiph/YkcqleQJbxoeJchOqNX3aXSKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM7P189MB0693.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:39:13 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 11:39:13 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Fri, 12 Jun 2026 13:38:32 +0200
Subject: [PATCH [RFC] 2/2] bitbake-worker: Call landlock_restrict_network for tasks without network
Message-ID: <20260612-landlock-v1-2-77891f63ed7f@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
In-Reply-To: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781264338; l=1180;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=c3kSG3fgfR/+g8z1KA4sDCF4dKX7IAini+gE/H4NprY=;
 b=vCbHRJVdQpOj77YikEifnkYqvvENUEAQyL1ZjbdjYjGR+k4EBFn2AZxzIf/A82MXR2P8eXV1f
 /BfWdphC7VfCP/ujEpxS6j1bofZxqLo2eUDj3hyFnLvw3BtUF/FTvh8
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVYP280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::10) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM7P189MB0693:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c2e386-46b1-47e8-8779-08dec8773a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	ZfvLdGNF/3+/9q++kx1XIr3D2GhE5tAZNwuSTp6kZnlK9O6DlB/waVn3WZewUFJaa5g++SXyCEBBIbX7UBluhC3su0H9l4dPyQuSRUD9MSTlkNY1HX7dSA4OHfCzfoVap1VrWcWrSjpCZUEiu3y8RPRdQSE1AWUVEHEhsGpoDzHpGI9mZuUJfa+AoDOYIuLhMtM9WYd3Za2IhPkSS9AVf5UfNF7LDC2UoSSRvztYe3TU3ZMjZJ4XQHid06eL2Lt4X4dAHwpLUCmko2k0WmCYQR18oOq7mqnEJMhX4LK3hRHq+8dRuhQ4EvDWIMBvsNdZrjH+qiDIDvg9hYdy4k/nrasP+qeMRc3brbGwgiZWTBgStvdtAnuO2BpBVMe2m8AVdntfNw71ku2jtgi2hWBbYV/GQrAeWDTtzYJFmvFwwW1vX4xi0p4H3PhcDuJAg2S11MjttGkjkTqn1r/16Xa0SmvnMB9vOxWGzVHwx7kXoCQnUJEf5Sn4pIRYhooIEGSz1A8YG6ia4iFkohiZb6sigSpZbA7wwedar/Umz+huFAgvG8NkU6zrCMXJG/1KMvuU/lD78xTmIul8pHEPna9YNt8xyoixSf4SGzXZ0Nbxe7BABcKCJpc/jkFtIlUrzZAW+sJDI0Xp0xLGvmiLnlacJ6LblY8w3LpP9q2nDhm3v2tcC02qBJWKVtOvP/5oCw4N
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?igUvrHnQRmCkMvp1n46m5hZZz9Cfl6ZnQp9aixdM8NUZ/pOV+TS8XymN5Hug?=
 =?us-ascii?Q?dKa/UojPzsDuoSkxfdtvpAgGFH0Y9R6XoJLPvHRJVPJYl7cwLw7FzrO1Y0uF?=
 =?us-ascii?Q?WFnN4q/cVflXQHpxCV3vabskIlkL0ycimNtvoftPUfR/hyLFu6T//fWlvE46?=
 =?us-ascii?Q?YJXTnl1d6AE29bSshec2Ggngea9Dl3Ae32zLs4Ikz3QBhSiYwex9zJu3OTw1?=
 =?us-ascii?Q?SZ4rQuBeoXSIIJKY/DnVAcRVwwo+pVQ1QFi6NdN7JMj7qOdpW0Q6fyLbkz7D?=
 =?us-ascii?Q?YPNYk9drSz0Jp75TlXtEz3wRjkw1gtmZ9ASjV3T8g4hhTvSIoIOT68x7gTbT?=
 =?us-ascii?Q?Bq+tgyZ63IN6K0lUIm9D+vP5CRJop2afLUmFhEqFbGpHPy3Epy46Q8+Ymp14?=
 =?us-ascii?Q?ZOTNPPcgbsJrZo8KpEcgV6c7i63ZGCM3UP5B6r0DL4H9z5t1PqEEHpopY1Vn?=
 =?us-ascii?Q?U+xhL+uBAwNxeuLd8M5KO39pCmsJZmWSPMny2L/WV6BJOYEj17CvzGxTDUxX?=
 =?us-ascii?Q?dHwDoJCNpCfPVK/NIkM1/aYjblaM2as20BzoLHU6RjwZ7b3qH1pgiM89Dcf0?=
 =?us-ascii?Q?VG2DbVfQRnNhcnelalkegn3PMpF8PnoflX4zOwHzgdggV8Adc8hVl4YJpgDM?=
 =?us-ascii?Q?Mm7I4IGywXpGZRDJCJmXW9QQ4bPzJ9ma52uZn7nvLuS+0k8QJuO1zwThxAHn?=
 =?us-ascii?Q?ZeZRmWdRsQeYs8j32lV2m/5AYpwodT669qak0wqqFVGC4oVaA96t29SC7sKa?=
 =?us-ascii?Q?WVHhRCdNtNqbG+px524ZAGVJbg6c2dct8kyOUvLbsvjGHqZr3LPjmJLEG+ud?=
 =?us-ascii?Q?yyN9BzmaN14Nyrjwfvc8Adkha/4Q2F6j9VKA3BTsUILxkHbpCAcuzP3Y7/6P?=
 =?us-ascii?Q?Oc0Q1a3B1Za/Do06/vyJO6HHyY/OGTivSPB5/InKn2GpZ/7IBxZ0G9xPObPw?=
 =?us-ascii?Q?PqVZDJdhIB+Al+NVO7dWAU+c+b/bpWkHeh6oiLT32OCDWq7zIHwCDoNHbxBM?=
 =?us-ascii?Q?cw8ev5p2ElZpof217nrs0fH3k01kt4sLUDT5QNFkj6UGuIjCH23BX9Q8GYZE?=
 =?us-ascii?Q?wW5avFUssDIYVcXoyl30OFXCf0/rqogWONtxSYlZSm1Iunb3Vw4I9GFbz2YZ?=
 =?us-ascii?Q?Y4Hkn0xeXgvcMNEpXfJLJpTJFTM6zE9Q6GkrMFmonqSXPFQ7AAgmyDVYzwDv?=
 =?us-ascii?Q?Jehey4L1KoEtHbgl38WNdP1JUedpzu/YyJCBln0eV7r/1HJApouBYVW7Ultl?=
 =?us-ascii?Q?vdb71eoCoQAOt3YKbiq8SXUY76uMw4WOkj9kn4my0C55EfM8RYF/Yah3OC9f?=
 =?us-ascii?Q?JOSjA1w451Ej/lWaA69Y+ro20kFxNimXqNQ8dlrsjoYz4gpL4IEXLq+VDbwJ?=
 =?us-ascii?Q?zIOEJCtJpAb6Lpk7L19H76kM2Bm5FGIkU3yOq0FPw1c55g1Tfyh0f78DhmYZ?=
 =?us-ascii?Q?f4b8fOtpLjyNEX4begmdQtoAdVF9cUa1vW6BSC+ncLZnfAQR+tw1EtY8kW7U?=
 =?us-ascii?Q?YaspdI0QDOgKVICi11alg/p/vqS54mo444S9+H4c0PdpY0OZwRPnToGB1uWp?=
 =?us-ascii?Q?NnJsPiKeF3mS+KCi5MOkwdA8UqrzCrZvbMiewLThiAYLyCuIDqvX4nDtXVhQ?=
 =?us-ascii?Q?o+JnpGiiQXPNw4JGl8do216Lmc18p86MUKySkpQNk8mqkH+KpA6q65Th6jwZ?=
 =?us-ascii?Q?c0poFDvK6xVxGNh+XPLECRpFhAXGtjV0izILvDfWLs0BeVs8YPb0G1RGZsRt?=
 =?us-ascii?Q?S+RXdGuh2Q=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c2e386-46b1-47e8-8779-08dec8773a2f
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:39:13.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE8V75peqcgdA3g1M8g+VwElYEl4SpJhaFMyemn+3mu/mPlf27gfZ6QJfk0R4oFviysxxbtk9h5iGTKAkfzASQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0693
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 12:02:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19674

Call bb.utils.landlock_restrict_network() for tasks without the 'network'
varflag. This to support basic network restrictions in unprivileged
docker containers.

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
 bin/bitbake-worker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index aa14ef191..5f3fd9933 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -287,6 +287,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, e=
xtraconfigdata, runtask):
                         bb.utils.disable_network(uid, gid)
                     else:
                         logger.debug("Skipping disable network for %s sinc=
e %s is not a local uid." % (taskname, uid))
+                    if not bb.utils.landlock_restrict_network():
+                        logger.debug("Skipping Landlock network restrictio=
n for %s since kernel lacks ABI v4+ support." % taskname)
=20
                 # exported_vars() returns a generator which *cannot* be pa=
ssed to os.environ.update()=20
                 # successfully. We also need to unset anything from the en=
vironment which shouldn't be there=20

--=20
2.53.0


