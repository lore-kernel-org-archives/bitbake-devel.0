Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD8DCA1013
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=VohCsmUV;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq2Hm9Uab06yybGGp7p95b4Fz4C9dDp+byUc3RNUBiCU3fHSJ1ZwPxELs787AkQJ9yusvoxA3vvmYx4nnwqQf+ChKfKHr+X3//PG90rB2VnhduicTBW4GWF+htbfhY/snx/L+FcEjLyYMFeu3ifpF2sxuqYQlhoc0iggmltKQ6I0ghJL+F/9knRzKEbBbYq38Ekaj4ONZX+5IiM/5wYdPUg8vd7CfzvmVsJgAua3KGp4EFYXRI5ot9SGyQDoZW+XlwngWc06j8r7d65W1krTeyUdPqVmxa7p46pdEkUhY1QKey8FzSMIZbzdsyxP+oK7D+UNGVaPhu4hkSOLMum9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhkxBN/Slw7Hb4Vul1kLL3QpGAmLOfDhTfnGTCg6pYM=;
 b=VShZUiI4jMY5L77zxv4rJXrSm3Rty7RLUMbTDqsW8QzJc2+0qEyV//wSFj6WnK9Nd+ZX4OvKxrmDbLYDZ0Qn1uaSu4etodDmKHPlsfLvhTyXCYGlYADe+0EskIl9WK2I5fMfnjHXySu4MGd9Fkk2QO8VbaHUpDWrF3dqRpQ5JHoowpoxKTxrJubsj2wNbiXrnOHPM9ZJ6+SvjGuEnB62vPd+VfhhzDjeDTm5sG2YtoTF/clg72im3MwsEAg25u0vuQkxrStm+5v+mI4IuPVVrpxfVTn+y5SizmDJZH893Ww0mqgPhHxg9b7GRYYj732fxWTIXtmrHYW4eNuY3BwEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhkxBN/Slw7Hb4Vul1kLL3QpGAmLOfDhTfnGTCg6pYM=;
 b=VohCsmUVe7Iql6TjZk0L/zTjK82wTj942qDthhBbQ+Jn4JmCy4pRUtBFRsbDKJOB0e1jThVa2xN43B86fU2ddQdxH+a+Jyk0AKlUqcm97hpKXC6KPppdJ1sTvaIiYoDwIKEv3sN/Pv9/vh/KaDDkuu0Xxgub/BMkXa0e6W9wBv5oxiTsetgi5iUhqG+wQQ6hxtxch5sRhD5Jftj7qxFlGTTA4LdbyZ0Yd5PbF2hUA77ZL/CvCx3LSzkqwDSGanRPIOPYTlTPX8szQdoh0wb6bsK299fGy7hlKF4PeXGo67v4hENu7eOgknQPp3QoXh85lcXq5nw7oZBw6jkdkIdJ8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:44 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:43 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 10/15] fetch2: gitsm: add parentdir parameter
Date: Tue,  2 Sep 2025 08:45:09 +0200
Message-ID: <20250902064515.30879-11-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 510d8c6b-e2bc-4fd8-da55-08dde9ec54e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tHonDkUR0+dk3ZBp5xOm39Oq60fn1Nrv+CHewbqaVNbUNL0QZl/3t+dov58H?=
 =?us-ascii?Q?tVMn+rKnaykD8nI6idPT9L7YGeRBRUv2R9H38g9MyBcqi5v/KA2hYnDV4W5D?=
 =?us-ascii?Q?rdLVPnx7gJkuA6FPv9IzD/vnqr8SEXicn85lm+4ZcPZs2WKLqh6OFntsMQg0?=
 =?us-ascii?Q?2cqcxH6qNprIhR/7hU9pK3v5o/koztCEkgrOISvwaDDcllSTDGypxknu3tZx?=
 =?us-ascii?Q?8dfIYAwXwzL1e8edITbVYApqzFsRk1V7zoeSaAc2F7/AB6TZMpE5CWafN+cF?=
 =?us-ascii?Q?DmWS8p8VYOEQ1+IHui9uarwC+iOAdE2dS18jdWSS3+qMU8xApW4uGIkaHmeC?=
 =?us-ascii?Q?w7ddft2IB2+TLcJ/mkEbvtYrhBvmGqcQ9r6qsBvXzz8isfbdl+wexalCXGY1?=
 =?us-ascii?Q?CVQU/1einNGygVpPBFLOOx/sruQXdvZlapQEHBUrBYzfkox0CQPtoP3XGrG4?=
 =?us-ascii?Q?x/MLPrJDfNUWeGvLGBx5E6kKxFntgJEKUUu0DwHtij+eBEgAE8th5ruEX0wk?=
 =?us-ascii?Q?kdmKw+btP0jG12jkqFPbX0w3PHdWVNDfQHVQ0LJSLb4yLi7TdTXj62R4WkbX?=
 =?us-ascii?Q?VmLM5LaXqcC9xL+6204hL3Bp5Ozeg+ZOGRIfetSJyvlGm20eEuj7SfRSt2l9?=
 =?us-ascii?Q?gqMSkEpra9oIrNFCIY3D9EgDlwpYYBWGsH4a9sTotPErcI1i3xemdoayQNC1?=
 =?us-ascii?Q?nq4GfsTO2zwgh7eqx0WHXhgMJu8o8uVA+49RKAmEQJRV1FT3QLlnDMaGWY2X?=
 =?us-ascii?Q?FhhJUICu48A79JcgIMKauSVUT8xqLnapL4J0r2zX7/1elQ034qAST6/2FYI/?=
 =?us-ascii?Q?y4xhRtGpdJpqPgCVJAZ9gGJc2LnKIR062Cejx+M5HhqY+9qaVxrkfP/LKc49?=
 =?us-ascii?Q?tQ3MXceGz0lNNgrdkBvycpIWk31MGbwG7UI3FVLlgpfgnFHPuGkBLbdnOiYG?=
 =?us-ascii?Q?g3V3AnelcVGaJcWTJtco54ltqzg2DbcqEK8IwYf604wvxojWRUJNkOn2XGG1?=
 =?us-ascii?Q?9sLkMVX7ozm7CgPnKAFNe9LzDSrhZWFbzwWi0NTfNQwxda7gEKsbQbG8YOAy?=
 =?us-ascii?Q?3hmH6bk2w41Me3HzLD1jnm1Vw0SRSL7gPzl7m8KH5WS8zeO+BCKnka6i4sbx?=
 =?us-ascii?Q?NFOzMYqPSeEIhIAibFURsYCbYSKA2zVEnK5gXVwXn+J/9DclkSI4KVYC8sPH?=
 =?us-ascii?Q?NNxUilUHgBmQTd5dWnbobQX4G5c6iPktBBy9kspo4VUF7GtFjhGGIFjK1RIh?=
 =?us-ascii?Q?MvNiBiIRSst74/hpa2JLwAaiAKZL442Ie0Pn5BI63MHeZlwxYLBtuWdzwpmx?=
 =?us-ascii?Q?utTeA8LkFbuzsiDNEm+438zFoq7GOqX6s5JClKIuBe/N5qpOVUMgnFeCbksV?=
 =?us-ascii?Q?ZVPHJpxCV1FUz2PcI9b9WywQ2c1sbXH+OS7aHQPI0yD5AIpwjFiaEMpE0cvr?=
 =?us-ascii?Q?ubi+3O9cPN5KZPvUmP0A7wIaY6XM+o8GBYhKGmOoj/0M4DM1XNsAXw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x0C8lVSEvqx6rgS0QlPf9OH7v4REJdZtvNzoT1LKKTusVPUr0KfcsE22pyPJ?=
 =?us-ascii?Q?R/Nr71tMiYCA1evhKN6N1AfVekZtiGKG2c2b+MOlxanvKtvp5F8SnLkC9Efp?=
 =?us-ascii?Q?t3bW3O4Suf4o7t8czTFOgJvU2JVQkS9lPtLF3APmMC7/Xxh3sRGCLv+X0xE6?=
 =?us-ascii?Q?KsP+ePkQJ+FdMiPKa9FvnptOBVsOkuPSCrxZUYH3hBz4US2o4qL2exjL2R97?=
 =?us-ascii?Q?6HKlEHZrHK+LHmxo6y/gnHH4Y2p6XjXEhsgiuC5RVBjpBCFEEJ6XgAYL3UwH?=
 =?us-ascii?Q?Gx9MNcHgY0ayBq8dx918Y8fQpsRWEtJPwjkOsZj/2PqgyM3wTKUf9W+0gL1R?=
 =?us-ascii?Q?a8GA0AUvxebxofWvnIFR4Tpg3gZ4z67ewXh2btHE/7UdqM9fapD7azCQH2Ix?=
 =?us-ascii?Q?gIH3K3LqaqT5EYo4WwbANeQX0i5yI8sKOkHjYyAcmpXQtc0LLDuVJBpyH9Na?=
 =?us-ascii?Q?RL14iqGbgcnt5AZ/RBxjAdbmRvMQYkLXev+elgnEsKAVjZoS4JEYWYI3s5sN?=
 =?us-ascii?Q?5rmvUoaP2TCioaObgnL/wIeZ5lSdnt2MChUnX7gtL2Cz0Ek0dsQCgf2jT4rq?=
 =?us-ascii?Q?sZ0tA8mP7DdGDVdUx6axI63yod/6LXvfGVc77S7L+ecpTYncnKrZWsx0KhIF?=
 =?us-ascii?Q?GeYoHhT65MpnCXwfR87Lq1F4Hgd5+ExDuGpjnT0mAQyNWRqyhho3smQ7QxYi?=
 =?us-ascii?Q?2/jsrGXXMfxAWkHabh6D4giXa+idV8fv9z7ZzMuqKTlSv0Ifz1JYUzQJaje8?=
 =?us-ascii?Q?qh+htoYgXKkAf5WOMFtFPT47KtdB2hBauUpVQV+JaPXWR7GOkhnELRgu9ibG?=
 =?us-ascii?Q?BvcNeLryHCqZmBWmNtqdwl256UDg2gQzNlAX2uh6+81gZm8WE3zYMU/ZryN6?=
 =?us-ascii?Q?T8pyQvarVGCkQKyUwVXWZv9mClpoAsfhoYbUnMTpC3t3N2WrdX/+rlfJmnSY?=
 =?us-ascii?Q?oL9WCBt/wBLtU3fc0hZwvUCplB/m9h0xw22poMk4ahEvfEsdRYuSgwJoo9NQ?=
 =?us-ascii?Q?FCjn4GEfj6jIY2anKnRt3BwSr7dFfCOpgbDO894/kRc3TBjkMeOdUgJIwST4?=
 =?us-ascii?Q?i5GYwZJCrx65FNZdEKcmU2JtKrKFO6UGz0YTNm7VrccXriPtBQuPNEC9uioh?=
 =?us-ascii?Q?CvG8zy+s74RNOlD40u1sGxjrFU3vmKE2xy0keitJixzX0PeM+73yfNazQ9JH?=
 =?us-ascii?Q?W4UsyP8g4vFJmaf963pLJfyB9Tzl7F8hUuTBMKGBwvRpfqdEUGrg4plQBbhL?=
 =?us-ascii?Q?A3LOnnVWo8CpG7eJGh6o4cYVKVuQuQQiDQfTMKvf/VG0mTyDxW0OG/qYXGKk?=
 =?us-ascii?Q?SHk1TrTJPpCo8Wmk3nCTop46frHNdrOF45GMfVb1Z0zfbZwcjMHrVR2uO5oc?=
 =?us-ascii?Q?dpEW4ADP7Q0wi8fC/NRtYQx2EvSIdN9XXps1uxYAFlaDJjkv32UKLonnWz6l?=
 =?us-ascii?Q?Km+SliDSUxi7XuLrPsbAavV4zpZUprlo/jkkkQ5B3PWZeIz9rb7d2BpHjhmJ?=
 =?us-ascii?Q?UfoiRQcTF761rowzCOz8f64U3XgoDtEsaE36uSbFpbXsxRFNBDaMsLFRLDdQ?=
 =?us-ascii?Q?TbJTO7IotHCPMzUURHzLvEZJiuiljgpYipJg5YWJkbNEigFbZDfZiJbrs9tm?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510d8c6b-e2bc-4fd8-da55-08dde9ec54e7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:40.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m98Hnhzma0VjxpKM2vnEG3CpJFHXbcIrJm0WaWu9Olk3uGaXBT/rpAzzJjzbV2qFTZk4qBLBa8vvCrhR59wDJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17928

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a parentdir parameter to pass the destination directory of the
submodule parent to the submodule.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index d013a09d6..c3e7189a0 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -127,6 +127,7 @@ class GitSM(Git):
             url +=3D ";bareclone=3D1"
=20
             parentdir =3D self.destdir(ud, '', d)
+            url +=3D ";parentdir=3D%s" % parentdir
             gitdir =3D '' if ud.bareclone else '.git'
             subdir =3D os.path.join(parentdir, gitdir, 'modules', module)
             url +=3D ";subdir=3D%s" % subdir
@@ -203,6 +204,9 @@ class GitSM(Git):
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
                 new_ud =3D newfetch.ud[url]
+                parentdir =3D new_ud.parm['parentdir']
+                if not os.path.isabs(parentdir):
+                    parentdir =3D os.path.join(destdir, parentdir)
                 fulldestdir =3D self.destdir(new_ud, destdir, d)
                 newfetch.unpack(root=3Ddestdir)
             except Exception as e:
@@ -212,10 +216,10 @@ class GitSM(Git):
             local_path =3D newfetch.localpath(url)
=20
             # Correct the submodule references to the local download versi=
on...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, wor=
kdir=3Dsubdestdir)
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, wor=
kdir=3Dparentdir)
=20
             if ud.shallow:
-                runfetchcmd("%(basecmd)s config submodule.%(module)s.shall=
ow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=3Dsubdestd=
ir)
+                runfetchcmd("%(basecmd)s config submodule.%(module)s.shall=
ow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=3Dparentdi=
r)
=20
             # Ensure the submodule repository is NOT set to bare, since we=
're checking it out...
             try:
--=20
2.39.5


