Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070BCFD315
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 07:35:07 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12184.1764056097635598479
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 23:34:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=h39esurK;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34243e2576=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP5aS6p3519348
	for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 23:34:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=Wmw28TVaXRrUFnJRyxkW
	LR961pSyNZMCSwzsX0GL/XU=; b=h39esurKG/XoAf2WNsF0RfeKxNJSM2dMwGPZ
	4FrWItZS+r9M1XZM0KvM3fKjtniFBSpRNJAPeP51+1GSQs8ZrdMqYoBHpmmV33Vw
	soOt4NVJ0Hz5XzfxUiom3vCk2zfL67vtsuuiyzbguNh2LGZ9450ol4Ah6o+WBrIg
	SewA61WnJao25upE4916wW3Wkvw8E43scT8QB/Cq3AkyG0Pkes+eGRhvEjx/0TSF
	CHD5NafejItxstaYj93aZz1vdkaI45uRgkuy2Tra5MGoNaDgrBZ5c8A0+8y3mOt2
	paI3Sgx1et7mYNz7IvGH+YwPLZYifOM3hpLziu/HOkNmpXvczw==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak9b5amv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 23:34:57 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 24 Nov 2025 23:34:56 -0800
Received: from pek-lpg-core6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 24 Nov 2025 23:34:55 -0800
From: <changqing.li@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake-setup: Avoid unexpected positional parameter propagation when sourcing scripts
Date: Tue, 25 Nov 2025 15:34:54 +0800
Message-ID: <20251125073454.1282407-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fozRpV4f c=1 sm=1 tr=0 ts=69255c21 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=q66ld7yrh25gMnS-DFMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA2MiBTYWx0ZWRfX8Afqx0SRp99p
 FDTVAUzTSVpsKx2/E5V8hxMPTGxvJkw5gofPwG7W03thd0A1nlCKp426E25lX5nDnJ5j4hhDR6S
 tnxAfKOuygAMOk1oJaeWYfwmedsCxprDbIRPDJMUW+dsf8vE/P8APR4tj3lQIB0CDq1VaSGS/YZ
 KQ5axfC3k6L4yxWcEUZ6mtOt0WQvcqZIv5WjKctRsYDZHOgIs9A3joRF8cDQc0UyXuq5tl4V5eK
 NpQEC9dhQmviMMbmZVrKule1yRMmGBLJKGy8KuPCUlvSUDj3dVMs8Q/1h6AlKMsKmJju2dMS826
 6ksPWWYhuEiCJ36aFCIPgIi2IY6jmnkrgKOXKMuvD4ysJQt88clESaAvtq+f7iQc2jKrig3LBgl
 zC1QjNjbwm5XtdJ1/Hs/nUNcNUFABA==
X-Proofpoint-GUID: yUw077lCHp1jumrhHKXN83HZa6DKPpXZ
X-Proofpoint-ORIG-GUID: yUw077lCHp1jumrhHKXN83HZa6DKPpXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250062
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 07:35:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18487

From: Changqing Li <changqing.li@windriver.com>

Using `set` to define positional parameters in the current shell causes
those parameters to persist. When another script is sourced in the same
shell without explicit arguments, it unexpectedly inherits these
positional parameters. This change prevents such unintended propagation.

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 75be90940..7f77bda55 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -184,7 +184,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
     def _make_init_build_env(builddir, oeinitbuildenvdir):
         builddir = os.path.realpath(builddir)
-        cmd = "cd {}\nset {}\n. ./oe-init-build-env\n".format(oeinitbuildenvdir, builddir)
+        cmd = "cd {}\n. ./oe-init-build-env {}\n".format(oeinitbuildenvdir, builddir)
         initbuild_in_builddir = os.path.join(builddir, 'init-build-env')
 
         with open(initbuild_in_builddir, 'w') as f:
-- 
2.34.1


