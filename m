Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85799E77182
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 10:32:31 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.108])
 by mx.groups.io with SMTP id smtpd.web11.98025.1733740340477353303
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 02:32:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=B9lcE9zV;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.108, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrbf1svKBVtEKFStwIUhPCuYi7bq0juZrSEih4nHS0bDphDDHAlyRs/U18KiY1fWUI4Q4qJvYKLMj8MlX+2dAxqvWTz9MuZeRO1Ykn3eT5YCWuoxyqJEcHvFsKGiVCHQh65UReiltnPsZcK2d7d9WS107IUKQlf4CmSBKsHylR8fXx7LxZw1aTdHaJfj2bSVlQ/AtbxXqgxaPOuTp4vaTfd/6FlkRfvxkvIIPIV+phocZw09Z4w7kR9Da9G452+eGGEqWnb5mPH4EGk6Twvnfx3P7PrPf0JfIXrGUVF3U8u7VtH9rVpbZu+65jdUPI2j2yPebP4UPX9UP1YZWTcHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXafPm23m9zOx1oM6wVWEJnREmZhk/nyvyac4xnyl34=;
 b=C0UUzyJhFK5/834R0a9JeivodhTxmZ3NPgOx55NVlOi+IWdD1pHjT9IqGT8jJKAB5E4eWzlAPMpw/SDzQ//9UQUsxIc3VtcJlEQEhV0pwXeIkSxLQwom4HJekyUZXII1KOsrOt47d50U8CL2y7DuNv4VxNrWew2b5vFXro4ZMLO5kp1/qfgwOb2nJx2Q6/MUVDNu9v48TEX/C9syW0ERze+UywI8vdBfTfdd26/steHI7JkH1hdehHTRhDnh4KWSM11wGEH8PPHXFImliHvg2xeFSUumr8XBGTlsOK5THSTVxrqhTJXB3j+n5Gf6kTgL64biiy6dX+Q8CCUidgQkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXafPm23m9zOx1oM6wVWEJnREmZhk/nyvyac4xnyl34=;
 b=B9lcE9zVjUPrNQwg1wz43wxapRL2iatVqr/nEE/kFSWLkZEq3xxF9uA5u/z4eGy/moToziAUD/yt1JtSdYofGXiogun27elk7gKB51hVUNHa2qpySfcOUP/54p5/Lxc5UsPQvWX5P3ijX8PiFBp5pNqjh/7oXuCKxG0ZUDWl0BBrUn6PDf72t1yWTbGhcOLqb5utm9EqRLvXgySAB5yniA5p2HGLNozw3rYUmSXWsOw9JBJW28Mn8tRa9ZKXQANjjMweBCtIjJgQlR58v9randEPGQxq3BFZIzgoefSLRqo4kMIUQ2CyQ+jqlamueOs7SpZVQRofhQdj/mjW016BxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS2PR08MB8384.eurprd08.prod.outlook.com (2603:10a6:20b:55b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 10:32:18 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:32:18 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 4/4] tests: fetch: add npmsw test case for bundled dependencies
Date: Mon,  9 Dec 2024 11:31:58 +0100
Message-ID: <20241209103158.20833-4-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS2PR08MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afd3bdd-e1a2-4d95-2b02-08dd183cc16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?855bNlFGyYWNVXlpdpPTjqTlDLh2DZQRKPslo/FXxg6uoLTVDBnqNZ7bOqol?=
 =?us-ascii?Q?6NWZNIXJmk2ozJ/bw68+tQcbzk1Pp6Yxd2fkFg4c0O1gZ1Krwsvi7QW0H8iT?=
 =?us-ascii?Q?d8Zp2NNuax/r99sYvXmwSrLFsTNoXs7Po7KSQz62zLdtl9X0maZbvoeQlOFi?=
 =?us-ascii?Q?nyH+HZqUmvp78EUSLOaRa1bDXK0jKnHudOt0ka/sBTkERiz8rktAjo2BWOu7?=
 =?us-ascii?Q?jDN8mroj/PJ27sXOjKFb5cEGaEXUfDCET56Zcroj6JWe+WnQOiSU7YNAVx54?=
 =?us-ascii?Q?VNPQZ4y3E+C7HlphC47Q156jPqBFTElXU3W1eeFJ5WeW1BTlApAYCau07Bmg?=
 =?us-ascii?Q?3uZ0CT4axCsB7b/lmH0jVHKKme3K79JIATjtIWz8uuuj69A8xuPJZpzQmEc8?=
 =?us-ascii?Q?S5h+6m9rYu7M67xG6K5PlxKIr62zghyEmfxsHBZaJlxjEHdS7oYpNdNyxKt0?=
 =?us-ascii?Q?gSukiLXnA+i9xi2HY/ldKriKmsmgBoZ7D+1By0jtByiFTSjFdE+Ir6v0B2P3?=
 =?us-ascii?Q?Q0V3Sad8bJoC6tkXgHOV7DwcBhb4ycWCP7FHosvtT9hOfN2/X/4MWseGwx9Y?=
 =?us-ascii?Q?K9Y4qp56qGpBz8Js3hgZiMMfAvOnAYuwQ2oBrgzUpkaMt1laoEIrx7sh2D5v?=
 =?us-ascii?Q?IjSTTxdI+usEX7PLjebWw9AyzoZJo7fnk62Ub+cbTghWzklCzL0SVzX73L+d?=
 =?us-ascii?Q?1YldnuY2BYTvSMrGXuO2YAY+Mfn+eki4Jkqrm29gOCUaA3zNlTdqcL/27xpA?=
 =?us-ascii?Q?JLeIOoNqlnx4qDvfN8SuE9+xd8HdYb6AsIZtDAYM/GEDFVnQo/Rin92bxejz?=
 =?us-ascii?Q?mHNXhnDipBbYBsfpaSKwT9M11b6SkwRztpceB6oK/4X2xXXfvOhOMCbmBtSH?=
 =?us-ascii?Q?DHeSjLbzM28c9oaRcnKSVHIZW2BUigYvsZ0Ai2cx+ZwU+JbYW+5MIhEs+IyJ?=
 =?us-ascii?Q?Aichz/eLlJHH3q5fByPavtss+YnXTyVGWRW6WJOO0SDFdcA+p/QOx5mUNnld?=
 =?us-ascii?Q?qtqC16Thwau5i14ls/XbTDL1rj7WarB2gMaC1aJQFuzvEvo90jX1Wrtgv9mo?=
 =?us-ascii?Q?AD/CVKol13vnTUM+cFaDDhyZB8BB76snptC24SiQAIPwV+eqnB9FvSnmkiXL?=
 =?us-ascii?Q?A/Kphxz4RYIBdwRO/R3h+HW4SBUh8YSh3fk+vj8zRry9TRE8yP35eHCSIT93?=
 =?us-ascii?Q?alHx61wJkui85nsYjWpTPbXcAfriAi5KQUmlo5ZPVsuicbuSMdEsWa5dD//+?=
 =?us-ascii?Q?NrHgKYhs5ATg7wO9oVZDIplnlZ+FDYQybA7KtrJHcy35ITqm4HFfZK9V1aU0?=
 =?us-ascii?Q?CKAMnum+wvc5ptYmi4WBJj88Ps2aPJk+VFb44VF5M0ZRQZ4RCLlI60LN2/5b?=
 =?us-ascii?Q?DYA4oVg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WBPT0Lj/JRHZ5v9Vju0ecSA/El7Tb2oy4omfNM2IWHJoVq//I7eI/cCA3aCz?=
 =?us-ascii?Q?tl1Tnej9tr3oeWYf3noDvdHxkrpbseQY9UdkGZa3OA2kv/CZ18mrSp4T0Ovh?=
 =?us-ascii?Q?G5tgZv2WK14zJ94DaFF1Q5OgNxZ+oYZn9FYEVdCfD3bMQNqXxogzhijXx7ct?=
 =?us-ascii?Q?WXFn37dEI4JmGNS2ZQR+4/ijWr4hA9t049moWn5DHn4gybNWe1ac+9gbt0l4?=
 =?us-ascii?Q?z7AMm1Ky+qB4lfxkTxLtWE2I+BVSshI0fhmojp7JH6fkUGFc0bez05KTxHaN?=
 =?us-ascii?Q?8jFiNyG2lHRqTwCgyVnwZlQR2J6xwg0OrGtmvkjiL5PbpEZ4USIeFmgozT9f?=
 =?us-ascii?Q?v7niQ79Kzmee5XNcTGr4C53givMhBAn8HoqKgneD6m4EPC5gqyU+uXFJ9VC6?=
 =?us-ascii?Q?Vl5+17ge3WrxVX29r+gB4TlNJa1r6hoRwA/0R4BYdyPjusJsTB09Z+uaJN4S?=
 =?us-ascii?Q?HpndbyQW+nScmU+e4YNQQowiSLe9QoVsrURvjfj2UwtzVJAfVaN8zXZd06o6?=
 =?us-ascii?Q?oMR4ioVd8zMgf5XG0zC5lAeWurr6477YIDnNe9sUALDo8pLFAUE82YQgxph7?=
 =?us-ascii?Q?avv3q5WGdMYvxM4eug5IIbtpbcasmNl6sD+tDfgiru35caMWyOh+l6DMEWNj?=
 =?us-ascii?Q?3LXQ3O9DPnx0+nPxWPPPaE8ehJXuVEjGyeTbqArzpQuergz8s8T5KKphT0qD?=
 =?us-ascii?Q?xSaLUa1wx7pUyqvF6pByE2P+h+VcZKbN37gEnGqvGhVtVEIBn+LEwdnOo1GZ?=
 =?us-ascii?Q?lei3qBnQp8n7us57E1PZftqX1xOdk0D3k2rBdUBIhuAMkovV1c2f2+zqIiCR?=
 =?us-ascii?Q?m5BVZYBm5LwVIxO4MnwVstbsX8wHCCiDuut6Fw/vjU6hrbAXEjuYa0HxfRuK?=
 =?us-ascii?Q?p/zguBSmj6a/NGrEMAd15ynzTuGr+v0iSCclBN1zDFIivX5ekn//y9hrcJxm?=
 =?us-ascii?Q?EcTUoXC9fOm7aYNT/LK/eiZeV2rtpLndqo/IbycEm9T3DbbID49lyVEUcCPJ?=
 =?us-ascii?Q?XIMk2/cAQ6zej1tHLvVqcaDCxzV9fa4P/cgkVEiiedr3ziuCP4F5E4oRnWdO?=
 =?us-ascii?Q?Iw5q8HEVEI2U8rL+UTW7+zkhbQAq6rYoxwRH2pGQO/1jpFpje4sD9OKedAQ3?=
 =?us-ascii?Q?z+pKH9SrYHmcmixKOgI/vM9PTl6RlGGmrbHmcqR/maKXqMnJYM7ifsedJRkI?=
 =?us-ascii?Q?LnrPbniT2Je0SfpX54oZ2rhpuP6RBS5QW+xVDLjW5jLywfkd6rEeG7SkrW/E?=
 =?us-ascii?Q?R5lvdtMWCqz9P0FSdRv+W8NTJBJ3P6qj7sHRmJAiCLxrv5Gu4/1aZ+u1pXL1?=
 =?us-ascii?Q?ed+m6T6DtrVu6/wj43Nqeg2MURKAwiq6f9ZltRXKidDUJtitZYk0P23LHkSE?=
 =?us-ascii?Q?fKktUZ2SUqi5NxZb1x1n+kE1sfTXYXu2t9/F1LfZUuM2DD32yksipxGzFW4H?=
 =?us-ascii?Q?t5wJxGfawN7qzQ7ZHfA7dvRJc9yECBRcIdRGMcK34poyjglX5l6U6SW0bj55?=
 =?us-ascii?Q?qE9JivhLg9135s5307CpsUVrsv2tqP4MkAPLG1EmRzI8VaiZ/btYDDosVDQT?=
 =?us-ascii?Q?q40+1cM8yxiocC21RrazTQZlOUMyvwrn8MMZMpHW4zZiVph2hg92pTJoZsUz?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afd3bdd-e1a2-4d95-2b02-08dd183cc16d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:32:18.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWiSy9bCmN7FYDJ3WJf57GamigVzi200N/ixAiCX2z98ewzFqcag/rfhTcpg5pI7NSVU5SXjc6HQ1SbS95HOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8384
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 10:32:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16896

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The npm package lock and shrinkwrap file list bundled dependencies which
are supplied together with the parent dependency. The bundled
dependencies are marked by a flag. The flag and thereby test depends on
the lock file version. The old lock file version uses a `bundled` flag
and stores dependencies in the `dependencies` list. The new lock file
version uses an `inBundle` flag and stores dependencies in the
`packages` list.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

 lib/bb/tests/fetch.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3eaaa8362..6dda0d381 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3112,6 +3112,32 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
=20
+    @skipIfNoNetwork()
+    def test_npmsw_bundled(self):
+        for packages_key, package_prefix, bundled_key in [
+            ('dependencies', '', 'bundled'),
+            ('packages', 'node_modules/', 'inBundle')
+        ]:
+            swfile =3D self.create_shrinkwrap_file({
+                packages_key: {
+                    package_prefix + 'array-flatten': {
+                        'version': '1.1.1',
+                        'resolved': 'https://registry.npmjs.org/array-flat=
ten/-/array-flatten-1.1.1.tgz',
+                        'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                    },
+                    package_prefix + 'content-type': {
+                        'version': '1.0.4',
+                        'resolved': 'https://registry.npmjs.org/content-ty=
pe/-/content-type-1.0.4.tgz',
+                        'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk=
2Zob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
+                        bundled_key: True
+                    }
+                }
+            })
+            fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+            fetcher.download()
+            self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2'=
, 'array-flatten-1.1.1.tgz')))
+            self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2=
', 'content-type-1.0.4.tgz')))
+
 class GitSharedTest(FetcherTest):
     def setUp(self):
         super(GitSharedTest, self).setUp()
--=20
2.39.5


