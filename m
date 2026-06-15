Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D73CD98E1
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.135401.1781545093469164306
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bayERcc6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej7C1186413
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=SBY0cJAmi8HwyC4fp3WxoDXpuEv1LlRdnBWzJdxcxW4=; b=
	bayERcc61wZmSByGgibYwCbkmc8ejuu+T6ANMxeuGsAtRbNmBrUCuhD8IDdKlzgs
	KiVjQN8odD6ExJYEshIEYXlVd1j1zYNtm7T047Xx+NAm5hc+wQl4BXUAiaNDg6kx
	Q4ZrUj/TCs1Tu+4Sy1E6oM+0dQD98PEeGMogKNjGp3vJuaAc8ktSEH0b7krs9CcO
	ve5e4gD84dhXn9AZufvEX+uWl2R87iiNf6ZTfDUM4o7/K+LIa220XJbpw01A0+vU
	4S8YTMSSLrrQEJHZS3pW3y8kgS8uoGDQjlcsr+phhBdDPN8eOEDedncrtFtkvuxk
	n9EQICbaKqeRGGfpUfuxCw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:12 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:07 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:07 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:49 -0700
Subject: [PATCH v3 07/10] layers.schema.json: Add examples property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-7-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX4roYeN0aGENg
 umlmt7RgQUZQzhA2ULBAyb6LWXp5iDW/3SmW8RE4suotC0MvNpkrCMYroYWQeABFOOIGT41xFk/
 +jYok8PddyB9mJ7Uc9X596FDeKrMB6c6X32frFGVcbu+ekR0qBxRuYeA9guhNI3CMmou4VSgLD8
 ffaoKR5QE+zu3ZgwqWAIlbNyqJaLm2QNmz1mjskx3ci7iCK0KxDfK7vqiWx/aXQn+wjrhXfP0j8
 zJXx5jQcbY9+JFuqWbSOOgsdI7rzDejSrwnJxHusRIAFTh9BnKHSwRkRPDqBN64Hrc+WkPnE48i
 SxQLAvPbkNAcSpgEOCSRO9C6PI+a39qgKVfny2wHG0QjzIQhN6rMBWGJXyMwlwp8HVIwENXYmWH
 vrufFZCj5BSFt4Mukht57AQ9Gnnuct2mlzZMffE4YkMHaPaGwEwU8ci1CYFB5L+FPu/quYYFl5s
 W5/XsirX6ZJZow9Errg==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303884 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=eRc3Im3UAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=t9p6cdMu2i1p4WqHfg8A:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfXyyW7rE3Dtsjb
 xYMrxDafto7HYiX5qm57N+jtFw9MAmelCfONRRgpWOYYZBVf9A9qC+T89tIWSljA5PsQ3W5D+3E
 MnkMRIKEha0qyLXvOnsBlMJc1YUvIn1A7jGPbg0061ME1YJcEBX+
X-Proofpoint-GUID: A3R3QhWLa2jMW1VqAl9v7GZBDmC6FuJh
X-Proofpoint-ORIG-GUID: A3R3QhWLa2jMW1VqAl9v7GZBDmC6FuJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19696

This resolves the jsonschema linting error:
    Set a non-empty examples array at the top level of the schema
    to illustrate the expected data (top_level_examples)

This example intentionally only references bitbake as a minimal
example that focuses on the tool itself.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index afeac1869..e75380be8 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -2,6 +2,25 @@
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "A schema for a manifest of layers to setup",
     "title": "OpenEmbedded Layer Setup Schema",
+    "examples" : [
+        {
+            "version": "1.0",
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
+            }
+        }
+    ],
     "type": "object",
     "additionalProperties": false,
     "required": [

-- 
2.49.0


