Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE1ECD98F2
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1852.1781645506802785077
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=f/03QdJk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVM0c495812
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/P9l0UZAoehUJtn6+jkWXhFf8pVNmgOPA/7kWBuoaRA=; b=
	f/03QdJkokTgt2u6En0xd/629EwbB7AvqkBSfJseSieGxt3yDeo2TgJis2EEZ87g
	23AZhc8s4r4kak4CfViLJsHWy4g0prWKW4AvupRp5me5DUOqjxL5aboh549qkRHX
	ICjTlbg/gvqBug4lGXrupuhbzSettqUcxiSpvSZLVli/t+ApXhw240T/8AYXu0cy
	uqj2e/azddUWLKeKhRSG/EbiVa2Nk8w7Yrxq2fHFIPHKsday4MqhaG97A60OcQv7
	l+BTNHUL2Y2SjkhF5CkHOtcJzBlO1UZ6j7Czl8oVQzsyLDVu+pJtvr0N6dTqj1qn
	KiPj9NcRPjCJSHvzJELwPg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft0012-2
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
Date: Tue, 16 Jun 2026 14:31:23 -0700
Subject: [PATCH v3 03/10] bitbake-setup: Add checks for version information
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-3-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: 35x31McTRYAny2X9nCLqnQWny2GaClkU
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a31c0c2 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=vUYKkVZVldypNouynCYA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 35x31McTRYAny2X9nCLqnQWny2GaClkU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX4T0JFYv14Fgt
 NMb01BECF4wvAHKwf38UnKRCulXyDaeJ5f+5gaG4x7g/oI1e4al811N+hXGf4Mfu8+wnvigWkp6
 bgNIgxYoL+NCVQYv6mjPYuXVXyW7OWDGMzBK4xnjXpN7cnWH2AIR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfXz41ltEFtWwgq
 rbAHnM1Z0g8iy4ClCIFvhMcRn0Fz7lJoaxquk0KUPbD4DiwIvOPr3FFj9Y3o8MGXngvqteCKsIh
 14+Xt9VwLXHBcP1SwQ8mE9qLfO38s9alTWdFE0t4Wk+WK/DolkEgcbk3OhiRZemqAOOGaHCYUDH
 xv6ycu0rNc0xSo64cAfpUs9at5aaR9/afpUGTLSib/Yhx/66+Ew3FuCag3cY5BPbAMY2NUpV4hP
 g0iExJYy7YvaaliQGTFgkmvxGxlw2+aZhHZQD1Ahw25ooVBNcg20DkaxhafFS/mSQ1zzC3weXeD
 YgJ5GZXW41PRGpFYs5m158gqQkDtWvFuX0NCmq+rfzMUBKVp22SyxYjn52wxoYOC8oP99D5rCwi
 KBadWVQSmqzTxf5O3NoXNpIUmcnpT0gyy+7NLkI7oGUMszTfTbMno/WP50XMY2a/8vKplSI3J8n
 jcxx6JLcKXNzJ+XdPpA==
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
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 21:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19716

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
index 664bffee..ed9b0947 100755
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


