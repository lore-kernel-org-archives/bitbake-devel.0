Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB5CA0FED
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:44:44 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.127])
 by mx.groups.io with SMTP id smtpd.web10.15209.1757054681032438910
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:44:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=6IP8p3qI;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLiW8QN+W4QJQGiqDjCbElI/C+pyPJxCQ79l2fJiLzSF71+IjiTfpZIkzG/1BFuO4q3x5pSMaMLDuir0OYv95H27WgWX/rHF37LIY5/WVzrcomFgBEcIJLP4+E1rvbWwjXYJcJyLF7evjwmJPZ99KEyPzoDglNCVceTLUmz0Cc9PUZ7Wyz3tIWEq62U73KHJqA1Z8dKc9J9Nn8wHw0xEogvd/Ca/eCJnuOXPFFWUrxMGFFV+VC8pvUqPHuwxUKGN6ZJewyEOc4+7SIgPttw2hbKygN29oRCkadT7jTtWL3Syqi45PdPCBVovVJVC8PmI8eIzueVf1OQJRGxNs9qeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7a3KdtBGjO2oBkCoR9VGELlnjTARRX4RBEzPLFdTvo=;
 b=EAqZKeB/fdzGTF0SiGeDhMTd+SXKfJZv7h0KcdxbM8kAf3O5yCo4RQQAHMSlQTqG0chz/y0vGcSNx9wdw3rUXJYvn940BfSGyeEMYS7qjrkRJpxalWnngi1117eBqpVUTd6qUKMZF/3LHQVKTcn7STh51CxCuEkqlCQwKDKI7rzS+cDQxUknVtbaA8h3eIHHHZCHoyuEzn1r0bEtD0CyDJYRAPmxP3buSvb6T+ilGSlwGf27tj3SZSdSFaehhZ6Az0kLMXb2SXtuM1ho/NFPV0ObelUs2sC89mY6BB6EFYjlvj4HAEyI9bAyE6NbfRSP10mQxAW9Pg7jVFxkpCdgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7a3KdtBGjO2oBkCoR9VGELlnjTARRX4RBEzPLFdTvo=;
 b=6IP8p3qImlsQjTcWOD+8GbqdbBXkgcYddevfvYXNuFr+LUS+PhKMVwdyliL3O0lrlDxpyaCnMFPNywMkPwR+QEWmLrtV0H5mEFsRhCGEhBC0ogTbm9kr+XIIATfSEydhSDC82j7AzWkFKYw+LZtkfUzu1z5thkN9FdscHb0XCReu+io88RPc7QLjL7ZXLqaMNyCg0iG+8yXN68H6WjirrQmDA7dp8rkWSHtegQyLDvMHQ+7dTXq7to0nJOpF/lRDF4ChKXnlGEJP5UInqznDspfJmy6Ig/KECYYaDzTOx4jS4do3EYoKUVBALbr5nHXraJyTUaEj97NCkW8qNQ9XXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 06:44:37 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 06:44:37 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v2 1/7] tests: fetch: add test case for gitsm implicit local paths
Date: Fri,  5 Sep 2025 08:44:13 +0200
Message-ID: <20250905064419.2589111-2-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7e7d744-f454-45ca-2108-08ddec47ad39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9rd49rHYmVbQyurDEIKgpPWmflhP026lSlHzrpgQMH6BeZX+2jsAOlvmyD76?=
 =?us-ascii?Q?BdKt2w0utoJtLfrD8IINIPXYPh64/sBb9rV71PQ+7cSXCtui6fjRpbu/KFH/?=
 =?us-ascii?Q?qZ9aO7Qg00XVqEselkZSrwHIo8GVCXuH8+uTKue2avlHE7bjy5U6t39DvwRP?=
 =?us-ascii?Q?QqxR33Hf2vFTTQH8g9lOuo6S4D7HUqtPi4HMstND+b67B/5B7hqgxG1j8snO?=
 =?us-ascii?Q?rqgVnPnlXJQ/G2LIk0vtSQZPzQSqBqkvvbp47jMJ7lvDnWGXHH5P8tTT9hRO?=
 =?us-ascii?Q?BJuZLcraYDEK40mmZJNojS7ZRUpJVL71vQKq1aIFaT16HOTChsoNJ7M3oC2j?=
 =?us-ascii?Q?ZvcDqTMuzwE8om+zxDnNL9EMpPSdl7NoEAA51Q3hRC+3mhf4FZ5kQHS+7USu?=
 =?us-ascii?Q?MD96C+atvcvO64Pe4fQeQCFHqwhn23pf2LmlJgs8c6H6nNe6Srum0VDhMAVn?=
 =?us-ascii?Q?EBY1SJjCsoxRaBG8b6WxD+v72MGxtIuU/iCnKqAb7c6SCl7m0xs1R9apUZIX?=
 =?us-ascii?Q?pjGoW4CFdi3FmtiDwIlRYnSXBWZNWpFMex00/yzQdAjSDwfyplNV/N82LjWl?=
 =?us-ascii?Q?Lq5ONqXZZsufJFKLUJg4V+Uro3w/qs2FVjxQDMI12OsjCWN7WOIeq/B0+uIx?=
 =?us-ascii?Q?HskbwMymXVqHGtdkI7O/rWmdkQEsfZYhQFHn+KsNOe5yGuS7Q81isXDfS1wJ?=
 =?us-ascii?Q?Q9hvrrQXIxNuSHAdzRzgHBO9jomSGX6TcHKVmLsTq4198Xtd0W6SP4pcwiBc?=
 =?us-ascii?Q?SRO14+qymVcupRuqd6/AjKY1FRc/EBlxcKTSpftbEKZ+bCY9H1iAk5Jx2gDH?=
 =?us-ascii?Q?QkbjrFpT2q3L/BwaBHHxmjUAzl/RlpojLQ8p5dHwPxbq4RLE7WxwuYnV38dh?=
 =?us-ascii?Q?WYZCGFB7ZK+5a/l9A4IRYVURCcPS0vXuyOLZpvbU/OIN8LZt9eu7NP7eBqhV?=
 =?us-ascii?Q?ut540t9DSBQeZz63LJmPKTZsYU10CzVkU9GxjHTnm3qtlVjDmRNHdruJaoTJ?=
 =?us-ascii?Q?vUsmzLDZuPrZ/1Cb5ybl0/cdhf22/O0x+5hrgE8xAlFm+CjCqo5uGmd+ePbe?=
 =?us-ascii?Q?z0nPaj7UjiTUshJ59B/w50gVp4hTuALp0QzEuvMIGsG/rDz7QRGivE6jg913?=
 =?us-ascii?Q?J2TxOHIxaeQIRdaLHIrQa4Nxv505eJ7yFKhBEyC/BnY0sDs02ll1nw1hi+Wp?=
 =?us-ascii?Q?nMWEDW48n97LsuEQvK9j4ptgWujLw2izbAzL2k9qXHoumRhOYgpSjd4UaRKu?=
 =?us-ascii?Q?UyHaFRb7TBBSCng2OhlQIbbGv39O/mVxDtNSTvne5ZaAhRB5Y+OAYbOy3O1K?=
 =?us-ascii?Q?Tqr0MmJwLqorNMTVSe/k/uU0QkljTUfjlCmaKK8jWKiTMH+2qnT9GF1k2z0w?=
 =?us-ascii?Q?0EHv98aWnC23ayH9HYVxf3tTVeTPK+GuG1FckJBmZa9f2osv72YMElsQai+A?=
 =?us-ascii?Q?KQZtbqiY3ZQB1dcOnwuhd739rYNTP1ttyk3yjwjC/Qu2D67SnjqNkw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0nxtS9tlMidMM4k5eWLnbF/O2Yi/wBnY+O9wQoKKpb9DbP8/pjsyfUKF5AVr?=
 =?us-ascii?Q?Fpraxa32ZcdkSbDr/pXiXNbh1k94tM+nIGPx8tjOdM3yljRo0qm2m3pcKw1y?=
 =?us-ascii?Q?40B/EakxawGjqyhtzzO/iWX+ZPRAGyFXenilytWCR3Sq9yXraS07bKk/1qE4?=
 =?us-ascii?Q?pdbjgYEpDXqcXf1Kd7ZFqz5BmgEtMQAmBUiVpqzsyHIywMMlghIBN5wr2Rks?=
 =?us-ascii?Q?i/WWkcu587glSWTXHb3Y4cjNg0J6QZ2x9mxS7ACQcTMknwULSH0ltFLVoYu1?=
 =?us-ascii?Q?Fe7AogjIRkzOoAImf2nRc/8fr/dulpXgz8rfxKekLLKki2HSFu5S7MLICFds?=
 =?us-ascii?Q?2PCbEdQmWiJpfcJTfHz0V2Z7Mg5XPIiJiCDx9EZm09Xcc5TCHCrTZdCCGO6q?=
 =?us-ascii?Q?t+npa+ICw2JvMmaUjHFyCnb2pVuLSqrazP597V3LsoBTbU1kZZOws7GqbOjR?=
 =?us-ascii?Q?/WjCJGWuDooL1ltZmJvhWcgKIQzAPOcdpDGbJslJBrii8jOcJgYbW1Vwvhhj?=
 =?us-ascii?Q?F0KHGVrrTpOQoMel8EfJqZMcfKqQmgtO5mgyDQyqXR/cPOGUVaYEsp97735s?=
 =?us-ascii?Q?JskYJez4/GoUWGelcICaSMQ8PMbz48FwjuDYk5JeBwKsdA6sXaUwmC0ZJBMj?=
 =?us-ascii?Q?+cS9srlU3UNhgxxqd4pM2o8f9ZGuE64aOF9tCjWco9ICbTgcw5HKAQu/qQY7?=
 =?us-ascii?Q?rQRLbWoEDeW6ELWP/V6e2NFv4Fe4LKNKRv97xOvIk37uQ3MbgkN0Ozb69PqF?=
 =?us-ascii?Q?VouM6Q+wLIAFNQtRljJJ8YaESotDhn6GnO2kqoJrWv/dp3O10jMC/hhg2MiB?=
 =?us-ascii?Q?t8pWHZ36AN/Iov6G4E7RaUyNyDPVqsGv3Cdrmhy7QjdEB2hxk0aPT+qKYN+D?=
 =?us-ascii?Q?XGkS5YBqvchUrc4qHcRBQj+bPJ/AzpRiuMBqfYSsQlLsS42EmL7yC9MbkwEj?=
 =?us-ascii?Q?8kXgWRLQiDE66fO6p/kh8iWkrAzj2n3XcO56IYknwDNI3U86SNcN4oarsftr?=
 =?us-ascii?Q?Up0FucPRu9nzp/iJbr5HJnZTQNHbBO55j48iOyClfmsjySZoc/lMcfNScAsW?=
 =?us-ascii?Q?B3/sXd9geYw6y6axdo/DtoVxatSF2VGUhjWYn8386g4WL2o86YYvVH4aPnsT?=
 =?us-ascii?Q?pmHWXDurrjtSd4stjdKKwlbON+kRVuuhplZzuNf8awz2YtHFcpGSddYr8MHT?=
 =?us-ascii?Q?45YZxSQllwR2bmkQtVgfhqsGmjy2AzuoYwpy2E7g6jnVDmfkiW6NWVcy/gm/?=
 =?us-ascii?Q?zLqEhEu2zQBHxaQplE25MHzIFl3nAzZFmFYxmJH1xRArlNmtRUkdJ7kYuy1o?=
 =?us-ascii?Q?CECSN/XSnz3QyQFXyYu2CH3c3HgtHjPQx7L6oTkbNw2JpLkrEQuZaIB8sC/O?=
 =?us-ascii?Q?PjhvCGk6VH8LzImxoErdp7AqGE/+I0W/07iin96gtzLOemLHjFlCr6OEZuXa?=
 =?us-ascii?Q?BwUeFZHSkeDnDflTzk8b4oOQkhcs47JZR8H2qiQrfzTCSiaWaPTOWyDLkwzM?=
 =?us-ascii?Q?MQBmaFzhpcOzl0Dgp1hz1mCohMHjHsmORKpXvPmKzNeH08Yy3G8tsZBKk064?=
 =?us-ascii?Q?XfOdQzazr+1nU3SUH3LLJi1BXg6RtFxgM6e/No152V6pitsIbe+1pETFI2Gs?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e7d744-f454-45ca-2108-08ddec47ad39
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:44:35.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1J7jxfXzRKG8qjIiPc7EzsFiV77nsjO5IUq9Avpsqip0tyEo4KUCnDtSo6liiMMYHTSkyTQwKxriFeoXKi1KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:44:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17973

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

Changes in v2:
- Move test case for gitsm local paths into FetcherLocalTest class
- Remove implicit urls from localpaths

 lib/bb/tests/fetch.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index dcbe60783..feaba235b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -900,6 +900,21 @@ class FetcherLocalTest(FetcherTest):
         fetcher =3D bb.fetch2.Fetch(localpaths.keys(), self.d)
         self.assertEqual(fetcher.localpaths(), list(localpaths.values()))
=20
+    def test_git_submodule_localpaths(self):
+        urls =3D [
+            "gitsm://git.yoctoproject.org/git-submodule-test;protocol=3Dht=
tps"
+                ";branch=3Dmaster;rev=3Da2885dd7d25380d23627e7544b7bbb5501=
4b16ee"
+        ]
+        filenames =3D [
+            "git.yoctoproject.org.git-submodule-test"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        localpaths =3D fetcher.localpaths()
+        self.assertEqual(len(localpaths), len(filenames))
+        for localpath, filename in zip(localpaths, filenames):
+            l =3D os.path.join(self.dldir, "git2", filename)
+            self.assertEqual(localpath, l)
+
 class FetcherNoNetworkTest(FetcherTest):
     def setUp(self):
         super().setUp()
--=20
2.39.5


