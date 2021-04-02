Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web08.19601.1617383778008536618
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=je6SEdLK;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d02GrVy8inrbUVJRdbjPnB58zDbGlNv44avcNays5NNi4WwnkrePxu+SOgTnwTexDkQkkNTRC9JXvx7jsTRfxe1JWIACBn7O9vfMTZdCWqZ4+V7r7vneesypdM8/klrC7daHEBg2umqt51IhKu3ffkpFJonzcBWjzPHt3du5uMzXv1MkDH5/NuwcRzOVNonwjmOZyCdDtZUh5IppogJLeSFjDEAFGuMi6b3MNXrxeldW5XYBGxv305JJYHP/Ec2y4aQiLaEkKzTnGzSkaRtuZbKw0E9AyBrhjU4D6u74G+zqiFNPt5t2glmU0b1RClOm98KhqHkLMW8IaqSnevntnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS7YhCyt0E9UyKr6FA0BbAIrLjcueaRPqVh75I6BgFE=;
 b=mQDJt5UBLD7u4Ofm52g4mu7Y5Xw6yC+AL55x+mSkZ2K4bLGjBH6zkc3/ikPKYdumL7w2gKp368g0oAJF35GbniPH395JhK5zEGi9awmPHEt76E2RlXJLHg+O9glGM+QvBbQB8bCEpOghHB53930h0CwtSJZ9afDTIlM1uduLuvjAsWnETorYik0jnSN0KUSfTRSEzqZihlkd3LwSNqPqiUAyQXePwTUJfuE1Vl/5s8URWfk0NH3YRVXNF572Js7vzCEnhyJ/JXrdC+Uka/T58ZJ+2gRao0O8rGr08h3iVMBOj4p6ff2kqptxf5LFF/ANpH3/IEZBu67UUQHLhsgijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS7YhCyt0E9UyKr6FA0BbAIrLjcueaRPqVh75I6BgFE=;
 b=je6SEdLKr51SbftCDTeDcVP6zquRAOKc/JamyEGq5wMH4+Z8Rv1+pjsPcCl6uDOUEDg6wFC8gf0a8DHn0ohTSfYOBj59Q/ZDUcm4YcYYP2QWlTQDT9qwEvnGz5tbPMY05+nFYYRQX8Peo76wzIpyrBFficv1XVXp2FWoDfBb/R4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:17 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:17 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 08/21] bitbake: fetch2/git: allow pack references within download dir
Date: Fri,  2 Apr 2021 13:15:44 -0400
Message-ID: <20210402171557.981599-9-paul.gortmaker@windriver.com>
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
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 766d81d0-367f-48ec-4f17-08d8f5fb06de
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB2249E4493F45870337B7B11D837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kk5e9fBny25UyZkS6V8Wz2Yz7vS2YnUK3vwDI3S0tjQ3rEivYKlie229KfhEUBdHSjhY6Mtil+jRDsdwel2yUuVTJW4zl/B6b2VxhvgsQK4BLzg0NN7WV/weyanbgWIqKHeSM5tkrjlcINCnmGcFVKZyS79G0dL+Z6DqOlJMI/dS9ZLICjbJ5sIvv0S6VulaK1zxpZQHt+y+U48vu69meDTs77FmAKH+9yO10/1BCLDylGJ8glUBbX248TXhSLhcLbofpuJR1LbjjjrIXjK36SDduV92FeOmgfqGtasHxf4jggccfTK4QEq8NjudDCQUvPc8L1PCngqKln0TJjbtpV/fhp8taIrA/+u0YJKYvXD0spALcuHHaDhpA6Bi/YlPBPB/omUdXrjA9bTCMHONI3MnYF/BRxr7eFDImHDQIgu5MwbQx+2fltw1u5F4XBHVyHccCRyHEupTRP9gdYBMhy36sdxSBwyWt3yLgVytdRN7Rt9Z3r2Ur0UqJt9giRY/8/z6hd/qeAj0h5GWf3P4POu4pJHzjXUlwPjyjNkroqdv9UQrhOkBS+ozJRGAZGJ9fLs8Ytw5Whi+qn4G2S7oTvdARMZOKEMnpDcUDJ5S9sJ7RWbfoh9FyOa4wTO9MFpg6T2yCbyKcH3eoXuWPTkguzYZxaCe4QU/jMXBNOPJMQGDErVbWv5sjFQ8aZ9+MawB2jaOGaH9pKBFC/fiR5egbqk9Fk/EyQG/pZbdkRIFCUE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(5660300002)(45080400002)(83380400001)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6666004)(8936002)(36756003)(52116002)(966005)(1076003)(956004)(86362001)(2616005)(66946007)(38100700001)(8676002)(316002)(110136005)(6486002)(4326008)(16526019)(186003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?0j2rxnbILD6TGTlqNf5L+wCLKKmo2qpUoBOxHOpZ4gTE+rsC3j/qJn5TbfCl?=
 =?us-ascii?Q?8/qWDuRixevcqQMfF7DKu9m2PCQXbrjudJyc/SSTIqySpYyrK0lRaYe7f11/?=
 =?us-ascii?Q?EA8MqtiFoJy/ZFVxfBaGb0m5HS7WSZMJ1AY0Q2fz5/TtMW4zH4w39UbM4dsB?=
 =?us-ascii?Q?zyyApcxVYCHXO3yvhdZaaSECEsWoxCQY7z2+j1x2O6/dNMCIH+B7APTEnnuF?=
 =?us-ascii?Q?kjVmOaZphD7OwH06KqGMqk7FoqyWBfBDWjaZsLzFqFxpWWM3MWMBDrfbNAQ4?=
 =?us-ascii?Q?opoCFTrHmajK3YCLoxFeo9/HjiXd1N6xULZhWskwJTChLWax+g/utRLTF0gj?=
 =?us-ascii?Q?ye/njFgQMuLSeWwY73BkJBL/bsToXfX34cOSML7Many4qAAYLh2ETz9w34su?=
 =?us-ascii?Q?uJWw+tzpZBXSiYmR99ZgWusm57DcG1RFHYcgPasSL06dsBcOG4U2w7Xa2GPV?=
 =?us-ascii?Q?wkV08rDMjogAIvQNsShafaVmrs6IKSZohJGjOQWo6MIZKeNsJ5+H8SAZG67k?=
 =?us-ascii?Q?V/y0BV6ypz4G7rmG569Sv9CP9E40o/UUETzykk9a1pTSEhw8mCX228paFWse?=
 =?us-ascii?Q?4E6ON2/2pDP1G1qip6rWd6QYvkCIQ4zQNyb6v3L8+ipSBk/Q4TMfeOkx1RPS?=
 =?us-ascii?Q?Ma50qkBSqCSWksRcF9UUbOPurtf59Vx6jA0/DtI86rouxj65RACYDcUnl4I4?=
 =?us-ascii?Q?Mpnyk7XStsxipj+FxPCQ8Tf4upyBSC4WNilTM5s4BhjPtnHSEndFlKoOfb0V?=
 =?us-ascii?Q?VhM+RfhQeBcNZw5l8xCdENaR7ZL3BC/DH2UH0pWQmPCplRl85XuOxBwWI/no?=
 =?us-ascii?Q?mtl8PR538183KKNV214A4o2DBxitPQ+kNdsN8mJskXUVMFImfNpbs8neHjYZ?=
 =?us-ascii?Q?KaydatxYiRl0bAfYHiYQoH7PUin6Qh36GGC3cgl96jDBmhG0wgNXfOlMGmCD?=
 =?us-ascii?Q?iGYKfxrAe6ec8CihaBGp5WAek4XDOO4rHnUgZwvhzAdxrfkBDIT/r87a7S+t?=
 =?us-ascii?Q?OGc2BT4K7/taCVqDFWOlEnFaSfmlwLdXGZbgvuyzAbUuP003ggSs2NCRyI4h?=
 =?us-ascii?Q?N5uqdv5Q3dm+B7PlUlAojMt8G58uCF00IYJi++V1SvuQOga1gyYwiC6YOduX?=
 =?us-ascii?Q?fq+ODnS3bcYQQzfmeyzWvOkNSF4n4mkCRMsM2eMogR+Z6EqALPolLwKrKR9n?=
 =?us-ascii?Q?UVAUR8WV61Hq4PW6A7bdw+F/pQmCRz2qW/sHA57p55XshUvQ+FFP6mzzxwU4?=
 =?us-ascii?Q?GdmiOzI0fmZ4ojBMMQEs8nEHHwqgz42WjpYwm5MKJOtv14Ct5aGHg+ZrZttW?=
 =?us-ascii?Q?Q1OzZ68mydYIKgnYJjS6oP86?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766d81d0-367f-48ec-4f17-08d8f5fb06de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:17.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GdbA2a7KayIpMDB4618Sq8m2p1SOYbV8CebH3Dkaj2AEQCxFNkS5QWcNQaWAdID7neFeIbglnsopKpqsxIIIRllBN7RxuRe1+Kqiw6ciFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Borrowing from "git pack-objects" manpage[1] we have:

   A packed archive is an efficient way to transfer a set of objects
   between two repositories as well as an access efficient archival
   format.  In a packed archive, an object is either stored as a
   compressed whole or as a difference from some other object. The
   latter is often called a delta.

   The packed archive format (.pack) is designed to be self-contained
   so that it can be unpacked without any further information. Therefore,
   each object that a delta depends upon must be present within the pack.

   A pack index file (.idx) is generated for fast, random access to
   the objects in the pack. Placing both the index file (.idx) and the
   packed archive (.pack) in the pack/ subdirectory [...] enables Git
   to read from the pack archive.

As stated, they are self-contained and can encapsulate an entire chunk
of development history starting at point A and ending at point B, which
makes them ideal not just for transferring, but also for sharing that
chunk of history between repositories with common ancestry.

When you ask a server for something, it sends a single pack, because
that is most efficient.  So, using the kernel as an example, lets say we
decide we want to use the 2005 git "epoch" as "A" and the v5.10 tag of a
recent release as "B" to delineate an initial block of history.  We can
grab that chunk of history with a simple:

git clone --bare --single-branch --branch v5.10 git://someserver/linux my-5=
10-lib

and we now have all the history up to and including v5.10 tag in a repo
that we can use with further "clone --reference my-510-lib newstuff" as
a static unchanging library of all those objects for "newstuff" to use.

In making such a clone, Git stores the my-510-lib dir in the
objects/info/alternates of "newstuff" and all the refs and tags carry
forard into [packed]refs of "newstuff".  Subsequent uses of the
"newstuff" repo are only using the objects from "my-510-lib" and they
are conveniently all stored in one pack, as there are no loose objects.
In fact it is a waste of time even having git operations look for them.

This means we can simply remove the alternates file and link the pack
(and accompanying index file) into the pack dir of "newstuff".  And by
using symlinks with relative paths, we get a mirror friendly reference
with no data download duplication.  The "clone --reference" is simply
used as a convenience tool to do 99% of the setup work.  The linked in
pack is "just a normal pack" to the consumer of the commit library.

As such, we introduce a "packref" as a useful parallel addition to the
more well known "altref".  It is ideally suited to reference from static
repositories containing a known block of commit history.  Note that we
don't limit ourselves to a single pack, so that a packref can itself be
using another repo as its own packref and so on.  Hence there is no
arbitrary limit of a depth of 5 as there is with a reference using the
more common alternates (i.e. "altref") method.

This opens the door to insert an arbitrary number of split points between
A and B to fragment large repos, if desired.  An example that shows how
the bulk of kernel history can be split in two, three or four chunks
will be provided for recipes-kernel/linux subsequently.

[1] https://git-scm.com/docs/git-pack-objects

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../bitbake-user-manual-fetching.rst          |  7 +++++
 bitbake/lib/bb/fetch2/git.py                  | 31 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.r=
st b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 12a68accc2c5..db1d108f4736 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -453,6 +453,13 @@ This fetcher supports the following parameters:
    is responsible (via fetch dependency) for ensuring the reference is
    populated/cloned prior to being called on to act as a reference.
=20
+-  *"packref":* Enables cloned ``git://`` URLs to use packs from the named
+   peer from the downloads dir as if they were their own packs of commit
+   history.  Similar to ``altref`` above, but suited for bare static repos
+   for which no loose objects outside of packs will ever be present.
+   Recipe is responsible (via fetch dependency) for ensuring the reference
+   is populated/cloned prior to being called on to act as a reference.
+
 Here are some example URLs: ::
=20
    SRC_URI =3D "git://git.oe.handhelds.org/git/vip.git;tag=3Dversion-1"
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 3b0c068bc020..8aec12df2bf8 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -65,6 +65,14 @@ Supported SRC_URI options are:
    operations.  Recipe is responsible (via fetch dependency) for ensuring =
the
    reference is populated/cloned prior to being called on to act as a refe=
rence.
=20
+- packref
+   Repository is to use packs from named peer from downloads dir by linkin=
g
+   them into objects/pack/ of the new repository as if they were their own
+   packs of commit history.  Similar to altref above, but suited for bare
+   static repos for which no loose objects outside of packs will be presen=
t.
+   Recipe is responsible (via fetch dependency) for ensuring the reference
+   is populated/cloned prior to being called on to act as a reference.
+
 - usehead
    For local git:// urls to use the current branch HEAD as the revision fo=
r use with
    AUTOREV. Implies nobranch.
@@ -171,10 +179,15 @@ class Git(FetchMethod):
=20
         ud.static =3D ud.parm.get("static","0") =3D=3D "1"
=20
+        ud.packref =3D ud.parm.get("packref","")
+
         ud.altref =3D ud.parm.get("altref","")
=20
         ud.dlname =3D ud.parm.get("dlname","")
=20
+        if ud.packref and ud.altref:
+            raise bb.fetch2.ParameterError("Please pick only ONE reference=
 style: alternates OR packs", ud.url)
+
         # usehead implies nobranch
         ud.usehead =3D ud.parm.get("usehead","0") =3D=3D "1"
         if ud.usehead:
@@ -373,6 +386,14 @@ class Git(FetchMethod):
         static =3D self.get_git_config(ud, d, repo, "bitbake.static")
         return (static =3D=3D "true")
=20
+    def create_pack_links(self, refname, refdir, dstdir):
+        dstpkdir =3D os.path.join(dstdir, 'objects', 'pack')
+        refpkdir =3D os.path.join(refdir, 'objects', 'pack')
+        for item in os.listdir(refpkdir):
+            dst =3D os.path.join(dstpkdir, item)
+            src =3D os.path.join('..', '..', '..', refname, 'objects', 'pa=
ck', item)
+            os.symlink(src, dst)
+
     def download(self, ud, d):
         """Fetch url"""
=20
@@ -388,7 +409,9 @@ class Git(FetchMethod):
=20
         repourl =3D self._get_repo_url(ud)
=20
-        refname =3D ud.altref
+        # Both style of reference are the same for initial clone operation=
.
+        # It is the post-clone absolute to relative path fixup that differ=
s.
+        refname =3D ud.altref or ud.packref
         if refname:
             alts =3D os.path.join(ud.clonedir, 'objects', 'info', 'alterna=
tes')
             gitdir =3D d.getVar("GITDIR") or (d.getVar("DL_DIR") + "/git2"=
)
@@ -419,6 +442,12 @@ class Git(FetchMethod):
             if ud.static:
                 runfetchcmd("%s config --bool --add bitbake.static 1" % ud=
.basecmd, d, workdir=3Dud.clonedir)
=20
+            if ud.packref:
+                if not self.repo_is_static(ud, d, refdir):
+                    raise bb.fetch2.FetchError("Pack reference '%s' is not=
 marked as static content." % refname)
+                self.create_pack_links(refname, refdir, ud.clonedir)
+                os.remove(alts)
+
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
             if ud.altref:
--=20
2.25.1

