Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.134])
 by mx.groups.io with SMTP id smtpd.web12.1837.1603056844234856105
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Oct 2020 14:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@prevas.dk header.s=selector1 header.b=GoeynRb4;
 spf=pass (domain: prevas.dk, ip: 40.107.20.134, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaXrFPEdDVKdm6N+UxYiZYLdLJ3D2q7M6cu+x210zEdaLKb221g2ZMJGZDN45oI/ZOHPeZ+E30AHJuh9uGa6RMkg9FXQ/av2sh36c9x24EzcQb1NonUw+G0f9dmkAaWK3aWED2E44eSALENIoXOBkWpVCbX0oIUkHdlHWhTlb+sjL7GWIYyqpRlMBrYvf9aHHAApJ141xjB7u0aH4si+zEI2xsOsZY26UPnICNpxDCcNuTczm95qT45DCJ4EDh8q1iADtzJS5+7ENs/P7SYMPiCzfFsdD9B/Z+h1GLZ1u2nwDDw8p20mJ3+HmWspO0WTl9yRClCU2BgWAybkXDKpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcmgWcc5xKq5T6TE3CLLcRvdUx5DELkQ1ZyuEv8GXsM=;
 b=XPhZan8usK02whWLh+f43j1o5w38nUR7mxulTDo84Ix1JfIeKoCcimEvVnEnt7yFC6cfRcSKDyqEWRZHvv5VxxCTPs4flDBXZ9FK3OhWPf6zIG62pmrS0lQQG1cX1/7JxrvNcVSCuD0AaIfM76ORqGBrKBPWcxB7y8T7KmKPl340MDYK4UjPqPEnNSvjqcOA9bR6L7nSTRWvXqBCcQYniEQZFpBg89JvXp0OGMUCkFKASf5dKqwOxgS+YztcmLecdu3HAqa/QG1/s/aBuANnvD7MVXLpaZPgNcygz2Zv9xi4l+C48xl6E5aEbgLTaj45aVYcJ2gQO5K+nxLzcboZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcmgWcc5xKq5T6TE3CLLcRvdUx5DELkQ1ZyuEv8GXsM=;
 b=GoeynRb4HHAvcSOdN9QHewpg283c9FvEVBsmxAd+GXqDIBS9XhU4cM3XrJPSPtxYea8VYdOn/YHpnn6UvDflITqnx1Or4DrPE0SuUN+Ug6QbQg6q+/J3OrTQ74B92fqwfNWJeXCqnhkswDS3BS9N2udSdSICsb59oBvoTwa9ykI=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Sun, 18 Oct
 2020 21:34:01 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3477.028; Sun, 18 Oct 2020
 21:34:01 +0000
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
To: bitbake-devel@lists.openembedded.org
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] fetch: git: add reference parameter
Date: Sun, 18 Oct 2020 23:33:52 +0200
Message-ID: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.23.0
X-Originating-IP: [5.186.115.188]
X-ClientProxiedBy: AM6P195CA0041.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::18) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prevas-ravi.aaad.autarch.net (5.186.115.188) by AM6P195CA0041.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Sun, 18 Oct 2020 21:34:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6babab6f-be42-463a-ec8a-08d873ad8734
X-MS-TrafficTypeDiagnostic: AM0PR10MB2241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB2241D6F58209C08BF67AEE9893010@AM0PR10MB2241.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LUQD2FWynLeyceFEOwFVWmPkgvbjgorrGAKcCbtG6t6tN+I/r8I59KvJiZRy4hMrq7NNyBbAU1r7e4oAfEsh8Tw6wvrJgsVIGfYe/kbmkBKNkce526FD1H7GyaZ80cGN3Xfoz2nFEir+luBrV+W7C3nH7Zlvr7SXH4twFFOf1PJisoFKmi0e1c+3FoxMA1tjam5zrog1WGW3NCGg14y5tkLPVR94ygjuAyc2Y3CW+Y4m3NNqrkolwoVsmrZRwcl+a99Ju453qoxVH8t9yBMZLK6aYHwYkXAl8kyonv9n/UyQgPqsYbRh+ZZWvlJaij8rJYTijgDiQ0m8Vi9p3VV93A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(39840400004)(376002)(366004)(6916009)(4326008)(107886003)(6486002)(8936002)(8676002)(54906003)(26005)(36756003)(83380400001)(186003)(16526019)(86362001)(478600001)(6512007)(44832011)(2906002)(52116002)(66476007)(316002)(66946007)(66556008)(2616005)(956004)(8976002)(5660300002)(1076003)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	ZG92sRlVFmDR0xsptfSjmReWbcARKWeBBDUVbHJ+PcHhmBJ4PzgXQ1xtNqNjnYbfb2Yzs9wyH957mB6em64e7rLkGRTLRhyWqG4awTlVRIszEF/7AwolvPXoJD6I/WlueAn8Gnlk7E+PHojp5nLwzWIL68gM02sLi5ayqQbacMAryUx3lBkiLdK0eCNt0IHXzh4qwaXC42i2NoEl3zqlintT59vKBUu1FOwHmfwS491iILXjPVMFoKirUcyF9RgbOOi8Ja+ya0XuOFG5rljT6aOU8BD4Le3qr6mMJVBZxTBQDJAC8IW6Rn0AU11zImzN1T9RU6MBv+mdSSU0lCFwEGQvTa7ZX0Yf8FK2gc4ji36Xse8qlONRdQ/SkOzQhaeT7WCt1qAQax01JKyslPk5XDjsZmlZI5Rnsq726ftNNzrsvP8g26vA2+Bi98HOctOVuAXgABdUxWDUJWfY81w303zx+HE74mjQKaOPWW1tn/z9hKSY2MSKnNNpf4AMjquYM3dzyGVuawf2kqKl9/NtS9lZdoowdgqg0+Pp+Jorwm6IX0rLlJDkH04sDTZnwBfpDJcitH9/tyw8fBeBspsIG8lKPSDdQa1UPQOJRpxs1+JADtxQJCa4VVub1JUMUC566RRsXGY+pAdGQykxXAqOfQ==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6babab6f-be42-463a-ec8a-08d873ad8734
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2020 21:34:00.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZmhjI3oeLHbzbF+e7js54lYboP/EAjce33btXMnA1Ozfqu2Vdb5Oqpm+ts80nU5CHTKem1KIr6et+YsRlw0RXlwoOo2Uu3WZjprSw/fTnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2241
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

The --reference(-if-able) option to git clone can significantly speed
up the initial do_fetch if one is able to point git at a local
repository containing a large number of the objects that would
otherwise need to be downloaded.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 lib/bb/fetch2/git.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b97967b4..c8837816 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -51,6 +51,13 @@ Supported SRC_URI options are:
    For local git:// urls to use the current branch HEAD as the revision fo=
r use with
    AUTOREV. Implies nobranch.
=20
+- reference
+   This can be set to the path to a local repository expected to
+   contain many of the objects that would otherwise need to be
+   downloaded. It will be passed as the argument to the
+   '--reference-if-able' option of 'git clone', along with the
+   '--dissociate' option.
+
 """
=20
 # Copyright (C) 2005 Richard Purdie
@@ -151,6 +158,8 @@ class Git(FetchMethod):
=20
         ud.nobranch =3D ud.parm.get("nobranch","0") =3D=3D "1"
=20
+        ud.reference =3D ud.parm.get("reference", "")
+
         # usehead implies nobranch
         ud.usehead =3D ud.parm.get("usehead","0") =3D=3D "1"
         if ud.usehead:
@@ -344,6 +353,8 @@ class Git(FetchMethod):
             if repourl.startswith("file://"):
                 repourl =3D repourl[7:]
             clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s --progr=
ess" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+            if ud.reference:
+                clone_cmd +=3D " --reference-if-able %s --dissociate" % sh=
lex.quote(ud.reference)
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
--=20
2.23.0

