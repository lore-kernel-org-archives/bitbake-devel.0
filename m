Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C03010AB80A
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55636.1774551471036927566
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TDt0irRC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcR3113430;
	Thu, 26 Mar 2026 18:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=j0+mM2JIY7mpbMRrlJ7ugz6+615lj2yVrQmOSks+Mhc=; b=
	TDt0irRC/1aiOHnVbbYeDkORMp5DRB2/MDe4gtjq/chNrOiwLPkYUMt4G8YkToUX
	E60pcLQfIRU2LWPNhlm4DI6CPvw2ZLCiUKKd2P0uCyHC8BPZMpQePpNtdRzf76t7
	cX0qtsGDZA8+b4XNIRLuvZLDKZCiJDZafRSFXQ5wlkRf2r3zuMZYo/MTvaBnxIk2
	/fy1mvb462vAmPPHP/nIE9UYKZvuuFF4dbtqIBOwIOrzd2EG1txjt1dE+vF8IoOo
	HQe4Q5qMG2D+ZWsN0lbIrnQIkZmLxp4XuW49yAK5j0fvGq9Ej2plhs1qVnvUJfxx
	dYI5Xg+KUrynZD8f6Si8ug==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:48 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 09/11] bitbake-setup: Maintain exception chain
Date: Thu, 26 Mar 2026 11:57:40 -0700
Message-ID: <20260326185742.542268-10-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4OsJpotFAIz3X3kl0iQoCox0lqgC4P20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX44JnIfPux/WN
 3SFdYhflRSwpPlTvm6L19ervFn+0duKLbNu+Eb/Bx3zRmXZCJihdF5LFeplItmKZ6g5wzT14Js7
 +isSp9t9jk2bpVQAQbRpSYQ5IiqqIrcHYCcnOjYUZilHAABgmFQ/6EmLV1jtUj4x3jAoV5BsNCB
 HPkx34bwfqEu58CE57PER+x5D2YMGl38BzEI/HDi5Ah2PLtpOtXloJNPUQjFFn4S9Dq0BU4tPQt
 zTWv7Js8cWBwq/dqX+k8iuspD7IVHwTQrJiONCDxCE+nCALDDPfoQz1t92wSRkvYk3f2ztq/TJS
 CFm/AJ5ztuS0jm63rkl2U1u+WqSthEZ3Kl6BG6yV7tqg9K77bqlKuESWxn8H8Og2xpt23KlskF6
 VzNMwLjix/JY9AHKj6w79k0XEu1GhC+vX3P0FCrwJEguHiSNDmW55IwUhPwLtOgq9BcrFZfbmXj
 koKaEavjSaMzux5nBgw==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581ac cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=2V6DY6BgAAAA:8
 a=buMr81B6g3mRPbPPW0sA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-GUID: 4OsJpotFAIz3X3kl0iQoCox0lqgC4P20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260136
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 18:57:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19254

Chain the exceptions so that it is easier to trace the exception
back to its root cause.  This resolves B904 linting issues from
flake8-bugbear.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index e2b2f1836..2e1e347d6 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -579,7 +579,7 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
                     json_data = json.load(f)
                 upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json_data}
             except json.JSONDecodeError as e:
-                raise Exception ("Invalid JSON from {}. Are you pointing to an HTML page? {}".format(config_id, e))
+                raise Exception ("Invalid JSON from {}. Are you pointing to an HTML page? {}".format(config_id, e)) from e
         else:
             logger.info("Looking up config {} in configuration registry".format(config_id))
             registry_path = update_registry(registry, cache_dir(top_dir), d)
-- 
2.39.5


