Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E2CA1010
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=iT6c51Sr;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhJKfazTaVZ5akWdNuyMXfmTDNEUmAX8+rIXC3AXfRmDAGOh2JZe6av+rZEcAVGgMdxMtGAz5owbntvlrGtNqok2E5JwI/IRGIXDJntzrHSAgWqu/x58YTF91fYQu//fF6xgk1t7WAkMGsc8adb5nqJV0tCf98O6cXv2v8x0tSozZ6tdwJjXziiLTJwCRP/2fR1IKgShCIVFWxcbgbdNOPOsAatt3b+7i4ikyTrwvvzzCZXxJAa8HVpSYGlsllJrApBweHci1ubkFZnsUskYR0TtYl9izy2ZmpQ3iA0RnOJEcNlUcJqrH1+ctBNjtzLvgrOCKx3pOKqbttHg+xiy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klRo2YCYs8fid/Pde4qdC6lyMz4x3raNKqBO50lqmuI=;
 b=yuuC/F9YxrPzWiVj8ygLxsGF5Mup+wu5K4TTvTvmheVRy/7TkcbyrcrWa8uqUhlfk98fRfzVfvzEGxhzICzylsJKeO6it8PXY+GtyjVYpg27aVvTcF9cjh9V8kuWEvGzTdrDl8erpgzNENnlaaUaJVbMsKiWOx3P4e5SSVfDmKCFpHldr84hsQ1mk8N8zHMWXCHjJRt0SS1QJF1kaPSBN4NgoqZoRDKqeAcxEQqyBKVRVEyiK7ioSpXG5rGvPCBtNhdp3B6K4I33dyrNJjt81mG9Ea4zarNtmWXvHIRs7NAuRvEOPvQyUzQkpty3FwPqh5cEjvUeGovW81w7+lfdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klRo2YCYs8fid/Pde4qdC6lyMz4x3raNKqBO50lqmuI=;
 b=iT6c51SrwiZY1nS6Z39OxjUe+GFY79l+7O6iVcBseSLlgZC0FFjT5Pwpy6Y89NcR1W98vE8JWGqOBniyIIhBsOaveHpL0vlhOk1FC6YFiaV4itUjlUYPKgLiU5v0YZRSnfaV76woIRcC3vFmnjpLSS7H1kFjZqR2HW4EzCohhFBEVTorOGmvrxjsv5Jeh+30yg5OnBabwIr/KCMA58XAZTiI8ldzLFJuMTKy+WmvT4nFQe/qAyMGHa6lmhX2c2pmqsRTIKXjaZKd1sMArSUAQ0fFq7xE7KEL2y4KVTXsa47o6bQ5ONocDoZJkkltdsRc80LeEjOZdb1Z3E8bs6ZYAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:10 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:10 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 01/15] tests: fetch: add test case for local paths
Date: Fri,  5 Sep 2025 08:20:44 +0200
Message-ID: <20250905062058.2563806-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9b964b-3890-4f23-2f52-08ddec44679c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f4b88xLkWBciob3ME1YoZeBpiGUrzAkSCEAf76R9/XnSd6XF0gj1kzwyB25z?=
 =?us-ascii?Q?xicUmGOywyJNLzPLy3k4/KODXvkWeUaCseLzEyRCWQAeb5GIeuW3FVCHsY2N?=
 =?us-ascii?Q?Hygrbmp8CLh9HkfC8vLwJZM3O3zHC3xnD5Y+ktmeovHhEyKaHXJV+0O9f0+8?=
 =?us-ascii?Q?48Q0BckXdGZdGOHNGmuA/AuOy0nNleBCa6SGSt6MYSH7Sq4zcPfB//jacm/Z?=
 =?us-ascii?Q?SCyTl6t3mFJqKFkVuIEpV1UoKrQ5qt7zKaDn2w5m9fvH6w4MHvZrCzqR5rys?=
 =?us-ascii?Q?j3pkraVx8R3QkLMBVYKsFVM6E5bJeZCkKFk8NYaMcPC5+l5ztH7KetRqUvoa?=
 =?us-ascii?Q?WGLo/oy6tl2BzXyrppo/4JFYi/qd5FadAMhWD3dEPNBzCLMmSYks8hUompqn?=
 =?us-ascii?Q?BFU3eQiAIVO9Ni8wT25O8xxnnfxL+uO2/4IWJ3YCv1D4MRSNHYtx6/L+i0bJ?=
 =?us-ascii?Q?12op6yx8dFjabcWcU2S1jAbdGKdNaYwdvY0PnU6T0dEYNTqaVEEa81Ym5B71?=
 =?us-ascii?Q?Emeuk2UeWEMRjnIe75l171KIJ59x9AFZnGmMNWPUTrWic4slItqr3Ek5tsXy?=
 =?us-ascii?Q?JcDXMgK23g6Em9eXJVQxk+XcHeRYmZRzXSWaiT/WZGv7S/HMfHKCHDk7R5Y/?=
 =?us-ascii?Q?xYvIoedZJyXgAnpZDotqStVmbCb4oL2Jm7+VCjQjtYpsQz36jXD5tCQmJ9Kt?=
 =?us-ascii?Q?2SyC0MkAa6/rDrhX/tW157lPJMkVUlP9Q9wYTRv9Zx/3LYzNFLO08GJO56m6?=
 =?us-ascii?Q?fWsTvHcoYIOLdlqcYDLOjrwdmxs+jPOTQLSFZQVft2UwVooXDaOwKtogpm/R?=
 =?us-ascii?Q?MKP2zS0fEoMcLoEgwaHaukEzCMAN9tqwyQB1pjlk8Nav8/VmhfPf5bgyedug?=
 =?us-ascii?Q?aQUmmQ9F94ZAHNAo1YrotdbD2HRJd85ZUw0m2enlMPGHvbBbhkZVvb5zTk8/?=
 =?us-ascii?Q?eyNHiw6dylxumRiXc69+pZ5eQuYVS2bnrRWhnplGuVH/QvEFzXUd3Eeo2CAE?=
 =?us-ascii?Q?snKbv+vwxJGd4xzJvOQz6w/ukx5lH5TCK+vBjimVtgB/L/9LkUCp0oxBQOqS?=
 =?us-ascii?Q?XBlamS/elbSWFDIYnAu3wFlLdI6cFyvy9Wr+LQaDu0Dey5FS8ZD24rf1x4aw?=
 =?us-ascii?Q?O5QM0J1FY/8ji63NyDBq3BNNhmZEqf9NlB33K1siJ4NeoczoHa8E/2vniW23?=
 =?us-ascii?Q?MfUmX074QVI6SNGGLCJQbFChgWQqCV8YZy2AIGaDEHOXbTF75cknTgcqquy2?=
 =?us-ascii?Q?DbBAewb/iXwvDuA4CJg4VN4vHZ9MNQp+Lsn7cWOarLIC9voD+wBJukrxZvNj?=
 =?us-ascii?Q?hjqODTMFsIwdXk90TYpeUpqKZEUHwv7OhnJj1GkmKhtTX+XdYlyPV9ULQ3qe?=
 =?us-ascii?Q?jjHAHePpBLLwycaNT1atHDsthBs0PAAPr/VZeZFg+iL2L8Y/wYWwJcfwiFSr?=
 =?us-ascii?Q?wlzybU2LGd0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GUtPO9EsxzJEeaNCqouLqlXpVi5Dy7f2zMuNL8HbNKS6Ht39R7doLYjW90Zn?=
 =?us-ascii?Q?jSduDiaN9x1NJcznPJFx5/TiflmudMlgwdoz0UAmNAsopP0lrDEpIbfjrkNo?=
 =?us-ascii?Q?1BZh2OjY4QbwVb1Xwfl+s3eoj5+XVO94URpPPc++gOTQbE/tO3xC1lI811f6?=
 =?us-ascii?Q?B08sN+tO4HAkhuUNaaXbdIshxLOX23geIzjjZZLozXGeq9UQO3og2b0YeSzG?=
 =?us-ascii?Q?PSuiNRRi5v65878OAD2XydbcaCcCGoMQUwraKSclivjC39kmmW9ZQgw3SakP?=
 =?us-ascii?Q?m0uspKsvpj22bCejZj7+UPoa3TKD2BXKlBOgd4Sx9ampUACSuCKLlB2fSdGL?=
 =?us-ascii?Q?MkKarom6UGmWEDJIJbYNpRpVEXLTD9X0bRuCyrNVfxHcpnN6fdU56xH0I1wa?=
 =?us-ascii?Q?v0p20M+Wl/DK3kJcN+TLGt+U5KiDkgR6+wowxH0HyXLVXVR+TB44BWgHQPMf?=
 =?us-ascii?Q?N8N7bEkR6KfpdAllFVRy+5Hkv/OWEXeK6uiDvLVVrq7Ty3bMr8vhOzKqOzM8?=
 =?us-ascii?Q?/Um0gbF+p1xM24Di58qd2TrGgttIU3MWQf8O8IqyOaLiAe5jTwe01oGKHYU7?=
 =?us-ascii?Q?yyhcGh/m1KsX+jkwOfMLFrsQiNritxOhivvYCgOeeIodjiQVaUbpJTp/6C+S?=
 =?us-ascii?Q?EnsW58v7nJ0MhAwoS+U5FVV1ygOfdfcpN0JBOTrQ15FtVegbIFSRXb0AyMwo?=
 =?us-ascii?Q?3JNW381asvoFhpWlFssYFpHAuulBzDPc2m/ad111YSCB0fozifglO3aB//OD?=
 =?us-ascii?Q?laEqSJKiWmx4I98KGpY8yZZpfklwUhDXHV/CSNiSJi8/A/ad4yH9E+VxzcDu?=
 =?us-ascii?Q?ZHsg/2jL2CmRqsmDHd35bvj1qfCH2GpiO6cQ//TmDhivu0qG43+xYe0YXRi3?=
 =?us-ascii?Q?mnZuIHg0+IkvqLsOaVMIzsgaTIs1iAlJbz98LxWX92ZSXSBxqdVQRWOy/Ekx?=
 =?us-ascii?Q?68UOqTyKGG1Dt275A6C8tqEvkp+ZK9KYVo/arwF66vW8hoUNrt9fy3XNIx7P?=
 =?us-ascii?Q?Q4MiPJOwzkFqalpF/aTrBBre8UwXc7YVVuUUcIXJe4qTp39pYy7qZ0sn5QMB?=
 =?us-ascii?Q?+aYJ93N8b0f9BNoyQkXIf4kxgCorwLnUokQimP/lF/UFHOQmarNGZhJL3C4l?=
 =?us-ascii?Q?3BbEH+P7+YD5NmWxFY/TVUaNCUEciMIckyMpPlqPdvDtKrVonizDodf4fRnp?=
 =?us-ascii?Q?EzuD6SkvYg/vsVgVv8/p+7HRr7bDxdapYO50pjQSpDjYXebjaUXuS/7Thw8h?=
 =?us-ascii?Q?lkfHKpHtMAsoeM++r26Y26pXucdpHRBcyLhqxnYTwPiQnjH1ukEffjmtmvmk?=
 =?us-ascii?Q?06wkjRWfKuEVn3Di+Jw238I/W2Xp0CSbGF1tkBCjEtk+V+GPxUnTOWRHi1C6?=
 =?us-ascii?Q?5WDFVyEFZX2Zt2frSNEdC3hTIZpTraAtTGMVOYDjGT1zSzVT1g2YqzA8AQm2?=
 =?us-ascii?Q?QvFNzbc9TiUzbXdO8nfuR3Ni5Tve/LgclDq/X0d7FK+AFfYYIFauxzrUdH2U?=
 =?us-ascii?Q?52hBJLw4zEO0Btu3/5cQYI2+HMCtVHD/b/EOVHdgGR86kFChbbuuR9rINx0Y?=
 =?us-ascii?Q?DS7SI+0YssJ/dMtOJBXJkLlQ194LVSRaOGnFF9iWi/VSrlv8WWQGrgk0w9aj?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9b964b-3890-4f23-2f52-08ddec44679c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:09.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNnTZyTR4jkV3eKe9unP6hpPAc8V6WfKVFWpJ2h8aiwohzI3rFtWkxiVhWrtIkN0MMqzTc5ni9dQ3gV2qoU/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17958

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>

---

Changes in v2:
- Move test cases for local paths into FetcherLocalTest class

 lib/bb/tests/fetch.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d216eac2a..dcbe60783 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -888,6 +888,18 @@ class FetcherLocalTest(FetcherTest):
         alt =3D os.path.join(self.unpackdir, 'git/.git/objects/info/altern=
ates')
         self.assertFalse(os.path.exists(alt))
=20
+    def test_localpaths(self):
+        localpaths =3D {
+            "file://archive.tar.gz":
+                f"{self.localsrcdir}/archive.tar.gz",
+            "https://downloads.yoctoproject.org/releases/bitbake/bitbake-1=
.0.tar.gz":
+                f"{self.dldir}/bitbake-1.0.tar.gz",
+            "git://git.openembedded.org/bitbake;branch=3Dmaster;protocol=
=3Dhttps;rev=3D270a05b0b4ba0959fe0624d2a4885d7b70426da5":
+                f"{self.dldir}/git2/git.openembedded.org.bitbake",
+        }
+        fetcher =3D bb.fetch2.Fetch(localpaths.keys(), self.d)
+        self.assertEqual(fetcher.localpaths(), list(localpaths.values()))
+
 class FetcherNoNetworkTest(FetcherTest):
     def setUp(self):
         super().setUp()
--=20
2.39.5


