Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CC5103E18D
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 14:16:40 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.109])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15112.1773843398959356681
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Mar 2026 07:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=iIDSEjQi;
 spf=pass (domain: navimatix.de, ip: 40.107.130.109, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCDTaPvsXa23oorm5UT6iMZpq7mT4t9gjFEVx5iwQoYmeuj+ecZ0V8an7mRbuD7jqUi1MaliIJrGeVinR7R5sQTx/mFpzafwjmguPTDDUhn060WWfDV1/ewMb8s36vfX838mj3cuQB9aMzAwWOJdCAxi9wMxrcI0ZIgyVS7BddkotRX9vyTlB6nQ9pjOojOsnpcstxkG1Lf+X+R2R9Vtf647NNIU3aJuxyr3cDYDmAIGbmCXInfoZqIqlLePKyX/0r1N15EewBTRW7z0hpl/S8xLlrQnrLmDFrYHfYBcUSJxEGe62UNwmAu/Gcz2RDXJtfEUbq1QReefaIuc7wfpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl39GDshHAUfvnS2Pejl3f7M1B1J96tflPLigwbO4Uk=;
 b=XTcQbi4YT5vBBnerGm2ou/10IQVfwtAf+v2VlUjSCo16MoBcypmMIhDM/rWbcK+nRCkv6hwBIwheMjkEgAo/V+MclGxqNWrUyJ33Vm/mXK7PcgzMe8ehv5iw5JlRs+QWujDolJh4dtebn0U1xNUBsdrGicE7DvuM/e9QwgGKM4edqGF8WICGUJwh7Mz09R1uUhVJiS/MsO4euCYs6xgSl1eHuSgVTyFT2D2U+dHB5/lxaI/cxsCie5qF1zFPpGvJ3xn4V6J83C8D87BNLlCtpEVvLhEnjLFqHPRaOB0I3Tbjeij8pBbEEIKFzUNS7PMWJPhmWk0H0Tronnwqfbh7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl39GDshHAUfvnS2Pejl3f7M1B1J96tflPLigwbO4Uk=;
 b=iIDSEjQiPqlU0a9DnTDi/m9vDj9xu57FnNrQ8T6vt5rnqdm8OUR/KJ2Sauf0xHaHZymu4CZ9FrHJFgh0vJmN4sRrfeIR8X+hfUC0Pxgs0JQ2AgTp/ll5uCU7cOqTTWL1LMxH73hkpJPgSKfTz30ZD2I+yfG+6IeVDNYNbgIM+Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by AM7PPF6B64AAD3F.eurprd01.prod.exchangelabs.com
 (2603:10a6:20f:fff1::796) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:16:34 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%3])
 with mapi id 15.20.9700.018; Wed, 18 Mar 2026 14:16:34 +0000
Date: Wed, 18 Mar 2026 15:16:32 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: bitbake-devel@lists.openembedded.org, quaresma.jose@gmail.com, 
	joerg.sommer@navimatix.de
CC: quaresma.jose@gmail.com, 
	=?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [PATCH v2] data: Add exception details if build_dependencies catches
 one
Message-ID: <bdc93bfc2de6fd284f4e7a8fe17463d7709d867c.1773843391.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.53.0
References: <564bef12d9c423c71beccc5f2dfe9d50bf8ff8a2.1773815612.git.joerg.sommer@navimatix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <564bef12d9c423c71beccc5f2dfe9d50bf8ff8a2.1773815612.git.joerg.sommer@navimatix.de>
X-ClientProxiedBy: BE1P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::29) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|AM7PPF6B64AAD3F:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a527a6d-3184-491f-9c24-08de84f8f589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Bhzlb0H/iYR15mUt4b3Y9q5npJqRbg9eldYCNDJDBzm8HhYnoNAAc0+m0mQ1HY24Ky2uqKmjJSz6XtQZWh8v4f3DiWsGTlSVfXegcEo+VMbqqjQ+GJHRog05wJod/e6WFCNPf2krDzIyKiRSm4vkVeRgzqU1QGkIJoPDYHwOsP5FxFAmT8OwUBVkS7KkzlNW5L98kkGRQlXnWKxnI/sxLQSGFPYiI08gDR6E//7vvXS5YJsF+m/Sepdako6ep+j6Smx4q9Oq2Q3ZzqZm8dSiE0B277ag1ialEjvb0R85qOHYdIM1Dnfq7sTKtkkxgnVxQ3OHWmcZSOFu4EpjwgG/6HyG+pmRUD0wQsfsDAddgL3fiUZ52fRCljWfmMmWBQQqCTrzA97LUKdC47F3adUsstRCN0iDFc5XWeyZUSwVRxGNFn7TQqo2YihvAN/AmYSaWMPCEba8oFCiK8eokFZ7JWBNr2uxR7MGa6kibQ8VCdTIxpo9/euUFklTg+TVaar4A51FXADMX5FcstekKiPK4LTxU9L9uQHLUVbU6xCHDdjy+qe+H3177JstmX3SSrd2EEizMn+g11DhpVKT4om9/MZBfo7K86JFEFd2lK6FLYyFP2QHDRrDS4M5clOMFqxgebbA4Xn72QHzk1gYdd83cvTyqcWTI1ijW4ET3S60uS8SFYZWcuhyW2QO3f4bc43YLgFUMJMbkMRdQ4BMJqnZRSegHtbMN1sa+6ORQgPoZys=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PB8EkGUgpV+00trcOV+eQjtCy31LZMFlx5OmZx1jPMYyKgIHjZVrSA11ONgA?=
 =?us-ascii?Q?mvrceBf0gr7Gwx7URKvl9TdhOBiLGz7y7qmU+pKql81zXEoL/dp4hK59cVin?=
 =?us-ascii?Q?JZDrVTno7E/cDLZO1BdcGXRC3M6Ndqo6Ah8F+ioQlxMt3LKxOaKX6Pu7RphH?=
 =?us-ascii?Q?Xa4trdgSlwXugN5p9VPNNtNLVkV/kx8ssg277uLXRCnuOgGJmUGrbEzMoJXa?=
 =?us-ascii?Q?OJyc+sFcAD8uN1sw5Pe/jYSGN0CFslFrW7gUKmftA8ThBvabgWlm3YyaAG4g?=
 =?us-ascii?Q?qSggWKRRayQDWxvK/gUVnmvKuvaQq82Awe0XNNjVWSRh2MdOxee6TgoTG9L1?=
 =?us-ascii?Q?Tuu17bPv/SqND7VglVJW2clAiJpIeyv1XyZ073k/3YSoW5jTxJckEVa2ynJM?=
 =?us-ascii?Q?ejnYLwHLbrUNqZvtHM4D17MjiJxjlt+QuV4VtzWiYnlidjiz2hxFuHE+8HIX?=
 =?us-ascii?Q?8tJbPxCCp2MTSL+kFoJ3fiBB/9J5Yjac46hqbZmAUPd1wxZkXsRR1Pr06phN?=
 =?us-ascii?Q?NOrEC+i2S/JNV8TJq+9wobau7br1TPyBwN/eg3xqaHKkoy3fK2K2FIlNBXPq?=
 =?us-ascii?Q?35b9Ctg1+61tr+dBtBAfzOf7nSeJdMihFOEr1kteEjXIKG13vhyXVaFXAkKB?=
 =?us-ascii?Q?1qwDrS5Lg7FR6QLUxu7jaMezBBFBC7tRs3o89xI7kBLraaPtQrs7C/xJNC4a?=
 =?us-ascii?Q?wJ3lae6D6bzqN9BfUjNMuaeDgnhcazU43wEaIHfH9yydY6zExalAycHQ7AU5?=
 =?us-ascii?Q?2X7SvQfIxzbgjoDq87a/GuXdhxl5mJ+Z3HAU/MwVx7FOG8QEm6jM+o+6MP5V?=
 =?us-ascii?Q?iC/f/oVpAkYYs4xwp2zZze9IaTZxaNw01StJUofpMPGHuqAurGwp99YMjwuR?=
 =?us-ascii?Q?bC4Sc72JM6nEQOFhxqU45wP9uIirkjAH1cLFl0FmV3g5H+jKHOB/Vo7+dIJ6?=
 =?us-ascii?Q?miprXUxdx7LX6VNZxrEzvYlrgQ3TQrbdfuCUDveNaDfqliGY7usEbYQAxRQt?=
 =?us-ascii?Q?2/1+jB1l5dVGQO2fVSYm3E37bxJ6bVf4Ho8wiu0FSMaq9U9hBO7mzD8S9UFX?=
 =?us-ascii?Q?WGhF6KuJcDOn4bznfqTl9NbxyZepyqz9318YGXXRF9kvxs5hLy0WznyIDGKk?=
 =?us-ascii?Q?zqvBpAoyp7TxOyjzuGmcHtT39c9fqzfRMi8txiVdNrBXIsziRCbBHx+z35Wt?=
 =?us-ascii?Q?gACptHazVPfIAZjU50X15G/OMx4wHIajqzS9S2PV5T9LPMgcjy+872vwQUxf?=
 =?us-ascii?Q?tGleeg7L8J+oA8V6xt+vWvmywdUKisVKpks7w05MHE0y+l4y6DPd3/DHrqxP?=
 =?us-ascii?Q?tvnqQ+Re7dH2WnvbtRlNRSMPN8VMqw3bd+30BnjIrYZrqrFg7BYoDeL9oHcT?=
 =?us-ascii?Q?Zo+SIaJFVPnh2Dr+CWuDMzgbAh2vvX5RLDQ+q8m/n79rlhq0t9F+E66NuHu9?=
 =?us-ascii?Q?CQSSmh3EphnZ648LgnT21qucrI8V563jAnKtgcrfge14xyVapqhwsxFX8K8+?=
 =?us-ascii?Q?VCocNIbYoS9tXU2g7whMF+AjYsvIOQA3pQrwRzw5sJgHbjfjID3dUr4+9kgl?=
 =?us-ascii?Q?6QLqjU4enr0I4zFlJiPLb22TRlY/vMtHLKc25gn08vGPffB+Z7KOVectddWt?=
 =?us-ascii?Q?2ReLTtPLYsoGHiYcYW9NW46DyZcvoET1bFrIPaLSiU+IU9eM9sPY5ihbW7K3?=
 =?us-ascii?Q?cDRRYR2RcehyZJyeRQrnU5y0DI/wEDKDUMWIagAIKafgfJf1BRtf1oU86zeq?=
 =?us-ascii?Q?YEnZ4v42w8ZyNMwTrcfdR65zf/xhfPQ=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a527a6d-3184-491f-9c24-08de84f8f589
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:16:34.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uV5oYVuMBW7RZTUMGq0dF0amMOtHl3n5U6xQWWJqMK0BYl8ZL//wdhAAUYQ5Ax819ohvIBnXbafzwIW7OfuoaM7naMDlL/HzVmTWHzszABY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF6B64AAD3F
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Mar 2026 14:16:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19167

From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>

Without this information, you'll only get messages like this, which don't
indicate what might be wrong:

    WARNING: =E2=80=A6.bb: Exception during build_dependencies for do_patch=
:00:17
    WARNING: =E2=80=A6.bb: Error during finalise of =E2=80=A6.bb
    ERROR: ParseError in None: Not all recipes parsed, parser thread killed=
/died? Exiting.
    ERROR: Parsing halted due to errors, see error messages above

Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 061e63386..5fdcdb04a 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -367,7 +367,7 @@ def build_dependencies(key, keys, mod_funcs, shelldeps,=
 varflagsexcl, ignored_va
     except bb.parse.SkipRecipe:
         raise
     except Exception as e:
-        bb.warn("Exception during build_dependencies for %s" % key)
+        bb.warn("Exception during build_dependencies for %s: %s" % (key, r=
epr(e)))
         raise
     return frozenset(deps), value
     #bb.note("Variable %s references %s and calls %s" % (key, str(deps), s=
tr(execs)))
--=20
2.53.0


