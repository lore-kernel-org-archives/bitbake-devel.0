Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web10.19480.1617383784768231124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=nIwLB1AJ;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3KZfS9JIeIpPDrPKTHSnYsjQEOL+VF+NyBmU185Oz502X/igVJ0g55beCj6aavqm22JpziaB6bShq3qnhsRpAbKhhvF3l6I0cBl4whbjxjxLEArTa4DqKrq5yNpn5zndDiH/4/FAbVcuEeNfFClkAIJ06fCQ9sRMjTi+HT9ASLF92j7cghFS070cO9oKVQ7CkvZhqq4yfCMGcud+c3F84KV9YckybbzLmmcGsK2tpPkQbvvL3BNtcS2eI2paay8tiiNf2TroNmbQK3u/pipeGtEWs63Oq+yQRBzxafOF05tcPUgwusHwZ14ny4E8Fwhd2E1nSTGYaDp6ZBbB2N/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpScKDk6Iq/qbPiNKO+uRfz8hPcqhp9KEjPJ4QakMVA=;
 b=djQp2a3CBJs57Xztf2TjY2ylakcPXHsLqSvUfnmg8maw8uEN4jsef0LiCwG1bw51xnGGL1wzofUmC5aQETubAkEBGx3caDTUVkLWCmymKbhD+K/DQjc0LKomQpaGHI4tmaKPdH/AXihBm+LoSrXxSDj+0F+nMPWhTCh7ZT5+qKP+hnVEC4NTfLZLc2ChGLg3N8UPg6Lrf+spuEtNz9PXR4Oi3jLPv0CaDDEUEaF3wTfJNGU4eHQaaMWtQc19pph1XyzIzKYjlm4LhVo0BWUKey1M3L+2obXiNRJ0Dlj7DsxdBEMoBQr1CQeI6p57Oi4CfbahuGm4dqYsMA8bocLjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpScKDk6Iq/qbPiNKO+uRfz8hPcqhp9KEjPJ4QakMVA=;
 b=nIwLB1AJeS4OqKOgu9periiismAn29zVPs3aH25+uGchofD6kY7A8EVc+4VFoy4pwIhFj6ihZ8hygS3eaRAF35rLi/kn9EdKjZC6ohMYpIaWJAU9LWtnmMaqnY8LrJ7/Q4Q0Sz7dDyM7Lm0lMWY+g74/D43F046Jh56BE2ZTKHM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 17:16:23 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:22 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 16/21] kernel: add stable fetch recipes for v5.4.x, v5.10.x and v5.12.x
Date: Fri,  2 Apr 2021 13:15:52 -0400
Message-ID: <20210402171557.981599-17-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce3c9bb8-b50a-4330-e2df-08d8f5fb0a0e
X-MS-TrafficTypeDiagnostic: DM6PR11MB3532:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB3532C60A3AD0A93820BB63C4837A9@DM6PR11MB3532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hjdqTF3QRgyPwbpWjJixYwFL/k/pcBOsrJtc1GK/MZKe2Yg/17+Mn71LPcChLe9c8q2P8zw6zATCoARiyEpwtr0A9DTqX7E/AGeK8FrnFNRdVHqWaYk6TijBj75O+xSrC7s4jalZyWZjlIHQtbDHgwWPFfOvbZ9ir/WJjScxIjtk/w+ygid7P/Jm3SsyjoFyFcAb2kRkH2VxOGqXhPQa/jZLtRUJ+u8fwNz5cJgbp3Lnsh/gonoUX+AR6keOfewbNouxH0LHM2KO+2ZXamouhOgOERqzFlZfQfncKD5A6c3YydsdjpiunpfzA/QG/h22P7a4BKiaZOxBIZD/f7kBVdgJ0C4e9M1XEMT3aM1vF+PFRE4vnHCfBhIjuiIChEXUz1mmKvL4mUWpo36ewRGQojE+Jv+EKa1kUCYuUOMVi4kj0Y/9+0FQTE2y3ezJ0jDbUApxbrhAtB6Q1k/Vs5s0TuFphdQOuFmbTILHZ7MmkhCjMXiVerIM49okuj/mIjv+cbOOcEC3w00p9hfZsQDQvJiOvUdfV/SpBw2A0CTt+7wvmPAnQFPpVfAb6qFIuADqUkScUM7j2/MOxci5+gwaIwqJdFo8Pilp4DGoNtH0KLLrmOg5Xm7miyZpnJaYma2FifIXK5YkDQJdoDcX5rxxPQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(186003)(38100700001)(956004)(2616005)(6512007)(16526019)(66946007)(66476007)(66556008)(1076003)(316002)(8936002)(110136005)(478600001)(36756003)(5660300002)(44832011)(2906002)(52116002)(6486002)(26005)(8676002)(86362001)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?p2Q88niul9clEDyG4jISHdo09ZQudI80eg6ENzCihUK4IbhQvRO+a46lRFMF?=
 =?us-ascii?Q?LqEJebNKjBE3HP7b9cnJjBRVQR2/w4BrpvM259Xo/kfDPM/2IP+qEBeF98UD?=
 =?us-ascii?Q?hLJPK4mh5HsPniaqW+GGXme75oAtuObM8YPIRY6l/Z93Fixk6L9BrMQqQsMy?=
 =?us-ascii?Q?AoIDDgQdfyQoX19Ax7qAevL1lLAe+b+c+AMVC78XYCRPCpGvbO5i/52q8vJa?=
 =?us-ascii?Q?lCbYYrCV1R53bZrmqdejX4XPfa9h/i+UyBZ7G+HdrThlGRRlLt/fqIBy9DgN?=
 =?us-ascii?Q?GxAQrUTbSYGb3Mes+maGnjxolO/IGV8uhbhEcBS/97nBsBn0FWHVqox9OBEN?=
 =?us-ascii?Q?flYA/vU2FcWUGwnXBQ3iHmNQjOVN661nmYmb62xcoweoLAlhbQITm0rbo5Bz?=
 =?us-ascii?Q?PR3spqp3toXK61i3LUH62WqdMgXiZIgDhOTWIjgT1EZSq3bc3VK9UxJVXhip?=
 =?us-ascii?Q?TC8VYfV1PYPEhzm6ZpfD3K7cY9E7xKh8qpR1MfyyZ1U6MAxZEyfK8WUQEkOF?=
 =?us-ascii?Q?cjKJnO+AnHkb/gD2ENaofBy/w9chFTvXhgo7hQeFeO5YEnydTaM82Lk3lwQp?=
 =?us-ascii?Q?teL4TDkYtKbw0DIGa4HnhCSWhflXa69Ss9L883ISYOE4/eApXLuGSFxB/weK?=
 =?us-ascii?Q?KlXPun193CmYyh2Ow5/525ON1aepv5zGk9C0YmEwQZZklh22xfXYrkv28zWf?=
 =?us-ascii?Q?ZNaSaqWeAScyV0oZkkKo/287Cs4TBOGNjMQa0esm2w4Vx9zxUn1M+Vh9hRQO?=
 =?us-ascii?Q?mhsx/giDE+gPsRsPdN45YVJbTCtdv0EG7V2a79rVf1i/+ltZU7NqA3RXQjSH?=
 =?us-ascii?Q?3Ro1m7vE/XoHAbWHVbMk/3MGKMQA28uj5pB08xl8aKMrEu2f6OEMZO168Za1?=
 =?us-ascii?Q?8aljYWwQOCQ80Q3A0iem6HHeuF27U6xx7IMbpRWkrX64JjfadV2jv/Eh7F3N?=
 =?us-ascii?Q?v6s3Q3VV282a1RLw+uAkoFaj5kSPcuUk1QCESRh6k60ZUs6pFB4n8/Oxs3fV?=
 =?us-ascii?Q?XMoDFvq1L2LHYf7FWaGt1/CtWNJQPwqPtX4IRPDYMXX8hqQdlauqUgcqFDtr?=
 =?us-ascii?Q?dxq2hhmG+3XER3yn0MOVxmp+VWvfaYXVlYb/s2wRSoRKWa/qv3GEScVU1sfS?=
 =?us-ascii?Q?FN3Q4k7BQ/fuKgF2bkwl8OgAjFnrJ58hxcceaT5yo583IThs4qWjAXI8TRlc?=
 =?us-ascii?Q?hQbCFkiiPp5rp9AzzBAVrCut2lglotZvdCDnqLkUfseJxyQFkW4NeIX+pRkE?=
 =?us-ascii?Q?hc5ghSu0p8qb3pVwjO/8ljI5za1cmZL+4UoNtpcMf85oAnE7Ef9eQFUlPeoV?=
 =?us-ascii?Q?f/Bm90M5f/Y0qSmqF2OcXjv9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3c9bb8-b50a-4330-e2df-08d8f5fb0a0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:22.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yixj6EwNmkfZuc1CrqQywoZXcLN3agiI6JQmKY5LM4OJgkxb+KsE3D4vJQrcS8ziT5q5nymCEtMdr0y3qV5s8plNABuldjf6qEeTNSwZiOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3532
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

One might wonder why there isn't just a stable-5.x to encompass all of
these, but by having them separate, we can retire/EOL them individually
without disruption.

Note that references are a "round up" to the nearest kernel recipe
containing the stable baseline - so stable-5.4 references linux-5.10 as
we didn't specifically call out linux-5.4 as an independent recipe.

Also, stable-5.12 doesn't exist yet, but we know it will, so we insert
a placeholder in for it, so that v5.12-rt can reference it w/o future
change; we just switch the one line in stable-5.12 once it exists.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/fetch-stable.inc | 24 ++++++++++++++++++++++
 meta/recipes-kernel/linux/stable-5.10.bb   | 10 +++++++++
 meta/recipes-kernel/linux/stable-5.12.bb   | 16 +++++++++++++++
 meta/recipes-kernel/linux/stable-5.4.bb    | 11 ++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 meta/recipes-kernel/linux/fetch-stable.inc
 create mode 100644 meta/recipes-kernel/linux/stable-5.10.bb
 create mode 100644 meta/recipes-kernel/linux/stable-5.12.bb
 create mode 100644 meta/recipes-kernel/linux/stable-5.4.bb

diff --git a/meta/recipes-kernel/linux/fetch-stable.inc b/meta/recipes-kern=
el/linux/fetch-stable.inc
new file mode 100644
index 000000000000..051c35db8772
--- /dev/null
+++ b/meta/recipes-kernel/linux/fetch-stable.inc
@@ -0,0 +1,24 @@
+# Boilerplate to fetch a single branch of stable.
+# Reference is non-optional; there is no excuse to not use one.
+# Use a packref for a fixed tag reference; altref for master.
+
+require recipes-kernel/linux/fetch-only.inc
+
+python __anonymous () {
+    kref =3D d.getVar("KREF") or "master"
+    if kref =3D=3D "master":
+        d.setVar("RTYPE", "alt")
+    else:
+        d.setVar("RTYPE", "pack")
+    clonehost =3D d.getVar("KORG_SERVER")
+    d.setVar("KORG_REF", "%s.torvalds.linux-%s" % (clonehost, kref))
+    d.setVar("KORG_REFDEP", "linux-%s:do_fetch"% kref)
+}
+
+do_fetch[depends] +=3D "${KORG_REFDEP}"
+
+STABLE_REV ?=3D "${STABLE}"
+DL_NAME ?=3D ".stable.${STABLE}"
+GITCLONEARGS =3D "--bare --single-branch --branch ${STABLE}"
+GITFETCHREFS ?=3D "refs/heads/${STABLE}:refs/heads/${STABLE}"
+SRC_URI =3D "${KORG_URLBASE}/stable/linux-stable;rev=3D${STABLE_REV};nobra=
nch=3D1;dlname=3D${DL_NAME};${RTYPE}ref=3D${KORG_REF}"
diff --git a/meta/recipes-kernel/linux/stable-5.10.bb b/meta/recipes-kernel=
/linux/stable-5.10.bb
new file mode 100644
index 000000000000..4dd09fd212d1
--- /dev/null
+++ b/meta/recipes-kernel/linux/stable-5.10.bb
@@ -0,0 +1,10 @@
+SUMMARY =3D "Linux stable kernel v5.10.y source"
+DESCRIPTION =3D "Fetch source of the stable linux kernel up to the end of =
the v5.10.y series"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+STABLE =3D "linux-5.10.y"
+KREF =3D "5.10"
+
+require recipes-kernel/linux/fetch-stable.inc
diff --git a/meta/recipes-kernel/linux/stable-5.12.bb b/meta/recipes-kernel=
/linux/stable-5.12.bb
new file mode 100644
index 000000000000..18cb764dc3f3
--- /dev/null
+++ b/meta/recipes-kernel/linux/stable-5.12.bb
@@ -0,0 +1,16 @@
+SUMMARY =3D "Linux stable kernel v5.12.y source"
+DESCRIPTION =3D "Fetch source of the stable linux kernel up to the end of =
the v5.12.y series"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+# The stable branch "linux-5.12.y" wont exist until late April or early Ma=
y.
+# For now this will just create a linux-stable "empty" 5.12.x placeholder.
+#STABLE =3D "linux-5.12.y"
+STABLE =3D "master"
+DL_NAME =3D ".stable.linux-5.12.y"
+
+# mainline latest is the default stable reference if none is specified.
+# KREF =3D "master"
+
+require recipes-kernel/linux/fetch-stable.inc
diff --git a/meta/recipes-kernel/linux/stable-5.4.bb b/meta/recipes-kernel/=
linux/stable-5.4.bb
new file mode 100644
index 000000000000..98842bacc1ab
--- /dev/null
+++ b/meta/recipes-kernel/linux/stable-5.4.bb
@@ -0,0 +1,11 @@
+SUMMARY =3D "Linux stable kernel v5.4.y source"
+DESCRIPTION =3D "Fetch source of the stable linux kernel up to the end of =
the v5.4.y series"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+STABLE =3D "linux-5.4.y"
+# For reference, round up to the nearest tag with a recipe
+KREF =3D "5.10"
+
+require recipes-kernel/linux/fetch-stable.inc
--=20
2.25.1

