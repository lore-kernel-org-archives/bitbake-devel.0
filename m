Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89844E77197
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.118])
 by mx.groups.io with SMTP id smtpd.web11.149744.1734693993154756588
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=KMKEckgy;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.118, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3Dnl7DmzD8vGawq0EKZ09r8xqNZ7vm5GJzoyQidkl4iqYW4txRCE4+3NBNyRRCjJEQUDPkPsfpXcoNfXYn8/UtDRwkza78wj3vmTKCRZdjohjLrie7vb6X/wFWBLGNetwe4gEhwmiDe970zgCqUXMYBZ8oZ2hFDctvzZ6MvzaFWIddXWMFpwolwekiagfuEsdiv4mJhcv/cK3dOxArgsKY3JNXHxKu51htTN7APoSE9ut6LTX9xTTiUzvr1N93xIAs2xPjD+LgweoPlq+0Lg3fi1uMdJaU/RTjIhlVxzZJc85wK1ofS1PEogMXBkBSnJ5i2NM20F0NA2jr3nh5nWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i3bNDHqF84Ldo1B37JTzHr5cWaUGE5wPJDTGQw9/m8=;
 b=Rl3KFA4iLFte/pSJdIzgt+A+vFSjv2lYs9emXPRZU5ar83+cchRLgXEELs5Epb29JEtQaD9udrUxY5vHge9N1Th7IfcmGtQsrCqigI5MoXbo2s7/LMnOC3vfF+o5aad1BT2UX2YhmKvZ8OFc49lYxYSrzhR4BHJaBy8IfwOaAldbynW5CAtjfiUiUrdeei9176Rga9bKygZ2oOgGH4MHhwbiYnk0pb1/8drSPsY0SkVlsE4tXhrfBa61nkNFevDVSh6cFPKhlsUYOnIrEcC+sWnP4hCcfMA/CiaKazo7nc0jmThgyX6kF0QpnPg671eYWQISZtSXOUGZMhMQAHoPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i3bNDHqF84Ldo1B37JTzHr5cWaUGE5wPJDTGQw9/m8=;
 b=KMKEckgyuxsxA+v4QCLE5n4oArpZ9+shb4g3szld+Yu1d+oreYWtzUojNeAM2MIirf6erxugtlCxPTz5ki2I3XP/ZBpO/DZg6sFYpYk0h7soufhLD9TxNq3EEk9NWTMmyOWHXGwIq5e3G+eBMetv94ZgUHACoc6dD6Sfk9n6yhQTPKQnx+2vF096VI+kGkN1y9Osh6BphLWncsovL65yrZI8R22KR9fpeP2SNYFd5zogfj/dq9mRlz7Pom4g84x2jZZjhBUiAL1iTgRtMBZPS0dM9pjRqOjeJnjIQZ730O+rkOMlwarK04nJ/nxNz97ZCKLnn9kxgV7IPGD7WkQnJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:29 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:29 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 13/21] tests: fetch: adapt npm test cases
Date: Fri, 20 Dec 2024 12:26:04 +0100
Message-ID: <20241220112613.22647-14-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0e3a87-07cc-4bf8-c2b6-08dd20e92561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ip+DCzS7HG1sxQkO3gA0IZ2fz22QtNnhW8uzzVzqbGqZc4R0k3HNi+UjFUkH?=
 =?us-ascii?Q?W7E3V/UkmAU+zOWW4LmXVS4lvQudQTKXyh8dv1AZZblz4FDA9dohrA7CTQfz?=
 =?us-ascii?Q?Dm0nKyBbcG44nqPP84Bl/U3tIUFDsWOUV3WXJ3vB9E+RMZmd7YMoNOgxSW7f?=
 =?us-ascii?Q?GTLiGiUvrMLuToinO3zIaSycsuv7TjYQpVM4GAi4uezItNqqK7IqCBcrQV+N?=
 =?us-ascii?Q?NB0IYQpHf7HtfjA9+XVu3KYy0QtrGJKp47OyAQPx7HBgO9jE3uZ7lr3qHWav?=
 =?us-ascii?Q?vdUPino+0qZ11iwt2A106GXtVSJvEUw5bPvx2Z+CrPZPL9ObkTausOBBvq3x?=
 =?us-ascii?Q?uqAlK2MS+lWlxyh3d1fL77PYKchVNZ+wDVkrE6B8/nUB1YNPYYp1a/fCSgpQ?=
 =?us-ascii?Q?QAf7v5r0xBxOyxzm+CHGuvnBlZRVA9KshkjYIZTSpYhnOcoJCZsj9LBAR9El?=
 =?us-ascii?Q?stjbTUyKr0/BH3+INtd0RhOxP4CIhLcjYWpobd+guo9AAC0HNbf/ny6UhjaY?=
 =?us-ascii?Q?WKEkD8rKioEfJEfYqFReEeenjUrVIzEgKXtov3aJcAImhrKcQgptusS08/S6?=
 =?us-ascii?Q?nWplkulpViaVlVqvbWx7rkaRwq7rA8QAaFutVa18tvBhl/zWCOCd4+pn9xKg?=
 =?us-ascii?Q?bGDbMgZEPX7nuaXjU2Bt1Uy8uSDbgvk+uFhV9BAQJke7r5StI5o8EKApUA/c?=
 =?us-ascii?Q?WtuE1y4xYkn0PKhvw1Y1L6Ce3NUbWvzrzoFLsM2dJbQUbcb7sW3Sw2to7ED2?=
 =?us-ascii?Q?bJIcWxRzAuuYzYfrtzYFS8QINqb+vE6OSSYYVRoZWgV4EUuAn2gA+NhWZLDW?=
 =?us-ascii?Q?C2ISUv06kf5PCQwRta3Q1PjoXHzxKQxbGOQQzNWtMHJl20j4Zz9TXEfhF+tt?=
 =?us-ascii?Q?ZFuvNS0Q8pcVhmNy1A4NGoqrTj3zvRDr5vbt6HYi3ASiBeg2MspBAua6RTFE?=
 =?us-ascii?Q?JvrXz/cUJCEdPzj7g2clKVPxZqcw8genFxLyqUN7qjqlptmsS3YQsg/npFZl?=
 =?us-ascii?Q?gLj2yWYdgTwFs2FQIol86paRgcimsJT7jAc/Gqa8C3ZSPGjNhTlgBWV4L1Pr?=
 =?us-ascii?Q?7xM3ttZfRruc2+Z+UmpD3r7xgJroxZQvShgNBI7isEmd48CrKVdIpWWUu8Wx?=
 =?us-ascii?Q?C38Oj7R3cN8i6y98yLr7INi4k6LtyT7r8iFx0CHpW32vqWDHM47fd+hcZo+y?=
 =?us-ascii?Q?YGuZCLwpGV6dHRnWnbYmJNNXJgULZFx4Oo9zfJ5IEYIsZM2VPixFwHxuc5SN?=
 =?us-ascii?Q?A+4qtaJF1bMKtLOBEX+RTOUGLQ2Z4XFq2ElgfJVWs5dbknx2i8xUaKDBOc96?=
 =?us-ascii?Q?KaZSaJ2w7x3pEYoEkDSSCehZXqDPGuwLYmx4BexT+Bb6U3HMhu7ImzvXr/ZP?=
 =?us-ascii?Q?LfPLkHUPdtVmM38j8sBUmaN4iVtT4G5PXCygxZxznkoI749iIA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?46CSJ1QWhVC7DfdTkWOuJpDdh6Vrll6E4fi9NYP6XIIZ5gLf0rQ7hCw1WAWO?=
 =?us-ascii?Q?Ednj5z3QNBMUE9v9zgaa0pz3jku6Z6Cis4ziifsoVQdywJZ7gMIJGfmVatfT?=
 =?us-ascii?Q?EvIJxnefPdjIOxI5E8I2ixgCjeWLD1GO0kK5/Jos8sPFjcs8zGhQ0IPtKAFB?=
 =?us-ascii?Q?1ZVAaVQ8Pg0OLj7jmTYNKh6F6cwSovbR4t6M6Gmw+a8i9WlLLZne4RlJzr1a?=
 =?us-ascii?Q?iSKxZOgRxHdJg6uR2xzJefWgyrW3JZlYoc2heSww3pWNV8NYM/MkW7Zqji/P?=
 =?us-ascii?Q?rkAXAYDp8WLv3cVRbsuMvUkKcz/WlPNaILzng3yNyvSgLF4rudiouWsh5zWf?=
 =?us-ascii?Q?9oYjLveE4cTze71gUVtpwwcQ+HLclijuopgUNlqBWY/tZqNeL16VXOHu1FTE?=
 =?us-ascii?Q?S6vSbZqvSN2cmujoOw7/2hv+C8dIMzsEAS7UEubUFi1MNyiX/MF+iuMkRNaG?=
 =?us-ascii?Q?ZHvAZON39AntmybbIXihblnXW7PjN64iP9dPMbX/pbhDyhTci4GuFHeSqbdx?=
 =?us-ascii?Q?5ja7ZyFMvKyELJrbs4LVlOScYMMIVun7KyCmdPG1BIUqNijthl9Bbna14hRx?=
 =?us-ascii?Q?YkTPMFZAbJFJesZ7RIIdhLS5kZVxlp3OAKLnQAkJGu1Z+jQ/domX9AI5gzPk?=
 =?us-ascii?Q?0jMk+eEsDvYWc0tep4QwUPKhZwKYW1geqfu5nagwaD8kLDwC6CyDQgb0dkh2?=
 =?us-ascii?Q?GbmCla7H6DkN9Hd0uTKYJ7cvq92urhdQTtdVhcyBcJ1XQeE4jkOiDPe/pHGA?=
 =?us-ascii?Q?OZoQdbxb1hIeFd8sHlU4tLZEWhgxx3e6GJow6K0SW7RJ02zzYYHXvK5TizAY?=
 =?us-ascii?Q?H1nzZD2oDQqxK0sG/I2WD4HNAPsjORGrJYGPmSNmEq6G+L8lYXIAg7GV3dJA?=
 =?us-ascii?Q?sUtrmfstLAw9PY+8HePFv2nyDnjp7dCnD3J8hqxOO9dQe0QNHP+5eqb2E70I?=
 =?us-ascii?Q?NF97ExqcPZVB7Ng+rihaCJkW2T/Irg1mOO/wSCiVstTgJw3l5Sj3m4rfa88z?=
 =?us-ascii?Q?J/9SoUwPI2OcNcVGu+GpBGd93irrtdM4bBimLwH11szq5B9T5Ebkr7n0FN49?=
 =?us-ascii?Q?3UIi/0X6CY0woi9DB0zhmDGGnBj/mAP9qVrjoQ1FGfPNNdad1UAn71n2stTf?=
 =?us-ascii?Q?hKRAhMtAdMDyJYXbp+E7jYIBaOiLngkrkZpHCtwcmlHHOVjwqwLzyJAFmcpP?=
 =?us-ascii?Q?4q0UBMrZOYZ4nFb4GRdTC3Q5s6a1YSQatT2wdiFoKXBCA5VRFA6xmeN3TA6H?=
 =?us-ascii?Q?5xPYLgbnufq1RV6f+4O+K7DEOsrVBsD6/fmrbgT1C2UH8mfZ7NrflYjMaEn1?=
 =?us-ascii?Q?/2yjGO2iULtmRCl6FrwK9Jgx4ouat9/vEaQNzTko0jSz1os73fGNhVGYQdu9?=
 =?us-ascii?Q?sJVsKFD7o/L4/YWIjrSsleNGB0N+nY1kQ9HnFFmIhZ5hC1kgAJ+2C4cDBVJd?=
 =?us-ascii?Q?Q0qTAHfcyonokT9nbjulcFkNW7j43aYVPSCwhYbLUZPhX1MUQJPP5lhjtqKz?=
 =?us-ascii?Q?SHdjF2UY9GC3QAE8iIhmT7g63O66HSzLBgFIGMzknKBe36Xn3uLOr8ZLq798?=
 =?us-ascii?Q?qAAClr783VnUPfuY4A+j5NBjLU7wid+nSsyOarGyNK4oWZXMQgTtB9L2LI+t?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0e3a87-07cc-4bf8-c2b6-08dd20e92561
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:28.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRwRHHX0n6DStVWTBc5MumiFBdYfvspvR+N60X6fptIGhNZoos6BHijCdareD8Co5sGUro93oulnayJ50f1RPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16937

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Adapt the npm test cases to the reworked npm fetcher:
* Add test case for latest version check
* Remove decorator for npm binary check
* Use common npm package for test cases
* Define excepted file names
* Remove test cases for (pre)mirrors, network and invalid urls because
  the reworked class is based on the wget fetcher.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 221 +++++++-----------------------------------
 1 file changed, 36 insertions(+), 185 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3fd4c82cd..09f493f8a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1507,6 +1507,14 @@ class FetchLatestVersionTest(FetcherTest):
             : "0.9.29"
    }
=20
+    test_npm_uris =3D {
+        # basic example; version pattern "A.B.C"
+        (
+            "types-node",
+            "npm://registry.npmjs.org;package=3D@types/node;version=3D16.0=
.0"
+        ) : "22.10.2"
+   }
+
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
         for k, v in self.test_git_uris.items():
@@ -1557,6 +1565,17 @@ class FetchLatestVersionTest(FetcherTest):
             r =3D bb.utils.vercmp_string(v, verstring)
             self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package %s, =
version: %s <=3D %s" % (k[0], v, verstring))
=20
+    @skipIfNoNetwork()
+    def test_npm_latest_versionstring(self):
+        for k, v in self.test_npm_uris.items():
+            self.d.setVar("PN", k[0])
+            ud =3D bb.fetch2.FetchData(k[1], self.d)
+            pupver =3D ud.method.latest_versionstring(ud, self.d)
+            verstring =3D pupver[0]
+            self.assertTrue(verstring, msg=3D"Could not find upstream vers=
ion for %s" % k[0])
+            r =3D bb.utils.vercmp_string(v, verstring)
+            self.assertTrue(r =3D=3D -1 or r =3D=3D 0, msg=3D"Package %s, =
version: %s <=3D %s" % (k[0], v, verstring))
+
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris =3D ["https://downloads.yoctoproject.org/releases/sato/=
sato-engine-0.1.tar.gz",
                       "https://downloads.yoctoproject.org/releases/sato/sa=
to-engine-0.2.tar.gz",
@@ -2618,216 +2637,48 @@ class CrateTest(FetcherTest):
             fetcher.download()
=20
 class NPMTest(FetcherTest):
-    def skipIfNoNpm():
-        import shutil
-        if not shutil.which("npm"):
-            return unittest.skip("npm not installed")
-        return lambda f: f
-
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
+        urls =3D [
+            "npm://registry.npmjs.org;package=3D@types/node;version=3D22.1=
0.2;"
+            "sha256sum=3D9dad888e5280e9969393d7410e26d4edf726a828ee4762318=
c8ddf6fcfee793e"
+        ]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-        self.assertTrue(os.path.exists(ud.localpath + ".done"))
-        self.assertTrue(os.path.exists(ud.resolvefile))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/@typ=
es-node-22.10.2.tgz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/@typ=
es-node-22.10.2.tgz.done")))
         fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, "npm")
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_bad_checksum(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
-        # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        ud =3D fetcher.ud[fetcher.urls[0]]
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-        # Modify the tarball
-        bad =3D b"bad checksum"
-        with open(ud.localpath, "wb") as f:
-            f.write(bad)
-        # Verify that the tarball is fetched again
-        fetcher.download()
-        badsum =3D hashlib.sha512(bad).hexdigest()
-        self.assertTrue(os.path.exists(ud.localpath + "_bad-checksum_" + b=
adsum))
-        self.assertTrue(os.path.exists(ud.localpath))
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_premirrors(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
-        # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        ud =3D fetcher.ud[fetcher.urls[0]]
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-
-        # Setup the mirror by renaming the download directory
-        mirrordir =3D os.path.join(self.tempdir, "mirror")
-        bb.utils.rename(self.dldir, mirrordir)
-        os.mkdir(self.dldir)
-
-        # Configure the premirror to be used
-        self.d.setVar("PREMIRRORS", "https?$://.*/.* file://%s/npm2" % mir=
rordir)
-        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
-
-        # Fetch again
-        self.assertFalse(os.path.exists(ud.localpath))
-        # The npm fetcher doesn"t handle that the .resolved file disappear=
s
-        # while the fetcher object exists, which it does when we rename th=
e
-        # download directory to "mirror" above. Thus we need a new fetcher=
 to go
-        # with the now empty download directory.
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        ud =3D fetcher.ud[fetcher.urls[0]]
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_premirrors_with_specified_filename(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
-        # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        ud =3D fetcher.ud[fetcher.urls[0]]
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-        # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, "mirror")
-        bb.utils.mkdirhier(mirrordir)
-        mirrorfilename =3D os.path.join(mirrordir, os.path.basename(ud.loc=
alpath))
-        os.replace(ud.localpath, mirrorfilename)
-        self.d.setVar("PREMIRRORS", "https?$://.*/.* file://%s" % mirrorfi=
lename)
-        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
-        # Fetch again
-        self.assertFalse(os.path.exists(ud.localpath))
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_mirrors(self):
-        # Fetch once to get a tarball
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        ud =3D fetcher.ud[fetcher.urls[0]]
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
-        # Setup the mirror
-        mirrordir =3D os.path.join(self.tempdir, "mirror")
-        bb.utils.mkdirhier(mirrordir)
-        os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(=
ud.localpath)))
-        self.d.setVar("MIRRORS", "https?$://.*/.* file://%s/" % mirrordir)
-        # Update the resolved url to an invalid url
-        with open(ud.resolvefile, "r") as f:
-            url =3D f.read()
-        uri =3D URI(url)
-        uri.path =3D "/invalid"
-        with open(ud.resolvefile, "w") as f:
-            f.write(str(uri))
-        # Fetch again
-        self.assertFalse(os.path.exists(ud.localpath))
-        fetcher.download()
-        self.assertTrue(os.path.exists(ud.localpath))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm/p=
ackage.json')))
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_destsuffix_downloadfilename(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3Df=
oo-bar.tgz"]
+        urls =3D [
+            "npm://registry.npmjs.org;package=3D@types/node;version=3D22.1=
0.2;"
+            "destsuffix=3Dfoo/bar;downloadfilename=3Dnpm2/foo-bar.tgz;"
+            "sha256sum=3D9dad888e5280e9969393d7410e26d4edf726a828ee4762318=
c8ddf6fcfee793e"
+        ]
         fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "npm2/foo-=
bar.tgz")))
         fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, "foo", "bar")
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
-
-    def test_npm_no_network_no_tarball(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
-        self.d.setVar("BB_NO_NETWORK", "1")
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
-            fetcher.download()
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_no_network_with_tarball(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0"]
-        # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        fetcher.download()
-        # Disable network access
-        self.d.setVar("BB_NO_NETWORK", "1")
-        # Fetch again
-        fetcher.download()
-        fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, "npm")
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "foo/b=
ar/package.json")))
=20
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_registry_alternate(self):
-        urls =3D ["npm://skimdb.npmjs.com;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0"]
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        fetcher.download()
-        fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, "npm")
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
-
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_latest(self):
-        url =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/nod=
e-server-example;version=3Dlatest"]
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        fetcher.download()
-        fetcher.unpack(self.unpackdir)
-        unpackdir =3D os.path.join(self.unpackdir, "npm")
-        self.assertTrue(os.path.exists(os.path.join(unpackdir, "package.js=
on")))
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_registry_invalid(self):
-        urls =3D ["npm://registry.invalid.org;package=3D@savoirfairelinux/=
node-server-example;version=3D1.0.0"]
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
-            fetcher.download()
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_package_invalid(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/in=
valid;version=3D1.0.0"]
-        fetcher =3D bb.fetch.Fetch(urls, self.d)
-        with self.assertRaises(bb.fetch2.FetchError):
-            fetcher.download()
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_version_invalid(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid"]
+        urls =3D ["npm://registry.npmjs.org;package=3D@types/node;version=
=3Dlatest"]
         with self.assertRaises(bb.fetch2.ParameterError):
-            fetcher =3D bb.fetch.Fetch(urls, self.d)
-
-    @skipIfNoNpm()
-    @skipIfNoNetwork()
-    def test_npm_registry_none(self):
-        urls =3D ["npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0"]
-        with self.assertRaises(bb.fetch2.MalformedUrl):
-            fetcher =3D bb.fetch.Fetch(urls, self.d)
+            bb.fetch.Fetch(urls, self.d)
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_none(self):
-        urls =3D ["npm://registry.npmjs.org;version=3D1.0.0"]
+        urls =3D ["npm://registry.npmjs.org;version=3D22.10.2"]
         with self.assertRaises(bb.fetch2.MissingParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_none(self):
-        urls =3D ["npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example"]
+        urls =3D ["npm://registry.npmjs.org;package=3D@types/node"]
         with self.assertRaises(bb.fetch2.MissingParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
--=20
2.39.5


