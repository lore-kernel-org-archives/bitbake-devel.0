Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D986F109B481
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 14:53:32 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22395.1774968802517063218
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 07:53:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=OT38e88B;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V4w3D5274792;
	Tue, 31 Mar 2026 14:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=TzLa0LE4e
	7yF5Yu5bCxHRppRhQ6PvBN0LB+U/Gbsazw=; b=OT38e88Bo8wufgg5p3PnZPyt5
	4NymDX9DL71tgf3v4JzthMmmeQ7ZobcaEhZOr356DjK9Jjx8CzLfCgHAgmGY++M9
	Z2cG9U3pQvUfJr8AXEQ1bVHGJbi5313+WOF7stlpMKeMpXoUYJH5YpYpHJzBnorb
	emho8aWaJD7WGRh6Za71b/rpk9iJRibLHw/cPvy0gMmadjaocooBASolzBDwwRUJ
	Ouh7cEmJTjdaZNQGRieAqzkx2XLpFzSnpD+hcqzfL44kZARkLYyRXm7rWyocoRGC
	9v++NghfzjlS8GndT6tjdhUZ24n6YAZhYpujlLev7by3ipOG1rCsomjylKGtg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4btqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 14:53:20 +0000 (GMT)
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
Subject: bitbake-setup PyPI Packaging
Date: Tue, 31 Mar 2026 07:53:13 -0700
Message-ID: <20260331145319.3125456-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbdfe0 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=NEAV23lmAAAA:8 a=Q4-j1AaZAAAA:8
 a=K_1DeRggfWye27DRFMsA:9 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0NCBTYWx0ZWRfXzV5B2un0ylR2
 6mBgTSfyYnL/0TEugMTu8oxtCQmOiNpOx38TOIIdLRYZnN+971Odin/f6eVzfRumPdL7AOB6D4K
 Tpm84KO9zGYjltlEbrfBX/kaTj1dJIYvs3zYTLsP6pnipbTXYoxoSrUO6Mk63vKj+5B80YgdSG1
 pD6T0wQqNQYADW36Ttz3kXEV3qiXlh6fzwyI8rybBJW+NdpGcyCBiCSGlqtuCgAyjyNxxh90gF7
 5iI/rgMKHlyTeuACkMYRasGBaLFVkoQK+6usHxChGkfym8BfegA13ad/ZQAzOnyys1Owf3ebipw
 uyHodNYP2SId3hC1dWUllh0aV6Szf4K3zv8AXrQZKA9xa0gUMgFt3pYku2XFppg7ivzUAF6nAvH
 u5KxZ30fy0T/GPijxRGSSR6N0iA19tESk+w2kQi48EDZZ9wgmWeycozuBTgbRshRbXBK4s7VjUz
 5EWA1hK7AgfsWU39IyA==
X-Proofpoint-GUID: 42dxIABvJBpiLyGBCEyth2Lqe7XnpiB5
X-Proofpoint-ORIG-GUID: 42dxIABvJBpiLyGBCEyth2Lqe7XnpiB5
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
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 14:53:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19292

This is a new series to add PyPI packaging for bitbake-setup.  It is based on
my development branch here: https://github.com/robwoolley/bitbake/tree/add-pypi-v6

It assumes that the previous linting fixes have been applied but they shouldn't
affect the functionality or context.

The main challenge has been to package bitbake-setup independently from the
rest of bitbake.  This necessitates creating a separate staging directory
with pyproject.toml at the root.  Details are in the commit messages.

I have tested using these changes to package all of bitbake to make sure that
these changes didn't inhibit that from working. That is beyond the scope of
work for what I was trying to do.

There are 2 challenges I had to overcome:

1. Ensuring that all primary workflows worked:
   (a) Running bitbake and bitbake-setup directly from git
   (b) Allowing developers to use pip install -e . to develop in-tree
   (c) Enabling pip install in virtual environments and at the system-level

2. Historically,  he sys.path modificiations made it easy to refer to the
   vendorized modules without worrying about system-wide package conflicts.
   Adding packaging support required that the modules be properly
   vendorized so they didn't conflict with the upstream packages.
   Vendorizing the bb module resulted in too much churn as we import bb
   and its sub-modules across all the files in lib/bb/*
   Given that the bb package on PyPI is obscure and hasn't been updated in
   a very long time, I chose to bundle bb instead of vendorize it.


Here are the detailed testing steps that I used to verify this series before
submitting it to bitbake-devel:

$ python3 -m venv venv

$ source venv/bin/activate

$ pip install build

$ BB_SKIP_PYPI_TESTS=no bin/bitbake-selftest -v bb.tests.setup.PyPIPackagingTest

bb.tests.setup.PyPIPackagingTest
test_console_script_help (bb.tests.setup.PyPIPackagingTest)
Verify bitbake-setup --help runs successfully. ... ok
test_console_script_list (bb.tests.setup.PyPIPackagingTest)
Verify bitbake-setup list runs successfully. ... ok
test_entry_points (bb.tests.setup.PyPIPackagingTest)
Verify console script entry points are correctly defined. ... ok
test_imports (bb.tests.setup.PyPIPackagingTest)
Verify all expected modules can be imported from installed package. ... ok
test_package_metadata (bb.tests.setup.PyPIPackagingTest)
Verify package metadata is correctly set. ... ok
test_vendored_dependencies (bb.tests.setup.PyPIPackagingTest)
Verify vendored dependencies (bs4, ply, progressbar, simplediff) are not bundled in package. ... ok
test_version_from_wheel (bb.tests.setup.PyPIPackagingTest)
Verify version is set correctly (not fallback 0.0.0 unless expected). ... ok
test_wheel_metadata_file (bb.tests.setup.PyPIPackagingTest)
Verify wheel METADATA file contains required fields. ... ok

----------------------------------------------------------------------
Ran 8 tests in 18.014s

OK

$ contrib/pypi/package-bitbake-setup.py

$ cd packaging_workspace/

$ pip install -e .

$ which bitbake-setup
/ala-lpggp31/rwoolley/bitbake-testing/bitbake/venv/bin/bitbake-setup

$ bitbake-setup --version
bitbake-setup 2.16.0

$ bitbake-setup list
NOTE: Fetching configuration registry
    git://git.openembedded.org/bitbake;protocol=https;branch=master;rev=master
into
    /tmp/bitbake-setup-list-v1m6p7s3/.bitbake-setup-cache/configurations
Available configurations:
oe-nodistro-master      OpenEmbedded - 'nodistro' basic configuration
oe-nodistro-whinlatter  OpenEmbedded - 'nodistro' basic configuration, release 5.3 'whinlatter' (supported until 2026-05-31)
poky-master     Poky - The Yocto Project testing distribution configurations and hardware test platforms
poky-whinlatter Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 5.3 'whinlatter' (supported until 2026-05-31)

Run 'init' with one of the above configuration identifiers to set up a build.

$ pip uninstall bitbake-setup

$ python3 -m build

$ pip install dist/bitbake_setup-2.16.0-py3-none-any.whl
Processing ./dist/bitbake_setup-2.16.0-py3-none-any.whl
Installing collected packages: bitbake-setup
Successfully installed bitbake-setup-2.16.0

$ cd $(mktemp -d)

$ bitbake-setup init

... 

The bitbake configuration files (local.conf, bblayers.conf and more) can be found in
    /tmp/tmp.s1MXZQ5XiF/bitbake-builds/poky-whinlatter/build/conf

