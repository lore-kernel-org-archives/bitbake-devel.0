Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275610A88F1
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 17:39:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53620.1774546795203407638
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 10:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=YCllgk0e;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRYY3113430;
	Thu, 26 Mar 2026 17:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=eQt4eY8IPExcGucft0zFhnk8MMBhUD1afSI7NduY89A=; b=
	YCllgk0eRc7C1JgHVzp2rfn2CWby9KYrV/Xq8gjfO2Ce4xypXjLmaO5UewB0dNS8
	DAgIAXc0zkMRatW9al8mGF4q4Cmy39MaJGlzljYd06P8p6kM8ZYjfYthMlhonN2k
	q0PGDx7Cz7TauEDQ3CgaLpe7qoPN/T7h7Ta01EqIwlzWxA/m45OsmtjVDkD+r7+U
	K+xD1iTtS52YnbnYPob8zyLzRoR3FpDCzD4bQ36FPYWtj6C1U8YRBBxtaKLsS89H
	Ltbxdx5to0CmWxPOOUZmCFXpHuz81iufk1GoHCCUhVg9rhryntEHJjhbi2DAmyoa
	vsN4q4nVQK21fIReqpmHrA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj86y45-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 17:39:53 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 10:39:52 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 10:39:52 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>, <richard.purdie@linuxfoundation.org>
Subject: [PATCH 1/4] bin: Move version information to common file
Date: Thu, 26 Mar 2026 10:39:48 -0700
Message-ID: <20260326173951.519326-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326173951.519326-1-rob.woolley@windriver.com>
References: <20260326173951.519326-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ILYaVkmwKDXxPOoAKYc8MYSwnTkIXQAq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNiBTYWx0ZWRfX4kV2lZSPw+Uk
 GhgVP+cIQYUgq06fbnRS5fuc6k5CxqGMjuUiL82vz2BM6jaI/w50Nt8L+bwrrWGTV7pxGorz+7R
 OQ1BptTSzaz+DXpPYyHz/1xQyU/6na7o4rwLCZ+8QUjm1s5gQgvJ7YpB4gyMwexZWrYjGx/PuMM
 BGUYQkOuytkg4PxgZVIrR3+78xKZNv3PzxulDF9maRs1nknjt92MC+Dw98VDoMZQgstywejpBPC
 HYZsQlhcphsmYt3U0pPkDMdSTIX/8RTKXOv3wPddO+rJwKjFgISKTLD8Az1O61tf169odHAmhoc
 3AeJQEp9Bdsn5X26yshUats6uPj0ghk3IZgZgg6IsjzwXWh+MlW74q6CsXU3rdv6lZKrgS0TbuB
 16gP+ZqcCo2zx3YMKafbIAiuADgjuuQnDLKQR1AVwIQIrVV62gQRxUfT/ukuNiR8Arzcj9DxhMa
 1fJ7tNrd7eVCs7Kkm4w==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c56f69 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=u-5W2QJJIwHLmcSTUp8A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ILYaVkmwKDXxPOoAKYc8MYSwnTkIXQAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260126
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 17:39:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19241

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake       | 5 +++--
 bin/bitbake-setup | 2 ++
 bin/version.py    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)
 create mode 100644 bin/version.py

diff --git a/bin/bitbake b/bin/bitbake
index a995bd665..f838593e7 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -13,6 +13,9 @@
 import os
 import sys
 import warnings
+
+from version import REQUIRED_BBVERSION as __version__
+
 warnings.simplefilter("default")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
@@ -27,8 +30,6 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.16.0"
-
 if __name__ == "__main__":
     if __version__ != bb.__version__:
         sys.exit("Bitbake core version and program version mismatch!")
diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index dcad9c169..1ea41853b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -21,6 +21,8 @@ import signal
 import functools
 import string
 
+from version import REQUIRED_BBVERSION as __version__
+
 bindir = os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
 
diff --git a/bin/version.py b/bin/version.py
new file mode 100644
index 000000000..1e2d585d7
--- /dev/null
+++ b/bin/version.py
@@ -0,0 +1 @@
+REQUIRED_BBVERSION = "2.16.0"
\ No newline at end of file
-- 
2.39.5


