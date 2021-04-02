Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.43])
 by mx.groups.io with SMTP id smtpd.web11.19933.1617383776013302542
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=V5PKQFb3;
 spf=pass (domain: windriver.com, ip: 40.107.76.43, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kihnQcbYA+uWtF4NiBxVQjWfK4M4IIxG1oZoE6Syx7pgnO8sfgq7fHsgl05rq+EwtiKJJygbs2v0DKUe7ZvhTXVbecQsDcCJkIIdCr5510Wmik58ToJn98kRDZQl3aQ965y8yzt3BrTVaiu6tQhZs9GugbM8gA2t8+6itb5j/ce8F+SOeIlV3FtRBn0/vBosbZ1HKNZdjHI6uIC0qG/hZi2RLoCMPRQRGcVhMzLH4eXfEx5TDGBeIjekNOiAXfHG1C24ubYhvgNBh1wyM/CqjZ5EVkm58fS/6MtdrE7A9kivJl5LCstOHvxmBCP2sJpEVOoYqrzUx1+uHS2unZ47UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EciHTmKYEnWB4pHN9voGaVfL2ho2vo8WhbxHio2wKcI=;
 b=jsb7ciypB6POhn4t3cb2bhTK7ffu5AWNnizCqdC8FxmUrYJYEp8xBGUezEZETZCWWT53jRQUNKWNW9KBFhTEFn8/AoXwKWoCwHD66znSesGvhwlIKy9d+6O1Z3BzSh9/D8SJ5+lT8KxTzYO+SXSoIvaZSahA3bppw7GRsEZBjgPdfIoF0l/bY3COvO8KhY0RejJ+189leUFG7iNyyDWdPU187XLWyJ1FzQn/xW4+0JNRT7vF4AvaRiY1VN4PyXkixzSUPPzPNSi2XmbeMISlcDGhvtWrPjfrjxDP/+AI7C4QWTX2BG4VWznupWSMI/vb0tZVVan2Pt/psJNStTpskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EciHTmKYEnWB4pHN9voGaVfL2ho2vo8WhbxHio2wKcI=;
 b=V5PKQFb3YaIEKdwan6ENiPEJKJIReESzbKbdSoEDVY+uyrL2KKoeJXEMd7Wi+GycnOPzsEr9NlQag5XClae8iEMRQdhPpGw9lrucAavMiurt+GMlh7gsDULrS7AHTkQ3pOLSLbr9ZrIMrxQqX/zZXDmB6ptDcTXvIYfMiIELlVA=
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
Subject: [PATCH 04/21] bitbake: fetch2/git: allow specifying repos as static/unchanging
Date: Fri,  2 Apr 2021 13:15:40 -0400
Message-ID: <20210402171557.981599-5-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd8c9d3e-9bc7-4092-6d4d-08d8f5fb0550
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249488118008C7BFAEBEACF837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BOdWjw8prnVjlaMHcGpNzJKc15n5Ujq87a2GfEMZXRlL/Ta6jT+2NnyrIacBT1X+5e06GvP9PUON3uxiop+jw/LhDW7WZdrDqVmaIQL/Hlo4WjmGpXNHM48JoYXz/iWRjWM84Dl94wGmFcHaAFfKw3tj3FwiRkfXqWaTJbzj632jj7v6gigoO9Acs7fpqMJu1vD0rQrTI4KNGCD4CpO+Dsvo/9S+RmPxD9VsWTrkj4/rWIgkPLS+oaWnpVJBlYP5U+flTSResbVXiGCl2OpQnKrNoDf6JJW9Y6lptO5KwXMjSNtLHl72hhIO3vRQEpx8qbhrQaQovur7KKk1jeGQsknWH+/e4FGu7nqINn6Wa3mGt3N3v79BNcVnEln31JU5F9UDXs/UhpR7OsWJEVGXFTn4Z3I/bELzW1NgzPAkLlYdHpUiEjA2ENwz8YLtp9vL988Fr/Xpyzr0/wlXyr778YJzZIH9l7Nt31c2CriwfhDglxp3e1P7/kKW1c1tiT6guHsOQzbRQ5dA2MYSUb960iM7nE3M6Y27GHlRMwKrxqQ15acnk7ZHvVByAbygGMTS83o0ZS7vs+UpqGElUUjmqfNzNtRuOHJQMoD44j/cezFimLftDzAg93ampChDYOpgy43jGTjMs4inbPrhElG/ng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(5660300002)(478600001)(83380400001)(36756003)(52116002)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?3VvKHwGJgO+gzOyFKEe9/UuakDkMLpKnM4fO6blL9gIbBQb3TYZZaSctMqNO?=
 =?us-ascii?Q?J4O5F9E4MjtlQruFb6EnIf157ZYbIliv0KdKn5kmjw1Da6LmC/pniPD6rQma?=
 =?us-ascii?Q?XmaGjyvrtrc2hpcPF5FUnRFRL1sD2yFYWajvxQTUFw9YiIVDvMhiYdr4uaS7?=
 =?us-ascii?Q?nOaYw4IKHbzQSF61zKNoE1Dr4Yh8L5e2I4vfNGg45Pado0mbN8A9o/FKp8ZF?=
 =?us-ascii?Q?wC9DBsAhsVNjvWvzPG9PY1O7m32fq/V5StEn+oFePyjJoeS9ykC97giMC2lQ?=
 =?us-ascii?Q?S8qV9WIds6m+BBidG5D+mrLLdSaoK3rD2JtbBj/jBAdSEFr/gaFrL+/wyZwn?=
 =?us-ascii?Q?kejjrdwWFwbCl85QkxmRn6kW3jWut/AJ+5q7tvcsJn0HFUnONMfY6lYrkiPz?=
 =?us-ascii?Q?/BmdE/oSfmQVlin85JyHqAn7dU7OgIdruOZRUojWIaShQNnL1HwiRqWXzUc8?=
 =?us-ascii?Q?iYhU/LDu89cDUCKWBlSdjoVcW+EML6xJXinHfafJoRx5/9jiyMSbzAFs1S+j?=
 =?us-ascii?Q?zg6D6YlT1qe5MB101KA8yyGgnyIy0x/AwLNyC+50EG/2z0NKIGkzcdDhWzHp?=
 =?us-ascii?Q?DyDv7dZLHkkzhr3IN/FPos0fEjRb+cxHfPcIPuHT/ab9pqRxmkR0JU7bDzgH?=
 =?us-ascii?Q?HpmsV02zv9pfbJoyYkjB9IAPpOt4h+Dt3jYl46dH39Qof1gbqB9EBvcs5DR3?=
 =?us-ascii?Q?wQxqoJiUrshBl8vTFDpNk/bIlDFNVkiyrL9oRMAlKnQVH87dzH4+Y3wNypmN?=
 =?us-ascii?Q?9yQzgx1ExK+iLAciTQuArwFux4Gg46tr+dy4ExVWdlREujZ1nFRizx/DWAhp?=
 =?us-ascii?Q?OHfRY8oFW9rS4b+YXlLZbnPc66ZgkNEZjYIYW5jd49oqranuuCcQwZmCmeZ0?=
 =?us-ascii?Q?kG1hjIugVSVuLi7fzIVjcwvxL98mOTb8o4hkViusWsXoG9grN7Pd8uL1t+G5?=
 =?us-ascii?Q?0OYlnVD5Sly1ntzkRWQJOQfKIPafNFSTygriVdwc560LYPQLFWTZlfgSk4oc?=
 =?us-ascii?Q?y3pMnrUuosMNrC+OM+Ac4791FBF1dsvKc+L4gpMcTgaB1MZJro9uFLd8NtUz?=
 =?us-ascii?Q?bAAe5R0nuiz0fm8eZHdYcnxq/noq555N/dJmDbQSlKFmksjvAHTP5GEIgca1?=
 =?us-ascii?Q?Ap3pIO1H5fYFkSzZn52ie+QYQqvqyCb+I+iiVZ79VZ/AefDSv5gbACfgMQNy?=
 =?us-ascii?Q?H9LCw/eiUhx5IjeBxq+Jm4E2DGpHzO93IHBcNQg7fjxKi4bwj4WWPNCvF0X5?=
 =?us-ascii?Q?TXzyWX/HYfBj7OPpB/fzwScbgO0JeNZZJEVBa46rpP9Tc2b4b/Ikl3IEKnFj?=
 =?us-ascii?Q?02i/0ts5MlWAzUUGCf+8aHvJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8c9d3e-9bc7-4092-6d4d-08d8f5fb0550
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:14.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mxd/fwLN+8kFXON6mXLSqsJWT/OeiDmdM7SEdcDFxuGm3M8O8cXfoapPE9xn8jW+mBRzE8SdDU3FNpME8z3xIXuXSfw3LD56qiNaRFUkgVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

If we know a repository content has what we need, we can flag it as
static and then optimize accordingly for the future, by not trying to do
any fetch operations against it.  In a way, this can be thought of as
the special case of GITFETCHREFS =3D None.

There are multiple advantages to having this.  We can skip trying any
updates and speed things up for a project we know is EOL.  We can avoid
doing "ls-remote" operations against servers, easing use for
mirror/no-network users.  We can open the door to accepting tags in
SRC_URI more often as absolute references, instead of the less humanly
readable SHA.  Archives that change upstream in incompatible ways, or
have simply vanished, can exist as a snapshot in time after initial
creation via mirror tarball or manually.

Finally, we use the flexibility of git-config to store that static
information in the cloned repo itself, so we can tell at any time,
independent of the SRC_URI, that the repo has static content.

This will be used for reference purposes, but might also be used in the
download dir itself outside of BB recipes -- for example a script could
easily spot any static content and hence prioritize it as a possible
mirroring candidate.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../bitbake-user-manual-fetching.rst          |  5 ++++
 bitbake/lib/bb/fetch2/git.py                  | 27 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.r=
st b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 0f12eaa3a81f..94f4cf3363f6 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -426,6 +426,11 @@ This fetcher supports the following parameters:
 -  *"rev":* The revision to use for the checkout. The default is
    "master".
=20
+-  *"static":* The repository is a "one and done" - clone/untar and the
+   content is static and unchanging.  This allows optimizations like
+   skipping fetch/pull and doing "ls-remote" on servers.  Typically used
+   for repositories that will act as a commit library for other repos.
+
 -  *"tag":* Specifies a tag to use for the checkout. To correctly
    resolve tags, BitBake must access the network. For that reason, tags
    are often not used. As far as Git is concerned, the "tag" parameter
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index de698a3d9f24..7cba990c3be7 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -54,6 +54,11 @@ Supported SRC_URI options are:
    referring to commit which is valid in tag instead of branch.
    The default is "0", set nobranch=3D1 if needed.
=20
+- static
+   Repository is of fixed/static content with no active/new development.
+   Once cloned, nothing will change, so optimize accordingly.  The default
+   is "0", set static=3D1 when appropriate.
+
 - usehead
    For local git:// urls to use the current branch HEAD as the revision fo=
r use with
    AUTOREV. Implies nobranch.
@@ -158,6 +163,8 @@ class Git(FetchMethod):
=20
         ud.nobranch =3D ud.parm.get("nobranch","0") =3D=3D "1"
=20
+        ud.static =3D ud.parm.get("static","0") =3D=3D "1"
+
         ud.dlname =3D ud.parm.get("dlname","")
=20
         # usehead implies nobranch
@@ -167,6 +174,10 @@ class Git(FetchMethod):
                  raise bb.fetch2.ParameterError("The usehead option is onl=
y for use with local ('protocol=3Dfile') git repositories", ud.url)
             ud.nobranch =3D 1
=20
+        if ud.static:
+            if ud.rebaseable:
+                 raise bb.fetch2.ParameterError("The rebaseable option is =
incompatible with the static option", ud.url)
+
         # bareclone implies nocheckout
         ud.bareclone =3D ud.parm.get("bareclone","0") =3D=3D "1"
         if ud.bareclone:
@@ -311,6 +322,8 @@ class Git(FetchMethod):
     def clonedir_need_update(self, ud, d):
         if not os.path.exists(ud.clonedir):
             return True
+        if ud.static:
+            return False
         if ud.shallow and ud.write_shallow_tarballs and self.clonedir_need=
_shallow_revs(ud, d):
             return True
         for name in ud.names:
@@ -341,6 +354,17 @@ class Git(FetchMethod):
             return False
         return True
=20
+    def get_git_config(self, ud, d, repo, cfgvar):
+        try:
+            output =3D runfetchcmd("%s config --get %s" % (ud.basecmd, cfg=
var), d, workdir=3Drepo)
+        except (bb.fetch2.FetchError,ValueError):
+            return ""
+        return output.split()[0]
+
+    def repo_is_static(self, ud, d, repo):
+        static =3D self.get_git_config(ud, d, repo, "bitbake.static")
+        return (static =3D=3D "true")
+
     def download(self, ud, d):
         """Fetch url"""
=20
@@ -368,6 +392,9 @@ class Git(FetchMethod):
             progresshandler =3D GitProgressHandler(d)
             runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
=20
+            if ud.static:
+                runfetchcmd("%s config --bool --add bitbake.static 1" % ud=
.basecmd, d, workdir=3Dud.clonedir)
+
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
             output =3D runfetchcmd("%s remote" % ud.basecmd, d, quiet=3DTr=
ue, workdir=3Dud.clonedir)
--=20
2.25.1

