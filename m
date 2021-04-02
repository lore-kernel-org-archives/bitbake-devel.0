Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web10.19480.1617383784768231124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=j5JoR80D;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmrcQgWhYul9u3s1i/uIBwPXTlG2PAcoTvO3T9mjlZiHSyLWcJkL6ACAWkhzgaW5RoFhvYuAWqBk18J7B57Tlvf4qPV5fSozS+vb86Q6n0a9bT1Fyr9jlMupif/CON5fuTNfU/CnYw6ar2jCspIPsxg9mTECc81b5fUudOCVs9BUuJaiKzBIfQsAVSAIgoIgUNr/DxnEn0L1PpX/8jdIhMi9ZBrXQg3TDj34l143kb+awgqf+AxdQ8U6SClJ00KR7K1T9d1M/nOIuDMdHm4ogdvmBr92LfZ5wIf1/1kRK+z7yO6NsclqKtywI6r9Vz31QeTp6Hu5SbVsg6Y1NxiuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZoOEVZThongeIALWCs8DMPk0z9Ets/niP/T7GDUHw0=;
 b=gmxAZz1TB0O7ewEQdKwfrdEEwJJnNdNrbdoTfHdDPKrhlzJrK/L+emVl2aKigpDAfUsV7dq/HOEiUDphKH7OjWCEV2XQQhl57QmMFKz27HC5064lCqKXvd9fRdCzYJr+l0q976LMotnvi+/C0r71qxFkb/1YILaaTagQ7D68VtsW4fnp31BBpB6rDPkbLIKHqpN+Ranvm1xo7ySk94DWJKxeiuBjTChKTiTW4V2KWbxNadpWz2qWw0lDvv1WFvPdbfd+gwSJC3nfkH+dkOfmXpMuxbSGot/e9a3NJ1VPkXvba95tBzoKx3IV7aKMBPIvLomR/5yaCHgfs9B2P0YDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZoOEVZThongeIALWCs8DMPk0z9Ets/niP/T7GDUHw0=;
 b=j5JoR80DaEU8QkNlVzSFmqT7VARxH2ylc08WYDCLre0RjWYT6/MdPYNDz5rEZK8a7dqjk9Uim0vXgMl75w+9sF85Oa0McX+MbSUxWPUS600gdWGa59sk1Pfh5WEjg8wD9+hxwneD6ZoBz+RVqVAC5HIUaLOzQGe2yTSBGReO37o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 17:16:26 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:26 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 20/21] kernel: make linux-yocto-dev recipe use shared source
Date: Fri,  2 Apr 2021 13:15:56 -0400
Message-ID: <20210402171557.981599-21-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 163bc035-1249-4540-123a-08d8f5fb0bec
X-MS-TrafficTypeDiagnostic: DM6PR11MB3532:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB35328A4F61409CEE29E1F1D9837A9@DM6PR11MB3532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gYzDgDRKrx0SLugeiNQVrgWX89VvsZifMM5pm5BLCpWC0qRqrDII72O8mDDgBMTvULLrJRMHtietraA/3UO8n1+rrLwVXMLkv5oYmUW57tJ5Y8ziNouf3PmYejMkpqRY6sHNLIaRglZqlvbOZiYAW1QHK4MZNOj28hYTIQcq/tvLBnawvPcQ5ahjI37PQNGZS82vzIbAZ1BhMMOa8cVULm2aK9mndAJZype/rUSl6YrPG+kruO/CASH52EzQa49YRoyI7e5HJFqfqrvG+iwSqA4MblfMVbCHlwapQV1eC9vTWOdnvNiVRKNGcxrpp/7E4mIJpe4XKArrRo82j/lAXXJBJwJ5IjOsCL6kzcpl+2UtVqMmc7F1sPPBw+BaCDOgl+XW6HOxxnt/jwWQQbt0kpoXpUKC9j2Ti8kPCnpsIlx5abBh77qnIFutSgvSF1Y4j9721gCBfLvtSl+W1Jc/RRxiOcCtth8O5dvja5e0y/5mNmoQFWV62YlGEysmIe4bTa/cpm6YnWBFRxyOB3JgS/BQg2wwdvFRkk3uO/ToFDbBbJbkeH93g6ZOv2R+wulTEsnEYobUSNKPgF4j3+oHgsGsKEnU81x3bKgwn4VzNe4qdYu4PyMdE5woq9TSO8wzDpcalN7QW05cKYq06fbH/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(186003)(38100700001)(956004)(2616005)(6512007)(16526019)(66946007)(66476007)(66556008)(1076003)(316002)(8936002)(110136005)(478600001)(36756003)(83380400001)(5660300002)(44832011)(2906002)(52116002)(6486002)(26005)(8676002)(86362001)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?1OBWHs1a9BzIAgDKVoitD/FsMx1438uAXehvKlTizF3qXbJrpCyqLjl+7ay+?=
 =?us-ascii?Q?1K+CxBQV4IpeHXi/D9/T8UpxWJT8ULK8OJM8epF2gtORGEnKl5dLdJP39D2p?=
 =?us-ascii?Q?svqonjzT5VWzwACv8qh/kNacl2yB8AsFrZNh0beo64U33BvEUeCOjN2Sx1cZ?=
 =?us-ascii?Q?OCOXvqJttDF0Dh3nC+gA8bbcgbrZ0TnxhegPs0OcooVy7hk4c6sVIpnDRsVc?=
 =?us-ascii?Q?1+Uo4tak57X9UjEQCwS2slv8NGL45l293sAPyJWfEd3BMAb7z29visJnatp8?=
 =?us-ascii?Q?8vD/LG4vzx3bR61nycDMKIuJeKN572ariNECqikKcHgh52Ap+rwabhzW5MGQ?=
 =?us-ascii?Q?rKsTvNI0R5j0HBhXBQKB8okyMTMcEmvFpk/C+mjyaZcQHtBXPZQR85bHISjv?=
 =?us-ascii?Q?PLX2DV+1Fju7oZN2aQDCc8hq5VNFzDM4BigouDLOWDD2imtDMp1zMB66WMET?=
 =?us-ascii?Q?dBvYLynO9dLQmm7V4a7Tf0SAnFtOMv1xjx5QCO02dUJnJ9tEIL65E6K1sQgc?=
 =?us-ascii?Q?xg1lIoZ1aEy3avMKgQaGeb33OJC5qd15E2AFHw6A3Kj70b7/Kqpv5IsLbl3j?=
 =?us-ascii?Q?bXY0HleNISs7abb7nn9MGChsHJOB/83akdBYatjqU1BrorZKQVATH53Ng0EH?=
 =?us-ascii?Q?FEJgZRODAnBPLJ7g1mmDpTB7J3UhqJA/tu8HnnAtA/gYD44WPj+LWltxmaYf?=
 =?us-ascii?Q?D5RNDGtRF2kQ73JIx6ZK78gLnqpJFVf0rEKIhwHOw+nbf1nLCRlDcOuYZGKP?=
 =?us-ascii?Q?6eTIbTfAa5+mOs61VtHav6m0rjEkKge4VqFi+WsMYWU1C/sFkhmP6mZkEwPR?=
 =?us-ascii?Q?ZYgp/KrYH0UVwI0tzqX0o5PA++f8aMo8RScSrpWxgDHzU7sI7McQNFt0jzac?=
 =?us-ascii?Q?3VC6QkxWIqrCNgHorQMMN1TbHnGYsCMKC8/5S0zjWCbHkac73RbPOxj/Qqxy?=
 =?us-ascii?Q?TLVR4IZwnGZNzf5ff/PP+xWQG/hzATnfEuQsMUIYIK3KMVqtnzpGkH/DoaCK?=
 =?us-ascii?Q?oBl/b1GUTPn7cKJwdrd6j3L/rGKPh2nGn6yMLSQzpaCmn5wng6DVgsbM4utS?=
 =?us-ascii?Q?6Zn99yMC5065w9pkgz0dfbCCK8N2B9FPhmPLc3JRY7EvKQE2et668dLbLVK2?=
 =?us-ascii?Q?2PRlKDOrPSpdHi2dOEk1gP3KCgOxoShoSuDVHP7LX+CAYp7HXahaydJX0JzL?=
 =?us-ascii?Q?wM8OYfWBVB4wkaA7XF5B56xVyCoPo5myoe2nXMqkSVz8x1DY6IDoKAnAIDXd?=
 =?us-ascii?Q?bHTigcBiTRXuxBJATXiLWSehpF9QADE9XoKyBuq/v7CLRPLshJ5ojyqd6oXe?=
 =?us-ascii?Q?EsylkNFkOOZ8sV6DKakTSuvL?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163bc035-1249-4540-123a-08d8f5fb0bec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:26.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcHdaBSbxnxNuFuYOhp/LL80TYOfZTBJqkuyxetKWCfbgRwk3C771l1LsK6hh9s5J6PytYCdOVCAUZlg2egdojq5rWRmdUb+4IKswMh+boc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3532
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

At the moment, linux-yocto-dev is set up to reference v5.12-rt:

        mainline
           ---> stable-5.12
              ---> linux-rt-5.12
                 ---> linux-yocto-dev

We'll probably move to v5.13-rcN in late May and at that point we
can point it at referencing mainline directly while the respective
stable and -rt versions take shape, or perhaps create placeholders
in advance (as was just done for stable-5.12).

But the good thing is that we'll get v5.13-rcN via mainline, which is
already in the above chain, so we can take our time; there is no
pressure to reconsider the chaining of repos synchronously with the
kernel uprev.

And it is also constructive to consider the reverse case: where we are
pointing at mainline directly and a stable (or -rt) gets added/used.

        mainline
           ---> linux-yocto-dev

In this case, if linux-yocto-dev used a shiny new v5.13.1 stable,
without it yet being explicitly a part of the above chain, then the git
objects relating to that would simply flow from the server directly into
our linux-yocto-dev clone directly.  Nothing breaks or falls over.  So
there is no requirement to immediately react to creation of v5.13 stable
or preempt-rt recipes (even though they are trivial).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/linux-yocto-dev.bb | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/meta/recipes-kernel/linux/linux-yocto-dev.bb b/meta/recipes-ke=
rnel/linux/linux-yocto-dev.bb
index 8725473d1cd8..b4b91593aef8 100644
--- a/meta/recipes-kernel/linux/linux-yocto-dev.bb
+++ b/meta/recipes-kernel/linux/linux-yocto-dev.bb
@@ -19,7 +19,16 @@ include recipes-kernel/linux/linux-yocto-dev-revisions.i=
nc
 KBRANCH =3D "standard/base"
 KMETA =3D "kernel-meta"
=20
-SRC_URI =3D "git://git.yoctoproject.org/linux-yocto-dev.git;branch=3D${KBR=
ANCH};name=3Dmachine \
+# When v5.13-rcN comes along, we can revector back to mainline
+#KREF =3D "git.kernel.org.torvalds.linux-master"
+#do_fetch[depends] +=3D "linux-master:do_fetch"
+KREF =3D "git.kernel.org.preempt-rt.linux-5.12.y"
+do_fetch[depends] +=3D "linux-rt-5.12:do_fetch"
+
+GITFETCHREFS_machine +=3D " refs/heads/standard/*:refs/heads/standard/*"
+GITCLONEARGS_machine =3D "--bare --single-branch --branch master"
+
+SRC_URI =3D "git://git.yoctoproject.org/linux-yocto-dev.git;name=3Dmachine=
;branch=3D${KBRANCH};altref=3D${KREF} \
            git://git.yoctoproject.org/yocto-kernel-cache;type=3Dkmeta;name=
=3Dmeta;branch=3Dmaster;destsuffix=3D${KMETA}"
=20
 # Set default SRCREVs. Both the machine and meta SRCREVs are statically se=
t
--=20
2.25.1

