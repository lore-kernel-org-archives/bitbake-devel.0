Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web10.19480.1617383784768231124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=IWuypmgH;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFkdVnZmOrTMDVdSqU5I182pPM11A03avXWoxQ04Oq2TQ/u6OlWMVX8Pkl0jlV1O0Q7wMce0LJbYm3mE5IzAzDOeUsbwUbk4SSLGeOCOJ1BWGTeUrm7UzuGg9fmlJE9X9p8nIpWrclrUog/YOtVU4c2JFZ3WTsp2Dty2/0YQEVwuP5RjR8ZhVuvLoyZC0+J8G6BKBVbBk8GXfiNuEGv5OE1W5o4Jojs4Qhcqi8KWwoIyJ9kjzHj1LmAwLHgBvn4vHkmphcRIrWxs0Ba570W955d3eYg4QXyNmDlwS4wDjkZ//JAQAnVMp/zGzYTPMzc6a5p7N/6GJ7m1ihDPh0yr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtFsJXHL0q0j7buk5lZYl/ITXb7gY9UI1ypGZXeHQyY=;
 b=a8Ndj/tOjt1djVa7TV6g7ByOhRRYIS2/geVXvQdVq66SLIvQ5BGvrXmIqZyLFfZd2Tnl/unBfm94628IlIC4AE/9FNzFZQE30gXCLnBoGL/MQLwsk2dMzenPQuPqIe7oO81nBSMUJR4fM4rtvISgGXmdE9eqD/kqxxeWDJb1/fq/JVUjV3KKgKNg5vctHAbFRKXqjqIuaLetfqhE64d36P4CXUaOyzyI66dVmc3njW4qny14uMwTPMJYLwcwG1fRekuG6CbgPUA1YobVpHb/JU195wbjDJtGWvz2Vyi7d71pGEI+C8L5TyVIKuuyD2CEAYlYdmbQ5cMHIEI9c4Hndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtFsJXHL0q0j7buk5lZYl/ITXb7gY9UI1ypGZXeHQyY=;
 b=IWuypmgHMDk5aBgnAD2fBebGgS9C2L4BcogYhOoSN8Fs0z0wHU8IZPOmQe+TkZFnybRNKECYOU1u/DA7FLDX6DXqOi+EdLAWbYWdhUC6W0/8ocE3li/HV+jfALmCvPCsTqkLiDbNxoEeNvF4f3gtC76t6Ta1hVl5rZpVYnzYfko=
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
 17:16:23 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 17/21] kernel: add preempt-rt fetch recipes for v5.4.x, v5.10.x and 5.12.x
Date: Fri,  2 Apr 2021 13:15:53 -0400
Message-ID: <20210402171557.981599-18-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 200f99a7-74b8-414b-e690-08d8f5fb0a6e
X-MS-TrafficTypeDiagnostic: DM6PR11MB3532:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB3532B7AC4681497E136AFC5D837A9@DM6PR11MB3532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IpxsY5s6zz+n+5a6Pef9v+8OYsVG9zdNLS42Thun5jQcuh680YzoLrxqTc5OOCZxaZsaC3RxB+s0E4x7Ji+o8wxqWDd1M0t/Ab+huxD0MJixEGf1r0/1WxOPBqVR6xhmwjA2btV7Upz3SPmd4dIYdTe+HCulu0BrqrxbJgt48btbecoNWkz4r6rrDaMfrTE9/9gjJdjEH7x934QdslM1x9ge5bc/PyRtikZe9NJNthNOTCxb+PlG+1YG3nDapkGp6FwBkry/alqFsuTCuhnC4oihjPOlvgQgSLJvSwRjtLdvmMCJeeETnwkWKa7VIGHutqhDzKGwl5PN6AOcgYP9xoBAMserkMriB47q7JbTSPyC6H851fqvM+V74tGs1zQotIYJ9eAKDaelDcLotpU2j6xQGuk7Rb5pfvFKKvw9GHJXowCfLSLKCd9bIRL2/VV9xH1rq7f64GIIy9kSfUOjjMNTkIgcX3/yp566j+6qPp5RnVTqTvkvPrGbpoHUcFxGXT5rQYsspcxBQ1L0ca1hdbr+BtZoN52zphKWISJdezHpXQ0QjbmIjqBQRoInWtn/a99yuucLie0BSxYnlUHzwty5l+IxghYnDyFIPkOJtga3KcBYmKl4virngfp+HJEQZQfHIozvFZgrHlj9tJm1Lg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(186003)(38100700001)(956004)(2616005)(6512007)(16526019)(66946007)(66476007)(66556008)(1076003)(316002)(8936002)(110136005)(478600001)(36756003)(83380400001)(5660300002)(44832011)(2906002)(52116002)(6486002)(26005)(8676002)(86362001)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?f1LrxPaYrYw3eidztDDOKpBiKUThOMk2qXv+iDBYa1+HTsAfqw72wbOykDu/?=
 =?us-ascii?Q?F09FZmEur3megR0cnnoL45gzN8pp3Ml6EmFIfRi8dX3X4x95JUHUNF1fssHJ?=
 =?us-ascii?Q?O/4kPGMvMVVTa2tOdLwGE18MIwskLAqmh2VYOYeYYqEKexvm8a8j8SYR3hHR?=
 =?us-ascii?Q?UbMvz5b8k4jkmch901k2IiRXGGh2CBQdYFMfSlLwmbjAprpMhR8Vo2P3m/wA?=
 =?us-ascii?Q?oQ1qn28rr3h32zbqaa0NwT9SvgTGhkc0h9OrPqW1HS4kbtNEZEorxutlwsHl?=
 =?us-ascii?Q?pf1mHtyCLs6Dmk6cevtNBz1nc7c8KaQnOCiaviZZk4rcQG9CbbOyRoYligaL?=
 =?us-ascii?Q?ruVgtzx3H47mjzteSYpwdQzYGkotV8WMjTRkAmgS2r0V7oqHhGsZky0wucx2?=
 =?us-ascii?Q?C4VMlTbDQpuqH/TgUAcS7h1VstCkG/pq1bGmOZ+g/HwH6gzWi9VKToCm+LkY?=
 =?us-ascii?Q?UHW/bnAJLv2AxeNFb/7nF/xlMPr0MqA6DBmW601wNDwBIgKxCEbfeD1I0GFg?=
 =?us-ascii?Q?khK/kwOL4dReq2TkTsXAXxK4dFJ2smJb0Wnsr6O9Vs/URVyYKMazW2teLYvu?=
 =?us-ascii?Q?zMygfHC6WD7lZAB/2WIWS6H7XB0ZsmTZS1sF16VVDiPWf5AgH34wHqUAk75E?=
 =?us-ascii?Q?Z9U5u/cALfktJGMmsEZQMcALsSnIq9aTQGl2VetSZohZdFLLjQy9rrhFLiEE?=
 =?us-ascii?Q?99sSL6TmGS6QZdWRviG4MwuD7jTw4RaGtAl/OcJZuj2BQOh8ldKg/nrCYR25?=
 =?us-ascii?Q?5odgQebamh8WaNZuzR9coi+AIN1saY4IT4nKAyF8MplhivUlgkS3z51pyAQr?=
 =?us-ascii?Q?HNj+j29AI6Vzeg2f33KXOsxwRYz5wz/LI9PZWjrcsN8fu4UYUliMMJGslTQu?=
 =?us-ascii?Q?HKu5cYeQ5/ppIrVPbLqx5jUqzKSTafDUM9X4uOn5d7fkv0vLIZhrNu7p61+o?=
 =?us-ascii?Q?5UuGoTPO0S30LCVF4sARUuRziI86X8hi8IjU3dBTO3J9iHu6i50q+1/xlpqr?=
 =?us-ascii?Q?e7pOk+cmcDoO1mmHZqXARdhrFLPrmL483AE0YRILBM8Bo5urBvcXPJvjY0Li?=
 =?us-ascii?Q?WybZTecCCyt/AdmZMxARMnQgWVnF7mNAbgZ1bhBRCTT6pYxboy2xRuvUkR64?=
 =?us-ascii?Q?ZIMgFCXknzxZvfQxB6P1G0uHBmo5h+DGCCUXU5LD9ibZkfT3sxu7hPUUCFxp?=
 =?us-ascii?Q?crRcGosccomKkIKrEKp3RG7scc9knd0l1A2I1uIfvTe4+8HUWPrtGw4CuoQW?=
 =?us-ascii?Q?ixCbXl7XgVO8QQ/ukEe17EmnfwSmzlWAlE87Re4d1TzerB5y3iCgqTrOHuu0?=
 =?us-ascii?Q?xvxqKyFvKbOOsXMQimUt4/dT?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200f99a7-74b8-414b-e690-08d8f5fb0a6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:23.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiJUQpdliTZEr7LZYrxkLeBIVy4lVbAtNfZoCAOhFL+z6nPSJvg2yoDuFYWXXldfghe2m835oNkohRZUkjOt0KjoaEKUzu1LXsTnwS7K89I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3532
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Note that the v5.12 content currently is in the devel repo and will
eventually get moved over to the stable-rt repo.  When that move
happens, we'll need to update the SRC_URI accordingly.  [The v5.12-rt
content itself will remain fast-forward with respect to that which is
in devel currently.]

Also, since each reference their respective stable baseline repos,
which are still in maintenance and not static content, we use alternate
reference instead of pack reference back to stable.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/fetch-rt.inc     | 25 ++++++++++++++++++++++
 meta/recipes-kernel/linux/linux-rt-5.10.bb |  9 ++++++++
 meta/recipes-kernel/linux/linux-rt-5.12.bb | 12 +++++++++++
 meta/recipes-kernel/linux/linux-rt-5.4.bb  |  9 ++++++++
 4 files changed, 55 insertions(+)
 create mode 100644 meta/recipes-kernel/linux/fetch-rt.inc
 create mode 100644 meta/recipes-kernel/linux/linux-rt-5.10.bb
 create mode 100644 meta/recipes-kernel/linux/linux-rt-5.12.bb
 create mode 100644 meta/recipes-kernel/linux/linux-rt-5.4.bb

diff --git a/meta/recipes-kernel/linux/fetch-rt.inc b/meta/recipes-kernel/l=
inux/fetch-rt.inc
new file mode 100644
index 000000000000..18dbf0628640
--- /dev/null
+++ b/meta/recipes-kernel/linux/fetch-rt.inc
@@ -0,0 +1,25 @@
+# Boilerplate to fetch a single branch of preempt-rt
+# There are two different repos, and two branching name patterns.
+
+require recipes-kernel/linux/fetch-only.inc
+
+python __anonymous () {
+    rt =3D d.getVar("RT")
+    rt_repo =3D d.getVar("RT_REPO")
+    if rt_repo.endswith("devel"):
+        d.setVar("RT_BRANCH", "linux-%s.y-rt" % rt)
+    else:
+        d.setVar("RT_BRANCH", "v%s-rt" % rt)
+    clonehost =3D d.getVar("KORG_SERVER")
+    d.setVar("KORG_REF", "%s.stable.linux-%s.y" % (clonehost, rt))
+    d.setVar("KORG_REFDEP", "stable-%s:do_fetch" % rt)
+}
+
+do_fetch[depends] +=3D "${KORG_REFDEP}"
+
+RT_REV ?=3D "${RT_BRANCH}"
+RT_REPO ?=3D "linux-stable-rt"
+GITCLONEARGS =3D "--bare --single-branch --branch ${RT_BRANCH}"
+GITFETCHREFS ?=3D "refs/heads/${RT_BRANCH}:refs/heads/${RT_BRANCH}"
+DL_NAME =3D ".preempt-rt.linux-${RT}.y"
+SRC_URI =3D "${KORG_URLBASE}/rt/${RT_REPO};rev=3D${RT_REV};nobranch=3D1;dl=
name=3D${DL_NAME};altref=3D${KORG_REF}"
diff --git a/meta/recipes-kernel/linux/linux-rt-5.10.bb b/meta/recipes-kern=
el/linux/linux-rt-5.10.bb
new file mode 100644
index 000000000000..04520101a443
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-rt-5.10.bb
@@ -0,0 +1,9 @@
+SUMMARY =3D "Linux preempt-rt v5.10.y kernel source"
+DESCRIPTION =3D "Fetch source of the preempt-rt linux kernel up to the end=
 of the v5.10.y series"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+RT =3D "5.10"
+
+require recipes-kernel/linux/fetch-rt.inc
diff --git a/meta/recipes-kernel/linux/linux-rt-5.12.bb b/meta/recipes-kern=
el/linux/linux-rt-5.12.bb
new file mode 100644
index 000000000000..88f2daf92032
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-rt-5.12.bb
@@ -0,0 +1,12 @@
+SUMMARY =3D "Linux preempt-rt v5.12.y kernel source"
+DESCRIPTION =3D "Fetch source of the preempt-rt linux kernel up to the end=
 of the v5.12.y series"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+RT =3D "5.12"
+
+# Note: v5.12 RT will move to linux-stable-rt repo sometime
+RT_REPO =3D "linux-rt-devel"
+
+require recipes-kernel/linux/fetch-rt.inc
diff --git a/meta/recipes-kernel/linux/linux-rt-5.4.bb b/meta/recipes-kerne=
l/linux/linux-rt-5.4.bb
new file mode 100644
index 000000000000..3d70be5aaa9b
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-rt-5.4.bb
@@ -0,0 +1,9 @@
+SUMMARY =3D "Linux preempt-rt v5.4.y kernel source"
+DESCRIPTION =3D "Fetch source of the preempt-rt linux kernel up to the end=
 of the v5.4.y series"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+RT =3D "5.4"
+
+require recipes-kernel/linux/fetch-rt.inc
--=20
2.25.1

