Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249ACC021A7
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 15:51:10 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.23])
 by mx.groups.io with SMTP id smtpd.web11.24156.1739548268282327099
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Feb 2025 07:51:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=y/lyZYEb;
 spf=pass (domain: siemens.com, ip: 52.101.70.23, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujeHvtXuDsg97TXWmPqZGb0UO+/E9fKI5TrqSCzfMO8TQSjTfQJEyJ+wVhhTZ7ZUAk+ULNmQwDObyyrGOZCgUmGDfFgFzRf3C8LlklVl49j22Spr7iRke8tKGQK7K2FX5XZXI1dOaS3OqYnr6zBqqvfOHXmVta4/3Pjct2vxs4EE7FUDfI6bbEZIZiriDexazMPMfvx7Rn0eoQN2YOzHCALdJuCcMRr/VagCHipyPi6N0seubPMdQTrODabEKe2wc6u5mOyrnRJt90hnkNdLNbuv1kA+uvGZydNEH6qtQhCGx8YYofzI0rVLt4q+5auEaVmR0mNiRFPdylqBh1wf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGjVzQ3yPj/sI2xP3igcwiTRMFzFxuDFmYPGu62AyG8=;
 b=PmFG0WRprr/2H+JyIc2l7R7eG69DIoDgLUgV0nk8xQIW3F4c7u6KiWL5TNtK5xKexvEJIj/n2yVAP7SJaRqnvBxX2LRGmrDdWywGcCOMLdV3gDfpjxjVJnHC7Uctw7Q6rRyqZRiQ1uAT+yhE7PIC1TppBlolZP029TYzbjvkHwQU1ia2kl4jzDZIRNYOEI6OUnC0nFxSkicroaI6djkMvhiKhIzGTJUuauHs68RZCn64fh+B4DjBPIFnfmIQNZq97TvXYExafcFZmqGNpT5TT7YspI+IlfDlIKXwWOlmCFfg9wEQvMwkp2N/F0nX33g5tnpwk9cMml+IqXeKPUWpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGjVzQ3yPj/sI2xP3igcwiTRMFzFxuDFmYPGu62AyG8=;
 b=y/lyZYEbSoBSUi+3r51Rcg0JM+Urf65FnDmw1nQPXrCP9uGwoOLgvrvDjFYdQOO/Gglp17VdZGh7jK5xkkiv2Yljolit+0CP/+SMU4G25WsRmfvVcVjQqnIp0oqA/qTT6gStimWUQM2+nZg4jWhtYfs+gMFhjd6IKvuLgSyWJSXI/mL+4gaB7W87x/v+WKo5jKssIB3A9H490YMg8ZdwpjdYxW27Obv90gJj33qW3mKpRm4z/lDLR+ms3wAp6OECVfzKvlGTIjn+xMMTl7/hrf3HJoN+Na5mm3CAbbGyew0POo7Nz0tDPhOLSWq/ESG7h8YMJRXLGWST9WG1ALjFAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AM8PR10MB4081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.5; Fri, 14 Feb
 2025 15:51:05 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8466.009; Fri, 14 Feb 2025
 15:51:04 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com
Subject: [PATCH v2 4/4] tests/fetch: Add additional test cases to check whether the fast fetch is shallow
Date: Fri, 14 Feb 2025 16:50:57 +0100
Message-ID: <20250214155057.1748020-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214155057.1748020-1-stefan-koch@siemens.com>
References: <20250214155057.1748020-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|AM8PR10MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 65af83ad-b163-41ab-0bb7-08dd4d0f6351
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Lifm2CjY6MW/z+Z2MmYzc23djG1HncgVIknTVikfckX16uyj54fjzFw0b0WY?=
 =?us-ascii?Q?MQsHJbNWL/YWFh4Wc7ekhutA4gbJ5/OCtTGQcHJRq+f4grDfZQKUDTwcKQvw?=
 =?us-ascii?Q?RznGJ98EkUI9I5pYaVy2FAFmj5x1db9IgaxOXu+AEXFr5z5PUr35fXZcpUi8?=
 =?us-ascii?Q?FqXeX4RQMVzIzslJI9hcwty+b4LDd1LXD89wDXgWHgnpkRswEEszVnp2uHNy?=
 =?us-ascii?Q?43Rtn0beaMZUpc6Gc6E38sk6dC93hM1ABn2zSDK8E9YBVrpGRSOh+FtInWlu?=
 =?us-ascii?Q?CdBD8lbKTjvFYL5uiU8b5UDRQoL8BWZTxFvP2M+y0QWS3gYOJ//0vf7ywx4Y?=
 =?us-ascii?Q?dnSgPM9MMgRIVXuAWhaM1IKR2iIuz+WHsPUfJCWT86zHSZh98pddpo8W++AF?=
 =?us-ascii?Q?RuII2GvkCKbXDFkY0TQhW0W5sLTvilklMVlY7AFKAhuzypAadGBylmYHXwsC?=
 =?us-ascii?Q?wn0H2Gvj3eGdrOoEwcwkkksQaaTRoxXU1Ov4ekND40RdRaT2fQwqvMg+R6T9?=
 =?us-ascii?Q?zhkH/3VNzUT5JweXkppxiGJlDPt4tFkM5JnfAgF5xDzTZ7+NUlqxPcpNCtce?=
 =?us-ascii?Q?f+5nZWxtC0TS7NOquqraRbBc7ybbbeXbZD4Xj7pnpenE7W/aoB1EvbknFHWa?=
 =?us-ascii?Q?Sxcq6f94nWGPMXfqNp5yeMi1H2wE2L46PPk/lrhA6VLucwLGLVXeADhyYaI1?=
 =?us-ascii?Q?E2TfY0MuCZM7ve2R8a8Fda3iRmbnSfbGmvgWuR2pFvokQ++x10sOTcr4BT3N?=
 =?us-ascii?Q?peiWYnJ/Ehsk/IKMuc2fnl8n34FpMmBPY9an6QJiDKRJxc6wcPIWULu/pXT0?=
 =?us-ascii?Q?pdjTAsWjyQEohy7wO4HwXc677WyJJRSDYnDqszDKWq0TQRXSEKeVE1VhHbtC?=
 =?us-ascii?Q?kwrsoTJt1mKA/mFGCHcdHBY+LzsszV8BxtO2oU5WFPZdhu7Nd3tisfGeRFWY?=
 =?us-ascii?Q?JI+6zzN5tYcNWumD4ywYnhiuNle+kcVaWr3GM4QCaU4DNW91Yo1Nm/GV+KQ/?=
 =?us-ascii?Q?kY7ZaO2+STLAE/xCaJ+gtuQzx76Ga3fltaJ23zDzsr/3ZI8ug5T7Iy3j7WJP?=
 =?us-ascii?Q?L7BaGktjVigmjdF3IhMyiyt3L8xsvoonrsW1oRGmCsys9OmjytywtxNgKWBM?=
 =?us-ascii?Q?ZlgHljNdi7noVs3MYOq87+zb6mKrsqw+Arz7O6jxDSS/u75ZLrAkTf2G3mOd?=
 =?us-ascii?Q?imfBb9f30K0QMOmo1AgAPqj8SrZIg35jUEv0ezD/ZEREoSNlBB5SPIK28ZCi?=
 =?us-ascii?Q?z1pUDY6wwHc6IBekZzuJpxmw9h9JtudHofn1Ae5X1g3pdZiir/EvlY9nc1oV?=
 =?us-ascii?Q?NjryiTmLLVhDu9mJJeWtuyKprpTSONA6pxa7ZgJc9GBeDmqaLmpdf/t1HXTN?=
 =?us-ascii?Q?5+Pc6QVul4pDNsFMzlmSofrGEndQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d5fM7eixHSaDoEkdbgDHg1gvsrSGp99KoOWooU/cUfM51z9QGFMEeEdXEjPT?=
 =?us-ascii?Q?xj0rLgcDrtLW+i1OUN2cHnvJnw9QC7eHcCXPwDYMA1QOE3kt6ztW3r1KeWDN?=
 =?us-ascii?Q?RN/R8A6B2WmurI+nRJzp+azaY/PfuNgAhjGMFJH2QOfbG0wohRo4l2J+kTr6?=
 =?us-ascii?Q?sOn8XKOoVzWOvjK2z6PdSCdF9ZgVvW/q3jdS4X8LMJLMC0D63/ANF+wTwc2O?=
 =?us-ascii?Q?TKZAGlVyD74YhqgiLRkRtp7thnYDdxvZpzmAUJliAZLGjOWNZ2djvmwXSStK?=
 =?us-ascii?Q?WM4zcZNo6yMRbb82hOWe4gwr2hunjOJozNOcswKgkXpQ+4nB+ZO0CB2QRz86?=
 =?us-ascii?Q?nO41LppXdLZ0wRM1r8++rQtTRbnffzD6zunhrTgEHcuCBsYPKIFRu1KNt9AK?=
 =?us-ascii?Q?vEs0HZ0/OjkiAclob9gLW36p384w7adxidAmQaAcSB7o8uAqKAkXbK1ZpSCR?=
 =?us-ascii?Q?CuuIPQQ80c0YZ7NFaPd7D6wpjGiP91WKHS73SiDYqkhugVHb+PkgDH+qOGRe?=
 =?us-ascii?Q?GB4D5xc6+y/SUUtWQTqWCuxQKoFhxLeqP9gG7e4laBNiQ8ik9OnICiIsB4RB?=
 =?us-ascii?Q?HEqE84vLFxPl0zzqYXoFEZVH8xjsl6QEImrFbTgZZRbGYs7b+p0RH99/WCVb?=
 =?us-ascii?Q?PED7O9WWlF3q8wu/MPnN5ELGuMgggSL/juSbHt4qUGoyFSpyPi/GZ4zAL4oD?=
 =?us-ascii?Q?daV5k8vtzKkDDNFrcz5NtrKlBvNybIbL3+Z6O+l3fHv3DHLwnZJYL7rNJdRC?=
 =?us-ascii?Q?Pc16lQB85fuXks/jlMICn2gKjZWIj7xbmHKPZX9r7GPdYj3aTV1m8a40GAxA?=
 =?us-ascii?Q?pn6IQdahuvQvBx96AhZQMf8KsmmT+vPIgrGGAXkKccpjpgAp/0Jrqlt6h2jV?=
 =?us-ascii?Q?wEzGIuFd4wYdBWQKIA0pk/ligkyUWO57fC6d5DhjiuPzXVAW5hXZ05E6KyZW?=
 =?us-ascii?Q?D5gL7zws752eSOw0olzjtRiTLa8TsXmUvNfwJadMol69oZL0qBrPpDYIilob?=
 =?us-ascii?Q?zDJNmozm2UTNptkNtvZLQpCkDSOKgMTUjykfjueoQKGoH3TVGqz0n3ghGTrj?=
 =?us-ascii?Q?oRh0j9x6FPy7zDX2OmsWQdQx8fJsxrRiD68JWwoHNwuXaclUBSNQRYMrSlS5?=
 =?us-ascii?Q?cuCzlGSmme3eojeJlGZS3VjvWKtXUy31e1nJFMx7MzCQFdQuHzQaernwkywj?=
 =?us-ascii?Q?tkC6IR9BW+KwtEbIwDkyDU2L0MxvSN3RnAuu6cBNWhyN1W8Zo233yAgCTWPm?=
 =?us-ascii?Q?fqoFzJGOuQc3aWMJOpWUVTzFCCWScVKywAFXymXMr77Jy5lHPu9xJidbFyQJ?=
 =?us-ascii?Q?DAaP/BiVjyN2Azu7rtV0EuPiAAZ73bZQHSmPIDDSE8tRpv5FQvvO5q+eaDnL?=
 =?us-ascii?Q?F7yZTQxyFJwZLGCuIcIJiAHz63a3ORrh+/p2rxlPQqG0kfGFIzig8aXRH9WB?=
 =?us-ascii?Q?84WL6HxK1U1uSvTCsprJzkq1mlZ0Ss69kP9YJj2cedRa4r6CMOHQ2ga0nGSP?=
 =?us-ascii?Q?W4AXq4EYVirfCFB/KJChN8JXggQe+z9UwdPE9Irr/TT4tGwfMdk5HG5Ygraw?=
 =?us-ascii?Q?trStLq/81HhVYHOTCbG5N4W53D8gzSV25wRAzjh9Z4CE+FQVhndQ3C3eV9li?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65af83ad-b163-41ab-0bb7-08dd4d0f6351
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:51:04.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRzkKl60MPZM63xCMVWLwveo+2CkuO5fcPbo5VKvHJeCSLIIBrpv43PzaMBMV78tFDAwE/2Ml9vXDXZxIREt0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4081
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Feb 2025 15:51:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17225

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 2891cf9e5..a1d9f4e61 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2350,6 +2350,18 @@ class GitShallowFastTest(GitShallowBaseTest, Fetcher=
Test):
     def test_shallow_clone_preferred_over_shallow(self):
         super().test_shallow_clone_preferred_over_shallow(fast=3DTrue)
=20
+    def test_shallow_fast_check_is_shallow(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        # Fetch and unpack without the clonedir and *only* shallow tarball=
 available
+        bb.utils.remove(self.gitdir, recurse=3DTrue)
+        fetcher, ud =3D self.fetch_and_unpack()
+
+        # The unpacked tree *should* be shallow
+        self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.gitdir, '.git', 'shallow')=
)
+
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
         import shutil
--=20
2.39.5


