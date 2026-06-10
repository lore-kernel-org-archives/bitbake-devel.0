Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D05ACD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 07:40:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14820.1781077226113159762
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 00:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=WpWT6HCL;
 spf=pass (domain: est.tech, ip: 52.101.65.53, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/4xFTn2CQyorFYm9wn3FQ9L5t/zGHSPh3PBOMNtPVxfkbNTmU24EHeRumEZaJqxLIYB2ZpV72Gz0MEj24Q1qiEOEMQweiFc/6E44jU5EAeS8viqr5nlr0WCEbj2q1QMXC577zHxfi25tGKhWKmgt6Lkpl2H/8ej7348hHzAmkQalKf/wDJObfoJZYMR7VwgL8ZWyn0IMkMpHFre1eQjmENM4jV47QiG4OeCUoSNkwpfwADFzZVsbvv/KdisW0WmMMZYYQhXWFaSwswYfRZbGtTOQve8bvt5PDLBOKh/0InEg/T3NWWgQ0duF3cTEnE/wqs6i2HB+VPQGHIoEgeTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqNyziqvUtXtZSMwaM6HKml4gLBKuYqpRUKXqcmLcEw=;
 b=YYANHHT+UNrpG1a5hzBDLc0nBtYMZqPYuCv4T2cblfuVhgrgTD/T0/RsCjb+OJcMct9iK04uJx/Q0h2pMk69n93+rTZkfTBNRWyQRfvJzh4hJ90zBGO8npS7O8jVSmDVWqMIichRd2LjjHa0AZkNm6IEeVWetFJlV3TqjPqLCS8wDbBYB4w1TLR6ewU6fqQoQX0rG2d5ylD7aYiCuylWI921vsGj7x4UlP6piStB5wEyPCUIC78t5e6P0NWAcrI6cjjaOoyCiDpI972fh/5/MLg29oMpO6271TBx2xMRZFefNdgIGPiewE3kU0skw9eptBZafOWOPG/q4/JqB9KMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqNyziqvUtXtZSMwaM6HKml4gLBKuYqpRUKXqcmLcEw=;
 b=WpWT6HCLa3U5qlXFHlGCHBw+0fbU/+Gb4MAmjPmCK76Vef8yqKwuyDbOJQrKtM50bGVXdvVdHYY3rshJbnU3LyZTfYdBPseaw1jFH7wwHyAmY4OAVU83XwSvYZSxdlVJPE+iy5UGJH+KuqMCArKJQEzZnMkVgyAP8CbqHJbkT5sOkvJ44sfzbi9i4VRA2nZGwdwh8YMAMKwWRN3a9VU5STQf26cdHpKPbapz+LsKyzYR1L8ELrNY25wNr78AIRZtbBLgDjI1X3J+SS07KRkGva/Q3FXSRZ68V29Lw8Mm9kCbURK9GhPg+KiAcPtXh2rso7uFIOvVm9ctukQp/oMhFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 DBBP189MB1290.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Wed, 10 Jun 2026 07:40:23 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:40:23 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 2/2] tests/fetch: cover checkstatus redirect auth handling
Date: Wed, 10 Jun 2026 09:40:13 +0200
Message-ID: <20260610074013.558709-3-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610074013.558709-1-anders.heimer@est.tech>
References: <20260610074013.558709-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0275.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::6) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|DBBP189MB1290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3bd7ed-b555-4fe0-1f13-08dec6c387b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	MhNmKxqp/xfn5op4qp9kukg1TyK6aFqvi85+wYAxkgwJ42MEAGbNT8uI2GmslW+LRsuol0OT+C2t1y1qrDr81GbgehkHjvesTW5EGj/ATpWST2N1/iHkn16frjswz+61nNJWZrL1Xo1Fzc6+MAMqLxX8YmAfMsJVDMWDXtH2SSxIUnkp5QjbSht6kUb85ncYCr3mjNrQ24xNRf4FiTeZNoq0vnBiDaSZES4An0U3D+oyH2zTlMMzgDULn4vsWsE2Q9MMv7/pwfNvwHcO2BmnyI6oQmUZ5AfsXwlpOkUn1dB5dJznaW47FLAtVX1Yowl+kVcwkMunAFSBDQ/3EFPAJdvG5KV9Yb73TLnvTFMfdVUP5B3O82kZMJjv9c3F9G49Uvanl+a4sYpsbiFJoQH2CrodLg7V8bL+Uy0XTLkX8NK89vzY0Lh3vWBLEqybyrHb+5QdoT4G5tx3d+I/4WxnlIdGZdMbRuvurfJ/MhINOYUJOBdOlQyTXWQo7PmWKLfb+DOwvwFa3Hjz+L+de0WeQzjI48u/3JWNMynuZ9xBjI61DlMHpZL3wP3B92aj0K59OrRHHud8LRWpT2HrFHmA6HX/tUJP62dHPcUAGflB/VECoMPcdVvfSYAhUQGzBiBNbd9QYY50t1aCZ8Ckiy/bhg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xxcu14Vb9OwUx8I6AbKtY4dI3uRA3wn6MN0qsZVde4DyeAlOTrv5ibPZxHPv?=
 =?us-ascii?Q?7Nq7PIlGiC8+6sD0Tx+fCqGeOLIVWaPdefTQL2PT2/WluQUQ1jtz7oqZxYDP?=
 =?us-ascii?Q?qMvyoYoevzs1XF4z1/j2091aAus179vEvzyR0eNp/192yhYo88GfhZ7p6VUi?=
 =?us-ascii?Q?VGT5DK2IcTPhpfcTROuWMsDsoEMF4gs4LvkVB0eD8N+tggYpKDZAhHTYrSD6?=
 =?us-ascii?Q?YieN7fepTF7C8PHBAy+jSYNrNgOVj/YoITcqvw5bT6PzQInz1KwQ4s2/Dd5P?=
 =?us-ascii?Q?CFPaFlUN9w+cvC9LQ+KxKi73OKBY01JOg044rBmXmSDlS5//hHhuagXU/UgJ?=
 =?us-ascii?Q?ptM9mY8CdgNYdwqk2LBXKQiYCgZeWXji8OcReI043ztl9vIZUjkZIprLqQBv?=
 =?us-ascii?Q?pQabvTeHNcgOMZIfuGFYoC1liRPn8NCLYFEqa8PyXaATRgaViiH8u/h6hasY?=
 =?us-ascii?Q?oI1YdyJ/OynrT0Um5fF89I+kfBwZm+u/PD9dknn+GsijbnEQPAKAIhHMnbbk?=
 =?us-ascii?Q?9G9Ye5d3P1DTdNQUYqf3ky7bHCc9Y5kGc+kfWotN13FilaEDkkG2KGBSFFPg?=
 =?us-ascii?Q?XsWss+RQd6QRg4Zp8zic+loqnYtU3gmNq/Q5JFUb34FcoYs+Pza01K+t6o3Y?=
 =?us-ascii?Q?zmWE4h8FWjln8vkTEeV+nVxwYWGu7tfNTcAjcp/N84lNJHRjb84p6aHSa0MK?=
 =?us-ascii?Q?fLTMTkX2DPQeK1huke4x8V7Jzeme45yJLS71+KU0nzDNkF/ywm902Y+GtnuL?=
 =?us-ascii?Q?A4MY5dhVAuhXxX/LNRdIpFSue8nw3moRgUeqqmK6NJla92S5iTR0d9EurSGs?=
 =?us-ascii?Q?QjIcQNehatc0xkiqTStAL0PFRGz8ws68NPF7jg/6/1V2YKZmZdgOl2pxyo+J?=
 =?us-ascii?Q?X5njOxSp6lVE+WVVyR0SeEKnhA/jyT7x2C3K5emRXNHllL2yAu/PZ+MAuzfP?=
 =?us-ascii?Q?4zlOFjQcWOjOV020gk9Z9bLjQHcmLEFlQJeGZ6eHpyCu5d0desAJqE0MKwMb?=
 =?us-ascii?Q?mddSpeJanT2XXJujJ2NnMmuzo0p24XLGFR+tSbIHNaFQOWyvcNdYQf+PZUzM?=
 =?us-ascii?Q?uhPJ0OFecxMNp9a6Ieg9v6d48LzQ3+UPQOP+YKLjTgccsDWvwHEYAOn5ScWu?=
 =?us-ascii?Q?gA/pg9LKVq/WOPOzl6p/a3GTRa9TOIwjWMqWLhYg1raKO+Eh8WjWQEmClfDV?=
 =?us-ascii?Q?/aohsfrbsVPgLnBxgtR88LvaibI1Nf/vKeFa8INCyzNj3Wwg1ZxE9OJJJtB5?=
 =?us-ascii?Q?qVXP+zcesuSROODgxAGe4x/VBNCG4yPbmSVPtDhC5ba8ZDSzLQScnWVuq6Lg?=
 =?us-ascii?Q?2YGGEPem8OVje9gCDzOo7BBrHsB7M8q45O1Je6AW2wz5Xc602IqQoct8+DKi?=
 =?us-ascii?Q?nhNwaE6Fxo/2bHA4KJR6IN/JhY8tbGDL/LRag8E5d+8zKy3bp9JXpVTgVIjn?=
 =?us-ascii?Q?r0Us5MCA5GV8q6jnK9y7lASlNQdXCzV/itBSKf/gpwps+6uQL7vElLNjh3Kq?=
 =?us-ascii?Q?m7LNDKwJ30Du/K+I7vvlQ7KZ7zK/AH2oM/pjamodCYojFq0hixbopHf4j493?=
 =?us-ascii?Q?NYnIdhZxT70u8UH+qq6PPA1Ul2bFwleznmCM6bekkp67qpBVXBeBkiMjpxAJ?=
 =?us-ascii?Q?hD9uhtyDmpb68jFHO3R+m5gi9Y2ys7w2RtzyrCw2GzxpzB8457e44sjhaSRX?=
 =?us-ascii?Q?z0ofPfAUBTlxUlMIK4DvCWF/4UbI9w6MsAmQGc8v3Q8sJOzbkENgT8Bc33nl?=
 =?us-ascii?Q?VyhaYZxngw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3bd7ed-b555-4fe0-1f13-08dec6c387b0
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:40:23.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnterXCGdQcYt+yFAoTO+naziDBgi982wZgBnLoGmynnNiAcCwc57U0BK7kqJYJBXMmH1+f6pjvZmH+DEh5bsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1290
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 07:40:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19638

Add local HTTP server tests for Wget.checkstatus() redirects. They check
that Authorization is kept for same-origin redirects and dropped when the
target has a different origin.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/tests/fetch.py | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 95cf6c414..d021ad786 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -7,6 +7,7 @@
 #
=20
 import contextlib
+import http.server
 import shutil
 import unittest
 import unittest.mock
@@ -18,6 +19,7 @@ import os
 import signal
 import subprocess
 import tarfile
+import threading
 from bb.fetch2 import URI
 import bb
 import bb.utils
@@ -1716,6 +1718,41 @@ class FetchCheckStatusTest(FetcherTest):
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz"=
,
                       ]
=20
+    def _start_checkstatus_server(self):
+        class CheckStatusHTTPRequestHandler(http.server.BaseHTTPRequestHan=
dler):
+            def do_HEAD(self):
+                self.server.requests.append((self.path, dict(self.headers)=
))
+                if self.path =3D=3D "/a" and self.server.redirect_url:
+                    self.send_response(302)
+                    self.send_header("Location", self.server.redirect_url)
+                    self.end_headers()
+                    return
+                self.send_response(200)
+                self.end_headers()
+
+            def log_message(self, format_str, *args):
+                pass
+
+        server =3D http.server.HTTPServer(("127.0.0.1", 0), CheckStatusHTT=
PRequestHandler)
+        server.redirect_url =3D None
+        server.requests =3D []
+        thread =3D threading.Thread(target=3Dserver.serve_forever, kwargs=
=3D{"poll_interval": 0.05})
+        thread.daemon =3D True
+        thread.start()
+
+        def stop_server():
+            server.shutdown()
+            thread.join()
+            server.server_close()
+
+        self.addCleanup(stop_server)
+        return server
+
+    def _checkstatus(self, url):
+        fetch =3D bb.fetch2.Fetch([url], self.d)
+        ud =3D fetch.ud[url]
+        return ud.method.checkstatus(fetch, ud, self.d)
+
     @skipIfNoNetwork()
     def test_wget_checkstatus(self):
         fetch =3D bb.fetch2.Fetch(self.test_wget_uris, self.d)
@@ -1743,6 +1780,31 @@ class FetchCheckStatusTest(FetcherTest):
=20
         connection_cache.close_connections()
=20
+    def test_wget_checkstatus_same_origin_redirect_keeps_auth(self):
+        server =3D self._start_checkstatus_server()
+        server.redirect_url =3D "http://127.0.0.1:%s/b" % server.server_po=
rt
+
+        url =3D "http://127.0.0.1:%s/a;user=3Duser;pswd=3Dpass" % server.s=
erver_port
+        self.assertTrue(self._checkstatus(url))
+
+        self.assertEqual(len(server.requests), 2)
+        redirected_headers =3D {k.lower(): v for k, v in server.requests[1=
][1].items()}
+        self.assertIn("authorization", redirected_headers)
+
+    def test_wget_checkstatus_different_origin_redirect_drops_auth(self):
+        origin =3D self._start_checkstatus_server()
+        target =3D self._start_checkstatus_server()
+        # Same host but different port is a different origin.
+        origin.redirect_url =3D "http://127.0.0.1:%s/b" % target.server_po=
rt
+
+        url =3D "http://127.0.0.1:%s/a;user=3Duser;pswd=3Dpass" % origin.s=
erver_port
+        self.assertTrue(self._checkstatus(url))
+
+        self.assertEqual(len(origin.requests), 1)
+        self.assertEqual(len(target.requests), 1)
+        redirected_headers =3D {k.lower(): v for k, v in target.requests[0=
][1].items()}
+        self.assertNotIn("authorization", redirected_headers)
+
=20
 class GitMakeShallowTest(FetcherTest):
     def setUp(self):

