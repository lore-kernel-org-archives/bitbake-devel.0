Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79340109B499
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:17 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23969.1774973227671478634
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=QJOfSQD+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5i48C352519;
	Tue, 31 Mar 2026 16:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=i6zLAIr7QoDFSNJB7XaCqRPZDy4J39QeI4iSM7NUko0=; b=
	QJOfSQD+yre0yiDTAxZmj/s8LvXwdT5pCDl3mXQuUWMm1SZG+JJKiE10+vZOtJOM
	NNKRGdRBvt+nSszwgh94taZgCwXc2ToHevSqfpI+zkG5UdmbEnGRXdELP+dIGCJH
	MQ9oYVOuhkH2lpK448bIDnAyu//mgNrZKWLBdsmqycUefWpgLqMC/vF/fcNisfqF
	TxrkdZbYnnHJ+SVQxNxPXD4Z47AAkR4buAnHq8V76s/AFjHJvLzKykMhA+tiIaHQ
	SL9dC9hvUw7hHx0N8dG8BukXFjxLGV6JwW7CpSzDeJ0QcfsSOYULob02ociCx/lp
	VaTAfINxf6nRZOCq7cx/Sw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4bxjb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:06 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:04 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:04 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 03/13] bitbake-setup: Set function default to None
Date: Tue, 31 Mar 2026 09:06:53 -0700
Message-ID: <20260331160703.3137930-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbf12a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=aZRFCHUu4cexEaU8piMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX7xQari/VfSJv
 3MXi/o4xzjs7n5bW26R8+w7L2rfzXbXsOq7DaV2XMi0Z9fHiR5XmG37ETCtnKOhFOapZwvVPie0
 7zP2N6fVGIy58qYvrCmksrChiPFhKPkiUSlLia5y5z1j+SiJZq+P4zLaMJ5PHWekr+J5xGM1MQX
 A7AM8RlNaPAcpGZFdpEfeNOT7EiC4MqP40YFhdMiGDOKM5GElTad9nteimObSMUJIxjqUx7TCX0
 RTU/zJsmt5rcMEJ1iOJ/mJ1qMMbjfGZ+0GyQCOkNwnQByLWCjCwgOy+5XqrJWRDclBy1WvpA1Bc
 aqme54r6x4bqkCYDWYlAVvbKpdZCEnv3nbMNYOO/19PS9MNLifWK1ny3aPBy9nCX4Zh8IeDKiF2
 eEfWpzBiro7OZv4cxRTOr8D3zZaX3ZluzVNthT+xJxsJXLf5HtE2D61GKm0ymis74bdqcsvyY8s
 j2BMYXfTMJSxfiua86Q==
X-Proofpoint-GUID: JbVmb5hfZ7P2oCL-CCQhVzV4-BIzYcfc
X-Proofpoint-ORIG-GUID: JbVmb5hfZ7P2oCL-CCQhVzV4-BIzYcfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19304

The function defaults are evaluated once and use across calls
can lead to unexpected behaviour.

Set the value to none and let the function initialize the value
in the case when the value is not set.

Resolves B006 from flake8-bugbear

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 313962cd4..f90f01f55 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -46,7 +46,7 @@ def color_enabled() -> bool:
 def get_diff_color_param() -> str:
     return "--color=always" if color_enabled() else "--color=never"
 
-def print_configs(prompt: str, choices: list[str], descriptions: list[str] = []):
+def print_configs(prompt: str, choices: list[str], descriptions: list[str] = None):
     """
     Helper function to print a list of choices and align the output.
     Each option name is made bold to stand out, unless color is not enabled in
-- 
2.49.0


