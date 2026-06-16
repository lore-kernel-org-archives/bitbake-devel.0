Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E18DCD98EC
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1755.1781645507085556707
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HldqHRPl;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVM0d495812
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=rruTfr2PyUMiN4KrGgwauqabR3iINi+UDhbs6HKTTrA=; b=
	HldqHRPlujtl6Vvk8I2XBnn265mqtOxhu/BJf6+3MaKUcVOJf41DsItVGSBg449O
	Mn57z0hvFyTlSRtzF/WPze+PYG8Zq18KPnRJbFuH38fgsYj6EG0DEOJOM2IKv54U
	MQI5+/EMzTlEnYe6fnMwQ1hVW4TbWGow2L5mj3vQHpeMzATBTNgdNLHtpN0V5on6
	pXkP7Ur0TlSJ7I9APmY1eRaFb9xti+H/QX45FN3z60yrlnX+tCg85u1tlyTDeg9b
	j5U89xhRrqjh5/hLzR0pGKXI1oP4xDJueSjq3AVmn8w7ApwUjr7coljbdCHM7axe
	dWYSXTdvcT3CbXRJeZROEA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft0012-3
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
Date: Tue, 16 Jun 2026 14:31:24 -0700
Subject: [PATCH v3 04/10] bitbake-setup: Add version option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-4-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: rOlAknSjZni1LYJhSCpLp8NlQM14kjM3
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a31c0c2 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=3MZ2cW2_6ngPcrpQ0mEA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: rOlAknSjZni1LYJhSCpLp8NlQM14kjM3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX/S9hgMcPQdpY
 FOI1G0DyABL+8DtGTIl8ewn7LGoadm/KZRnXp3y2A6SmK+BWvRrOXORP/KRhpgYLgo66spv0RPL
 4Yby3u0Bhe8BGdivhFyawLg6W2TpXA1PqD86Q034lvF5RbRe59EL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX2DPmSG5nnQsP
 CU/9fl68fVCVX/ZaWGeLvToPCXIBI/oQCSava4JpRWU4O5+UFX6jJVNXvUyIsGbV59cQbDJ3jJY
 Sz0LIPC8CIcruWOx3REt9FtYWUN0Jv3Bsl4SfpNdx2OmzDUVogvIMhOeX5/TwJg7yzzsQnkhpxH
 WkdWfvgO+D8QFv44ESHblEEy+y/Nbwt4oD2Lc5HEXIa2cnZ4aSRwPEYXI25gJbfsJHVSvIY6ES0
 4ck7bQaaEPpSFsNBBuZ97EhAZBpeBuiM1REdBn4ETDmC4sCRFI/2CBDVUk9sZV7C1MhzYs1zEFG
 YoM65Bkmznp9wQ+9cuHZKVkUvmwHXLakwgBLBa8hAseg3z/8GZZmL0IamOd9gazGxDR8X2JG5DK
 WQckFM/sO4wLW3fJi/RnC9DgYv4eewVzzIm98WYqitRKiYCkPJIxXeNchQREhnIoa9Y9iqZhl0V
 vKuLsRP28H+7BAar90w==
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19714

This adds the long-form version option to match bitbake.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ed9b0947..8218a500 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1267,6 +1267,7 @@ def main():
         )
     parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
     parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
+    parser.add_argument('--version', action='version', version='%(prog)s ' + __version__)
     parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
     parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
     parser.add_argument('--global-settings', action='store', metavar='PATH', help='Path to the global settings file.')

-- 
2.49.0


