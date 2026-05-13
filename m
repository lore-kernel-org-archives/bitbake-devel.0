Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC31CD4851
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 08:38:39 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2962.1778661511946254204
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 01:38:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=dP+0U8wx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=959356aca3=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1cWF1011026;
	Wed, 13 May 2026 01:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=b+wBeQETS
	iiUU3As3OQ+5KOei6KkJZElwqDZaj5oKe4=; b=dP+0U8wxBLzbvjqvAZrT+F3R/
	vIZvqN2kBndObg+ilew9NLhbmS0nIuLSaamJjQU/04UE6KhbusOuWRggYjlwLkRQ
	3tVEirOkPjH84iLF+TwbEr7g8EX2jb5VRRV/bu1iGH6nFM3x7WSpgipOXit02sxK
	9YZhrfemO4LJHjJSbPGDDTdCK8pCPKRaz6CHLKnLFeGdsAksjCJSZDHel8E6YBNQ
	eJlk3KBpu9dWUXxBwg6aVv1B5uOeuGS0kyiHaKduE06dmnZMDGwiMup4//1+Q5kl
	OLBDmmzd9Oqttx6L1ZBOfJYA7MTm3FhQN2r8jK+rrug/S40gHvEDL98rUPHfQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8e6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 May 2026 01:38:25 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 13 May 2026 01:38:24 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 13 May 2026 01:38:23 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <ross.burton@arm.com>
Subject: [PATCH] fetch2: allow empty value for params while formatting URI string.
Date: Wed, 13 May 2026 16:38:23 +0800
Message-ID: <20260513083823.3089897-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OCBTYWx0ZWRfX0CiLTELuUf5y
 wE3DQmhtPNUc7076maUCk8zbyN1woyAl+nAkQUnRM5wHChEF6fJTynXgl1OLSECNxyED10W+wYE
 JE7xf0u74TLQMZrGwyqYpa4FVl6999EDDEVWPvXXvju/UGljq8S86xKDReMf2suTkru0wzkFCRI
 xwLe/usaafcshJJv2aUn8fSdlfNlTzxe4Bt/oCfyiuEOSoD+UxX3F8dOUceZ0ZPytcYnzXZgaCs
 iVGyeanZjylmsQIN6Ze7fg6MID29f4K4AWu6C4atVkVJi2W2+005CcbBAF/10HBqHcwv3rNmha3
 cokMx6qSRbUqXe5p0dPlGKnkgE6XMhs4K+NvGuBnpa1M8Y6chX3OP/6kXw12SmIRMtnXJIoHF1v
 kwVJIe5hSK13OpfVxEQ5sYg7xieMTvv6rpU2eXPPyZaz14dUsbycTzk4oP3sLjDdcLdAyMimCCk
 iMri+gB+A8tcZKA82/A==
X-Proofpoint-GUID: 61cwqEoD3yMB96-D7bpyTPU5ZY7eq8j7
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a043881 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=NEAV23lmAAAA:8 a=rN9iFrjnAAAA:8 a=t7CeM3EgAAAA:8
 a=zvX824Vnu1os9XwVN20A:9 a=4n8YEvAJnS2QHtwm3qfh:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 61cwqEoD3yMB96-D7bpyTPU5ZY7eq8j7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130088
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 08:38:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19506

While using PREMIRRORS to gets source code, recipe sbom-cve-check-update-nvd-native
do fetch failed:

$ bitbake sbom-cve-check-update-nvd-native  -cfetch -f
...
ERROR: sbom-cve-check-update-nvd-native-1.0-r0 do_fetch: Bitbake Fetcher Error: MalformedUrl('git:///path-to-premirror/git/github.com.fkie-cad.nvd-json-data-feeds.git;branch=main;protocol=file;destsuffix')
ERROR: Logfile of failure stored in: tmp/work/x86_64-linux/sbom-cve-check-update-nvd-native/1.0/temp/log.do_fetch.4135595
ERROR: Task (oe-core/meta/recipes-devtools/sbom-cve-check/sbom-cve-check-update-nvd-native.bb:do_fetch) failed with exit code '1'
...

In oe-core commit [1], destsuffix was configured to empty string through SRC_URI,
but in bitbake commit [2], it removed `=' from destsuffix in which value is empty,
and trigger MalformedUrl failure, see sbom-cve-check-update-nvd-native do_fetch log:

...log.do_fetch...
DEBUG: For url git://github.com/fkie-cad/nvd-json-data-feeds.git;branch=main;protocol=https;destsuffix= returning git:///path-to-premirror/git/github.com.fkie-cad.nvd-json-data-feeds.git;branch=main;protocol=file;destsuffix
...log.do_fetch...

This commit use function _query_str_join for query as usual (if a value is
None then it isn't a key-value pair, but a bare key.), and use function
_param_str_join for params to allow value is empty string and still key-value
pair, after applying this commit
...log.do_fetch...
DEBUG: For url git://github.com/fkie-cad/nvd-json-data-feeds.git;branch=main;protocol=https;destsuffix= returning git:///path-to-premirror/git/github.com.fkie-cad.nvd-json-data-feeds.git;branch=main;protocol=file;destsuffix=
...log.do_fetch...

$ bitbake-selftest -v bb.tests.fetch.URITest.test_uri
test_uri (bb.tests.fetch.URITest) ... ok

----------------------------------------------------------------------
Ran 1 test in 0.001s

OK

[1] https://github.com/openembedded/openembedded-core/commit/131e024a6688074347e08879718221fbfb69033f
[2] https://github.com/openembedded/bitbake/commit/eac583bd4c46f3bb9661852cb6a1448f16147ff1

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 lib/bb/fetch2/__init__.py | 7 +++++--
 lib/bb/tests/fetch.py     | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 52d5556d3..603ed693c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -303,7 +303,7 @@ class URI(object):
 
     def _query_str(self):
         return (
-            ''.join(['?', self._param_str_join(self.query, "&")])
+            ''.join(['?', self._query_str_join(self.query, "&")])
             if self.query else '')
 
     def _param_str_split(self, string, elmdelim, kvdelim="="):
@@ -312,9 +312,12 @@ class URI(object):
             ret[k] = v
         return ret
 
-    def _param_str_join(self, dict_, elmdelim, kvdelim="="):
+    def _query_str_join(self, dict_, elmdelim, kvdelim="="):
         return elmdelim.join([kvdelim.join([k, v]) if v else k for k, v in dict_.items()])
 
+    def _param_str_join(self, dict_, elmdelim, kvdelim="="):
+        return elmdelim.join([kvdelim.join([k, v]) for k, v in dict_.items()])
+
     @property
     def hostport(self):
         if not self.port:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 86dd92992..969e5f876 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -291,8 +291,8 @@ class URITest(unittest.TestCase):
             'query': {},
             'relative': True
         },
-        "https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip": {
-            'uri': 'https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip',
+        "https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip;someparam=": {
+            'uri': 'https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip;someparam=',
             'scheme': 'https',
             'hostname': 'www.innodisk.com',
             'port': None,
@@ -302,7 +302,7 @@ class URITest(unittest.TestCase):
             'userinfo': '',
             'username': '',
             'password': '',
-            'params': {"downloadfilename" : "EGPL-T101.zip"},
+            'params': {"downloadfilename" : "EGPL-T101.zip", "someparam" : ""},
             'query': {"9BE0BF6657": None},
             'relative': False
         },
-- 
2.34.1


