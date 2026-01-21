Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005D6D262BC
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:47:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3865.1768963660538579003
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 18:47:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=RQN2Gt21;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=548130ef9c=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L1hetD858135;
	Wed, 21 Jan 2026 02:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ofV1aJZrdXEPVRuUxwyVZvpJx5BBOQ5iYq4tK5UHIW4=; b=
	RQN2Gt21NCY/gz3WX9vLpUlwmzGrApI9eANO0IclGTZg+1Xc7H7br91sOtAHtOeV
	nZ1PavVsETf+2tHPdXkW8WF6P+PtyPeaszoX9hpW8kVohtjpxVNxazDt4w/6D91r
	9EhM0Ro/8HNDDbgBvzGjtdro9jlZtpT/WaWEAC38M3gzPE8CA58yvTH6BPrb2yG0
	e57+LaTrgT1hRAbL5yd3CD/TbrCym+0S5li2Mxf/jw8wGC0qbXIieYDPFVxMyMh9
	SrgYDiDNRci6zIGIgTjWdsxnl8Q0gGLxMXCkyHp4gKGvFoJTLnpteYI8tKRsbAeu
	HaLH8mhDD/ixpV+ug7ZV2w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btncwg1gg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2026 02:47:24 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 20 Jan 2026 18:47:24 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 20 Jan 2026 18:47:23 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/5] gitignore: ignore Python packaging files
Date: Tue, 20 Jan 2026 18:47:19 -0800
Message-ID: <20260121024723.2634264-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121024723.2634264-1-rob.woolley@windriver.com>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yTqgTKbjZYE8d0F9q0VNzMjTn8Cey1oN
X-Authority-Analysis: v=2.4 cv=ecwwvrEH c=1 sm=1 tr=0 ts=69703e3c cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=E_K_3J3bz4N9Vrko1f0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMiBTYWx0ZWRfX17UefsjxmDtb
 kulJ6l/bawkLYhptzq5krSGElZAjQddfk7R93O2AtjWHimjcpp+bOQ4xTk9HD8QIIb8lUnaoCcO
 Cho5QehmC+qzuNyKxXkGzQKZYWGC8ESKzbbgXtIo1gcBYhudQjS5AIys3S/vJf2rVii4Az5ZqnV
 uvhJ5+LNnBY6L2H01hIZLp8Rn9vbQcBudcDgOQlSlHzBTP4rfVz0XTQM8A9ypWtV7h1sxJRMidM
 WwJV34nORn4myX6cV0vP7L2k8AHV0uqW8IeXnhHHORVgdp7IO7PtBiJ/IKv1syAGRDqfAdlrWRy
 UBclgmgup3NuzgCvJg7ZAjmvN+vevMxzPK7eSrcO68rCcOXyyAEf84575sJAZg7yJwNs0xMTBus
 7teEENePrGIZNKO5EAYS06F2uLcVKrnDn6zLmyKJPFvqf9rHQKvKiRURHEurcGgKNTtQ9ou5BRS
 loR+Ujy+0LVJCIOH2iA==
X-Proofpoint-ORIG-GUID: yTqgTKbjZYE8d0F9q0VNzMjTn8Cey1oN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210022
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 02:47:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18827

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index a6a256b2..0d8a8e23 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,5 @@ lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
 lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
+dist/
+*.egg-info/
-- 
2.49.0


