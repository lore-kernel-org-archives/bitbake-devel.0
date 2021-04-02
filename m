Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.45])
 by mx.groups.io with SMTP id smtpd.web08.19604.1617383786731332484
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=OU7IcoPX;
 spf=pass (domain: windriver.com, ip: 40.107.76.45, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9O0RPBXYCDTt06KLmuVJawQZIPplG3+xsVYO2qRg4k37nKU5xjJuhvHHPmr629b+tomVaR8WRztJmdUYSZJd8QVL9a4YfIg56Ermq6ytYXN0ZiUpMHkj+VY/0+ZQ6dUpAmYRc3YIfAlAkJbMYVrbRD2NoWoTrkH7ZXNjnIV44Xb4UVLgckb0GBgWBztdzRpugtHKhYZy6GmtJbeSOEF1eSP0WQGDOjdiWDnFGlsfXdVOzaBsoPCZnJp3gzYcIgfZlPwfoEVqit4ujoEYV0eIlCvKI7DClzT5LX2FfdktgmBZE6LlqyI+RECZb+Q5mG743WGDJEMcyVAorRR4xr11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8smSpWWeekjV+WU1UdbG5QgM6wvA5kbXSdKhJqa4Zx4=;
 b=V7ca/py836OhwvnU/96KxetuZxcjYnS7xnSCOJH7MZlPkVayYPsUVI8Q/azCrD4AKFd7vBwI75ekuXnFaAgzyDZDIB7RW2PwwcnKPl1jCh5wSYTK0ABZuLNqXId2t5x1EI844g1kq6+UsV3qoX6VI5od4PL/XBiFVY8mU/JEBkDUoteW4+4w3z+QLD4rIdQuXhuxCg4Sx7SWh/fIuNX8rlWtVUE0wu9sjqtlDj+81Nno1/KTDt+BLgp2wj8Tlbsac8+UVeWi7aCbrgOqcET1zWi68+HNnxfNY90Oim+H8bHMROb/aoY4JsM8V/G01ePFBqR68vRE6Q60hN6NrxyBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8smSpWWeekjV+WU1UdbG5QgM6wvA5kbXSdKhJqa4Zx4=;
 b=OU7IcoPX+sGc8G6CSzUJGSPVThIwCOx0/XlyUoN1toTfUYK0FBQ1S3l0p90Iq1UvB1S/pbplFuSTaZtLxHoO/MmlaQmT81+Dtf8fqLvTo/uhYmDcqfh8aK1W4Dd6tF708U7fEd/vuq4cl5uApD7Vu+EOwtJHIWVU82CEDpJbpXU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:20 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:20 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 13/21] kernel: allow splitting mainline v5.10 source download in three
Date: Fri,  2 Apr 2021 13:15:49 -0400
Message-ID: <20210402171557.981599-14-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 188fed14-ffa7-4d8d-3455-08d8f5fb08c6
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249C4B4B6CFE8CA9CB21884837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8na1XOxslgex4AVeOMPTZyFd4UT4AGLV6nM8rZ74szcOdvvadfyfYdU+G7O/ZD1Za+n0PsGfjFF071bYigQ0GubgU1kzYX0tq18JM3b64tNsdivWqfjpUvypt3v3nTKpeS+zMDomPR3E/rrJ/nPRSmX5lC+8IHbOX8+YajxxpsytvlwbgpG4WIPBZsuywHjgLtP3j8I9seWowTwMx5nnzOgE/WuQ2bW36XZav51W+o3+cAEsCsjRiZa3q50vZKKwvGtmBx6wo7km34Xglcn4fKPVZ8itxqs4nkQBvbz/8oAi5v+Y5JM8l1RRf3U0uCMdgDl80Uarv5PXkfjYKzko0yo8LJuAjvFexVvE72mBzFiGE8ZcIZMcftM43Ku60VGePx5CU4AmVFOxEW6rTy0VfKURlvOK2tue7fBBq6EwgQjD3f9doSgaq1vA3b5kUnkKH6HkVHRlNQheAmrnpDrrbk4M+4JFJMKur7reyRyf9iLquvtARVXqnOQrMwPuGQB4OfRh3Be5eh1h2MIBpttMQD3y4JIlMyw6xHVQtK72lB7TfDgcXK+ENDGlB/P49lSIBjNvMQiorE4ZwiCK2PQTIDzpmtrQCxgbSSuPH14Lewhdahr8jr9iNCuhXFLN8NQzZlxwBHOWNkF1P3mZT9j1aA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(5660300002)(83380400001)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6666004)(8936002)(36756003)(52116002)(1076003)(956004)(86362001)(2616005)(66946007)(38100700001)(8676002)(316002)(110136005)(6486002)(4326008)(16526019)(186003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?ZY8tpfjrZd4J0kcLuvyjLPnZZ31sucKGI+ecPtiQxcjC6f2kjxwMK5g+wBuw?=
 =?us-ascii?Q?mIzSrl0sy5qe4fEgpFoLRz+pJc2Bt65lDBOfTT2liDXFFTvwX/r7vLUdQl8p?=
 =?us-ascii?Q?HhzkuaJlfO7qdE0QgdsZU+yH5Gv2DYz+uqnTFtvRReN4zO/LgiRyiVPlJGnr?=
 =?us-ascii?Q?kp9BwsVDxbrTN+eyLfA/a9pU0UiSvPvHHfBHZ4QybHWBkz9Frm3w6WeK9MmE?=
 =?us-ascii?Q?hRMxeb5zRnCmtILmjZjoeuZK7fthFZ/RhUJw87rEZIjclL58YASAp7lGyswV?=
 =?us-ascii?Q?Urhscutxtnss9craQFSwwp/ctDlf3EaVpUYeLFqoX+jjKDf8lT5EhmYw3RCs?=
 =?us-ascii?Q?hE8qiyOSH+PbrPc8uWG7oECpDXnZc5TqlZo5wJX0aHesQZ2kj7WtT4cw29gb?=
 =?us-ascii?Q?SKDPIBN91uy3zUxk7BflPptMLtepm1jPi5pqOxm1iIImTYsdHjS4I/6ZmCFD?=
 =?us-ascii?Q?kpn8oraRRCqXyJoToL98oR4bxWQw91Hg/ERCrv+bqJO03IIo4cP8XQm6RCa8?=
 =?us-ascii?Q?YEWqcS0u9pEimBkBkCR+HXp89jUcylkLq/3NM6ykMbDnrCwEwIN0sb2Uq/SD?=
 =?us-ascii?Q?g46le79Z5ktExQjy+FXje+MUp0i21Fq2OfCTEB4h8mOoUOVTmqba+Yh59EZT?=
 =?us-ascii?Q?imAXNaChBL3honAjYYwde5SnbADcaZtf4b49B3LsTtwf0p0An8ojGtisRvhz?=
 =?us-ascii?Q?zSdqUjkyrfdpMvUNjvnErznLvyAAgdl4CfF3uo/5SFGqWTTV8HGdw1j3gEe4?=
 =?us-ascii?Q?zNX14WRvWFBQIxTWeFJymgNWA4wg/BbC7RPLzfzpx8QOz/n8dik9B7/vGgFL?=
 =?us-ascii?Q?72KKMmbBrFnLS84hE314C+9lwl5ma1N/juuOejXJucxRGvWvgy4yUug0cHEa?=
 =?us-ascii?Q?/K0hIqJSFnJ6gmMrAihssIw1TpRg2y+gjLkFNHv4G+QGtvx56XfaAH33SWdY?=
 =?us-ascii?Q?PlZdwQduitg5d6zgEhhXU+tyeJQFR3Rhk0DPt6fr820AuzO+tQ6pBlHBa4ib?=
 =?us-ascii?Q?I0d3D6XUtH7aGIuCFJt3q4Qpe+Zcr0LwS/8+JJF2L3yVxFKnwp8SoOiqJb1Y?=
 =?us-ascii?Q?5IF6CyGhj3FdtRIpEb4cclWaI1/7HkScjqCWV0YqOFmfYtEKdhkbKKmjm6pE?=
 =?us-ascii?Q?9MBOKvxa0/Z8btaysbDgfwV9UUIV0xlCh192uONMCdAN5YAPdk4MToNoyM2r?=
 =?us-ascii?Q?EobJG1pIgIUUxJM+Ewn0pbTumDC0j1ZAvZAsf95dpHsocTlwZR/EwYqO8rAv?=
 =?us-ascii?Q?4dr1ApwNrHDqkPmnp0kqqGnDzAwTYdOyWlnbsLEMs0b6F8YrXD1ItZNRpXwx?=
 =?us-ascii?Q?Srj60lH7AC67oM6D+WQFYlGF?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188fed14-ffa7-4d8d-3455-08d8f5fb08c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:20.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3aCjD1xwG6Zu9jpvcN22vtE2a3w/PR/TFvPWOO+BJSt39SIW6kUH1TmFTH3wTDQ8alJE82msCUVzMJoh++wiTTSy8e8+hUDuaBXixW9U4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

With a split in two done, extending to three is fairly trivial.  The
only difference is that the introduced "touch down" point of 4.12 has a
fetch depend/ref itself to the other touch down point of 3.8.  The parent
repo (v5.10) has no need of knowledge of what happens prior to 4.12.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/linux-3.8.bb  |  9 +++++++++
 meta/recipes-kernel/linux/linux-4.12.bb | 10 ++++++++++
 meta/recipes-kernel/linux/linux-5.10.bb |  5 +++++
 3 files changed, 24 insertions(+)
 create mode 100644 meta/recipes-kernel/linux/linux-3.8.bb
 create mode 100644 meta/recipes-kernel/linux/linux-4.12.bb

diff --git a/meta/recipes-kernel/linux/linux-3.8.bb b/meta/recipes-kernel/l=
inux/linux-3.8.bb
new file mode 100644
index 000000000000..58063ea51691
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-3.8.bb
@@ -0,0 +1,9 @@
+SUMMARY =3D "Linux kernel v3.8 source"
+DESCRIPTION =3D "Fetch source of the linux kernel up to the v3.8 tag"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dd7810fab7487fb0aad327b76f1be7cd=
7"
+
+KTAG =3D "3.8"
+
+require recipes-kernel/linux/fetch-linux.inc
diff --git a/meta/recipes-kernel/linux/linux-4.12.bb b/meta/recipes-kernel/=
linux/linux-4.12.bb
new file mode 100644
index 000000000000..6e8034a77f4a
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-4.12.bb
@@ -0,0 +1,10 @@
+SUMMARY =3D "Linux kernel v4.12 source"
+DESCRIPTION =3D "Fetch source of the linux kernel up to the v4.12 tag"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dd7810fab7487fb0aad327b76f1be7cd=
7"
+
+KTAG =3D "4.12"
+KREF =3D "3.8"
+
+require recipes-kernel/linux/fetch-linux.inc
diff --git a/meta/recipes-kernel/linux/linux-5.10.bb b/meta/recipes-kernel/=
linux/linux-5.10.bb
index 73e33d405376..373c6b8def2e 100644
--- a/meta/recipes-kernel/linux/linux-5.10.bb
+++ b/meta/recipes-kernel/linux/linux-5.10.bb
@@ -7,12 +7,14 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7=
fc9398086aedcd7e46"
 KTAG =3D "5.10"
=20
 # We optionally split the v5.10 download via adding refs and depends.
+# Multiple splits are achieved by adding more chained dependencies.
 # Fragmented downloads can be less apt to timeout, but delta compression
 # will lead to object duplication for > 1 objects/pack/*pack file and
 # an increase in overall on-disk totals.  The du -hsm for bare repos:
 #
 # No split:	1521	epoch->5.10
 # One split:	1730	epoch->4.0, 4.0->5.10 (854+877)
+# Two splits:	1928	epoch->3.8, 3.8->4.12, 4.12->5.10 (628+647+653)
 #
 # Download sizes will vary depending on server compression settings.
=20
@@ -23,6 +25,9 @@ python __anonymous () {
     if splits =3D=3D 1:
         d.setVar("KREF", "4.0")
         return
+    if splits =3D=3D 2:
+        d.setVar("KREF", "4.12")
+        return
     bb.fatal("Unsupported number of v5.10 kernel content splits (%s)." % s=
plits)
 }
=20
--=20
2.25.1

