Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA272C369AB
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 21:01:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.37228.1744405308977968236
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Apr 2025 14:01:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6196f37709=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIGwRl028658
	for <bitbake-devel@lists.openembedded.org>; Fri, 11 Apr 2025 14:01:48 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45u41m88sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 11 Apr 2025 14:01:48 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 11 Apr 2025 14:01:47 -0700
Received: from YOW-MASSELST-L1.corp.ad.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 11 Apr 2025 14:01:47 -0700
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] utils: lock_timeout_nocheck() ensure `l` is initialized
Date: Fri, 11 Apr 2025 17:01:46 -0400
Message-ID: <20250411210146.6741-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: H857Eq9xX4kpnqhnp_tM9ck3uH6PvF_U
X-Proofpoint-ORIG-GUID: H857Eq9xX4kpnqhnp_tM9ck3uH6PvF_U
X-Authority-Analysis: v=2.4 cv=QOZoRhLL c=1 sm=1 tr=0 ts=67f9833c cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=3jmanMmXoJMmyqvRNCgA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=785 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110135
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Apr 2025 21:01:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17529

lock_timeout_nocheck() can be interrupted immediately after enterring
the try-block and prior to initializing 'l', for example with a
ctrl-C, the code in finally will still be run and the 'if l' will
fail. Initialize 'l' as False to avoid this possiblity.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 5486f9599..a1e093925 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1898,6 +1898,7 @@ def lock_timeout(lock):
 # A version of lock_timeout without the check that the lock was locked and a shorter timeout
 @contextmanager
 def lock_timeout_nocheck(lock):
+    l = False
     try:
         s = signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signals())
         l = lock.acquire(timeout=10)
-- 
2.39.5


