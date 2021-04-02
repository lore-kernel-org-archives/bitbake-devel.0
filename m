Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web10.19480.1617383784768231124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=C+ydPcD0;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+qTETy7PYdKSEn0Qt+a2huTz2bkACcdg0WucGMYUQdPoA4qnEJDMI4+tueXSlBgGAcOd/WDaJ+LIFBNv9PmtkabZfBE72lskiiejegBfu0R4u9JnP48IuO7vMikPPEg/p4xRLPt1IXZ5qEys1o4SevZlzSqzK0IQx2RjFGccAp+5wAC92TsuQcWPU70Dy2qaUqCxEOjbIoQsX2loJ9rLFp+d8atU9VJejnqTT7L7NQQY4x5SaPHLXNWO0pDnMB7HHDB1LaM4DOVEGf+GKTuuKV2O0QbKeXHHohL8y0aktb+crvfX1/EJxzVqZLc8j/Xmud0A+gfoL7mDeru/QkFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYwTRQJo6MiTm0B5sERtIR3OrdcHAQzSQQkcSdI3GeI=;
 b=PXy22xS8+i3AVqXLZUk+NNoUBv6YT/0j0AzyVQHbc8ezPIgdjQ2D+wSOjGXfDrD6kuV4AzC3ayLlQMOe5sEQcDYD8K+HNJr7nsUsvaLsVGMDRkvMw0TxwDvABl/CnUlUmQZBEK5gB8T0+iHbAuWGGr3yPUXvqI74ItpsJpPCc+zLhyA+TujCZqC2RSt1cTzm9SDPPaVsl6hhkXSn+gJtfbLG9cHnaWp/BZjPojMwHtkg133c1zN5zO4hYNNbC4L8aeTcuH2wXMIvrYyuV7z2kIizpY8NFpCLcZZ2FRORTJYDsYl26wROB/hP2zFXcnEuZAa039kQXqQpyZudUc1VvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYwTRQJo6MiTm0B5sERtIR3OrdcHAQzSQQkcSdI3GeI=;
 b=C+ydPcD0/0TuCs86Q2nzJ/tCAOGJx7V1q3qw2lwFNLl9I2y5rEdWX35cD1jkEPdSqyXDhMR9+nPcq3L4NEcQyVGzATIzZt4AiYjKI5FhJwTz9r5fOhHiCypbeZfwKtf5iSP9qdFa/+OECIsw/plXA4HDnn8zkp70sW1he0AM1rk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 17:16:24 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:24 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 18/21] kernel: make v5.4.x Yocto recipes use shared source
Date: Fri,  2 Apr 2021 13:15:54 -0400
Message-ID: <20210402171557.981599-19-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8252380c-015a-4337-faac-08d8f5fb0b2a
X-MS-TrafficTypeDiagnostic: DM6PR11MB3532:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB35327F102A959B47D724E354837A9@DM6PR11MB3532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0YoOa4+4tO8xj4yLmvATaBZxfdS9kKHB470qSB4lfnbt3LQt+FN9ud7bgLnAIe0pCqq8XUXLPVSDxtDPm7zdc0vsbjkVSxxhctmhWKtGIrvKLqzyKn1b0xCECqfj9VSYUEz95eVgYSBVG54YXVfaKdQH5h3iC3TtkxC4NyKSwVhDXwNUKZGK1oP43JrMS9xe6JlbD9UEGHsGHS8NjSoixCicCl2R2GiNQTnG/n/8Bpw7p4eBqeWs/tJdWNQiLWeDZyCtqLPjAPCPSjlwYc93zctQhep9HV7G3Lk634JVCsQYYSssH6XdHz9up0iSv2HyITcugR4L1a8R6cpxUu2/QTGg5dfMMLl4ojhy30w99gsi7hdEGsxcSsUtWif/Q/wLeivXM2Mn4gE60TM/iVUXhMwVFDVdseRkZ1YzXqksK1xsgKWJI5nHBD7kE7hwzVwNUwx4qYxgPPdO7Wmpisd06SGwvOjUw1g7pXGqyoGX/3JQoPITJKI9PijLmO7PWe6umnZV2OxcJLo0jZcDqeoVJhx9FQJCe3m8B1kfOtnq6lvBSDE0joYf1bTLv+7OtAfkLfFpIQXXXJ7b+8vl11obrISyqRR8ISVW9Cn6+wDbXQUNggwiAQVogNiQFakFuOMc97nJyQImepUn1mVj/kVKkw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(186003)(38100700001)(956004)(2616005)(6512007)(16526019)(66946007)(66476007)(66556008)(1076003)(316002)(8936002)(110136005)(478600001)(36756003)(83380400001)(5660300002)(44832011)(2906002)(52116002)(6486002)(26005)(8676002)(86362001)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?+bubvBcrhyXmfL2w71JB8CVzxQh2/yWrQbqNf0Ecq1tcs20pXmpgTuFy3NHE?=
 =?us-ascii?Q?Eyjobsayjz3bhgaRflMOUj9vNlXAw0vM0rSi/WT2FELMOE+/cEmaJE3WnFfM?=
 =?us-ascii?Q?ncc1v6NOln8uNs9G8L1XXccjUgoaSeViU5/b7sBa+03Dzvr1wTITe/4jSJ4P?=
 =?us-ascii?Q?M8S8WkJdqdqRYVxtB/W4jzVEH858+tM87d5cRfcbjS5HhlEqXe3z8S99KCdF?=
 =?us-ascii?Q?NeuF3IQz4+TTzwDJoZIMiCFs7P1o1NKcK6siizQ5O+gzrwqi+QHF8HSjEySh?=
 =?us-ascii?Q?1puWuldmzBB2h/vvtN0Se5ZAmA/QDxVCOlhFLi0VK47EllQF/80psjv+RO95?=
 =?us-ascii?Q?cFDt+TpG5TOF/NDW1Xz6nAUItqTj0RAicD9GXw0zsaSt5p2c3bk8IY8iomG6?=
 =?us-ascii?Q?r/OeYPpxcvoaAQC7qS3pUbqgLGQQKM+cXVhZluy9pV8/3gXKlgAjMXjR43xB?=
 =?us-ascii?Q?xJeBpD+fSAhz91n+Iwq+8J0c8n7JGe9hn3PCsotES1JlnDk7qRswZzw99XBx?=
 =?us-ascii?Q?NspGgiiLlfqWQX2hwjDdnklubHzYNj0M/eBCEKzpsoaYOqjB5SDHu4Xa+fcV?=
 =?us-ascii?Q?n/9zQ0vyshx7e3eDawL1GUTbSbkIhnc+2znLjPpwDJMLH7Id3xasoauwvZxW?=
 =?us-ascii?Q?cY2qEzu6RrdL9i1TPKfZja8v737n2ilAkMmT8YwZkMrJNxnrJP9lj1mpeWvq?=
 =?us-ascii?Q?HhddPxHEZbq0CATJQF2WMPrLCh+eKg65e40o6oAL6jdFv4bJIWeyK3jEO+mz?=
 =?us-ascii?Q?eixZBEHfoX1/puRs26tSW/VfNBgzd+MTs+O3WZ98w0bqNB61PC5XpCgVtS2m?=
 =?us-ascii?Q?mPodb2JhJbq927hVre5HyBnuAnEYFCKDI+Cs925DSPAOkHSHFd/Z5S975Cw9?=
 =?us-ascii?Q?8y8eXf7DeDaQq2IYHUVKqEa2tak+0+MDpXHCNdyTXLmXnulGxwmDYUbvb97y?=
 =?us-ascii?Q?O9EqO7GbnJcxdwvohyhlxF0hqGt9JiXQNDOqTxeuXZZ0Ln1wFClTfFpYsUIq?=
 =?us-ascii?Q?z8v6DdwhYnn0V2RvFviGlwWCEWrGIadO65MI4IwEPlg/UVPdwBYr+j7sszTL?=
 =?us-ascii?Q?aGxsbciW+cHNnVobUHnvYV7B8pyiihbVRXBo7dQlPSKLE15rSQooMO/75E3J?=
 =?us-ascii?Q?D+PrJj9psS6fglyYhDGlTuCNpEUICR8k/aFdOl7uLztCvTN0I26hUATTXyAh?=
 =?us-ascii?Q?sKHniWYFXBzZS8eZqf8Tw8w5mcSp8fd91ks9ZPwdGeZzDaQrYTRXgjX7KVad?=
 =?us-ascii?Q?Zs2ni4ZBWlkN1zn06SOpSX9DV5iOsmYdzEsaHwFB5bT9gYNT3czSbJTCUMjm?=
 =?us-ascii?Q?BKUWL5mN+Z611AD7z8bsjWMW?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8252380c-015a-4337-faac-08d8f5fb0b2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:24.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FFP/12o1JJd0yyvK0sbwtHu9cvMGWKfKDyCp8zMvIFXKQ3jXUWspdbHhNHQzrcDuTc1fiO1RSJNcDu9d8/+O8LcVcAZxM8qizqK6bXmgzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3532
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

With all the heavy lifting done, all that is needed is to select the
right endpoint for our reference, and the right fetch wildcards to
ensure we only get what we need. We've got:

	linux-5.10 (superset contining v5.4)
	   --> stable-5.4
	      --> linux-5.4-rt
		--> linux-yocto_5.4 (and rt/tiny variants)

and hence the preempt-rt is the endpoint for the reference.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/linux-yocto-rt_5.4.bb   | 7 ++++++-
 meta/recipes-kernel/linux/linux-yocto-tiny_5.4.bb | 7 ++++++-
 meta/recipes-kernel/linux/linux-yocto_5.4.bb      | 7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/meta/recipes-kernel/linux/linux-yocto-rt_5.4.bb b/meta/recipes=
-kernel/linux/linux-yocto-rt_5.4.bb
index 2ffc8ed5428b..373da8501f6b 100644
--- a/meta/recipes-kernel/linux/linux-yocto-rt_5.4.bb
+++ b/meta/recipes-kernel/linux/linux-yocto-rt_5.4.bb
@@ -14,7 +14,11 @@ python () {
 SRCREV_machine ?=3D "65bbe689d98a007848008be2c8edeb5fa8066829"
 SRCREV_meta ?=3D "19738ca97b999a3b150e2d34232bb44b6537348f"
=20
-SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;branch=3D${KBRANCH=
};name=3Dmachine \
+KREF =3D "git.kernel.org.preempt-rt.linux-5.4.y"
+GITFETCHREFS_machine +=3D " refs/heads/v5.4/*:refs/heads/v5.4/*"
+GITCLONEARGS_machine =3D "--bare --single-branch --branch v5.4/base"
+
+SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH};altref=3D${KREF} \
            git://git.yoctoproject.org/yocto-kernel-cache;type=3Dkmeta;name=
=3Dmeta;branch=3Dyocto-5.4;destsuffix=3D${KMETA}"
=20
 LINUX_VERSION ?=3D "5.4.107"
@@ -23,6 +27,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dbbea815ee2795b=
2f4230826c0c6b8814"
=20
 DEPENDS +=3D "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d=
)}"
 DEPENDS +=3D "openssl-native util-linux-native"
+do_fetch[depends] +=3D "linux-rt-5.4:do_fetch"
=20
 PV =3D "${LINUX_VERSION}+git${SRCPV}"
=20
diff --git a/meta/recipes-kernel/linux/linux-yocto-tiny_5.4.bb b/meta/recip=
es-kernel/linux/linux-yocto-tiny_5.4.bb
index 2b6e35a69c10..40327039368f 100644
--- a/meta/recipes-kernel/linux/linux-yocto-tiny_5.4.bb
+++ b/meta/recipes-kernel/linux/linux-yocto-tiny_5.4.bb
@@ -11,6 +11,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dbbea815ee2795b=
2f4230826c0c6b8814"
=20
 DEPENDS +=3D "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d=
)}"
 DEPENDS +=3D "openssl-native util-linux-native"
+do_fetch[depends] +=3D "linux-rt-5.4:do_fetch"
=20
 KMETA =3D "kernel-meta"
 KCONF_BSP_AUDIT_LEVEL =3D "2"
@@ -21,7 +22,11 @@ SRCREV_meta ?=3D "19738ca97b999a3b150e2d34232bb44b653734=
8f"
=20
 PV =3D "${LINUX_VERSION}+git${SRCPV}"
=20
-SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;branch=3D${KBRANCH=
};name=3Dmachine \
+KREF =3D "git.kernel.org.preempt-rt.linux-5.4.y"
+GITFETCHREFS_machine +=3D " refs/heads/v5.4/*:refs/heads/v5.4/*"
+GITCLONEARGS_machine =3D "--bare --single-branch --branch v5.4/base"
+
+SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH};altref=3D${KREF} \
            git://git.yoctoproject.org/yocto-kernel-cache;type=3Dkmeta;name=
=3Dmeta;branch=3Dyocto-5.4;destsuffix=3D${KMETA}"
=20
 COMPATIBLE_MACHINE =3D "qemux86|qemux86-64|qemuarm|qemuarmv5"
diff --git a/meta/recipes-kernel/linux/linux-yocto_5.4.bb b/meta/recipes-ke=
rnel/linux/linux-yocto_5.4.bb
index 245c3d574b44..938f3bc9e595 100644
--- a/meta/recipes-kernel/linux/linux-yocto_5.4.bb
+++ b/meta/recipes-kernel/linux/linux-yocto_5.4.bb
@@ -26,7 +26,11 @@ SRCREV_meta ?=3D "19738ca97b999a3b150e2d34232bb44b653734=
8f"
 # remap qemuarm to qemuarma15 for the 5.4 kernel
 # KMACHINE_qemuarm ?=3D "qemuarma15"
=20
-SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH}; \
+KREF =3D "git.kernel.org.preempt-rt.linux-5.4.y"
+GITFETCHREFS_machine +=3D " refs/heads/v5.4/*:refs/heads/v5.4/*"
+GITCLONEARGS_machine =3D "--bare --single-branch --branch v5.4/base"
+
+SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH};altref=3D${KREF}; \
            git://git.yoctoproject.org/yocto-kernel-cache;type=3Dkmeta;name=
=3Dmeta;branch=3Dyocto-5.4;destsuffix=3D${KMETA}"
=20
 LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dbbea815ee2795b2f4230826c0c6b881=
4"
@@ -34,6 +38,7 @@ LINUX_VERSION ?=3D "5.4.107"
=20
 DEPENDS +=3D "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d=
)}"
 DEPENDS +=3D "openssl-native util-linux-native"
+do_fetch[depends] +=3D "linux-rt-5.4:do_fetch"
=20
 PV =3D "${LINUX_VERSION}+git${SRCPV}"
=20
--=20
2.25.1

