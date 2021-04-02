Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web12.19630.1617383773958212525
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=NwrY4mlD;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZylunwD9x5tunXdO16pWSfeNqV33ser72D7jtfUBZJCVQndQid2xg8BioPzPKPlxJk5W5kgy0rjXKwLIa6cdIK7e+Eqyr5A6dMVLZJ/D4hZUWnKw4WGD32GG98Ssqy+8k0sSpaNFMmhSiKMNtfKe9dmrqcn69CFNEsq1hyZJuAlXEc5AE0i1JOT4BXhbE8spLQiAJs8fwjR3Uafqsbk39LbXFw3zAWfr8fWfvPZib9zY9utAhLCWesGVgT7G5I1U6sAvobdp5KIJGFiwKxdbp+K2iUJHAHPka2lPLDdN5twyXKp56hjPDa7SNJKdFJSuUj65FmNiS8lOyqOqIu4bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIhI2H5e7iboQ+mba0ZCgJj1oJdazm6I6GcCLdG1DuY=;
 b=GBjD118f5q+i+y5jP9ixEkfx/jw1GYDF+hRKZhGZ/PmXo72TbgRXZ8mhnWyDvb44lsDjFwA9ANDS33zN3YskOLwexWBnoMnJwfMjFYbjuEVwSdt4TTvIrEQizTilqatW+nJ/fNv/fk+m7EV/QwVF0Iw0Br2WYCLSAQ2wDoG2Im+dfvCPd+YTj64bBD3OrbqkTvisAf0LijkxEIvDBl3Cdiuf1IiZq5gXGXQp3E9NTrbD59UVdtEFTsQMQb9aRDeESSazS+tl/kSxSfHVwveO9gZuQ1RQsrxXnY/cA5ZROLIpTfWJHQbzGCCZn/EEvaP8mFiNqHcgxmWrZ0thCEgXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIhI2H5e7iboQ+mba0ZCgJj1oJdazm6I6GcCLdG1DuY=;
 b=NwrY4mlDS1wp71qWjZf6bN6RsgO5YwGuE7XgYYy66kzquZ3cO9Y8nNwvL3vFhuvwnfo5NpChDqiURxRsOlQFG+CFUPt/5wB/19+i7FrSjElSu8d/G0bxNPlrcBf96nmBd2hPysAVHObKmgF2NbSebxN1wNtHkET6wIgXqYtdsf8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:14 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:14 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 03/21] bitbake: fetch2/git: allow optional git download name overrride
Date: Fri,  2 Apr 2021 13:15:39 -0400
Message-ID: <20210402171557.981599-4-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3c72639-baa5-4296-0868-08d8f5fb04f0
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249B676166F906561B003ED837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i38+hSLXybgKSXJmsMQdZ1NjMS6mobER2ofmb6QgoZHc49c4HDiY0PM1+MGaD1NfE8j2mgHKw7/urijGT37e35+jDHQDlPxK0ek1qomp/YKwH6Ds8+bRwfKGhpNK4PXxnVlnVLQxjinbjQA34nd7kcC0JLsl5uOPKZHo+bB3sLtTulsChpcrpsEBsUZPsbv8ZJgVS+2wPEPveZEtElBRz+OfYRIlHRtCYMvLBXXfzOp1HYw1ztM2JPZoS03nWEg/IBqY79RHL79E3X7ukUPdwuMEuIc/iv3zMpzq4N5+FI4yUnb2OS/2w+QGgmJffIEd4uYnJXznGh3XYxF9QBPTFlgH2OUJSjBErF2LzB6whqrCHLICasrqvE/lHMKXiwmCxZqfMP3ftcjsRZuF+mMN6suF78aJyMWRRFU4EdspMgXjPZbla6Tu6zUV8a0FPu0EeZSRmzVur16DwT8uWrJ3p1+sg3duRzc4p35vB1SRrtdzvdzYTwwVFmL38ONnweit/4gg9YYihaIFaUwdV3vTqTl1nDwS2c1DJ5dzcZ+hmkJNLhBWiYsP28CH4SNU6Ox88lqjSvR6LIk6je1sQds7VRpBdiCSQ6YPxKWmRP4DcxBvuQDrbyF7XW//9+f74KBUOaoRfe483qmjOS18asA2ww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(5660300002)(478600001)(83380400001)(36756003)(52116002)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?kcZk/P3QPLl7MhT4Tej/SPgDg1E9FOx/j9sigYJWt/icr3f+15WgX47jvTpJ?=
 =?us-ascii?Q?AcZd9Kjb9h+Zaz4XlBKq5WOF70rgyEEQ2RbyYujWDhhw6DqJwTtKlBP3Bcr5?=
 =?us-ascii?Q?tAwqeJSVQj50tNN2ELB0CDl7PLT/DyJVMTS1/9P4QE5jzRMiQcGxDeo7CVPX?=
 =?us-ascii?Q?MMINNsyvAWAmJiNrR/7jsOiSAMIuir2N0tM2xzgLOQCtsOHzi5XAfg64J6pl?=
 =?us-ascii?Q?RTURCVKnIOxNvQiMMI9Z67g4iUOD78/bmL5NnI+8UcF2tWrP1wWR1GgtN86Y?=
 =?us-ascii?Q?Lt+miCKhTf7vePot4lq1HG2WOc9GMFjhiuuRW4L5cnxhXKI+i3kV+kZ7qplB?=
 =?us-ascii?Q?fEumz0fFKehdv49xhZ/Jau7uevCaK1VP3nkpjx0/jUL8lzUHXPh6SjXKgGkR?=
 =?us-ascii?Q?t4NyIzc0xnHP9NRLNWegEH3FqdYn57KfhBaJ+FJSp0ABm5n8hQaCrLuRv9fb?=
 =?us-ascii?Q?O+uhdC1e1tDM5nt8iVlWOl5T6qPUcxp7lBS0pBaegsTTf4QGhbXOsmAWQyEf?=
 =?us-ascii?Q?9oLMV70nWpnUH/63/fsdfQZ3u+upvPJlxLYKbwXTJv41ZBUDTn/GJskDfGRa?=
 =?us-ascii?Q?eAlE+jZnxFtW47adNDsyld8ldAuFK1UNasusEZujuNhGEWgb61CaAYknY1Ct?=
 =?us-ascii?Q?i9nau8oucwx1m0jFLFA0UEjfzbYM6gm5tTKm5YAkwWd02zB3uY28tIYCtkWK?=
 =?us-ascii?Q?xrIooMwqrK2VwWBukL/IZtDAUlzIE6EiEg5VMmjjIn2onwrTjNU/1aDmYPmI?=
 =?us-ascii?Q?o+deAt8/hDRRX+xre3dt9oJjwGZkwuj8H8qyGVvsEQalMn8rceQWKdsl6/ED?=
 =?us-ascii?Q?1DnRpk1MCzr4aV6/fCDiLfVG549RmMEfhpVjshKc+NLIxvOAmhiQQlOEQiFC?=
 =?us-ascii?Q?31EqXiAyhCZWDhGU4IkU3FTpecYec8FqcAdPJWFerp0gkBuWIbWShca8EUw0?=
 =?us-ascii?Q?72ODpUjfm3JL/4/sDrX2xs/31HoVlN4sTwv+kcqUrU4uiwpIJDsZigqhJvI3?=
 =?us-ascii?Q?2RE9hT57oN2hTojC1t6UO68SVFbGMAzJzaC5j4F5KfSHq90HZJ+58uz15K3k?=
 =?us-ascii?Q?mE+Oj7HcCBIpJAbhtVXX5O74fwVL+IyayApa3Bgzvvo8PAAAkcGkiVRM5l4j?=
 =?us-ascii?Q?EAmucvv7c3jfeX4uv0D4KBgAP9oUyrwzyiaOM6ZHS5RQWR7c8L35kCW4Rf3g?=
 =?us-ascii?Q?/z8VRg9jZTkN/n1Q69zvZmU3wDP2H0lHFbtARtcYE/RrK0HSwIrx0PH5U+wt?=
 =?us-ascii?Q?+BYCYH2C06ltCrGoklCZU7UwCB+luU2EbuqIg5ZLKqsx/1fLohVdJnSuCyz0?=
 =?us-ascii?Q?3WRUNAPpPLF0j/JhYJtXVUPP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c72639-baa5-4296-0868-08d8f5fb04f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:14.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeEv7w8ILkfzMXXr7E4MuiV3BpONwFB7SylBI2huv4VGvWSVo0IW+DifXEFRcHa7epLb0+w4qV1MIwMNZ1wmkiwpX1RQUbO8+H00t4twRww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Single repositories containing multiple independent origin commits are
becoming more common.  For example the rt development repo has patches
as "raw" format-patch output in a patch series, and also for ease of
automated testing, them all pre-applied (ff and non-ff) to the original
baseline (v5.10.8 in this case):

   linux-rt-devel$ git merge-base linux-5.10.y-rt linux-5.10.y-rt-rebase
   7a1519a74f3d0b06598fb95387688cde41e465d8
   linux-rt-devel$ git describe 7a1519a74f3d0b06598fb95387688cde41e465d8
   v5.10.8
   linux-rt-devel$ git merge-base linux-5.10.y-rt linux-5.10.y-rt-patches
   linux-rt-devel$
   linux-rt-devel$ git log --oneline linux-5.10.y-rt | tail -n1
   1da177e4c3f4 Linux-2.6.12-rc2
   linux-rt-devel$ git log --oneline linux-5.10.y-rt-patches | tail -n1
   96f1ac50158c [ANNOUNCE] 4.1.2-rt1

As can be seen, there are two different "epoch" commits and no history
or shared objects exist between the patches branch and the applied
branches (on the linux-stable baseline).

Since we construct the download directory name based on the server name
and the server's path to the repository, we currently can't refactor that
content into two locally independent paths/repositories in the download
dir for efficiency, ease of use and tarball/MIRROR handling.

To resolve this, we allow the recipe to optionally specify the path
component of the download dir name, so that a server with a repo of N
independent branches/histories can be used in N different recipes (or N
different SRC_URI lines) without overlap or name space collision in the
download dir.  Continuing with the above example, we could have:

  RT_REPO =3D "git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-de=
vel.git"
  SRC_URI =3D "${RT_REPO};name=3Dapplied;dlname=3D.preempt-rt.linux-5.10.y =
\
             ${RT_REPO};name=3Dpatches;dlname=3D.preempt-rt.patches-5.10"

...resulting in the following independent repository dirs:
     downloads/git2/git.kernel.org.preempt-rt.linux-5.10.y
     downloads/git2/git.kernel.org.preempt-rt.patches-5.10

If the new "dlname" parameter is not specified, then the automatic name
generation functions just as it always has done and this change has no
effect on any existing download dirs.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../bitbake-user-manual-fetching.rst              |  6 ++++++
 bitbake/lib/bb/fetch2/git.py                      | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.r=
st b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index e9a5f336dfd2..0f12eaa3a81f 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -417,6 +417,12 @@ This fetcher supports the following parameters:
    is assumed to be "master". The number of branch parameters much match
    the number of name parameters.
=20
+-  *"dlname":* The download name used in downloads/git2 (or GITDIR).  If
+    specified,  this will override the automatically constructed name
+    component from "thispath" for the URL git://some.host/thispath to the
+    user specified value.  The component from "some.host" remains unaffect=
ed.
+    Allows splitting of one repo into multiple independent download dirs.
+
 -  *"rev":* The revision to use for the checkout. The default is
    "master".
=20
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index b54ec76d7174..de698a3d9f24 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -18,6 +18,13 @@ Supported SRC_URI options are:
    SRCREV_nameX =3D "xxxxxxxxxxxxxxxxxxxx"
    SRCREV_nameY =3D "YYYYYYYYYYYYYYYYYYYY"
=20
+- dlname
+   The download name used in downloads/git2 (or GITDIR).  This will overri=
de
+   the automatically constructed name component from "thispath" for the UR=
L
+   git://some.host/thispath to the user specified value.  The component fr=
om
+   "some.host" remains unaffected.  Allows splitting of one repo into mult=
iple
+   independent download dirs.
+
 - tag
     The git tag to retrieve. The default is "master"
=20
@@ -151,6 +158,8 @@ class Git(FetchMethod):
=20
         ud.nobranch =3D ud.parm.get("nobranch","0") =3D=3D "1"
=20
+        ud.dlname =3D ud.parm.get("dlname","")
+
         # usehead implies nobranch
         ud.usehead =3D ud.parm.get("usehead","0") =3D=3D "1"
         if ud.usehead:
@@ -242,7 +251,11 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] =3D ud.revisions[name]
                 ud.revisions[name] =3D self.latest_revision(ud, d, name)
=20
-        gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replac=
e('/', '.').replace('*', '.').replace(' ','_'))
+        if ud.dlname:
+            gitdlname =3D ud.dlname.replace('/', '.').replace('*', '.').re=
place(' ','_')
+        else:
+            gitdlname =3D ud.path.replace('/', '.').replace('*', '.').repl=
ace(' ','_')
+        gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), gitdlname)
         if gitsrcname.startswith('.'):
             gitsrcname =3D gitsrcname[1:]
=20
--=20
2.25.1

