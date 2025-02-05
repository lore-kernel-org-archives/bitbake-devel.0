Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB60C021A4
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.128])
 by mx.groups.io with SMTP id smtpd.web10.6665.1738739756512032404
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=yyIOZMYq;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCmpqCxOf52ND1AuUhAPPk/Dq0vUqzknSAQKSTV1SNBuQjadO+SgxKYGRGsPT8PGQ5k70O3W9OwsGsJnOWQELu3t1idXuXV+AIJqEFUwnv/uxnp/KPxYEPa8fr+uMeTnGHtBT3qtnlhzAZa20iDaV4OweEmOHKcdyIYJPq0a98QOBDn1skfhBCDG8ZHCtXldPDLG/bctD+OSB9SG0tCmBWgHRfdWpbBfu0bkxlCm0srnz9jnDYCNiRCDZYbErvL4y/lmMJhMDfXw7UuNW1NOddYqNzIScYUExJK40XaYR2bpniyAkrHjtXkHHP2GeD65tCgMuqP+Ykrkt4NGnSwZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7UpTbXzEVX3ICLuHsgvcZJz98bCplkf+NZGS2XhO8s=;
 b=DDTFeucGJZFP3uJbUHjbSCBx9ARlITq2vXiKmuuRtSgOf8B32isJiHp2YI/hEFM48YbOF9Anqhxbhs+E7zDkLUcnt8p3ivCTmoXejwnQ14cUvgJJ/1EyZXjjN7A/Sq061h21qritt+YHkgHRK+wj0xqXmIhc+66uptEO/oObs8l/J46LBs7IBLanSv3TnzEHfpEeX/FJs9nPuLUPqVfM1fIzqiQfIEESkUvr3VbeOPiKV9WuvNI7voKzWI7uktCe2OeumQYyeu+65NZBFnnpYRGaCySRPXnSkzilZS9G0QrnAespqVdx4YUErrCt2wGG5VW1JkxeTctCSyDsJH8WMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7UpTbXzEVX3ICLuHsgvcZJz98bCplkf+NZGS2XhO8s=;
 b=yyIOZMYqLQYfG78UJZbjZE6XayKym919PsNrppeLk7xoMYMx/1XxPdLvxFtPYadlYvbKHFI33AxqtYQh/P8Refmy54+SpCte+/xFAgH/8OzwYdcUcVKtL2zxHxvT61x0vQM1uOPkldH+8WlrYAWAG+2Le/RZSOwx7k6lJAUrWs3Fg/e5BOiJ6/ZonTDYExJbEq96pIf1KroiANf8PKMLDJ7qQbGrMevGr0cGJX2BdYqhdc+bKB9kevwRohY+0fYFi4mWAYbE8ABave8l+RcBtnPP+DbvSuJwze2SRbOm0ZZlyWeh3xFZJye41n9akIjKURdk91psTpQKAdxGTC42Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:52 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:52 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 05/15] fetch2: clearcase: remove double DL_DIR from localfile
Date: Wed,  5 Feb 2025 08:15:28 +0100
Message-ID: <20250205071538.2681-6-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 051adf26-5576-4d83-e7dd-08dd45b4ec51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cRhipOA8gCTVxBXvoa8/TqzdZZpEJJ/TPkEnGSim3CMXv92gSEAzbpD4pKIf?=
 =?us-ascii?Q?URHfMaypPXBzbkdG7HK8soq3tFgnmM+wGuLnBCZlGxWWgZfcDdv/sjpTMazn?=
 =?us-ascii?Q?HG6EMJ2+ot4qeKMG9N/+PYF7m21Dfsg7TzPMwxhdImjjPvjwBI10wuCvJaAC?=
 =?us-ascii?Q?A7f9NzzyHW6S+631gURixqXQKCAD7PNgVD2NyO3RiOba1TgwDdSlYW/P0tNV?=
 =?us-ascii?Q?nUjPAdHGOjxyJctaJjiC57RwdasN+IkEvVd4p1SfivW0SwITA955HQk5ncPz?=
 =?us-ascii?Q?QLOue5swANYl0oOryvRK0ExpLikgW5aHc0vd3tmmalVGlOJv6dATljP75lmO?=
 =?us-ascii?Q?6n5RorcY1DNr2l0yE1omVVyr69tBxQifI9/4xFjuZktBnF+rgioTGxpeIcji?=
 =?us-ascii?Q?UQ3GyyfXyNx8rG9TnN8x9YDsZo/HfV/UlDlcd/rtzx7m9s053Ttv4qVMBmb4?=
 =?us-ascii?Q?r4N+iaQBo9xpJLq+RU5n00P+NpLMWh4MAVG7NL/fQTrgJ5miEwdEbbf8Djl9?=
 =?us-ascii?Q?+cbViS1jUt5Q8DUIuJf4uEx3VbvUyHeumPdeGvjmF79G8bzPR8cNI/ZthgAQ?=
 =?us-ascii?Q?cOncTLAydqPB9MG2lZ1Zrm3gZpSjdLTUgD9CTseGaHeZYpN1uUhCEMU+4skg?=
 =?us-ascii?Q?0eQxwPc567PcCplsq4DkYKi58l/hQxL9P/kPDXkQIQz+meJ+Izkzc4HHn7F8?=
 =?us-ascii?Q?Xvx/hpxlvGRj8nK63FRWAXjmlHlBYRpQ5oRtiuv36XEdwTacztEKa/IdDGU7?=
 =?us-ascii?Q?Y6eTUU7THR9lXgxayj8ZbotxVUrP45D9ckSvkeIF0c+EO/5X2YmVOUAYpXFP?=
 =?us-ascii?Q?kVpgSoOeKJVq8P3xG/bOc3zPIG/T7euherdzLW7GsLDqlC5AWZGltQEm9JqD?=
 =?us-ascii?Q?wtANcQFgHX2eC0mSI9DQrTzfKLeVE/BwpUDj8q33N/n/yVw/9H8V287Sga5d?=
 =?us-ascii?Q?4rYXxFql6GDfSXaZ6Pt8ZnQtSgTQEVJjtGr7BhbGrlxJI2urqz7JXi5E7nxV?=
 =?us-ascii?Q?fRNVpTQXA2dp9wviZn2HWINvRhCfcWGb9x/WRXkRCcSVTQzZ1USk2fKpL2tW?=
 =?us-ascii?Q?p7aO8L/E6oJv0BcixNp4F4BEpHnziiTCZ5p73/uT6wgQWRclQ4tjWuoyHTEm?=
 =?us-ascii?Q?k3Yjk8TpAOcaHiZFzs+++HPtNp8VbgtgqF9kwpmR15FhRTiAWwe8kuN47MYw?=
 =?us-ascii?Q?pXwuXbbbS3+DlxA8+kLMQIqZvpZ/pcuEHvowFCaXIYRShFTRpB4LRRFV2G+I?=
 =?us-ascii?Q?Hm7U9Ot+NgCvuICd+aOfMPtRJYDKrobakh/LJdmpO7TEOFzeSigH+2fXSmx/?=
 =?us-ascii?Q?5HqXNadxhjE+2vhkRwDbhMA7TxASgSh9QM5t4P5OvlHKw7kYoLmcQXlCSCWS?=
 =?us-ascii?Q?a302gF4fiL24avAONq2vYvRn7y41u4ezJqSOCLxVMn0FJWB8jTud9O83QQQt?=
 =?us-ascii?Q?pPamjDMeq2NJaCVzg1TEvqF7tdYWAk76?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4zpCpmfLpRIgdHemWbN0j7zQnQdAkloAi/146sb78k9/AsfZSlRT7OnCYJCv?=
 =?us-ascii?Q?lsYLGlBjlFHf8D46DyHR7amCBFmPVLvhwRzehco+9ii/kOHAKLzbGwh/6DlD?=
 =?us-ascii?Q?uzJJ2tdohhYhknTq+eGhROELJwdC9Z8pbbH+/xZAA/RyeRay18ZEryT/URSL?=
 =?us-ascii?Q?pdHLd8YAfY+qz5y6H+9Xv1Vty7zljHGRvqle61Qr2CN0c39A0Vir3jpPrzSC?=
 =?us-ascii?Q?fRn9IjxJqXsmcAfo2mxKWaj71LdxxDDPBnAc168fhTKtwU98fZYvv383Nwr5?=
 =?us-ascii?Q?+TEfnjzLNKkqSo50dg+gFacDVe1Ud214O3SDHvzWbp1mjjay0RViiqwp/xIB?=
 =?us-ascii?Q?1OpjsYt9Gd89LJQrJL8/lBC9kg7R1Bu++xf2fXCqwCle9IuwAWppfCrEDJoL?=
 =?us-ascii?Q?1Ub9LUVViP/wmnh20qK9m0gOEBfUMgTHzbtCNOTjZGxfPS0uxvhOItY20O6G?=
 =?us-ascii?Q?idcJpQkPXsg3cHtRqdRWfIPh61VifGZ+aIukWy7UZlmMJjdN1VcC4FerCweA?=
 =?us-ascii?Q?hqWYCbc9ObL0Oew+3xXosR5PqYELjcwz5B7kGtGlSd+qLeOEVkkDmo7n588m?=
 =?us-ascii?Q?MeXiPAFI4oe/4he626qH5XFbWiq5ZgRvJ1U8ASMhr/X+slhdZk5/3HuebNci?=
 =?us-ascii?Q?Xtd7dPw/+x7WuVb5mV0FPjaDty9/rWEauJP1TTgOd9a2tCDPKC+ATnDq49pR?=
 =?us-ascii?Q?jiIIuqBDcyGG7p1sRlH11jCSzWa/bGS7OEiEK4UwpsVQ1mewa0LldVojr5Hr?=
 =?us-ascii?Q?1QQsjhfmOmpcbytNhZp51JhFXsrEOK7+CXK3NWiE8M9RCB6GBxEH4uEb1jpl?=
 =?us-ascii?Q?vn3YFbdT/PmvKTolLE8aKJ9lUVh54KZOQuf3PJqDdSaKVWn5Mu0+itlIktwd?=
 =?us-ascii?Q?aY6upjIQ1wXHyoJppX+vGw6X/CJJn+JWIahlxzDb3Y5W5nRThKrko8DkTtkE?=
 =?us-ascii?Q?yUfqW1XbO8JvCo8ESpvmdOmuM8xmQY6aPre51orlldoV9UYC6wGSEHLyAT2a?=
 =?us-ascii?Q?s+WOnE7PhWpCuztlaEh9vZnZfSTohoDIEnDyuaDezCT34nOd+8+2wNZU18Mt?=
 =?us-ascii?Q?gVmDuLu9IKtNTNmRoFQFh7BZvx3UVyCgrHJDnStNo/smzzRqQiXB7wrSZZsS?=
 =?us-ascii?Q?zIoALVypG2kR0P2+c5+B+tfbE4y2mENwPGdb8CG7nBNLusyaYkisUatcXiiN?=
 =?us-ascii?Q?eC4S1Ilc/bkBgo9MGOs1qjJLVSgn3kK5KUVHRwVysaY9tNaegYl0FyFnDyHj?=
 =?us-ascii?Q?hOf3bpeTcDxMKdeLCmPg7lsxhB03FLSBtPpgQgp7g1dtrNnftcV/MoGzun+S?=
 =?us-ascii?Q?QcJBWkJ1cC7x5VX6zkSk93/hyoyaAUdsu6vM632QxfyTlx1Mz3nhSFIjcnNU?=
 =?us-ascii?Q?Au2XA6Zhe8ER6gxxnQ0Hb/ZcJiZ7gCTEe0x3o33Iyg1vAsrjBx8TGhR57wVy?=
 =?us-ascii?Q?/sIbdbiSdjh5esV+L460Vv+J72NlmT/8QabXZr6cULm/U41qdgHAFgOUAhXO?=
 =?us-ascii?Q?QPZnwiIHkRNzzgkkrPBKM7VRoDvEQjSOPnigEpsZTOkr8aXaD0tj2YMBB7CO?=
 =?us-ascii?Q?UaO73FR1+VEU0igx0AvXvsez3fsUDJzAubftk9mLxhIq8QZaRw0/4zKTb7RE?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051adf26-5576-4d83-e7dd-08dd45b4ec51
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:51.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLi05i6MQ8010NIMAzMiq/QOfUU08xKxrQZkxtI7LwAesUMMr73AfmDtYo3R6LDUOl/UOnCH+IaNcrrusXU4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17136

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/clearcase.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 2b3bd7069..17500daf9 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -130,8 +130,6 @@ class ClearCase(FetchMethod):
         self.debug("configspecfile  =3D %s" % ud.configspecfile)
         self.debug("localfile       =3D %s" % ud.localfile)
=20
-        ud.localfile =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
-
     def _build_ccase_command(self, ud, command):
         """
         Build up a commandline based on ud
--=20
2.39.5


