Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABAC43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 02:03:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.401.1783562632367635953
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2026 19:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ice31Q5u;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1650fcb189=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6691gLpk1094724
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Jul 2026 02:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=AZTiky86Z+eBzZm0o308JQTYJsvZJg8zjjs4nNOyU6Y=; b=
	ice31Q5umIruDsHQqd0DDgcONg289o6bYlzaiEYo4/zT11QlC6VqFMLr/4Bwqs9V
	mxlJ/FhkjCUjmFBkfVGaZ3xq0fHr7Tpt50E69k1KqKiFOvLlCUnS4IcT3Vy8k/xq
	+MOf6sRQDVfkEspiqRHQKkWpSBeWi32hyT9BJWbg0O1Wx7vFyk0vUvOZNTMnaXnC
	yHY4BoCHvxXkuW7H6XaGxVHDWU7vmPTSgaYHe9QqBjAU7inkdpxvwgmcXHbm42Cz
	Szl2xELL5lbTRPTdVOWtwPyc8xaDg8zvFIXkDm9etxAJK4PhXgyKZoIPlREPat84
	rN9yoTnIX2KYx/q9fmIH0w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1h202nm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:51 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 8 Jul 2026 19:03:48 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 8 Jul 2026 19:03:48 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 8 Jul 2026 19:03:36 -0700
Subject: [PATCH v5 4/9] gitignore: Ignore temporary staging directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260708-add-pypi-v10-v5-4-7d5f457f4b9c@windriver.com>
References: <20260708-add-pypi-v10-v5-0-7d5f457f4b9c@windriver.com>
In-Reply-To: <20260708-add-pypi-v10-v5-0-7d5f457f4b9c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a4f0187 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=kZMSq-wbSamDtaQhZQkA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfX8o48IdOaVYpm
 CM98KTjOimBo/7x8Le5u7gXnMiU5gbQ4VXGVig6YtWvoqiM64GmUm1NSQLon06X4eEMUwqDpBxJ
 mLnd3NIBVNUpi+9bJQJG1UxSMCyxCwLtH5dtYN+4dhxZ85blQEG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfX1JN5NRfbknJs
 UbyH/e0gDiO2lKBgWPeA1AwNMa/6ma5rTIJQgzyzYJWqvtfHaVW/iVbYUYaWVc8l2kvxdeJlJiu
 2AWTscBSMQa5Lc7P4p3PjpR3yJDkAwwT7rcK5/j2IgICfBc5yF6Ra78Aptf5eJBq7YKVpJ8jFKQ
 G/MJNjPf/W0Z3npDIIsJgJVah/+Hx+KYXMH4maD0FlUOY9uKZwde3u9xQmb2LoaFAPCydbQDrSG
 6mwoUG9eOqZVgzy6fQYYLHUSO6Uuier/HTtcHuvgRbSEYm1H4Uucca/6GZrEQPlqI2FHHFujw76
 rDuG2FhNjV4WHbvuGQkNckssLVbfl/9R8522tKSJZf0hNOzBicCqbWpvYP0kFk2XHU6HBB983pW
 /kO5KuyYEW2qp6aviDaOqZFHbo8jbWUhKnMJcaugiyw8qav3yFVcLzs5j5F6+VXnvv94niQKBES
 uDU+S7rbc3tGIAX7IpA==
X-Proofpoint-ORIG-GUID: vv4MHS5ytFFY-D6Djd8C2462GEM9eiV_
X-Proofpoint-GUID: vv4MHS5ytFFY-D6Djd8C2462GEM9eiV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19825

This directory gets created automatically by package-bitbake-setup.py
when packaging bitbake-setup for PyPI.

It is a temporary staging directory and should not be added to git.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a6a256b2c..23cb96881 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
 lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
+packaging-workspace/

-- 
2.49.0


