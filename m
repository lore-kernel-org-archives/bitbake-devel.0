Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web12.19630.1617383773958212525
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=KVWs1M/L;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRPSaIUDjBnhvp+LcM5zFoReiy5zPZF26qLDmOD9nqUi8JEfaPY6MHmuTWnAIRZGAPnO902Hjg4D8dvxtmALcW1QXFdVC5/Szz47EbttikVWOT0CBBhodZB1AUf8Lo8Bi4wUha+aWNFOYOsFsn5v2tlyW47wKXkWdHLDhDFatv1TR+ISmJNjY6Ne9jLNOSE4nnTwsP5RnH4HoldSthLrIJRjcIPVZQaUgU11WS+Axy/HQvbOZYxCBH3+t4CQ6N3UzXhS4LF2s7hzbkMIUCPoF9jCPIeSoF6an0S4QHrGEkaANwxuDGWp4dXBrNMTlG8ZqJEI8+VBGxgV6hFfQaZpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfBe7U1ZqL7aJ2eRKH1+JellMzRmdarsvZfn0IOCzPI=;
 b=bVGAh5i0nrY8fdX5VcJaceRL7EyqeJAYY2z4iD28/Ae4uJtdNXmoYgDgMKg3KOzod1sopt1YsFQ8ekwD6yGLdp5XBcA9SCIp1TNYr4x3oCdQeNiVeEormaH3yiutdRtdgbGnn7QQgbx4Jeo1y9gB9F8xCeN7yRmJyr4RnSpKRXjfy6pVIZKRGYNXI+6mi48RD5gryiE5lE67ZxV4YUJE0ETFnUAuKiOQTSOADx2sdLwR69mYvRFG/jYzY8e+EtK8IXWJhjC+2u6x5e4fJeVqHCJVy1/regJer00pWJegIVoeon34HdhgwF4AUnr0QtGIaJhV2bFLOweEHlh63ea6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfBe7U1ZqL7aJ2eRKH1+JellMzRmdarsvZfn0IOCzPI=;
 b=KVWs1M/LF1uFtmv53wq8+9j9LkaQFSH7zu3jygxvhlQGeEQAnz+4WtFeYz6GI1IotZWDwsbhhnbYC/VAudScluMtbBaAPxkOkCrgvj0WZv7lWZIjPylGVrSnyhbSD1+rcWpTHFkERPOq+cVAW0IAQt9VLvNrCv0UteSYi2l5tbY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:13 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:13 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 01/21] bitbake: fetch2/git: allow override of clone args with GITCLONEARGS
Date: Fri,  2 Apr 2021 13:15:37 -0400
Message-ID: <20210402171557.981599-2-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3177bdd-7a61-4d4c-bc78-08d8f5fb0420
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB22497EA12650E22D04110082837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Cjr/Kh+ykKlQJzHnu/UlFr/hzsT9LzKzGVSqxMMj2tK4bDynLmGV2mZfr2qo0mPVqCuPs7FNAXpKyo+ZhcOjT1PtRR0g2Q+AHA+YoU7rcOWjUTYM77Yh1ZzEmMSfFq5p5qJMkgtonFztN363OYwVg9v4ipGHc3FwCqv4h4VrG7pCXfVvjMrwfoCKM2tK66eX5h03JLahqKtUODPwCHdOzSm7KLaIBq0iSehkKjEuYNbkBD2DkxzgR7pHaybzqIb6lPrpntb4dDBlWDEBXXKoY3xOJEcSyVeFrUOXKA0HbppDF3AaJXVyXHNhQSisG7pvrRB4FMDkZM6hA88OJg4A/HX7A/QutCRqkHhtD5hvfrLyu1C5gT1l2cdXh9tIKTNhjAg/7m3JwqPptfJzrSHj4lPbciyRoDOF6GN9tf3pLdzM2YUQDKqOeWnVbp0dhC1AQksjiSo3JdijdmejQP/ANcbBqYO7HA+MU5JVrbq6ffPBePQMz40ZQ3BAcCgn25L8zz1ST5rWE/uU3kZzaz4eKp0g6DsFVgpt50sCaezdpLzaUurThIDCRTm6u7CyYfUqSNxOZCLeKWkAtguppMwUWKObRdkZkrFNeBxzm87T14KXXQBSHpIOXivqheH4XnEMecpb3EwD09jxoOYOzJ9Caw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(5660300002)(478600001)(83380400001)(36756003)(52116002)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?CxHIJR4GEb8cuCBEQQQFPH2mn++ZM7ox7Ta9WWqytwI82PWrK54ZU9AlPuKN?=
 =?us-ascii?Q?Df/hENEuGWSCXV4lgjFLb+4SiPg2Q5Fqzf9ID9wboIUFJWmwRtl7ZA23eN6Q?=
 =?us-ascii?Q?t0UrV7g5zHtQz5g6ia0NKyh+zZmWNhiTKX+gb+UgClt1c1wPh6HEmJenc42g?=
 =?us-ascii?Q?RRvw55IvAE0L7Ira8l1zahfa9NskCVn33z2qiG+5R7onD8C0C+s2cTkYbxyD?=
 =?us-ascii?Q?q8xIowzGBtgsf1Vp8PVaLh4I9kEg++HL2ueRGhFZAFtQYzIf5AV8DsAXvLbD?=
 =?us-ascii?Q?gTOHwzGOvj75+4PC07oHR53Cep/F8gq8TyDMIVrK8bx2uq8Bc3sMzXuq6aU2?=
 =?us-ascii?Q?qA4dJj1D4MoL6FzSMYZUBFnDSwT6AO0sEdVB/TXizmXSokmyIU7sBkYygAIv?=
 =?us-ascii?Q?joSzClJJZN87bfZx/kNdGcVgvTv/QB4h4pI08FI+TWt+o2odsVdXkcbtwJ2d?=
 =?us-ascii?Q?412LhPty+u7OpR5SAOLURJHgY8Fs18xQf2DVHxFH6LP8oi38sNcS3T+aQpUX?=
 =?us-ascii?Q?f7VO01hswzudORsB9Elez3BScX0h4VPEvq59fSUgAm3MU+J89e+PNZ0/tmdR?=
 =?us-ascii?Q?dn0NDXphI3lmo5TyuloFjK3XpfYj4rBcxlVEmYfp/gaqLHfJeYELvbpYSMxU?=
 =?us-ascii?Q?7iMlGQoUEFrTc9k/T7u2uedzNO1fouITQDjVXf3nBCY3WktwTg3W+qDG03+G?=
 =?us-ascii?Q?JEuXMEHOBq+3prH0X/27qZ+BnrwIg8NDwJ+huaMZ3Ib1SCil8BzCWHcKvSkz?=
 =?us-ascii?Q?om6l42p24wwfyHZhMmuAxnXtBHyIbu9o9IXjP0jfXoulu272lzaIjOe9uvQx?=
 =?us-ascii?Q?vV8erRcRIjaR/FCI6G39eAOox06Bxj+qndDwQr60a+GKnuEzRdmUtJTNiaYz?=
 =?us-ascii?Q?ZCo03TqBbW3cH3CanwUNqDc/JnbxOtPbt72Ytso0v926jL4smrjkJWB1j5QK?=
 =?us-ascii?Q?z/Asbvxo1kNHRtyeLUbr8I4eRFFwaJDXfwexqbz9rdk7K2jihg8gLafbiG2d?=
 =?us-ascii?Q?qkDrFq86UyBksoWFJpQ5HmppAHxZbPPhYrV36zW78YzzRg/dJRRF+M8BWBwu?=
 =?us-ascii?Q?9ToT2RSh2zIn+kwYpVTv/MvPDGdhSAr8E4l71usgoLuVV5sEFt3oVcrYkqrh?=
 =?us-ascii?Q?r9zMgy5b5RDS9Fzglmwezoj9l4/mmhO6w7gQ40XNEFF6LSTHwm29Oieb8Dg3?=
 =?us-ascii?Q?28UdLYv5/EP96jya5FD0t8VVpOcPughzuNmlY1mtNxEhJvOspMYGHg7VumZi?=
 =?us-ascii?Q?m/txKnG3AjOySqoqXSdedH30UrFO5yw5s++UkRdTpZyZtlhRN1oFShR+2/Ds?=
 =?us-ascii?Q?3Jl8e85GUlzyPQxOofM5GZad?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3177bdd-7a61-4d4c-bc78-08d8f5fb0420
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:13.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+m61qjnptK2pjIxhar9bEY3XIlKYW1o6EOf9XaiHMnTswWsfxHSA0Rxi5y9TwQ1AFLGiAnKlNKbbyen3hCuSjWIa2STZAuUN5MY44SKQWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Currently there is no way to avoid the "--mirror" argument when doing an
initial clone.  This is problematic in that there are now a significant
number of repos out there for which we want the content, but creating a
full mirror clone isn't practical or efficient.

The two most common examples are:

1) Repos that have "ingested" another repo with no common ancestors - we
see this in "stable-queue" and "linux-rt-devel" repos[1] which started
as repos of queued format-patch output, but then also added the baseline
so the patches could be obtained "pre-applied" for easier automated testing=
.
Obviously, ingesting all of the linux history grows a repo by gigabytes.

2) Repos that have gone forward in time in a direction we don't care about,
say for example a flag day event, where everything was rewritten from C int=
o
rust in one massive commit, or where a merge of a giant wad of orthogonal
history and/or binary/proprietary content "pollutes" the repo.

In both cases, we can solve the problem by using "--single-branch"
optionally in conjunction with "--branch <goodstuff>" in order to limit
the cloned content to a specific branch or tag.  We will only get
content up to that point, and any commits/ancestors leading up to that
point.  The clone is fully functional and without any of the limitatons
imposed by shallow clones.

So, in case #1 we simply choose the branch we want - raw unapplied
content, or applied and tagged (and perhaps signed) - but we aren't
subjected to downloading both branches.   In case #2 we simply specify
the last known "good" tag before the upstream went off in a direction
that we don't care about.

Note that default behaviour is unchanged - so this is an opt-in feature
which won't impact any existing recipes.  We also leave the door open
for it being URL specific via <name> since we know we have multi repo
SRC_URI in recipes-kernel already.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py           | 3 ++-
 documentation/ref-manual/variables.rst | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index e3ba80a3f52a..22281e2cfb98 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -345,10 +345,11 @@ class Git(FetchMethod):
=20
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
+            extcloneargs =3D d.getVar('GITCLONEARGS_' + ud.names[0]) or d.=
getVar('GITCLONEARGS') or "--bare --mirror"
             # We do this since git will use a "-l" option automatically fo=
r local urls where possible
             if repourl.startswith("file://"):
                 repourl =3D repourl[7:]
-            clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s --progr=
ess" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+            clone_cmd =3D "LANG=3DC %s clone %s %s %s --progress" % (ud.ba=
secmd, extcloneargs, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
diff --git a/documentation/ref-manual/variables.rst b/documentation/ref-man=
ual/variables.rst
index 0310429bdcab..cd2b77604e87 100644
--- a/documentation/ref-manual/variables.rst
+++ b/documentation/ref-manual/variables.rst
@@ -2649,6 +2649,14 @@ system and gives an overview of their function and c=
ontents.
    :term:`GDB`
       The minimal command and arguments to run the GNU Debugger.
=20
+   :term:`GITCLONEARGS`
+      The arguments used to "git clone" when cloning a repo from an
+      an external server into the local download area.  The default is
+      "--bare --mirror".  Use of "--bare --single-branch --branch foo"
+      will limit what is cloned/downloaded just to the branch/tag "foo".
+      An URL specific GITCLONEARGS_<name> will take precedence over a
+      recipe wide GITCLONEARGS setting, if both are present.
+
    :term:`GITDIR`
       The directory in which a local copy of a Git repository is stored
       when it is cloned.
--=20
2.25.1

