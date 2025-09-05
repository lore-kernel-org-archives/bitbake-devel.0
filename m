Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B2CA1010
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:44 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.127])
 by mx.groups.io with SMTP id smtpd.web10.15209.1757054681032438910
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=GrxfDHee;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNFs3LbXIbTEtzOlYXntMVhsw5sh5n549DCDRZV/k9bAJSAvBU6K6XgRE3jKmORQ/9P/jPuhEl56xeKCRsjZQXRQPNP7juZHat5BP9qx3O++9cP8cL2uKFwUrLObXH2uJehIBuRh4TCRSiDEQ1RQsCRnz7fLqL8yfehmF/o0UOVeK01KTlMscAIc8vjKTMFXQZa8BlZI/0vdfBK9WCNGXyWrxCJ8PXLZNg972Mo+/tn4zqGCjtCBASKO5we9q+blCb48l8guhYmW3paT4HLV8CA8MwdKeZ+pYfM1KEfAjdLVcpxoRMFIA8w/KAZlKfJizNSIySgBO5db3m3rZSpu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCRjfojtGtzYwfvx3Sdr8R6WssHXQiQZCN4oB17tPEs=;
 b=AOnJzWwVXPcmDQlB4dGAaf4fusadpXApQiR8G7l0vXUEEsHWEZ7IpDxTLggcGr6QPKYqXa+cIMpveWDVOAlOILZe70PiwVwE6Zr+2VxMp08ckpK+pm9HQUVUj2eH1CrCzyIXe7U0I0ek/Ev2J1fyBH6ZwT0rFE/FkScreKKb2C+QWd1b9KiO7p+CRT8lDXiDQ1rfuYWQh8ITIaPtt9F4+anK+T+xbojHtLqle3Dgpgg8xYcru0bIUAd4klmwDPaZO9cSiT2DJvUa8t5NPdNQspeTvKIqZv/7GvhMbTaVX4AEXQdaOXEy4vSGIvsOEgjy1oOkLB1EecsFVuHA2iGLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCRjfojtGtzYwfvx3Sdr8R6WssHXQiQZCN4oB17tPEs=;
 b=GrxfDHeev0CMDzos9sQiCvf0evcvmNvFOTriMfKBhGWfhyuoLZD3ECeJdqLlTv693JWhsw80u9lBIheOFjZiPTDmmyDkoB6r9+sePiClqF+HDVcPQl8gjQjUEmfyUR2Cw/styEHMYupcQvsVJ8nRZcDwguzUW/djnEKCGEs32WjbFVKDXRl/yqTrjrBAbE/eVBxDgjcTTBB7QFi7ltbTYgP+jWnx1uZfqXeWPSkHWVrIxAPtlvYj1ebrFod4/dm7nVEJEMQ0A0EMm5Xmc5cyUT7Lv9Z4afFjC6YeVCzgzEEHoaiRsMQJGQI27MiyU/70K4fqhGXgdSzfMXojh9cyMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 06:44:38 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:44:37 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v2 2/7] tests: fetch: add test cases for expanded_urldata
Date: Fri,  5 Sep 2025 08:44:14 +0200
Message-ID: <20250905064419.2589111-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAWPR08MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: e2642301-c2b6-4a9a-b0fa-08ddec47ad91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5a5Q74NNXTGDe+Fh2dtE+zHfYSMQrNKzfEhaAGI1nhfNrxsyO+nkLqjV42aw?=
 =?us-ascii?Q?4ILfV2PhhWKEz7XOum0nIfe6jJLPg6IP9gVmhXuAT5qtTKjlvZskUsB1hbw6?=
 =?us-ascii?Q?5p4E8AMEanq+4ycMF5EpRc41YntSxy9queX9p3+Z/L+Ez5VTK7zYMzP/TRQA?=
 =?us-ascii?Q?zUE9FTN1/+GbWAdo+TcmN14QtKgFhtVdtYZ4pgurD4qd273UmBUNEUsxh6/6?=
 =?us-ascii?Q?zrz4GVT8p+emAlL7b7OznH5Wv4AV23Qg+f0rJs2J/aqG12UvlDECcVytAfjL?=
 =?us-ascii?Q?AI43e6JBvvRIeGXBtJCgI6ZKSqynJap9eD14PiXmNM/XyJL1Y7S3gqE8rkcD?=
 =?us-ascii?Q?IAyssRr32zF+hLIvpidDGe4fmT0j9s8OCN5J91cpLjMW9WJLdQG98Vh/t5h7?=
 =?us-ascii?Q?CdhsoWsVBpVcKTcT8fS5p/OzZgkTItboFQGCyhoksLI/dfVz1P6TjqwKum7M?=
 =?us-ascii?Q?+ILJE0lmoX5HmkDSSHmaXW40ZjKlGLlthJr0kuXWso2E/ny7+rsiWHRA+LEI?=
 =?us-ascii?Q?gESJVuRpszukroTVc/qGvdVw+EwWaqHIqhX9OXdE2SpsAc51yHG8gH3k6HIa?=
 =?us-ascii?Q?hWcIjzHMR3gGPYm+EpPW2JNyI17F58ddNAMsoAMVJTZ5aKP8SDRO8tiup2Dn?=
 =?us-ascii?Q?1KLvKcqI/4+9e1jXtrmcibDrBLkE2v1bXbFVb3jQ2DXG32Y4UTC8ZeR9gN3P?=
 =?us-ascii?Q?LTqwVTcVVWh868rKOiDSUJVQlg/8HNf/6y+eLa/BUbXVoIlcJ0P1pfgBtRrq?=
 =?us-ascii?Q?u3T/3icMzddsl9W3sPRkCpMZFHzYW1h4CpKnj4E2Nm5xODmwdDgIIBNt6kRz?=
 =?us-ascii?Q?85jHnTFmm780xDEu0D55+YkAx74uxkiiBpa23vpUYGzInXmSUQFqIcqQfwga?=
 =?us-ascii?Q?PDOycbyxU6EtRVKqhnNYwU82Sdb8Yl2TJPq04W874y9ywA7I4MyZU71GG591?=
 =?us-ascii?Q?phPRLiQSy35pZvfWrKVpnCPP3tP6JohNzLIE+7bmj2FfrRZ6zLahnTLweMoG?=
 =?us-ascii?Q?HltTlSsRlRP6d7l8CfnX95MDG2lBkJCMtkCkhSD5Jo/hOFWpEQB2MXLXjynM?=
 =?us-ascii?Q?0D0K8GKy/MxcSKQdI/1zzp7IS2B/ID76HbtaR3TE5IXu4+nRVM+SDIjalBQ1?=
 =?us-ascii?Q?PglOg3SgS1dYKr8fUXJd4Z1KRLMyESjlvXoU3r7QnRu+qZ9exjxE7mpks90Q?=
 =?us-ascii?Q?i3xW39Yxl13MpJ6sIho3DLoObdMGA+iEqRjmRGmXN35nlhk/1F3I+ISLmLCO?=
 =?us-ascii?Q?Fd1gnVWMbBLDjms0CLetKwjabKDoicE+qPVNObKbjjKf0xAd0PKmzSiYAESS?=
 =?us-ascii?Q?galAxaRGWSPK/VyXAT/ZzPBAag92jgzDqszzD7Dy/ZvQ6aFVv507uebDnXXF?=
 =?us-ascii?Q?BKiKJqQZsaterpspifN7qP1lF95Tdbyw+Qob5bUdCw4Z/1oEErwHfmbgDrJj?=
 =?us-ascii?Q?+V47fzInvag=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a4ggajOFoVGLRhmk7WgRnau2Yi1Qt4TGV3TzGF6co2bQmip11H7hz89XBGUq?=
 =?us-ascii?Q?2aA1QGzaw4BhN319wapbncCtu3rKziIDQH7cmWKj72q4hYpTdUfcJefcp8TX?=
 =?us-ascii?Q?R2DtPfhnIwiMkEWcNPXTFTIE0kN4VCs8mbeBhVTdEuDuPMrD8NHs4+RmcVML?=
 =?us-ascii?Q?3coFxDhCfoHGFk8AaY694EqYlRwIMyEqaFgVlB6bMSlEbKtDclfEdCoh6iNp?=
 =?us-ascii?Q?xIK9Q/1nfM4NF3nP0iNFHD0AaTxQeDjE99AWWBKl4AzI5FekWMSR5gq3HuQV?=
 =?us-ascii?Q?p24U7m55CIswI30ECv/QiNoJWuPLjCGrmz17HHFpRZ54KO2Zj4Fm1ziZP9Sw?=
 =?us-ascii?Q?6zZhOQmToFzCJ8BY8o0Iu5mAmPEJbSa/z8EUlXGo3ZclBw5MN83w84KQbK5N?=
 =?us-ascii?Q?ArxNTw9/j0TA6T2RU7fxA3s1KXKlsptFVDFjwb5XWAGhTycUbDXpgbRDwmUq?=
 =?us-ascii?Q?Fx/kCAOV1LwgjvNrM83+NTgcnpenHih8pG1kRj1kcTAHvI3miB3Oxhtz6yPX?=
 =?us-ascii?Q?mKt1PB563TQgTZDcMPRr3R3EhiFc7SfRu1wDOMUl+HSl+mRMFX3zfWMgOCfi?=
 =?us-ascii?Q?8xiToi7q1vnkLvE56jh+isTwEoqj6l8HGDfaq2fojH8cvni9R389pNmnKlfY?=
 =?us-ascii?Q?FkJ0TugQVK5UmbgmHn0vGGwZRxrVoaHm/UxxoPz+8940pbS0UoRXGC3guZBR?=
 =?us-ascii?Q?Hex8snLOg1i8Uw7hSefH9aO+f7FIRWgOxGSg3ByZlEfhbaJRSa1xJP7UTOQ9?=
 =?us-ascii?Q?+prc+kF80XFUMrChqpX2D/XnwnKrMl8floY1KIw81VYRkgpjE7Luv3eHzbjH?=
 =?us-ascii?Q?VQubTmLg7u6B7KRve8rflx+S9Qy1ksX+nU98NJTZ/iAeMIzO7icshRtHZv1v?=
 =?us-ascii?Q?RsZBPPtt15rCRhX+Ee7dJJ6CCqDX+f3O+BDOnm8eegsIjHXFiDz5xJq9iUZW?=
 =?us-ascii?Q?jEnsWhGfgEtRKIKFthYA8OZZ4w8pnnEDwhtvxAf6sMNmmyxjR+EtEeeeijOX?=
 =?us-ascii?Q?kBrMkv1T/gCywCYjkBwlMUrTMdlBUjdBZlD1DLC9erhpnTsAub+o/bi495lp?=
 =?us-ascii?Q?lh7Qir/Aue5oQQtaRzHWRahLVgpEw6FNkyzwpcVfQz5aKTpMtIcK1Xl3b1Vx?=
 =?us-ascii?Q?VF4cFu03yg14adORLPwQwsiycoFQ//VK/6omshkpS1+5mulQAeT5EiBtIUUN?=
 =?us-ascii?Q?dvxpG69wSShc/mMmG6DVeYhsft8lm0jWB0Vdp8m2gP6t35zhOG4mSX/yCnRQ?=
 =?us-ascii?Q?EQ60j5AmurHOJ1MQHL1SN974SipIAWygV8s4uXm+UzZ/l7Nlh2MRpioGCkEF?=
 =?us-ascii?Q?Isat/7nMKJKStf8aAsKaD3mIwkNN9bcJMfXREYtNY3iKTz0dxNfFyS3PVkvq?=
 =?us-ascii?Q?FBjeVUYxpw6WEuVmK9dg52tufLS+q2RFHyXM0zeslq6Ix6ZFWSECsHqGsp8e?=
 =?us-ascii?Q?lmbrxZTz619lsy4hwtkF6Kenx++VRsvdwm7kNKv6BuZ0VAwuyM+OU8OyfKEH?=
 =?us-ascii?Q?b84cyz8K3IdxX9h3xAjCMZJeR4sgJRIupfUZWpiZhCaBb3IxbMyI6bXE9UrH?=
 =?us-ascii?Q?PUz1imX9o9fj9L/Kk09gOx5pnnILTGQEAPf92FiD7QtDXwv7568eaTtF3K/S?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2642301-c2b6-4a9a-b0fa-08ddec47ad91
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:35.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlrgUfABU2s/EKJxMe7WLycaqUMD2Ajd5jLozO5aTOqAjiZ7B2cT1wWZH7tNzwjwAQnbe3dxV4gMvj7eFU/AlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17974

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add test cases for the expanded_urldata function. The test cases
contains plain tests for local, wget and git fetcher and an extended
test for the gitsm fetcher.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

Changes in v2:
- Add commit to test the expanded_urldata function

 lib/bb/tests/fetch.py | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index feaba235b..806870198 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -915,6 +915,20 @@ class FetcherLocalTest(FetcherTest):
             l =3D os.path.join(self.dldir, "git2", filename)
             self.assertEqual(localpath, l)
=20
+    def test_expanded_urldata(self):
+        urls =3D [
+            "file://archive.tar.gz",
+            "https://downloads.yoctoproject.org/releases/bitbake/bitbake-1=
.0.tar.gz",
+            "git://git.openembedded.org/bitbake;branch=3Dmaster;protocol=
=3Dhttps"
+                ";rev=3D270a05b0b4ba0959fe0624d2a4885d7b70426da5"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        urldata =3D fetcher.expanded_urldata()
+
+        self.assertEqual(len(urldata), len(urls))
+        for ud, url in zip(urldata, urls):
+            self.assertEqual(ud.url, url)
+
 class FetcherNoNetworkTest(FetcherTest):
     def setUp(self):
         super().setUp()
@@ -1316,6 +1330,36 @@ class FetcherNetworkTest(FetcherTest):
             with self.assertRaises(bb.fetch2.FetchError):
                 fetcher.download()
=20
+    @skipIfNoNetwork()
+    def test_git_submodule_expanded_urldata(self):
+        expected_urldata =3D [
+            (
+                "gitsm://git.yoctoproject.org/git-submodule-test;protocol=
=3Dhttps"
+                    ";branch=3Dmaster;rev=3Da2885dd7d25380d23627e7544b7bbb=
55014b16ee",
+                "a2885dd7d25380d23627e7544b7bbb55014b16ee"
+            ), (
+                "gitsm://git.openembedded.org/bitbake;protocol=3Dgit",
+                "c39b99792547b642570ea5152070e7396e812390"
+            ), (
+                "gitsm://git.yoctoproject.org/bitbake-gitsm-test1;protocol=
=3Dgit",
+                "120f4c731cdc4a24cd29e44c4c02c4c658d8bc0e"
+            ), (
+                "gitsm://git.openembedded.org/bitbake;protocol=3Dgit",
+                "52a144a7daa94b2bd239d582cb71d1f03119918f"
+            ), (
+                "gitsm://git.yoctoproject.org/bitbake-gitsm-test2;protocol=
=3Dgit",
+                "f66699ed76c2b21ebe2a94ee23450415d2c7dee4"
+            )
+        ]
+        fetcher =3D bb.fetch.Fetch([expected_urldata[0][0]], self.d)
+        fetcher.download()
+        urldata =3D fetcher.expanded_urldata()
+
+        self.assertEqual(len(urldata), len(expected_urldata))
+        for ud, (url, rev) in zip(urldata, expected_urldata):
+            self.assertEqual(ud.url[:len(url)], url)
+            self.assertEqual(ud.revision, rev)
+
 class SVNTest(FetcherTest):
     def skipIfNoSvn():
         if not shutil.which("svn"):
--=20
2.39.5


