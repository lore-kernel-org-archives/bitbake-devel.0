Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50AE77199
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.149745.1734693993938884026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=cvhNR8lt;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNlEXEl42tqWUwhchRlGNZcTO6M6ui2m7xcFik+MPrzy09kf8xbeQYUVh/6cCfkULHetXRvuly3IbZ8eEDxabfHONCyg9O5Z33olfv3+7x9ucbkBJ4pmo9m96Lx2moQx8+05a9Gmy/Hfd6F7mRPu6zOWI6Gt+rt4iZZMhxvzgwBVHwf5fTmqHlrnEhL6HRzN2nEKQjAhPpjjpBoYu0FtsO+E7FrPM4OxtFrTR+EurbzkNilYpfMTwUbTKjFPTzD1gkClEVE+k+pqElhbjODj0n9tKZoXKWqVapZE3urYOhjArHrxXjuq401zQVc22vNCBviV8qsQJBqT2w0nQSGgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iZHi9BXyNE33KEPe5zk/Om8Ucv7r91bk7xCrTG1BUc=;
 b=dknPsFrEWlz922YkI07mv3aQRaNsKQGpFKulVHNRqtaUoq5uwFubnNaLX31/R9MRCmViCIZTnZz+TX4HEGB+/UqvoX5Fmn1HjXg+llHdUNIfJdV+r9xxPqNvT+G8drsCxRTNCRbd2M/3YpSmk9798RnSWoz/AjI/8Pi2IQZpBatZ0xo4cn0vfgd2wy7h51vglCAgEnsj/ULWLd2GhU5m7//EGx3kL4ERQkjniUwtuNM0R0yugCtvS+MQCRywAb8sDDfjoJIcUjhsz50K8waTT1wPn1R6HdajbDJ9EnhLuttRIAwg1aQ+pwkGaXIpHhlpKo8zw5O/Bok0u3LaRg81zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iZHi9BXyNE33KEPe5zk/Om8Ucv7r91bk7xCrTG1BUc=;
 b=cvhNR8ltG39O7w5UBM4C2prhO3Mh4WNMx71fFQ3YW+HnPbLD6v8Oexnh5uahdVc7wGs92Z6qt5QnXHGVHswE4cTXmpVL3VZPiJPp2cdKTyXAgqOYdqjeIW8cV/x03H5tzQOJPKnl1UQIg3Pwf3BreLoaWZ464Y5JPQKGJL4OhO8YsHQ1Y+4aXBro753gmYTy56gsbuhisNqihs7dLKeVLUiaQyWoTrZxFpA6WX72VCcZ09AqYe41yuPDq8W/NXLpWE3sw1kgW4l+B6Sb1TsubCVcprlr2ozEd+spuVS/EbEMq2jLxJBhYLidP0IBlzmLZ6c1NRve8OqsC4prLWyf0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:26:31 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:31 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 15/21] tests: fetch: add test cases for dependency fetcher
Date: Fri, 20 Dec 2024 12:26:06 +0100
Message-ID: <20241220112613.22647-16-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM8PR08MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2228ee38-7348-41d5-4870-08dd20e925c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PRgSGQNP9krG19JMx85IHsXkT3dErTXLqbbA1nKLrQV6bQ78+TYGu9JQL/0L?=
 =?us-ascii?Q?cxGBfUfD5dGZc5OrLlR86jy6u01g4ovWhB9mEJHtWGuz2kujOJ7jAeJhGVlX?=
 =?us-ascii?Q?kxIDopA9yXdNV7QHlMlkjmXiTDsXYx1MHMMJRvJyceHb0jJLWbxeZFd1k+1F?=
 =?us-ascii?Q?J3gXOaz7seFxw7QVFrgtnD4o9DzIQBZvOPDBS5BgWsVZUPgsRuzv0oDagCz5?=
 =?us-ascii?Q?GoMlecFHsKXhGkKQ5yHJ14fYaMjOwttdPux4UHuwjlJpp3Ji32o2OZb2ekLK?=
 =?us-ascii?Q?XI2hBXzb432INtTExr9wryFPsggbiy+9jnczfAEl/LoT8XsLW8QgDae6LOAA?=
 =?us-ascii?Q?kPWzSXXDHWCtABGtjX5LBUXPcJ9s8EfzcU1n/KvVW6SJSN9lTP9Zt6bWh1vD?=
 =?us-ascii?Q?oeSOcIpMn6n6ScYKm69NrkJ/ZOoW71YDR4txYj7bWv0L4MdGC2D/awFvZ2Rx?=
 =?us-ascii?Q?/WZJFFirsLKeiAcF3ep+9VKN0Etr2I4TMF0bV2aZjAfhk23tpDXaVbvlZaH1?=
 =?us-ascii?Q?9Rv+9xU34kUOYGsn0LkxSy85eHDVM1iyYQQ9aNB7ENo3omZdYZR89tRVF0Qf?=
 =?us-ascii?Q?uHfOJ2wwSqGRdaiqelY8Hcj+PW9IpycL4oKDtR/fqlLhEptLTD08PDfmmcvW?=
 =?us-ascii?Q?p3KuRI3F5XVZr4ucPH1X6U0GZnK9H9hY4A4EsiXRtYZECkY9cWvvsnypKoFH?=
 =?us-ascii?Q?r8oB2Ivxx4Xkgrkf0Eo4Jc4rEvktRF+yOm2Nrv6t/cfIncVqeHa8vnX7cXrZ?=
 =?us-ascii?Q?LBiixYPmIG/yXFipij5OIZ6COfB6mX2VOkRhZLTTSUHm1emiwajG7JTqsh/h?=
 =?us-ascii?Q?wHvSXoPmnsVPz2CQ+joYsg7tk2p9HpTuOC7UPn9e9KHbc9JUE/bVEpbkIGKk?=
 =?us-ascii?Q?JZ/2joGYWE6q+h1xM/JGW2mC9ImmeaC12A849b7GkewpF66Fgtu/Aa3GFmXb?=
 =?us-ascii?Q?mW0sUvBw3NqbyZAWhTIh4xb0b4ikehNAnxb3AfFwTYCrx/D192ErQ0crOfSX?=
 =?us-ascii?Q?X7CPF/czGqA8BcrUwdvEh87R8ak7aBRLhqBONUSTVXsGqPMrXJaYrgV2Yh2N?=
 =?us-ascii?Q?oYTnOWJEugYHyUB4U3bT2QkA2numsTeY5857wyKhEVZi0S4Q+OyuCTyYQCaZ?=
 =?us-ascii?Q?GmsAJ1md0kRNsqHnopb3A+N0ssL1VJ4reYHc7+rI9aNwZVnVY/icsoWFjK7z?=
 =?us-ascii?Q?8zSoTPJIsXfXDhLk00BecfvSAasKISclc1BVhVYBsLLEZU0zmdqZiuXttypg?=
 =?us-ascii?Q?Lujnlw/PEES8+ARwZgj7PCYx/nQ6IEZ/q3ivLX3RBX9sMcus1jlzCGWlPzpz?=
 =?us-ascii?Q?HLftXKKx7gP9c9oHeROcsfN77yXoAzFEgnbp8sIedg094Da3czEuFs3wgirm?=
 =?us-ascii?Q?bBrxO6ivYRgvnE+PS55F2M+dfxDl8O5c+x3T0kCKdkJS70Rerg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HbM9eY+N4pEj7qZH4WgJDvMHzSEoz6VYpkMgr5DWDTiC3mDAJriXiAHkniwA?=
 =?us-ascii?Q?Ev1KdqvjE347J5AjGzkc7Fi0dNp0xR3IkNBVths4aAr0vtY+mMTwYcGkDsm1?=
 =?us-ascii?Q?vZETfyJ94l3hdAdOkXuG8tp9B+znOfxNI1zo6a4FmF7FPfweF3Hc/oEGcsAp?=
 =?us-ascii?Q?Xucs7F39+sk/AbFYhfs1Uc6RU4Sd7DuR5oTsw7pK+Iqj8tkeVhReslsioQyg?=
 =?us-ascii?Q?kHW5mCLoXkd3KDH13128EK7umTQXFjgFVjwfUcCrNUWnjehH3wKPG91gPLhW?=
 =?us-ascii?Q?Bgt8eyQNmRaVyjNGw3dLzTDXPsanlnZsP1fSFa55CCNTmXJ6xzX0mdsDQMRU?=
 =?us-ascii?Q?yS/LHRB8QDa4D+1FJjSZMECKUkyNQUcJxjYDUHPAdJ1fO3B9UXChVrI8UC+4?=
 =?us-ascii?Q?xv0cY5wvYbnjARtq5fcM8Qqm4lT5tnHh88YTvT9UlQLgVap4qnAKc6Zyhxj6?=
 =?us-ascii?Q?tyPlsRg2Mylv737uORli5JVyZNfNJmIiDUdrq7lIyznF5ZWlQJWuQKsZDZ25?=
 =?us-ascii?Q?qBReUsdg8hDgl2x2YS3IcVxUpno45dP63SCBVsZhovIWG3OXeXaA9uEnCxP4?=
 =?us-ascii?Q?ksoORpoCeJNArFb4EwtM4f2XFxt5PKqZsIRFmPLI266EzvIKmLrOjF+p0Hmq?=
 =?us-ascii?Q?invIqeoVWsQpKH5Fy92pElhfGVwRosQpGmKIm5N4AYndJBmz2AI6q6jsEU5C?=
 =?us-ascii?Q?ObKOcMA27JfiTJDu6njr0Vn2fbTB907dG9wt+1cBTyT9gh2oXw11HxT9Bk3x?=
 =?us-ascii?Q?bBzkHHfSucPNodO/xj9/NWRWzPhdWSmt1htg6TVXi32scRRFsGVe49BHztW2?=
 =?us-ascii?Q?6AbYtLm4LUbi6yQA8oEUV857HXMBuGiyWIPTuF2iZCzp640iuWBz+UkruEe9?=
 =?us-ascii?Q?3DbTypQQhK1hvf7tVbh2zGMXqk2H1LKnvcE0mBoA7A8SEwBVApv53u8IKALf?=
 =?us-ascii?Q?HSyD71rl50eZX65JxXm0zzpuciFZkC+uN1F2ID60IemWKwHqwbg/GgZwW8ym?=
 =?us-ascii?Q?PHhCVPloyXyVP0Okm0NHdlZ5lrG0j4YPTuoIpWPxq7nmjnc3Xey0glu+Dc32?=
 =?us-ascii?Q?vLHe8GDeqRf6iQolxwrd1EXCr1V8i0xaAuoMza5wA49034UUq4RKakv5QpCe?=
 =?us-ascii?Q?p2Wild0gSC6YRznOmCWBNDIC0RjAonO83FFUXUMbvpY+qOXesup79Ysbq71N?=
 =?us-ascii?Q?mHNz+L6QYF/5k/xZyARCu/5trl4ph9r53W80+/+03Xt/9iOSa0fo9XDd+Qba?=
 =?us-ascii?Q?T3xAY2yw6PgrOC4oqyE1BmUlRHxWxhT2kZbRQYxWV9AR9O8jpzxqSVU+cSC4?=
 =?us-ascii?Q?6PeCQyaDPbzVFRdilLxUqv8yEpju5kNMRSzK+VPW2veuqgeV4miUc6F4T4gm?=
 =?us-ascii?Q?79RMhXbf4ZH55o408S7rh51m40uB6yfxBxzVLgESD20i6zZnsPaWt24lo7ca?=
 =?us-ascii?Q?U6e/vOONSpZHOL8MeAKFVeTT0Vgilc1GI3qqbNuE1FQdMsuQEF1vhmzgQZSG?=
 =?us-ascii?Q?UieTzUbTcjm85eymrJ7N33cAu6vbb2U1WPrgTrkARK0ADhuvKEjSqDYxMwgF?=
 =?us-ascii?Q?v3fNYr2x5UNmfPZ+mAxb/qLzrRdgyeQf7ZrFFObzQCHx4KD/eJxG4+Qrn4S6?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2228ee38-7348-41d5-4870-08dd20e925c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:29.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhXwoM+wOZAqOu/CAzqOsvamQvloA5R6+tI0bj91DTZCUZcAkOa7Ogd1TQKEKSY+MDLxCdR0EaVC0oM700wsGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16926

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add test cases for the dependency fetcher. The tests use a dummy fetcher
because the dependency fetcher provides a mixin only and isn't
self-contained.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 121 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 09f493f8a..903095746 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3443,3 +3443,124 @@ class GoModGitTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.openc=
ensus.io/@v/v0.24.0.mod')))
         self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
o.opencensus.io/@v/v0.24.0.mod')),
                          '0dc9ccc660ad21cebaffd548f2cc6efa27891c68b4fbc1f8=
a3893b00f1acec96')
+
+class DependencyTest(FetcherTest):
+    class DummyMixin:
+        def resolve_dependencies(self, ud, localpath, d):
+            urls =3D []
+            if os.path.isdir(localpath):
+                localpath =3D os.path.join(localpath, "dummy.txt")
+            with open(localpath, "r") as f:
+                for line in f:
+                    line =3D line.strip()
+                    urls.append(line)
+            return urls
+
+    def create_specification_file(self):
+        dummyfile =3D "dummy.txt"
+        lines =3D [
+            "https://downloads.yoctoproject.org/releases/bitbake/bitbake-1=
.0.tar.gz",
+            "git://git.openembedded.org/bitbake;branch=3Dmaster;protocol=
=3Dhttps;rev=3D82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40"
+        ]
+        with open(os.path.join(self.srcdir, dummyfile), "w") as f:
+            f.write("\n".join(lines) + "\n")
+        return dummyfile
+
+    def setUp(self):
+        from bb.fetch2.dependency import create_methods
+        super().setUp()
+        self.srcdir =3D os.path.join(self.tempdir, "src")
+        os.makedirs(self.srcdir)
+        bb.fetch.methods.extend(create_methods("dummy", self.DummyMixin))
+        self.srcfilename =3D self.create_specification_file()
+
+    @skipIfNoNetwork()
+    def test_dummy(self):
+        self.d.setVar("FILESPATH", self.srcdir)
+        fetcher =3D bb.fetch.Fetch([f"dummy://{self.srcfilename}"], self.d=
)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/git.=
openembedded.org.bitbake")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
.txt")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "bitba=
ke-1.0")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git")=
))
+
+    @skipIfNoNetwork()
+    def test_dummy_git(self):
+        self.git_init(self.srcdir)
+        self.git(["add", "--all", "."], self.srcdir)
+        self.git(["commit", "-m", "Dummy commit"], self.srcdir)
+        rev =3D self.git(["rev-parse", "HEAD"], self.srcdir).strip()
+        urls =3D [
+            f"dummy+git://{self.srcdir};branch=3Dmaster;protocol=3Dfile;re=
v=3D{rev}"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/git.=
openembedded.org.bitbake")))
+        archivename =3D self.srcdir[1:].replace('/', '.')
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2", ar=
chivename)))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git/d=
ummy.txt")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git/b=
itbake-1.0")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git/g=
it")))
+
+    @skipIfNoNetwork()
+    def test_dummy_https_file(self):
+        archivename =3D "archive.tar.gz"
+        sha256sum =3D bb.utils.sha256_file(os.path.join(self.srcdir, self.=
srcfilename))
+        server =3D HTTPService(self.srcdir, "127.0.0.1")
+        server.start()
+        port =3D server.port
+        try:
+            urls =3D [
+                f"dummy+http://{server.host}:{server.port}/{self.srcfilena=
me};"
+                f"sha256sum=3D{sha256sum}"
+            ]
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
+            fetcher.download()
+        finally:
+            server.stop()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "dummy.txt=
")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/git.=
openembedded.org.bitbake")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
.txt")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "bitba=
ke-1.0")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git")=
))
+
+    @skipIfNoNetwork()
+    def test_dummy_https_archive(self):
+        archivename =3D "archive.tar.gz"
+        projectname =3D "dummy"
+        projectdir =3D os.path.join(self.srcdir, projectname)
+        os.makedirs(projectdir)
+        os.rename(os.path.join(self.srcdir, self.srcfilename),
+                    os.path.join(projectdir, self.srcfilename))
+        bb.process.run(f"tar czf {archivename} -C {projectname} .", cwd=3D=
self.srcdir)
+        sha256sum =3D bb.utils.sha256_file(os.path.join(self.srcdir, archi=
vename))
+        server =3D HTTPService(self.srcdir, "127.0.0.1")
+        server.start()
+        port =3D server.port
+        try:
+            urls =3D [
+                f"dummy+http://{server.host}:{server.port}/{archivename};"
+                f"sha256sum=3D{sha256sum};striplevel=3D1;subdir=3D{project=
name}"
+            ]
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
+            fetcher.download()
+        finally:
+            server.stop()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "archive.t=
ar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "archive.t=
ar.gz.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "bitbake-1=
.0.tar.gz.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/git.=
openembedded.org.bitbake")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
/dummy.txt")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
/bitbake-1.0")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
/git")))
--=20
2.39.5


