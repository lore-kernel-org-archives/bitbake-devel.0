Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF0E77198
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 15:15:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.98])
 by mx.groups.io with SMTP id smtpd.web11.22924.1736262932271212229
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 07:15:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=NW1elh4L;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.98, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfTtMGGlkJlJJ64/w08xgC9jx+Quis4we4kpoAmesfi1QZUqRS1sep6bbmdpBdmh/dd6fqm+E/FfxRTrCxfbtxNjDo685e1nuDHi5uOL2Fb7ICEtvgSnGcvPNeDC7tA77tGOEfxBdAVlxTXi0a60ggR2DVl6GM9A+C8K5PUlOiLkYEYXG4sRxTzgaSdes43Lr+eWl+PTwDvKEifd1WFraIMJgcQcHiwq+9Dx5gHXp7xeWWoW0dBdrRlchm07/58H8hgbt2u82IoR13Am95PBEG+9QAy+N+JQDQ1d8knoXzHamJM3ZMNQGB0Ma4pOSoW2SwEdLB1IfY7SsNvAOc52ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q6q3MD1M9yLb9yl5zIR0wAjclQLqSnhN/AOr6/nji4=;
 b=Y7oWBFklhTXBGaV/eSP3cuBxbMVT/O79EPflEGlc2YvKFSi9DZMbCyHl7cA4lgHJVxAxOaAkfs/9vpXBLfJy7xdUMa/tEdgE5nNY1DOLb/J3kZqCdKytOUQ+sO2G8M9+zJsGQVWNNhG13sJFARleRWsDKGTt67k9Sr7J95k49Z1bT4mXfF5I9o35SYfx+ho5dvFOg2UmbuD/T84CXfCZFghLbUMFZR8W4AKRj8w1FI8rxh5uhOA5OKyrDmN44vywNOF6wu1OlkGicsMiGT+/ivINbMWFjz8LZsNOFsu/Wk2+WLi0x5P6K9bvcFyt4X84Ut6xryr7Vvpat2mSUk2nVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q6q3MD1M9yLb9yl5zIR0wAjclQLqSnhN/AOr6/nji4=;
 b=NW1elh4Lln7i3rToEEvklsW+w3xwHnB1y3OnXPGW5ksG2XVtCxNlCZoKoARwfcfG34OEvS/Gh5bTMhbbBF1G4YskIKxaM5+EAHnuGcyCA2Q1aFao886+ey5eeOTAUQaKaSPNGrIYF+wmSWloKh/CMZf0fQTwmTIeWri9lLBVSoddaB5vMcCmIfWWD81ZFWzU0zpj8ciuaPfbuaoDRDW1cpxFNcziTqiZTJOBLXhpnhvMUdD6R57Lyc3LKGkq+FWvuwhiPvi6zcHxs6/9Tc1/o27DEWJRPhROuJW+qZ6EWoeaUfAESrE8Nt0gJtVF3Dvq1OcQbzZjVvfMHuv+CA/ByQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by VI0PR08MB10538.eurprd08.prod.outlook.com (2603:10a6:800:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:15:24 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 15:15:24 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/2] tests: utils: add test for Go mod h1 checksum
Date: Tue,  7 Jan 2025 16:15:14 +0100
Message-ID: <20250107151514.8115-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107151514.8115-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250107151514.8115-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|VI0PR08MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfee39f-f451-4f86-fb48-08dd2f2e1c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?maYEULxE+OqurOdnl94VLIT7xG2Ottj9DDjGxXug5qp+w3GtON8uo4+d4dnl?=
 =?us-ascii?Q?Z7omrxrNTKSROgG/q6N0cru95CSZsmd4Q15lOm1DmuB1GpZWuD72uS3UG4AN?=
 =?us-ascii?Q?cWq+8yUoxTunyyF1fd19iAIo/cJqEy+aYvlPGDAwU5kGu4+o0c6EJ0Z+mdqW?=
 =?us-ascii?Q?q/uPpaqiukmDrT15mZJkCyIs7u16uwWTiq20QEn/mS9AxFCOWsmOZuE9pHrB?=
 =?us-ascii?Q?KgtdcG/kKFSAblXKwWFNG9GSTl/dwoexbVwWiLIM4MDfgPGaoeRi7tZz2hc2?=
 =?us-ascii?Q?+gd54u39FzaJNppDhawvt9v9C6zfFPFQHkpsJz76/VybbWEqg3aNEgxOHYtW?=
 =?us-ascii?Q?ZaPs72XYTaRZYsJD2qwhEroeD5zhZO9wWsACFlAfhWdp97KJ7MyxyJp8IpX5?=
 =?us-ascii?Q?YYQomNZC9KT6R2aouzoNSuJYHV8cPsSPVoWPsKwLd1uiIgPfBI9g7GT2bnQ0?=
 =?us-ascii?Q?bnpsX/kx18wz//uH4cxCZSGx+56rVeHYGkA0nlNC4otYk080sCP9DhKAAiYP?=
 =?us-ascii?Q?euuKj5a9liY59aQb1As8tScNx8G/TCkehcgdozYxEfidSljSbAUxK4MOU/zh?=
 =?us-ascii?Q?6wYIG2qe1soXNb/oz3GmIkYjyqCC0gEteXSTQjAXKD+K7zMGPcIyKh4JQ3YU?=
 =?us-ascii?Q?9qLbHmU3WcCaHvsKE4WmmTP75hqrcUClJVMMmoPhjyoUMnr65KryhwrkGrhU?=
 =?us-ascii?Q?N29EhwLE0QedcXzibG0Zq0X0VSxjlID9rwCZ6G3tw0lSdv732jVixCpqgHTB?=
 =?us-ascii?Q?nFnAPsIH0OBfJ8P8BxYqfq0eP/cEJ+lcAGXJV6qzHpk4aJPW0A3qHb4kwzXg?=
 =?us-ascii?Q?vMrFeaHxr9BbTwUPmG4AGp2YGCVBURAGGg5qK1KBq1cWF+0CYVfq3KJR9DvX?=
 =?us-ascii?Q?19XqXkk9jA83p6ZYBwoHsLjGGaZm/TOiIZ3ky0r9Xo4kjvbYw+0UYVHyNiKt?=
 =?us-ascii?Q?Be7W0MXTg83P7zRu733V6Q9686dpK+Wd0ryt9GA5eDxTqPT9I4oeqXnLhXE8?=
 =?us-ascii?Q?0/PaDuh/Ts+MyQBoMg2Hik8GnjksXESN8Sgfo1zIC/AtTiZ2JkvYoWpzEZBw?=
 =?us-ascii?Q?Kxv/XYE+SZKB/fvkE9BRabOw8kzDG6LJ5yc4BTjoaa4KTNcQFGndPeTqQz8Z?=
 =?us-ascii?Q?Q4gy8WA1W2Alohmrtr8mWcvgNGQ9y2IAoXxzdTZ2B717g7O2JOzmUfOpHpvk?=
 =?us-ascii?Q?9VNsnhdmapSFxDFSoKtflwslm9gapWys+OoklvHKBMj705kDbwQ0Dwk678Nb?=
 =?us-ascii?Q?IM+cfOSRz3baHJCs79K9WdS5coOThKzfsJZfXlpkRRqaX3hAMpUFGLFFB2Zk?=
 =?us-ascii?Q?g9hBFDyFM+q71U5ZXRC9bgUWCWfoQ5fXILiJnLKp8Ggc6w52Fq9qsrRHYWD4?=
 =?us-ascii?Q?xc39SQbJ0iSzgfZsg+q1hj/E9qNGdpeON3E56ITb4Y0T+IuCNykZQ659AXb9?=
 =?us-ascii?Q?s44Bf0II976ULeHqxJey3ZrI1mDUNaUp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Bk5a/vo/SKJYTmkH9BHSjZcEF+8qc2yCzaHxlXkLHZyJy8rwWB2DM9nBDjqT?=
 =?us-ascii?Q?Wld6F1/g79dEir/N2tRVJ56HMktxqzX6NJn+fjQ+12w+qUwAK6gNkN1BV0SI?=
 =?us-ascii?Q?VryyjQy00uLiJqZwJfppnb/Qldyus4WLv/7hFrTLcnMY4Vi0/alvrTeOZ0jA?=
 =?us-ascii?Q?wpD0ZpivLM2Lm2grDZ5coqxZ5ItsCbi8uKBFdgXoCHnb+fe+cLo5JKN9/ZML?=
 =?us-ascii?Q?+Sqhvwla1t0Fb+bSTmN3prbwTTnfFqaq+KsXKL10YisMnNnacs86n4WhmLbS?=
 =?us-ascii?Q?MapCEW1OGOAUdInL+sHkzR8hu2stXzDUffBRLdJSMSTlEcBKi6hSK+LI4SuQ?=
 =?us-ascii?Q?4MB1iipVbbTmGP2RDKAxpMPmCRWxNTybNQgWwBgSP4OubrjggXxwN/y6rk4f?=
 =?us-ascii?Q?P+0GF0FWQIfVBNE9hHwbVXtc0p5MidyxsM8DD4Y7fi+QaqucJF1SRlkXrCNO?=
 =?us-ascii?Q?3GRToa2dQsWKy6y7AaVrXemPW4Fel7KRNTZEqWu3uSvdpsyvj1JG8XqigVwU?=
 =?us-ascii?Q?CK0DvksPHK1rU6Vp4IzjlFAITxMlZbRp817x6jA/e+TWk2AnE3z7o4XFpwvp?=
 =?us-ascii?Q?dCOT/PcO67VPbzsQtuIE8H21H0A+VBVFGhhGmUg0pklxPeoNJCyhR4ApJylc?=
 =?us-ascii?Q?g7/adMXPA8CIjdHLbn+TZ0i0jXahJU+bDXkxbc47bav4+gVNJxYnkCJrHTH2?=
 =?us-ascii?Q?aS51pk38hLsYCwPzbATmWTV/X67Mh+M8PCIKXl8UWmsg5+xIgqwQg5sN3mqH?=
 =?us-ascii?Q?dNZ8UxVffN75ezQ1BUMfQOxit+zct23xX7wmNgz2UJ4mSN9AX2+xQtBF/dam?=
 =?us-ascii?Q?fgrbqWnOuw55V1fWyVne7FoxiSpWtJTithJJ1CNnapZJCTHPcmL9ozNUVRAI?=
 =?us-ascii?Q?DPBvdT71ywfgdG6EPU0OAuIzL9z5e609YH/a3vpBTT2N14Tz1XanSI8vcClB?=
 =?us-ascii?Q?zcOLsYbWeTCsNW8UheWTU+2vuPRtWWVf9w8uejT3A78xyWYDrfX97uPUtJTI?=
 =?us-ascii?Q?fFe70vQsymvVC0yKx6fR16G/7YJJ7haGqQYASeMVz2dvbflAV5zcv8+cCr1t?=
 =?us-ascii?Q?ptgMvo23cVzGIf6PLmLvcvlv64nFZhEiy6VMsrmmWeg41rqx1itqlD4l+j8E?=
 =?us-ascii?Q?+vYfuHlrpgfVK6o+uQSDn99MhpD6QU5xyg/slMEc6IAZj1PY2wnmtyTrPARZ?=
 =?us-ascii?Q?TbBMNvVtKK5RSYw8aYfBYHJyJj+STwGXbEVAUD89wa+av7STQ9Mv7mjI/ZMl?=
 =?us-ascii?Q?AFaCqV24Im8MlqM7szilP9FxW2M4QAnfpFoj/s9Saslc6t0nyUaTu51htbQ4?=
 =?us-ascii?Q?12l9y2ev9+a0Paj9JpxozhYkBC3liZOk3utqUR8JPir9xzccNyIIkZ8NjuOt?=
 =?us-ascii?Q?k5Y6uy1ZFtPCgE6lsq2NpwxFSRZjZK2+joM7GYbi4vcL62VN5TJuB9NtwwN/?=
 =?us-ascii?Q?mKXq1uRsFu56yFUj5w+3/OsKuC3pVNctshCXyoXU2DQOBTg44mCQ7jSjJ1NT?=
 =?us-ascii?Q?zgtxn2cLA1wEpZ1rCWTJjtv6vDr5rwgwFIdB/8FlV8xQSZCSXMVhtxXK7cp0?=
 =?us-ascii?Q?FzmfLQ7DycB0aSe73BQ9239xePxEjwM9US4CfYvA33D/uvx9ZGyrIOEfi3I8?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfee39f-f451-4f86-fb48-08dd2f2e1c10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:15:24.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ipdgmv3Tauljo9K5ev8j/i9UuJ3S3PnYzWcLmcoMapnIkg/NGQvN34uiAXlj9+Lpz4awQbnX92VZbabCZed0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10538
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 15:15:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16980

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a basic test for the goh1_file function.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/tests/utils.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index c363f62d7..48e61dfce 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -130,6 +130,14 @@ class Checksum(unittest.TestCase):
             checksum =3D bb.utils.sha256_file(f.name)
             self.assertEqual(checksum, "fcfbae8bf6b721dbb9d2dc6a9334a58f20=
31a9a9b302999243f99da4d7f12d0f")
=20
+    def test_goh1(self):
+        import hashlib
+        with tempfile.NamedTemporaryFile() as f:
+            f.write(self.filler)
+            f.flush()
+            checksum =3D bb.utils.goh1_file(f.name)
+            self.assertEqual(checksum, "81191f04d4abf413e5badd234814e4202d=
9efa73e6f9437e9ddd6b8165b569ef")
+
 class EditMetadataFile(unittest.TestCase):
     _origfile =3D """
 # A comment
--=20
2.39.5


