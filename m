Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF106CF9C6B
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 06:44:21 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.92.50.67])
 by mx.groups.io with SMTP id smtpd.web11.7764.1727160259992914853
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 23:44:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=jGUG5gaX;
 spf=pass (domain: outlook.com, ip: 40.92.50.67, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUdCuR+glVy+g3t2vq0pu6+s8k+HdFPGtgC0vy77vzJ/CoqhWKJuOT9LpZp1fn0SkRkL5yXIE6+VrPR+62NgFyL+lDzw0k8U1ipqZGn2YRYGAvFDEzOWT5F0hyXLYBF47awQsovrCoLsQjYCD9HcD+Qbeq1Hl3sEnbOL6o6scPWkrAANsHRNrGQRjjicuKzPCd4ozkx8qCPqg9Ez88zH565cJwsLTOwSwAjA/J2+keAPEBqnxuIlSdQhFO0WFZW2QQwHUmxRkHHA/PJTd03H8/jskmojVKnvRoTO+YodBahOVs0TLAfkD/x0/HVvjKS12nOQH0zWgn1MrAmokA6SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GrDObMofvhTMSuE8J/gR6UH0FYZYivnnjlqVY4ZJWk=;
 b=TtiO+sKDtjfIXz9OehI61nGjbCKdexXwnC+4kAUCQSA9IjLLhUnXiQg6PMMvDHDDd5R/x/9RawSBn+OdDG4x7IoOwzAoLrNUy1vOCxpyuA+CUtEi3JyhK4uPc48lvJ5kXE9JgSfgw9u8HjEUin5PYSPU+Tpr7ShMTEvtuiMoOpNUWBjDXs3Z3gGcXcmp0wBmLVT+Bs8jkq/6DHed5f4cIheA5XTJwvkLRQUXDcQOx73i3jkPFlgYhw8EgygqJcrlyHGr4q6I7YXZU4BG1uDxpg4dwUxhSslsDAaAa8paQO0EIKcB8ellmbxWN5nV9CMytH2kFRf0lNrJLZX4PuduQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GrDObMofvhTMSuE8J/gR6UH0FYZYivnnjlqVY4ZJWk=;
 b=jGUG5gaXp4GlSBsvtkURtlTeWtMf5QY5bNs0+t1AIMvGyHaQSg/8lE17gIt/NXKjjq/hp0ogBAv/vl7mkfFgItGbX1+AbUJhuvcnE74mHlhcB2UkL9EwnTlIQl39Rkej1pA1QVnoWwuaPQ7WsUw99At5lmL5QjIv95RYA5eRXDx6+1/KFzZYbs6nvW5S6a6sGz5cLgcUtA3iXQ08YWqvpJEqPmNgp3J83gYhZM5KeVKuSluLvJj3tJfrbQIPi/fHiUYrdh2piSjyylZP0KDH5uW7CFshIfT5QxoNAKKEMzGPN6+AyeWbgdfqJGQTCp7zvLkvxWR4RZTo/dwMq8GbpQ==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by PAWPR07MB9855.eurprd07.prod.outlook.com (2603:10a6:102:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:44:17 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:44:17 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH 2/3 v2] bb/data_smart: fix override syntax warning
Date: Tue, 24 Sep 2024 06:43:38 +0000
Message-ID: <GV1PR07MB91209FE660BF5A5CCB712373A8682@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::7) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <20240924064338.1817107-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|PAWPR07MB9855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6673c64d-3da1-473b-de31-08dcdc644f89
X-MS-Exchange-SLBlob-MailProps: 
	02NmSoc12DdpACTrfqp54YIzaU4Z5SJbHnx2y9osjhWxUJLBuYtEbzkWRcFvoyWEVnPsC1lU9AmTssNJ3xJlyhRXGCBu4t1tePnOXiOLu6TA4So2/XEruGtqLX3XzPgoazj1nAMSHGv9Jk7pYlP4+ar1STWA2yy+9+w1hVLOkxH4YDzrZ84JhAuvCIxBBDym08DBSRkXV/eoZREFPWwyUhDAc2ZpwZCrT5cNFONRf3Y2DYUUximw8CeHdxvIZLuuBuzg4y4yrGMV1lnSMB+htgdg+8U/JXgi4eh+vQRqXznAxSO8Vk0NplFIzkKnbaNGtjZh3V2NkGWQ9GoLpmEs9auDO7Xwz55dGCjU9dyriot06IcEmLOw8fXCa06fS81PIAgr9dzV6v52DW5cU03P5JEfnc93y1wCO1H2JFcK7BPLB3s9lJrY6b0v/pEMmaqm91iUAgrlijZyQb2p+GC2WSG8uBnch/yJMhQB5INBeMqi442fDIMNj00Wt4lKbLloDEOmRvDonN1GO1oVONR+sDqScWKi9l+LK/RcBEOKGQgDoqgI+XNqY5S9Voj+72FCaZ+V6Fd6+DuMM308rpqg6hcU7PQhidPq3R1MSDXSaHRcXdAIWd42C6JZKQSQYQh4cdv2gyudG9ZItt7tXrKztd1nE8sPDo5ewSxvtfWkHUZk5gtyVkfEtFnGWKvhS0K1V6gZMhBmFFPBTTbxJ7LAhrmxYu8qmq5kya5OKrhL90lbGVKno1ujENrpbOgfFTfH
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|15080799006|7092599003|461199028|8060799006|5062599005|5072599009|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: 
	r5cdT95IHuYXeNnls70SxrZZ/K0Qo7RGNBFcEMWOqZN1BG5F56lZcMupl6itq92mEYpCXCaDbE6m0otQ4LEag1LC00iGrycJ41l40S2aiX5J6yWR4J8XDv/Cjff28svQjmiQDj2TEKIE8p6Ao/JJTuCTEQSrQpf9st07+VbviyPkfRf3YAb2qP+qvuqJ4XmTjcmnbp58+yyuXzmZSsYeXNEBwfAOBI97cRbZ5kf2Udd7VctdLQZyp9pPBV+rGmiURpLrhy7fRjB63nUX9TeTnPB4Q3jaGR2RKeP0R8csxB7aIzWDxxsd6Sl0Dk4SuyzRn6i6hSSWtJ5rBaOMjRP/MT1IHUnjqS/yd4MFStKqeH37I4we74bYhRhhd6JLwEUlF4uC0sdj+y/khcUn1Ovbv7j10au6ifiIuMiEHvViyUdXGeXWK1g8BVrVm33utxuiefpSYB9ZkAlQKtaUZETjXJvs0yjfKO2nex6+7KR82FNX8wuHvBKv86ltl+ISQJFgAdTo1SdAkfYx+Bey3BI9On7te6mYcKhQyO/ezcogorAvxrTxo2fq1/40Ak4LpUzB+NPZ4OA3c6arwsF8tsPOTRhGjzgGjhRJt0L0+AfeDKY4+KiDYDxlkJP9ojPiBN+S67mYRkVoZJtQj9FKmZ8yoAfl89AFF9cLTwZBToRyhl5Lyau1T8Xe22ufjJzX0OYpjPqRdYFmXwuAMNEh/KGaCgYgYkhn2xu+nzGVy0spkYmSSizFoe6ZHdqFC0ChXkVwjAv993/k9OSKYudv78X1x1GmtkFD9a0DCN8oezzllGE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NaRagcYNZvP/n/curkgUmLV97fZMkz6I6Xf2JBJ/EMwDFQgdrIpSKKzUzC7z?=
 =?us-ascii?Q?gkej4F6u48znWKqfAemCRGb33zojFIaxxiX4vRR5E/np+vj9sTHHMAuzn8ng?=
 =?us-ascii?Q?NwxMRir3PjZ3/eCxYJUQtVZ/QFAfsepswAKbSUKwMKrimQ10+2bZ5x2ufOuY?=
 =?us-ascii?Q?MvLdP/LVT81bAQ1wibcxWTYQGMSAYZenRFnr4O6NK9UXcW5XDgfR07QGaaIc?=
 =?us-ascii?Q?4vZsGd+4LWni3x9dSbI2BuGVrg02ruODpLHunhZNcUbujoy5F2+HYraT9jIX?=
 =?us-ascii?Q?29/5ZHmj1djKtYLSTycGBnYAu7qX5T5wcZdwjVwbm5HWhVFnWy399elFUJgm?=
 =?us-ascii?Q?AdrvIIpQeQVz+y9mZg2J2V5L1+n+wg6pel/BtARInna4BMF6zKZxZo1/e53O?=
 =?us-ascii?Q?LIXlSJQjGLvJLSBRtx3o0FV6mCq3J4bEVKhF/8cnuTLASE2YMs7bxB/AGiy/?=
 =?us-ascii?Q?fepRJyOSmx+AQNyPSsDeTQBGGGI4zAYOkE5IL9yAhG6oLQdBUwTL/OvYARqF?=
 =?us-ascii?Q?YfwZIbCOMWBbEqUxf43YVBjgNY0AcIpyJcbQqiUsMlWg/lULgVQUbjsxaojB?=
 =?us-ascii?Q?qAfMOk4WysEyls572UiE6DMZdDM96Pjg2jlSYUikuTV2c3EZ/gC8TTwSay1q?=
 =?us-ascii?Q?8DLVzOnV40C0twLXVQdH9eo92lAvSkirOOLnc3Wd5I3oGi/SUXmaZaOjQAI0?=
 =?us-ascii?Q?Vd8CWMlh8KQfaD0ZyFCrELialxnqR8yQTdy0mZobPLttzBdvjYRNAjXZfMDl?=
 =?us-ascii?Q?KSfbBdUiA8+8DwkFGKzbE9JlSSMEGPtXzIvd0xy7bDgk08tfUVi8blvUBxWi?=
 =?us-ascii?Q?xj3oSjDE5tOLrMWPpG09cf5Y1uVLdWMODJNIVr/3BC/g/BSj6sADp24ctnpi?=
 =?us-ascii?Q?XpVsSsJ0sweubHXvkRWRVR8K0XJTaJGBU0j2KeoN3w+EIXnjUCG/d9ripBeL?=
 =?us-ascii?Q?Z6D/A055jNZr5YRFF4FBZltOk8tT7gloKjj9ksXfG88LIVmnrYAOzBht4Uoa?=
 =?us-ascii?Q?3VSCUy0an0xLgJMC4qKAu8ffcnyLI7RTmJrZ1vf76TzsU/SKkhh+790JBC0m?=
 =?us-ascii?Q?WDEdIO/eB98XEieAfYlNMXmOl52BTPTLbJbMsmjD8VwQl9rzX5fZBOSvlzfN?=
 =?us-ascii?Q?KdzTA8keaFuei9kzl9WgUvonnNpHegs2v/cGhIiIQn6uAstH2RSjoPgFAq3I?=
 =?us-ascii?Q?g1GVaOhGEsXMYAQkyzJC1qk0KShbGCi74JSEPI18YA8nbooUCa5CljBmhznB?=
 =?us-ascii?Q?wcff8K9Sia6/8lcz8PA2gDqquAgZhzOSZla9aiap4vnD8aOI0l0g2nOqopUA?=
 =?us-ascii?Q?xws=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6673c64d-3da1-473b-de31-08dcdc644f89
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:44:17.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9855
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Sep 2024 06:44:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16593

when defining a function do_removesomething,
the parser warned about

Variable do_removesomething contains an operation using the
old override syntax. Please convert this layer/metadata before
attempting to use with a newer bitbake

correct it would be to search for a override operator at the end
of the string or for the next operator.

To avoid running the expensive regex search on every setVar call
the current "cheap" check would be have to be triggered,
before the more precise check is run.

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/data_smart.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4e15a43c2..8344981fc 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -539,14 +539,14 @@ class DataSmart(MutableMapping):
         return var in self.overridedata
=20
     def setVar(self, var, value, **loginfo):
-
         if not var.startswith("__anon_") and ("_append" in var or "_prepen=
d" in var or "_remove" in var):
-            info =3D "%s" % var
-            if "file" in loginfo:
-                info +=3D " file: %s" % loginfo["file"]
-            if "line" in loginfo:
-                info +=3D " line: %s" % loginfo["line"]
-            bb.fatal("Variable %s contains an operation using the old over=
ride syntax. Please convert this layer/metadata before attempting to use wi=
th a newer bitbake." % info)
+            if re.search(r"(_append|_prepend|_remove)(_|$)", var) is None:
+                info =3D "%s" % var
+                if "file" in loginfo:
+                    info +=3D " file: %s" % loginfo["file"]
+                if "line" in loginfo:
+                    info +=3D " line: %s" % loginfo["line"]
+                bb.fatal("Variable %s contains an operation using the old =
override syntax. Please convert this layer/metadata before attempting to us=
e with a newer bitbake." % info)
=20
         shortvar =3D var.split(":", 1)[0]
         if shortvar in self._var_renames:
--=20
2.34.1


