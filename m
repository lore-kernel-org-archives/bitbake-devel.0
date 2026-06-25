Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53171CDB466
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:15 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5833.1782371286374348394
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=yYwLyAcl;
 spf=pass (domain: est.tech, ip: 52.101.69.24, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKGoaRAyTQEai2Eb2uuIh4UUGyzde0JgKWOyAE4MBEkqO1aw5c/BI6e6dvxxjyBJ8ZtqJD/z1IypPAI10At07T54eI4tkWB2/7qb6H//6algI0QncaNxC0VzITbmr8Hr15+svXYRXXtqtZnwdSMfXbU/NZ01NvlHjGU5oRnE6ItA6xxJDDzQ4inDh3B1ji5BnlaJ1X9HzSgYfgV/Y1iUHDqV+PxONR0IM/myM3wmF6fJ7THF8AKj9QfanbXDSv0KwJRFD7LF5tZhXd//VOktzMIHjDOp9bZO66Of9M2OkOc3kSetAWFkWFK673Ax4BRaZxM9iLyYC2uivhu7YmyVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUR3agRsnNc+5k/YOK2JBflPEQ7EYj5Bm/05L6qgBfY=;
 b=kSsAsg73Y3lNaVyxL7KCa5QtMCPzfkqbTp5YD8kYf9tLLEC7A8VKmVeThpQX5rf/yOax2NV0cYrOi0PUgcHI9iPL286xv8mV32fU+lTvfW9I4s10schOwdMNLlQFGOdOi3/61/rsbVDnWLOeCY5cir6QBEMe0sVzABmMCvuutlD92zX3TP9yHXcwmjqF3gEAAXNcz+1xdqdKrX1pSHOaFRN7tZildO0ueSySylvYs28WAgnz6/UGgIXq6KvISmzmmMgAaxD3eTY0to+f2lz0o+Sbwqzn6WyovrL9Mya3aiVyAlvQUJ7GlSfhMarI8izQ/fjXhtZcrTqbaMWV/85r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUR3agRsnNc+5k/YOK2JBflPEQ7EYj5Bm/05L6qgBfY=;
 b=yYwLyAcllBODB+r3tv3v6LUT9BBCrZ0xi8gFu4v082+nzaU5SYbtszuDQ8Bhqbuej7TW7xhn93GbN7yMh7bGNEGm7GztnWfn4/Cm8nFXZzYPcDcl0IuLIUePaACrdlNfxGbdWFMVNuMx4HOYeicDnqWMg8lQzlMKdF/E7Dh3LiG63yWjQkWobekY43b+jl/nHd/LJBKKRm8KNGcfPFj1gbmsey5wytVEwEr53eq+Ei3Kjnr5EulXT+4PSMw6ifrItKmvQ4g/XsppgIzGT7ysTGiChEEYYCcXju1FCcajmDJLBTykxqwMlmUVqet8ZORtITbPdyXukQYfstQRxBzZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 BESP189MB3178.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Thu, 25 Jun 2026 07:08:09 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:09 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 9/9] toaster: preserve shell execution for build launch commands
Date: Thu, 25 Jun 2026 09:07:50 +0200
Message-ID: <20260625070750.2757558-10-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::8) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|BESP189MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eb32d8-3c0d-47b6-5ccd-08ded2888334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	tCpxWdvBbCm42h1aapZfcPD8c8XPs2ag6acKsM6szd5lBOR4hz7PeffkwDCiWQM1AnKbFKUlgQQg5rXy/GtGTDMrTpTzI0XpROLzQ/GUXnDkZXUUTllRdngtBz59RJm4YQiiQxpkyLfb8/Ppjxg0065eX8g65nCtIJKmdkaf1Pbzk6khbJtd3jeabtiwT6bGL3a7t1YyoTSnDOlCbJl3q7ziT01YuncrpvukfO5NwMlCvpczsnn3tJ7eYiOa/x37FE5zB2aG3/Z8cNaGeLWXATti4qJN4cwEP+dc1HeBBeA4yFZfS4komJUretfJfe7zivXjMvu+cf0oYUa0pNCGxWCvD9lF4BRPYplDcr1mMW9tOBA6Lb6ZcTVB6DdailaSoex0+hTOkCQgCM+DDxNpZUislVLQUEd7SrRh2pSj/XpEu4TIHtK8uSMD1xay5BNrdOayuvhdvF3Cv01V5iEhAR6/8xb1ahqdhJuYrEhJjwbkNzavfSIVQJsxVGxiFcZ3WAzXPwXldjYA2CKgtS1QkYBOuMay1d/cvCXIL96IKpmUfsPuoiKnFksDH3oVGjN8sYwqSILQeuVMK7N1x1ZANem9ogw8sAEAig6wJC5KECvDIEcNRjb4E5upXB63yHlwLu+EnLMABPnMfOpmBTrnhuPaxDIebldmm9xGQyFQRv4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YtJBVttK7HrF88NxFHZjKexD9YPhu9yuffWw4od9PtU1jfwY9KrT6J0j4Rvu?=
 =?us-ascii?Q?tn/JSX+McM4PYKX8P2TQ9XXQCJJBqdXfD4cNSrKSE8m2aKCOPmnsaA50PYdv?=
 =?us-ascii?Q?06lcGsUp8ZgAMJ0hz9T6dTMzTn9g2dUeXe8yiKgpJ5t+UPULYxK2/BZ+33eC?=
 =?us-ascii?Q?uhZxsNb8myEMbqoLoVYCZVQ8POplhQQybrQSS7JRJx/SiL4MX0gLKmcjgEnh?=
 =?us-ascii?Q?8R7fIbhnxe6/ffDXOSemP0x86aAcZeU4+N3ncBQJ86OodCeE0E/GJx4vPXg0?=
 =?us-ascii?Q?mPjgoT6Fv5WyuOtfBtDKLFPXQKGfnKXQbPYb20YNSV+SEvSmegLVW4zg80rl?=
 =?us-ascii?Q?hUm0qNxsZekmS2HSanCK68a7NxFeiI00M2/gpvl2FH9as+I2LFmxK9sHx4Tl?=
 =?us-ascii?Q?Jfcx84zqq7HVKHklsy440Zm9rCxnROFeBurRGclV+EWRsyukJWvFntWbuNou?=
 =?us-ascii?Q?7ZUw9+I98eeY1+bZXlleP5SuzG/47YVnmb0/lG8XICtSWPD0zrWLHzQlwm3H?=
 =?us-ascii?Q?5T8h5UW9OcTqU1MRG1cMtr2M353ksIkbbc0e7A/mUuA7egCauo+1oxkKKFA6?=
 =?us-ascii?Q?h2j3uejCfdaykrUlVvRs5P+8U5YF3ac6qKhbN7eKAI6/jV2JzYRmWwW6C3uw?=
 =?us-ascii?Q?VRBuZ+ubYuLE4RJNtVyDoMM1/6q/Wz2Lwu8iOfLA2AR1B8LBLlPXfvdVjd3M?=
 =?us-ascii?Q?iZMFmK2j98PFDFlAtLFNjSnBERxAXdubenezBP+G3fCdgSwwW+5qT6LnIaWm?=
 =?us-ascii?Q?zPZrhXQUf1T2YmNen7ICp74qyFm9auRwLVjBNEpO0BsygRlZTZyG8bUnXTPh?=
 =?us-ascii?Q?a/2QL81BcFfgBAfOVoMai4BQwaafXkQmZbW1ckqtkKvc2PV1z9mLz0Olbkrs?=
 =?us-ascii?Q?CEkdcz6Fg2hFWcPUUgDYn91zSbApoMvMMTjFuvX60gJczBa14dgdMhdoBD4s?=
 =?us-ascii?Q?fr8KNhYDLhgcOp9gNJyvbZc9yd9FnYGnNNvqCMA5bVep9H/NZNwyh0A8z4tZ?=
 =?us-ascii?Q?+3RGaWfr3Fe8VRNkFQcANpjxJa5Nhdwy0xL4vPpSodxgLUmNRmbOMJbC5UhL?=
 =?us-ascii?Q?NX5xBkh+nYW/XzD2I3eKq9ZCt10PmxRJoOD2w6i3cHBd5G0qb4eLtCkO3qaS?=
 =?us-ascii?Q?tmD8+X24IeI+wexwXE6laj1hTRjvXwWLcjmchnYHt+JWnhd67bT9gpp7g4/k?=
 =?us-ascii?Q?pnCia1g6VgPYcO8li66IiaTTcpG3dVf/qma0L7a5GLcvx9/G1AiPquErjA9r?=
 =?us-ascii?Q?beDCeHlyxJegmUiDQ2aCySWEJqQ2iw6swGZtWw/GF5vq/7JKF5i3/+LLEdSd?=
 =?us-ascii?Q?u0gfvJ7hcAzK8qR3cTL5+iund6kO1Kl9fTBJ97QqhhrEC2UFOwzklzm9Wq6I?=
 =?us-ascii?Q?mUA/OkS+GVDe53SWCb+g7CITnnFXvqp1n62oidtlXuTSa45U7lyQNphUNQd4?=
 =?us-ascii?Q?0nNlJCcKJKn4xhtqP7quIvA/4se+REhWI4LdYAcIBcNciO3VU9NFk9TswO4Z?=
 =?us-ascii?Q?k34+v217CEPK1cKHvYH7utp4EYi4KtA69vTNq2wuLYyZqIGsjQN7qunkqsmf?=
 =?us-ascii?Q?e+au6+1cc73EsOwbMjyI3UToAugbU610yz/F3lpon+7lSYOR8IlFChQo1LuR?=
 =?us-ascii?Q?AXrdN1CtFTr1UywXASqyphPHVEN50h2OUPIQkyLYpwaLOuHi3GVKo8ZyqZBQ?=
 =?us-ascii?Q?AAfiQ8zZACc/2v540udStBGzpheBm0hS5j7KHnlI4w8FrxchEyFpfbKCMU9f?=
 =?us-ascii?Q?xA3E7P+0jg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eb32d8-3c0d-47b6-5ccd-08ded2888334
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:09.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1ts7VGa5DivkfikpDLeaS45eE9HFi91hg75B6MREYorhYB0oCdkepj0kICacwI++ZBxUWC+24CNGUlQWPc47w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19788

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/=
bldcontrol/localhostbecontroller.py
index 91c2026f4..4e0a6e90f 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -547,14 +547,14 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
         local_bitbake =3D os.path.join(os.path.dirname(os.getenv('BBBASEDI=
R')),
                                      'bitbake')
         if not is_merged_attr:
-            self._shellcmd([f'{env_clean} bash -c \"(TOASTER_BRBE=3D"{brbe=
}" BBSERVER=3D"0.0.0.0:{self.be.bbport}" '
+            self._shellcmd(f'{env_clean} bash -c \"(TOASTER_BRBE=3D"{brbe}=
" BBSERVER=3D"0.0.0.0:{self.be.bbport}" '
                         f'{bitbake} {bbtargets} -u toasterui  --read {conf=
path} --read {bblayers} --read {toasterlayers} --token=3D"" >>{log} 2>&1;'
-                        f'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:{self.b=
e.bbport} {bitbake} -m)&\"'],
+                        f'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:{self.b=
e.bbport} {bitbake} -m)&\"',
                         builddir, nowait=3DTrue)
         else:
-            self._shellcmd([f'{env_clean} bash -c \"(TOASTER_BRBE=3D"{brbe=
}" BBSERVER=3D"0.0.0.0:{self.be.bbport}" '
+            self._shellcmd(f'{env_clean} bash -c \"(TOASTER_BRBE=3D"{brbe}=
" BBSERVER=3D"0.0.0.0:{self.be.bbport}" '
                         f'{local_bitbake} {bbtargets} -u toasterui  --toke=
n=3D"" >>{log} 2>&1;'
-                        f'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:{self.b=
e.bbport} {bitbake} -m)&\"'],
+                        f'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:{self.b=
e.bbport} {bitbake} -m)&\"',
                         builddir, nowait=3DTrue)
=20
         logger.debug('localhostbecontroller: Build launched, exiting. '

