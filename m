Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A76109B49F
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:17 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23971.1774973228312520572
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PdQ0fttZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5i48D352519;
	Tue, 31 Mar 2026 16:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=AvKZqiwd/n6WH/MmsL8NLmWgPhqfFwGkwu4APuWTDew=; b=
	PdQ0fttZ7QRgln/yFTcp+Jo/KvO3N71FgKYf0AE8hRqYDgKtTNhRmcKB8Z+8ryGg
	HS1UbNaAQVfLXFJ/rThEHU0JP5UTGf6CwpaVoXn4LqXxc+TbdYxYN+GqI+qmIvvO
	bD/ERWzt6RYYpm3mKIMTtoE+J2c5wEvjEa9hrFJeljhNVzIBwrKEDjeQzHSmgjy8
	Mwmj39eqXXpkJmzOXc8seQuDAujyZ8f+88O7l0KoW2ThmDUvtPz+p0Xc1cay/dkI
	nuPOomKJEtOe/BSJlImJFjQ7Zak9aRS6LoIdCC1+tHmrflMp168vsxM4HK1u1LLI
	AFu/xoCwZIybqbJ90/sGnw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4bxjb-5
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
Subject: [PATCH v2 04/13] bitbake-setup: Add checks for version information
Date: Tue, 31 Mar 2026 09:06:54 -0700
Message-ID: <20260331160703.3137930-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbf12a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=vUYKkVZVldypNouynCYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX9GaIhEIX428c
 Pqk2f7rRbi6pXQAtUS9BuTIZ9h2S2vqkWGZlFC98Zc4x5GbL+VKTKnEUV4Q9MehFDWLJfMolRJG
 dDGHa5akIliXbtv4aEtGaCIhOM0MLjVkX0+JbjNgggjW8cxa8a+f382wSZuQA7yUZ/m+Z512kV3
 B/lH7LVdwt7jSSYylC5LtJiVzYNA/BE42wZi0hlPShPR+WfrS2Zk0gCPtNuhyBV5svCtQXXpQf4
 G0/dc5rWWooBYomAc8N77zq33W4Kw9/6cZv/8TipQbL2jkccePIE48uFfrEuWpyEpziNUvLnd+g
 eKNHtxt+OFcpIPQfwYsnLPDYRmhBa1Go3IHvnMdmqR1/Sp9hU7WSBwjGcW8GKKDcQWbe6haSHVs
 4wOufOl/J3T3mixM1oGQXDd8BL3ujRv+HQyBzmYkXpSbs1nD//5U13hGSkVipAKF0z6ubdkBFmo
 76086w4FIxDOH5nstzA==
X-Proofpoint-GUID: 4C2EiwcqghJmFtV0KuTrHItML3q2qFKO
X-Proofpoint-ORIG-GUID: 4C2EiwcqghJmFtV0KuTrHItML3q2qFKO
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19306

The __version__ has been present since bbmake to ensure that the
Python script uses the appropriate bb module.  Other bitbake-*
scripts do not check the version.

When executed in place, the bitbake-* scripts manipulate sys.path
to find the bb module in ../lib. This path is inserted to the
beginning of sys.path and it cannot be overridden by any other
modules named bb.

This commit adds a check for ../lib/bb/__init__.py before making
changes to sys.path. It falls back to importing the bitbake_setup
module using a custom bitbake_setup package.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index f90f01f55..073b18f95 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -23,10 +23,33 @@ import time
 
 
 bindir = os.path.abspath(os.path.dirname(__file__))
-sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
+libdir = os.path.join(os.path.dirname(bindir), 'lib')
+bbfile = os.path.join(libdir, 'bb', '__init__.py')
 
-import bb.msg  # noqa: E402
-import bb.process  # noqa: E402
+# Obtain __version__ and import bb
+if os.path.exists(bbfile):
+    # Execute bitbake-setup in git repository
+    try:
+        sys.path[0:0] = [libdir]
+        import bb.msg  # noqa: E402
+        import bb.process  # noqa: E402
+        from bb import __version__  # noqa: E402
+    except ImportError as e:
+        print(f"Could not import bb from lib: {e}")
+else:
+    # Execute bitbake-setup installed with packages
+    try:
+        from importlib.metadata import version, PackageNotFoundError  # noqa:E402
+        try:
+            import bb.msg  # noqa: E402
+            import bb.process  # noqa: E402
+            __version__ = version("bitbake_setup")
+        except ImportError as e:
+            print(f"Could not import bb: {e}")
+        except PackageNotFoundError as e:
+            print(f"Could not find package bb: {e}")
+    except ImportError as e:
+        print(f"Could not import bb from package: {e}")
 
 logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
 
-- 
2.49.0


