Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00608D262BD
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:47:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3867.1768963660601691364
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 18:47:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=FdrFUdN6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=548130ef9c=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L1hetF858135;
	Wed, 21 Jan 2026 02:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=O1rT0MLz+3+5mkG1yDzmlVnPtUnLNYG5VzjlyBmREmM=; b=
	FdrFUdN6SvVN6354Mihzw5Qx5UFWv4RI3nEwZjQP7NvO3q09vYDPdD4rKQRUImBw
	OgHLfeZH2wKUzSnwYxNpfXfDiXN8gqpU9PPQwlmTgwNawtTR+pGAhDUcZcaWlKZ9
	IFEDKQLjecxCqgyGmYa6Ldj6jOObKopZjKzGdYsyVg1niFWBKFeMxpXYUFL70J5Q
	9b/jHrVjEg0EDxsOa+ab02SrEcUTFNRZ3eXM1hszsy4PlOLeE/Fo5uvJ3ZcShaE9
	g5INDg5E/ZbowF0oGwQodUx20N9g9s/VKV8zoRsPbLjuyti/uHrBxqmq/4ytNoLB
	awTKUvRHzj2lSwwyJtUOog==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btncwg1gg-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2026 02:47:25 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 20 Jan 2026 18:47:24 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 20 Jan 2026 18:47:24 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/5] bitbake-setup: Add wrapper script for bitbake_setup module
Date: Tue, 20 Jan 2026 18:47:21 -0800
Message-ID: <20260121024723.2634264-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121024723.2634264-1-rob.woolley@windriver.com>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 52jd7doQaUFb4z2hxcaHBwDOq7QN0N7w
X-Authority-Analysis: v=2.4 cv=ecwwvrEH c=1 sm=1 tr=0 ts=69703e3d cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=xoNeGLyQ804MmdI-zAEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMiBTYWx0ZWRfX6lsD8WVnSBdh
 pW634js4euuZk4h/6QJtR5FkqQ2yisI/MDRdaXbsCr8Fhq1Vy/1KVjcYoQiw9xofVm19uWrI+FT
 Yi+vVj8xIfW7XcE11G3X0vphhwLqcAHvcqM7366qcw5ReT5vQlmq1yFigyRLNZCpF9ZBYSpeL20
 eMCyBl3mOOipfiGo8d8RAIiPGn4jPuPmkjymGk3f1KZeL0/mpFbjgR4ifB9PYUaLITqVCzeWZ/T
 Rv+BhubOODWsNtvBQVIMoMCp+g+U8rokAbNxm7Pn3bwd/RyErOGIOgC67ONIKmaYu7RRZ7BCgI4
 66xMZ8K1mCJCnKPgambzS+jzRe9efLwFvxbcP/bEwt5ELnp/5lNHuLczy3k5CNwyobHjc06760G
 XgKUpZZHdkUYoty+HpSRR/CTMV7qPw+oV7uvO9n+yrUAGO0+za9wo4OYDtai0r/IuELXhtmiS7N
 W6UfrTC+sBfFFXDJZRg==
X-Proofpoint-ORIG-GUID: 52jd7doQaUFb4z2hxcaHBwDOq7QN0N7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210022
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 02:47:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18828

This wrapper script is used to support the workflow where
bitbake-setup is invoked from the bitbake git repository.

It uses the directory of the script to find the bitbake_setup
module present in the same git repository.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100755 bin/bitbake-setup

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
new file mode 100755
index 00000000..e1b1cdd1
--- /dev/null
+++ b/bin/bitbake-setup
@@ -0,0 +1,11 @@
+#!/usr/bin/env python3
+import os
+import sys
+
+ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
+sys.path.insert(0, os.path.join(ROOT,'lib'))
+
+from bitbake_setup.__main__ import main
+
+if __name__ == "__main__":
+    main()
-- 
2.49.0


