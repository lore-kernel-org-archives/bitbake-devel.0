Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.50])
 by mx.groups.io with SMTP id smtpd.web12.19633.1617383786141419869
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=DboUz//L;
 spf=pass (domain: windriver.com, ip: 40.107.76.50, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cokRiGXT2UI1sl40tCmIDBXcr5y8QazEbk9JBmSebyyAAKiRmO05pvqLCOrdAPIuxSRTbFWswi9VVZPzmFjw44s491IT9oFQbgdlBCHIzwdyE1ECRiNHaxCONRdgxZtkDN2fZy95i7F9A3bapyvxV7IrZrm8rwhP9m68Y3WBsab2fWwwO7XgAEmKdCGvZRA9gxYaTDYF6qyP+Kex7i9WwphNOKMKOChekfTX1jhBb7v1WwXBfkUaxCCEg5LEMrrkxjDeLtdSVCRsT2alBDT9FXiZ/Yd0Dsd88eVrBtjFfXUlFkYVLPXhkniIgvv/b8ejrQHev1yTN0JF7dFjBqP/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKISuIDXa4Oy0gQiEvTPoEoztuw5+BPitBcBiKDy2d4=;
 b=SUtoRBp39W+xcmFHM9Z/XaIpgyh8izAyxfz7lOBaEubos2l07jaq+jsF8cRAPMnF4f7PDfqyT6Wvb00kx3pUs4rrUdCzn9I/LqqEcJilXbJHF8U2cjQ5/oDacKpmG9wOKhs6ysP7+LlnwR3pAsIdjBJZ8xnUzNAzKIe7h6SDmoN0LIm7u3M0sAipddGCyuFsKD7NvMmaJ7OK4euC1ySHNaNUMkbgexW5x4es6PtVP4ZqBWxIsaKeSEtd/4+YN/81oePAh/oqFXDPqrvLaKfbwGHxfwFNjLccRn3+vM1p3MsmC3/8OQC/PQQ4bveYGUKNEIzz4eo9X0I2aaMYja8K6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKISuIDXa4Oy0gQiEvTPoEoztuw5+BPitBcBiKDy2d4=;
 b=DboUz//L3JDdnmXhFIq9D3UapM5bHAKe8WZxY7KTLM0tIKwt5EjNkFqwg+UWOOa5goNCJYZ0z/FxSqS5Pom85BJ9IWXn/F7j0ko4oCB82MGhJ/CKS90KN8PxHqGzRsPuKc5NRiF5PJyGbNGy9x9ICroWSYHmpWDrDe+xzDH68Og=
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
Subject: [PATCH 12/21] kernel: allow splitting mainline v5.10 source download in two
Date: Fri,  2 Apr 2021 13:15:48 -0400
Message-ID: <20210402171557.981599-13-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81e3ae1a-9794-461d-1a02-08d8f5fb0867
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249CA951B6680848E1BA3D7837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qVNHGFOzxkoX0xI3djMM5oyq6jW4lVWw7ECdNdSVeO5Ll+nrX859/nTVn7x3hUrrJLtkWXIPfbxtdsqZxGwYV7KLDFy6w8FMRGyvRG0mah29TPPQM4y6U2Gfk4WiV4aj/4/eYSYrHa5CZZAJYOBJK8ES6RVJSat0XHJrFw7HvWnjaPzR18KXV1Qe45j+04F+NDQJ6a4lyyT38L09mTBPemCg+C9YDFAXllSM/LfYkC83yy55kYNc+BhFF9fEQJLecpZOiUddjAu2uCH5kRjF4BkJKB8iYrpfnND951RxdbRknGjSnwLE1GRcOxks316zFH9FxNG1hjZmaHPsBiM6T84wXKQNe8Z4JURKxe5rUA3afQlUzKtU68u3Hj/F4Ci0v8RFMmKPekN/CnqV3sj2s1dy/lIEWiWxbJH9cGWAQushemcupmMhia+bUHs9eTZwCWXTY0G7hTN8P9bOsTyYxBHwwyYr3Pm0sN64Xwsl+UHy2V5GB9pSOzByaR3HnZfLmtD129NHQyPMyiey48GuKkXmXVi+FGbP55x9InlI1yrYqwIFMJfls2iNIFTkV5CjKy02gKATz4gM4V0pzjViaaQxVavlfiWFWbb2uItKFDSLDyqWm2pJIJntpmGIK9Wdlb5DljchGItV0+DUMBA+HA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(5660300002)(83380400001)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6666004)(8936002)(36756003)(52116002)(1076003)(956004)(86362001)(2616005)(66946007)(38100700001)(8676002)(316002)(110136005)(6486002)(4326008)(16526019)(186003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?2zpBDD6yLxS0mLJ1frZJriu3/FmTln4IdQffpxA+7e5Oxi6vI38fxN5HnCvK?=
 =?us-ascii?Q?g6H4TULfNuukNYiKQh3PWpcQY0/PsNM7wQ8Zop2U3+fhfHnj/ydKE3q3WVc+?=
 =?us-ascii?Q?+BmlrgXjjaVmkp97XEXaNE/Wvl0H75wLAVanHWfAM1m45dDNWV+9Fx/HJpW1?=
 =?us-ascii?Q?EBDG0tQ7g952PUjASCd0sBhOhkBN7jSrYEiISalvFJaV+KdEjr5osVwqOBys?=
 =?us-ascii?Q?Y+KJ9U0vLPgbxcPQHSmbMkSugurG95f9XR3GbEgwhk7vshB6r3bMoC99B8BW?=
 =?us-ascii?Q?uPFMKIGy07ATcsK3CFEkVziQmkbpyQvjo4bxCX9yYVwfEhRWb8dgPl+2jWLe?=
 =?us-ascii?Q?kVz9ksNqiShd+eXrn7vQj+lKTbT8DiQ3FEC7uqCF7mSJeHQhwWoWV6OfCyW0?=
 =?us-ascii?Q?nEkqsaYh1x4N0Uf7H7tsBPfjKLh+Wu30nRIYx+9bE3Qsx5ofVgltm4fZtXTP?=
 =?us-ascii?Q?HBpyjA7w2+S7DbqhKK7MglttmZqVVnoYCFEVLp+gpXjR4Zu3UWjfLOt4rEr9?=
 =?us-ascii?Q?fG12+0xL6B5pJCvFlEOv+2T0RNN7JTp5lnZoBtTArcv2cN7JttnnrSKKWUM1?=
 =?us-ascii?Q?0nTh0e5NrzCC0wVB+lMhCHpUwrfK5HTdvqOKUX93E9Tlgvz4PQ5GGbhK15Dq?=
 =?us-ascii?Q?mjMZdGzNTdMij53i3Ca9NwCj4jHkxpLuEJGZ0SrtDU6p0h/QM+gj1o063uEn?=
 =?us-ascii?Q?cLrk5knfCAXHJioOYf8ibHOw2HNY34S1u91Hj6tdLHONSFuDu707FSnmDBOy?=
 =?us-ascii?Q?Ql30zzuWTiAPbXzpOOsufz5+Y9j4SUth5LKByRDZNVbZpB1leghE7VmL2OOy?=
 =?us-ascii?Q?WTvsG4YS/+vM2lr6WETuf+INfvPO5vyx+pKekU8CQKQ6uTqB4eCYNZwh7nIH?=
 =?us-ascii?Q?1Zo5S5i5fYOdoRzybVzngKUJrFoCWXIhyZNg1I17fNXoFbOZryJciZ/wLaJd?=
 =?us-ascii?Q?5jIbY2PbY+8Rj3hQvHUnVYrvRxWEYrDp/G54eLrFL0hQ5W5rNxi6WhM9Hu6+?=
 =?us-ascii?Q?SsTAHVCRj4EuI0TbNPfZBzQDVua4niXCQe/WwhoLqaywj2rgCl8U9ibYb7+r?=
 =?us-ascii?Q?thP1/Zeet5ObGpuAKb1BlvC6UmI5M1szB5IMzrySKbhIzgQ3V4xw2Xz5b4wk?=
 =?us-ascii?Q?LBwHrbeSTvokOspIC9s/jWm01YZjY6ojPR/Gu5bFntfaOX9X5yFNt0jCINyX?=
 =?us-ascii?Q?GDqH4PPLIL4mtdNrrHUZOQlrycjZAzVuYHmiadC7y4Zh8UxV+n3/J5KwAgii?=
 =?us-ascii?Q?hGrtDTjsj3JNRtuQw/erQ7PUPeXIxZ11sb5VI40/jHRGVprtSWP+KBiYGtl/?=
 =?us-ascii?Q?ztCmUc+aa82wD4STabh3z4Ej?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e3ae1a-9794-461d-1a02-08d8f5fb0867
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:20.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU2nHRfLniq/d+zzd8VgxvTr2ekux7t0Hor+PqiVCv2i8o8gHjh3q1gX56ZOICtg74wEgQxxZsg02s/l3yi3JRcwI+Qgza0IEW9hF+ZFD3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

With support for sharing packs, we can now optionally split the larger
mainline kernel content up to v5.10 (approx 1.5G) into two.  This may be
advantageous to people with release media constraints or unreliable
connections.

By setting "INITIAL_KERNEL_SPLIT =3D 1" in your configuration, you will
get a linux-4.0 clone and then the linux-5.10 clone in your downloads
directory.  From a size perspective, v4.0 is roughly the half way point
between when git use started in 2005, and v5.10 from 2020.

This split is achieved by manually selecting the midpoint tag and cloning
that portion 1st, and then cloning the 2nd 1/2, while using the packs in
the 1st 1/2 as a reference.

Packs deploy both zlib and delta compression - and as with all
compression technologies, splitting the input comes at a cost in terms
of reducing the compression.  So two packs will be bigger than one,
three packs bigger than two, and so on.  Representative numbers are
listed alongside the implementation in the change itself.

The 2nd 1/2 includes a fetch dependency on the 1st 1/2, so that things
will be serialiazed properly.  The dependency also links it into the
chain of events, so no other mentions of v4.0 are required.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/fetch-linux.inc | 15 ++++++++++++++-
 meta/recipes-kernel/linux/linux-4.0.bb    |  9 +++++++++
 meta/recipes-kernel/linux/linux-5.10.bb   | 20 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 meta/recipes-kernel/linux/linux-4.0.bb

diff --git a/meta/recipes-kernel/linux/fetch-linux.inc b/meta/recipes-kerne=
l/linux/fetch-linux.inc
index e3fdd0bb36c2..96653a2bea06 100644
--- a/meta/recipes-kernel/linux/fetch-linux.inc
+++ b/meta/recipes-kernel/linux/fetch-linux.inc
@@ -2,6 +2,19 @@
=20
 require recipes-kernel/linux/fetch-only.inc
=20
+python __anonymous () {
+    kref =3D d.getVar("KREF")
+    if not kref:
+        d.setVar("KORG_REF", "")
+        d.setVar("KORG_REFDEP", "")
+        return;
+    clonehost =3D d.getVar("KORG_SERVER")
+    d.setVar("KORG_REF", ";packref=3D%s.torvalds.linux-%s" % (clonehost, k=
ref))
+    d.setVar("KORG_REFDEP", "linux-%s:do_fetch"% kref)
+}
+
+do_fetch[depends] +=3D "${KORG_REFDEP}"
+
 GITCLONEARGS =3D "--bare --single-branch --branch v${KTAG}"
 DL_NAME =3D ".torvalds.linux-${KTAG}"
-SRC_URI =3D "${KORG_URLBASE}/torvalds/linux;tag=3Dv${KTAG};nobranch=3D1;st=
atic=3D1;dlname=3D${DL_NAME}"
+SRC_URI =3D "${KORG_URLBASE}/torvalds/linux;tag=3Dv${KTAG};nobranch=3D1;st=
atic=3D1;dlname=3D${DL_NAME}${KORG_REF}"
diff --git a/meta/recipes-kernel/linux/linux-4.0.bb b/meta/recipes-kernel/l=
inux/linux-4.0.bb
new file mode 100644
index 000000000000..68dd054970ca
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-4.0.bb
@@ -0,0 +1,9 @@
+SUMMARY =3D "Linux kernel v4.0 source"
+DESCRIPTION =3D "Fetch source of the linux kernel up to the v4.0 tag"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dd7810fab7487fb0aad327b76f1be7cd=
7"
+
+KTAG =3D "4.0"
+
+require recipes-kernel/linux/fetch-linux.inc
diff --git a/meta/recipes-kernel/linux/linux-5.10.bb b/meta/recipes-kernel/=
linux/linux-5.10.bb
index 7f8a27bcb1f0..73e33d405376 100644
--- a/meta/recipes-kernel/linux/linux-5.10.bb
+++ b/meta/recipes-kernel/linux/linux-5.10.bb
@@ -6,4 +6,24 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7f=
c9398086aedcd7e46"
=20
 KTAG =3D "5.10"
=20
+# We optionally split the v5.10 download via adding refs and depends.
+# Fragmented downloads can be less apt to timeout, but delta compression
+# will lead to object duplication for > 1 objects/pack/*pack file and
+# an increase in overall on-disk totals.  The du -hsm for bare repos:
+#
+# No split:	1521	epoch->5.10
+# One split:	1730	epoch->4.0, 4.0->5.10 (854+877)
+#
+# Download sizes will vary depending on server compression settings.
+
+python __anonymous () {
+    splits =3D int(d.getVar("INITIAL_KERNEL_SPLIT") or 0)
+    if not splits:
+        return
+    if splits =3D=3D 1:
+        d.setVar("KREF", "4.0")
+        return
+    bb.fatal("Unsupported number of v5.10 kernel content splits (%s)." % s=
plits)
+}
+
 require recipes-kernel/linux/fetch-linux.inc
--=20
2.25.1

