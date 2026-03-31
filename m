Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6C109B48B
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 14:53:33 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22396.1774968803439175738
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 07:53:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=O8k4nkbp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V4w3D6274792;
	Tue, 31 Mar 2026 14:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=dYd9AtrqXVzG3kkPmBJJveSdb9jhz/Z9cXLbO2WtMGs=; b=
	O8k4nkbpn/FhxaaBjmaWYfiMRFGg9KZOEZp3gVfkEzIv+A3uDqtl3e0YUg4plS3b
	kYaHn8eV6H2Nt6K29HI/mJfZMqac2/SCIKQv6FEnnKohWixkiznHdUGYJV2VivXC
	Yq7JYJofbVXT0mQIWplvXgN9WCpcsOznECPw4l2OwqebdQFqAPzVmNdIcBi7Zqbj
	Mbu7f63vtwoTxU+Z234bbPSJNiEVv/eXMsZmX7bvmetYCAEHh2gjzgntSyviWT3L
	KO1uNFMx3Zf809uYdi5ioHviz9M3LbcJvpEJqBR4wVE0EWIdCSCfklmVwtud/G7n
	GVM/cWxdcp9xqX7/tkdJ4w==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4btqq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 14:53:21 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 07:53:19 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 07:53:19 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 1/6] bitbake: Add checks for importing bb module
Date: Tue, 31 Mar 2026 07:53:14 -0700
Message-ID: <20260331145319.3125456-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331145319.3125456-1-rob.woolley@windriver.com>
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbdfe1 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=vUYKkVZVldypNouynCYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0NCBTYWx0ZWRfXxcND7J1RD301
 BMCAm7NGnaGsXBvZhPKQ8XRDOmUgBhvGscoG3GI/VecgRVy2JTRzFjhVOVx6vi7mtyQaX72D043
 220mrd0SMlLXGC2qi1RkeRicvV3AaMLSSgWRZlIBRtMVvOVN3HLncyimCy4yrK+pn469I0QTWyE
 p1j0BishUOP/Mk1SasH3l5ssKFjgqRN16+MuNt9fh9THnXWLjCWSEhFuCkmWLvroGIYLU++GJuO
 ycfBjIfyvf8n5UGURBkTBZzoFApEf4ksVlnQX5PZtyDbjwwVRt1V/Fhr3IHLMDtjSgPKy6VdqVU
 WNPeaDJNxDVHS9ixc2B4asD232owEd2/Yz0W+Fsp6AoE9diHj5Jroi5rNGKPt6c5SEiKIlePliS
 Sccxlzo95gpJGtdZuXoPpHMiixU6gahCVTd+4CxLYzLmIlRi0dnAFG2FVDZiEsezpJ790gGtgH0
 KEYDxltk6X4V84tTzLA==
X-Proofpoint-GUID: Chp881F-t2iAqtSQyyqEZxuqzCmOuhYf
X-Proofpoint-ORIG-GUID: Chp881F-t2iAqtSQyyqEZxuqzCmOuhYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310144
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 14:53:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19293

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
index a995bd66..76ec80d9 100755
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
 
-__version__ = "2.16.0"
-
 if __name__ == "__main__":
-    if __version__ != bb.__version__:
-        sys.exit("Bitbake core version and program version mismatch!")
     try:
         sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
                               cookerdata.CookerConfiguration()))
-- 
2.49.0


