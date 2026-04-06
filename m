Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF7F46C6D
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:21:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60248.1775496072138449890
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 10:21:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=FNlzdVQW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=85563bbf72=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636ASbBr1474696
	for <bitbake-devel@lists.openembedded.org>; Mon, 6 Apr 2026 10:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=rNM+f9w9IjQwlIblA8YOkZ1ePcYkMrg4avn1Pz6qdis=; b=FNlzdVQWetU4
	FqiWAGkm5z5hO8sCD4rcS16kM80xuDj9IX271/tsyHrriw3yiienf4aI5w3lDg1v
	1moyYEO08lDpKnnAutg+qixLre0SVYsKSft3jgHD36qHec+kMlPz/hAnPZ/bCdv7
	RBRU7YicP0gOR21hEhyrPrXppVSxK7jCEMuSLreHtcGjduaZuNsyS5SCrvJvSazp
	83gAOwMlxVQQKdDzKZCLrSyNfgr1v/jK6EHXkIHZW961GlY0fot68TuETuo9WTGH
	e8laZkpRSRcDYYZESX7YzAZUg2uWWNDkne1gUbM2xU/KFGzyxv3N51Ba0lRycXjb
	qlWaZD3mLQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dawwx9rha-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 10:21:11 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 6 Apr 2026 10:21:10 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 6 Apr 2026 10:21:10 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/8] bitbake-setup.schema.json: Add examples property
Date: Mon, 6 Apr 2026 10:21:04 -0700
Message-ID: <20260406172110.2050236-3-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260406172110.2050236-1-rob.woolley@windriver.com>
References: <20260406172110.2050236-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3MCBTYWx0ZWRfX+dIlKUyP8eBV
 m/bPtR9QQFNpRSXYWSMcx5P5EE/vMSi1Suc7xspvEq9ebna8HwoAgFZnwI21AzJfkR8+1r465zH
 iuBBeZ5hu+0uiL6/XdiVJAyh/H5S3b9O51Pb2emnIsIrueuD4Qf7xSc6A+eoX59ROBgVqoNtuPV
 aaKUm3dDQ78/ZSgTrau5mXsg2v/Em17kBjXkxOFpbtXmrhkkSbJfPEoPxOoUdLK9rTBTTabPA4H
 4Df3lSjyCvc41yxtep3DM2LrKxJkVretecky+etbA+CYUe3dfJv8TnS9QMYdt0YHUwp88HGtkmz
 PLjbhvwTltjdMz249rE5Cxs/SDhB/gcMWipuvR5dnHas4LwlcGWxd3oVWNMUS0hW3L6Fox+0yDC
 U4at+6jzgi9nIeNu6SgVhd0Sm2g8lhpHHWQBKyUyL14yDotVV5qWGxjy2Qho6UnsuGStIuJseLL
 FLBqwo6E3Z8WytXHHpg==
X-Proofpoint-ORIG-GUID: UBTwdDijbZWYOLDvvvvarXVYjXYgJ5vg
X-Proofpoint-GUID: UBTwdDijbZWYOLDvvvvarXVYjXYgJ5vg
X-Authority-Analysis: v=2.4 cv=AZm83nXG c=1 sm=1 tr=0 ts=69d3eb87 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=aUFtpbXPKauoctxpIh4A:9 a=6K7LhGdg8M_A9WyCZdwM:22 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060170
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 17:21:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19325

This resolves the jsonschema linting error:
    Set a non-empty examples array at the top level of the schema
    to illustrate the expected data (top_level_examples)

This example intentionally only references bitbake as a minimal
example that focuses on the tool itself.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index d340c9785..976e2cdf7 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -1,6 +1,27 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "Schema for bitbake-setup configuration files",
+    "examples" : {
+        "description": "Example bitbake-setup configuration file",
+        "sources": {
+            "bitbake": {
+                "git-remote": {
+                    "remotes": {
+                        "origin": {
+                            "uri": "https://git.openembedded.org/bitbake"
+                        }
+                    },
+                    "branch": "master",
+                    "rev": "master"
+                },
+                "path": "bitbake"
+            }
+        },
+        "bitbake-setup": {
+            "configurations": []
+        },
+        "version": "1.0"
+    },
     "title": "bitbake-setup configuration file",
     "type": "object",
     "required": [
-- 
2.49.0


