Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.67])
 by mx.groups.io with SMTP id smtpd.web08.19601.1617383778008536618
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=C22VioUp;
 spf=pass (domain: windriver.com, ip: 40.107.244.67, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku60nzvwiaoy7WK9ZGnPITAV1m5SYtzV4FRJDN35w6sriohG5ZJOqVdwu5BWNtFmRHG8yW+2YrErFV/ZpsRxP6+QWgQJc9YeMDRMT7JBl1KzU6ydlBD9KJG9+YavDtSPM/b7OtMZGmKIFSnI1rAfU2QEx9HeUXi9TU/k8nwuzeEqI+kDloi5i6ZMrV1JSP6lUKq3OmtjHDsyfeTytqOH/doZrX/ddAez5f2bwgEGLsXkAtpY4VwTkEqIjS/MC/aM4aZ9C8byb7YTAQNL59LBGPL5opF1uUBaBwUwxjJClcOogdxo3T0QT25SPZcuwbxhkUSGruEUTchXbbo2tSjc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/YO8bsoF220PUsvJxrXtJQ42RFeQ/bezgTMJd65kHY=;
 b=SgmgdKEtLhosisEw0NqSLknVsvf4q7dJIKqwoo0UmUARDbdpxSz1vgaA37vxXUKoP4Zd1EgWv+8ULg8C9weJu6OeoDTdijZi6hn2T/Y5QQnj5AYlHEqFLlSob5XmQKJFCfsz7uUfRnIQQrqbPI5RlvUR/Vptdgv/cxuXBof1gkO4n1QATmhynwQzT51Xm8ECiYa7NwzvJyXo9imjnskvEdPXHCSfPnZE8lcRXOmTcqD5j6DPumdIgyqgxQm5bEB/ZJdUtY6fgS9WaBtpP5KHSuFVNgzuwyuqHsfWbtb1gKYZPRVD0xMyPOMN3ny2n5NgXY6vfvExnWJdwjugNbrQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/YO8bsoF220PUsvJxrXtJQ42RFeQ/bezgTMJd65kHY=;
 b=C22VioUphKvhFNM+AL95HHe4tCzV3a+N1oSC3C2fw3zl+phHIbnN/xEso+nvRtRfn4i8y1vG/l2qW5RCAMeOdclOCo2D1kMB7oPMJdkUvm0PdU5nOEJpa3V9ZulkRRIeBk/iR3WhOizgMfRfslwddnV69lF1R/u0f9RcPu1tY2I=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:16 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:16 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 06/21] bitbake: fetch2/git: allow alt references within download dir
Date: Fri,  2 Apr 2021 13:15:42 -0400
Message-ID: <20210402171557.981599-7-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b0f01d8-16ab-4198-8552-08d8f5fb061d
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB22490FA85ABA07D86B60AE37837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eIpT1uCqg1XL9KPNcgDjoAV4ZzzRQm2sFLP3pDF/4L1WNGunLFJA4xapNEY4l01/arjwaQUS/ql3F1rMBb9giuJn3xLfm6bnYL5YuPUxzkhAUKACbgg+qGKXOdgY15pDYubMrEXbWiwuJqrzac3HNvNWccMf0qqKQyUADMvD1WDCMfSshPN1loHvjIMd6SQtrgLAHSjClRZEaremjQQU4+8BU+HsnzYCPg9hdt3425AI0hVxc91wr+IJa1zRK2QTXWjhwN5qvXcwnT8WYNihUME7qZmLXw2qU1/MWz1VpbHOuMTYnKFQbmgR0DkK/0CTfT4IiNmuvd3Anp2D0QaqiWAC6xJ/l/yreO6GrwjQbvuSY9z/+47lIDyTrpWVZ8BhINB7KtldDW+2t0Srj17Rf3XsBRjmbkKe5H2sKxlvjdsrMAN+4XIXENxLS6++SBmM5w6NkKPzE3wdQ+8r4xZ7ubHj2O/xnSeNcQbtoyqOU6ifexIdW+VhotA1xHGstiMPWQD6QWtHwUYrwpyfFSjAmH5yutj4bdu7YA3zuSqrBm7rO/ADSEk+GJgiXQveng45a4kwRSTLSGvA565FQ1W7HHfx+1nRjjOJ61k1ZFI6VKWTYlrCJphOkWxRg3RM1beOZjqlamkhyPBpxouIIw7HtavfByZoO1HF3RAvXzTwuG1cwQIVps5or9E6Bd7/Sey4M0skVS/yxK6UiFLpjFU4KfyCwx2NOZ1PynjS3JhR1K4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(5660300002)(478600001)(83380400001)(36756003)(52116002)(966005)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?b0Yf6fEoT7PK8AITivFV6rnI1nfZnYNNFJjjQo9NvSzkgrmHeV2TZPCJBi5N?=
 =?us-ascii?Q?1E3wH72rw5u1JrdwKDQYeH2I9rdKfk+aAAoiZmvgkk7JX9IN+fX6xIBjPrRY?=
 =?us-ascii?Q?mC6ZOh/NaHJXQS5KH0x77G10ZMNP74850pRCokS6ebtCdrPEJpiKdOBprWQ7?=
 =?us-ascii?Q?HpKeoiTqi2KzDhPEegkJMaT9tVPaEHlea5IaesXN2RkRCSAU3YZ21Qc7Cv74?=
 =?us-ascii?Q?oxpIrX3J5aNe4sYPDbVUrYZ2/AhtIEBxhhGW52SucZJIsdVFU4ufaATW+hsi?=
 =?us-ascii?Q?nA3xMEsXABFjxFCF6TgLURFgp/dRPFpK/7moxjh3sKWt3GQf+N1jUkvY6t6E?=
 =?us-ascii?Q?+hyS7MZeDMIbNLlqIOThkf2aHE59trCb9mL2hVNvruJqdGHtmS866RrfcVLY?=
 =?us-ascii?Q?Xkv1qW0sZADhOdSK5jwer710iLHbeTP13D6JE0TsFIOeWEQewz4c1alRjgzb?=
 =?us-ascii?Q?Xq2qr+/K08SugyZ3ElyJuSFc0FeKrIFz0khbJcdfFyol8H8PrKD1G0ozWRA/?=
 =?us-ascii?Q?IIqNks3xu8af8CsciDTRP5+TYWmC0zjPadwm548JkXcwMbib8dmJL3uG9EAS?=
 =?us-ascii?Q?wFk4EOexN5zjPyWdWpSigWQot3bJ/Ifpmu4TMYlFk6/r+V+fnyVowE1oHomq?=
 =?us-ascii?Q?4QnhE5KWpV28SfuNeZj+BldREmOBvaPHUrkZilC1UvR1UG18+rAjqPz9/FR0?=
 =?us-ascii?Q?TMX8jO6HT15Ai7xVuuCIOU9Zzk3cSQ1NgE0fSUyBY6L/Nme4/Sd+UEEYwym/?=
 =?us-ascii?Q?lsd9WstOq+tt/PMY7ZbWrZxO0fZghGH0iEIFrykyboBtki3YstG3A8GXx4C8?=
 =?us-ascii?Q?6bpyoOfkvjYYttLM2zS4dlXEoMC6qzdnAFzs8YwE38KoXagc6S0bGg2TzmX1?=
 =?us-ascii?Q?3wTtUcpag+mISz3cTs7H5UXF2COVACR7rq1SrtREyIJuhSX+7peDbmbYG6ca?=
 =?us-ascii?Q?U8/JN7Wd460TZReHZfBrHpZka21gJVUiEHp3N1aPfkYbZZJq61LUV1g7m6lL?=
 =?us-ascii?Q?rZd/LXE7Fwe0/7+tbbJhwhPou54QVJx50vmW84UEhvp8pkL76K9/x/0TOEJa?=
 =?us-ascii?Q?JL+V6nRFgV61YtiS1Em3hwMAOi/jUXYtQZXAfEc9YnVBofwS3C0oPG83U2ea?=
 =?us-ascii?Q?prD4DEUtOFC+3NN4xZ+nmcNaHMKf35+b0W4hNX1Ms8ZxDQn14yP+F97Dwj+f?=
 =?us-ascii?Q?csX5msAsHrQEPEGNn2/fkUXHqyX6mzxHVB4IIHnsJ9agC2FvjlaMJ243lZC/?=
 =?us-ascii?Q?2nWuJUcCNcwxZJaerg8cfoPt9yqtNYancffsAgDnueTfoSRvkF8WbMqLNvVJ?=
 =?us-ascii?Q?xqx09Bk6GHNEkCwAv8ZH/B6v?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0f01d8-16ab-4198-8552-08d8f5fb061d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:16.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9pVP3z1OxyJ6iPEm8AEW/5C8kly+Lyiq9rO7+JzHcmA0H+PE6aPKDGI8cznrxoPvN/JDGC5vBFUR48WlOha4OfWpko7YKmd6GWrPfV+OUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

It is no secret that we've needed to formalize some kind of sensible
sharing between git repos with common ancestry.  The opportunity for
sharing the mainline kernel base between linux-yocto and linux-yocto-dev
is the main obvious candidate.

Many of us have long been doing local hacks to pre-populate the
downloads dir and avoid lengthy/large downloads, and some have even
been kind enough to try and get a variant of that upstream[1].

But the problem is that it isn't as simple as adding a new "--reference"
switch to the fetcher and then walking away.  That will result in
non-portable and incompatible use cases with existing work flows.   We
have to put some thought into how we see this fitting into the larger
framework of things and in what ways we want to support use of it.

For example, we know we want relative paths in anything in the download
dir, but "clone --reference" will put an absolute path in the alternates
file by default.  We also don't want the SRC_URI to be containing any
absolute paths either.  We also want (pre)mirror stuff to keep working.

So we set some basic ground rules.  Firstly we don't even expose the
obvious "--reference" argument that some of us are used to at all.  That
is because we are going to have two types of references - the common one
based on objets/info/alternates (this commit) and a pack based one (the
subsequent commit).

We also restrict any references to be peers of the other content in
downloads - no /home/fred/super-SDK/kernel-4.19-rt/ type stuff.  The
idea is that once you factor out the common building blocks of source,
then your kernel (staying with that example) becomes a very small repo.
For example - all of the linux-yocto BSPs (standard and -rt) can be held
in a repo that is only 20-30 megabytes - small enough to attach to email.

Clones via alternates have some limitations - for example there is an
arbitrary limit of six[2] levels of nesting, so a pack reference is
introduced to resolve this subsequently.  However alternaltes make sense
for shared non-static (i.e. WIP repos) endpoints, like stable and -rt.

[1] https://lists.openembedded.org/g/bitbake-devel/topic/77645766
[2] https://github.com/git/git/commit/c2f493a4  # if (depth > 5)

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../bitbake-user-manual-fetching.rst          |  6 +++++
 bitbake/lib/bb/fetch2/git.py                  | 24 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.r=
st b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 94f4cf3363f6..12a68accc2c5 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -447,6 +447,12 @@ This fetcher supports the following parameters:
    parameter implies no branch and only works when the transfer protocol
    is ``file://``.
=20
+-  *"altref":* Enables cloned ``git://`` URLs to use the named peer from
+   the downloads dir as a reference through the standard git alternates
+   file for clone (see ``-reference``) and subseqent operations.  Recipe
+   is responsible (via fetch dependency) for ensuring the reference is
+   populated/cloned prior to being called on to act as a reference.
+
 Here are some example URLs: ::
=20
    SRC_URI =3D "git://git.oe.handhelds.org/git/vip.git;tag=3Dversion-1"
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 6cd5d09b2ded..e742010229c3 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -59,6 +59,12 @@ Supported SRC_URI options are:
    Once cloned, nothing will change, so optimize accordingly.  The default
    is "0", set static=3D1 when appropriate.
=20
+- altref
+   Repository is to use named peer from downloads dir as a reference throu=
gh
+   the standard git objects/info/alternates file for clone and subseqent
+   operations.  Recipe is responsible (via fetch dependency) for ensuring =
the
+   reference is populated/cloned prior to being called on to act as a refe=
rence.
+
 - usehead
    For local git:// urls to use the current branch HEAD as the revision fo=
r use with
    AUTOREV. Implies nobranch.
@@ -165,6 +171,8 @@ class Git(FetchMethod):
=20
         ud.static =3D ud.parm.get("static","0") =3D=3D "1"
=20
+        ud.altref =3D ud.parm.get("altref","")
+
         ud.dlname =3D ud.parm.get("dlname","")
=20
         # usehead implies nobranch
@@ -380,9 +388,20 @@ class Git(FetchMethod):
=20
         repourl =3D self._get_repo_url(ud)
=20
+        refname =3D ud.altref
+        if refname:
+            alts =3D os.path.join(ud.clonedir, 'objects', 'info', 'alterna=
tes')
+            gitdir =3D d.getVar("GITDIR") or (d.getVar("DL_DIR") + "/git2"=
)
+            refdir =3D os.path.join(gitdir, refname)
+            if not os.path.exists(refdir):
+                raise bb.fetch2.FetchError("Unable to find reference %s in=
 %s" % (refname, gitdir))
+
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
             extcloneargs =3D d.getVar('GITCLONEARGS_' + ud.names[0]) or d.=
getVar('GITCLONEARGS') or "--bare --mirror"
+            if refname:
+                extcloneargs +=3D " --reference %s" % refdir
+
             # We do this since git will use a "-l" option automatically fo=
r local urls where possible
             if repourl.startswith("file://"):
                 repourl =3D repourl[7:]
@@ -392,6 +411,11 @@ class Git(FetchMethod):
             progresshandler =3D GitProgressHandler(d)
             runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
=20
+            # Fix up reference to be relative for tarball/mirror portabili=
ty
+            if ud.altref:
+                with open(alts, "w") as f:
+                    f.write("../../%s/objects\n" % ud.altref)
+
             if ud.static:
                 runfetchcmd("%s config --bool --add bitbake.static 1" % ud=
.basecmd, d, workdir=3Dud.clonedir)
=20
--=20
2.25.1

