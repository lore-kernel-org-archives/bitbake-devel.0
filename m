Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB67E7719A
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 09:18:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.129])
 by mx.groups.io with SMTP id smtpd.web11.16587.1736241499941436827
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 01:18:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=ydQLbZMc;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.129, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbOni7XNXB3eOXlaNzRl1uz9vFLzEvCXwIM81Q+vvkl3NnhicT/n2E5i5LuWA08UWyXj36q1a7tYf6Pr4JaHxWooionKfq0qGJiC4Z+FwFST0S50ufTOeWcqmgS5/Z+Y8kjXrZR4YmdPAWykJIUNZuFfYAyFekU20AjSrdZAJeSt5s1uTYaqvrVGk6lNdj9afZcp3FTO+0emSsdyU5LTFxAACCJn8ig15eLOapHHPGtnNRPMYZ89KPMychtnxKa0zTXDlOaAsEbC+lkvHxurk/l3BujPGRbVGPxrBAJ156OA6m6qMOpq5krW1B3krddnR1MLneezPknmrlqpInJGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tit6rmzEZRai1FkdRp8QgPPUeB/0AyLmW9ayX20M9nk=;
 b=LQgS5sBydgRgbqVw61xycjThBuNQgWFQ76FxGPAPw/Xj9riBrVV+GJe67yVqcXqcXYYBdw6PrrNUjYHr6Xl7IP2Y2rFkG7wZoNZY2tS4COALFCb8D3zK6Mfz7cOnuomWjMvplHRBM6ml4pSNYVBsCNWI19vf1c5UBJqfGLSElvtV4a1lOFJbX5yJ7kEVKmNaSpJ8oKMNODJj7W6VP/WtX40hb6kctJ8+jZ0UOJvaxVvUZnN9aq1Rn7OhO/ckUHI/D1MwkRtIdzRid7l+mRPwRFoB/bZLVCCnhCriee3M8x3kgcwjPiEjLAILOvaQkmxMIdAFkmkVqcX89VigaB6dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tit6rmzEZRai1FkdRp8QgPPUeB/0AyLmW9ayX20M9nk=;
 b=ydQLbZMccyb064341jWLobqzJePtj0Mr81P627x5knLyZ+fH2DwFFAHvT7pVPwc4vGDxDC/LeN1Tu6q9rfWXUjTTAeUnsyq84ReaPplzet3HovknlaPdwke1ShnMMZMaJ9vCvHi5ThAJ/+eZ5IVyhyFcYONy2VLFfquT08VjuI43CO8EwrWc24iFpriVr6UiwtKBaaWcW4LLd6qS8YFBomeDUp27MpchFMKhw7Lq64sDFFAA09MiC6GW00Yq5c51vGusa59WKm5Kc8k3CuAqymqumCQmwOGpS8TEkRf8ELlFY1hxRa5drURV/ziSBxbjC2HrYP9Nuj2M8COwGxRiuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by GV1PR08MB10607.eurprd08.prod.outlook.com (2603:10a6:150:16c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 09:18:15 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 09:18:14 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 5/5] fetch2: read checksum from SRC_URI flag for npm
Date: Tue,  7 Jan 2025 10:17:57 +0100
Message-ID: <20250107091757.886-6-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|GV1PR08MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c080724-20d7-4f6e-9149-08dd2efc36d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Evp9rp12e57KUCvykNMAGVIDi18y/Q3nOGHgLBa1r7UaU+Asd1wACJQTK3nS?=
 =?us-ascii?Q?MSKoskWGcNrjnMmdwKSNhX6aCVC4p0rFON666ZD3A2HF47+Uj2sDa/3bMz1b?=
 =?us-ascii?Q?+A3W1k5gNhHErbCW9IBWVA/Jwpu1AbqBZN3OtFvTaeMFwfJXWCgnbJiH1AQR?=
 =?us-ascii?Q?9dPIIKjPcIjJniEDU2lyCYb/LPTCCrsSWn1sfGeaLR+Po73gJud0+IDuLDKV?=
 =?us-ascii?Q?Kv5HPQoDuAIumAZELQpNmSGcwmD/5zO4EQJkU2G/NTlzCGjya8AHvz81zi4x?=
 =?us-ascii?Q?gG2ncee7+hP9O1juiwdJ42NDxbRFQOxTx/mR1UREQGWkWTzdOjWMEuES+geU?=
 =?us-ascii?Q?93T0K2B0FIAyiLvUC/MmoB+7YA13kEhosBk1pvX96lL84IBlrwIGcnm76Q+o?=
 =?us-ascii?Q?emS8TrWzpgInVBM8ZnFFZub8/lCE6zT/pN9+C2Tf3qxesKs7dJa9l6IpV1HU?=
 =?us-ascii?Q?0NLqAuOY/bQuSnqS2Dvjc5DccQS74b5J8nfXi+NJ9S4p0948jiHo5ihLvMqv?=
 =?us-ascii?Q?yiu/6pOLnGNiB1K825sEwU5WJljbTiU+5sOnDBB/S3IPNV9FVeQX2JRJmGxw?=
 =?us-ascii?Q?ERrqApcFwfgdYks04RGusM5hefIXK/TCJ1n9ApKy7Ujo+Zfuayhn4WXbYiJX?=
 =?us-ascii?Q?X6KCBYzIXvOgbIl9BXZ99wPaG8L6SbAXuad5GeAhISMORtdoLO2zen0ztxqS?=
 =?us-ascii?Q?5g+41iIBN9RN9zZoy5yjjLeHBfFVtl/zg5ddACPa2BLbPuNe9EgcTYqHyPNa?=
 =?us-ascii?Q?VSHqo6a2PS+hEE2dZ8DQLlVuhjOeb9NfYNAyToCwCIuaVQx6OgXzLlGffed3?=
 =?us-ascii?Q?HMX4yoZ79/IgTyIxV121lnBMOIdbeFbguEpYF9CAyUbc7bZTX4IimMq+2mQ8?=
 =?us-ascii?Q?rze2BuWCCc3lkIU97mYBt5hPj47BcADSvUnpCirNDk7anyBdC80MfXM8qAOD?=
 =?us-ascii?Q?QOq89sjDiptcxzxKLcD2+6VJiVCIcPq5diIOw70axpOe8mnpdDsh26/cPMXf?=
 =?us-ascii?Q?ewzvB3x6Pnz2fgevoXLEr4kMcw2kjm5z3Th7rp+hzcp3qaq/4GPwm2N28TFS?=
 =?us-ascii?Q?SnBCyD9v7DZV32D6m94GwMR99iS8e5pftydOOZktx9GDg2R4VTAcG0OvNeKv?=
 =?us-ascii?Q?2SxnF4KM2pPVEe6gVaKQE52x53q0KIbgrkY06Zpkr2SbgbyU0aXc3KhQPfaG?=
 =?us-ascii?Q?2uWdfuP/zZfxsN4UEnEa/WodbWR3F++XaV2F4oCjgA+B+0o0wIc5ZjE3PePT?=
 =?us-ascii?Q?FKBG+btJXohqkxTnSp35jbwcAjs32Wct64r9tpQSkiOma0Kfcncwwi/8kdLD?=
 =?us-ascii?Q?NbKg+mWekn5/GIYe/35sMyIhwTW21Qb7QVvH3aCEqkiarRBF2rcIobP7TnmW?=
 =?us-ascii?Q?Yb6uPJTMoP0o/uoeQhamoCWwGPOzmd8IagGEKv38nhlYLH7aA3S4HuUpHilf?=
 =?us-ascii?Q?3jaqmBGVzvfrMk2wiXyya8eZUVKYKWrV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?puuyelePUqF0eByo+5erAzMqdRnz8l32xdt0b0T2+NswCBDCRc7pE99CP9qk?=
 =?us-ascii?Q?q3EN0dbsiB30Vjc/vBC9pVwoGetIAR/gLD9SGOZ6SCED9pPoqZyTRh4Ig7lL?=
 =?us-ascii?Q?ZImMaYAxsCk8uBY4+GxZmMb47QKrrZ1smD6eaO+8EuR0TkSbkXTeLhZ3Lo5O?=
 =?us-ascii?Q?bYietIHGr6/BqKQCjdkmFp0UKJBH0MLAxOgwov2hUoG8EIjy98Q5nF0ar5kf?=
 =?us-ascii?Q?sLaHG7QbW5N3W9/L39qXmIJERtsxFAfZka83kaTAXmbO/SAc4UijU4xJZ4IP?=
 =?us-ascii?Q?B5BcojhjrhdJ0q4zghmhxJcp7l9kNIfh5RlSuDCwr/JwV6cVwN0KYREV1L7k?=
 =?us-ascii?Q?JOgZKCSCZTtE8dfhFxi30ZPgMjtuVW1uUMdfOWMzKO69B9MF5KTnT8ruDsHh?=
 =?us-ascii?Q?UBO200jZcfGEBYMsSYrPwdAEIkbmG7oHTyNaEMmSIN2jwbxqW51U6DbS3Auy?=
 =?us-ascii?Q?bgc4p6qvQ0RPCpZeTlcSK3xbQ4k7Kz+gRsdNo5nVvAtBZTSfWgIuVqfZE90A?=
 =?us-ascii?Q?WNd4RFQllVW3+2OWpr8TNeVGLmtF0x61G7aUR+LquslH5+2ikngpRQtF6Q+6?=
 =?us-ascii?Q?ri3TNVzPHYfC17rv0t83kMK/JHozGBievXn7odPtpFMiB2WvFaH1rcBlnxY4?=
 =?us-ascii?Q?kALtDzuSa5RPKJ/ZYCXqMyK9l41IABlVgTf+FaLKiQYepiZTMNV3VXkRHxiT?=
 =?us-ascii?Q?V3t8c+refkdCvjBnJGmn/6scOSDrNZsdV1dtt48I4yGy3nJvMidOUbyaETto?=
 =?us-ascii?Q?amDihThHKPNYyUvJfhRf0/rCPyD7J3Ff7Ao9y3dcQpH4zGc+L0V/vhUtvONy?=
 =?us-ascii?Q?5BIyQ/URI8WW/fHyRZ85xTxVuU1mJs4yTk4gkUh5bhOWRzoMovZG3G2BRbiD?=
 =?us-ascii?Q?+c7s88q78wm3iHro2dfdDuILX11xY/i9RjyAXeG3bNyxwHPmGM+botLn9I1Y?=
 =?us-ascii?Q?4+s7mj+hB3tiwAn6sxjgX2OO0cTXVa180soHIK38awyVqrxYsFheOV/vqjDY?=
 =?us-ascii?Q?0+eDEYg4dtYN1Ynnd7KWbzc9SMHn/CHn+Tbvxj/Ox6vaF3bmT5zosao6mHpE?=
 =?us-ascii?Q?bppT3DLi8SUc6fBwbPU/uYv9Ii5jXjTmXc+8pg0pUYYtF/YQZttLbHwcQfEu?=
 =?us-ascii?Q?LCs/oodMRz155ES9AnS8Ok1vGeb91tfTAICvratFrKk/noP31l1a60vJnd8H?=
 =?us-ascii?Q?oulfrdh7bdkad9KlAm4T3sjSzQFCddvQ7YvYwffryjNgh3r9V7e1H6rEY2dD?=
 =?us-ascii?Q?UKXGzWGAP2tPOS4Hqpq7TO2lPINWnpYOMuZlzz5LPZe6d8vOBhBYOfU7N4TN?=
 =?us-ascii?Q?oAKvp0RiyybKNz01Hs8LA7mWKRLSPR4Mmq+cTfC2kgrdsRj4lIHQXGuoGg0Z?=
 =?us-ascii?Q?1BwhMIDgozVe7dc8T/ceeb+yCla0v96kB21SnTAGCf6DqiG8gFaeJm03cAny?=
 =?us-ascii?Q?T+HSgW/GeootbdEH9Qj9JKqrMEnmZ9fM3XAhVqT3TpvpaBly8m+GcdmXzgHS?=
 =?us-ascii?Q?lxhf9vfO1oCe7V4iX+mKV5pwH7Ru5qIDZdHFTZKU/JOUXJTg1Ig6FUK3s8B5?=
 =?us-ascii?Q?z9Xwanbk2E8DRzj8w/lIDDWiAzEn13Yc8TCTVorFGEY4Ne/DtqMiDku6hYOQ?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c080724-20d7-4f6e-9149-08dd2efc36d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:18:14.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/yK4hvL+msWXIvdKsYfvKyEeziGQfYPN0b/zAlK2aL98Ic2QqW6AVw1I+nzLwnciVWYBRmAnuV2upEjoUCEZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10607
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 09:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16975

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3d31a8d4a..d2a30c18f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1327,7 +1327,7 @@ class FetchData(object):
             elif checksum_plain_name in self.parm:
                 checksum_expected =3D self.parm[checksum_plain_name]
                 checksum_name =3D checksum_plain_name
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp",=
 "s3", "az", "crate", "gs", "gomod"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp",=
 "s3", "az", "crate", "gs", "gomod", "npm"]:
                 checksum_expected =3D None
             else:
                 checksum_expected =3D d.getVarFlag("SRC_URI", checksum_nam=
e)
--=20
2.39.5


