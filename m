Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEECFEEF5C
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:03:01 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83591.1775574173397665004
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=i4bSHvsk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376LvYn2986663
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 15:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=R9ek9DhbmTfGih89MDmGLMtTzXjfaIQPWpYEgqHTTHc=; b=i4bSHvsk2GkP
	T4CRJZaPaC0/OEvWPIq2OzfpIkuKhgQKBjl+Ny1wg8tZnX7dh/eiDYN9CF3wfbZX
	fBlwNkWbh5fE4KZqVS2hf/MkYtAN4OKiqEsiWRXrH2RLOXVldM/gS1kYZ1cexkYz
	85e5+rJ5nj6OyNLOXeRi2gVnHb38bijwsJh1ox31fnsSAbwnaUXv7Meppyt2KW/U
	U4caakmL4E0qj4UrDpnoGvf3ojsWm1dLPNTCtshnpwbMqM/k/achZW/H50ZKjmgu
	SxSq0C7RV5GwdAD4I/2OUaE9+9YEOArX0ZOBkSe82VPiuNGo4bHkYeS18WlT6f2w
	stfz/vEcWQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrqgx3g-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:02:52 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Apr 2026 08:02:50 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Apr 2026 08:02:50 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 2/9] bitbake-setup.schema.json: Add examples property
Date: Tue, 7 Apr 2026 08:02:43 -0700
Message-ID: <20260407150250.104135-3-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260407150250.104135-1-rob.woolley@windriver.com>
References: <20260407150250.104135-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RPCD2Yi+ c=1 sm=1 tr=0 ts=69d51c9c cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=eRc3Im3UAAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=C_uONGLPA69YsntOWNYA:9 a=6K7LhGdg8M_A9WyCZdwM:22 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: a8PSQ4gXi8YcncKE7Y7P60vQ4jPoSNOW
X-Proofpoint-GUID: a8PSQ4gXi8YcncKE7Y7P60vQ4jPoSNOW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfX64gPGb8tg9C5
 LQKVqpYPO8O4j9NIiGsBmedqziMlsNPsSDDx5aMPH0LTqUljzDQ1J0Vzp6PL5GbxKJng4YfqJpK
 95bNWCFHnLm34paE+W/FTNHll034YJaqL0VDGHVWjVAXvLBsxR6nS1CxlWPvrKQpVlt2j0joLbL
 jQ3LGScYCHfurhTEin0lQF84Bp5Pvq4slQf6AYMs3VmaU0E1rIPLVCDPrliy7EiLxfHsYhTE+t7
 ug/m1s4Q+S9IlWJC7PWn5/4YmFKvNdgtkAoZjqhUs6BjGI4dmyBdzd32nJWV7K+nmK/j7EzHji9
 a1QETNPplRedWqs1pSq1hSkRz+qacVDr10ikURv3pc3nq8BWhz01YwVs2G38C+YIcClxv1O6NGv
 UMRor3d53uIalajRbPIoyn8FEoxtq4BbTYRD2iyYJeR2VGR3ZMFXDg13tix1kxapLS3OqGSUSpY
 lterhgzI+67zttjTryA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:03:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19348

This resolves the jsonschema linting error:
    Set a non-empty examples array at the top level of the schema
    to illustrate the expected data (top_level_examples)

This example intentionally only references bitbake as a minimal
example that focuses on the tool itself.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index d340c9785..3324546de 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -1,6 +1,33 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "Schema for bitbake-setup configuration files",
+    "examples" : [
+        {
+            "description": "Example bitbake-setup configuration file",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.openembedded.org/bitbake"
+                            }
+                        },
+                        "branch": "master",
+                        "rev": "master"
+                    },
+                    "path": "bitbake"
+                }
+            },
+            "bitbake-setup": {
+                "configurations": [
+                    {
+                        "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"]
+                    }
+                ]
+            },
+            "version": "1.0"
+        }
+    ],
     "title": "bitbake-setup configuration file",
     "type": "object",
     "required": [
-- 
2.49.0


