Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web08.19601.1617383778008536618
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=d7JFZLyT;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwrROBKBPMDb0ACUDqKJtXvUl9EHD8/qIFxKBLaCJkrPjVnfgdLduaUhyA6VjeLqtR22s+d0qWaU3+lUO6zWFTwVAvL5K3CTuItXA027v9CYbuPOkTMbB1fn4OMRr7YalcoTR9YJW4riyD9c4QFro6GXKEQB0wU4waXIk6oR/vck7FEEb1Yom9JeKrFGnMCZRbQGS3jJg4MeyZYxekFmI9JyvLej6A57degsjgpFL4SIOY++EAcumpCS5dj3MBjVg114UYM9b5u5YivjyET/8OuqJSrxcyj5rtCrgI7KWG3xbZ/Ex+jm8HXPX72PnxhPubT0qQoRC7+ianGVUAbJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCUycPKsUoKVt8iLBs6jwG8iQAc7jbGFYH0mFgUcpmM=;
 b=kwJgRd9/cNsfHmiiWcr2T1uESXJ+Su3WOghWAFYetcdSZ4iG6MfoH4/DldIsFjSVnl2L6I4x4lrn6FbTCALz0kM1awTTbCnxWfSStmN8mKYkjz3NQx0G6703bNCg8/9QhxIjnZR1whjYY4mxhbWRTNscgdzDDaUFWRZ9rjEe7x5c5JG2jH9cS5ssAvZSa6mgItYA//aLucMeOIwvS9//U16drI7b/7Jh3WUgX57ResKmeNveMoja/F0L/AlaA0cfBH+2hRgJyVkCPI4maXfxtva5Nfn2ahsRWRdOc3NOARasd+OXV1E2O8AFsezgT6LhIBFNFqzxPwp6KUg+QTNRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCUycPKsUoKVt8iLBs6jwG8iQAc7jbGFYH0mFgUcpmM=;
 b=d7JFZLyTM8gwFC8L/xbMl1WkJRfUIw9mwlQZ1KXKOPmVsk0e164EXPt60ieBZxwooS2tg4otGnjx7OOmUVTah0QkNmJ1J8yh2K5VCYQkFqm3alAKWNlOjmKvJRiIHtC1HdRMSoDwK5d0M036NY+qBMLoX9/egkbbLvaa4tpw3lk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:19 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:19 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 11/21] kernel: add a fetch-only recipe for mainline v5.10 source
Date: Fri,  2 Apr 2021 13:15:47 -0400
Message-ID: <20210402171557.981599-12-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402171557.981599-1-paul.gortmaker@windriver.com>
References: <20210402171557.981599-1-paul.gortmaker@windriver.com>
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:208:134::39) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
Return-Path: paul.gortmaker@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef67615-c6cf-4f26-ef75-08d8f5fb0806
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB22498C8FCDD12790B338EE0C837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9FLoGSVZA4NW4PA3o/v7FvfgtflbjmVQzCkR7vafw2y/XmGP+sAOAxwI2LXQAVcmI7AYUG/I+X3+X6NR8ghjeuLjNXmAAhkutwWjP3U+LNrcGEVZMvb05GKiIaN4GFr4W5jP4ARnTwPIG0gkmgHz6fmejcOgZcrZf2rE5pO4u/gONGc5yU4vxnYLkThpF32KMVFqRBaGWFF0A1ofyQh9jEW80HMAqmH2bn1qM6+4zbpnjNEtrFfdm4tNCDBTYQ7c7vdRDWTL0asllRWZ3G0+snpHpGNzzqBjlolu6fDRwug2PBkvbj2/kpNh+yA2t3NTzVtKDnhaz1aJqgWGIPUDejeOQvkFUfYXnZ2A4bljxQNnotb9Xm1YGLhcBO/itxDSfljdEEBiQf9nUMePZ22KNJK2gDOVuLA3xf3PhM9nFyonHFlyFLBfnU4jZSCpBVZwzFRImOGSumJjwbuWBqnjdWAq14cPD8Hod1VEpVbxCSPfry7aflvk01Y2RHCRwt+qz0sABkqwCA9OflxmGuIOzOVtgiaRZxgNquWPPaJId8+aWjkPFbPsA32zDvMRqZcbx9V4y9JjGi/kfcayA/Y/gidVkBBDX7j4gQMK2jKHfs1CCNjTKnJY7XEpjpobHDrmrXOnfC4hmvjbLf5+20UoEA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(5660300002)(83380400001)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6666004)(8936002)(36756003)(52116002)(1076003)(956004)(86362001)(2616005)(66946007)(38100700001)(8676002)(316002)(110136005)(6486002)(4326008)(16526019)(186003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?vLSJL0eTNNixwNo0q3rcZWynbayNTc1mVeUU44J+vEo+cK/+LLh6NzYAXU9U?=
 =?us-ascii?Q?AIAZ7BaIjVYfjMGofn3d3GS4SrwDp0zMRteSJv6N3cgkUnf5l3RaK/uJBeBl?=
 =?us-ascii?Q?zIRta/h0etgzG65zNItmDeweb9Sfn9BhyjEn7I59RmJcg4Ovb49xy5zjRJj7?=
 =?us-ascii?Q?jcqMKTakyXao8gWGOn33IBKhcf0Z+B8t+Mwp5mtdImuHLodw4P1K0RQcZ+KG?=
 =?us-ascii?Q?euO4otLYGVOyUb0LDci7R2TQ7ReZEHntCQ+tAUEx7Kb7/wATbH09ZNO/7FSd?=
 =?us-ascii?Q?XYBUE2mh7zr2AzZaHrAKfZ9sD3cRS1X7ThOlhUIh2AhAYqj6wGObYnag46kF?=
 =?us-ascii?Q?q5njOOOM9z6mxH4SdexXjlF/gSdOAvacclIvlvlT5oIA0V3ThprO+9Sg1Mx+?=
 =?us-ascii?Q?qaBOFlMScKyR7N7+RcspdueUho7RWKOoIXYWfH9kx98zshb1+wGjBpVmI9GJ?=
 =?us-ascii?Q?syyS0wsdbd/5KcMZBhck6Hr9Kn6O5LizxzRK2UZXV7+qcIOKoFKmj1Ja8IRM?=
 =?us-ascii?Q?dwcZa9dZvn1XjnsmjVOxiWjBRP0tAuyKmxzomXKQ/m1gPb/6kCqapOR2QcLU?=
 =?us-ascii?Q?4i78PydnnR8JVUep2F/t7Z64DCfDXp2W9otSbUVAxy962xgtEm3pV7tXnpNF?=
 =?us-ascii?Q?JrRYZrJliYH62G5L8aGFMuyHHlrXWwoyoYBp0moAXfv9fqbLwE1aOmXP2egb?=
 =?us-ascii?Q?OshvAdL+ul8xwU2ER3833hIkXwLboiLHoVHy3PYV8H8C6boAEBel3rOeYTNM?=
 =?us-ascii?Q?UoXwILN1XcjckA6DDBRgv08JFFsNwVFF+OsFqm6Wvy8Cx/hhTy08ljB8/Amc?=
 =?us-ascii?Q?WoWs7ZQmEMoiF1B5DuVYkCDePQcAC6CVPUMVtNYRxbLtNkEpwwlM+wFQk+SD?=
 =?us-ascii?Q?RCE9+NmczycDjD/G2wi4pGexBQQRWLi3OIih34s3qjY3KtLUQomTJjg3qioj?=
 =?us-ascii?Q?xuKPxN4xpq43BUV7AtKz5JSQO5We8uu0CgeBN16fGQZTggfp0dsrWLsdG5Yk?=
 =?us-ascii?Q?wu9PlxiE7wLoVcvStmY2JS/2r4B6EuOukq7QCsZwAZ8G20cRjU/AsiiasO2l?=
 =?us-ascii?Q?E3h/R6gOa1aNMSAKtQuWUZobTdkfHPFeHXm8goVMhag5RwvrBAlZ8tjshiKe?=
 =?us-ascii?Q?YLtlNowyCTZlR1e+4daudzku4/9hUXIcrgUCSjGZ+YnYtP+jv1xgSfXhL8do?=
 =?us-ascii?Q?WOtprfDd+9zSGcGsLFMEHeqyeorlhEftk2xt+TUhYeQGZI4WDZsh3EwNtaYS?=
 =?us-ascii?Q?EnV5c7XSuI5XGoavQCSN0BlxZmMigTnQ72Y/oh3pdekQdh7GiHlXkZGUjzGX?=
 =?us-ascii?Q?PDtLk/j/0GCcjL1LAov7Zk42?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef67615-c6cf-4f26-ef75-08d8f5fb0806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:19.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOYlGmdhu6Z/ooFZnyRExT8Wh+OSrVbr9TZbOq/sDNXy3tSqocOsrmdkF/1FV8zD8MOXBNRrFPEzdhT6OxESGYJ9QP5epkVG9nhH4qGCmpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

With v5.10 being the newest baseline currently in use by linux-yocto and
with the download size being 1/2 the size of current linux-yocto itself,
the v5.10 makes a good initial line in the sand for blocking out the
source in a way to optimize sharing.

With this commit present, one can test via "bitbake -c fetch linux-5.10".

Pending recipes who will want this source present will add:
	do_fetch[depends] +=3D "linux-5.10:do_fetch"

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/fetch-linux.inc | 7 +++++++
 meta/recipes-kernel/linux/linux-5.10.bb   | 9 +++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 meta/recipes-kernel/linux/fetch-linux.inc
 create mode 100644 meta/recipes-kernel/linux/linux-5.10.bb

diff --git a/meta/recipes-kernel/linux/fetch-linux.inc b/meta/recipes-kerne=
l/linux/fetch-linux.inc
new file mode 100644
index 000000000000..e3fdd0bb36c2
--- /dev/null
+++ b/meta/recipes-kernel/linux/fetch-linux.inc
@@ -0,0 +1,7 @@
+# Boilerplate to fetch up to a single tag of mainline
+
+require recipes-kernel/linux/fetch-only.inc
+
+GITCLONEARGS =3D "--bare --single-branch --branch v${KTAG}"
+DL_NAME =3D ".torvalds.linux-${KTAG}"
+SRC_URI =3D "${KORG_URLBASE}/torvalds/linux;tag=3Dv${KTAG};nobranch=3D1;st=
atic=3D1;dlname=3D${DL_NAME}"
diff --git a/meta/recipes-kernel/linux/linux-5.10.bb b/meta/recipes-kernel/=
linux/linux-5.10.bb
new file mode 100644
index 000000000000..7f8a27bcb1f0
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-5.10.bb
@@ -0,0 +1,9 @@
+SUMMARY =3D "Linux kernel v5.10 source"
+DESCRIPTION =3D "Fetch source of the linux kernel up to the v5.10 tag"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+KTAG =3D "5.10"
+
+require recipes-kernel/linux/fetch-linux.inc
--=20
2.25.1

