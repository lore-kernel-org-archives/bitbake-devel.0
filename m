Received: from EUR03-VE1-obe.outbound.protection.outlook.com (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.102])
 by mx.groups.io with SMTP id smtpd.web11.10451.1603373940205274741
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Oct 2020 06:39:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@prevas.dk header.s=selector1 header.b=gSVj+mgX;
 spf=pass (domain: prevas.dk, ip: 40.107.5.102, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd29goklfSr5lrX6Jz7kIqjWAD9Hv84T1p/+4f3FGSz7rb0LZBZt+Q6C6xf4VfZ2YOKIClS2K73icg3MgYNxzJhoRwp4V3e7v12T55ijPbskmYeNNKpDQ26XHsR2QcC2XbSP0ty8ZSD9sQmBIVIxtpxKdWFYO18kSL7nI4VqBVmMQW0AXDnU4UAe1oBogCj2muF9eI9a54proCzsblW6YOW4EBvO2jO+vJ6HAVODkvurOsBGxg0/PbU7aw9/mG9PXK4Nl3nHQd8pfxLzVULnHDWXmNpdtEOBxyQJUrh8UWXArFI9m5R00wo8c3P5P2mByk9hcqPw1oE1Na81m5oWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4fQxF+Ljf/zQvUzoky122hx7H3sJLAlUBQWGwmw6pY=;
 b=bWEPtjyePcPkNRyjJQg5/G1wxBVv44Rl5bWTA8Go/bzfL2tZGcTP7vCB6t5WkMH8YxgrA1oyt1I+w3MZ58T5JBckarwyLw0YGKzfMjjSEk8Wpc8Y/fDfdfO2Mksfc+quwWES9aHMJD+8DONxSaHUpsYhcsFgxIGgfr2nbRNOuAZ4H++wf6fi6gTVoYqr0LGvjIwPo/JMej+wEmlM0+RuH5CdpIJ4a7RyuQpIGotjHaaKPd/bp5qnPsz9+D9XPzNefyfpzGGF4x7acuOZg2qTFXEmr4ZULJK4B/f/f1NtMHnxcOanknGLMVKDsWXqe0MJsAYCRJNfc2qAG4zAr2J5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4fQxF+Ljf/zQvUzoky122hx7H3sJLAlUBQWGwmw6pY=;
 b=gSVj+mgXHNjV79PNMzf1rRqrZxdhxyp8cTPIvzSJSkNDVTXGOMGwgXgPA8TtKHHfGyeD2uI0GpYaYDGBOVJob/3hFnmygI+MeU8X6FB/uP9pQnwKsqbQZV71zl/4qtdpE5H1boOGhKIDw4kzW39ZSnhWk+RWDzWQYg0qHb2+u1Y=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Thu, 22 Oct
 2020 13:38:57 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 13:38:57 +0000
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
To: bitbake-devel@lists.openembedded.org
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2] fetch: git: add reference parameter
Date: Thu, 22 Oct 2020 15:38:48 +0200
Message-ID: <20201022133848.32480-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM0PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::22) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prevas-ravi.prevas.se (81.216.59.226) by AM0PR10CA0105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 13:38:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73cea2e1-81ec-4889-c48d-08d8768fd36d
X-MS-TrafficTypeDiagnostic: AM0PR10MB2628:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB2628AD1D46E96C06AB12F454931D0@AM0PR10MB2628.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hs2ymeBg4fOJ/JTx3UHVcYPA8f7Jnbqv0w/r+cTOX2r4hvPmwPAp6Jpsmd7AAjBqobIonnonJPlzqFHAkFIIPwfOTbiTnoDqTJLpyWGeU3rJkn5AcKoH1jsNb3v9KQxCAGzYLKFMJ3/YP9WSAg69B2Y76dttaqpYFYRSNpLus7DJSYZOmuo9YkzQQYhqtDbA4r/muHJE0n1et98NsiLKtBlGHaJdLa6PxeJmuE/M91TrX6bRUbVRaCHb/lu6xWlOU/pZ2MLyaTKzsryr5JDvzJuKYXUwayz3YBIrdM4o0Ai7MQTCMW2P6+Tyj78EuAbvzVOmMjCoB5hPThRqcdmbww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39850400004)(136003)(366004)(66556008)(186003)(6486002)(6506007)(107886003)(2906002)(316002)(54906003)(52116002)(4326008)(478600001)(6512007)(26005)(6916009)(66476007)(66946007)(8976002)(86362001)(16526019)(6666004)(8936002)(83380400001)(36756003)(2616005)(8676002)(44832011)(5660300002)(1076003)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	vlThuD8TO4DzhPtBLELyx9OOLZCFS8OAdRu0Q2xs/IXWW7mG74+Vk+9HLG0VsLfGKmSc/qMVKtlUSM57Pjpdva3oeXUfgm8RNWYWbZOLwZKjQFMe4Toyxs+JbL5ASb9b75mKU0D0aMYu+ppTJ9xv4+W94Yna46s7MZbE6yuEA0WFz4vemx/+t6UEEDKVj6b8mqlJU3HilUTC1jmElCi3FoYymLlSDD26GHqRuxA5Hxnvw30z1DL0ZaurnBNwKrPKPu5zGk4Tvm4EpNaBwGkfqerDdiPFmoPsd7sOusE7LeqS+NBIsH6shvYK/2JZy5OxHePG7k85/5TxnrrZLX3xnBRMUgJpwlyhTli3GAP13NSc/oHshV6lGr8ZB5jBErxKDTOR8NxRVDJHhozbzrFWtI/yOP5jTsH0GubkQ9g+yo6BdMbnKDe2yUfftZym180xUvh98iPzxNRuctGd7cj1y4TFftbJb4KzwBPm3OhlxRIV0mxfGMLyGsoOkrZOBDK3fb2u35XHmDKV2g5eQnzG0y7bacc9s+rK4FFkWjfX1Z1Ds6mg5Ub22lP+IOpx/FRxxioOtgb3xKBik/MX2JKCHi6JH4u6Cjoc74yD2YSu1yUyTy4+E2J75o8TPWxSef2sUk5jn+M6jEasPeKSz/t1oA==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cea2e1-81ec-4889-c48d-08d8768fd36d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 13:38:57.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZDmIlATzT9Q/Hd7VpUHWDj3Gq9C2V1Vo+4COszIRHIV6hO4I13PltKInzADmT5nC95ywU+5SklrcoHeAp8h2rg3wtTEyh6rWOUW38cjn2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2628
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

The --reference(-if-able) option to git clone can significantly speed
up the initial do_fetch if one is able to point git at a local
repository containing a large number of the objects that would
otherwise need to be downloaded.

Allow the developer to define a directory BBFETCH_GIT_REFERENCEDIR,
subdirectories of which can be used as keys for the new reference=3D
parameter to git SRC_URIs. So, say for example

  BBFETCH_GIT_REFERENCEDIR =3D "/git-refs"

and /git-refs/linux-kernel contains a (even possibly somewhat dated)
clone of
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git. Then
if a kernel recipe has

  SRC_URI =3D "git://some.vendor/tree;reference=3Dlinux-kernel"

the initial clone from some.vendor/tree will be much faster, since the
subset of objects that come from one of Greg's stable branches will
not need to be downloaded.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---

Pushing the downloaded objects to the referenced repo, making that
more or less contain a union of all SRC_URI repos using the same
reference=3Dfoo key, does not seem particularly hard. It's mostly a
matter of running

  git -C $clonedir send-pack --all --verbose $ref_repo

(I've done that manually, then removed $clonedir and rerun do_fetch;
now even more objects were available as expected.)

However, one will need to ignore any errors, since two different
vendor kernels can have a "master" branch (or any other ref name for
that matter) mean different things.

There's also a decision to be made regarding the initial state: If the
directory $ref_repo doesn't exist, should one do a "git init --bare
$ref_repo" first? What if it does exist but is not a (bare) git
repository?

And another decision to be made regarding when the send-pack should be
run - only after an initial clone, or also after a git fetch?

Since I'm not one of those alleged "most users" that would want any of
this, I'll leave all it to someone that does. Just please make it
opt-in based on some additional BBFETCH_GIT_REFERENCEDIR_PUSH_REFS or
whatnot.


 lib/bb/fetch2/git.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b97967b4..bc39962c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -51,6 +51,18 @@ Supported SRC_URI options are:
    For local git:// urls to use the current branch HEAD as the revision fo=
r use with
    AUTOREV. Implies nobranch.
=20
+- reference
+   This can be used to point the fetcher at a local repository
+   expected to contain many of the objects that would otherwise need
+   to be downloaded. The path to the local repository is formed by
+   joining ${BBFETCH_GIT_REFERENCEDIR} with the value of this
+   parameter. It will be passed as the argument to the
+   '--reference-if-able' option of 'git clone', along with the
+   '--dissociate' option.
+
+   If ${BBFETCH_GIT_REFERENCEDIR} is not set, this has no
+   effect. Also, the provided git version must be >=3D 2.11 for
+   --reference-if-able to be supported.
 """
=20
 # Copyright (C) 2005 Richard Purdie
@@ -151,6 +163,8 @@ class Git(FetchMethod):
=20
         ud.nobranch =3D ud.parm.get("nobranch","0") =3D=3D "1"
=20
+        ud.reference =3D ud.parm.get("reference", "")
+
         # usehead implies nobranch
         ud.usehead =3D ud.parm.get("usehead","0") =3D=3D "1"
         if ud.usehead:
@@ -337,6 +351,11 @@ class Git(FetchMethod):
             runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dud.clo=
nedir)
=20
         repourl =3D self._get_repo_url(ud)
+        ref_repo =3D None
+        if ud.reference:
+            refdir =3D d.getVar("BBFETCH_GIT_REFERENCEDIR")
+            if refdir:
+                ref_repo =3D os.path.join(refdir, ud.reference)
=20
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
@@ -344,6 +363,9 @@ class Git(FetchMethod):
             if repourl.startswith("file://"):
                 repourl =3D repourl[7:]
             clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s --progr=
ess" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+            if ref_repo:
+                clone_cmd +=3D " --reference-if-able %s --dissociate" % sh=
lex.quote(ref_repo)
+
             if ud.proto.lower() !=3D 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler =3D GitProgressHandler(d)
--=20
2.23.0

