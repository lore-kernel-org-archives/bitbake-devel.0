Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53521C0219C
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.73])
 by mx.groups.io with SMTP id smtpd.web10.68437.1738932437003972275
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=mr2ewtUR;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.73, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH7gDkUnxNfLf87McdJqzbIANCZ1zwK7AfGjUf6jpg8fbPPPXdtbDhcyTMx3zMEhB9zgcptrolmnKVcvxxpHWCKfjxR1fFU0K41poHuYjnajjFQm/KYRqqi6i1bpdvnQMnpZWwK20Ss1IJaJYxQTavJMwSXdkQu4SxZhT57dOgGbFU0n0h19ibRINbK8VCqgzBf0xuDyAqP4AQ/+fB5v8YkqZrkiHWUNB/ati8nSP26WwlxzQrsVLrEnmWtGv5XwgZpg2s/7pf5z07PnfhYagoc6WpyFLknfx0Sy9cU0IZj9jq79kxa6pd9RW9ybBuKiFmBtyRhZOnCymQkOnIm14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSkGb3Hnfuny3auLz2RXOg0fbaRMFrhScg0E0eTgalI=;
 b=UikaIS6mRwVQds8CfRxSftZHzosqwEV9vab1rKpJZVa+rd/9XF+QNsE9lCYxHGjN8bQ2giGPvXs9OBsL9Lr1hB7BrDh0A2LCj6XlGCvGa49mjTNjQRxkVQViOhwgaXq4xC0UQQC7zZ2agic5CK4y2mpZSJ5Z4k7vxFl2BA1rZIL0DONDpsG9TiYcTMpwypxSJ7HBiqtBPCxGIShZgB69c9cY4rC/oNTnMsFXrdd1JIkKBdYDu5EnxO3vz67XzXdm7fFxuWu6K/hFCLfrc2FjahbOFfRLWFdducR53SJ1FLph/enXXfAhojp1a/Diw/x6Y99dNyN/q94sGhbR8RdEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSkGb3Hnfuny3auLz2RXOg0fbaRMFrhScg0E0eTgalI=;
 b=mr2ewtURquAuac1Baie4MPze1QlDQm0TyS/ud7FP6lPo508El6qUSgnYZX6pB+lMOJU/+2ZdzPSM3CYLmopNxiSyFC7rZDSVfdY8lUkTXd5EDcTHV6+KB4XPs6DvsYmgEn3zFiFWAlriTd4JQQfgnz/beOpMJL7EVby8RsoNDJY6DbJRWH0qTAo7NselC8nwVmSr0aiIorHu1cprDSCciXkKGXOGS0zeR2Sdzuf+A9a6qijHMjE+lF67+HPse80Ounbf7k8auLV5yU+rUwP+mbM0kW2lLaH5dqhKx9akOhiKhL9IE5429g8wWrqsS2bOXvSt7iXMHnwZ9k1UFmoT8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:14 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:14 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 02/13] tests: fetch: add test for file URI with @
Date: Fri,  7 Feb 2025 13:46:50 +0100
Message-ID: <20250207124701.14787-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: f36b9287-c584-409f-f20f-08dd47758b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QVtLf+inqXYCw18mOqfkKPjLUp4WO7cVkJEO71sOE+IZrMHLFCt0ZttKYUGA?=
 =?us-ascii?Q?HuasvFTXpy4Yj8m7b/ZUCILJ2BERy7vqve1//z6sdcgYrz8GtCljmqNEt9S4?=
 =?us-ascii?Q?bXF+hYsOY21XCPBVTcy+dCBqVSLuv9+gKjwyQfsfVvl0rufq8PdquU18PHJn?=
 =?us-ascii?Q?+BArcZjVR7l4dIAcx4VOKrxi434n3ws0l8pqk5bY1Sq1Y3/zvPG8vEd+WnSs?=
 =?us-ascii?Q?CeJWXkaEwEpR5dbVDiw7S+uKmlrn12/LSMKDz7P9zO6DffwUIrHL+uZxl5ag?=
 =?us-ascii?Q?gpylQ8L/gpN2mVhPc/KLG03nVfgLf3pwLUXcBRXJbIGa39z1y0o0n9f00AIY?=
 =?us-ascii?Q?LjKXFHQsMDrlYSJ8igUpz/LXZFNoSaj+e+JTMFK1zVBttb9YEAKqa/sMUVPF?=
 =?us-ascii?Q?S4PFIn+hp7n3tILoQnfLLDBF8U5CETwJYxhRTeXoWbqSlQTmevNR/h5hIaAM?=
 =?us-ascii?Q?dkPm9+CUAL1q5NUfPG4MJKdV9kGL6HIer3j5LoFXVnd3vyv3cvXZJPg3e94S?=
 =?us-ascii?Q?6pu9msC8+DYs0ILyJiQ/BfkzPAi9Zjepw3JQypR3Ybd7abpg3MSZl/7RtV60?=
 =?us-ascii?Q?A/UeZBpU9vyZM6BCyo2H78AumSEHrjNEa0vom4EUxG34twyczEelPhw6zNBT?=
 =?us-ascii?Q?XGY/CGR1bH3xfREFEn6ukxgsRKj67akOTQra4G/hKf9KDaagzQRSRry7UdFu?=
 =?us-ascii?Q?40NbuJI0PEVl3aWUgM2Kggw3xR9Ai135GRGC7VKcJDVt8inqglqvFUxUAJ9i?=
 =?us-ascii?Q?f8EUa+fETozoRm7zu++ZY2ecTdjWkM2CWU1THg9srBHP8h3K/avX11fzk3Y4?=
 =?us-ascii?Q?usD0VavhOubPBK44c07+GiyrlqqXVZ+sr4gxoEbdzkJZdwecpJVX+dEV8GMt?=
 =?us-ascii?Q?0NfXUNFBWo9h/m5uojE9meFOnEpcDFdTZuIILhX8uBlFqKYUqw+knk9LiQGh?=
 =?us-ascii?Q?PGDyz2346/xCkDsyrXE2OjMMumbj1romcT+FIHbu+sK7urmnXjwJjwdbUCV9?=
 =?us-ascii?Q?SoE3LT91U9VUVSeSYJEPzc6Sb1qEFSBe1T8Rur2wYsoDjjUbELKG4DnZpoRe?=
 =?us-ascii?Q?TmE6TksGFQYa10JXVj5rrnZ5ZLlgEWfA4a/UtGi4Ukk7TbROSzljJH9g6Uzj?=
 =?us-ascii?Q?j1hpPerrApxERyTj6t4W5OBsIdjIWpqW53R3wj6Dv78J/CPsq/8s/+9JmTu3?=
 =?us-ascii?Q?EwFvOXE61x4pAuqNO5yLsAitn6ng0QO6+miRbWJWvPp2pUUTvM12ceoOjn9E?=
 =?us-ascii?Q?HkCGsXhO5WdtLIH1/Ny4I8rxiOl2Tyoa//yuiAqIpAZ4JEHYgBKsV9diru2Y?=
 =?us-ascii?Q?OLQSmk9r61mtKy7aLXD+1nBLKuO14ebydGasfP+M6MnQVAzMrHMa3alu8ekt?=
 =?us-ascii?Q?4PXohWpiBYUC0XV5MtcQRwQLKwSTpedWYvhMuSZZPhXZnzZffg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zvTrFK6RqeRkm7T3kAGgNQrkxU9hK9N1qmLJnlGGDpixKoSIqU/yx7ZQtI1c?=
 =?us-ascii?Q?++Uw5g/pAETRUQcQnj7fX6rZXdMa16jpecKp4EMwxo+IjMrYRRQNch8E3L5t?=
 =?us-ascii?Q?KaSFklTu88CnpB67dfbF4egyjwoBeUbR/fAFVRjgthiGofPLdZtlKJG6hF7Q?=
 =?us-ascii?Q?lllJ4V/V7G/hizRANy85d+v16Sa/r1q4ZWCiJWV+HTVWXoCyaO2jxjpDkAtP?=
 =?us-ascii?Q?bDvO8M+smLzaPe9mOecnnnsIlaKWuQ7Tw6kZ/836TpJSv+9dmdlQn73ZUWLA?=
 =?us-ascii?Q?q2u2BvovbMaIpbAhahmz+akj+eQHLqEGJYd6DqUrv9G8VSxAOjhWz5IpVuvw?=
 =?us-ascii?Q?sTnliMBkHkqCf5Fy/Xku+rxn0l5LgUsuyuD3IeqUHIXeHeBBqgjVOfIk0JpN?=
 =?us-ascii?Q?pvZl6uPrtfHEI0EZ5LEdYoDy4nSoENEvnGkORzd90il42AQb/F6Wx8FTXYIj?=
 =?us-ascii?Q?kVdqNVhzqcxu1cllFCX45TLvxnOBjo3yE1eWoXQI7tgP6D4PCowcfaFWXY3W?=
 =?us-ascii?Q?zWIwHuHezMoIM4CX99hCwr777QTLSENCZc8SHI+g8FZFOwLdhQBrpwWK4cMv?=
 =?us-ascii?Q?HN3QfFudCNEW42DHbx3EhJAXoip0ja5/aKfa0I4HAerSrZU1UIyoiScHJvy5?=
 =?us-ascii?Q?lJXCFWdQ8JvkRSkLoTWkGW6EUcBQPEAAueQ9chrJ1SvqxvEV9a3Kr7LlP0u4?=
 =?us-ascii?Q?x2orcLV4LFMRyF33KtfdNAU+fVt/w0K+Oq6dGNR8bKGW3Hq1KWOSAMfFRyd3?=
 =?us-ascii?Q?l4kScVLevvWYkeBQ8AUlRAb/5ka0AJGEpUT6T54eCbb64CZO9WdhU5cSZE+U?=
 =?us-ascii?Q?R8Pd7skOMUVflSambcLw8ZB+VvAYEY8K+ahu3g2etd3fG29GEJNQymUNtqns?=
 =?us-ascii?Q?Ed9myKspWZ3JWjhIAtgp11lMJELq998iTaJ5CAtWXKqY/YyCrtgrUsMU4u3j?=
 =?us-ascii?Q?NKfwgVdX9gValIC5gjmUVMIOTHuROfHyjBvSfX9gLp7KemVv14MHhAiICHoS?=
 =?us-ascii?Q?shHiYl/vv5+/F13hbrcch1RqTjcwuX1Jq0QqOz+iUp5GBg7TzEQuzEi/PJnC?=
 =?us-ascii?Q?9HO1cofl03vKPkagfLw1LKo6r++LFKl5zJrWbjIYpa8WM4totgxQmtskFgaQ?=
 =?us-ascii?Q?L2v8aCIfCMxC87y3pweGm9u4S6KTaYGaAYtf8d/ZwPU/SKMUdRkEn8DugN3x?=
 =?us-ascii?Q?eILDTGW/F7IjMS465GF5JcqvOMX2ixeoefAzmkAtaaK9P0UWwmPonQbcpe6c?=
 =?us-ascii?Q?XGfgTWI6W/BiTG58g+3v/6svYOwElnNjeMuIxaL+V6E4Gt+S7RGrl3rjxhIg?=
 =?us-ascii?Q?J6lC6CmoRW7CuV7/w5lWpdiU4B9LfxwqFW953nOdeYo7tv5Di1xYnAGD+ZP9?=
 =?us-ascii?Q?fzRfYdo9ZJsZqRlp1V35iGIRi4IOApirFgih13bE2EYMn3xtd/Izkzk9SaHR?=
 =?us-ascii?Q?it16wP3E9noEeKQc0qJEYLwskOomsXfFgO+K9OIiEdhL6wLmSm7bb0rSSJhh?=
 =?us-ascii?Q?BhLu7MCz9ZYhmhQe8ES0X5p4oX9CIO0zDr2ubCnufdhouLNPBv5AajC/+UTA?=
 =?us-ascii?Q?gQEJzhXIfjmk1t/WOLghFFXJmHVnRqv+Hs5LitrFa3UfDSH98OEmoE7p7VwL?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36b9287-c584-409f-f20f-08dd47758b4a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:13.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tf5P5ai3MVrb8HwMC43/8GbWRV3Idpq5dTCIi2TimR8DCptUqLNUK8v1zIVX2yeoiBgT7iBcJ0HTLJZ/dsRB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17171

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d64717011..3be7db358 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -323,6 +323,21 @@ class URITest(unittest.TestCase):
             'params': {"downloadfilename" : "EGPL-T101.zip"},
             'query': {"9BE0BF6657": None},
             'relative': False
+        },
+        "file://example@.service": {
+            'uri': 'file:example%40.service',
+            'scheme': 'file',
+            'hostname': '',
+            'port': None,
+            'hostport': '',
+            'path': 'example@.service',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'query': {},
+            'relative': True
         }
=20
     }
@@ -728,6 +743,7 @@ class FetcherLocalTest(FetcherTest):
         os.makedirs(self.localsrcdir)
         touch(os.path.join(self.localsrcdir, 'a'))
         touch(os.path.join(self.localsrcdir, 'b'))
+        touch(os.path.join(self.localsrcdir, 'c@d'))
         os.makedirs(os.path.join(self.localsrcdir, 'dir'))
         touch(os.path.join(self.localsrcdir, 'dir', 'c'))
         touch(os.path.join(self.localsrcdir, 'dir', 'd'))
@@ -759,6 +775,10 @@ class FetcherLocalTest(FetcherTest):
         tree =3D self.fetchUnpack(['file://a', 'file://dir/c'])
         self.assertEqual(tree, ['a', 'dir/c'])
=20
+    def test_local_at(self):
+        tree =3D self.fetchUnpack(['file://c@d'])
+        self.assertEqual(tree, ['c@d'])
+
     def test_local_backslash(self):
         tree =3D self.fetchUnpack([r'file://backslash\x2dsystemd-unit.devi=
ce'])
         self.assertEqual(tree, [r'backslash\x2dsystemd-unit.device'])
@@ -1388,6 +1408,7 @@ class URLHandle(unittest.TestCase):
        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=3DV0-99-81;modul=
e=3Dfamiliar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '=
anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'famil=
iar/dist/ipkg')])),
        "git://git.openembedded.org/bitbake;branch=3D@foo;protocol=3Dhttps"=
 : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo', '=
protocol' : 'https'}),
        "file://somelocation;someparam=3D1": ('file', '', 'somelocation', '=
', '', {'someparam': '1'}),
+       "file://example@.service": ('file', '', 'example@.service', '', '',=
 {}),
        "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234" :=
 ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idtok=
en=3D1234'}),
        r'git://s.o-me_ONE:!#$%^&*()-_=3D{}[]\|:?,.<>~`@git.openembedded.or=
g/bitbake;branch=3Dmain;protocol=3Dhttps': ('git', 'git.openembedded.org', =
'/bitbake', 's.o-me_ONE', r'!#$%^&*()-_=3D{}[]\|:?,.<>~`', {'branch': 'main=
', 'protocol' : 'https'}),
     }
@@ -1405,8 +1426,11 @@ class URLHandle(unittest.TestCase):
             self.assertEqual(result, v)
=20
     def test_encodeurl(self):
+        import urllib.parse
         for k, v in self.datatable.items():
             result =3D bb.fetch.encodeurl(v)
+            if result.startswith("file:"):
+                result =3D urllib.parse.unquote(result)
             self.assertEqual(result, k)
=20
 class FetchLatestVersionTest(FetcherTest):
--=20
2.39.5


