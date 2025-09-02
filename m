Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB55CA100E
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:45 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=NptdJhN2;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc+xLcu8BKRZd1f3roNhclDGfwVvnfB/qghlzm92OSGMcBQdhbDd8naBPgtJIYAPOi000xqICqbfs8UK7564Baubx14FiSzCIx74fxG3ToL1DOXhx8T1yVLd4OjeGmEUHa1lw/bQGV95I+ZvlZmCfltoBxoDM3lACyojeGcbcrXm+wACy9Qlbizh8D2AjTOohHAjOOeIZwxAD2+YccH/0EdC2TpgpxHc/l7h2USJg8ku/mkof6KpoLBir7KBG+1xIvN3gnQp7igJrA9PZQNtKH1abIbG94ZXPzKVatfO0OBgamZLQ1JeXOlMw3oUX3JXcOseFQFXUuEsCsBchJQETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a6olMHD4WuWr3Nq7dt7IuX85GSa0mWnnLAdml+zh0k=;
 b=TbeIbcNvx34qjBFFrPOj7+r7OP/HCwOVCXID9f6OLzRnjeKac/WxLUf6ybIVZMt9CYsO6T8TEfACjI8Cv/kG9t5alrTO3NhY7AoORBgi9TEwLGJQ03WDsWpflCLwRC5zk5dcw61FOltmz26L8hn0wE+ER1sxAE6SHZuuPsS3Ltx8T8gjZq2UX4nML4bdM0XgMkPzrqR7XDKME2O7Sg2o1G7vPqv5VAQS4hrwp+hm7W3C9vrEJQOpxIwx+eNdFKIZNQf/GxoxAmyMUNYK+4PTom3M+mMzIFkAgqGopenIOv3mb3/pZqAjlC6FuhSvDsaCjTY6Vl7MbLM629BN2Fnd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a6olMHD4WuWr3Nq7dt7IuX85GSa0mWnnLAdml+zh0k=;
 b=NptdJhN2fSZL3/xD9RHHX8FK/rF4rFXP1a3AlMStHkgzmQ/VaG6xYtUCRI/kjoSiBuyFYrPLidXjA7t+/6QTSJWeyIx0z763gSR6HVd42v7V5E1QuuaKFglZ+oIZvHXO4sR8yNUN1FzjUaBGWjUl+h4ul+nuECbnEWihXkTqTpxdMNxODen6RnOxthz5h9Kam8amcWo9z1Z1eg3UFXvy7rF9CjzYt1VQuAZlAq5jWIPjqp5Q5BYX2bkpcMbFfx+4u07h1xAY9IjXKNf0Utq4MvjQyJOhe2bRRqPt2p0ZyRe3HOpgx4pdGHD5vAUIIlWma1o7CijUoVDtehd408stbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:37 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:37 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 03/15] fetch2: git: replace destdir variable with function
Date: Tue,  2 Sep 2025 08:45:02 +0200
Message-ID: <20250902064515.30879-4-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: ff38b2c9-beae-46c8-4ebc-08dde9ec52be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ys/xvZI+k1oN54zR3ME/2R+EPmfpFuodtIfP9YWDssSZiglo9lsvVGPXamCG?=
 =?us-ascii?Q?DqAU4510AjkBfHW4hLxLh3sO+i46IMj8Mah4n3RlDDqf1t/Jxzhx9CUvIwIv?=
 =?us-ascii?Q?OumGNTnmYsXNd3dwvfekGIr/SF375534+fPFzNmfo4aZXRhYqypsKeudUjHb?=
 =?us-ascii?Q?5IHRBLQarT4A33q9Ovr8vN/MosdeAyICV056JLye2Gd/mlRipFV0hmUs5hVY?=
 =?us-ascii?Q?nnV7zvQ3eAvMn6Sg7bV9TmO3OnjyAPod4XytZYiqikrogAMU9LtVplwqYR3k?=
 =?us-ascii?Q?MPGOyX4RWMIhZyPLYH6G71p4ewz45ZUacS7cjm1xMwE5EhVPjwUn6fJC3/Bc?=
 =?us-ascii?Q?sVnysxtZhynz02qM51hTtyfm/4VxBa4BJEX0M1vNlwKV08ur16RhyD7FKp29?=
 =?us-ascii?Q?VumNQWYcNkmbe1LAb+MsuU1JD4YmcFqBFzsJbVx+o6Ydbit9XmIrxs8n2W4/?=
 =?us-ascii?Q?SCkZ78kuAK9OVvaOa+kazCTqeFI7Ll3nouwgm2yGhIXybFTMLtT13OkhmW0+?=
 =?us-ascii?Q?0GbSqtchfEUofJDKupKRWHthSQLNLf+TO2pKoE8U3q4rqB0Md423Ft+TKFhC?=
 =?us-ascii?Q?9vvzO3w89wPS6BGlvrq4lT/d8DQ9Cy0mwesFkSMHt2U5VrJUCFCGszgp1tOz?=
 =?us-ascii?Q?yp+uZNwWpCGgHHJob2iwY3U9wDa2v9orS8RF3CXOuJzYOQWJXeubaDGAYxZp?=
 =?us-ascii?Q?2WLAxFVXJ8adKWD6FhSlHgjsFbDgEteHHRwhICeho8nwOwyoW3mtTnl0Musp?=
 =?us-ascii?Q?WO7f+Y8iv1OqYqy1noMbaglN0zxTYXPxnWof+74JspTFO5uZ5fJw5vWAeR5F?=
 =?us-ascii?Q?kUvHzTjTiUsSB7EVEZIs2ABVkpwCz/lIQzSobGadqwrC6TY2GRE4tJ21t7NW?=
 =?us-ascii?Q?N67CqLvqqMHZbSahNoHps85SISiP3RogVGNwHgYHMiiVZlD0d2z2C00mC8bq?=
 =?us-ascii?Q?nsZ6pH4E2mQyH7WjixlXBA7WsuDENuJOPdsCDaYFIicQ3gSzSUBylRuSV7bY?=
 =?us-ascii?Q?nYKzLYhUTGfcXkOedvNUAx39J8AvI4r83YeN9E6cwbmFGD3E1iie80lAoiVn?=
 =?us-ascii?Q?kZv5mv4PHm9K7Rzq/6PXpqT6xoi31JRYXqUatM3lEPd4gHh6Tfc8EMTc54IF?=
 =?us-ascii?Q?wtShpoEmuoIxSRpkswmFCKDNEZuvYiReohCh9ZNBq4FZwLmv6F0nIywyxiMF?=
 =?us-ascii?Q?FJBjWSryvW3eiRajMXYf1sXJ9PTgvtsCAEjWR8jBqNMrWkX0RXiuX//s4j+H?=
 =?us-ascii?Q?Ox55u6JpxQBzDLukJlZCH+kmSBLJ+taiCe4u3z+I1pWjQhH+7UlvvZic9bxW?=
 =?us-ascii?Q?6Ib+EavSnzzaQCV/9HkbGU9G5H81c0T7oWaWOXPUYpTtNWMycdtH/GxqEywz?=
 =?us-ascii?Q?9GqE0PaMfYSdQKhA9+hxayKqCRnQEJS/lJrUeIeOB/o4QOFcgCrkWCRw8/g1?=
 =?us-ascii?Q?O+vmRJnlMGbGFifKx/irwyA/rwe2ocK1oSKIEt/pWvrAobSJ73JLbw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A22DTy7ho952HThVyrK3Syz3blEgXaxLRo0/6LzumDiYFGEG9XLndZkoEIbE?=
 =?us-ascii?Q?PPkiVb+y7tt7e/WpHbwi5naGgTcLGVsxFRLBttsA98toYdIauSzoWWylcwel?=
 =?us-ascii?Q?Rowq9+KyBi3AqTEorMAUMDeo6vGFUNQGFExtjQQS/nskrfUbjhsQCtsFWnlh?=
 =?us-ascii?Q?Ep5tMRoI17OdMqC4CQm5w1e5spRewWvDL7b58Y/3ziXThFVSrhtYGrN+Kvrg?=
 =?us-ascii?Q?xiCsd9UYUdJ2Fc3yI19zDSR3Hk/BYBTituwWTuQZg5+kBweVTj4dh0pvev+k?=
 =?us-ascii?Q?jaXpBmSxFjz6o3DwsSkSo2PTl4Pk2nHCL993XSx9oyHhMWGopc1m+DB3AIl2?=
 =?us-ascii?Q?sA8yZ2BSweEMe/sbXV6oZIPMtlHcPGXl7Vl7amkjFMxBeI9/g1ZSPhJm4Eed?=
 =?us-ascii?Q?HkqLfylBaPBthgLFYtsY2kg80G226BWuB8gj/WlPN/GVRT139xisCnz9RX6b?=
 =?us-ascii?Q?so7/p4z7Eir0WZwPSM9uqM694hnEVkwKQKJSpLv8lFKA4K1c4uk9msMNJGOn?=
 =?us-ascii?Q?n48u4HENvqm56d6V13pQCTJ4CW3gcuBPwe9vZv0FoqPEV4izpmqAqVEDu+BD?=
 =?us-ascii?Q?JF97VMQM8+kUo4FqG2JPYZCZAR6EUMfmEAXGaCpXKM9k73hrTd+/Qpqta//8?=
 =?us-ascii?Q?rZLZbRiPb+g6aVr2X/0ruE4irC+/MEJ08X8wuzlSUDVggqsKki1CRSMDHcAc?=
 =?us-ascii?Q?n0P0MQ1GhxvtsSt3dNXNXyCtx4HYeNTJd+gyFfvGY8Mw6ZHgyUNO7Msy9DgK?=
 =?us-ascii?Q?XJkv1M/03RWdwQgkMjr+/UOH29aUv4Q3XvDyEk9q8DdfVDFMDTVNRfBWyB/y?=
 =?us-ascii?Q?lwV+Fy6qGIYKo2zmr43YwdUzbaBZ7ozfuWdjVZT88GMhwmDRYC8zJ2hFUhR4?=
 =?us-ascii?Q?UCxnvz0mys3UhKnw7m2mfDyfByYpE8Cs9ckeXpy3bET4Z6kJfceBg+44A6NL?=
 =?us-ascii?Q?VC3X2M2ld9O2S2mAZtz80Nb5uXK9PGoUgqW25ngbcSWUy4FDXHfugjdXJRyg?=
 =?us-ascii?Q?/ZT0xfawkrmpkbJyqOVyeZF79D2DkdSvGasEiJXKLpzzdH+DevMHAMn75+C7?=
 =?us-ascii?Q?PHmUGN+RceqojzA6J9H8kslwZki0nU7gcuqfOn3bZ6VTkmlkqorccVdaZIYP?=
 =?us-ascii?Q?ZBIzFyqKBOjLWM4rFsgG4ytz5iVD/s1GxY11V1lVIBtAVKZ3Sp5Ii4h/tRLx?=
 =?us-ascii?Q?FCI2fYfVmf5pCYt1RQya46T9pzCQCzobCFMFXvhuq6+JHWmbEZMCb5pU9Q3P?=
 =?us-ascii?Q?7x2281K5cUpMDCCJFQjCDsbLQZ71qO8ZCqNiRIeT602aTtB00ZgYtjv+Elqx?=
 =?us-ascii?Q?cFE88plYRuUqtsooxIDj3updHZYEi4MDZk+L7iUJ2RFtRlLBqRgyc/FN1+v9?=
 =?us-ascii?Q?3UTk+j0e7LcldrOGd4wNdy1I4dMyh8+RkqVL1MYApxKFkaI2mnzfRprckaXk?=
 =?us-ascii?Q?7KQ8Pb9YeGZ1QMlVPB90rIKSeUXYoqdxXqlLI46uqxp/9+mrXfAYqak9DXhb?=
 =?us-ascii?Q?7X14lskNVYec4S1rZ7KArXP6o2MlkAuBy0/bMdUFQdAlYiz56wp50LIFhZFP?=
 =?us-ascii?Q?y+1/hbYM8ePT0LKZCtgOfs+y7kJ69yc37eRPdThH7xZRscmdJ+FtKtI1e3/3?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff38b2c9-beae-46c8-4ebc-08dde9ec52be
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:36.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KHCnwU+UO/QuxExA2kD3Qa5PP3StDc5MARuLX32bjGsiYIYxkKyN/7u74P4nzQ85PNZ9PPnJs42i5wtth90ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17922

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The destdir variable of FetchData contains the volatile value of the
destdir parameter of the unpack function and is only valid after the
first call of unpack. Replace the variable with a function to make it
independent of the unpack function.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/git.py      | 25 ++++++++++++++++---------
 lib/bb/fetch2/gitannex.py | 10 ++++++----
 lib/bb/fetch2/gitsm.py    | 20 +++++++++++---------
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 52fffe21d..6d3bc3447 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -656,30 +656,37 @@ class Git(FetchMethod):
         # The url is local ud.clonedir, set it to upstream one
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quo=
te(repourl)), d, workdir=3Ddest)
=20
-    def unpack(self, ud, destdir, d):
-        """ unpack the downloaded src to destdir"""
-
+    def destdir(self, ud, destdir, d):
         subdir =3D ud.parm.get("subdir")
         subpath =3D ud.parm.get("subpath")
-        readpathspec =3D ""
         def_destsuffix =3D (d.getVar("BB_GIT_DEFAULT_DESTSUFFIX") or "git"=
) + "/"
=20
         if subpath:
-            readpathspec =3D ":%s" % subpath
             def_destsuffix =3D "%s/" % os.path.basename(subpath.rstrip('/'=
))
=20
         if subdir:
-            # If 'subdir' param exists, create a dir and use it as destina=
tion for unpack cmd
             if os.path.isabs(subdir):
-                if not os.path.realpath(subdir).startswith(os.path.realpat=
h(destdir)):
-                    raise bb.fetch2.UnpackError("subdir argument isn't a s=
ubdirectory of unpack root %s" % destdir, ud.url)
                 destdir =3D subdir
             else:
                 destdir =3D os.path.join(destdir, subdir)
             def_destsuffix =3D ""
=20
         destsuffix =3D ud.parm.get("destsuffix", def_destsuffix)
-        destdir =3D ud.destdir =3D os.path.join(destdir, destsuffix)
+        return os.path.join(destdir, destsuffix)
+
+    def unpack(self, ud, destdir, d):
+        """ unpack the downloaded src to destdir"""
+
+        subpath =3D ud.parm.get("subpath")
+        readpathspec =3D ""
+        if subpath:
+            readpathspec =3D ":%s" % subpath
+
+        root =3D destdir
+        destdir =3D self.destdir(ud, root, d)
+        if not os.path.realpath(destdir).startswith(os.path.realpath(root)=
):
+            raise bb.fetch2.UnpackError("subdir argument isn't a subdirect=
ory of unpack root %s" % root, ud.url)
+
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
         if not ud.bareclone:
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index 80a808d88..dbb74e35d 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -65,13 +65,15 @@ class GitANNEX(Git):
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
=20
+        destdir =3D self.destdir(ud, destdir, d)
+
         try:
-            runfetchcmd("%s annex init" % (ud.basecmd), d, workdir=3Dud.de=
stdir)
+            runfetchcmd("%s annex init" % (ud.basecmd), d, workdir=3Ddestd=
ir)
         except bb.fetch.FetchError:
             pass
=20
-        annex =3D self.uses_annex(ud, d, ud.destdir)
+        annex =3D self.uses_annex(ud, d, destdir)
         if annex:
-            runfetchcmd("%s annex get" % (ud.basecmd), d, workdir=3Dud.des=
tdir)
-            runfetchcmd("chmod u+w -R %s/.git/annex" % (ud.destdir), d, qu=
iet=3DTrue, workdir=3Dud.destdir)
+            runfetchcmd("%s annex get" % (ud.basecmd), d, workdir=3Ddestdi=
r)
+            runfetchcmd("chmod u+w -R %s/.git/annex" % (destdir), d, quiet=
=3DTrue, workdir=3Ddestdir)
=20
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 5869e1b99..d9ebe8d18 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -205,14 +205,16 @@ class GitSM(Git):
         self.call_process_submodules(ud, d, self.need_update(ud, d), downl=
oad_submodule)
=20
     def unpack(self, ud, destdir, d):
+        subdestdir =3D self.destdir(ud, destdir, d)
+
         def unpack_submodules(ud, url, module, modpath, workdir, d):
             url +=3D ";bareclone=3D1;nobranch=3D1"
=20
             # Figure out where we clone over the bare submodules...
             if ud.bareclone:
-                repo_conf =3D ud.destdir
+                repo_conf =3D ''
             else:
-                repo_conf =3D os.path.join(ud.destdir, '.git')
+                repo_conf =3D '.git'
=20
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
@@ -220,7 +222,7 @@ class GitSM(Git):
                 # checkout dir
                 new_ud =3D newfetch.ud[url]
                 new_ud.modpath =3D modpath
-                newfetch.unpack(root=3Dos.path.dirname(os.path.join(repo_c=
onf, 'modules', module)))
+                newfetch.unpack(root=3Dos.path.dirname(os.path.join(subdes=
tdir, repo_conf, 'modules', module)))
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (ty=
pe(e).__name__, str(e)))
                 raise
@@ -228,28 +230,28 @@ class GitSM(Git):
             local_path =3D newfetch.localpath(url)
=20
             # Correct the submodule references to the local download versi=
on...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, wor=
kdir=3Dud.destdir)
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url=
)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, wor=
kdir=3Dsubdestdir)
=20
             if ud.shallow:
-                runfetchcmd("%(basecmd)s config submodule.%(module)s.shall=
ow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=3Dud.destd=
ir)
+                runfetchcmd("%(basecmd)s config submodule.%(module)s.shall=
ow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=3Dsubdestd=
ir)
=20
             # Ensure the submodule repository is NOT set to bare, since we=
're checking it out...
             try:
-                runfetchcmd("%s config core.bare false" % (ud.basecmd), d,=
 quiet=3DTrue, workdir=3Dos.path.join(repo_conf, 'modules', module))
+                runfetchcmd("%s config core.bare false" % (ud.basecmd), d,=
 quiet=3DTrue, workdir=3Dos.path.join(subdestdir, repo_conf, 'modules', mod=
ule))
             except:
-                logger.error("Unable to set git config core.bare to false =
for %s" % os.path.join(repo_conf, 'modules', module))
+                logger.error("Unable to set git config core.bare to false =
for %s" % os.path.join(subdestdir, repo_conf, 'modules', module))
                 raise
=20
         Git.unpack(self, ud, destdir, d)
=20
-        ret =3D self.process_submodules(ud, ud.destdir, unpack_submodules,=
 d)
+        ret =3D self.process_submodules(ud, subdestdir, unpack_submodules,=
 d)
=20
         if not ud.bareclone and ret:
             cmdprefix =3D ""
             # Avoid LFS smudging (replacing the LFS pointers with the actu=
al content) when LFS shouldn't be used but git-lfs is installed.
             if not self._need_lfs(ud):
                 cmdprefix =3D "GIT_LFS_SKIP_SMUDGE=3D1 "
-            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dud.destdir)
+            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dsubdestdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
             url +=3D ";bareclone=3D1;nobranch=3D1"
--=20
2.39.5


