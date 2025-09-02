Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCF5CA100F
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.127])
 by mx.groups.io with SMTP id smtpd.web10.71239.1756795548727092388
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=HulgbzvV;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E368Fbl3meHdoQYBx4abHCcGWx5gU9+LvFrOnWeH3rIjKZAC0/cTMuGK7tZPurBMEtDse6hmgd5UHJkYAwmXui6C4o6q+LL2mmtiUAWJpcG6OW0sjeekki/lSk5DDhXmRi4agiXjojnl8Tz1IF75ljaSSgzTdzdSjUnSZkWCWz1hwLafUPEKgHKchO7yDjN7J9PyvOJPp0yF4MK2MH9mhQKTT+6xbrBtQEB6VUdJltKPsB/6EXfYWf/Wg3veMMAoz8b5dqBMi1x73yvQ7sEsFMwUU1yQd9EF6qkV1rOP/Xp0Cnoo7/tGBjbV+M8yi8bdnlvS7wN2AL4fpgjxaXlFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNKaSUcgCTqxYXsIVM8hG6Prs8f7CIYV4kBBVUmtpwU=;
 b=cFfhMirRh3ZGs9nbYU0d2jnK6GYUrPkvwNYVlzkifhq+NtlzTs4ulWWURf4vEkKE46LKwkN3gkCIKMBvVSK+SnW+yfQd5Ge3pdpIVdCnFf89YCfKjgvTqmWvgNRew0wzFLI7u+rXSunfqyyAFoLDIjn7QeSmVIBj+g39BGIGFHeBLWfloYom4ffhgZnUuxwEj9rHOGgs9dT6B6LlZQvTy7xQd4FDZKk8pJNc0y8KIP3hTos8so934rWC8YY/j4WWUMaAosm1gEU9JaezsVdhsuMN6e8obtjWj2OFvVM4ez4rHn24PvwSTGvOnfuwESeRLGUdopDxkoc0To0ZOE55gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNKaSUcgCTqxYXsIVM8hG6Prs8f7CIYV4kBBVUmtpwU=;
 b=HulgbzvVDRf1ol9st7HOuh7rrhLnn00RmgFchGYzFnbqz/wgJpPjN7iS1kSI0rJOrfBeJMlfx3oMhcD3geCbVxti6ONCOsSIpEXw8iWcFr5sSHPlQw7hrbtRGZn7aWOnSQ4Pt6S2mhO7ILVewQxMrMQK0MDUKduwxM9rMOhRv7IeMvRVRq3NVL/ysGs4/S7+mE8Qyle0Eyo4edo/EV5tmtwPuNbVCuagRh7Rk0cc8k3UVSRqHVWGx1lp0Zud8HL+XqFWgzbQbLsgrXHCnvbP3QhCTVDbeCD2vVmPEvao5Sc1UqvACMAPzmaKiJt+mmmIYvHrluVm8rySacjNgyC3Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:47 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:47 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 14/15] fetch2: gitsm: use TemporaryDirectory instead of mkdtemp
Date: Tue,  2 Sep 2025 08:45:13 +0200
Message-ID: <20250902064515.30879-15-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e079c2-a565-4c3e-a5c3-08dde9ec565f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cThucnioUqLYl7wRNtG0I72/nrMm0DiUnNu0JQcxaEK1cGPMVhGCIJM2OCHw?=
 =?us-ascii?Q?g57CXczzRBHbxZ0MrCQCnwfFA6YNl++BcS1jyrrYdgiU9qCjQTfumT5xDKaa?=
 =?us-ascii?Q?uVI7G71KTgXO5kW/OU81NF8BMKKdyJHxkUgyuove7yHDSt9B9S7hooD4JBNv?=
 =?us-ascii?Q?AgQwYi7XR/PelapYIAbyeSfHZriB7GiuMX6Z9avFb+N7QOEbpQIe6lRMismY?=
 =?us-ascii?Q?4NC9n4mZjerPy3Xgbhr59SfqsC80MVGVqaKqyK2fwA/9XZoM0CXFu1vCfx9w?=
 =?us-ascii?Q?LwQh4ZmnJi/sYKiWaLu58gi2CDAAi+k9WPirnscZzimE9dLPyDzSxMlAhXqa?=
 =?us-ascii?Q?u0kR4t3gobGbkdqAQGEoKUE+MHe8LvEH0rGrPXqyTlcEFlTId7SKsEEpHRpQ?=
 =?us-ascii?Q?5w0m0xjQnAspp3ecKkR5rprowyF3WFZJIlJK4jSAG3WdmJSk7YCld2iMl63w?=
 =?us-ascii?Q?E7RedPhAS0zR3//OSz5aAYaCUfdR/CEywjSIEzUbX9hWI6oBNn7VchbrCTUj?=
 =?us-ascii?Q?HOLWX0DNZVhglJrx4XUENSrVQYY43iJHNjkBmfA/rNMc+Ya6adwhNR8aRtvh?=
 =?us-ascii?Q?flDoR3gMn7nZQ1TGRzjDDX0zsyBC2gt8/cgIhI2NPKwVAjhbxB6x6hLEs1bb?=
 =?us-ascii?Q?5S12YSGnxbE120H2iiW8BAO3IuBqFKrOmsSbp0KwaEUkhw2YbjX6DPZELLzo?=
 =?us-ascii?Q?2TAnY06yizjpgvES4luGgc14Kg27B/oDXG5b8GdEli1U8LR/+uNqyunJXBy0?=
 =?us-ascii?Q?xBYuVUkCXIF7TmVlMViXhJSM9qLbt6YbWtii6hYu7iRx2hgIrlRr4rNIwOlG?=
 =?us-ascii?Q?EunqVcqWxCiAuHwRPmeYCpyGaD6EYoADpYQK5IUdFECmxXAFU3XXifWtajA8?=
 =?us-ascii?Q?iHDz8OR5RHguu62sdvGrqC1Aa1DMatzwoiAe2TY2Z4Dfe22dfycT4bfU6evx?=
 =?us-ascii?Q?K+x1XiY+G1JdcC8G1qQT+z5/ieELU3Dyj7OmyUvUKnOOXD5UTCsAOZPNT+CH?=
 =?us-ascii?Q?WJ98fJ5QlfMCh+lNS5dBbZkQYU5AULKT+hzsvtnYjEP5cGI07CQVuhXK4/go?=
 =?us-ascii?Q?csQa+P0UeD9SC/Gbg3yNHXfXA6Sc3It6cwEb3SRJS82jPsoOlt+mbZZnF0Zp?=
 =?us-ascii?Q?PGKgSJxO18ksZ4g/LBKxFHS/aLShsXbxkqut42ojGxJiHYcH41K8XSS8Fqq5?=
 =?us-ascii?Q?8ZCfLlI9ZG3zLTXAmRQXncqaTKdxHdMTwTUu55+cKBLfs+St7up44L/AWdYH?=
 =?us-ascii?Q?EV2pc8cGR0/awBjJQZizIMKYbX4HU6iUcFlaO7gnI+hYDnksn4Z/aqNhBnS0?=
 =?us-ascii?Q?djmY6AF3g9Gt3D7IhanInAiQDGUd/JalF696B75LV1N5ijcB0xDn9hLiBgaW?=
 =?us-ascii?Q?d76AsWEvXTKzjnfVV6dUPR2GOKluoqV5SJA5zCQQTpN/fGclapKs7oNIq44H?=
 =?us-ascii?Q?+x3PmiAah2aQqRcxqvl6HP7REfKB52pzbVLV7tI/KI7GeO4PMEayWA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?27FAL+xuqmEY9LJpJNd+qoq1IiA5seRFw92UMbAprm/NDGRRnunp7gr0h271?=
 =?us-ascii?Q?Y2ckpCdvQRhf98h+N8lNl9HaOkmYzeogyFWtVHTKqDTZiUmzK/VxJPYgedMP?=
 =?us-ascii?Q?fAgGcUP8wyCcItjviHYLtAsjgdrU1G4sI6AJk5YGG04f1K/AyabkNMlueUyJ?=
 =?us-ascii?Q?UBKXmoiZ34wEy8ab66OCAKDJ6QB7jrryC8dGv/jYOt7fWtL427pbZ1BbFjl9?=
 =?us-ascii?Q?o2zUUPx7a8Ej3W6bj8gEkMBceLMMs1uCSj1opOZQQYWDkXBMv/+HN3R8pM8Z?=
 =?us-ascii?Q?kUwwD+gniD2DCR3MTZ6EioiiQnnSIkGW7/2GxPsxKImEv4hjBadYoBGtB2Pe?=
 =?us-ascii?Q?Zjr4o1ApXB2gI3PTty19HcJP17zbdos7LRX/MJLP137qCxbN2eioapv/g7Qz?=
 =?us-ascii?Q?OoiSHZV8LoHItJ8juxyy7hmHoow/nojiT0PsdinPMKVCnvtfYcMC/aTzhkut?=
 =?us-ascii?Q?LsLpufJRzASZ8eLCqER2zPmhdAx7Wv+AThKeoCb85wm4Gisyv9Y8OhK5dHfv?=
 =?us-ascii?Q?vYcbdX0kemsSaaqW+R8L2BEXFJw/EBulZGh+vtLUoEZAiwRwkEiKMxp3okXb?=
 =?us-ascii?Q?D6TQaOoW+ETLW9hqR1XZ5YNLXTbCEKikiRqBTRCepiIJScT8QCgySHsdH6cZ?=
 =?us-ascii?Q?8sajI6YN6GthwhBj8VrNAxLDh1bci6DurtWRI4ZDxm0WPpDakKVzF94nmD3B?=
 =?us-ascii?Q?DHkd69vugGGQa18i0GwHuXnehG3lBeAiIICEtL1Qg+ofovyVCru1tYbnaq4s?=
 =?us-ascii?Q?+jWtWOFGfIZYNfwTrp6dFXx8dbyihj6bV4Z06j388yp4xCAywSn91xFXx6ZL?=
 =?us-ascii?Q?Vx7Qdy07jzyedXsecdueiUvC/cHd6cP9/zg7mV43deu6stbkD8t+aAiYYY/p?=
 =?us-ascii?Q?pNbW0TLXnQ9Wc2eyvrbsCtq4CmkJXVloYiUKgJKynSbmoHXlF/pGeMhq5FtV?=
 =?us-ascii?Q?pIt2n/FpCiYWn+QPURjxRp0cOmTVQcVzjvBD/2B1ohqBaQXWcqtcE40V59F0?=
 =?us-ascii?Q?1trqXSqJF51tDO5j/zElOCVkeSlCHx/MbSjDqDOicYeWW1ZB8h5QLCS6DORC?=
 =?us-ascii?Q?vq1zMVFQIeRltUdg6icEtvf8fFZzeK4agoqwzYVHtg5PRo0ltiLhWoq/95wp?=
 =?us-ascii?Q?yl9bkTaLCWA05H9n/Isx6vHzEOHC+mCjgdSuIv/TW53HgDDzo7MIfPjlz3ZW?=
 =?us-ascii?Q?6JpueSxZ7tIMIAKoPkQyJSumhauyrKmxb9jYyvNV/5bygINUuzDsDFrIauWz?=
 =?us-ascii?Q?tsLwplg2xrtQTIQaDHXrxItiQ21F6QDXES1C47PAh2BG0/ByDQTDrUJFZHk+?=
 =?us-ascii?Q?wnXSosA76xJbXev2TGEoX5lmTJk3oXtiZ4+gUVicMEAZwB5qNLUZU7UrptA9?=
 =?us-ascii?Q?cQltr9tCBCnJvGP3tyLLbj1iQ67qyEfW2ai5AbDjhMxrJSImKU8nNwFRNZr2?=
 =?us-ascii?Q?yh6O8vUEbgG/HcC2+ssbJ9TJwhbib38MBtJEpvoR2HXmsYtMoXePlcoXxsm2?=
 =?us-ascii?Q?uD9EkUaplRuHNtomwPSzkom8vOnuivc6ivmK8SHZuERS20YZPkfzm6djFjcL?=
 =?us-ascii?Q?0Kj0YZcpFr0pmih3oyxba3PK9B1KiRSTUZHi1mqoT8E+2Euo5IOLMtub6iDn?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e079c2-a565-4c3e-a5c3-08dde9ec565f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:43.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW/qYOThMnmxsLCukSU+Y8Rx61EJ0gD6xYQNniX1eMkNoJhR9VaRQCZ0hJfiluBiw8fcDSmCfMJpEuliVE0RHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17932

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 31460b19e..4b6c88baa 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -20,7 +20,6 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" req=
uires a clean of your r
 import os
 import bb
 import copy
-import shutil
 import tempfile
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
@@ -151,12 +150,9 @@ class GitSM(Git):
         if os.path.exists(ud.clonedir):
             self.process_submodules(ud, ud.clonedir, subfunc, d)
         elif ud.shallow and os.path.exists(ud.fullshallow):
-            tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar("DL_DIR"))
-            try:
+            with tempfile.TemporaryDirectory(dir=3Dd.getVar("DL_DIR")) as =
tmpdir:
                 runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=3Dt=
mpdir)
                 self.process_submodules(ud, tmpdir, subfunc, d)
-            finally:
-                shutil.rmtree(tmpdir)
         else:
             raise bb.fetch2.FetchError("Submodule source not available.")
=20
--=20
2.39.5


