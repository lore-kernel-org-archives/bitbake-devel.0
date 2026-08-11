Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BADC5B56A
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 14:34:59 +0000 (UTC)
Received: from mx08-0040c702.pphosted.com (mx08-0040c702.pphosted.com [185.183.31.154])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.55377.1786458757600602046
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Aug 2026 07:32:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@karlstorz.com header.s=S-DKIM-20210427 header.b=IHZtiC4K;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: karlstorz.com, ip: 185.183.31.154, mailfrom: prvs=26834fd734=rouven.rastetter.ext@karlstorz.com)
Received: from pps.filterd (m0267678.ppops.net [127.0.0.1])
	by mx07-0040c702.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDZCEl776317
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Aug 2026 14:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlstorz.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=S-DKIM-20210427; bh=glB51
	BbjSphdUZn+vODMCrjmxhAjmEfurznlcEglvv8=; b=IHZtiC4Ke6SjjCrzKFOtO
	qL8+ncWfEk3OPQ0VGGB7zM13w6vdBAOBN/ISQpXucuhl/BaKFC4G5ngA1QNp5L9z
	cOf4LfbPMhsQNvD16HP578c1xx2y6/er/+UZ7sTi6aRSAUGjzmm97mJsquY27q8z
	X5wZfD7BWXuyKjxtuVx4RlYMqWYrXoMUsPhn3CeBfmB28xmxB/sB4UiQAZFg41YG
	EFpJfvLzJZjC302nR3xV9MvvVSJwmBHTMCzP6qQudLg0Qy755MIikLDUlx/eCxFv
	olbDNj0QY2g4/BE280GaFSE2VS8h+TizTjXkU/Izg5hgnvAbdfquzPalvHqjK8Pp
	g==
Received: from tut-ex01-pv.kstg.corp ([62.134.76.232])
	by mx07-0040c702.pphosted.com (PPS) with ESMTPS id 4fyxjasqkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Aug 2026 14:32:35 +0000 (GMT)
Received: from TUT-EX01-PV.KSTG.corp (10.0.10.190) by TUT-EX01-PV.KSTG.corp
 (10.0.10.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 16:32:34 +0200
Received: from tutn-jjhfqf4.kstg.corp (10.0.10.41) by
 InternalSMTPRelay.KSTG.corp (10.0.10.190) with Microsoft SMTP Server id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 16:32:34 +0200
From: "Rouven Rastetter" <rouven.rastetter.ext@karlstorz.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rouven Rastetter <rouven.rastetter.ext@karlstorz.com>
Subject: [PATCH] fetch2/wget: checkstatus: Do not try again on 404 status code
Date: Tue, 11 Aug 2026 16:32:12 +0200
Message-ID: <20260811143212.2085885-1-rouven.rastetter.ext@karlstorz.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMiBTYWx0ZWRfXwCwOxihj3xPq
 YOXM2KFIAlrRMLoXnqMi9cYCr30VRtsS/LiDu8NmAsNhyMFAgSSV5K38AfAzQED2CCuTIPTQKEK
 y2+BsY0IpABsPuC2xvE1KN6JeuMeZ79lMykhrboo9/7BDaQ/HTxf
X-Proofpoint-GUID: mbt6xtxWm_AgUR5zv0r0GDUMJTsPL5K5
X-Proofpoint-ORIG-GUID: mbt6xtxWm_AgUR5zv0r0GDUMJTsPL5K5
X-Authority-Analysis: v=2.4 cv=TYmmcxQh c=1 sm=1 tr=0 ts=6a7b3283 cx=c_pps
 a=OToaj9FDvIz41JSycRbD4A==:117 a=OToaj9FDvIz41JSycRbD4A==:17
 a=eIjXppYmxIHLXEgB:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DBWTBMGyQNCzyBkTEoZL:22 a=-VCclSYHLTda9MBvNMHz:22 a=oDe8D4UVr2cHOxPrqcMA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMiBTYWx0ZWRfX+JQ80a++pqf8
 JnY/FYa1ysyY2/F2diMic8AXvGSTq6bTLXbc/ouGPknuQZ2uWknpEpNz1EKi7NgNiblBCsHBlzQ
 +H58SBZ8g9O81P8pbP5oKe6WjM8uxL2kTyq5dYja25ezUtKHI6+ZiIHJfQtHsYVHJysHlIfYQFX
 +CIbY9mT6gcSXgMo8TgYRm9nh7xyPuEcE+hTFH+s69dri92114DdWuM/pKW3W2xnHZ+1bAXMoww
 /awwrSxVWZ2bQoA5njrZQlYOYxldAwyBJxig4y9ppLp+nwD7ade80FTL8L/PKEjdlyJDSPiXUe9
 bN8fK476rk0cDprYqVI+aftpE9KE3PTCuMPTRyKe8zfWWh/eP6zXFKIbW2Va2z8WxaK/M0LP2uI
 BkMZFDcf4W8OtlcBr/W4V9HO1Kmec9TglSdjK9t33xD8/dc1OqYRiNA9ZVXJuWFhRzm8n2kq58h
 qIMwknuHD6kRu/kKaHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Aug 2026 14:34:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19912

Http status 404 means, the server send a valid answer. A retry should
not change the answer and unnecessarily slows down sstate cache
checking.
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 141c2d062..8a8d30ab3 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -421,7 +421,7 @@ class Wget(FetchMethod):
                 with opener.open(r, timeout=100) as response:
                     pass
             except (urllib.error.URLError, OSError, http.client.RemoteDisconnected) as e:
-                if try_again:
+                if try_again and getattr(e, 'code', None) != 404:
                     logger.debug2("checkstatus: trying again after exception %s" % str(e))
                     return self.checkstatus(fetch, ud, d, False)
                 else:

