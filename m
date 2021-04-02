Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.56])
 by mx.groups.io with SMTP id smtpd.web10.19480.1617383784768231124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=N/4ugfbV;
 spf=pass (domain: windriver.com, ip: 40.107.244.56, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMwDzZlKRR4SGM5np7tpQQwb/f9Zdr/UbAGeNofTK/ZZTELvTKbJksFVddjxH9Qh3O8c8Qd/OuqCYjNNw0bKyPdMh1IQtbZA8Dzo+UloeVM4Cq0hnGFidJvWyMwfkEudCUXIlD0psUx3k06FU0AXNM+VRfVgo2EMswXlugLatWcXSJeeFD/IjwPfk5eg8yWgTnIpAOEbDjne7IyYIR5LYsJxNm7+WMlpc95CUWGxk76f70xTvgtdi52Vq9qY1yiSFE0Zp37tZhDcesHDdqYeCe/yvVvQbjtkL23VJ1ZCEOErvNb0TC768R3yxRjkcLZ2klvkfaZ+LsalJZHzTMkzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b45Wss75KrWwVoT65ENN7IV333TH0LYP3BZDrHgFM6Y=;
 b=NSIgLYlyOTrEVuG2vnF++Lgy3dHnsBi6PiA0VcPqfevro0cw98NbXBwdTXKsdOaD0HuEviMuKHODROA8HDOc3XembW1uxdUG6tgdcx6H/QAryA+/OgR00wyt5zfpxC113FnnFWssgppQtsvVOjJhwy3Vu6UjawVtZtcDdTpqpz5pNolJr/s2ESyfaYRaiSW+4ByhONnA8sEHamaraJd0Fmz/fcOpvMKflWlpa+eZUb4GKlJ6XiaTZvQ/RuKNwo8FTOFFG2YLNHSBU+KsCYBMiMXA1gdzA6527aGAPai/a9ncvqLITSU4yrJldXzchNCrdaTDI2kvmtHLaACX9eJXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b45Wss75KrWwVoT65ENN7IV333TH0LYP3BZDrHgFM6Y=;
 b=N/4ugfbVd2BpWbuTXrdDdsl2RC/YtUVFCAEuQmzmJeaKMnqUAegLogUO/mIsZq/u0m+NQm3YVu701mLJANMYCQkQCwmfALESKZoNsz12T/jVs4Uw6ZNZ3e1zlhp8qecfQwaImhu4OQZ0PgoI0P+T2wQhq8S5A2JbRey0tgEeJug=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 17:16:22 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:22 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 15/21] kernel: add recipe for linux-master (mainline latest)
Date: Fri,  2 Apr 2021 13:15:51 -0400
Message-ID: <20210402171557.981599-16-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: de8d87db-e39d-4845-7374-08d8f5fb0999
X-MS-TrafficTypeDiagnostic: DM6PR11MB3532:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB35322D9E475290DC613EE3BC837A9@DM6PR11MB3532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s0z8UsVNazcBS0TJCfkYJuLVEveDZEMjfSf+JoF0gVTezsBEXVTE4N1OLY6Ys7v5VkWdyRywDJtYSy1fAL5IKlJNC03V1C/tK9mnG+rxu6ETOvMF4sybbiUAS+ZzYP+a6uZTewQgaap9KupIN2HoCLKOHEyz9tlGse5YWKB3efzC7T7iLLfzOTQ/DV6tv9xcR/s2QqqCu8GU9KHvcmzAfsSl9bNaftTBXcsDqYl9fhAR9Ghe3YUjbxnWZm7YkYBVPa3TcxJ/7Oh+y0gdGnO+5mRjrF5jkUxec0xNZA0zWcJJliuL9NYtWvR601SKH7WH57/Mqv6pGYpkp0EphRGOTQtSoZSm/Xi+2MwIXKyEAGpCcSIDYc7F09uP9whmjq6IKa1a7yYBMevcz/5y8ktKkdTep0Ww4vG8ahvl+uZ4U09FE9nCiA9cSQv2GpWWWZeykChwGjbVt9xTQLcRjtoQMmxVykl5Jqrlw7RGuYZ37xOTv+EgCk8d8BgKT7OAvKaQCSTJiIAhfPLQOez8k8EGpBlaNr4D/6I4H4pKAQG0pt7HjL3ymQ/F9L/XDyKzrclVokgVsD1HZ6Y6AjhtSmAeBL/PbH/HtnlqwQOUOMs9lqBvFpGxLK1E9dOOIIjXhCZ5cyUZ8drDLJvWRfZsAVMbnw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(186003)(38100700001)(956004)(2616005)(6512007)(16526019)(66946007)(66476007)(66556008)(1076003)(316002)(8936002)(110136005)(478600001)(36756003)(5660300002)(44832011)(2906002)(52116002)(6486002)(26005)(8676002)(86362001)(4326008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?sdmO0mIs/o4C9P9XKZLOGQiatoQAMkm60gJ1i/5CQJd4o77lM5p8I5zXsqHw?=
 =?us-ascii?Q?mAqa/0ckalMnmUAdxTjQVUf0QxCbd0rRpZZ3ClqZ4MeBFw0z9ff58igFF3qO?=
 =?us-ascii?Q?EzZAXD6nYn56PkxYOR/PlCwOarwsGBpg7/rTUTQycTmE/xNs5wJksonPsU0h?=
 =?us-ascii?Q?jAE3owH3fKZ/xiJViuyS+r5COakrABy0OG8CQ1Kh0z0/HgnXeuzpC2bEFGL3?=
 =?us-ascii?Q?KfaYlbPAOa2WbhPUVL0RJEEAaJhUvnUh/VIrq4ZU5yHYzz+3XSMNyAEUNEh7?=
 =?us-ascii?Q?anCnmHaB6Fuby8CFMH3zfEnhBf1mcy0J9QYYhF8ynwt6n2pevngwSuq9236T?=
 =?us-ascii?Q?Y6rKI2RUUwSC84Nzf872qgzyvpOLwt0zmYBqZxy9RxQf+eSuNXfNORZQwHcC?=
 =?us-ascii?Q?rkhmSEjVSMH2fFyVwzt9AGYUI6P4HAQjdywty5yfGA5SfrD/63TOg0rm4D/U?=
 =?us-ascii?Q?amfo1ZAuKTAjd0G6giECOKNQNWjHMMk7CAdISpfsQmzoto1B4nwJ/ZPpPhhn?=
 =?us-ascii?Q?DJoqa3vXcVCOA3Uvhiv0eT2yJKJSX06+gRfqbWegd5mrHeNVfcE4mo9BceZh?=
 =?us-ascii?Q?OoQh8iB1QFkvNV+EGztjZhdM0L/QdFzOwxVz72mnXMLmI4tKyMYybUa5ddes?=
 =?us-ascii?Q?YNF5iZtkRmFrSPBsrtyv9Ap0PBQInNsgeK0catRcI9YjkzLlspJN9bJlaCwI?=
 =?us-ascii?Q?ESclbi3CRstu864taDU4KD/OBDdjUwTLl/+CwLv22fVRVeahXXjnEnfgY/x/?=
 =?us-ascii?Q?rrUsfaHnGO9ekZXagrzTLOC/Y3Im4R+7/OM4Lrt9mMYAdTT4x7thQSJTuJLy?=
 =?us-ascii?Q?qbmooZUaJzHz6Ct1YJ4mjC0iIry4VP57N5B43aaIvX+qNLWhgy5hhz7fhb+E?=
 =?us-ascii?Q?rHNdQbLwF8pGtUT/zz/ZtDGYg18yFZa6csmTdeb+4Cjc4IOxdYzb9Nf2Q44O?=
 =?us-ascii?Q?rOZulDaEFZbD4Vjihdj1RtRkzPvWSxuF5VZC8MDlvnIhshWCatZnlFtHD3yZ?=
 =?us-ascii?Q?+a2f0v2WEzkGG7MRMI1g01A9rKYaaN5qHOM6sL/fXP3g1diM69Cb6CX6tH97?=
 =?us-ascii?Q?D2EUgzN8MqqySvnoNcGQaLmQ5uwuxS2TmazvdZHG2KaW+JeM6CK2eFGbBSi/?=
 =?us-ascii?Q?hDYSwz2aOIUe/C9WqHDXMvTwhnvJ9+PHbL48vrd8Bl/SBHxiykVtgra+vFsh?=
 =?us-ascii?Q?/tvk4kR/6v727shXZcvG1EYtWYpdVnSc4eZymErSnfruAwUEeoL2yNTwwslU?=
 =?us-ascii?Q?EI40vxJymZGQlhvomP0b0dpZ10twe25OFpatp6G+OHTWFM2DDy6czb/4X0X6?=
 =?us-ascii?Q?vwZd8hNk7QDVh5YSk3tY+moY?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8d87db-e39d-4845-7374-08d8f5fb0999
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:22.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29xyUC5t2V32TvNvAdyC1XetbMfkjwxEaVIuj4J7rz5+pE3vBGkTNR3fdoIShvh8OIl0jaYS+Pe3nmHZC0tQBAckAsMlw3bGb2sDCb3SdW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3532
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

The idea for this recipe is to have a name "linux-master" that people
can depend on as a reference for mainline; today and ideally for as long
as we are maintaining it.  While the recipe is there for everybody,
the obvious user we are creating this for is the linux-yocto-dev repo.

At some point in the future, we'll carve off another chunk of post-v5.10
work, mark it static and put it alongside of v5.10 and let this mainline
recipe reference that.  But use of this "linux-master" will be 100%
transparent to the underlying backing store changes.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 meta/recipes-kernel/linux/linux-master.bb | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 meta/recipes-kernel/linux/linux-master.bb

diff --git a/meta/recipes-kernel/linux/linux-master.bb b/meta/recipes-kerne=
l/linux/linux-master.bb
new file mode 100644
index 000000000000..f674c2562e81
--- /dev/null
+++ b/meta/recipes-kernel/linux/linux-master.bb
@@ -0,0 +1,13 @@
+SUMMARY =3D "Linux kernel mainline source"
+DESCRIPTION =3D "Fetch source of the latest linux mainline kernel"
+
+LICENSE =3D "GPLv2"
+LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7e4=
6"
+
+DL_NAME =3D ".torvalds.linux-master"
+KORG_REF =3D "git.kernel.org.torvalds.linux-5.10"
+SRC_URI =3D "${KORG_URLBASE}/torvalds/linux;rev=3Dmaster;nobranch=3D1;dlna=
me=3D${DL_NAME};packref=3D${KORG_REF}"
+
+do_fetch[depends] +=3D "linux-5.10:do_fetch"
+
+require recipes-kernel/linux/fetch-only.inc
--=20
2.25.1

