Return-Path: <tengf@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D00C43458
	for <webhook@archiver.kernel.org>; Fri, 10 Jul 2026 09:41:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9138.1783676461643417269
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jul 2026 02:41:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=IA7qLEYR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: tengf@qti.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A9Tbuk391255
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jul 2026 09:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=llye4RyV+I+pIQByfa8xpE
	WWv2KoMjnBrQQzp+j9rYY=; b=IA7qLEYRnSBrDc1GyQWbAnHUTAx9qwAzPCZyS5
	uvMz7efI/tOeDNWmzFzHInbg6gA2+xaIzrMsW4EBai0v0tCn6etzVBFrTvgE71fo
	iM2t7PiVvvpO4UJAk0w55JlIPdKyGOZq7FPyzt+WYYXG42gML2G1dggUUqfAqtlO
	OE6TuWJv36P06K1iiT+cL9Z0QP9p9HV7LflSyYdbkqn132uTokeeaJIV9uTddiIu
	B+RrTXRdkcTblWEmLuwY9zFLaGMibwL55MWMdWQHRuweHpJicuk6tIOWGoj5BXhU
	WjpVdUp8KQUeOzwsh8Ywj39naGFXi4NsqWiLz/de6MQ57Y2Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f81n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jul 2026 09:41:00 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A9es3w027278;
	Fri, 10 Jul 2026 09:40:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 4f6u8jyr4b-1
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jul 2026 09:40:54 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66A9esm6027272
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jul 2026 09:40:54 GMT
Received: from szebldarm02.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 66A9erJU027270;
	Fri, 10 Jul 2026 09:40:54 +0000 (GMT)
From: tengf <tengf@qti.qualcomm.com>
To: bitbake-devel@lists.openembedded.org
Cc: tengf@qti.qualcomm.com
Subject: [PATCH] fetch2/gomod: support pipe-separated proxy list in GO_MOD_PROXY
Date: Fri, 10 Jul 2026 17:40:53 +0800
Message-Id: <178367645337.2070338.3995116335029500655@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.34.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a50be2c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pM9yUfARAAAA:8 a=yqL39e-WNB6DZH68Ct8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=YH-7kEGJnRg4CV3apUU-:22
X-Proofpoint-ORIG-GUID: r5LjMy_-ISwDbYsqrlZ0v52HjcuLb2Nj
X-Proofpoint-GUID: r5LjMy_-ISwDbYsqrlZ0v52HjcuLb2Nj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NCBTYWx0ZWRfX8hdI6H9euq9w
 iqWhnjfQjGVszzCE03Sh2x0+naQcGAPU2oXsBBhktvm9UDggjESsZchNSU2QlCkZM9gseg/tto/
 38pHDbQ7EK2C9adfhSymTX7SMIJI/8Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NCBTYWx0ZWRfX6/m4ljCQhA5V
 TiHJWYJHmlEGN9GQuEuDmJPkomK6n2I0FIpwkkrjT2Gy/7f2BRcgEwc0d1gbfOh7CXwqvZk/8t0
 5mmQPe72ZSrmn/PV/mM76itzVAumW7Vr3qKB/AEwYpcl8hQbl80nGhY3TlwZgTPldxJv7MxbMnp
 /TpfxkUkEzz4TH8ofvTA0bGEdO/15LzmhNtEnfnkvOUYIfmEMgYVmsM4MOwUJDqpm9YYRaXwz0V
 j7vIrBq2hsnAgPI08gfOWDNn9NTGye/IesRfmlfKKch+QP/AJ+Tqzr4LZxg16QcA6BFhRlhaHm9
 Y/czvvGSeJl/Vv21x4BTepriomWu05vXVhBTC44YtP24H0ZTviaq9H6dtMaH/gkc2b/5JK5J08i
 kYkF3/OSUB5C3o93NuWLfcEdwFzwVl+6kjCi1wN7qHrZ1TMKFTPNI+JK4zbflHlUIGkKWLEBGXR
 cFsUkJ8mfAq3J+ziZjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100094
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 66A9Tbuk391255
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jul 2026 09:41:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19835

From cb7d8f5176781eb441ec83241f05ab272d4611c6 Mon Sep 17 00:00:00 2001
From: tengf <tengf@qti.qualcomm.com>
Date: Fri, 10 Jul 2026 16:54:20 +0800
Subject: [PATCH] fetch2/gomod: support pipe-separated proxy list in
 GO_MOD_PROXY
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The Go toolchain supports GOPROXY as a pipe-separated list of proxies
tried in order (e.g. "goproxy.cn|proxy.golang.org|direct"). The BitBake
gomod fetcher previously passed the entire string verbatim as an HTTP
hostname, causing fetch failures in environments where proxy.golang.org
is unreachable and a mirror such as goproxy.cn is required.

Parse GO_MOD_PROXY as a '|'-separated list and try each proxy in order
in a new download() override on the GoMod class. The special token
"direct" is silently skipped =E2=80=94 direct VCS fetching is handled by =
the
gomodgit fetcher. If every proxy fails, a FetchError is raised listing
the module and version. A single proxy value (the existing usage) is
fully backward compatible.

Add two unit tests that exercise proxy-list parsing without requiring
network access:
- test_gomod_multi_proxy_uses_first_proxy: verifies the first non-direct
  proxy is selected for ud.url and that the full proxy list is stored.
- test_gomod_direct_only_falls_back_to_default: verifies that a
  "direct"-only value falls back to proxy.golang.org.

Signed-off-by: tengf <tengf@qti.qualcomm.com>
---
 lib/bb/fetch2/gomod.py | 39 +++++++++++++++++++++++++++++++++++----
 lib/bb/tests/fetch.py  | 22 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gomod.py b/lib/bb/fetch2/gomod.py
index 5cdf8f998..7bb91e2a0 100644
--- a/lib/bb/fetch2/gomod.py
+++ b/lib/bb/fetch2/gomod.py
@@ -48,7 +48,10 @@ Optional SRC_URI parameters:
 Related variables:
=20
 - GO_MOD_PROXY
-    The module proxy used by the fetcher.
+    The module proxy used by the fetcher. Supports a pipe-separated list=
 of
+    proxies tried in order, matching Go's GOPROXY syntax (e.g.
+    "goproxy.cn|proxy.golang.org|direct"). The special value "direct" is
+    skipped (direct VCS fetching is handled by the gomodgit fetcher).
=20
 - GO_MOD_CACHE_DIR
     The directory where the module cache is located.
@@ -97,7 +100,7 @@ class GoMod(Wget):
         cache/download/<module>/@v/<version>.mod: The go.mod file.
         """
=20
-        proxy =3D d.getVar('GO_MOD_PROXY') or 'proxy.golang.org'
+        proxy_setting =3D d.getVar('GO_MOD_PROXY') or 'proxy.golang.org'
         moddir =3D d.getVar('GO_MOD_CACHE_DIR') or 'pkg/mod'
=20
         if 'version' not in ud.parm:
@@ -109,14 +112,24 @@ class GoMod(Wget):
         ud.parm['module'] =3D module
         version =3D ud.parm['version']
=20
-        # Set URL and filename for wget download
+        # Parse pipe-separated proxy list (Go GOPROXY syntax); drop "dir=
ect"
+        # entries since direct VCS fetching is the job of the gomodgit f=
etcher.
+        proxies =3D [p for p in proxy_setting.split('|') if p.strip() an=
d p.strip() !=3D 'direct']
+        if not proxies:
+            proxies =3D ['proxy.golang.org']
+        ud.parm['proxies'] =3D proxies
+
+        # Set URL and filename for wget download.  Use the first proxy f=
or
+        # urldata_init so that localpath / checksum keys are stable rega=
rdless
+        # of which proxy ultimately serves the file.
         if ud.parm.get('mod', '0') =3D=3D '1':
             ext =3D '.mod'
         else:
             ext =3D '.zip'
         path =3D escape(f"{module}/@v/{version}{ext}")
+        ud.parm['mod_path'] =3D path
         ud.url =3D bb.fetch2.encodeurl(
-            ('https', proxy, '/' + path, None, None, None))
+            ('https', proxies[0], '/' + path, None, None, None))
         ud.parm['downloadfilename'] =3D  f"{module.replace('/', '.')}@{v=
ersion}{ext}"
=20
         # Set name for checksum verification
@@ -127,6 +140,24 @@ class GoMod(Wget):
=20
         super().urldata_init(ud, d)
=20
+    def download(self, ud, d):
+        """Try each proxy in GO_MOD_PROXY in order, falling back on fail=
ure."""
+        proxies =3D ud.parm.get('proxies', ['proxy.golang.org'])
+        path =3D ud.parm['mod_path']
+        last_exc =3D None
+        for proxy in proxies:
+            ud.url =3D bb.fetch2.encodeurl(
+                ('https', proxy, '/' + path, None, None, None))
+            try:
+                super().download(ud, d)
+                return
+            except FetchError as e:
+                bb.warn(f"GoMod: proxy {proxy} failed for {ud.parm['modu=
le']}: {e}, trying next proxy")
+                last_exc =3D e
+        raise FetchError(
+            f"All proxies failed for {ud.parm['module']}@{ud.parm['versi=
on']}: {last_exc}",
+            ud.url)
+
     def unpack(self, ud, rootdir, d):
         """Unpack the module in the module cache."""
=20
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d021ad786..76b2e203c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3815,6 +3815,28 @@ class GoModTest(FetcherTest):
         self.assertEqual(bb.utils.sha256_file(os.path.join(downloaddir, =
'go.opencensus.io/@v/v0.24.0.mod')),
                          '0dc9ccc660ad21cebaffd548f2cc6efa27891c68b4fbc1=
f8a3893b00f1acec96')
=20
+    def test_gomod_multi_proxy_uses_first_proxy(self):
+        """First non-direct proxy in GO_MOD_PROXY is used to build ud.ur=
l."""
+        urls =3D ['gomod://golang.org/x/net;version=3Dv0.9.0;'
+                'sha256sum=3Dd9b70a10f88ededacb4e0e974de5d5a98e3db9c1e0e=
01c4dbfe5a5279b65a0c']
+        self.d.setVar('GO_MOD_PROXY', 'goproxy.cn|proxy.golang.org|direc=
t')
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertIn('goproxy.cn', ud.url)
+        self.assertEqual(ud.parm['proxies'], ['goproxy.cn', 'proxy.golan=
g.org'])
+
+    def test_gomod_direct_only_falls_back_to_default(self):
+        """A GO_MOD_PROXY of 'direct' (only) falls back to proxy.golang.=
org."""
+        urls =3D ['gomod://golang.org/x/net;version=3Dv0.9.0;'
+                'sha256sum=3Dd9b70a10f88ededacb4e0e974de5d5a98e3db9c1e0e=
01c4dbfe5a5279b65a0c']
+        self.d.setVar('GO_MOD_PROXY', 'direct')
+
+        fetcher =3D bb.fetch2.Fetch(urls, self.d)
+        ud =3D fetcher.ud[urls[0]]
+        self.assertEqual(ud.parm['proxies'], ['proxy.golang.org'])
+        self.assertIn('proxy.golang.org', ud.url)
+
 class GoModGitTest(FetcherTest):
=20
     @skipIfNoNetwork()
--=20
2.34.1



