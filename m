Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B3E77191
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.106])
 by mx.groups.io with SMTP id smtpd.web11.149743.1734693991344736713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=rXAIepYX;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.106, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sN1j4gTgt0gFVnnNclEDv63U1B1MrcQBA/47qrfjwkoR1ab5cdEscyRffLyqdi73l1fdjB6jZkUA1DjL8iLjZ3zvF2VCvZiIIkg/Etls+tfWvA/vWqmUjoiLlwmaCUgpE7KQWEpewDbdk3tyqbQmSrd50kybYp+7V2gi++zDYS4WvBc5bO03P9+PL36IFOu0cpJZquJLmk6ANn3nan924paNm7LpKZmep/997JjW48k6pQGnHwEt6mu8q3IsmRV++HtIJHvRusp6KnKOwe2JGC8/9UybQJ3WzvKxAO56GfnWNyNydxckwTvkybzpeQwz7Hfh4np6NnZtFn4YACaRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAH8aLxGBZMJvoHCM9F/eJsCXT6U6VjnD0ZS3FSViBI=;
 b=LDddvS/Pi8BBSGtT80LaN+YD4IHRoKt1/1xev0G3k92kRvq++LbdVNSZYMgr0uLLSBWj+VCoeLhV3d1AjyMW/kd8t3fkhJn70oHesJ3ibi2JBGuRPv4JVggjFJ4aoIv1zb0jJU/BfEqGcwShB8YCGKD+c+F0BLg+NA5789xLCdQrEBGYJin/Anb0SrJZ68yTbA0RsJD+uKnm+jDcwSAEbJDUzoy9ppzqr2c3M6ebbVYFie9yFFdHnVrlclUEz5LKltiYITwgoh4UwFM8gOmZ5pheU2EzJ7VSfCf3V1qEAmwaZCtMVjexsCQoXpFhuu5jpa6Y+QlpwfAfTqbiM0tsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAH8aLxGBZMJvoHCM9F/eJsCXT6U6VjnD0ZS3FSViBI=;
 b=rXAIepYXQvzYzsujaq+7IovggxRBZ7IvcD/ghM7aOQzO54lS6PLrjjQtGSomZmuwqINr7XezJMiC0JYlGfArCQVz8uRRg0N3HJ3hWhz6Hm2pPb++OgSR5w+dlhiSGQKRH8ZnzUxiec3+IOIOJ8Ye7ve9jW9IOpbQ317qP5v2muTk8+BqoGdtWEjYUiOOOpefROJW0HcMcQwv208i7Z/g8NBuR3ulfqczqNu5/YucvftAddkc8EutEsa2RXEfYKKUvYdO04uOHABGBpnyx4muaasrNXi2mdCGMJMzzk+NYdE+bmFOWC8ncpeGdQ4A1watFgVmdusGmkkq8gxHG+4qLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:25 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:25 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 04/21] fetch2: do not prefix embedded checksums
Date: Fri, 20 Dec 2024 12:25:55 +0100
Message-ID: <20241220112613.22647-5-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8148a115-8c84-4564-40ac-08dd20e923a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bSu05CVs8wNRnvtQ0mOWz3WEsoN9ciOm9MGazlaox4qfFuNBL9VnJOAfRjDS?=
 =?us-ascii?Q?1KqeDgyWsmlZURKhleCgpTt1Ri3t/gSCG2FG02huXbiEatP/LBghmcUyU6zl?=
 =?us-ascii?Q?NZSkW9V8+Hx9PKF7JS08GKfoUeD4UhH0idHz5BI6h2fE8DG1a7a169nXw3hm?=
 =?us-ascii?Q?dYHRey2Aj6+QpJEWqnKb2K8lcr6H5AcodHKOZAYt7n4WAuxhBTU8/Y6RE3mN?=
 =?us-ascii?Q?QFn3Va+fKQU3q/wQgQiYMBzNc+39kpgBP5K1u4jyswLAfRl7xswihi5eGo1y?=
 =?us-ascii?Q?hpM71Bg4S2B8bgu3Q5puUq6hh9DVKYi+EIcF8c0v1JHTfKFeFG6FN+sj1Bd7?=
 =?us-ascii?Q?+VMsBRVmKka3MGElsZuiUfyAH2eMJ49VM5Kq28VyHYX4YwetIaJRgw1/JFKJ?=
 =?us-ascii?Q?62sZv3I1Vd55TgOe+e+IcuZAVcm4Np7VP0zfXwH+aebyTudHQWjjx2a9kTvA?=
 =?us-ascii?Q?L72w1IAHnXUHl5WAqv/mpfjHNRC0WdDtX5GkvLwsqUX5DtZ65NJlkOl349EX?=
 =?us-ascii?Q?mUcvYwJv5Q01g4MGpWPX80ndTIDn/NUvkhXlepy6q1ITDql7A4s5/WaFc9Bo?=
 =?us-ascii?Q?tZr+t+5Y5Q7NPOvYk33AxDGhIyojJfzOnljbLXqblo8EQXIhkCJM99Ov2IGR?=
 =?us-ascii?Q?b4HaEvuNqc1EwcZWlLSet2r8ds3ttqWcGDqww7ffZsNVNQ+3oH0X3OtNUvkw?=
 =?us-ascii?Q?IG8D6dslJg6vwaTZCZk3ugBroxhdCr0T2tzC4v0WS6wbBrBDszt/1uhS6i6P?=
 =?us-ascii?Q?RKJzRDuvtU4nnxlO74ZqvPcVMhdgfuwpwR4+YHeKxXQ5MDHXPvKNM/E/mJdM?=
 =?us-ascii?Q?UGnkRDkEr4sc1OF68IcWAEKz0Y9swAbDK+XlYcgdh56VDyatL8tFo3wmoKTp?=
 =?us-ascii?Q?lH7KSv7CRAMKIya1loegANrnCWx685cCPP1eDM3vl19mjjaVEoUvfHcizsNo?=
 =?us-ascii?Q?pM/ryC5KfpARegKDMvj4DS5kgR0l7maLHlm3DJuyxA5pmlaph/n5gu1kEj0G?=
 =?us-ascii?Q?TkoaRFyfiPmytXiwDAOHsOTJAzgLlV593my9xlnLJzGg4F+PaR5OoQAuIqqX?=
 =?us-ascii?Q?DDr4pGd9OI42Jmnp43rCa9cp5sui15ljwLbrBSaWeQg4XkGy3lic7B1dBD9S?=
 =?us-ascii?Q?WrjqFYyUgIt90hpdFTCM9zUXU2i87K50JyfSyMExf2own+hRrWbGpNnbBuxi?=
 =?us-ascii?Q?glCIMLYuukZFQ4TvuvPcAU2Sa8tWoHkr5U+HaixIO0T3hAn8t841xN7ma+Jq?=
 =?us-ascii?Q?AF4gNUG4A08njz4rh2niRqKtW5KiPA8HonFGDHUPOyr8SyiCd4sI/Wo7BRGR?=
 =?us-ascii?Q?ki8q+60ZOnKCwxc5N1tu+SeWS3UXIVYeNcB7xe8AWXCqJ8wHc2z5GyMx8bTq?=
 =?us-ascii?Q?06b1XTSaIFFJSgxGX4kM2Spc0H6KHWbbLhdJfVRGbZfkh5xZ1Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FwI/MLDzYp2XoU/q/TGR00IOyCx8tuxiKY5RlX1ZfXmhUUuEKF6hLbFMCaRN?=
 =?us-ascii?Q?mrI1RUIw8r+N+lBo1GU0W2yn5zRC9J57H3ea379z03fcsd5mpU60qmjVcnhm?=
 =?us-ascii?Q?52Ln1p/EP+MzqXKiV3Xy7pRlPD+AZVfVu1NJ8k/iz7H14+AgA8qyMomzIUm2?=
 =?us-ascii?Q?bR39lZwm54vLZy9rgJKDqfDP+s8a7ffDCxv6BIxrIOJipVxgYrrdiuIWcb7I?=
 =?us-ascii?Q?FFP3guEQZ/IYw1V27DEMdv0P2qUS6LZrxu+KYv0nyZ55lcU4sqMm5CTO/Wel?=
 =?us-ascii?Q?MDJ1p0S/jrNfyfeHHqdfX1wDuggRh7XD8hOO/gM7FfFI2JkuNHH1R/KUjRKM?=
 =?us-ascii?Q?XG+W987UDh3gd4BFOqLrJgazf4ahZnPXMC68yEvqLrthXSpg9uK9LVpYR4A9?=
 =?us-ascii?Q?jSrVwDps8WAS8zlVgXPwvOVMa1/kbOLEg+hThZxPVvDVbcEHxSCaLdSBnoex?=
 =?us-ascii?Q?pGjE+vfEGebhMrpwlxqtH//Q8KitOtGjPdjRxqT7gHoLjxX8EI9JvwBTMjUY?=
 =?us-ascii?Q?nB2YhUEBhI1RucE/pQTQ8UfXjYDdzT+zyWfvjFVkXHN81+GcwcTFoX2InjZK?=
 =?us-ascii?Q?Q0e+SE1ve87P2d8ZPWG6p5ickZwOloB1HqsvYQzXnlkWPcbmdhWJXAwNWn7j?=
 =?us-ascii?Q?6x3D9ILr8C6xLjmyhgBu8gn67MMIDoMoJLMNYPH7myzioy2UrkFGjO5DsXz8?=
 =?us-ascii?Q?F+SB1SXUmHWlf1Fi6W7yEnWY5kOOSnlpFYShjZjlvLZ+ZFKRSw2bhivZjWd5?=
 =?us-ascii?Q?OW2q83zh06njNDiX8R6zayKzIY+ulmhzf3z6td4zrnUuIDGiiK+Vyh91S66t?=
 =?us-ascii?Q?dawROZ+KraS0hLXZpQCZo82bS0KFYVzqgRLXT8bwhQnBy+2YmGVdWL1xs7tf?=
 =?us-ascii?Q?PLVqXl/aTS6/vuvvWqd9pa1dUgXOpFdPiQtGXb4h5b5OOrKMVQZIMBYmMyl7?=
 =?us-ascii?Q?BrzMH4Wrvi6RAllpuoh00I9wF6+4dlpX/sRvrKEWmUzo/qkfbiEBiYJ7z8l4?=
 =?us-ascii?Q?QRVZWdTqcqNDnqxHHv8I2oyv307IdfvrLEHXBq73eOXsvku2vpsI31Kmh+cE?=
 =?us-ascii?Q?KHIn16zoN8PFrxeNUtZjXOzerrL+xynpJsDn4YBllucvcE5wkTP2pISq+SjP?=
 =?us-ascii?Q?wkmlG8K8H10ONjbhXCkkuZGMjey873MU1A5wRV4wKYHkudCZ4cE2EzUeKPc+?=
 =?us-ascii?Q?xOIsPE9RXGEeX91Swv4qxYizJHaN2dPs0VPnfQyRT73rohoajsITo5mzEr8m?=
 =?us-ascii?Q?xmV0HkC+FIx5SvYIznukhqtEsqVSOSCQ+PofxcBOhTj38M1/F/EBeh48A0l4?=
 =?us-ascii?Q?7mxuYOoJktjcU3VvTjty6izw0ql8FDv7qVB6u6sQzq9HMu+QfqIEgrSRqLec?=
 =?us-ascii?Q?/Xmww/REAECcmZU8Yrzwk/Dqc5B8y/OGjRO/hX1TdFqX01va8bSX/tCYMELd?=
 =?us-ascii?Q?HXPlOrKmZU2xOWI42D3MSYDUaQPUyaJ42R7WHgn8tUJvKrZ/2B1t8kzRhmFd?=
 =?us-ascii?Q?eLlYEcEt2Ur8xp5KLLzB7YkV+yy7TvLiA6M2RyMI7fnEgP9XS7uK4a0Tg3Am?=
 =?us-ascii?Q?aBg9oJMj0hcnUAAbzOkvn1ZtCa0VxgkoMncxsLfqs1SLPKTz3IPQ7xTw3n1r?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8148a115-8c84-4564-40ac-08dd20e923a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:25.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9c9EtLnWN362Kt/XKffG+0fqV9K9+rhInft9vti1iFlch5tWB4mI1i4Rgq0NvL8PguWDhaZm2uF/7DdaaU+XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16922

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


