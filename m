Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F42CF9C6F
	for <webhook@archiver.kernel.org>; Sat, 21 Sep 2024 12:09:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.85])
 by mx.groups.io with SMTP id smtpd.web10.8378.1726920584162331016
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Sep 2024 05:09:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=HFgU/ek7;
 spf=pass (domain: outlook.com, ip: 40.92.90.85, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDu/gqS36BTcJGDxzrOhQDfJhp4+aWs8J9ir1Xhpo+ENsOfk3zunsdhPD87sEi+O1Ik8T4DYyhF73YXzxe/RWUlMee5b7Wor4ZEalljmPvKXcBioWaNBhFq8tTOYpPMenn7qGGxmB5YctVqByICgImuN7DnwBRJrRsbmoidQfZnAkzFakJDGFhklBOCAsMwV3XpC0nLiEAIIdpxhDJlhq2He4gB+eK+emvuFWQBaf+NGpCyt94QnB6AQJpTZrJMHZivZafv270CbHSXZz/tC/qKMlzQF+0cChu8q9LMmzoyPwFZQXInepQ4Wsr180THLJSTzq7ywjKv0n6upLBv6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JORyDp21KTXiJDU+0vsztEUCZGdGX0ygidfK5A3SGt0=;
 b=lSh2gVpirby1zMVPZJNeCnKbZac2bjeOo8784klbmLkSKdsOwNPIm6jTCiLOv2o3bILw+v3NEpva7f4EhLh6M+3ldtqvucSr+FHO/KC1nPOxPXwCyCLpxXoEl3r4eeOF5ooxY0l7/tANDyCKtgi2HknGNbmfeillOCQtJr03dJthluSJNem+szdPpcvYSJFZrCy7iAUmsd2erILjnBIIu7znHfqvJlxcFsymMsWr+F3MC0di+2ySpV6Hu6rw0+UatDTV9DwAerZKNmIuwzqA7Hr/D2XQ6t1oHGXTL4w1llb/pawmW5qqrZLDpWmw5d8poA6hp/dAXs//e/98v9j1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JORyDp21KTXiJDU+0vsztEUCZGdGX0ygidfK5A3SGt0=;
 b=HFgU/ek7QLRxZ/0eGft6Do9J2t8udiyOwWv4ZOknL/nyVSaNP4uHk0HOkYahdj31rouP1X5LzaO5pLlYAvHDT/7BOdmC/XmWmcM/6G3o/SBVjarMuH3NyE2tu7124xh8hz5FasYw5tzchjZtjR7y4/WOy6VVMsUhxJpaaxQHbT7cbCNUjJQ+qQFcWVJJ7k9ssB0IlPXkWMcgv4PA9ook0EaP+oe/j6fexqrGjJsKLaJarHyvdc9Q7QM/j/pXB9q7Y1r080sZfu9i3nD3uIU9iYG17k+ogf5aOuo1YHWhIx+umlxScTl5EWJY4CO5U20vxYZ+jN1CLbBrFj5tqqEqTw==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AS8PR07MB8992.eurprd07.prod.outlook.com (2603:10a6:20b:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Sat, 21 Sep
 2024 12:09:41 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 12:09:41 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH 1/3] bb/data_smart: remove dead code
Date: Sat, 21 Sep 2024 12:09:18 +0000
Message-ID: <GV1PR07MB912066D7168452D637F97205A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::19) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <20240921120920.240557-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AS8PR07MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a4340b-976a-4015-4a8f-08dcda364571
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|5062599005|5072599009|8060799006|19110799003|7092599003|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: 
	plzFjlGq5jKEpH1jW62h20YStPrcJ2OwiduPiFD2HCbOy/P8IviYrtSxEEtG9/ihiRkYTJPqAm/mbGy69odgNSb051n+al/uajEYQxhpMuxmpY7VjELc//eNS/zmGfIc4FVZKkJxUwkbS332iSJvFNXSU3heaOPAvcC4xPaXcRc7P6SUgP+NlaVoZYBrCVpFdBrwR3mQtbd9Bq2TFx/9boJYsVQW5EC35jWc9e4TsXtlbsQjuDrgRMEPgqLZ8Gmdx6u5cC1Qi4pdjDGwl6wKjOJS+dwNp4eydMjSGY3gHEX9k4WqyA5Xfu0idWhV4rL3IGrBM4qoC01iO2MVRafcH8dSHQnfy/mMlSLJ1S1bCapKNQRf5sgAY+VJym1c/8+47Eda4u/aGyxDAOfhamEPwdmMGDh64bWS8LzR6T+97lCAu/JHTspTXR3POCUHG+3YHtjmMFEtgcOaJahtEt4MB3IxVF6xRUjgXVDOnsZbxdb7jtkCVRvF0dPbEaH0UzdhyFaRErpmoYT7OJYlGaGleZtA2dX+Pvx4fSdgevADCggeJdWakSCRjNyedxK99V0yRGy8AxId3uNaRVkbD4/dpgzCa0hmt8zBFmPXCmCtll+UMl+JHstJ2Y8XBu6XOKIxMADCblisZov2aBN7d+OjIDsZ7doZjD+tiCAIZud/iVQMtshSAZLul6SIcQ6ZCxJIsEZ1NwzaqlZsWgbJFNUvXbvv4dHiP2Ibv/Na1keakm5De1QkWdwY1GuLkTsceV5WVqOw4FFI/5S/gJhH2WHjm0Brv5lGyR5B/j4sVqqtVok=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oMwnTN62tIwtJbMOzETr1HZ3qn63rj1recLikFXECl6FqAyswIpgaElvr/eb?=
 =?us-ascii?Q?OJS9ZTuwd/uXNuvW9RnNE6sZBDDqDRpg/3BNzLWd7Fy18cF1xhGxOPPY9Tbj?=
 =?us-ascii?Q?f940gdAJqda6LpkIyygwjZEUjsY2NNxJ0Jb+YPrKsD9TzmUba+8d6r0HWPl9?=
 =?us-ascii?Q?kQBzV8aZvqsa9UsXWANZ9acXZXsk1G7NZpMIW6f6DANaVnez6XEidEikoiso?=
 =?us-ascii?Q?ZzPVazYbQT4URQWPwceD0BLnNJ3HmqGHw0KMt9EbH6froOcD7mSm8hWoN3jV?=
 =?us-ascii?Q?5a7gUlQIyIQj6OJYoUaoPvGrZLYeo8xH7OXRs1+n7/nT1gYdhK07X3ogIKCS?=
 =?us-ascii?Q?pRxl2gWxhUJZ/DKwwZrpDTcx0TTbrwzYP/x6/sO1r5fqhKc/UfeXwehRnOuQ?=
 =?us-ascii?Q?3ZR9koWn/q+iwLeDPkI8G8JZRU9HUZYNyY99mHdYqUpdjRpm9GhqUzPxOTsz?=
 =?us-ascii?Q?gXAgwkpBFsSBsauxxvDH1sRGLdxT6r7ja3UzlfXk0Xu1roKAX0Uk1sAUDFj+?=
 =?us-ascii?Q?qMFV0QyVPHfvAfAkcS32DzDfF5YmWMebTBOafCRIrCt/gGVFarTP/ymUXq0O?=
 =?us-ascii?Q?bquR9Qpix+i0NFjHaIl3hzx9zSJ/Vf1Ei6xLm3f5FrR1hzCf7XaO+xOAkmzb?=
 =?us-ascii?Q?GlDQOWeM/H8A6XUCUcfuEERSSj6vkZm3rA389x0qYoRxhirRTdXAvW/CuaXW?=
 =?us-ascii?Q?+pFPz6M0Hus1OtQg9QABkKu9iafRthCIeojdRyeg7YF6sHdJ6bAeWvECKabg?=
 =?us-ascii?Q?HjJZF6Csiph25a0HCLTy/nK+SutLZvNOQEMpiQlPdMTSA5XSQrd9fYzAI9jQ?=
 =?us-ascii?Q?FKkPmsL7WbCPm5DERx8rXaTe5h9YXNdFATSQjMOa2ics876vZrxoWTT9AGIK?=
 =?us-ascii?Q?cYmH92SRdnJtIedgCqgr0/hd/70w3QODoUtw/5gIMWnSxKDvAvd0wMW+m1F5?=
 =?us-ascii?Q?T4FFp7slvdiV5UIRh6F2ytADv/kDre130/hXBzhhHnsE0lWNe0H9c+NPkST+?=
 =?us-ascii?Q?p9L7rxiKWzDQh9jn8+4t+2VKSWddJWRdSktJPDFtmpUmQg5BuWKwvXBfr8ip?=
 =?us-ascii?Q?XeJrIPIcqvQdtOhZ6zkkn0zhP5aFBD9AnIhDE3D+dOueGm28xMPTlYAsl/Fy?=
 =?us-ascii?Q?fyQU8ErjAeydYOEykgilpvsTELMnNBQIPgT/N14zFpzf6OCvUsXTyth2iQcp?=
 =?us-ascii?Q?UkFaFnZQ5Ix7Z+4cJIoa06GXoUS9pVgPTsGn9fsuucubgmyfjs61k9eAH7i0?=
 =?us-ascii?Q?XBiqBvS1IY4sX8ixacfxRl33QzqyAuRotYy22D2qEGFMuLJUFwseqDdjobBk?=
 =?us-ascii?Q?osY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a4340b-976a-4015-4a8f-08dcda364571
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 12:09:40.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8992
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 12:09:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16577

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/data_smart.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c6049d578..4e15a43c2 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -320,7 +320,6 @@ class VariableHistory(object):
             else:
                 o.write("#\n# $%s [%d operations]\n" % (var, len(history))=
)
             for event in history:
-                # o.write("# %s\n" % str(event))
                 if 'func' in event:
                     # If we have a function listed, this is internal
                     # code, not an operation in a config file, and the
@@ -540,7 +539,6 @@ class DataSmart(MutableMapping):
         return var in self.overridedata
=20
     def setVar(self, var, value, **loginfo):
-        #print("var=3D" + str(var) + "  val=3D" + str(value))
=20
         if not var.startswith("__anon_") and ("_append" in var or "_prepen=
d" in var or "_remove" in var):
             info =3D "%s" % var
--=20
2.34.1


