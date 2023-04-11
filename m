Return-Path: <kai.kang@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5C7C7619A
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 09:09:20 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9163.1681204154589452125
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Apr 2023 02:09:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=MwMP4MBE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3465c4dfd5=kai.kang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B8mJ1T027083
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 02:09:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-type; s=PPS06212021;
 bh=bLBbzjmiCzxCEjZy6C/Re4aFJgI8rCAMkimdwQHV430=;
 b=MwMP4MBEN5Zq3vfOGfha3RP09v26CkfaPGEj5LX0lMh+uM/QwJU8zTSinbzmezlvfxT7
 dxYSnKQ9MqDOahI2ihuAX8WQz0+607WyFi3MdxaSOQztmTuJE+0LD2uudcxOU3HNgd/r
 fXXzfizvyQ+xQfj5hZy5a12g2R3v1ZT+AsrhzIPWTkvJKfAFTuPTBbdA0Kh0wA6jYmkM
 eaIRe3Py8NEeRZjK/er/qnBrm1d8eiIKeTuELVEH6ZSz66pLlXglp3shZwCPDzTsdjV4
 s4Jvv7+WaGIyEkqnku6c/WpDk9RjBZEaYcidwvtIsEfnvQE/qqp3e20UXe3RBu/oNeBo 1w== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pu3j5jr8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 02:09:14 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 02:09:13 -0700
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 02:09:12 -0700
From: <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] bitbake: ConfHandler: Allow variable flag name with a single character
Date: Tue, 11 Apr 2023 17:09:04 +0800
Message-ID: <20230411090904.32065-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: KL9qDjGX-sb8ucn3vuPvPVE6EYEbxd5J
X-Proofpoint-ORIG-GUID: KL9qDjGX-sb8ucn3vuPvPVE6EYEbxd5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=988 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 09:09:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14692

From: Kai Kang <kai.kang@windriver.com>

Update regex pattern to allow variable flag name with a single character.

Regression tests have also been updated in `bb.parse` and
`bin/bitbake-selftest -k ParseTest` has been successfully executed.

Eliminate a trailing space as well.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 4 ++--
 bitbake/lib/bb/tests/parse.py                | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 05c627ec8b..7826dee7d3 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]*)\])?
 
     \s* (
         (?P<colon>:=) |
@@ -103,7 +103,7 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
 # a weak default, it turns out to be very difficult to filter out these changes,
-# particularly when the weak default might appear half way though parsing a chain 
+# particularly when the weak default might appear half way though parsing a chain
 # of configuration files. We therefore let the UIs hook into configuration file
 # parsing. This turns out to be a hard problem to solve any other way.
 confFilters = []
diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index d27c7c6f15..a3165d95bd 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -222,6 +222,7 @@ VAR = " \\
     at_sign_in_var_flag = """
 A[flag@.service] = "nonet"
 B[flag@.target] = "ntb"
+C[f] = "flag"
 
 unset A[flag@.service]
 """
@@ -232,6 +233,7 @@ unset A[flag@.service]
         self.assertEqual(d.getVar("B"), None)
         self.assertEqual(d.getVarFlag("A","flag@.service"), None)
         self.assertEqual(d.getVarFlag("B","flag@.target"), "ntb")
+        self.assertEqual(d.getVarFlag("C","f"), "flag")
 
     def test_parse_invalid_at_sign_in_var_flag(self):
         invalid_at_sign = self.at_sign_in_var_flag.replace("B[f", "B[@f")
-- 
2.17.1


