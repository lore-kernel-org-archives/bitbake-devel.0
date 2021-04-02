Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web10.19480.1617383784768231124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=EVmWXfI5;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmdNZgImw/rbecB9riXRlx5dawA9AwVvgJ51id6bHnnjzIPtS0QeE5L3a/Jaf89bmiawJR8HggFWidDiRT0q1BbIMDyEEseS7daA7CM0v/VJxuOzNTmvYkkFccNOjjbgYytKhvZaa0tQM/sNqBeapx7ZAx3Tb03r63/AfOTSdBjWW0XcXk8ljkZ1G8FzdAD8zutKEqky4vUgvzZCKlSHmajwzH8ZZJOWbiiAILaRfvgVgHTGTkWcNPXrAousT7yay4VqswyHE9AShuwnNSP5vAP2o7T4U/8IVEUh/Wg1wQDhDf4iyii4tDh2M2a7JEySla5f1YqySaF5siuabLxWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGXixNFvf82pYxKpbKgrGeQe7d4brbORhiS/iU0KpHc=;
 b=c4sSNg5ml3WUsaWiFR9K4HWm89mvhcMHyTjJxOnG6TyKucNlHf6ma/6X2+/+9tYUlaSB5YQe+zZ7xaFTAJGHU20ZjmWtMk3W5minzSkXpRsDCEXbJiHLRFWsD1yaSsnx9WitRjY3o1pnp4i9B1R8SQn/pT3x1VL3CfDNh4+7vlNHydu56D4/v4EEfp/UPf97V4DCD4FAPwqrx6Xl4gjx3gzKSCa/JgZJezwROcU7/TTjxFHj0tMu04S5MLxBH1GWKKy4WaaFDkkyWiUXssOQKadCVBbXVxuuZFuXwqP++2TYZWaXM6E9OkoLrOV/HEuzuxELIRIh3px6orGQ+vaI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGXixNFvf82pYxKpbKgrGeQe7d4brbORhiS/iU0KpHc=;
 b=EVmWXfI5o2RnYVvoj2ljpDivFzEPsI0KQtffCctSmpcvNqYDEV61Rcb+oMmGzngvtQ25A1hmcS7NSfmqeIra1HAuHvjv9nyJexCvJc+vj0P2NfjdSwyD2IPFGjmFeNVf3ehzpb30pkU7CmpPgdrCSAUth9SAbX0q2Ea59vsWPpk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 17:16:25 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:25 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 19/21] kernel: make v5.10.x Yocto recipes use shared source
Date: Fri,  2 Apr 2021 13:15:55 -0400
Message-ID: <20210402171557.981599-20-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc3b9b42-a855-4d63-e479-08d8f5fb0b8c
X-MS-TrafficTypeDiagnostic: DM6PR11MB3532:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB35320E8D7AC18BD90B39E1AD837A9@DM6PR11MB3532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cDlaCubc8e/KOmB6KXH84eBrbdBDNnKh5nhm5pFzEiJfXiVMbKiliynQnR1nBJ0PpfFwX1ABSrtPdoB9rNwiP5e6GQbsJDGKx2JyKDw287sPvUPct0V2qVNnURpmNDJmjQJYW5Ve8fkBfc9KXgD/d+yP/412Iu7MlFuy91G53VQExiaroWo6Q0U/jp++5QTkWEAIsD/K+CE9q1MAtOr1Y4dZBt+dCYs3ml9kU/WOMVY1rAMO1Rova99PlYHmKo1Uj+zupNQqptc2gKTasvTf+iw+D8EeUFoOlhgkq/Dn/VLL/ygzX5eVwwoSRRi1xObnacuhCpG7vS+R16AYQPQ9P9tc8GOrOwoMIPCO+xn172nR1H75R3CHRlfy4YgHA2rFjJmE/FWulP4mqKns9+sYvhhOuyioOgKEa0s6xSbL7J/Jp+7B7OjZOWA4Na/oZzBaYWFl3HVei3vz+VUYb/9AyoU6zkCrwnk3SCPL5KajFEeQISckXvz735fu7LuNew/33xOf92HTjuG/2jiGw8yCdAUa9QKWsuzFnBAide1+3DayjGC4gSBSMJx65E3oANWjE3LYxVVheKAjjWMw9FGmjaunGoeIn3A69Zuifs0JapyFgRFosguwZ/lTDqPBWk3LWILrVP69LRx4VF+CBJUsAA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(186003)(38100700001)(956004)(2616005)(6512007)(16526019)(66946007)(66476007)(66556008)(1076003)(316002)(8936002)(110136005)(478600001)(36756003)(83380400001)(5660300002)(44832011)(2906002)(52116002)(6486002)(26005)(8676002)(86362001)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?QyoLm9gBJwpM0KuLOZMKg+KoAlDQauV7NPOuzEQrzj1qHr7GO1xqLq48WpsF?=
 =?us-ascii?Q?ZdNNfvALPBR659OpD5Or0QXjxwio+zvDsV6cxMAxetEXG6GT8Lp6wjhFORwV?=
 =?us-ascii?Q?il7vjZge/vBvusMJmz7fAnqNMysP0WFBl8lChAfL9nHJ5BtMKL0EdblqPKNY?=
 =?us-ascii?Q?yAC/LbZiUdjdYbuTGm+vIAAdAmVYO5rXLlk2ItAa54YDlMlIYEkL7w5J5EG9?=
 =?us-ascii?Q?5eCh1khYeGP0luJK9kTCc5A187w9fs34taYBBj0TegoqV0TWS+oaLvBAwDAZ?=
 =?us-ascii?Q?f6k6dKZx164NFJBOkMVWi3nWYpbeNFEdtnKtpgUcbCWVIPDmuIAJ/a+U1q2g?=
 =?us-ascii?Q?Wq9zJ8Whto5QDbtv8+fG6sMWy4bJRJbPNAglyNc3oSsUQ3oo6PmzGiq7gI1g?=
 =?us-ascii?Q?J2JipiAT5wFJzN0gfffsrw5Y+tjApHjn1QyZk10nuWP9FpoKeZrZ22pAs20p?=
 =?us-ascii?Q?4hkW5seCpq4cY1Wf7ae3wu7hc3d4065PEq8dLUhNaKqGUjTMpyZTopbrZwIF?=
 =?us-ascii?Q?L/Mmo8Emaf3lL/nQyGQt3mrSVX92fZoLbaKEOSfXI9rTtijbTfq+WYhWaoP9?=
 =?us-ascii?Q?qNeVRl1cRDJTAi0jHnSAvjyClvmSWn3zYqOBy0KJUJ8SGERVjBtuL+q8QyiF?=
 =?us-ascii?Q?Pu4mapGC2lXFAHZlJhPGB16J2EIRwEQc6X+VfBL1FV7AmO8srkxdAMaq+KLB?=
 =?us-ascii?Q?deT1mtThiiQsR7RYZmGtxXQ5BJkEZ9tNRRDVCvcGgqZAV194CVHPNoih/aiy?=
 =?us-ascii?Q?/jFN/Zh6qZRusOFDi0EBFeE9sZSzER9bv5ad2pQs8vAHzyQtojiifla9RcRi?=
 =?us-ascii?Q?QxCcRGXKeb3vo0q+EHYG06rWmjFkeSKpa9p44Q3MuwW7k4DcXSaIAkp76tqE?=
 =?us-ascii?Q?mNz+MJAbcMphP0nE3hFBisHvSyFwfkZSllmtPA2CG0VCoLB2XwqncdS87hUB?=
 =?us-ascii?Q?j5rTjbRO14ByuOy+/cjtwa3/ggeNHh4TL99YUNimtxD1QVry/e5VLrnzO6k3?=
 =?us-ascii?Q?UjfwNeqzgBUlRX1Bx2qyd/QYEQPeV1SwCBKNryhSyODcF0C2ajmPpsqjIPQo?=
 =?us-ascii?Q?28Elg6gETFw7EcGRUOa4dQff1In7hx5txU/3KCHy28NzSuKjD3NGm+XTuzlz?=
 =?us-ascii?Q?BwNQlCBf7hRxdsqc5T2IpymoUAk0uOzjzGKypnZoujql9EPgtqWmxs6rYFAA?=
 =?us-ascii?Q?3rWbdq6eyH2HCSqlCJlQyAUSfuASHwXUDHx+l1NkMSV38zxzk6OUUZiAiJlC?=
 =?us-ascii?Q?ke7+hAxr6oyXlUBmz7xu8VYnbZ/LL95dBNQ8O4Z3lz/eT5SKiYwkiBEoaF4s?=
 =?us-ascii?Q?lsgmdEXTx2cr/3TvEG/iR04w?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3b9b42-a855-4d63-e479-08d8f5fb0b8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:25.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXj50eue0+UsMoRX+yEyWVeCWMlzJZOyMV9jhSj39IHdE/7Z0Wgyo+nuJzMWxDJrPr37Dg+E+Fu3ZWtI05HmfIS+c9+rdttLxMkR399p+A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3532
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

With all the heavy lifting done, all that is needed is to select the
right endpoint for our reference, and the right fetch wildcards to
ensure we only get what we need. We've got:

	linux-5.10
	   --> stable-5.10
	      --> linux-5.10-rt
		--> linux-yocto_5.10 (and rt/tiny variants)

and hence the preempt-rt is the endpoint for the reference.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/linux-yocto-rt_5.10.bb   | 7 ++++++-
 meta/recipes-kernel/linux/linux-yocto-tiny_5.10.bb | 7 ++++++-
 meta/recipes-kernel/linux/linux-yocto_5.10.bb      | 7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/meta/recipes-kernel/linux/linux-yocto-rt_5.10.bb b/meta/recipe=
s-kernel/linux/linux-yocto-rt_5.10.bb
index cb34887cda83..072b2eaabac8 100644
--- a/meta/recipes-kernel/linux/linux-yocto-rt_5.10.bb
+++ b/meta/recipes-kernel/linux/linux-yocto-rt_5.10.bb
@@ -14,7 +14,11 @@ python () {
 SRCREV_machine ?=3D "be2935bce35f9adb6d0e735d42651e81a5094adf"
 SRCREV_meta ?=3D "031f6c76e488a3563f35258c72ff1de3e25a512e"
=20
-SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;branch=3D${KBRANCH=
};name=3Dmachine \
+KREF =3D "git.kernel.org.preempt-rt.linux-5.10.y"
+GITFETCHREFS_machine +=3D " refs/heads/v5.10/*:refs/heads/v5.10/*"
+GITCLONEARGS_machine =3D "--bare --single-branch --branch v5.10/base"
+
+SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH};altref=3D${KREF} \
            git://git.yoctoproject.org/yocto-kernel-cache;type=3Dkmeta;name=
=3Dmeta;branch=3Dyocto-5.10;destsuffix=3D${KMETA}"
=20
 LINUX_VERSION ?=3D "5.10.25"
@@ -23,6 +27,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7=
fc9398086aedcd7e46"
=20
 DEPENDS +=3D "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d=
)}"
 DEPENDS +=3D "openssl-native util-linux-native"
+do_fetch[depends] +=3D "linux-rt-5.10:do_fetch"
=20
 PV =3D "${LINUX_VERSION}+git${SRCPV}"
=20
diff --git a/meta/recipes-kernel/linux/linux-yocto-tiny_5.10.bb b/meta/reci=
pes-kernel/linux/linux-yocto-tiny_5.10.bb
index 83e59b0ebb8f..14db1e578c1d 100644
--- a/meta/recipes-kernel/linux/linux-yocto-tiny_5.10.bb
+++ b/meta/recipes-kernel/linux/linux-yocto-tiny_5.10.bb
@@ -11,6 +11,7 @@ LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7=
fc9398086aedcd7e46"
=20
 DEPENDS +=3D "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d=
)}"
 DEPENDS +=3D "openssl-native util-linux-native"
+do_fetch[depends] +=3D "linux-rt-5.10:do_fetch"
=20
 KMETA =3D "kernel-meta"
 KCONF_BSP_AUDIT_LEVEL =3D "2"
@@ -21,7 +22,11 @@ SRCREV_meta ?=3D "031f6c76e488a3563f35258c72ff1de3e25a51=
2e"
=20
 PV =3D "${LINUX_VERSION}+git${SRCPV}"
=20
-SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;branch=3D${KBRANCH=
};name=3Dmachine \
+KREF =3D "git.kernel.org.preempt-rt.linux-5.10.y"
+GITFETCHREFS_machine +=3D " refs/heads/v5.10/*:refs/heads/v5.10/*"
+GITCLONEARGS_machine =3D "--bare --single-branch --branch v5.10/base"
+
+SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH};altref=3D${KREF} \
            git://git.yoctoproject.org/yocto-kernel-cache;type=3Dkmeta;name=
=3Dmeta;branch=3Dyocto-5.10;destsuffix=3D${KMETA}"
=20
 COMPATIBLE_MACHINE =3D "qemux86|qemux86-64|qemuarm|qemuarmv5"
diff --git a/meta/recipes-kernel/linux/linux-yocto_5.10.bb b/meta/recipes-k=
ernel/linux/linux-yocto_5.10.bb
index 026e69511a60..c7a8cb360d2d 100644
--- a/meta/recipes-kernel/linux/linux-yocto_5.10.bb
+++ b/meta/recipes-kernel/linux/linux-yocto_5.10.bb
@@ -28,7 +28,11 @@ SRCREV_meta ?=3D "031f6c76e488a3563f35258c72ff1de3e25a51=
2e"
 # remap qemuarm to qemuarma15 for the 5.8 kernel
 # KMACHINE_qemuarm ?=3D "qemuarma15"
=20
-SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH}; \
+KREF =3D "git.kernel.org.preempt-rt.linux-5.10.y"
+GITFETCHREFS_machine +=3D " refs/heads/v5.10/*:refs/heads/v5.10/*"
+GITCLONEARGS_machine =3D "--bare --single-branch --branch v5.10/base"
+
+SRC_URI =3D "git://git.yoctoproject.org/linux-yocto.git;name=3Dmachine;bra=
nch=3D${KBRANCH};altref=3D${KREF} \
            git://git.yoctoproject.org/yocto-kernel-cache;type=3Dkmeta;name=
=3Dmeta;branch=3Dyocto-5.10;destsuffix=3D${KMETA}"
=20
 LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
@@ -37,6 +41,7 @@ LINUX_VERSION ?=3D "5.10.25"
 DEPENDS +=3D "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d=
)}"
 DEPENDS +=3D "openssl-native util-linux-native"
 DEPENDS +=3D "gmp-native"
+do_fetch[depends] +=3D "linux-rt-5.10:do_fetch"
=20
 PV =3D "${LINUX_VERSION}+git${SRCPV}"
=20
--=20
2.25.1

