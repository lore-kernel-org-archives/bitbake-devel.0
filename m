Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB5ECD98F1
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1853.1781645507433149826
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=r01HiSvr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVM0e495812
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=RNJj7MsXb0gMdxwiqLzb11JhauFrQZdxjJ+wsTBuen4=; b=
	r01HiSvrgV7B+rayK9ApBejOh6S/0/BdT4vTGPANyEg81UUYVhMkt2gQjljtUNZL
	jwqdcPXHHGUo79NKLfUf7h9l511pVAdxZdnoRl8Unraj8fqDIadnl68+iB1oguwC
	eHEYx/xpIscdGpKadzg2rgiqlV53FlBWx3jsRBIITRydX/eQnYOYuCF+rSrcizBf
	3pMlBFY01GP+i3kVsxDYiRoN0BCBoJkmJrPGWj9ik1ddODabTOmPJdgCHWJUNyTf
	oaxkCjnK5p9Vmf9s9mYCWfImrldfwyX9VSG8sKGhU70DRYC5dVakb6cl2s9NvVoL
	Nld2VF423STU9k6tuDQdIQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft0012-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:46 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 14:31:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 14:31:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Tue, 16 Jun 2026 14:31:25 -0700
Subject: [PATCH v3 05/10] bitbake-setup: Add version check and catch
 exceptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-5-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: GR7KJ9zaO03B4RtRBEtucJBuIbvmxs4A
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a31c0c2 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=W72ytIibgHKM_pL8n_YA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: GR7KJ9zaO03B4RtRBEtucJBuIbvmxs4A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfXyF1VTW85D0Yy
 zDRSmGnPuP4azjYwehWMce/iPw+Z3Ygkk+sh8VVatbq0SAjsxdtj9c0QtUXddT3yla8zbJWnU90
 HqiTdhkb0jQjSlHVnaB+f5c/xPjM3Mej9CqNRAcSav7tbh8ucDCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX2JE3Q+PGJNgG
 9HReT8SGYFI3i4OqEPB3BWnNO2Oeb3bknp8CBCeF1oz28l9z1cvWWg/mJu+kULIpB2gVVcgymCC
 Ug1PiZ4CCX0oWmhWTSdj9rnJrWi+j/YXssl7fR9davpYaQUs4udkDezUulmyZ5Wrr9uVBSkevmt
 PaaiuKCIx85ZwtwxilVstYt+rnKHx9sbNifMr9Jc5wf4+7B48NaKPVyD6H8brl2jsPOwjB5Jt5d
 wAwUWhdZ0KYkIILV4VgL9O0OXDp7y98+ndEsYCsHZa395oEQ8ZrGmjs5ZgmhuhlJv7n8+blk+OK
 cIONdV65i6Zr4mjqYTdD9onzu1CatFGvFCYezUi9jxFT+jwFqEDPkAW5E7bCn6gi3ZQ9WUZeUwB
 nwHJ9OhXXK264FMVPeGbfdp3nGvbxsUltaQSAQf0UcuJMH4IuxisDf76r/L3zsZmjRECLq/vP7/
 rFoqZzyfrPI5b5juTwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606160218
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 21:31:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19718

This modifies the conditional script stanza to match bitbake.

It adds a version check to ensure that the correct bb module
version has been found.  It also catches any exceptions thrown
during execution.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 8218a500..af70d0cd 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1408,4 +1408,11 @@ def main():
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
2.49.0


