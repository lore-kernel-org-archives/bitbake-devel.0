Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D1109B494
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24317.1774973226660700639
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Ail9XdYl;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5i48A352519;
	Tue, 31 Mar 2026 16:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=9DbXTTApyr1oxfRG351I6WsDlIPDW/JO0fqB8YhPn/o=; b=
	Ail9XdYlwfzZvEIBBrp+kqT85Ns/6PmoTNFZzyGEamm0v5jIepWmjBZMzdRcGJjV
	d0FB+Xu6ieNdLNjmD2iuZenYpvCZKW9h2F8Dyilx7g3IU5Dmw23Xayf0t2EnfjLv
	X7OY3eNrjBgzSV4AztY6bcVvz21wEBPDulkZw7TccUOPUN7Udxl0b1Qek5gFQO65
	xWGeCKJwI3ubYQqvM3yp1M+zaUbtAKKfLVV0YXCrCc4aGjhmMIfQRvq7cw4dJ7zG
	SNyACzYDbxXg7djMAnApp+yGMXaRPt2rW8baMD2pDvC7YN3X3HFmoYbRc+0DK3ft
	9GPw9d4yoK1VFaeUKJAMvA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4bxjb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:05 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:03 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:03 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 01/13] bitbake-setup: Resolve unused loop control variables
Date: Tue, 31 Mar 2026 09:06:51 -0700
Message-ID: <20260331160703.3137930-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbf129 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=IJQjoT7YMls2vlgdCqcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX/xl+dWhmpmep
 2G2BeTTAA9BCw3lQEhf4uitnAzd05Ubp90HsQyOmP8ns/780J3J77xQPqxjj4fLAKViX7w3zhXY
 c3+IBAC/+CyJLAeEwQ/DpIi0YJ9oqXBxyZcvve3JcCP97JBGiTFcNg8lzvRK8z2qauhQxinWmxx
 7ThHCJfArG4cpXokjIVfRzx1K0+Ogxx1DW0uYSKzIX2Th81PEARKHCz6hAU9//DcD31wKHa2eoZ
 QE1Ga9pgqDREqJi0LocCRcgO+ZYicv9rnR47A3Am8AY0Xqqe4UUB78Pu7BF+l1SKVC5wJmPZlcA
 A5R0oCBothC2WMzhZzJNiOr07e00Jo22FISlUbwyUT+aNDw8C5h80TITEJ1WqbHqYWk6xpmtdRD
 hzieh9GcY3seD+k55sHqFgrPdqyuWNpVActF2cUkFQagUfCcsjjY2qF2H1hW6aA6TYHWJwqAV1C
 pDNo7Rtwre25+GKlDIA==
X-Proofpoint-GUID: G5PiQoy7IBogT8fX2uwnOajSWe22jfKa
X-Proofpoint-ORIG-GUID: G5PiQoy7IBogT8fX2uwnOajSWe22jfKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19299

The ruff lint tool reported loop control variables that were
not being used:
    B007 Loop control variable `dirs` not used within loop body

Adding underscore as a prefix helps indicate that it is not
being used inside the loop.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b02cbc2b1..304fbe6cc 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -134,7 +134,7 @@ def commit_config(config_dir):
 def _write_layer_list(dest, repodirs):
     layers = []
     for r in repodirs:
-        for root, dirs, files in os.walk(os.path.join(dest,r)):
+        for root, _dirs, files in os.walk(os.path.join(dest,r)):
             if os.path.basename(root) == 'conf' and 'layer.conf' in files:
                 layers.append(os.path.relpath(os.path.dirname(root), dest))
     layers_f = os.path.join(dest, ".oe-layers.json")
@@ -445,7 +445,7 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
         configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
 
 def get_registry_config(registry_path, id):
-    for root, dirs, files in os.walk(registry_path):
+    for root, _dirs, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json') and id == get_config_name(f):
                 return os.path.join(root, f)
@@ -996,7 +996,7 @@ def has_expired(expiry_date):
 def list_registry(registry_path, with_expired):
     json_data = {}
 
-    for root, dirs, files in os.walk(registry_path):
+    for root, _dirs, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json'):
                 config_name = get_config_name(f)
-- 
2.49.0


