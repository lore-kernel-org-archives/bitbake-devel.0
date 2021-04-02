Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [])
 by mx.groups.io with SMTP id smtpd.web08.19601.1617383778008536618
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=dZBW7fkv;
 spf=softfail (domain: windriver.com, ip: <nil>, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXjMD9jIQK9qbyjIkdPVapq4YkHs+ychuRmb4b/ARPGBLSMc0hun9AsE+lfpwrdb1BuBPGUK3Dzbd6cyWSShz0WKzH2wk3qITw9O1NvQ8gzcCR+q7tgWZa8p776AiAAsFpgB3CBEOWMDf6amFqlMx9PQPHAiGSYcqCYcBAH6sy/e6ZgZWgu5zQdesNgT6tnGrjl/3VExHSzA0D+kLg2rRgggF5vwMgN1ea5SNrczTS3mXWmPfvtR9UGijFCQEOWu4sYlv+c128qYRWqJzPeNu//mwtLW0x/yxLeC2QZYyFM81EsH30GQgc+HE6CT2AS5VSE0Bp/GEzOwmK40XrCtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEFD3RRL7HFs1hlpSf6/A1mUPRftMSoC0MVAuATFMG8=;
 b=G5eb8+0BTFng//Qwq+YyCVsUeUJ4FLA46NMDrmU4GBXOjdCRg9nwo2fG8lBvv77ELpFcAmrGvsS5CuVorvIRv+yVV8A9uss5xwKRBurN0gofZX0TfZ/suN0kkBzglwX7IbPxoEInZVTSDF+/R6gwdcBY4RqYvhXF0Ps34sc+JsCcq/yIPBtTS6p1iVyAifloyZ/NcTLyfJnMP4M13bvoCVDlTYLOsy6VSxuMWeI1/80Z66ix9Pcp+QxZnxoBItBYLQFDVC3vYoC9nTFMQq35zyxAFunq/l3OXDw9WDzw1bta+7C+jzR0K4suTP5oKK/tbrTM+I7KKO+d+Df4HBy0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEFD3RRL7HFs1hlpSf6/A1mUPRftMSoC0MVAuATFMG8=;
 b=dZBW7fkvOPJLYHtjH6xA1L3ukFGyd7+ASgxMcDNqw+BZpEIVss5mdTbeGxc1boPyqboYf29iuHAplAOlpAhEujtPzHXxYegHxCQ7OBHJ8Zvz29ywbt/DV3G5HqcawVqGt0D9/E/zGatuI8wxZtjV22u9v0XDBlHHFslmVkUNGMA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:18 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:18 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 09/21] bitbake: fetch2/git: use constant names for packs in static repos
Date: Fri,  2 Apr 2021 13:15:45 -0400
Message-ID: <20210402171557.981599-10-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 857ba2b2-426c-44c7-35f2-08d8f5fb0747
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB224908FB2983F5E782447226837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Va+lR4XHgIAA4X4zogHW/DBJ2a60p0GrnTisMOnCOHPlyNW7oO/mp9lhexWBmKa3euRMD8FBBWzAmHiRAuFSvorXPNJ+B3hw4sIQAfzCbdS7W3munjuFP6zpDHasmSIsHKl1iOvEbCbKfhaX9ggUvsFPxHP6bcOASpBg+PRNF5hgXFEu4zyhVbOXFQwzJcrdkcljYbOy0AmpMS1VTXJeg5r4firyYvM2ZW8wRm/Y4rlGb371bEEf5zp9AQheNH1CrbQhovM3AP+8Gq+n5iAbIr8gqrq9vwCyZQuiJXwfJ4mt3gyrebggQdpPuRyTN1sDTe34IDZPuYTkYn/tF/d0YjRoM/eRQIgj76QV0gig6s04gfcWXYQ0ujpskqBoWSJtJm/12XHnAXsX5AdPSuNEESv2W0u1GRpEdVlun0WGALJcAZUmVcJnaWJp1IkJLDC6dWp/VbQiMCHncCHMlz0KX1stu318V4CYH6awt1Fx2wIZj3R2WAFWGyv4YNxk3lj1EYzxJ5k/sEQ2NW5TrzcyLk/yGftf+H89T2O9+sct5prjEBndfEQgdggH3ZTx7UC3qhj01kCrPHhDMUVjuwNKTIl8mfD4h0RCXum4HcxJO8MEEfHAlV6P/sawQsotod2gaZIAolq/iA1A29Zi9fG+gb/VydRm6DSAnOmDN9f1LpC6J4t7WTuETlLsgQFKPYVGNTwxm2srhdMc3goWyXkETF8w2Z9IX5W73sZ2D2hdRCcYkhbbsgftqNVncEVKjfHJX7rp37cp0Ch9jH90ZnAJHcxxiGMntpPUKSFIeCG/rT0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(5660300002)(83380400001)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6666004)(8936002)(36756003)(52116002)(966005)(1076003)(956004)(86362001)(2616005)(66946007)(38100700001)(8676002)(316002)(110136005)(6486002)(4326008)(16526019)(186003)(26005)(2906002)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?qxUQ8F6vqINKetTYqpmtSXLPzF29c93Ejp0n9nUxWWd1pijVpUS9t91JkUWN?=
 =?us-ascii?Q?uMyxDxeSYIlNquOVjEgR5b7fHNlYubIZk7V1S90I3j6CDU0fAephOEhRqXGW?=
 =?us-ascii?Q?lJP2Lv2yxrREKmiF3zHF46epTx93ZY9lYqbS9hA88Ted88RmZ52xdh7qVfR/?=
 =?us-ascii?Q?bcmI0aSDYxJ5xjJ5KAe+994ved0XjBjw9LP7dYRHBamoCJlJh+d7MT31Dve2?=
 =?us-ascii?Q?dprQ3lUykgHvuwjJpzOhuUNOuZsaDb5jVTSlrWve06xU9e4gGh9s+g6cNHhf?=
 =?us-ascii?Q?fKT7km4fFQ5p6TePjtqSIxvumypD8d8eBefFdxrHFuM9z3EE9lTCjYMoMAfN?=
 =?us-ascii?Q?mjM59Ybk0olfTTPI3S2NOPUB0HdyfEqqjHOjoFySt1VCvWrxAC2DnzMVGwSD?=
 =?us-ascii?Q?BkYsXF8imVIMdFpjM3goQVPECfiMuB7EYeVMsTDssvdEAArOK4jIo7Pre1/C?=
 =?us-ascii?Q?avCJulecPKOpH9/J2urx5uCVX5On9bUAMNgeX2gD6147AENMaJ5KZ0mcynXE?=
 =?us-ascii?Q?L270sui1/wgaaTdvcJ9aK7h5G+bFVBs+gdrkLEQ/FkLy+AwabHwRZ6OH/WM5?=
 =?us-ascii?Q?rc/pLYXFIEkPmBhOTAt1HyOHaPKdq0uAkgrhStaPxSJPNNUAfTSqE1DDcqiw?=
 =?us-ascii?Q?tNFAk8TdXQqFm1Kncv0aNykCs/mfDxhTt6xjVLUKdUtYo5qElyV5nJ9wf2y7?=
 =?us-ascii?Q?bApuZ8EE7iT9CrGzJRqYxE3L8DwZ1DF5xFn1paGG/OXhkb5VoN6PQMSc1uM5?=
 =?us-ascii?Q?QArUeKaICpPDW9fmvV1HySRwWO6ltYchnvYW7I62nj9XPxq9oCJTRWG/+Wf/?=
 =?us-ascii?Q?I5s4CE/eY0mt67DfIDKLM2jsC0QzISD6TIlBlQDuzaI4aXS1rkESYCmUQqqZ?=
 =?us-ascii?Q?s31RdP9RsGfmneouLDUKsLAm7vuUlLLkX/AGScVe+SpPvWn2CTdqQznW3cN/?=
 =?us-ascii?Q?9FAH6t3gLYoC9ellLuAUfDb6Jul4iyPgtnYL0Np2wAjMT+k5/7F3KrrnfFJq?=
 =?us-ascii?Q?Uw1led69BhebZunG5wC/nNchXDKn0BxpAVsR6PJjNXgTMLxS/ly69hxJiEx3?=
 =?us-ascii?Q?Z1W+ONVFF2WN7BdWX+wqZqnwPK5QlrR/dw7d5p8Cn7qfIngdpnQ7JhDOkSb0?=
 =?us-ascii?Q?Lht1M7Z+KjVcRvELe5zA0XMNgEdEOtDuvRNFF8K/hCLGAsdy6x6LIrsN98+Z?=
 =?us-ascii?Q?HmzcNUd++/nLp/B4uTSS7whQ+NCAI2jvhcL/oKrFBito7AlXACrTvV+b9XjB?=
 =?us-ascii?Q?y4h1jKZNHfkom57abOK9f/GzI94hYjMGzKbWI1saYYvBowGNpFjsTTO6v4+T?=
 =?us-ascii?Q?AMeiRGifoQpq5mGZRfUpKDTc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857ba2b2-426c-44c7-35f2-08d8f5fb0747
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:18.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iywnB+9wbAU/wf+dFoMG1XQ3T+utL/Bgxc3I83AA2DgH5Gj9+jZJaF3IgsLnUPpKUKtPBuv60fFUz/Hk0ImxUaLF7SZKZwlqtf4yRjOr2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

The "packref" support uses symlinks to "piggy-back" use of packs into
the pack namespace of the consumer from the originator (reference repo).

We use symlinks, so that mirror tarballs won't duplicate the referenced
data, as hardlinks would do.  However, that means we also assume that
the pack namespace of the originator remains constant.

What if one uses a reference from a mirror tarball, then disables
mirrors, does a "cleanall" on the reference for some obscure reason, and
then re-clones it from a server directly.  Will the pack links from the
consumer into the reference still point to a pack or be left dangling?

For simplicity, we temporarily ignored this assumption so that we could
deal with it (and this corner case related to it) separately - which we
do now.  To proceed, we first need to know a bit about pack names.

Most importantly, as you can see, pack names don't really matter at all:

   paul@hackbox:~$ git clone --bare git://git.yoctoproject.org/poky
   Cloning into bare repository 'poky.git'...
     [...]
   Resolving deltas: 100% (381097/381097), done.
   paul@hackbox:~$ cd poky.git/objects/pack/
   paul@hackbox:~/poky.git/objects/pack$ ls -l
   total 191100
   -r--r--r-- 1 paul paul  14250608 Mar 28 12:09 pack-db459c1574c5410a1002d=
8098745daee3a59599f.idx
   -r--r--r-- 1 paul paul 181429684 Mar 28 12:09 pack-db459c1574c5410a1002d=
8098745daee3a59599f.pack
   paul@hackbox:~/poky.git/objects/pack$ mv pack-db459c1574c5410a1002d80987=
45daee3a59599f.idx woot-fred-was-here-31337.idx
   paul@hackbox:~/poky.git/objects/pack$ mv pack-db459c1574c5410a1002d80987=
45daee3a59599f.pack woot-fred-was-here-31337.pack
   paul@hackbox:~/poky.git/objects/pack$ cd ../../
   paul@hackbox:~/poky.git$ git fsck
   Checking object directories: 100% (256/256), done.
   Checking objects: 100% (508912/508912), done.
   Checking connectivity: 508912, done.
   paul@hackbox:~/poky.git$ git show HEAD | head -n3
   commit a7e1bbaf6d7c5d1cf44069419860dabd78c02eec
   Author: Khem Raj <raj.khem@gmail.com>
   Date:   Thu Mar 25 18:11:07 2021 -0700
   paul@hackbox:~/poky.git$ echo $?
   0

This is because normal flow will have a clone/fetch feed stdin of
index-pack, and from the "--stdin" part of its manpage, we have:

   If <pack-file> is not specified, the pack is written to objects/pack/
   directory of the current Git repository with a default name determined
   from the pack content.

Two things to note: 1) we have always been free to choose the pack name
even if the average user probably always takes the default, and 2) the
man page is intentionally kind of vague on how that default is created.

We need to look at #2 in detail, in order to answer our question about
whether the pack names remain constant for the same object content.

The executive summary is "yes" for git v1.7 and older and "no" for git
v1.8+   So we need to look at both in order to decide what to do.

For the "old" git, the default pack name was simply "pack-" + the SHA1
of the sorted SHA1 object names themselves.  If you have an old pack
around you can confirm as I have done below:

   $ ls -l
   total 792
   -r--r--r-- 1 paul paul   1632 Feb 13  2013 pack-a9f793e9f46c138a27abb326=
ac68cb6e6397d0f0.idx
   -r--r--r-- 1 paul paul 803171 Feb 13  2013 pack-a9f793e9f46c138a27abb326=
ac68cb6e6397d0f0.pack
   $ git show-index < pack-a9f793e9f46c138a27abb326ac68cb6e6397d0f0.idx | c=
ut -d " " -f 2 | xxd -r -p | sha1sum
   a9f793e9f46c138a27abb326ac68cb6e6397d0f0  -
   $ git verify-pack -v pack-a9f793e9f46c138a27abb326ac68cb6e6397d0f0.pack|=
grep '^[0-9a-f]\{40\}' | cut -d " " -f1  | sort | xxd -r -p | sha1sum
   a9f793e9f46c138a27abb326ac68cb6e6397d0f0  -

In both cases, we recover the pack name directly from the objects. There
is no extraneous information, like date, servername, etc. used in the
pack name.  And so it is invariant upon reclone/repack, even if the
compression level was changed - since the final result from "git
unpack-objects" is the same.

For newer git, which contain 1190a1ac[1] the choice was made to use the
SHA1 of the data as stored in the pack itself - the "trailer" SHA1.
If we look at our since-renamed pack friend Fred above:

   paul@hackbox:~/poky.git/objects/pack$ hexdump -C woot-fred-was-here-3133=
7.pack  | tail -n3
   0ad065a0  db 45 9c 15 74 c5 41 0a  10 02 d8 09 87 45 da ee
   0ad065b0  3a 59 59 9f

...we can see we really didn't "lose" his original pack name, as the
trailer SHA1 db459c1574c5410a1002d8098745daee3a59599f is right there.

But this means that the pack name is based on transient data like
compression artifacts, and that no two clones will ever likely generate
the same pack name.  If this was a letter in an envelope, the SHA1 went
from being the contents of the letter, to also include how many times
the paper was folded, and the size and colour of the envelope.

This change was made to remove any possible confusion that pack name
equivalence meant binary byte equivalence across two packs, by virtually
ensuring we never got the same pack name twice.

However, in our case, a pack name that is essentially a random number is
unhelpful, and the namespace collision concerns of commit 1190a1ac are
even less of a concern for static content repositories.

So our static repos use pre v1.8 pack names, which reflect functional
equivalence between packs from clone to clone to mirror tarball snapshot
of a clone, because as demonstrated earlier, we are free to choose the
pack name(s) completely at will, so long as we keep it paired with its
index file.

This turns out to be much more robust than trying to preserve the
now random "new" pack names through self-updating symlinks based on
dependencies or anon python or anything similarly complex.

As a final optimization/convenience, we can simply drop the "xxd" from
the pipeline - and avoid introducing new native dependencies, or adding
it to the ASSUME_PROVIDED command list and hoping it is everywhere.

We can do this because the ASCII representation of the .idx hex values
contains the exact same pack object content information as the xxd
binary-converted version, but just in a less dense format.  So the SHA1
of that less packed info stream still gives us a unique signature of the
objects contained in the pack - just not the exact one the older git did.

[1] https://github.com/git/git/commit/1190a1ac

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 8aec12df2bf8..2d693083cac4 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -386,6 +386,21 @@ class Git(FetchMethod):
         static =3D self.get_git_config(ud, d, repo, "bitbake.static")
         return (static =3D=3D "true")
=20
+    def rename_packs(self, ud, d, repo):
+        # Use git pack naming similar to pre v1.8 - where the name only
+        # depends on the objects within, not objs + compression artifacts.
+        pkdir =3D os.path.join(repo, 'objects', 'pack')
+
+        for idx in fnmatch.filter(os.listdir(pkdir), "*.idx"):
+            pk =3D os.path.join(pkdir, idx[:-3] + "pack")
+            idx =3D os.path.join(pkdir, idx)
+            # insert "xxd -p -r" before the sha1sum to get exactly v1.7 na=
mes.
+            cmd =3D "%s show-index < %s | cut -d' ' -f2 | sort | sha1sum" =
% (ud.basecmd, idx)
+            output =3D runfetchcmd(cmd, d, workdir=3Drepo)
+            newname =3D os.path.join(pkdir, "pack-" + output[:40])
+            os.rename(pk, newname + ".pack")
+            os.rename(idx, newname + ".idx")
+
     def create_pack_links(self, refname, refdir, dstdir):
         dstpkdir =3D os.path.join(dstdir, 'objects', 'pack')
         refpkdir =3D os.path.join(refdir, 'objects', 'pack')
@@ -441,6 +456,7 @@ class Git(FetchMethod):
=20
             if ud.static:
                 runfetchcmd("%s config --bool --add bitbake.static 1" % ud=
.basecmd, d, workdir=3Dud.clonedir)
+                self.rename_packs(ud, d, ud.clonedir)
=20
             if ud.packref:
                 if not self.repo_is_static(ud, d, refdir):
--=20
2.25.1

