Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBFCCD98E4
	for <webhook@archiver.kernel.org>; Sat, 20 Jun 2026 17:44:30 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10608.1781977469374546640
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Jun 2026 10:44:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=BOf9PIAF;
 spf=pass (domain: axis.com, ip: 52.101.69.13, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaxSRvfXXRhsiYy/9Pd7lr6/6dX/misiaOqxWlavzPNQE2Uvb5jlIZ9E623o1tyxSJQkubRjNoLewOapGilH9p9heyEX9Z1AdFJwg+ptPeq6Sr/6M1CrxpRZScJlJXDzt3w29TCzOfqGPaFL4F0eOb3/D8wNxWCnZtqFQ+CmakXuqWrk26qgGT4ZbKXs0f9XS7TZYUtuJEQTivprfWpRwfDmToLb/eq4qm/nQR4sYC8yQG4wL9Jc9q47nStWnCzmF/Bq4P+LBr7H+PacAu2mCwfDIog9dKWynB0oAvWMfYw4BYrbLyIyVaQ1Vveo4P2jqRPbiC8ZffAyCFmyVNg/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJcLXpho72p+CoDZdHWl/4EfyLCznZHS+vPvhg58QtY=;
 b=d8XMm6+YsjaFykkAMV64zBw+q29KjjGj0DA6xRrxmTmH6DyBruQDtQonjPWOqAkEe+DmaIQ7oR5jBeBr+AOvfeUAh7JBmyAy7XNsuDo4upeqYlT8JxYOw29r1ALrAQfl1vlkMEJkAk6xp1xouhcdjWSC/5PB3M3bKMiR1NH0+n+34uLSpNc2yrdqCzxL4GeF+ToeXPAVe7AXSq72Dl5chWaHGsBJCcACOuX8p6D5x26pKkg/jgTC7GWyNYJqJOF+sWOphAtxcdABEJTo3mkiUsYQozYTkIzg9SPRIOXkfPnjLhBZeYkkUm5Cj6a+JMZpy690C7V/N7NTo7tQhYI8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJcLXpho72p+CoDZdHWl/4EfyLCznZHS+vPvhg58QtY=;
 b=BOf9PIAFIowXr45UyX7j4nZGQoon9fMEeHK3z0Oe9RzWCg7Dui43gwT3PQJR21BJoFQW7iPy4XGyseojYzlmBrbz53xLfhN63EooouJZmdslCoRNkGXxDnZ3hl/h7/jZ4mbvrswTNIH4j6BAOKS+UiCXx2GspZ+3wpmVSJJ8TaI=
Received: from AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::35)
 by VI0PR02MB10512.eurprd02.prod.outlook.com (2603:10a6:800:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Sat, 20 Jun
 2026 17:44:23 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:208:17c:cafe::9d) by AM0PR10CA0025.outlook.office365.com
 (2603:10a6:208:17c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.17 via Frontend Transport; Sat,
 20 Jun 2026 17:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sat, 20 Jun 2026 17:44:23 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Jun
 2026 19:44:23 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Sat, 20 Jun
 2026 19:44:22 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Sat, 20 Jun 2026 19:44:22 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D1E662BA4
	for <bitbake-devel@lists.openembedded.org>; Sat, 20 Jun 2026 19:44:22 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id CC51112CBEF; Sat, 20 Jun 2026 19:44:22 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/git: Only fetch extra shallow refs that exist
Date: Sat, 20 Jun 2026 19:44:16 +0200
Message-ID: <20260620174416.1489364-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|VI0PR02MB10512:EE_
X-MS-Office365-Filtering-Correlation-Id: dae27240-769c-45a3-4c5d-08decef390b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	eA1oQZcN0rpF9tFrf0X9MrhGuhUGR1HZZKNi+3desAttMZDmrqZy/ESL1f0SPucOMK/KhC0n/HiBbhxqSysLEf9jF5paQ9TNxf4hPLVIXjOvcMrz50TNNvfWT45B4aEV2XHnHsQOIqwrrd9lKZwBLyQhcmR6Fz7icduZ2FNlXlEFAyMjosH2TIZM113yWID8f/dLchmp4j80QBNeaBebSCG9mienCTdX0o9rtZeMxLliHGUAJ+XYDu8r3EDuAoCi/5ugrKXelvmUyVdHXAERo4JAKU90TBLF1ZzUcx5oyihZXh9d4dgHgP+hXAHtQ5FDw71HAg5N7R2tNAaBbL7Xp44Y+R7oxsmwePebdEMO2w49GBHRORuqHZ3fn3ejlDzsxzGAjdJsRU2JbtEmQ4yjQF/VVbTSk/lIoMfdlfCMNnXaL5ZdM6qrWXVpS+2BRa++SwLW/w9zUs2vUITqJcrKRY+Logo/ATNFoPG8dn/hWnZNgntCoAhHKgvOK05oA2bzy9ESbVCYFEpluoPLMBylXI7KXgtmWk8GtyEyJCm/XnqGlgHHGTLXSNKgfi3SE8B5ViIbcPnUKySfZjhWBPjtA5gyFFsVK3ORbu+KkV2AH9z0fwql/IqC4Zy9tl6NaopkHYqMbGu5fDlT8Yx7RAldxs77CIRBKllojjvlLolQ15iHAvI5qw4vmb0A6eCBjOEIODmUU0GC3HSihm1j6zsoaw==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	2Q/zNO6eK5JOsTAnGYKQIBun4tV+v55EFWxZMD8O9cKZPIcI6dvzeuAf3HYNUenBFlcwNG6IA3HpUOwQ7lUtmFj1VFNFCS/Css1Mxd3k0xjmWtm6OSAlkkx6m+NkTmG9WqTT7er17OE14MBzyQBLGoaAOQ8GGF8brteeeozZJpkSikvnL3TeDnDhc2vP0IEllXq6xQ36Gh5ybZV2vXYfp9UCqhWus+lvSaur1o8Gys1XBuAn7yZzV1L3YIJdT9CMiUp0WVwMMPG1X296W4qJ+KrBOyJ6/5wHA/jkUFYksCfQQhGEYk72KdjlbBb95y1YhuaJTgTs95rORLF1hAHM1ggNC5X7ryZiRtbk0HuKB6BsEfvvN+gKEEWhp2UJGn7ADQ3+aYIWLZqV/n8h5hU8cGlR+GiYQf74nE9tYYkrKCiNu2+wkRWJNw9a2ctQCre3
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:44:23.3182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae27240-769c-45a3-4c5d-08decef390b8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10512
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Jun 2026 17:44:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19763

When using BB_GIT_SHALLOW_EXTRA_REFS in combination with a recipe that
fetches multiple URLs, make sure to only fetch the references that exist
in the respective remote repositories.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fbd85441..3f723ca62 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -640,7 +640,7 @@ class Git(FetchMethod):
             if '*' in r:
                 matches =3D filter(lambda a: fnmatch.fnmatchcase(a, r), al=
l_refs)
                 extra_refs.extend(matches)
-            else:
+            elif r in all_refs:
                 extra_refs.append(r)
=20
         for ref in extra_refs:

