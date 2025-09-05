Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC64CAC586
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=m96DEGBc;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuKs5pYPR0TwD+ZFadE9RetokotzPgaBZWEjHg9RkJDw7skB8HxoEVBAQM7D7gsMk53ICk8ms2HjBcWFRNVt6uSdDQgL7tiJpvTQdyOJCPoP7K6l4rePKlwQ8MLyFYfYjepZ88/2JU3EMCtT0/3D1WH4atBbMzoUfnqX1zIQhLdfKkiREVY+2wftgBY69Qy48gtnzDS84rTNpbxP78JkUEMZsP34mTBR32OHQhHDSy7m90/Y3wAE7HzFw2Tf1WczkwtrnqXY3mUARwDPv0uUUYSC4WW2VLqrSrtUgHkAE2ogTnYuSnP4BwZYNi1PIL5xGyI1qW2GOHPnd3mh3hkVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2/DaQgm8ceDMMNT6cw1z+Y4j1nLtSWvhhU2pOP+lmE=;
 b=OtTk0VomJZ0GYYfBXVR1K9IQHUdxWw/IHBiphSrChnCjKxVvifOLrttB+wT1Q+l//ND+BmumsI+dBUG6DXOw/Rt3QVZXPfbKH/9bhSPbbtjMUYag2CJbwHizbO46xYXNGEtnH2cGdlFnov1hunbHftMsAtxCIDTmTDunXypRToBFsYNQrht21KyqLf/iKu2AiG/NIEc29tlsmPpNqIGW548q4R2sW5vmGuT2CS90MiwvI55JgkD1K0edQ9FuhBYe2dfZYeAXpFDLBiDfHruC+8dInRs+lAE/sH47aJih36UKkyaF3e8n1nDuQ6OOubGlT6lK33pJGC+zDcnGF/r0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2/DaQgm8ceDMMNT6cw1z+Y4j1nLtSWvhhU2pOP+lmE=;
 b=m96DEGBcO+b0perIfA6jOSt1Bpo9NC194FnDfltK626T47OvgepJD9w828+tEwRWRI9jI3Jyy7rVDSGGYxEYS88TQ9kSaPoRS1PsZWnfJSICZF/SDsKZDalurwOTxKwhQCy7RnrDlWL4wHmjyXv+9sNlb8fTPSd9wTFc+Xv5/v94jeK2QrrHORHjAZXGNaE+IG9iU5vVJLk5eiwN1zs7Oo7hSTElyglykH/2BYdZo7F9v5McS1MBk2s2/uAz45bpdZ7l8BfJXsTHwfzkqvU64tJ/cvIQkgWMpjGxe+s/5ztmmgIujzAS4wA9222W6uq4khK+i6OnCaxitiZxy6yAqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:10 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:10 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 03/15] fetch2: git: replace destdir variable with function
Date: Fri,  5 Sep 2025 08:20:46 +0200
Message-ID: <20250905062058.2563806-4-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: acd933b2-818f-413f-0365-08ddec44682c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mqmeBlQNe10dFanSl3B8DFrUPr2mebnWF5kf1H5jlurTb0POvS8Q+pamPMfN?=
 =?us-ascii?Q?McltWBodpjdY7F8JpxRf2Qnw6r+BRegiXJKDJuIq9/oS6sqEGSvHpYR+u09t?=
 =?us-ascii?Q?bHhShc6CYjnaBRmoXvujrikIiU8PbZqyGBuLPaBQhsXuuHDyINRhi2zARNOV?=
 =?us-ascii?Q?aWspRU+1GP6iMjYHTOeHeNjB1zeVFIiaiDUAKvKJsMM0SnaiFMKKGfgcUD+5?=
 =?us-ascii?Q?R7x7fSydkKBkiSAaJnPx6gcJlqqQMFGV5wlK8/KFXt57IQlmxpJ7RO/2R6Am?=
 =?us-ascii?Q?hKN/qgd8D+dGPgX3m5r172P+f93cUVfP2MwF/tqFl9u6x+Odtbjx7SNvtwqr?=
 =?us-ascii?Q?KEWJ1R9dVuE0pXBSf0HkC8JDQp6Uj4cJsoH+bv7KFpLlkWKFaR9MRzX9rAQD?=
 =?us-ascii?Q?ea95vBt6EnQGViWKksZLDgSToLb8bT9Dzb9md/IGGohA/pp7jc1DjTeVTg/B?=
 =?us-ascii?Q?Dh6Zofb2aGn30WxVBv1D3cRW2M2GwwctELUXvjHr9J+nZCcq6oHQe23U2Kzd?=
 =?us-ascii?Q?Z1c5JFCkEEuLKgNrNLpCCzfgvns6Vh3C66nASx77r6MIJHCEQ9QTD2lHx6DI?=
 =?us-ascii?Q?WJkCuvlyBvzkpb2ORJ9J58USmulE/w2Y4PkxxITpUZNq0OWDZQ+zC40JOnvV?=
 =?us-ascii?Q?srdh6kvqTn+e2pIEqmIWCbwxeF0gzCo17JfTjZD+PLTVzqEGQOnL3w+EsA/H?=
 =?us-ascii?Q?CxPAFZYIcmau7bJufYuurOYaAk6hlfIAWts5MemK1pqg6c2EuAtxkmC6lhF0?=
 =?us-ascii?Q?yrxT+CFJTnglmQ2FzaVVgKk2x3gXkEJIUqgKTAxHU+uku32GJ325h8fe8l1+?=
 =?us-ascii?Q?8NLo0A7HNf6U5LU7HQzfgL+RMTyqk8omwFH8vJyp670f3qbjB2DhCAH6wIOk?=
 =?us-ascii?Q?ivVd0gpCTXeYmwVao+XNTPdXT+t0g08R6t5hai3fJnRMboI4neCioHKe6S+b?=
 =?us-ascii?Q?aLQMn4wYeODp1JNIPUuBmHdTajZdMX5kQHJf4mh5FrscvC7BdR2a4BFrAi2X?=
 =?us-ascii?Q?pc7NIUlq+YNZSQLR9Bg0k+zFg3s59O1cznuWG4M1pZp/4m8qYcuP9+ncLEME?=
 =?us-ascii?Q?2J9VbDFUVW01aAwp/M4oD5/P74MQy4JwrY08zTffWs+Z5z5UECbNeT20W5uk?=
 =?us-ascii?Q?l4eUylNlW/RWHonFxY6HC1mJdF/UUdwcoI+Fw0H9jm+Lp2EavgLlV83VD0CD?=
 =?us-ascii?Q?LCti2gPU1aWcybpvl+yXkGQv8ArpiMCUK4XqLOES8+w4e/TMrSU8D5+3/KNG?=
 =?us-ascii?Q?BWPpzsBiErWWUM4Xu8tEx58CHvnh4wswzKjqea7FGgGAgpLZuLG54vpSO9gl?=
 =?us-ascii?Q?f/tDOS5ZB0ZFGBq4znk5aZ6Apzm8o5TGivSStwO/V9+lJ/mw9G5oELBxuJ+A?=
 =?us-ascii?Q?ZiP0qeIMtxZXowSvcY3a/HJAcUJng/MhXE29FLGAadlbmL/PFq5eF8IDZp6O?=
 =?us-ascii?Q?sqDKhXzSB4D3kDCOC0wlHUgRbzJfuIm3dZcHqdzjs7ZN3B9cemC0IA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1OaEiZwcBoUwywjuVWehg13cV5g9iCOegA2/i7RtWaXUX/9m1kkZtWrQzKcl?=
 =?us-ascii?Q?7o5KD0Rsk24Q/UZP2VNOclSZgwq4yhmsQGoLV6AGSlH08LhALjBOZj+AI1ao?=
 =?us-ascii?Q?Cx7BtkyIfzM4M9BQhfxUt/IRvJE5w9EAfPJzJ6OmX0jjfXBHmR3lau0e+tUI?=
 =?us-ascii?Q?sQP2iRe8AL15FYkt9GXc64+Y4OeN/PkrD80d6bw7zKrinwMbfIUcHkgiHHGe?=
 =?us-ascii?Q?uIxwe7OePSBdtovd//Ot5ZAf+2Nfwtl6/2HdV1PcrPFVd1ofmajRfZYw0qGl?=
 =?us-ascii?Q?+QbcfNiZoPkR9Fr7LMI61BaVzvFoFujxgNcZgQinmShEAOT+Z0DIimfjzw4X?=
 =?us-ascii?Q?dTyBvCbQjEHhdmqaGpaIvKfIzRBr4oa7auyhkaKxa7D62KH5rRK3W4e823UW?=
 =?us-ascii?Q?L6zgUXqc2jhlAAWC4BtVDO0S8BA+QISDASHbYbsZ0+48sWaweN6RmG/6CUDk?=
 =?us-ascii?Q?DQyXD4yo7jKLs/5n6Z3Xzh5EzAXoadt/DswpomvdX56vwN2HsC/HcPePJwAX?=
 =?us-ascii?Q?yaisls2sgGHnMFXDDgEdtu6gS8/GwQKisiUz1q57pp29cJgLZ65RMz96i+nN?=
 =?us-ascii?Q?Zx6YtQ3RKJsnfcSvjJN5XnpAn+bHhfjTpr5fA3cV2mKDuRxHpmZdoXeTufke?=
 =?us-ascii?Q?BlAyU2brEBB7fQK4QzornvdpTBiMhORlOdHOlVoKuPPSEJ2xsEUmoGur3U/l?=
 =?us-ascii?Q?ieXCzH+MmcybGTEEBkVI/KTBi0NvifdW8WQdcAqOXdfbXaVpWfSRQKKVHj4j?=
 =?us-ascii?Q?uduPRmwR2zo3Kwz+FUtK7rWpdhj/BGkL4OX8PS7DWqqoY2V5qstMlFxu8Z3o?=
 =?us-ascii?Q?S8Xkw5CJZ1pp2pZNLUJixi6wHRftrvNP1PRvURehD3jqzefIlG1iTgg8pRWp?=
 =?us-ascii?Q?8kjZ6gSO/y2KHcmNTRe9v+k2tiEIz9axAcfC5wpyVKPDOBgcRNBrVS1wB+Dq?=
 =?us-ascii?Q?sEVBA3HgI6tAB6BnzzXZY1JjC/sW++XAwE1R9GSRIxS8lIcaAMwW/iIvXysd?=
 =?us-ascii?Q?gU/wqJbDg0IM6WGZ7mITUvjGDo27OPN9hYittiD/70SEE34i3e0LgFNfmBUs?=
 =?us-ascii?Q?9FjRcmUUoJQ2vHHCxLUiaygeM9janfVYhqNBmjHbb1E4+U8+ROpeUfeAqQsj?=
 =?us-ascii?Q?tR+0SggjBGpwzVs6g9EihCGR33ffCp9DEjo3ihOx3gQBO61IA4SO0jvz/zAF?=
 =?us-ascii?Q?8ukmKg5v2z0o+cBOazwPsPGC1qHy7AYRCAoYpcJN8O75p4EcYaP0o6t3BJPD?=
 =?us-ascii?Q?W74ZA92mYk2qytTEO6tJiEEOw4MDzmeZzsDyOVTmmYveD0gQLBQJoITkBFS9?=
 =?us-ascii?Q?7/cNf7v6ZbuSaXe/9B2wjcTJqxxPri0trfGCBDFTIxUEZfWZqV37e6RPWsnj?=
 =?us-ascii?Q?6hU9yAuZZORD7scBVqIV8IE4pp50nIy+T9f5pCK4DURW8YUzPJ4UdL7rj3fG?=
 =?us-ascii?Q?4IVGQ6ycgWsuFrb3coGfm+lmi0oJ2GQV+RiMqrEkAczLsYyYVZ5khsaLHJDc?=
 =?us-ascii?Q?xEQSvsp7IveXwaZuAK7riAt798zXh+YRRs3nxWXyaooL3G70hl1n9p0iTf9Z?=
 =?us-ascii?Q?AMgADvRbldd3ReBrF/aIZVhRSF2V16samfto6wuxKZ+hI1Pl/V2RcAuvkuKA?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd933b2-818f-413f-0365-08ddec44682c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:10.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3zfSgmsslVJCRw4XsnFDXCsXV/osigGoQ6j+nAjfH9z2ltc+/TMSzGTRMr1Kz3JgvXecAaYkHrlQcFWKtU/zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17960

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The destdir variable of FetchData contains the volatile value of the
destdir parameter of the unpack function and is only valid after the
first call of unpack. Replace the variable with a function to make it
independent of the unpack function.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

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


