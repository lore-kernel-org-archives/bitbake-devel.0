Return-Path: <kai.kang@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF7C76196
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 06:07:00 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.7212.1681193219224729617
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Apr 2023 23:06:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=Pd3n66fH;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3465c4dfd5=kai.kang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5jtPn002025
	for <bitbake-devel@lists.openembedded.org>; Mon, 10 Apr 2023 23:06:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-type; s=PPS06212021;
 bh=vBjmBinNC8YauMvZDK6/dHaWRrAP3T8rCu08kCLkaGs=;
 b=Pd3n66fHxzVLxuQLlnJOXs5f3sgMWuoWVDg8n7l2kuSuAPxa9CSb1BaphZ5jwdinqIrO
 FPNr4tPMGib+sqqSMMj3tHCURFtxDG/xbtcos7CiZqSw80uaKIRB6ypUPGpQBwfVxPQ/
 2DuAiezqBPyfqSE6oxFIx3028mxWdPYqkUAwjYviqdAj7IXLkEM3q/jhNPd1VF6SjKwz
 abD74HPmVmNq3nN9uKcg1Dtb7IhepdfLxZh2r9n3/rQdRU4NGRe4elkDBUALlNpBpILM
 2o5wsfPIdekL+S9Zfl4YiB3KeqdZCe8kG69cvTU6fRphJoULet9IzL3GFOmhA0TP+LDR 9g== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pu3j5jk5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 10 Apr 2023 23:06:58 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 23:06:57 -0700
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 23:06:57 -0700
From: <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake: ConfHandler: Allow variable flag name with a single character
Date: Tue, 11 Apr 2023 14:06:54 +0800
Message-ID: <20230411060654.19442-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: qbMbOMtKKvpuLRIk86-S8SwLLmw6zV7_
X-Proofpoint-ORIG-GUID: qbMbOMtKKvpuLRIk86-S8SwLLmw6zV7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_02,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=925 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110056
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 06:07:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14689

From: Kai Kang <kai.kang@windriver.com>

Update regex pattern to allow variable flag name with a single character.

Regression tests have also been updated in `bb.parse` and
`bin/bitbake-selftest -k ParseTest` has been successfully executed.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 bitbake/lib/bb/tests/parse.py                | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 05c627ec8b..0bfe357012 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.]([a-zA-Z0-9\-_+.@]+)?)\])?
 
     \s* (
         (?P<colon>:=) |
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


