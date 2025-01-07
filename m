Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B486EE77198
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 09:18:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.132])
 by mx.groups.io with SMTP id smtpd.web10.16695.1736241496534764322
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 01:18:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=je3SrEpL;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.132, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpoAgpUhUNuEi+nZgxuJwl/vyWHmH426scs7QV8pt6nmsdXEKNh0e/egitwyFqlfZKCu2KxWrhZ2qnKVoi14FU/oSQz8dRImWW+Q2J6wLWh9bVlh4wrkUuGsT/mNpICGNVsgWhoVeBdOyyMo3P+wcpprrOEBHJmLqWqMQEfoU4LmIUc1QsA4grZOsaF9Ui6MAfc0VwP5tkVb3xMC/Me0AH7uYrsQgVgGEpMZtjmeJx3YwwXIjmQavyJnohxg68t+hBz90+O5d3nkxQnKT66S8jeif/+7JkxAqaN1UyRdIxHxvzylAxac5DEjbrLY2JluXzCg/m2EmSoCV9HyiJGW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAH8aLxGBZMJvoHCM9F/eJsCXT6U6VjnD0ZS3FSViBI=;
 b=MeR0tTj2KZ+tg8/HrFqcXyaD/26AhEN9In8d7NpkPAn3suH6iJ2AzEFpezOWxBcRpNlmjGVdVuPUbHtF06XowvFP0KZ7NXXniaUxPAT0q2lSeBfswEYRzp7wvLM+ObgdMAShFNbYxzsEH/TiXNOaOBTZz8eWhYhEFrTU3xTlxixo+jXpusPbgXfW28Fsol5X8oRY20eAWwYCc2KxuZ7GckeZtZrPeSGNMmkbxXyzvYAdPttBmlxZwgaBLGAWf46zuaa/LSDzGTQPlLLyPgAFQvNa2yvZjZi6qbPoJQqvDtJRmuqC3R+xEI4z6e4LZ5NhcFGz1iTqwYgwvOzjhWaePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAH8aLxGBZMJvoHCM9F/eJsCXT6U6VjnD0ZS3FSViBI=;
 b=je3SrEpLk3kmhKJ038/DRnvJVEkXpXbOu0NYzpzOqqtNAwfIENAof6IfJFq6/AiXXuaXf5U1QpZ0GNUF9EFKbTHQcNjJ1q+jEqBSbwU3EHbb4ToRhJH/IVVQctDt3D3BPLeljQ5bYfitldL3UCSfwG6zHfC7CelZQHVORXr4VQbl00vr9jjTfm76Sw9VOtA5ewNuskP5RFwv1IaMFFbzewmPWk7xR2LCTCGt7fr7KmyQkgNPYXXSJ/+mC/S4XbWg8FbY7092otea4RWSoHAEfMeDFSkC8JK4gJk+fV6aUPivjPZPvjX4AlgT1DnXg4KBtBTCHx1bLdaVItvHQS8PhQ==
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
Subject: [PATCH 4/5] fetch2: do not prefix embedded checksums
Date: Tue,  7 Jan 2025 10:17:56 +0100
Message-ID: <20250107091757.886-5-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75a35ef8-813e-4d6a-d1e9-08dd2efc369e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eDpakb+ps2xEgjnScX0rzKFeCQEXkBLH0FThAc4nfeQ3qQvHhRBsHLablmkY?=
 =?us-ascii?Q?C4Ourz68z6+h0DxdZpt5qPsxyy9U+9YlqUhHxfjAipHLSs5fFlCe5gORN7xv?=
 =?us-ascii?Q?jM5kHPDabJUbEbtOWpKmUx7qQpnonbmfH9jZJy8IxKoLEfZC8K5SlfPqPW4k?=
 =?us-ascii?Q?BZbY/iXiKK7+0OQnxfE6ELFuJiHBD8Ru65pVTrMqIM0q/QXCta0bh3D3D3hN?=
 =?us-ascii?Q?q7U4b4I/9SiIuxy0A0yaoXPNRenF/5BRAXAj1xRzFamAv8MV1AP82qJJ5OWJ?=
 =?us-ascii?Q?evbBzyz9/74042uJAO+ub3XJ67UiTey26uZvgjFvoXwSDknDolwrm41PQSAk?=
 =?us-ascii?Q?I8xHsSGp6N/CgW1YRgyC8x3PvUckfXbIZB9p/H0nV0cktWIrnsBATzqxMdBt?=
 =?us-ascii?Q?5GyQBC4bTfg60c3eMVfUOd44mYTNnP0G8QhSQ/aU6sGLRsQqTyh0xzPdCHd3?=
 =?us-ascii?Q?xZpU5ugs3u1ZyMiB0sbdT2lJorv3YJV3SOKF5Pf9QY17q3IBWLK4Kgvai3uc?=
 =?us-ascii?Q?hCpR3SZzIAMCjzK0ompkFbqKD8F5uAQ0lMRja0/JsGn6Z4gwmWrbLXC9uTgK?=
 =?us-ascii?Q?4kqOJpF1k6k+cgRepnpSvZCglspZw3zxn4+E7M1vVkhp7iDaCpfpNALSU3VJ?=
 =?us-ascii?Q?tHmeakK2bWL8wZBthN5uPjzpyV5Gt3zByLX0zsXZeLMNamX1ytLhIzPlYItY?=
 =?us-ascii?Q?VPS1yHYUmGrrEOZKx6HouqISIQ4Mw+AIj7KpWyDCyvcbsXx3A5Rt50OTBSep?=
 =?us-ascii?Q?6s8Wk0Yit21ZeM0M2SQQx3Wbdfg2bRr/9VRjc9b/yykINHYomFiqBqJcWOc/?=
 =?us-ascii?Q?3+0RSAW5rL8+282W8fzOC8oev7vhOcaaZgU4hQGnbUHRS+CBVY0StfL2xed1?=
 =?us-ascii?Q?d/KLFEkkzLq5hTpX5yElvbVOU5eejCxWy//q4oUZfbM6nJF3rYxZWR4MGmV+?=
 =?us-ascii?Q?2U0Gx48vUc2tbWKeepFE7gTvBlozz8Sb+myLDVZQp564MOc3/pXDjm9tj4W0?=
 =?us-ascii?Q?fiulJn7U4wDJTCobfg3mPU0HIf77NquN7a0jjBs3Xx8E7NGxB50IV+Eyaz41?=
 =?us-ascii?Q?H8ECNAXzCCfyooljbMEHOaQjP4scTI3JRfFE9wVNXsF7XMujNWIJSmpmUC4/?=
 =?us-ascii?Q?J+EXNzbhXdUT3CbVZC7iGWM8kGXbkVU3ez9+Y6p5LbapcqSqY4EO7+8eISzm?=
 =?us-ascii?Q?z6jc4w01A3DU2f4n8v1v0mYnWIHReG/7bvijX7f9DAURRoe9V11t2kKYwfn+?=
 =?us-ascii?Q?16iqNosJSxDZuKw4pNYBM6V9/dIvQQDlV7zelKtQ2+8fp8OpDTv/nAmvgBgF?=
 =?us-ascii?Q?nRbVjIjGA9olgvaaHqH/OO+UPEj/7klIoh0IZrQzPNvlsWR77KXsb3q8HNOo?=
 =?us-ascii?Q?b9BGL1whJzYQWTUAvKx6Imv9xx7UQMwTXVP2dHq/DivMnb97/Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AuOX61G5vcA0UmVnRis3WMs6xMSXtZIrhMMtxogSlhUxk8/IXKkQzdjLK4CP?=
 =?us-ascii?Q?pcVwbkBTSmUOU4VGdSvueNsRjioE7NpRp4fiu82CQNWE+flCee9ugNi3neUy?=
 =?us-ascii?Q?t8gVGoBNSf7cS5IAFJGxB8SSq9jq+4eJ/xDLONP3fUREx/wZqFG9fOSL/v+b?=
 =?us-ascii?Q?9JpD7Knxry3SVYJDYZadoExL3mg18TwbbHz5xrWlBb8QzW3fKlTS/m7HZlcZ?=
 =?us-ascii?Q?GDw/x9xAhN5J4jLlFSPu+hoDSeuJT38PmQQ6nUMQwL0gdmayxG+0SBgAe/qr?=
 =?us-ascii?Q?+mkaXAgglnD3BUjTA5h72oVWrSleyshQdcY4KmUeTfOXrRq4bpIdo5DL7xFw?=
 =?us-ascii?Q?GBdL79qKjKL8ddHNuqMJQc6Ob7H7b2QM1NwgvXqForN5YruNQ6kLS75e3ZdD?=
 =?us-ascii?Q?NaW81fvzvwZ2+raMCW90hcC79JblTh5p3Bf2aNj4MH/JUTjwAzXJDyRze3f5?=
 =?us-ascii?Q?k6abRnmjqG/6NqKrLP6K0o4mSTj3Nf5QpuINZvStkfyNsLBt1Xa9VwvGZvzm?=
 =?us-ascii?Q?74Yh/1GUSLBoFG7sNRS5OgQy3eciYxW8y7KgYZdEKdh65kP77cZ4KE8kYMaP?=
 =?us-ascii?Q?XdLDoQSH5IhgY11kjoWrYfi7WSTa+ydQ/7Fg2Y+gmTX7hPFdOlkQEd5ljURW?=
 =?us-ascii?Q?UaSse7RmbUXcM7icY7c2qrBLONS105CUREI/EgWV8kYRhJFfk/VC4pXWnG2l?=
 =?us-ascii?Q?JHXoCTODRhsf8KUSkc1efS7i74gKViCKiufmGUKw16L12fj7ANoXhBUimS24?=
 =?us-ascii?Q?Z6mgSIiiaBNlXjIcYo2XXfVVEzz5zBKMgALPYUYyHiXmN0jNett6BilXD+1W?=
 =?us-ascii?Q?zTb15/gZ+FLGQtZq2+k946IhtLarQ4DxURlYMonQ2mGCCobx1Bt1Y2uP0KQt?=
 =?us-ascii?Q?ZtKq3VycHB8YiACETQQ/9hkNM4V45ovyyA+vLj+8C8sRZP9VO7QKO3OHm/Rt?=
 =?us-ascii?Q?/txJRKRbn+mE4vSx50qDYAhLwbj1f/VZb+jl0xlVXziH3q2raKsJO8bINfm7?=
 =?us-ascii?Q?PtWIsRUIPLEINfOfqBRRf4vOBBZDIVZsLlpcUGACvHua0mm4rzczSQDQF7Bx?=
 =?us-ascii?Q?NlEP8eqAFwz1DIHO/mvhPraxVVL2dCNnW8Cz4mr+lnj9+/348aM4ca5GGqFT?=
 =?us-ascii?Q?mMeaZVcIplTArm++e069dkFizm7pDuJ6eB/p8/fCisCF2MkQoGugBC4xoHlb?=
 =?us-ascii?Q?8exyVqF5sHB7zJ2jL+ixqEfyz6H4sRW+8RWHdWjOV172rrdem5Hv3Zo0LWyC?=
 =?us-ascii?Q?m8vrb5eNbVd4wnqIo5hUYe6Aa5MiF1uZU9HsmCpBPKqwNEVPzLNbe1QuhrV/?=
 =?us-ascii?Q?NHNOyVp46QXklVK5EnkhWQDhwIe+z5oDFDcRg+UFKOF28Sewns9XvYC6JgTF?=
 =?us-ascii?Q?g5OTemT2SlaWZPkBotWymD7BGnYt+RUrhKMQNsh66WYpT0Cxzil6lxLMgjYA?=
 =?us-ascii?Q?H/Xijrj/v3VyCtIQpfr60Nyp33CXhGahxW6j2RIj+OkfhAd+ZeOtIdizvBaa?=
 =?us-ascii?Q?nWmA7w1/VZ9Jsq/Ttu9+hwvqFQBTeuk+zeqbu6f4GC3mFHQF091020UZLEMt?=
 =?us-ascii?Q?AS5BkZ6YB22zl9aiYkHaGZgeoV+oj5p+SaxnC4M7pkOETGVr6vrxHNRE5Uxl?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a35ef8-813e-4d6a-d1e9-08dd2efc369e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:18:14.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4UirkoPVV67aqtDHQOTD9SfIrLBW7MbfvOyOT5ct3ep+KLXXBAbs0tUpyG3vCMIVMY3XVI1UlQsedr2W/yrTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10607
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 09:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16974

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The fetcher support entries with an embedded checksum like 'sha256sum'
in the SRC_URI. It adds the parameter 'name' as prefix to the checksums
if the parameter is set. This behavior is unexpected and leads to hacks
in fetchers. Fallback to the checksum without the useless prefix and
set the parameter 'name' in the gomod fetcher unconditional.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 9 ++++++---
 lib/bb/fetch2/gomod.py    | 5 +----
 lib/bb/tests/fetch.py     | 4 ----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f79e278b1..3d31a8d4a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1316,20 +1316,23 @@ class FetchData(object):
         self.setup =3D False
=20
         def configure_checksum(checksum_id):
+            checksum_plain_name =3D "%ssum" % checksum_id
             if "name" in self.parm:
                 checksum_name =3D "%s.%ssum" % (self.parm["name"], checksu=
m_id)
             else:
-                checksum_name =3D "%ssum" % checksum_id
-
-            setattr(self, "%s_name" % checksum_id, checksum_name)
+                checksum_name =3D checksum_plain_name
=20
             if checksum_name in self.parm:
                 checksum_expected =3D self.parm[checksum_name]
+            elif checksum_plain_name in self.parm:
+                checksum_expected =3D self.parm[checksum_plain_name]
+                checksum_name =3D checksum_plain_name
             elif self.type not in ["http", "https", "ftp", "ftps", "sftp",=
 "s3", "az", "crate", "gs", "gomod"]:
                 checksum_expected =3D None
             else:
                 checksum_expected =3D d.getVarFlag("SRC_URI", checksum_nam=
e)
=20
+            setattr(self, "%s_name" % checksum_id, checksum_name)
             setattr(self, "%s_expected" % checksum_id, checksum_expected)
=20
         self.names =3D self.parm.get("name",'default').split(',')
diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 21fbe80f5..6c999e8ba 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -119,10 +119,7 @@ class GoMod(Wget):
             ('https', proxy, '/' + path, None, None, None))
         ud.parm['downloadfilename'] =3D path
=20
-        # Set name parameter if sha256sum is set in recipe
-        name =3D f"{module}@{ud.parm['version']}"
-        if d.getVarFlag('SRC_URI', name + '.sha256sum'):
-            ud.parm['name'] =3D name
+        ud.parm['name'] =3D f"{module}@{ud.parm['version']}"
=20
         # Set subdir for unpack
         ud.parm['subdir'] =3D os.path.join(moddir, 'cache/download',
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c5ec84dc5..6b8e3e060 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3391,7 +3391,6 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.zip')
-        self.assertNotIn('name', ud.parm)
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3409,7 +3408,6 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/github.com/%21a=
zure/azure-sdk-for-go/sdk/storage/azblob/%40v/v1.0.0.mod')
-        self.assertNotIn('name', ud.parm)
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3442,7 +3440,6 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/gopkg.in/ini.v1=
/%40v/v1.67.0.zip')
-        self.assertNotIn('name', ud.parm)
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -3460,7 +3457,6 @@ class GoModTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(urls, self.d)
         ud =3D fetcher.ud[urls[0]]
         self.assertEqual(ud.url, 'https://proxy.golang.org/go.opencensus.i=
o/%40v/v0.24.0.zip')
-        self.assertNotIn('name', ud.parm)
=20
         fetcher.download()
         fetcher.unpack(self.unpackdir)
--=20
2.39.5


