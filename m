Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DABCA100B
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:45 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=GEElsScc;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrIdsS90EznWbn5ADFaGzDLeNio5sQSBDZcHQusoY0iA72UpLu3OB7S0Z/VELCLQ/RUoD44/r4FcDHRlGDTrS3Aug8N+529PuQQRUdSTjAm8Cj2dTTLDFA2GxrU1uNEv2Hwm6Ae0YXVCkFAz037CK1N9h59zXuj25CK4RkUHhgr9u3y65JlZFb6i2wJJt5JVi5ugdoycR4hgUTMmbzA3xb5EtbvDBXMPAQsSWY+unFqn1vJDNmXaUMbXWlKgsXgRwcaJNpqaOHN3KH2e0tX4cCr2rkRQBPIW1gi5p2yb2jzMY0UGScGx9jBZV8fgS4OmRnmEoRKGxzZ8Hu9LCcTraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpYlOHQQtioKu3Fs3/rIu1WRihUuP3KTMxEYY4oWG7Y=;
 b=haNemamC0l04ybEXTR9uQAfJdys4QwSfxje80n4yLzwm+y2grhM2yeK/+Aax3km2wiMbc1I7NRi+FZ0CeY/Ao4WCzLLINQO1o8sA7jEd7kpD2RJ5bkQuph3QCFp51z5/BuQljV7kJ79BUZHyvVOXDiFVpbwKv1uAVPmnWLOcbeRm/zR7g6YROYbrj/45plbePibC575yMQtfZqqeuCcDuKmTs1yu0WBAMyeLwwL1JLIvSnss5TqrjDC2liO1eMRDTE+x70DrVrAQUIIOGzUZbEI1U0b1iYvgewFhFaZv2fp6I2utL/FOu46PTfmYerNlBZNm1RJ9z5q789oJ1piz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpYlOHQQtioKu3Fs3/rIu1WRihUuP3KTMxEYY4oWG7Y=;
 b=GEElsSccY5LvZGYvSlA5aeAuZWVE37dIkavfr6S0CClBi2oAayyUo3h835/C8imjmQdKcjmiUYHTNvjLSLnapT62ETWWrE6zFdlQSeejI/WLfRsYzPr7qGFM9GGcBQd7w0RFiWsv5iMgepafUnTGboEyGpufWnayPVgzL9Lddf6bUVHLvlssssWceNUge64Qlh5Mn7WHYVIc0+0GvpYQoFjep+N3d6euZD5PUSMqI4Dg5KPPryOpftgHmfk/5kse1xP/uHUYz9A49Lxekbp1zB9hipNc1D7Vpv5e3L3IUuJAJn6fONpkiHbBqHCBsuhzJfYX3D3IA4cw3Q2b/cFk8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:36 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:36 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 01/15] tests: fetch: add test case for local paths
Date: Tue,  2 Sep 2025 08:45:00 +0200
Message-ID: <20250902064515.30879-2-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f4b7c63-6f6d-410b-83f2-08dde9ec51f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EHA3AUKA/EtKJrZ8tz/eyjyHZpmcplhX1iiGCSsoCA65BjAZcQ2GeIPIXIyJ?=
 =?us-ascii?Q?jwBXxTi8wz+3zqT7e82wQz74JvKGsd07vd8X26eYdcENATeGzY6sOeSDY4aL?=
 =?us-ascii?Q?zIbdiL5m1TwQJg+rT7CfK7qyzO4Ey+GtYOorb40Nu9E0lyob/OxFiWx3hBDe?=
 =?us-ascii?Q?e/JQscjP848MlDt9Kc8jiAhf3/JuTp0DysJk0V0UIW/PHBqmUeCC+87SAt7G?=
 =?us-ascii?Q?WSs8DwGgNybUiW//9kKTEvrUWyIWa/2pHkLWpmdT0CiP9r7KwNwctFPq4kXe?=
 =?us-ascii?Q?WGOul9OQOl1wIm2AXnwdplCK6MujgVlzMJUEKUdAeZhoE3iiBAdFecsEsIe8?=
 =?us-ascii?Q?upH9wHNAh+xcA6xapY4TgGpsgcoJr/e+08NSqAv6Z96TdwI29AD3/E4D8PxA?=
 =?us-ascii?Q?wPdX98mCNnkGbmRnu6n9p8VnRzNSeeFwSED/70m/+UC0DcwZXXFrZKUaSoeb?=
 =?us-ascii?Q?M00ErnmRlOYqkT7X8IiBsHQQ3YOgYqTENw8xZHL2QrqBfdFObbDdQKscZ4Qv?=
 =?us-ascii?Q?c177U4rLeqQ3+GPD0nu29SMs8rtiLclTnqakNLLMoZ0/J0MCVA5H37xHtykh?=
 =?us-ascii?Q?7rwrC0ykFaGg35uagDZb41TYyeOZYTb7gSej586oQGk2eWbw7SLS3yhdY2uM?=
 =?us-ascii?Q?yws0uizdqhHccvePlub02BVgOtvyrmYVNJOI6/uNMwm/+KoAUAqzcfGnRHEt?=
 =?us-ascii?Q?mqdgBpKoZTtkz4S/OkpfpwUUrxjiGRyBgEQisDWhHhTYsIoaj1lfG7QNCZHH?=
 =?us-ascii?Q?c/Q0xAkq7FjLJ5k29lrKOU/5rga0G4IkHj/qtc8yog/dcqlD63LvGYue332B?=
 =?us-ascii?Q?kY2VmexvViSf2KCKjRYrgOvUDNZlMMCtr04ZWhei0gJRkJLpVLeAikgbnhTY?=
 =?us-ascii?Q?+ify39rBy2C+UWZbambj9rgbY8wL1Sqi1G87aYnRjuFro4vLrkyH3+e87TPm?=
 =?us-ascii?Q?GtyxAlSufTFOVJpVbjEgF20rmmZiT2aRYTSytQuGalJMuSJM+b0YNnRY8hgL?=
 =?us-ascii?Q?AmmwoEYKx6JIbpiWbAMQVr5H/vv3jwSR/fn2DT0OKOL+rwWUdRZpszsBWsVS?=
 =?us-ascii?Q?rSoA/WtyDUIT629YyIMHFleF30Bcq9H+pgUQVdm/ZtgPkgbfJXOIEMLlDPV8?=
 =?us-ascii?Q?IE0BsNjM6MC1GuE19XbXqzbCRRRCgDkpR6q4GGfJWNVx9O1M1PqrHPpwxJIc?=
 =?us-ascii?Q?VIAbUL8dju1ZbKmuepeM7mbs6M1wAvAuzVHUO/FRfTwF9yC2sa6Vjuq+pMRz?=
 =?us-ascii?Q?GAR+Dl97UhY7FUif9gNgdD3qmyIKLqevvDSM5NSkulu/uXUiXKf7oJpqeLY4?=
 =?us-ascii?Q?ya7drARHQNyW9nY+dbU8V9LTBMLzRPAGxNMBjLR9AHsaDTRYJsyJXSTSQR1J?=
 =?us-ascii?Q?+f90pE5MG3/4OVfJ970H0NUL6oXMyIVsU0FrCfRdjpSyH5IZC8gyZqvjoCqO?=
 =?us-ascii?Q?jZ7GioRKdkU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SIXue7lcW3dn4P1UBireENKNPVE+0gRaNuxiVvq2CL0jgjukc2DqVjB30QUV?=
 =?us-ascii?Q?0qqXZlA8UnDD8cMn8Lld2V+L5tTZclmlX2YIK5o8/kZYCOO77hW8Ygdy/f6R?=
 =?us-ascii?Q?L0+4YaC4UhTtrutPt1BDx2TLNYiCnWQPBM+f3mGZvpDREfg8k6kmCxNB8Mdb?=
 =?us-ascii?Q?kv65shNZ+bF7GG2N/i1eGgRg6PGx59gHXrLX3tOkONIiBlzVxmwGU+kQIzuX?=
 =?us-ascii?Q?7Do05cBHlXvgsAGlNtcst4+yHCcujxwHTE6gw2J1TGeV/a+b2nmuj2YZoUko?=
 =?us-ascii?Q?2SozeMOBUreRdrbao5Jdc6SlxkpxTBQQrrljAYGHtY067yZkhSocMLwT5ZfV?=
 =?us-ascii?Q?aH5EmFWamJNa/5GB2tBDAgoqK1U4uGp6xwkniP1ZIp+kXOH8QmZuulCy464y?=
 =?us-ascii?Q?ksSKQVw4OOf8WBp+v+1S+iehJK3/L5ii+gj+Dkr2InHpT9RLV3VqxR3+mc6M?=
 =?us-ascii?Q?daBQEgLnIiGbyZNPH05q8WJejVaIOnJfe2BtcQgOv/TdEyy0gAzvrCJIPpak?=
 =?us-ascii?Q?Z4CaWTk6m4a87EhCdA8ezq7gRCBA+cl/YNDdA9XD4kviCcz2q1siIetVQ9lW?=
 =?us-ascii?Q?GcFXv84B1pwqzAOo2PlVFwhL5FdSbTMnzn71YbvZvqjnzkzi6Dyd0jthsdnd?=
 =?us-ascii?Q?VcoQrSS4c7B8XGSqfE1Hbi4vHoWEdcCDWxpiAPz8xgPMjoAGr1/ofDuVOef8?=
 =?us-ascii?Q?SYUYAHYcUXhy7zsCFfhjgcb6bp2H0chuMk2j5sok2nXQJROzq1QAGc9uCOoB?=
 =?us-ascii?Q?HXcfNKPdp7Ccgm1cjcyYe4kWVg6w0A21yrgrc84QMWmQcQ5Jcbeh/kxqfNqe?=
 =?us-ascii?Q?lkefopBXVme29Rj2Bswt+lOK4HekzXMxx727l2U4L5TtYnUksq0q3fWDJc1e?=
 =?us-ascii?Q?tRjifTf+e63yzblLs5Fn44z3o9rsS1O4UTLIEP/8fY6/z5j4MmHgVhZ+V7SY?=
 =?us-ascii?Q?qpjLmLl0lODNd+/bcKQTgcCY93eOrY/Os2i7sxSPjvTGtr139HMysJlQr0Lx?=
 =?us-ascii?Q?T//I0nqH8/RSqyqMBtCsuJSv/3RzJbShCa/DtsmbrAIqJUeJrGRVY625jGfG?=
 =?us-ascii?Q?SHagL9JwJKvPk6Kv1FddvsTgwA9DB8/ghw4w2KCQMj4mPbLKD90j74xbuG1q?=
 =?us-ascii?Q?yJQYcHyJC+xFCjvKPBpurBJ54oslAUP0R5nClISbO9eRuUTpX1gO8osV+Xeu?=
 =?us-ascii?Q?w3HFD0MOnPdN23TQS2Td49nMezEmynsYzpThL7ww1hlZoMwyM75rM7uyT4a6?=
 =?us-ascii?Q?ZcVADqqUtCLzQq45MYr8RoKc2JbMZSZ0od34h3LJxtkddkG7vC1LniR2IM9t?=
 =?us-ascii?Q?auNGo4Vi8SpYC3v45T77LmKx6L5Da26nXbY7uJ8GvVz3SuCXZp7pMQmffy0q?=
 =?us-ascii?Q?m+Yzr4hAW7T9bKnTDTVAFsvA4fMOsOnNzSQcFcIEuBfk4i5jYpC/SzeMSzBm?=
 =?us-ascii?Q?IvxB/mowE2O5pT0iZQUAyQJf7HSpdjqsXygZcuy2LLPGY39lunzVoePMQml5?=
 =?us-ascii?Q?eiZzERfAS7u2FW1tMj3pqQH59OO4NDhV+iY0Ifd9RudONoJNicySMEVOjZhC?=
 =?us-ascii?Q?gea89iZCAHlWl9mpPUf5nzu7ZymHQ+07k7VWov3mVwD63YeNFdU/UgS7pawF?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4b7c63-6f6d-410b-83f2-08dde9ec51f4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:35.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEvjEcj4K8zIE7K2ADcwf7VmcKXN33epV+ucezw4A9r04p5IsLunU7FmiQg7Xm8bg9SoH4QWeysF2oglcE61xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17921

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d216eac2a..6067b02d2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3797,3 +3797,24 @@ class GoModGitTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.openc=
ensus.io/@v/v0.24.0.mod')))
         self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, 'g=
o.opencensus.io/@v/v0.24.0.mod')),
                          '0dc9ccc660ad21cebaffd548f2cc6efa27891c68b4fbc1f8=
a3893b00f1acec96')
+
+class LocalPathsTest(FetcherTest):
+    def setUp(self):
+        super(LocalPathsTest, self).setUp()
+        self.localsrcdir =3D os.path.join(self.tempdir, 'localsrc')
+        os.makedirs(self.localsrcdir)
+        with open(os.path.join(self.localsrcdir, "sstate-xyz.tgz"), "wb"):
+            pass
+        self.d.setVar("FILESPATH", self.localsrcdir)
+
+    def test_localpaths(self):
+        localpaths =3D {
+            "file://sstate-xyz.tgz":
+                f"{self.localsrcdir}/sstate-xyz.tgz",
+            "http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz"=
:
+                f"{self.dldir}/somefile_1.2.3.tar.gz",
+            "git://git.invalid.infradead.org/mtd-utils.git;nobranch=3D1;re=
v=3D1234567890123456789012345678901234567890":
+                f"{self.dldir}/git2/git.invalid.infradead.org.mtd-utils.gi=
t",
+        }
+        fetcher =3D bb.fetch2.Fetch(localpaths.keys(), self.d)
+        self.assertEqual(fetcher.localpaths(), list(localpaths.values()))
--=20
2.39.5


