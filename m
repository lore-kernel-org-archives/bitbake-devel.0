Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E66C3DA4A
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 09:18:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.132])
 by mx.groups.io with SMTP id smtpd.web10.16695.1736241496534764322
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 01:18:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=1XSAwyOG;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.132, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJEdMLbMHvOtBTO9y0th42lZKuYSp80tuAUkfmENErBHzNjVn34aVzptK28Oxq55ncd0qCUg9DjQjgbw5CwAw7aSHt0fCRIzBXJLLuNJAVBbXN8n0taOsU6yKHWq1R0nNIfeplbgkI0T645YQT3dSUVYAjNdhG/R4V9tnyElL9eiebPTt2IaPyk377GzDGt7i06i0zv3TfSrrt4zHc1qfH4AULCfgEWSD/6B7n5lOhYxgJkLGgd/tCXJ597fLgkivx6kyMpZWC5Q2bLh61+9A3w2G2K78O02oRU7RdQmf4A0EG9op8roDBvvCB5qaRExSrk4F+WkBE0K4148dwFh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tECYzinVbDQxMsSSm81qc/TD7t7q7X2mvyztaVAu010=;
 b=wIvUUygOT7r0obdzXIiZZlHDWTnugif2gvPUmyLeUwKovQ4s4Np2DchaAVOAD44AolVZUJh8dRmzx0+y1d98zRM2CE9hMt1MTgcFZRu350E9xpAarF7KAliZdg/9Hb3gFWpsHTVjRX7jVoJJGFnwCp0TXvQOCl5Bw2wEm/DjiygBpdfnnV5KFRAktcM1Tef8Gt+VAT4ZS/4OJSCBjEHVr17NAbxZGN4ms7o/llNwy/wrA6V3x3nvzdCzUOna7ARq6L41gCMRNntkGXGpsJ5ZrY/6jZlDZq2dt6MdoY8f6Y+2/gr9AfCCR46n1w46sIppXa9/xuBWD8GuT25nirWoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tECYzinVbDQxMsSSm81qc/TD7t7q7X2mvyztaVAu010=;
 b=1XSAwyOGP8xkIIOy33TzSQHeOHKnfUPd8Ba6rH0/jlDkmYcBM9GrEOr1bP3QzidLNhPMI3s67+7m/PT9/jzs4h/Mkijo1XFYKGvmTIXkrM4Rh6FwVZJu7HE2cK/cseV7Qlf8EXRO78+9c+wsFHjL+hVXrk5lSdcBgjFMu5azfRiO8rAgOsKAZTvTCzT+eB/L7yUV9ZVKR176OnLJpQWdZkrVREBbm6/25FajaWiIvZfgEc3ztH7tBeKKhLL8ZFBAMVa9nIZ1RMqIbr25rnvKfb7SUL3Kh7XLBVl3eoNYC28Y/eHd9RY3tExF95iuee6vV3yHP5WoMULuufzztzN1qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by GV1PR08MB10607.eurprd08.prod.outlook.com (2603:10a6:150:16c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 09:18:14 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 09:18:14 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 3/5] tests: fetch: replace [url] with urls for npm
Date: Tue,  7 Jan 2025 10:17:55 +0100
Message-ID: <20250107091757.886-4-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|GV1PR08MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: f14058fc-44e3-4e4b-351a-08dd2efc366a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?q1i3hT5+P/zA8Lv8EJDKnoxCGq9KIxLdrzme7AKUo5cERbdC/oIKsgNly/tG?=
 =?us-ascii?Q?+Ex7TLoAFEI8eTR8nlh3OuFsKQR1Zpj1m3KJAMvo10dCnXkoO+lyHnrVBaYK?=
 =?us-ascii?Q?WCQwf3E0PrdRpLWt8Vk2N6HZApFW99yz4NHk/9cZz4XcRziDQy/stsIKvaIm?=
 =?us-ascii?Q?Ddgl5qerW/ZC1YixWmh+EFpDHdmGK68voflW9arGjefce64jTxiM7hqSAjo7?=
 =?us-ascii?Q?8z4kkK/IPvQj4Mpwl/oE8N2moL6qyR4TWPk9HFaE3pj2z0mgbEujzfLKD1aY?=
 =?us-ascii?Q?J+1NEGp6xvvlgXP9XOYkSlPvUoC9XoeH78UfR2kVeYViQEWKJEd3K/A7qn1z?=
 =?us-ascii?Q?UcGq50yIiK+rBlLQZqwQyE5eW8qtORBjgQa7bQeMlXgLYD9U4JM44+Aa71Jn?=
 =?us-ascii?Q?CiP3W2D/AsziBJYcfntm6T79i8xJyyEfZG+IqBPbtALvzOo7+gZbwTiY+/z9?=
 =?us-ascii?Q?67aO7LeExFlgv3ibygJX6K/iiPMf1Md8Yd7qRfJ0bmJ9gHtJWDO6burkviYh?=
 =?us-ascii?Q?1dbBqeKd6jLfeHk4sU2f6zZy6AsxbZ9yHdERWlfomcBbVbAl1UbibUVPAsf4?=
 =?us-ascii?Q?/J9CjLVWhEkX1qRx/nIBI794tCYMeskolzYNlia6sGEY0rebLQzFHfYAWMS7?=
 =?us-ascii?Q?vmJjePCl3fdM+5okCYg4lZ+T6hSpNX5NRl1J0O2hNcHKVCwg7nnXFfa89koy?=
 =?us-ascii?Q?mJH4YXYGqK4nX8h9ERSV5OCZAlt+WxtF2jjeqCpY8AEaBDBFn8vBjkZB0KEs?=
 =?us-ascii?Q?+Q0tLWunSaWhbVDGqRRx18Sfztz8526iL6WU7HJAW2CdMVWJzvXU94BHUMYH?=
 =?us-ascii?Q?0t3d24c2Kmtrofx9AfNNK0sfs1aoNNt491Bm8YwNDKrlqqIHFypITozfURFi?=
 =?us-ascii?Q?TI7C058ZVQtsWO6GwH+5jWVQsGWoKt0qGg4QZ6cEgmOay0qvxWVuaIkNCMLY?=
 =?us-ascii?Q?AT5+cB/gX9aHiYk7yQ1+D4mwY+wEn8t5+8mkHAP9BhC8mW9K9l+rdqw6XWY+?=
 =?us-ascii?Q?ashm8e4JRkj3yPfHwZDZsn75lzBQjfl0Ik3bD0M698jyyA/fsonoi5Zi8cEN?=
 =?us-ascii?Q?REOjoDc4L/ZMxzvbvVoMAUj2xlF45QJaJdWCUU11Y36eFXvdD0iAfK47Pi5H?=
 =?us-ascii?Q?HEkCZ+Y3MwcP3RyhvkBth5arh6Ao7KBCzFlHn4vgfTwOqFIRekzic1i4HA82?=
 =?us-ascii?Q?xT/NVsUt5EatShTfnsCtjWVDkQhTVsXvTy3WhUoNNGZSkkWL0fXKevuvhBk/?=
 =?us-ascii?Q?kl/ChN3Nh8bz53nGZo3pOU8s60vlSXvBP6vKTbTEhEsU7VzuekhID2qacTAa?=
 =?us-ascii?Q?RzxVXEqUzmpyX3PfD9iRQABVJVsVvR72OeAAW8vSJEvz9qrJ78c0aBjaknk+?=
 =?us-ascii?Q?uAkYObtNuy5i5wB5jza3HT5IgTVxbhPVvGdsI1SOEfddFDy6s7osjTwOjsrk?=
 =?us-ascii?Q?9KHDT75rpFLsow3z+gxc+qYE9ajQBZub?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xj5dm8cW6Hen0eqOOPGb/oMSigeKJuLSWP6ZIa2i4lICef6hFIwiBqxS9CqC?=
 =?us-ascii?Q?vNgWTZoD5MiuInXnkkZeObjpENH6ZiiTRKfhq4bmIjsYeJU4H1SE9uN1Il5I?=
 =?us-ascii?Q?DuL6PXsEW0VX9XqoBIRaNe6AIJ4nSLG4A6Qbp7JxOlBVbR+7lABFb7fw8TnK?=
 =?us-ascii?Q?Q3eZxz6gqqMpuxD+ZsrfCktdLiVNj1J+rtXqUCf1Hcq88z4kKYje9Q0BbMR5?=
 =?us-ascii?Q?Ex6o7TTJ80B5wvTy8QUouGZ/CzSkZW62dHtbMVuIOKfFyYkeRRQiwJ1PpHm5?=
 =?us-ascii?Q?qRtqKZXN4HOfG6iRfmkI7k41RXFTZxf5pohMHR2ffDF2JxWK7RhXZcMz1t94?=
 =?us-ascii?Q?PeBaxlveqqOyPQY2ptN30/Eiey/vdLKfqiY4AQmN1/2hbtkNPD5oYD3yGMNd?=
 =?us-ascii?Q?404BZbwG7bHTn4gk9XDUvUsLWC6DfmIg6dxBSgYhHPNeXgvDSFy/Q5lbiUoN?=
 =?us-ascii?Q?+tC8Glklnum1jdDAt2nKzxf+M6hU/PQ6mwHTZOlsa8JW5YRTgJHtD300oY3Q?=
 =?us-ascii?Q?9tKZJhBMXg32P7Q35YQvAoDj4ADJUN0dWtjAIoTJRxYDc4SFMb5YDyTbWHBz?=
 =?us-ascii?Q?uLvMbs1Hk0pYkCxBkcl54XkHA8Xy/GkQmMfCcrTgsLjuqESPBccHb59PdVm2?=
 =?us-ascii?Q?UdY4Ajq/m3xnFANPw/4TRRhACYmlyZNZu22xVd+pDLjp9mcIOFGv1e8YdhQr?=
 =?us-ascii?Q?W2bc1C34L4r38XGGp+duYbAx/HYGwAxFg2VAt8MIS7+nKsfGhdOXqVsPTptD?=
 =?us-ascii?Q?ZPSykMmvIS90bCH9fulc8oGsxUpm32TVxcPfkYzcf87Aqdh0jho0YBmOf6wW?=
 =?us-ascii?Q?9sBazjhjWZvyUEpdPabJ0HLKkXuUksc4zJ9Q/DTDXHNdH8joLaXmF+ESslV/?=
 =?us-ascii?Q?oLuD0ubpGWlHN7izRA9cr02T0rINt+zp9vGKUDC5pv0fTMF4vzUGE+C3KFjW?=
 =?us-ascii?Q?xmzJ9wRhcC3ZAGmXrVHMYJfbxaek8+SQnFYxf48EKw1SIsYb70xS5v6CVxuE?=
 =?us-ascii?Q?L3Khr1AwinTohxhOHAG7/iOesl6pkrqkQHcCsqGPtcMRizBAKf0zq4xyFfQ7?=
 =?us-ascii?Q?W6/nT8CCTgFo9oluxaenmkj+U9cqx11M2tdbw1f/IbY9xxS6iHvGOamsoRxN?=
 =?us-ascii?Q?5bRvHzjA6yfYF1OPEwrHdWpDsSNmqLFPMHGVi21pDzAZPgU2Nln6yowfSASt?=
 =?us-ascii?Q?/V2TfH+fjNB7o7VUepvYfmmlfQuxOnIPSAhX7ORzIoZahymj9Y/KcHPew8wT?=
 =?us-ascii?Q?HApRYtnoaiH/STVYTPJUaTMm1Mv9g48ZhlpNFkzF4hiMrPMYaYsq6WEWVFrW?=
 =?us-ascii?Q?Ojayq5lkzg5v6H2oB3cPNl3PqKXEoThDzEOeaNdGyZXekig+bZFElTCmp7oO?=
 =?us-ascii?Q?UvqFKTOuCiTKSZtY53ejqt4MjT7ZGYc1jTZSTMuof4lwyE20bFBIAfQBcjyv?=
 =?us-ascii?Q?3KrJ5hu2V0EPGOLO0fuKQl5Fu0WgloMDxhAxiJZx57cIdC1ZBjT5/oJHhokR?=
 =?us-ascii?Q?mufYyAMkvGJCHpEfz39bLYmkKSNSQrwQloT95Nww8hr3C1ePfRoegdIhHV2X?=
 =?us-ascii?Q?py69HIUjttMVZrUlfjtlX8BOzMkmnLCKDOehGMUlPMAxgoHowGTgh4BkNYXG?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14058fc-44e3-4e4b-351a-08dd2efc366a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:18:13.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCsyBUj1kxoCzmf/M7MiPBn4+WZq/Ob4NUvdokQx8mRK8+yazuxAcjF9UJ3FDR2hWuWlgqIHnMQBl+Kfw9fE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10607
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 09:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16972

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Replace [url] with urls to simplify future modifications.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 66 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b89348236..c5ec84dc5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2627,8 +2627,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2641,9 +2641,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_bad_checksum(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2660,9 +2660,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2682,7 +2682,7 @@ class NPMTest(FetcherTest):
         # while the fetcher object exists, which it does when we rename th=
e
         # download directory to "mirror" above. Thus we need a new fetcher=
 to go
         # with the now empty download directory.
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2690,9 +2690,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors_with_specified_filename(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2712,8 +2712,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npm_mirrors(self):
         # Fetch once to get a tarball
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2737,8 +2737,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_destsuffix_downloadfilename(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3Dfoo=
-bar.tgz'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3Df=
oo-bar.tgz']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'f=
oo-bar.tgz')))
         fetcher.unpack(self.unpackdir)
@@ -2746,18 +2746,18 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.js=
on')))
=20
     def test_npm_no_network_no_tarball(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         self.d.setVar('BB_NO_NETWORK', '1')
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_no_network_with_tarball(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
@@ -2770,8 +2770,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
-        url =3D 'npm://skimdb.npmjs.com;package=3D@savoirfairelinux/node-s=
erver-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://skimdb.npmjs.com;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpackdir =3D os.path.join(self.unpackdir, 'npm')
@@ -2780,8 +2780,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_latest(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3Dlatest'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        url =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/nod=
e-server-example;version=3Dlatest']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpackdir =3D os.path.join(self.unpackdir, 'npm')
@@ -2790,46 +2790,46 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_invalid(self):
-        url =3D 'npm://registry.invalid.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.invalid.org;package=3D@savoirfairelinux/=
node-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_invalid(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/inva=
lid;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/in=
valid;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_invalid(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3Dinvalid'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid']
         with self.assertRaises(bb.fetch2.ParameterError):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
-        url =3D 'npm://;package=3D@savoirfairelinux/node-server-example;ve=
rsion=3D1.0.0'
+        urls =3D ['npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0']
         with self.assertRaises(bb.fetch2.MalformedUrl):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_none(self):
-        url =3D 'npm://registry.npmjs.org;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;version=3D1.0.0']
         with self.assertRaises(bb.fetch2.MissingParameterError):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_none(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example']
         with self.assertRaises(bb.fetch2.MissingParameterError):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     def create_shrinkwrap_file(self, data):
         import json
--=20
2.39.5


