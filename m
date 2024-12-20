Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A386E77195
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.106])
 by mx.groups.io with SMTP id smtpd.web11.149743.1734693991344736713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=Q1oM/ffD;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.106, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWX7NH2S3CURC3kerqcvDMFTL0HfmVIueamOVAh5o0t+TBT/uxcxWOYBVlfNrT6b5t8hmiSIRP023FthVViOLud7qMIR8D+GwfRvNEnIBOrM5RsyFJ1qLY6i4tI2PENqj3aaSNmhMKHIKjrfABMf3yd7/aWKxevrlbiOn+30zAnVvje4kANGWe/U4BsRZRVwpEzYcxCl4vUVU0bTN91eZGYruzj7JYOCQW8LNGyzfEySjuMZtLXOF2EwD7ySWq9YJq/YTrVP/Uw0zkao9Ec01/y+luYDdRMxtFrVsk57Y+Y9dwyeRjzND/MRM60FRYmyCYI+i/BuJKtSO99769Cxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XJfSBCTU3pIgNwk3SGlO6vmqo0NIaZAi32yAPJjF4Y=;
 b=HQ9ABuNjRMPJ4wBTU74UBbUKsNl3/2/HPZ1/59EdGMlCLOUZ2OPaOdQH8yEN8BwPhI5VgZJaJkplJkTFY1sRKJYKqlajaaD7xC1byZW154OtyvaBiRMXrzyg9EaFt6GKIPIJaYlwvY9CYaIsRYrltrsPRVniiu5fsvhN1XruKQfCE+5X5+7lECl+FXwwaeIfBOzo4wXrn06/JEZNt/bshSeIRzk9oJ9hsGCsH9jPL5hhyh8DWTjouaAx35za0z1R22//4JGkOj2s+82vZrahndamC+iOpCeCLNFejIHaj06uCThq1rGlfjs0lGC3kAZXKnwJRHrmYa/j3GaJLveaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XJfSBCTU3pIgNwk3SGlO6vmqo0NIaZAi32yAPJjF4Y=;
 b=Q1oM/ffDTghqYq+3XCDR8O5WviN+lB4g0thClIviOwFzSyJwJXbevGcpP3INA7VDm7DvBq5ZaXLaBP6j8dm42GcqIE/kJMAQIJqISDBu56Y9hEwqyji64vBAxem2737p7ZnprScwjK5RGbWilkhNdrKQcm305RccAzjMbr3W6SCfuX2hVP+fmlv33hz/L5NXwdzOkUWOIy+tiNmgnbe5OLYGmYeiLYlfC4DB0J8nJrK5NswW1L9XrbItdlvR7uh3xGI0aWSUcOcu9LEXQ/INVcnCMImixIy7OG1BQ8Z/qoHtqpuF3oisRadhC3YAUwQ20hnJlHFOtDn+0XnMSTaCQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:30 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:30 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 14/21] fetch: add dependency mixin
Date: Fri, 20 Dec 2024 12:26:05 +0100
Message-ID: <20241220112613.22647-15-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6980f98e-ef14-4bda-7353-08dd20e92590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZSon4kxYYTYkzpVlQSaOZjfGBZe+BfnXpxVVYdxsQIhfc6hPT8NCRny1h6iI?=
 =?us-ascii?Q?qca3fwCPfjru7Ps5hNsw94hC9qIed241kD4J657A1MFD3QkiDKAzGTtGGP0j?=
 =?us-ascii?Q?saAuru3eBuxVu/z+FXKZzdc8ov96BNkCzQd8DATDd/v0Z8lyTFCVVB9xAlNN?=
 =?us-ascii?Q?QbdrIBE9wL6EOA+EXVFLKSatH97QuA9lAKglXaklloSxuN3+IE7JCFGTYKVR?=
 =?us-ascii?Q?YWMyOSZh+zP6DQ8kW1syFScwm1CppCK/naO/aB7NhArh5O8hWLVwDSJAoZ5P?=
 =?us-ascii?Q?b580edqWudFCyrvMUovwOh78+b64waDpWEKf7hTKo8cLUjRiKpUAmLQzrUGl?=
 =?us-ascii?Q?HCV8V15lTgAdUD8XdPKxwO4G43+D4IGiH4nTJePnMKz5dLgxwpv7KtoN7/WG?=
 =?us-ascii?Q?iI66L4GjeqGh8My9ietX4q6xejb44ndlppaB1V4BlLabpyJo/+o1JVqa2/74?=
 =?us-ascii?Q?RNseuieaD6zFufPQq971h/tcKhN5/ILOQlNWH33VC4qPMGDhYkT+Kq4xloWZ?=
 =?us-ascii?Q?DN5GTOpor5JyTxCrwBK45v+bEroe6Y5iell3fXfYQyIP2U7ODhj+gaHdTWCi?=
 =?us-ascii?Q?YVOGzipSv5BTBlrUwK5shCbxFjJYVUK2jGZQd26GcRkD67WbuBMy0J+aBtqb?=
 =?us-ascii?Q?D3XkWCvImjJOXtRGlln0/XuFOy/CJMIAwMILHGKcSMmXbeiSp9iQ3apxkrFo?=
 =?us-ascii?Q?WS+j0Qp7ctCtvxxYl++4BhuJ3nUBF1Kfm5jGQwI/599I5oemffDcM9dAVgYY?=
 =?us-ascii?Q?NpACIYvvK/+tQiWtK/o11xG4mgJB1oLA+N1JgY3ls+5cSbZrcagYaTpaA2PX?=
 =?us-ascii?Q?MNJgwk/lNHJZAzXNWJ96J8lqwUuLcKL6eOrLsPNO6isF3qyVmcqD4kw9vikY?=
 =?us-ascii?Q?jUMFqMB9sgy0FKayNuCSRst/C6ERdDZg/h/b/xd83n8XY3wagUXTMLQBkPtj?=
 =?us-ascii?Q?k9iCS20Q2b3kerXsDn1VZHVQdweJPG+h/8+pwk3YhpngoeG216pyQVcYQXVP?=
 =?us-ascii?Q?z0yK+Bweoot5y7vxC54h3ES8zhKIOlAPRiJ74d48Y0x+zsH5wbS1c1fg0YKN?=
 =?us-ascii?Q?lfRrP4XjXcxyyGVY9IQuZEAlhEDNAbs+1s2Rcl3zgDm0o0cCSYSP+6GB4YK9?=
 =?us-ascii?Q?70es3oG028sUmkg9q/715RFhW0TovD2fe7OjwVJbDdoWCCf6aXYf1A2Rwd+O?=
 =?us-ascii?Q?fNS75SkqVieYFaVxB2v9uRdmWhw8kUbWDn/VPzwAZj/iRQhJPcrgVz0cBhlH?=
 =?us-ascii?Q?WRBFYUW3z5fXemTfLbgZWsXxotAs5RK5+vVcmizcgED6HQBfXxAKsPDeeiCE?=
 =?us-ascii?Q?Lu4Eb2RkOmkxij2M8fOp0gyTlLt7pp40aE2zDVIu9dRApVFB/DQ842+xfO/s?=
 =?us-ascii?Q?tdE6pvue8XSDSJe9j5t9JMDn+btl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?c43t+4Dyc8R6Psw4EC3xjnXpdK+2QaY6kmw3vEmnldeOv0dtbtfxx907ZTOG?=
 =?us-ascii?Q?ParllZh5FryCgrTTs7lxM2GdQrqBkcyY49OBgIuCOdAEWUhN9WymUZ0V7TJo?=
 =?us-ascii?Q?5ta16+tZhqsVTPMKaysOJUtkigA9WqcH3uXslXipSPfJvLYxL8B1a4HWmEUj?=
 =?us-ascii?Q?je6vqk4ckXuSJdh0l+sTqtGyYuUfNKx4OKSEUo65/+clMSW7rOPL8+LzGW84?=
 =?us-ascii?Q?dP5ivV/TcjQO7DmbcOIzOPhgf+t3DdX5NmDSg8oUqcyks82R2y1fZb0lFYKY?=
 =?us-ascii?Q?B92GpfYt5pYx6WJsoos/u0pDOYQqtHUXrZDc7ZtDXEeotlNWZVHq2RowmKul?=
 =?us-ascii?Q?ldF40WGWvj+aWb3PZZQh8lChoJA+eh19QZMTCMQKBq9ng+zA0gcP39ZXr8CL?=
 =?us-ascii?Q?sFYciyOcNNWtd9CUd+bdE3foPg+b0f9wsUt9M16M2Lh2uJTldkIS6XnKzJO7?=
 =?us-ascii?Q?AI1MyJuYH+Vgi7srm9hWKJSY9KEaABoD2IKy22/HIizuCfw6jV90EKCbgpOz?=
 =?us-ascii?Q?jwNSd9n7I4+ckgQcw9nOoUZ/taVDTbQZFCJjn6vFN+4zDpbHgU4GF98XRDBK?=
 =?us-ascii?Q?zNjbRcO2YV1rNSf0bFNSK7JPimpTh/L7i7MSwhmhDhMvEkTNJwesbD3BIKnz?=
 =?us-ascii?Q?apsA5HyuwdzkOo8ntpixI8GNQ0zlS2x+hTanWplFsy0POUXrCDKPpu32lmZC?=
 =?us-ascii?Q?NXqBSBbXJjhRbjl3k2Asa+fmxvCapeNy5wb5hadM6zg4T+e+UB4FLXDZnnmX?=
 =?us-ascii?Q?b3hbDCXPieZ/pFVQvzfE73+itj2At98tI1LR/YirXMtyKDnQPSHRAipoANS0?=
 =?us-ascii?Q?abMrrRKW9+bMfHllqwzrH1/dQ01f9zd7sbljPAzv40KOhzXLjSfaZ/V/WZAQ?=
 =?us-ascii?Q?4v3kfUG2Es2S9Mj7vD2lLyMrJ/s/4seRd2zMQ8pRY6mVL/vhUbYvsl4IH8p7?=
 =?us-ascii?Q?OSQrl52m3VegJyUwAx7ulY8BomdfduMQPiZ3/pfqjXpNhU7D7NeqGFX1dmEJ?=
 =?us-ascii?Q?O7Dg/GYBjenNBngB8oXMPeb1JoiYKwvHRr5oS+d/mSHbe4JVVCfEXxx728yN?=
 =?us-ascii?Q?Iast3NXySgv5lUO4BSZLBtCevbE0ZYxkfhRvfv7fHXfhZqCDdRkDKOEsOGTV?=
 =?us-ascii?Q?LjqGLPfAAJWAkw5JC/2CIuzOiyCnLUl/S1aH+Y7Db9vZXxmBKtZ8iGBswsqL?=
 =?us-ascii?Q?2JjWPmXKTnkTuHFUx3SYXNA5Gyhh6rzjbigRc7YPExkA6A4Ct6bu7OveT9C1?=
 =?us-ascii?Q?J28I9Bdsm0lSaRiPS4nfXrhD/O7lcq7ejRmbdqRw6tpv+S1hDZA/hEkhczTW?=
 =?us-ascii?Q?FkUQKLQPYXkpOdMKbSqFFcDj0zjBiYv10u8zbSMQcC+dF96i/2T/IE+5n6rx?=
 =?us-ascii?Q?qiArHXO1kveYnoJP4k9xOrOTBitoty/dTnsE4zotKjNELneSPe/yWW5VpmrY?=
 =?us-ascii?Q?dPqJfcDHKSoMiLlFRyVcmwKmAYrrF9hiKbmoMqVMvzPtnu0CaKmn8EOcnaOB?=
 =?us-ascii?Q?AOhxHGXjnnwtmQ9HODsBjnm+I0emgcCcNVzilB2LFtkphtrQT3y2Q5EfWyLp?=
 =?us-ascii?Q?0ncGpOyt1E+8LGH5ynUBEaj6CjlCHMkSNqQIEA3bNIjm8W2XlnhVGMjhzPzv?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6980f98e-ef14-4bda-7353-08dd20e92590
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:28.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3sX4qq4q/+8u3BKT3+9HOZ1CoZYixplfqadoJnQ0/Jme4ONuxPnjrGJt815FLcbP8IU2ZAVeNj9ckqgjmatKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16938

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add a dependency mixin classes and module. The mixin implements generic
methods to fetch dependencies via a dependency specification file. The
subclass must implement a resolve dependencies method. The method
resolves the dependencies from a specification file into fetcher URLs.
The module provides different fetcher subtypes:

<type> (Local)
    The fetcher uses a local specification file to fetch dependencies.

    SRC_URI =3D "<type>://specification.txt"

<type>+https (Wget)
    The fetcher downloads a specification file or archive with a
    specification file in the root folder and uses the specification
    file to fetch dependencies.

    SRC_URI =3D "<type>+http://example.com/specification.txt "
    SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;subd=
ir=3D${BP}"

<type>+git (Git)
    The fetcher checkouts a git repository with a specification file to
    fetch dependencies.

    SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/dependency.py | 175 ++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 lib/bb/fetch2/dependency.py

diff --git a/lib/bb/fetch2/dependency.py b/lib/bb/fetch2/dependency.py
new file mode 100644
index 000000000..4acad8779
--- /dev/null
+++ b/lib/bb/fetch2/dependency.py
@@ -0,0 +1,175 @@
+# Copyright (C) 2024-2025 Weidmueller Interface GmbH & Co. KG
+# Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
+#
+# SPDX-License-Identifier: MIT
+#
+"""
+BitBake 'Fetch' mixin implementation for dependency specification files
+"""
+
+import tempfile
+import bb
+from bb.fetch2 import Fetch
+from bb.fetch2.git import Git
+from bb.fetch2.local import Local
+from bb.fetch2.wget import Wget
+from bb.utils import lockfile, unlockfile
+
+class DependencyMixin:
+    """Class to fetch all dependencies resolved via foreign function"""
+
+    def urldata_init(self, ud, d):
+        ud.type =3D ud.type.split("+")[-1] if "+" in ud.type else "file"
+        ud.url =3D ":".join((ud.type, ud.url.split(":", 1)[-1]))
+        super().urldata_init(ud, d)
+        ud.proxy =3D None
+
+    def _init_proxy(self, ud, d):
+        if ud.proxy:
+            return
+
+        urls =3D self.process_source(ud, d)
+        if urls:
+            ud.proxy =3D Fetch(urls, d)
+
+    @staticmethod
+    def _foreach_proxy_method(ud, handle, d):
+        """Call method for each dependency"""
+        returns =3D []
+        for proxy_url in ud.proxy.urls:
+            proxy_ud =3D ud.proxy.ud[proxy_url]
+            proxy_d =3D ud.proxy.d
+            proxy_ud.setup_localpath(proxy_d)
+            lf =3D lockfile(proxy_ud.lockfile)
+            returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+            unlockfile(lf)
+        return returns
+
+    def verify_donestamp(self, ud, d):
+        """Verify the donestamp file"""
+        if not super().verify_donestamp(ud, d):
+            return False
+
+        self._init_proxy(ud, d)
+        def handle(m, ud, d):
+            return m.verify_donestamp(ud, d)
+        return all(self._foreach_proxy_method(ud, handle, d))
+
+    def update_donestamp(self, ud, d):
+        """Update the donestamp file"""
+        super().update_donestamp(ud, d)
+
+        self._init_proxy(ud, d)
+        def handle(m, ud, d):
+            m.update_donestamp(ud, d)
+        self._foreach_proxy_method(ud, handle, d)
+
+    def need_update(self, ud, d):
+        """Force a fetch, even if localpath exists ?"""
+        if super().need_update(ud, d):
+            return True
+
+        self._init_proxy(ud, d)
+        def handle(m, ud, d):
+            return m.need_update(ud, d)
+        return any(self._foreach_proxy_method(ud, handle, d))
+
+    def try_mirrors(self, fetch, ud, d, mirrors):
+        """Try to use a mirror"""
+        if not super().try_mirrors(fetch, ud, d, mirrors):
+            return False
+
+        self._init_proxy(ud, d)
+        def handle(m, ud, d):
+            return m.try_mirrors(fetch, ud, d, mirrors)
+        return all(self._foreach_proxy_method(ud, handle, d))
+
+    def download(self, ud, d):
+        """Fetch url"""
+        super().download(ud, d)
+        self._init_proxy(ud, d)
+        ud.proxy.download()
+
+    def unpack(self, ud, rootdir, d):
+        """Unpack the downloaded dependencies"""
+        super().unpack(ud, rootdir, d)
+        self._init_proxy(ud, d)
+        ud.proxy.unpack(ud.destdir)
+
+    def clean(self, ud, d):
+        """Clean any existing full or partial download"""
+        self._init_proxy(ud, d)
+        ud.proxy.clean()
+        super().clean(ud, d)
+
+    def done(self, ud, d):
+        """Is the download done ?"""
+        if not super().done(ud, d):
+            return False
+
+        self._init_proxy(ud, d)
+        def _handle(m, ud, d):
+            return m.done(ud, d)
+        return all(self._foreach_proxy_method(ud, _handle, d))
+
+class LocalDependency(DependencyMixin, Local):
+    """
+    Abstract class to fetch all dependencies from a local specification fi=
le
+    """
+
+    def process_source(self, ud, d):
+        return self.resolve_dependencies(ud, ud.localpath, d)
+
+class WgetDependency(DependencyMixin, Wget):
+    """
+    Abstract class to fetch all dependencies from a specification file ins=
ide an
+    archive
+    """
+
+    def process_source(self, ud, d):
+        with tempfile.TemporaryDirectory(dir=3Dd.getVar('DL_DIR')) as tmpd=
ir:
+            Wget.unpack(self, ud, tmpdir, d)
+            return self.resolve_dependencies(ud, ud.destdir, d)
+
+class GitDependency(DependencyMixin, Git):
+    """
+    Abstract class to fetch all dependencies from a specification file ins=
ide a
+    git repository
+    """
+
+    def process_source(self, ud, d):
+        with tempfile.TemporaryDirectory(dir=3Dd.getVar('DL_DIR')) as tmpd=
ir:
+            Git.unpack(self, ud, tmpdir, d)
+            return self.resolve_dependencies(ud, ud.destdir, d)
+
+def create_methods(type, mixin):
+    class SpecificLocalDependency(mixin, LocalDependency):
+        """
+        Specific class to fetch all dependencies from a local specificatio=
n file
+        """
+
+        def supports(self, ud, d):
+            return ud.type =3D=3D type
+
+    class SpecificWgetDependency(mixin, WgetDependency):
+        """
+        Specific class to fetch all dependencies from a specification file
+        inside an archive
+        """
+
+        def supports(self, ud, d):
+            return ud.type in [f"{type}+http", f"{type}+https"]
+
+    class SpecificGitDependency(mixin, GitDependency):
+        """
+        Specific class to fetch all dependencies from a specification file
+        inside a git repository
+        """
+
+        def supports(self, ud, d):
+            return ud.type =3D=3D f"{type}+git"
+
+    return [
+        SpecificLocalDependency(),
+        SpecificWgetDependency(),
+        SpecificGitDependency()]
--=20
2.39.5


