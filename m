Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web08.19604.1617383786731332484
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=N8+ts4xd;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKE3yHP/fSno6Wbm4IsvU4r9Jd0iby+H7gIZBPGA1FKer91/6URkCr2o5wbtx5geMk4AIdqLbOl+db8I17aOQLt2Bl4doVi2RccO5OS3yAq6RpzAGeKoAlJALiq4Zc8OiI23NG+zNWyeqOwgSSGIbXfRYjNFOeub58lpb4gUGVjj+SXNSbeTE2HL7wS93512mJlxN5Q0YAhaG3lzdQZd0QPjNMOD8abXggkMT2m/uOaF39Luyu7H9MRgax89Dn16PNdb4lESaFZCb2EWfzXPXwbywoD6bm45nnzrF/eVahvO3rb21hn+xtAYAbAMvkakocLtSinq1hQ6W34b7K4qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxH0Hm8ESvkMYmsIR++gIBxQ3KfuxBDXT3ytymjA5XI=;
 b=IFK8t5oXXo11ySZxj/rQDcBZvI8geHpN9r/dnJRN07isrEeJjfVO4Rb0l+iPW4aWXro0I3jRzcn+rJ6b8s/Rpm312YDv+jLTrZ7a26R+45OjzilHBrEYX5z+LWmtC60sKnhP9B+u20Fj9DnGVOxlF6XTrP54/qTyUhrsoHNwjjNSiIR+bz4ghN7SBShRzQIkrpWhkLEy91hwnSTVN2tC7DCn4xl6rr0OPqYEaKcob6H962xuKhVO/wJCxsfhUPk07ibEG0JKCeAhTWE9oXI0oPOuUr0NRlI4JIFbzlWfI56NEN8/ngD7xSU3HNDpeWZB2QAZ0WHwRLSJI7B5S1wDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxH0Hm8ESvkMYmsIR++gIBxQ3KfuxBDXT3ytymjA5XI=;
 b=N8+ts4xd0hxvobz2VPzDr04N5hcykXQWS7f/buy/wuvoHqGrRHlQNb4Mtw1iuhUSB3kFAsz3oG6A4ObqjIpHLUhMU/hfgv8ileAWH588OfuVVnxNG/tm2Tr4h0dshnI277tkHzK/EHAP/pBlIIWUFNLYm28ZhDZ1OoVrkJb9prc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:21 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:21 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 14/21] kernel: allow splitting mainline v5.10 source download in four
Date: Fri,  2 Apr 2021 13:15:50 -0400
Message-ID: <20210402171557.981599-15-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d66e7743-ec43-49ec-dddf-08d8f5fb0935
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249CC05A624531F5DFA35F1837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vfyrOcO0Yt3U0lCGlXLvFtvVTzkwqPvGvRtHEPPw1+2+CL1VwX4tfzXAvjjG0JSC7x00GrLanqcJRrEWp0OBZ+p7zEi/aNjkDvm2ebgrgJ/Pr51WHdKoSO2lgArm632UHxIMAoAGuiD1jFJMpIsT5tRz7h5udbgX2NMg9f8d+3F4Nfs3fub54mwndrZZtaaraBlMpUn7GfzwSQ9mM/fRQK5qIy1D0VXm1xY7lvvpYiJ/VnGkS13otlk9JDfa9fxJD7fTC1AC0YB9d1TsHqNm4ZHCzHS7RI0ZwKIxdTD1XXcLqBgr/6R74B/NT6evAcc/66gK0qFE9+Y2WXK4IjyWi6hK1viUN4Hb50EFANuObrn7UBRyzpHz4mJDd/A6fl/MgD+smmadCyDUxreb/rt/09oNoRz/RTyfydcWBRvy4HJZJcew0qTuyW3F68uk7DxfYTgdRCu0o7DyoZcqVdCiE0etbPoErrr3m61Fj6/1xa5dkgutNLDOzdUsn+H/8cWlW90pHUW2B30LnHY/omGfuBEUrng+ch2T9Wcd97g88Wc7rW/LHpcP3KAj+arMX0g5AB4vsNol4dkU/5t3GbI5mBAMUcrXIIz3jHoR9HdhXlz+e/9Uvz92M8d9JcjI6xLMEdzwAFkkx7ri7y9d42tf/A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(5660300002)(83380400001)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6666004)(8936002)(36756003)(52116002)(1076003)(956004)(86362001)(2616005)(66946007)(38100700001)(8676002)(316002)(110136005)(6486002)(4326008)(16526019)(186003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?XZTS0QtOjuOPYwpIYZYxhtt+a1bPL+dCuwNFLbWAvslGMnLxclZz5+x745Cu?=
 =?us-ascii?Q?6PoI/0jSY509zsM236S+JpVUNxTlTM+q1wf/WWM64uH2S870VMGGQxtSRed3?=
 =?us-ascii?Q?JK2XXiXnNL1ZEMTc5UU58z/xX4QrD4XqKFjaFsaQ9Ws0nBMVFgnjQ3MT+whg?=
 =?us-ascii?Q?O/XmJ2CO4RDEhnIsqBQ9KKoSO78cUVqf5navlxFNnFohjOBhqj/2H8Vu5pWX?=
 =?us-ascii?Q?fOfETnxoVQUS7WvDE4f8rvoHVudE5IztkD9REw3QZyOIVyXmn5xUG27O73+z?=
 =?us-ascii?Q?/CnKcUN72t1EMGNxLrGRUv4BX068MkyBLVXxEQjV2Xni75Kyw0467ujUArYb?=
 =?us-ascii?Q?Z3E1almAnuAmu3TI4fdjJkyYd9TP3VoN/fZTXuTQ7nSTdlNVYHBnxvpA8HCq?=
 =?us-ascii?Q?l7iOGajCxzsDgARL8i3N6gBDhUdsSXuuG39ubzEO+xM9ZckUrlCFIo71rSjS?=
 =?us-ascii?Q?QC4BrExcdkufVwsFw+g9qxthKNOZqIVKEQK7gtphFMZhBpYuPiRdiBa3UsYW?=
 =?us-ascii?Q?Usf02/HiYJv/Mj3AD1wcWSQoOjTygosZ1ryCgsdxL0t4ZGZbU2vb8Wg1U0hP?=
 =?us-ascii?Q?EHAznod8mSvzoDLyfOlGkl3+AKsj2VkGkikLp9IsKMjZFZrssCO9hICRIB/X?=
 =?us-ascii?Q?fqZeOeZkJszJzR/vdoM/NvtDdTk5TrQqMPq7FUm1M6RW2I0LuQ8QSx6bGI/n?=
 =?us-ascii?Q?/fnyLGr7K0y1Q+0tEnoDIV7YQBbHLuqgZT4Z7HEoD88i7iTpqfaJh4tvM14y?=
 =?us-ascii?Q?/M0RoYt5A7hCWMI35bYR6KKusjBk4VJ1OKQZY/ydSqBJli1PvwEr4RkLB5YW?=
 =?us-ascii?Q?xH0aH/eL99jY4lz4W19FdLisRwiu1coKsifbFoYcYPT2oXXMUTIAUtnnAiwQ?=
 =?us-ascii?Q?zrWR2AEfokiMnZAoVcqsXoHDaPLkeFMgzuhX3zBL1CW2Eme3kn+0fh+F9DvY?=
 =?us-ascii?Q?QuVy29FMJfB/k3PNZRY9N4+5M8bBsJUoMyXl54rSEj/DuKrdtm07+C8SjsEu?=
 =?us-ascii?Q?Lg8F3KSQftRP1/TOVe0BMCol++TIEdoRbQZA3zpWUkZGsdtfkc04EnYfiFK6?=
 =?us-ascii?Q?eeNorJhKQcQKbZ7QTsNmBTWVS5+BmrXpL8vpP4con+iLbO4ivUA57Wds7w5x?=
 =?us-ascii?Q?mFUJZqNveutLnGWbCuhXftGsbkXhEm98IRVJEREdP/NGQVy6UyrO4uzqS1rP?=
 =?us-ascii?Q?Z2GWmP99qg7NiI8qbvQn9AmuXGJUV0xskGDwXa+9XT/bQur7Ld8EZm+OI2UG?=
 =?us-ascii?Q?1UeEFZgd1/oR0iGGFEcMyFP/WE5Sji235x9msu7o2Suy1gyNfDM0s4mGubck?=
 =?us-ascii?Q?Jvx1oocUSa8eUK+gEL66dGfQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66e7743-ec43-49ec-dddf-08d8f5fb0935
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:21.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEJqz8x8Ah2zrPO4YmdBBgDYLt6nI9BjZuE5drhVFFrnA3SVmCigNhUvDz+ImJjgCqM2q0/AAnNF42vJ4s9b8eb2e+7eVmptA/567panObg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Extending from three to four roughly equal chunks introduces three new
split boundaries - 3.3 4.3 and 4.18, but is trivial to hook in.

This gets chunks down to roughly 1/2G and with the resulting loss of
compression efficiency, it doesn't seem to make sense to support
splitting things any further.  See the chunk sizes in the commit.

Document the new variable and its allowed value range since we don't
see adding any further split options.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 documentation/ref-manual/variables.rst  |  6 ++++++
 meta/recipes-kernel/linux/linux-3.3.bb  |  9 +++++++++
 meta/recipes-kernel/linux/linux-4.18.bb | 10 ++++++++++
 meta/recipes-kernel/linux/linux-4.3.bb  | 10 ++++++++++
 meta/recipes-kernel/linux/linux-5.10.bb |  4 ++++
 5 files changed, 39 insertions(+)
 create mode 100644 meta/recipes-kernel/linux/linux-3.3.bb
 create mode 100644 meta/recipes-kernel/linux/linux-4.18.bb
 create mode 100644 meta/recipes-kernel/linux/linux-4.3.bb

diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-man=
ual/variables.rst
index 55028987c08a..1226bbf77193 100644
--- a/documentation/ref-manual/variables.rst
+++ b/documentation/ref-manual/variables.rst
@@ -3441,6 +3441,12 @@ system and gives an overview of their function and c=
ontents.
       lines in the example are from individual recipes and show how the
       ``PR`` value is set.
=20
+   :term:`INITIAL_KERNEL_SPLIT`
+      Specifies the number of times the initial kernel Git clone should be
+      split in order to avoid one single gigabyte+ download. Supported
+      values are 0 through 3 inclusive, resulting in one through four
+      separate chunks (repositories) in the download dir.
+
    :term:`INCOMPATIBLE_LICENSE`
       Specifies a space-separated list of license names (as they would
       appear in :term:`LICENSE`) that should be excluded
diff --git a/meta/recipes-kernel/linux/linux-3.3.bb b/meta/recipes-kernel/l=
inux/linux-3.3.bb
new file mode 100644
index 000000000000..da355f9cd32c
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-3.3.bb
@@ -0,0 +1,9 @@
+SUMMARY =3D "Linux kernel v3.3 source"
+DESCRIPTION =3D "Fetch source of the linux kernel up to the v3.3 tag"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dd7810fab7487fb0aad327b76f1be7cd=
7"
+
+KTAG =3D "3.3"
+
+require recipes-kernel/linux/fetch-linux.inc
diff --git a/meta/recipes-kernel/linux/linux-4.18.bb b/meta/recipes-kernel/=
linux/linux-4.18.bb
new file mode 100644
index 000000000000..ea87f5e92b52
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-4.18.bb
@@ -0,0 +1,10 @@
+SUMMARY =3D "Linux kernel v4.18 source"
+DESCRIPTION =3D "Fetch source of the linux kernel up to the v4.18 tag"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dd7810fab7487fb0aad327b76f1be7cd=
7"
+
+KTAG =3D "4.18"
+KREF =3D "4.3"
+
+require recipes-kernel/linux/fetch-linux.inc
diff --git a/meta/recipes-kernel/linux/linux-4.3.bb b/meta/recipes-kernel/l=
inux/linux-4.3.bb
new file mode 100644
index 000000000000..35e5fd48d8ba
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-4.3.bb
@@ -0,0 +1,10 @@
+SUMMARY =3D "Linux kernel v4.3 source"
+DESCRIPTION =3D "Fetch source of the linux kernel up to the v4.3 tag"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dd7810fab7487fb0aad327b76f1be7cd=
7"
+
+KTAG =3D "4.3"
+KREF =3D "3.3"
+
+require recipes-kernel/linux/fetch-linux.inc
diff --git a/meta/recipes-kernel/linux/linux-5.10.bb b/meta/recipes-kernel/=
linux/linux-5.10.bb
index 373c6b8def2e..e147c854477d 100644
--- a/meta/recipes-kernel/linux/linux-5.10.bb
+++ b/meta/recipes-kernel/linux/linux-5.10.bb
@@ -15,6 +15,7 @@ KTAG =3D "5.10"
 # No split:	1521	epoch->5.10
 # One split:	1730	epoch->4.0, 4.0->5.10 (854+877)
 # Two splits:	1928	epoch->3.8, 3.8->4.12, 4.12->5.10 (628+647+653)
+# Three splits:	2106	epoch->3.3, 3.3->4.3, 4.3->4.18, 4.18->5.10 (536+532+=
519+520)
 #
 # Download sizes will vary depending on server compression settings.
=20
@@ -28,6 +29,9 @@ python __anonymous () {
     if splits =3D=3D 2:
         d.setVar("KREF", "4.12")
         return
+    if splits =3D=3D 3:
+        d.setVar("KREF", "4.18")
+        return
     bb.fatal("Unsupported number of v5.10 kernel content splits (%s)." % s=
plits)
 }
=20
--=20
2.25.1

