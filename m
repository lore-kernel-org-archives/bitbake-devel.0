Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BC2D3409E
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15119.1769529918077853438
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=EC9t+mm0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZI880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=KwqWEccu88eLeftI6CQVirprzAW7FlD8aIIwLCxerT8=; b=EC9t+mm0SFvT
	PEQY+opa27hw325zWxt7e8cPb91Q0kNmJlIRhIaOgVvTDvacSecffUhx/yez3Nb3
	GtBerGOj1WCaqOqunOPSfxyQyyabw/VQIjo2jEIi9epTrtsZ0ZRXR3eFbJzFbKwZ
	AjqRmLNdY+MoZUUOcQriQUYn8UvaiQ2vhvNEJRC/YI9tMMdf/yaFaTzJpD4vJsf8
	IEiEldL9X1H2nKE/E7SJpNp6mDTbs/sM+6QAGHdkt/jkZIiAl/j2s4dh5vpRFC4Z
	p//1hSAmVdnOlRkmZAEcyHrP9/ZP7mH/9dxR/8vj5Luf7vKpRpU0CCr2J6eJYZ9A
	Lu/a9UPZaQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:17 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:15 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:14 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 09/10] bitbake-setup: Remove unused Namespace import
Date: Tue, 27 Jan 2026 08:05:06 -0800
Message-ID: <20260127160508.3392732-10-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ksRpBhZA95RdzMmXPYH3x9Pmze5KYLW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX0WKAzGhmH2m2
 YqKIHBr/85UFBD5E70MaRt7pw09IwaBYy+qLuLoKWlpjJFDAEDHnagX5EuK+wvRyHztd7bkcmlP
 IX51jCjz0s4rZtauYRF1ZVVP2egGCsrLM6okODL7RsUwJy36q8NqUTi2z7nhzb6lm7g7Fb9XvDY
 rCdv2fqCnXf27lzL8Qu0/yZLCbpDQ1z8b7y5+hBvprEHjho8Fn2YmZOoF1YlETwQjnmqs3Kco6G
 Jsl4Ysmvc7HNLgfYPvqsK+67ZGCiHu3mcg1THn72nVjbDEyLyhivaUjPipx3T2p2WQPi4j+JJy3
 +DDS6xJh1Vn4HFXhsLugheGWN4UpA38SqXP/4gk0fbLWfLMtA9ei6RcpW7i7MgjuaU1bFqHEh+v
 gfLhB7klT8lyp9Nfs0RhYew8F5NcEWeVsRYXTuu/sOXHSkOwm3IjaJGzHd5uFww5xbQSxudC9wb
 ScKfpUmXege4v+2tC1A==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23d cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=rPNT3So2aFC0sl9B09QA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ksRpBhZA95RdzMmXPYH3x9Pmze5KYLW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270131
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 16:05:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18898

The ruff lint tool reported that Namespace was not used:

    F401 `argparse.Namespace` imported but unused

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d19b5394..a67c10af 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1102,7 +1102,6 @@ def main():
 
         save_bb_cache()
     else:
-        from argparse import Namespace
         parser.print_help()
 
 if __name__ == '__main__':
-- 
2.49.0


