Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F36D262B9
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:47:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3925.1768963661469711402
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 18:47:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bC62Kd3N;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=548130ef9c=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L1hetH858135;
	Wed, 21 Jan 2026 02:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=qHkugV9GGI8EONPIr5A+mGz/MU9DcdmPfK1ib6xi9eo=; b=
	bC62Kd3NZf5Xj9Ncywq3KuspsfTJSr1d/0uenyXJCPjbjYi+/DUWaYCwFcVkx0ct
	+FUQRFULXhr5X+aM3GNQygsjAGIozVK7eXaQA329BisKsmk5j+xERZHggmoHovXA
	d8eKzJfo7VM+Aujxdzm6V1i+fM9SLPFUnj6kf9WeO/dgtwzsSWAaQXt5KwGDgSAc
	KzFm1MgzSWMEcMbwbdY9lBHYKYHlq/RrYvVt3WMrMum/1ieZbWELPR7iWzXOX44i
	p5aRr9XYA+O9RjYwwK9LOJVa6QNmGTNPStoCjaQOOYeRjSj8PRbAlkcrVlfgopTp
	KmM6sBV4GjBIUCyZLMH5+g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btncwg1gg-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2026 02:47:26 +0000 (GMT)
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
Subject: [PATCH 5/5] bitbake-setup: Add the conditional script stanza
Date: Tue, 20 Jan 2026 18:47:23 -0800
Message-ID: <20260121024723.2634264-6-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121024723.2634264-1-rob.woolley@windriver.com>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hgi4Xjz1E-H71PkBdM4yX7GByw2FvnbH
X-Authority-Analysis: v=2.4 cv=ecwwvrEH c=1 sm=1 tr=0 ts=69703e3e cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=zBLw3jcbN7HYTawJRx4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMiBTYWx0ZWRfX96ZhZjZelY43
 m/TNvTCtOQsm5OCAU91kuqvTagGPahtFqGfNR+7cPwAx6OHYonNIRlzx022ziTwKenASVpnKd0Q
 8Fh4YPraI3lElgKj/qvzaKi+hjLyTrOeJac9ZdxexZd6juRm4iVm52HORQrccyJmU5iU/BLd4Rg
 hG1YNv05AJ70A4M4TrHg9mhJ8NiMgnoSX5HbzBM/pt+Cs1KhH0doI53tY9raDAsh79sj2nyLyd5
 1JVo5huVjxzlBvGd4HXUWJ2KDPfbbTI768JvylqO+W2nYPfy21h5hyJSzcCkl45jIyc75IbXXx1
 yt2kOJCzqGO4kG8ZRDnkrEMjQvilyPtLq+BodhBjZoF4kuFnkgti2eSv0nj7ZEzMHS3/i6sUE/3
 21ulFj02qEO3Dg40mizVrZb/9PVn7jvCcNjERVviCwfv6QaLO3/iPwVIid/Mi46jxn/hUi7CmPp
 HatIUU3kV/dYVU9loCA==
X-Proofpoint-ORIG-GUID: hgi4Xjz1E-H71PkBdM4yX7GByw2FvnbH
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18829

This ensures that the main function is only executed if
the module is executed in the top-level environment.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bitbake_setup/__main__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bitbake_setup/__main__.py b/lib/bitbake_setup/__main__.py
index a69dc750..d23582dd 100755
--- a/lib/bitbake_setup/__main__.py
+++ b/lib/bitbake_setup/__main__.py
@@ -1106,4 +1106,5 @@ def main():
         from argparse import Namespace
         parser.print_help()
 
-main()
+if __name__ == '__main__':
+    main()
-- 
2.49.0


