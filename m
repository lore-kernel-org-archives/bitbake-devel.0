Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC7710A88F4
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 17:40:09 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53626.1774546801424267718
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 10:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VCravLEW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFi7nI4072289;
	Thu, 26 Mar 2026 10:39:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=4cEj7NXsdwm1kIgYKgs5c+zNf4kUbQukbzhP1GkWA3Q=; b=
	VCravLEWPGlsfZC0rRgOSsz2sbAhtOIJBxXDA6stI1dRTlCBa3NbTpcC9k8rLIb4
	sGuUrRUrlionOv82vd7mLNru4vZOlQATp8llkYWUZsY7g785jc9aRC3zIW314vMt
	8EHIlH09Zl4FV8sZENGlYbYPsnk9ZmKScMSO4QgajY9gjk6tNqzrVpTMRvwaBMgO
	BtSUPtKjy0I7fAC6oOpsnuzCUrgkM5NzobrFhcRM5O0vqoQjGek7huNfNsDq7Dqp
	XIwxzMTdaS+Idp9HdfI5gpeS7klvHY/mHj38ASpK/mvDif7NpvPoS1ul35o0ymE0
	JOBsNDUOiniqQQ/3SukNtg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pkyes90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 10:39:53 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 10:39:52 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 10:39:52 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>, <richard.purdie@linuxfoundation.org>
Subject: [PATCH 4/4] bitbake-setup: Add version check and catch exceptions
Date: Thu, 26 Mar 2026 10:39:51 -0700
Message-ID: <20260326173951.519326-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326173951.519326-1-rob.woolley@windriver.com>
References: <20260326173951.519326-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNiBTYWx0ZWRfX+gq+X3WxdPa1
 BspDXanvCQPMATvfbM2c8GlXKMJDAB/IpRnlRnqEoKzKojgNjU6oAfGlmP6iEgwYCZ9+mDBN8eH
 De+fGvZQJSLr9MwexpOECw9wzI34Ijp7MGNkGYF1/Pe3yly8WmqL9enGryasXQxd1dWBftDs0f/
 ei9Ob80zYvJ8Hfti318nfyMK4X4huFI8PSB6pM936m9gOaAnZQmOTE7SrcpfFHiOYzaKJBgh0wV
 RRhCCqaeIfCCyZwCyQEQwMn4TVBMTRT/F+xPzLMKvdjM/8Qr7D1Ahs5PmH+DjSZ2O85l6TXWoKg
 45dbqsF8wF+Af+dRT8Wsfb68ksinm7fLLPsyvQtyuYXrvZ30/4kiqSrH0RlojnyTEVUweOWmRl0
 HTIk+O32+x9MM7eFlbX5NaxVIJdnyw9kArJlI1/faZSNstOC6QxdKNHPw0B3f22p1RkBIFdqhOY
 5MoGGFWwNfRWvmk0msA==
X-Proofpoint-ORIG-GUID: weR1f7lz2Kl2Yjp7LMFoKpJUxY0M9_Jz
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69c56f69 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=UlQryPpcJGEf9TBE9sIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: weR1f7lz2Kl2Yjp7LMFoKpJUxY0M9_Jz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260126
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 17:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19244

This modifies the conditional script stanza to match bitbake.

It adds a version check to ensure that the correct bb module
version has been found.  It also catches any exceptions thrown
during execution.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d7e2e187c..65c38b4f7 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1193,4 +1193,11 @@ def main():
         parser.print_help()
 
 if __name__ == '__main__':
-    main()
+    if __version__ != bb.__version__:
+        sys.exit("Bitbake core version and program version mismatch!")
+    try:
+        sys.exit(main())
+    except Exception:
+        import traceback
+        traceback.print_exc()
+        sys.exit(1)
-- 
2.39.5


