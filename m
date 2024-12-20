Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C8E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:51 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.149745.1734693993938884026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=tlmbFOax;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKpWZ9S+RH8ffwbOpm+XLckqb54pcZttJB9bf+WzHWX5Td8+5YBxhhS5H6n9nXKUwpBanLhobIUW/GmoxSsYEU2cIDIEodmas+fjhRjCSYCCY6NHxyHmO6Ea1ZVbo9yCIZh9TAZ+Ij8ikzMYu0rFbpgN+9LdwVUcOTcyKKv0G0ndEZt3WvaYyIIkOrIP0Pm2ACC3lBizAqW0CB0TMkrH6sFCMPEnM8y9Ss5PgSeZubeargpDRZgTaLkMbI+0TBNYI6mjaMcuT/Na/l5spkivbPIcd/X2FEFL6j/w3RwVfInG+r/CT8r0Ww+IdF/QhYFKYUUFxpoZVrVgb8Z9TWZOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jusmXzbEL2xi/yTDZ7sX+cOybecyn5mJcQGTzq32W1c=;
 b=aW1oX1mb5z27nfjOqp+fELd8U1tTe9MEVlmEm8knoR83r0g0X7S7T57yB0v+12j/KbS7FcZEn/BDmr3Y5CgcQgHoWbE+Oll+Vuj+lVnDHLaytuH6HRJ2dV76HOaoERrYSqHaTyRU1Q13tQUZs77yInK2CPsaFRpNeZ4b2o91OIhaKt7C84Cd9G71Mxui0JwWmspPfr9aOwE/Mi/MRsmpl+NE1vjaYcZp3wba2I7KX1rECgbM5TsAZsG0WStcXkW2DUvJAUVF3ysaqJWOcpDLuuPmKo7PfpSy/Xcc3iiCUmLHWhujY3PUShtB0HbT7Dy5FTOQgrXahe3D5s+tYfGyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jusmXzbEL2xi/yTDZ7sX+cOybecyn5mJcQGTzq32W1c=;
 b=tlmbFOaxqba8kc3XvyXtSTAk1dF3lJGCUtuuX/g5amNM2oZQOTnjFXS2AYKDfsxop+0hj7cw0/D2Uch2rY4jVjXLupriLanhv+BD1lVKZByAh4zU+/v/WGyHqrsnw00MppN3tJqLZhUH0W6Q1vmMP6kGi2/usMRP9oM/I9WpOZ7ssTB4bEUaMBm0Up6fExOrMoiS2SUuD4mJ8FiNz6o245ALcmJ62K7AgnfTR3sY3/8uO5T5m4xJYlRrD3MlMQqKFoLvAL+/aqr1URUQMh2/qRu4f7OSIL/sFxGI59d+x6AiYiO0KP1vhidAJMnhObYNMyyo2GyaxooJ/NzhkJrGeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:26:32 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:32 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 21/21] tests: fetch: add test cases for cargolock
Date: Fri, 20 Dec 2024 12:26:12 +0100
Message-ID: <20241220112613.22647-22-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM8PR08MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: f168832f-9c2a-478f-6295-08dd20e926de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Z/k0wDjBgto+yCzQKdYxcFkbGEszZUGc5Gm9TZZC0pPdoKJoOXDhH9uDagA+?=
 =?us-ascii?Q?BwGqHiGRoha45RerDnjZaKROWkxjlax6L64nw37wPmv8xdt7d7xjOE2Vt8QZ?=
 =?us-ascii?Q?4zM8UECIBxzaHwnTtnBXepNVqsdSqBd6AAmWD9X0Gxs/nnSVhihu0cNpJ/ST?=
 =?us-ascii?Q?0Jmp67nEN1nOmvr92GmFtYjjr8xxy3JIsPi8P2N+0dk6juKOpeQmoEs/SG7b?=
 =?us-ascii?Q?ldp+roKD5kd71pCuG9FX2cmj/ZTEvbWRRMsXd3wKp0L085Hq6UzDJWSZN+mv?=
 =?us-ascii?Q?F+qGLz1RiTXlNEYIgnS2fNmf1TqC4LGgFtcNNpX3jLWqui89OM5lgKopfup/?=
 =?us-ascii?Q?qpRnyrLbuhRVdn6/66ULziPomG3MnYvSMy6TOl2WcOITdDXHzKONFdHa3BR9?=
 =?us-ascii?Q?gQjWayN33061coRl2+VJEA6psYGt5ovzkILjayvsRwKFTW5EhyS4MX5vz9qi?=
 =?us-ascii?Q?dJK6L0ydBW9OLZDuZ2biUbCE//zPdhMPGl6izgJgfD4Kd9iZAryBYL4i6Ota?=
 =?us-ascii?Q?FQB7ef/ryHGt6YB5ntIr7jwIZh8JJdDybiZ/5FYpKLLTi2q9fXEXC3id11Wo?=
 =?us-ascii?Q?15Xs3GyGUsYghG2cYHvVNyKZ1Yp8aqzLVQzjDYPhMpOmmQ19TTmw1HM74GKQ?=
 =?us-ascii?Q?UOMlkfnmNMZbhpGrSQ2Eqa9nCIuR4gWVZ5R2plT+VjxN2YQPuZ1znp+blWU3?=
 =?us-ascii?Q?S4nzz5zY7oEgcbqnkvuK7DsT+5I5WCcUXW42JznGUMJXf4lD28XLRI/56OpA?=
 =?us-ascii?Q?QOOCOSoGk8jDSC3am6t9aWPGpKADS512RlOX6rXokQCVvwNGtrH7fdwqL+p8?=
 =?us-ascii?Q?IbEBQ2DaQEoiWnqxXqYWIFdphFjFdpZ4/zsk7jeK4gIEfPD6KHJsvqkOSQKs?=
 =?us-ascii?Q?YHksr3a+mYRh+S1NHxJBz2MwNvqhE3KbO3vljmvnSZOgXPCS+0NrWi7OlD8i?=
 =?us-ascii?Q?Gepasabk0EnsueFdNr1K5Lv6Df18Uer8XfPScygfQlIkGzuzWx68MW9WUdfE?=
 =?us-ascii?Q?YT4m74kJAbxkPvear+sRzLL02LfnG/bwY6fuF6Te4HaYAhONCGdaPADj2qEb?=
 =?us-ascii?Q?PB3XtgIGZ1VSIpgLkv9/Tun/3JqXimHaljKnrH/cbakFnJvoIUV5sLufBdwe?=
 =?us-ascii?Q?kxB8VunLJU3GRK49VZ5ZJ5FoUGrnUTyjCV5ovRx51k5XcaK4HadKPm3mocVm?=
 =?us-ascii?Q?7HcPCa8PVDR0ohHhcHvLqxOgaM/TE+4p1UGrPcMc5j2fayVyLjLXnsB3d8/5?=
 =?us-ascii?Q?42yQu9drvPJ7ReNp7ABh10dwfY1UXQJtgWOkw1+niyjszVwZKr2qiWFlC98/?=
 =?us-ascii?Q?RszY5ceg1Dk76vwkJTd6MpqGFGbqC5lxBFZA0LaKx+HWTpejP50fBbLpwDgX?=
 =?us-ascii?Q?uNWb/op8RzgA8EPUZPVQv2q0/T3schLQz6D9WLTUPZAgwHV4Pw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ETcggvnqcTVs7/tP6MYXjhFTZyDYRIQBvSZ90GHrYFpK8kG6DXV06u2m9cNv?=
 =?us-ascii?Q?rhpNlPoH4xL4KcAW8I5QKtq4FHuQU4LquiTCIw4eVeuaDl9U9GXs0SlHdb82?=
 =?us-ascii?Q?9yP/srkTverNSBiz3j1SHreQ9p2Vxu7OZi3m3M/pXWtsVA0hxX1QgMLN8cVx?=
 =?us-ascii?Q?TJojrCVJH26cgSr9nSsr87yGsfoo0UXXWVSBECpeP8BPnMs4YTqRJC/Hr0ox?=
 =?us-ascii?Q?yBzLv5ezLrF8AC0le7NUPBOA3ejs4vZJGLGPngujt9X3I9gdH4Xap/sczTLc?=
 =?us-ascii?Q?jZqqwpUOtw57ir7Nvgpp4FvbsTpp9c3ZqEgrsuwc+QcSiUk0giBSmfeefaFk?=
 =?us-ascii?Q?WxmDX9c5vJKjMu5Vubxr986s2glg1dRVPnrpR62GNFzp3TsFDFAIcWIrH8Nr?=
 =?us-ascii?Q?4jD4kZOg+j2HPDC1frlV3T/cyfm31FwYXIo6pn7rvf3SSDSvZWjACYE6W43a?=
 =?us-ascii?Q?sUg0D8fPrBCtXadV1vdSGZmWmKrtqwgLnoRwPo5DM0O7urGbD+JiY8YhkEU0?=
 =?us-ascii?Q?EG0kVYmLb1kjjVSDOvMotuaONYp4WgyICF7LrvURJaGnqBk4CRrf+LtOiG51?=
 =?us-ascii?Q?8gcuW7G8f5w9azn8DI7aZ3LnhPMuHACzgxgvp+uoM0pbKRMs4e3VM4kb2/Lp?=
 =?us-ascii?Q?4BJK8iq4b3kmBrvr93FTdYlyc781EBdFYvzLPxkyYS0hXns0AUtGaZoTNCt5?=
 =?us-ascii?Q?FZWjpEqOVKwAwu6886l8bh4Y2SovIUZtEIjG0T2eIKF91wchNrPllMsgHhOP?=
 =?us-ascii?Q?zNPm34XE/yksDpouJWmS0pwRhS/Y8jRtJm196PPBlTvpl1mrmEkYSPwanqd/?=
 =?us-ascii?Q?Sn3urCnehnkZYzPNl1YcBBhyTMJw95Xr/kxKN2DaM/bns34Gv/ECWw3tljcU?=
 =?us-ascii?Q?kXzR7K5Tue0w+duEPVbZ4cZ1Ac+0A4YAlsQw2tT0U7CxAcJDaKWahee3yhiW?=
 =?us-ascii?Q?VQu9wD2YqNICnK23H7d+uBRUlusHmqgE1Vi/oxzjRP8136AHTPrgiz6uqxyC?=
 =?us-ascii?Q?cU0JDiZvVN4ShY+MTyRVAtOVG7bzvgYRKuD8/lYeHqfhJV+Ps7S1oP+XQA3S?=
 =?us-ascii?Q?q5GX27HjTK6iWOAAE7lRK43cC/xaQKCKwibSIMV9VQd43QVXeU1YuK0nZ7lQ?=
 =?us-ascii?Q?bh89gLt5h0V0yAeUG/gmoI7raIi2DBhyPwu27oCFRhl4ZsS59AabXbeZlkJT?=
 =?us-ascii?Q?j/XZNhT29bnTv4PPizXDUiNws9Yh3POdkcrhD6wI086efiJeBHViQ+X5T7mm?=
 =?us-ascii?Q?H/Y4kgTTwcNlpnOE5A8b3n86JjoYW7J98VjU+5QAIhVfRVQEnQzQDKKRuOZY?=
 =?us-ascii?Q?66ZX3hPY+mx1hL5QRpTNBU5JqAXRl76uYNBdmyAb3Ytn3mJV1o+1d98toDJU?=
 =?us-ascii?Q?rhf9uFj/cCkOJL3fF7mZ6UtrQgdLgnqzHgY+iqB9GByj1lFLasiPhD8BFMIN?=
 =?us-ascii?Q?lYWm6SvVYb/Xm79ZfP7VmDvzZ4nUSnvId30Wv9xZFJQx+/gKa2ui43bhxuqR?=
 =?us-ascii?Q?QSEu09vLfhLFNN/FrJ4OQpPljBiiGN1Q1/Xo6yJyNNj2sFX2RTHNds09nhAS?=
 =?us-ascii?Q?1h+6PCf6GPfZ9z3xwz/xSGEb7IxuhlG6gYFK0nWsRWDJgUaOUJkTQbp6s774?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f168832f-9c2a-478f-6295-08dd20e926de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:30.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ+d3w/ACy0LdfLBBYxq0mjCdHgbnQ/5kfNC03MsUFi/vur6h+uzf3Itt3AyqafNhav1MRx2zW6tf0jUd8jS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16941

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/tests/fetch.py | 75 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 30c821a67..37146c087 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3495,3 +3495,78 @@ class GoSumTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "azblo=
b/go.sum")))
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "azblo=
b/pkg/mod/cache/download/golang.org/x/net/@v/v0.0.0-20220425223048-2871e0cb=
64e4.zip")))
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "azblo=
b/pkg/mod/cache/download/golang.org/x/net/@v/v0.0.0-20220425223048-2871e0cb=
64e4.mod")))
+
+class CargoLockTest(FetcherTest):
+    def setUp(self):
+        super().setUp()
+        self.localsrcdir =3D os.path.join(self.tempdir, "localsrc")
+        os.makedirs(self.localsrcdir)
+        self.d.setVar("FILESPATH", self.localsrcdir)
+
+    def create_cargo_lock_file(self, data):
+        import tomllib
+        filename =3D "Cargo.lock"
+        with open(os.path.join(self.localsrcdir, filename), "w") as f:
+            for package in data.get("package", []):
+                f.write("\n[[package]]\n")
+                for key in package.keys():
+                    f.write(f'{key} =3D "{package[key]}"\n')
+        return filename
+
+    @skipIfNoNetwork()
+    def test_cargolock(self):
+        filename =3D self.create_cargo_lock_file({
+            "package": [
+                {
+                    "name": "regex",
+                    "version": "1.4.0",
+                    "source": "registry+https://github.com/rust-lang/crate=
s.io-index",
+                    "checksum": "36f45b719a674bf4b828ff318906d6c133264c793=
eff7a41e30074a45b5099e2"
+                }, {
+                    "name": "regex",
+                    "version": "1.5.0",
+                    "source": "git+https://github.com/rust-lang/regex.git#=
9f9f693768c584971a4d53bc3c586c33ed3a6831"
+                }
+            ]
+        })
+        fetcher =3D bb.fetch.Fetch([f"cargolock://{filename}"], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "regex-1.4=
.0.crate")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "regex-1.4=
.0.crate.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gith=
ub.com.rust-lang.regex.git")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "Cargo=
.lock")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "cargo=
_home/bitbake/regex-1.4.0/Cargo.toml")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "cargo=
_home/bitbake/regex-1.5.0/Cargo.toml")))
+
+    @skipIfNoNetwork()
+    def test_cargolock_https(self):
+        urls =3D [
+            "cargolock+https://download.gnome.org/sources/librsvg/2.58/lib=
rsvg-2.58.2.tar.xz;"
+            "striplevel=3D1;subdir=3Dlibrsvg-2.58.2;"
+            "sha256sum=3D18e9d70c08cf25f50d610d6d5af571561d67cf4179f962e04=
266475df6e2e224"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "librsvg-2=
.58.2.tar.xz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "librsvg-2=
.58.2.tar.xz.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "adler-1.0=
.2.crate")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "adler-1.0=
.2.crate.done")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "librs=
vg-2.58.2/Cargo.toml")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "librs=
vg-2.58.2/cargo_home/bitbake/adler-1.0.2/Cargo.toml")))
+
+    @skipIfNoNetwork()
+    def test_cargolock_git(self):
+        urls =3D [
+            "cargolock+git://gitlab.gnome.org/GNOME/librsvg.git;protocol=
=3Dhttps;"
+            "nobranch=3D1;rev=3Def5c94d8362c35573d7eb651cf9a07c6df9df6da"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gitl=
ab.gnome.org.GNOME.librsvg.git")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "adler-1.0=
.2.crate")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "adler-1.0=
.2.crate.done")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git/C=
argo.toml")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "git/c=
argo_home/bitbake/adler-1.0.2/Cargo.toml")))
--=20
2.39.5


