Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0475B10F92E0
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24318.1774973227113724990
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KlTBZOnS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6nv8N2249206;
	Tue, 31 Mar 2026 16:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MkwjutSynuM2Eqq+KcfRqoaRS6CrYkUlTmtZ1aVUajg=; b=
	KlTBZOnSwODveWC/eMYgPx1LpeIv93yareeUcF8pgHNDc3PWA0CSlCOaUcdN3Ku3
	st1/xT6sfB6pAVk/Qj1DSrDU14xjmGqxHzkFz2UzVdvgfaofQAZqaqf+ktQrCScG
	nYrKSSLvYSDsMFNzyQyuEbC/4UcWpaaeX9QRlcoonCWp4BdT2cax31VLaxDQIE9s
	2n+75u9Jc9nwghRHsfVfVW2ZO6m0a+2W6AVDHmH9PuD+k6m5Nf66E1bcsFFJW92l
	/xgk4hWmrNOXBw8mjJ1AybLL8sBgj5LjnyChmDClAEaD9uw2YPkvrDjMxl2qezyc
	CIAmP6s0Nyp57LyO2p498A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vuyv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:05 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:04 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:04 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 06/13] bitbake-setup: Add the conditional script stanza
Date: Tue, 31 Mar 2026 09:06:56 -0700
Message-ID: <20260331160703.3137930-7-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cbf129 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=I3xv36lx51p9eynh3TUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: xVUlskzN_VULBP1G9L16VDb8UixYNGGZ
X-Proofpoint-GUID: xVUlskzN_VULBP1G9L16VDb8UixYNGGZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfXw37l58TEfuzq
 tjfsIxVqZJF4UWsJY8Q0C1Auo0cB9bM9EciGG4Jdl7B84Pen0NQbnKhJ1pIQyqoUqFv8+owhffL
 b3a+cvOCzY/5v/fzzXgPZnxkAoYDQDDoYs5RsUj+Vdp+5Y3Ebb+I9mKQzGg7+ijuYCudEILDK5k
 BFL5utIoOZ8+LMKMtuX52A8Y35ftrpnqB2aw1kOg2Q1tEOvhSaoFbcXjC5ZsiB9xmOZf1yxQPiO
 L/7N2xxv+YgcAIYfg7ZsZCvNSO+kzPxqWUS7GI39MYeViUIbMN9g3lN3oSZg6flJxG57FYnE3GT
 Y4T2Zn3Mz3q1A78UygCkjIP8pVfl9qOA5k1l/t7jnf87WjHIr1zZvr0RQzamYmKpZ/lTsS8xCQm
 EDJOJeqfyxJBWzzrnopVjjCrYrXize2koHwzvuAdXJ1vE0OVzfMUE2NtZPH7ZSxCK41TlNs8t6O
 rRZ5qQ+nhiH67nJvNfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19301

This ensures that the main function is only executed if
the module is executed in the top-level environment.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index f602dc1e2..be420adb6 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1403,4 +1403,5 @@ def main():
     else:
         parser.print_help()
 
-main()
+if __name__ == '__main__':
+    main()
-- 
2.49.0


