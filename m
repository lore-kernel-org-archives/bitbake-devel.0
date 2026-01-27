Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A86D340A2
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15121.1769529918891983106
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=SxKwrqDG;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZK880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=634tE9Sw/VsMgBpiWvlM4anjAnGOT8xug5Gj3kXg3oQ=; b=SxKwrqDGYtxz
	kA5SPhkm4cocosOOlZGMGRgyRxxkrscW59S25+y6u6uX+/bAoL+NySG5KDmlQ7NK
	Y9I2yILwfS4WocPXtO3KJXHWDXf/66Y7sg30bf460xgZhUlRYfj7U+yxPm1ipnS1
	9CMYqMgMiR+rpVDPNVg9Lkc0jGbsTbkit/lKn6RsD9tcAfyVVt7GnGfImZEzOUro
	ZxBCoBBYob3RgQv7/o7akTVk5sxGPk8oc/KaJqYiYNrcssRz5QYZDGRzFEFm/qpC
	axs65msonOGnaUogrHYH2vqCpf4GLzvXZGCs+wbdu1u6BwsXn5JKnD8Bj09Vgyds
	r5zK6t96Gw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:18 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:15 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:15 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake-setup: Remove unused parser_settings_list
Date: Tue, 27 Jan 2026 08:05:08 -0800
Message-ID: <20260127160508.3392732-12-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XwA7NukIPS4eRG1tZxt_vdUDphER41Kx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfXzVmRuElGcOMC
 Qj6426SMPPKPaSBwJB0JXdcpld3rRbI8BGp82PxF9Xtjj61xWFP7hMXYnbW/nuOcw0tFqbhn78x
 F/aFUQbfuDpM5be7blJwS46nf/nefoEQQVK2j36JYaXxY/yGhnKzgaan01i8JvNHE7wkz2wS+u9
 OyPOR6FHdKWqq/lQYifBmgwfZwcHe33ctPhC1N0fSGVduBK+DvAm0VxZ207X9sDX6945Ne3EW91
 h9MsAfzWsZ255aGBpU1gNk8qbvFO5VYPoAUGYKN61ySDlYA3hzYv6tmE7yZk44NhISxz7ph1fyL
 T1T42LnuqcUnM9xLxwPc2b2KgBh4Dw1uC0xQ6Ec8/mjSHVl1yPqthUUcIbOE+TREOAx9c8UPC38
 ilvdzWKWdLJT1saKlWFB9fPGMYPpyIil0gdUKWU23W5rKt815/W3fR2T9Cjyj6Q9XIfhYjIWQtF
 bteohc+kp5Y50ZYAbcA==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=RdzD27zFivnYBFE9EGsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: XwA7NukIPS4eRG1tZxt_vdUDphER41Kx
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18900

The ruff lint tool detected an used variable:

    F841 Local variable `parser_settings_list` is assigned to but never used

The list_settings function  gets invoked through the parent command's
settings_func function. This means that creating this variable is
unnecessary.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a67c10af..7eedf221 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1026,8 +1026,7 @@ def main():
 
     subparser_settings = parser_settings.add_subparsers(dest="subcommand", required=True, help="The action to perform on the settings file")
 
-    parser_settings_list = subparser_settings.add_parser('list',
-                                                         help="List all settings with their values")
+    subparser_settings.add_parser('list', help="List all settings with their values")
 
     parser_settings_set = subparser_settings.add_parser('set', parents=[parser_settings_arg_global],
                                                         help="In a Section, set a setting to a certain value")
-- 
2.49.0


