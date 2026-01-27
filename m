Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E73D340A1
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15117.1769529915803519081
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=IRWiE7go;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZA880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Vu7ViNbw0FT5GHkXZi45/KNPUFZcCCbMRbqd9a14dUA=; b=IRWiE7gozWPt
	orLjQ9xLgshdglocfZUUSf8EGIA3oq5uAzPyXDduDq41NbEaLLJ0HVk6J2KRp2OV
	Jvf1zlid3iCduILJEoU3DgVb0iIA7Y0aqhlDFomU7aQ2zzWuO4ruphnAGj1mUdP/
	rz7wZnjzJ91blwda+p5MlVSh4Gih3k9wAnKZBXtd87DocPwB7bES72FwwcB/M8fn
	mwTnROEe3ak6W/e5xxUhFuhPxfcpoPGzxSC/0dNwdfqYZpqb8JhK2oILyDuXcl0j
	p6bGtYD7vHo0f+63o6lkitcPM+RBdOpL2LMXtKKVYFMEJvBCkrkjMCyIPIt+ZehP
	t4u0Dkz5FA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:15 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:14 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:14 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 03/10] bitbake-setup: Remove extraneous variable from str.format()
Date: Tue, 27 Jan 2026 08:05:00 -0800
Message-ID: <20260127160508.3392732-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: L89GWLr-Qh3S62_PH7LpEya7xZEUaTZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfXyENWek++9x5f
 iKNmB473Fl4iJ8aFSpoNT+bOv8V/yHV3UnsTVW0FkZgDOmZ7us4k7dhHYSj5LUGQvvcPNDBCTUQ
 i+BsvAm3e4RcE9Lq3fGewF0za0DhnY+tkBov3Sz7oTAguOunpCVrOBbo4Zmz5MEocsIW5TCSflk
 agDBFqcfhCNCU016y4zTOqo0RcDdAA3ChjWb8uorThHkCr/senXzGk1SPiJnUV1Gvc8g9P9BBmO
 4A/J6JJGsKbPHhaL05IHNu/EAm5Oh5QjiMpl0JARZPPTXZ3LZYBhSrt/pvLN2FVelrRg6rzNsIF
 3ut83Vc82PNY6MMw0oAj6vDScjUa9JvinYy52sDQMQSccm7nlRv9/e7781ySDlAAfjbZkIctK9+
 EnwuWyk8OHIxKXNSBJDbq0oIQmT5N2sTD4oa8cs43e1rRqrOfMTqVeQdzyGDtVChJ9UNz4jxfpR
 Pfksk1fqwpJaDqgiQeA==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=2V6DY6BgAAAA:8
 a=njUzwRyDVfN587gzVRIA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-GUID: L89GWLr-Qh3S62_PH7LpEya7xZEUaTZZ
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18892

The invocation of str.format() supplied an extra parameter that
was not being referenced in the string.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d23582dd..a52a95b8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1093,7 +1093,7 @@ def main():
             list_configs(all_settings, args)
             return
 
-        logger.info('Bitbake-setup is using {} as top directory.'.format(top_dir, global_settings_path(args)))
+        logger.info('Bitbake-setup is using {} as top directory.'.format(top_dir))
 
         if args.func == init_config:
             init_config(top_dir, all_settings, args)
-- 
2.49.0


