Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web11.19933.1617383776013302542
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=WZKo5PeW;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPbWpSNIOUZHlW1TJjE/3V04LPxa4gwOZrnWAPLDwsemcIyTp2gTy7iHkrp7iUfcKiXkB/JYGqEZahID4FnHO/uj9cs9ur/LdnHJnEh/FaVSPmJ5UOGHo0f0MSVqGTfpu+NeC+v2YiT3T+fGRjTLVIlX8odRH5JKwqn8Rvaa4RRR69mLwEbgwsav7pQ2U0Q+8lnEsnIHMMjORWayD3G3cnqmcf4IiwozzIlpyeHzadhawgiDfpveWkBxOECYEtN+TUR695aIVkbybuEtJf/rGmb95sTIUfjHyqLaPdG+miXQJDy4bOtcMxwyMQifIQA3k6EEjvdRjyz9e2hnE7tulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YSA4v+J210hftRPPx01Vz6QHRT1T9BsTSldFSgBTvQ=;
 b=bfBbe9HfUGVttVepa86lLySLXLPBclUq8QDDPBFdHZg3hv6ZTOpqeDqS6RV0C1N5gEOoarHbNlQD4tRTx3af1i6xW3OiTBl3tqAu210RdUsaLCyaH+gSj/l9wpqKjxr/ZBhtjwp5Ao3zdyh8xBGALVnI//TE1aoJdNChtNY4YQuU32Uc4NlnbrJ+UwZzscZhG9UZYUOTFJ+Rgz5hRtQ9oew2sZYFbXi85WBe5Kamu7/lvPqLJIUaOemwwvGqL7OcXYYpf8ryKKw0r9ZBG+s9RsD80mrvugFMj8MP/8hNAGEHo3QahirlMUyJzIBxdi9eKDjkqqW8Ft2PDhHiKZI2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YSA4v+J210hftRPPx01Vz6QHRT1T9BsTSldFSgBTvQ=;
 b=WZKo5PeWAHkWM/9eEnnV1R84WfIHR44+/maCZLgGHunZ+PSi8TcAY04K1/jBLq78bR6an8AoRf4+OQeOQ8hS8sCQbjWBUMULgqAEdxdxbDbkDevSIfQZUrKJghqupvpBEMnSArVxlkFLTpWuDDNtYrVIQ0Y754s+1yQCuHvEBh0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:15 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:15 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 05/21] bitbake: fetch2/git: ensure static repos have at least one refs/heads
Date: Fri,  2 Apr 2021 13:15:41 -0400
Message-ID: <20210402171557.981599-6-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6929105-2ef0-4ae9-5dc1-08d8f5fb05b6
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249200CCEF058CE66A52F68837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ic0pbdaYmHJVChQVaSptxBVH4bF9hRrIKclR4F7+nuQ6XJVHR4gynk6biKTvoSY1wH34/I9NTjGvYz+mXHfO8nfsR8YxiKi2CZN4N9paURxKTFtemPZ5Qa+5gd/JF7RjGYOvpE9RcVbYdnxyttaaev0Ras2umVA+p1x1+EUOUGAekPdR+xu5xZFsRX4JG4txM2lOtnfkhXNa90cJLehPu6EyHhp/knxY6+NZuAHD/wOe4rKClXl87aE5N9/wXBFs0JwbdrlP/ulAs3L5nuIXjeFDtoLSsvSibHdgar27LobDxCK8QM3ueDIABAUFeT+xeQOZ+0AViIIGq1G+VnX0I+Gj+cVCsAQ+RrbRZQTU/6sH4CcC+4MO6XheTVvoTz7HFRZuhzb/oh1GPnde4/760QcCyvaSsmMZujYaCSga81yMTKNPIQX8rpnpTxrP7ggbXDy+G9+1c88MVFMEd1dX2DwebcN82WsW70OP7mIA3HUBCMcoeRbA+gvQvHXzMBLKVdXJAyVPpjXaBl4zWuHq1td555DszStjDXSHUAxfP8gl+Ic6SeO1tElf6WvC05RTZG+ZY1a2HHHR2U3BbAxg4O7Xs2znoBqRlBtUrZikGyHAtl75u5DmUL9Ni96Xg6PbtimTYA/xyVnr1fapsI+pMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(5660300002)(478600001)(83380400001)(36756003)(52116002)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?3gKizCjCbgN/oC0s8DhnVJkbMm7eQEqtyUTu8VN96oFTCk5qmblGSJX4cZ4Q?=
 =?us-ascii?Q?4NxPBldTFQVRtZrb5TPw3laOrOK7GMxCW9+pRqhw0qyjTE6Ci+t8+eS7UGy9?=
 =?us-ascii?Q?mNfKHaFhtAaOqHVR3k3ie6EpGDTIwW6pT4ZUAO+NbrDUpKiU8OFnvgW18J5w?=
 =?us-ascii?Q?DGNOwtBpcAxrZofyzqznWY97ZljAdQLjp60ZLPFpjg6FEcCq9SqOluICNWS1?=
 =?us-ascii?Q?z7HiLGcPtpdwU8bnBtCnIBKecE7UYB3dtQDdSlwfq3GG3nAIrVeNdko+TbfS?=
 =?us-ascii?Q?l0lxYX2u9WIEnYMAMulGEwMed0FJB/hot044bl9zNx18FU+YVxb96pYOGEg1?=
 =?us-ascii?Q?3P7L/YVMkEuUEHj7KzMs4Yu4Gjf6GJtVKzhUqUugf2sadMYSJTmd35zKW/Y5?=
 =?us-ascii?Q?FrNST6BnySDXRdTJ8O0l2mZupIU6WMcXPfUOJM9ZWj4C73IdeuGCPCVOAKei?=
 =?us-ascii?Q?cIQNKi6nNgp9rd3Im6KiRkb40Ld2cLSjskORNVwsMkVyWzzdId+axzIPG1Rc?=
 =?us-ascii?Q?FTylgqKDYnFOdP1u1j7hGPvd3tTN4heaJu41O8oAuNxUJsPEHO9ydovOdE1U?=
 =?us-ascii?Q?4fqenSAvzVtv1X4ZuoRWYZstXFRKFUZd5qR/Xx3zJ9/HgNOCQCgGy8bB8nx2?=
 =?us-ascii?Q?PnKJPIYMBT0wmRvntLWRlt9W+Pgg8FiR+oytfjAPmB4ihvAQ/WOt6D5IJM/a?=
 =?us-ascii?Q?YFTx9x6tdENx3I6aJogaUOaxaLHyfnCst7FNv180MNSHtP5O4/yzfHSiDfBS?=
 =?us-ascii?Q?xjGe6EkqvgwqL7vLE7BBKu84AZfZjpWFbtv6nvcx/xotEiwtuzMA09s3Iueo?=
 =?us-ascii?Q?4V1hx2qcMTmCC0HbE9r1yS3Lja8XT2rRRfFhlGU7Z7N2rR3lIhjCorl6JWQR?=
 =?us-ascii?Q?BLVL1TFACefhibAQqXKOSoaBx3/oV3TGg9Fcu7QjMeGShq/jlHsUUErTcUZA?=
 =?us-ascii?Q?MS0hO59k5OQdJhNmhrZibaIU8ezlR2r4VtHyRLRhZGZ75IomYu+C8MjlT49P?=
 =?us-ascii?Q?o1aE+MCPS+u9g7DNkNIx5e7m35WCcj/Ki3iGvRzIE54fkcFAs5Q2B/+IpAE+?=
 =?us-ascii?Q?zJJUHXFoD2xPrMkxsfIDW1xlse7EiyC9vXOjyl1oliW4eufiuwxpHRbpQs9l?=
 =?us-ascii?Q?4CCkTXbvRlFfb5n2fML7dueWn51rgAYwiHh7cuxELTHDIJLEemrNGz4mWVVx?=
 =?us-ascii?Q?wB8EB8NFxH7K/bUZzSjQ9VV+IoNEZWvd8ZQrYDxUAFT+blZ4h5bdGJtaZwDC?=
 =?us-ascii?Q?H7Ir526JqGUGeIlzW2yHt2tAO47hoEEZmWXDActPJHv0KWp+XcBgUIbJTfp5?=
 =?us-ascii?Q?33hCMC/HkYdPjkb3dh9WfFn9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6929105-2ef0-4ae9-5dc1-08d8f5fb05b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:15.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3HgJju3hTdi9gidQTxBJkG4gaOC8FRfrs54DJWsIntum00lp6n5Q0Ynm7YY6ofVWtVOp1Iw7DcgMdqhHemWZpRPrAbbXS5hh6h+L2/qOgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

When you clone with "--single-branch --branch foo" one of two things
will happen:

If foo is a branch upstream you will get a local branch foo and HEAD
will contain "ref: refs/heads/foo".  Output from "git branch" will be:
	* foo

If foo is a tag upstream, you won't get any local branch, and HEAD
will contain the SHA of the tag foo.  Output from "git branch" will be:
	* (no branch)

In the latter case, people tend to assume it is some kind of indication
progress was interrupted and an error happened.

While not strictly necessary, in static repos, we point master at the
tag that was fetched if no branches are present, to avoid confusion.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 7cba990c3be7..6cd5d09b2ded 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -417,6 +417,15 @@ class Git(FetchMethod):
                 if exc.errno !=3D errno.ENOENT:
                     raise
=20
+        # fixup "* (no branch)" from "--single-branch --branch <tag>"
+        if ud.static:
+            output =3D runfetchcmd("%s show-ref --heads | wc -l" % ud.base=
cmd, d, workdir=3Dud.clonedir)
+            headless =3D output.split()[0] =3D=3D "0"
+            if headless:
+                runfetchcmd("%s update-ref refs/heads/master HEAD" % ud.ba=
secmd, d, workdir=3Dud.clonedir)
+                with open(os.path.join(ud.clonedir, "HEAD"), "w") as f:
+                    f.write('ref: refs/heads/master\n')
+
         for name in ud.names:
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 raise bb.fetch2.FetchError("Unable to find revision %s in =
branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
--=20
2.25.1

