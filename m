Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E25CD98EF
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1854.1781645507888085761
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sbyYlu7/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVM0f495812
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fFczLCRY/R8Q3U7cIms2RnJ/3UvUkzOIBq2lR9RiRkw=; b=
	sbyYlu7/KQ7PmTK5i47mOkl7qOOBEzcL+F2R0QPwBdS99/2DQjwbSGpjZ5I9HOHs
	jwypoc5RUpE7BdKBtHAzeNt+QJ6dYerA5wywy4cnl7GhcggppLl/im5G6PEVGRps
	b6qqv8/wj/887ioJdZ1gvf8ZG4ITsyhS+acSYnzzOSzgV8gUQFQHeyT34+t3Zdwl
	LPsutaKYe2NpMtdoq9E3NIyPyRjbjGQIgWQX3JiDgs6ycWTxoG0bcFbZYGCZ+W4P
	idS9CZYUqxO5PZOE9jT9SpXX5tHH87kiHqDN+J6MQHqsDG9LG534hj22y8vjezKy
	Tv4/H3BzN98/HQKeGcSS/g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft0012-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:47 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 14:31:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 14:31:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Tue, 16 Jun 2026 14:31:26 -0700
Subject: [PATCH v3 06/10] bitbake: Add checks for importing bb module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-6-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: 9c0WLOXyXvaPhr8Wd7qokJ6KOM4dvFW0
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a31c0c3 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=vUYKkVZVldypNouynCYA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 9c0WLOXyXvaPhr8Wd7qokJ6KOM4dvFW0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX8DWOd4PwJdhJ
 lIa8VW+6VLH7NlI6FPNfuzkCoRg6s+pL7D2g1xJIewVD/h5+Ea/8SKoZPI9uAg/WAfT1l8Ugmet
 f3zTyg/08tnjN3BfdqHedAT12UqtMsqAa+cvb1t5sh9G+VC15BeX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX0jKhWexPWX4l
 zmbJD6CEj4E9Ujg04DL8/hCpyrweFdsw08+vlcvS4k+q6JEmjIxEvdgTz2DJXfoQtsrvOf7c31f
 t3IfyzNKMUbmO2Qc4pQk4SsEH86Pvcmr/PmXfaRMPMwUIdNzGrPzZU9zY4mps4Fh6/8R9Mz0B8q
 hLyPX5BP0qtcXfqlVAlukTWCg7WDk54nJYoT0L/zGqvf1/b7B0mdxBym82B3Cnlz/DeYCIf27Pk
 va267LtNbvFLp+igel3hadPrOw/+eH8hUVggYfX10V9iHnEBKEduS/wjKPzO1WreHzqI92Du5Mo
 78Y9SVGbqrk4lQkfvrlQko6gydwtPSC6OPh/mSnorA+d3Vu6w+OH2X5T64LX4NUYfqPtlfgPG3y
 7nc0mG/eHnHbmwBFFO/jePyRLiD54+jv+9kYQOp8d25g+zDOGS1Kx6tBnKQy2l66ufi9Jk5p8ex
 KnC90KSfwrSDSGvqh3g==
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19719

The __version__ has been present since bbmake to ensure that the
Python script uses the appropriate bb module. This was necessary
when bbmake had functional code that had to match the bb module.
The code has since been moved into bb/main.py.  The skeleton
code left in bin/bitbake rarely changes save for bumping the
version.

When executed in place, the bitbake script manipulates sys.path
to find the bb module in ../lib. This path is inserted to the
beginning of sys.path and it cannot be overridden. This path is
inserted regardless of whether the bb module is present in the
lib directory.

This adds a check for the existence of the lib/bb/__init__.py file
before inserting the directory to the beginning of sys.path. This
supports bitbake to be executed from inside the git repository.

It deliberately fails in the situation where lib/bb/__init__.py
is missing, but the bb package exists inside a site-package
directory. This situation was previously possible.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index fd5511c6..76ec80d9 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -15,23 +15,27 @@ import sys
 import warnings
 warnings.simplefilter("default")
 
-sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
-                                'lib'))
-try:
-    import bb
-except RuntimeError as exc:
-    sys.exit(str(exc))
+bindir = os.path.abspath(os.path.dirname(__file__))
+libdir = os.path.join(os.path.dirname(bindir), 'lib')
+bbfile = os.path.join(libdir, 'bb', '__init__.py')
+
+if os.path.exists(bbfile):
+    # Execute bitbake in git repository
+    try:
+        sys.path[0:0] = [libdir]
+        import bb
+    except ImportError as e:
+        print(f"Could not import bb from lib: {e}", file=sys.stderr)
+else:
+    print(f"Could not find bb module", file=sys.stderr)
+    sys.exit(1)
 
 from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.19.0"
-
 if __name__ == "__main__":
-    if __version__ != bb.__version__:
-        sys.exit("Bitbake core version and program version mismatch!")
     try:
         sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
                               cookerdata.CookerConfiguration()))

-- 
2.49.0


