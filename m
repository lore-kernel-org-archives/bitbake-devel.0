Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D3CDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12946.1782321618558843982
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=m5Ild14Z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxN2602576;
	Wed, 24 Jun 2026 10:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=eRLag2Xwb
	uolvwEGwB0Q9oIkeq1ROgi5MUg1BrN4lOI=; b=m5Ild14Zq4x7tjtdByPr1/UrS
	yn1/DMUoDReZIvNBBqW1bRstYN104H4shQqAcNAB61c+NlU5kHbHkRpfrytp+RaS
	sqbNHFt6ARbqqgncG6Arr/jLhvNm52AHZvjqQfnHXPSAVmxd66hg/t+N9xeVSkzl
	nSqvz3+ZXc7s7T6ZHROlRMedQWmZfhF/teYVnyszNlS0UqCdfsse6uo4eXIAf4jS
	x6oFDzFPVZFHEEj/K3DOIL48bqKu8ep/ltkHua2QkwnTVEZmiH4WdJXXs7NIM8GY
	hC5eWcGZaX2I9s3zMtj+D8kab6XoFkdyBhDSqMuHHnApMegdq3mjX5QtsHaig==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Jun 2026 10:20:12 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:12 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:12 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Subject: [PATCH v4 00/11] bitbake-setup PyPI Packaging
Date: Wed, 24 Jun 2026 10:20:00 -0700
Message-ID: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMARPGoC/yXMTQ5AMBBA4avIrE1C46dcRSy0HYwFTYsQcXfF8
 lu8d4Enx+Shji5wtLPnZQ7I4gj02M0DIZtgEIkokiKtsDMG7WkZd4myMn2pSOpcCwiFddTz8d2
 a9rff1ER6fRdw3w+ElGzxbwAAAA==
X-Change-ID: 20260619-add-pypi-v8-89df7be8c5c2
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Richard Purdie
	<richard.purdie@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX0SDeuzmwa1sO
 3tbU4Vd1Bx+I+Mg9mc55FMD2tAk2pPg0mx0rIbQqGOVTb4KdoqOM40h0Fyj0yU65etvJEqG+F5y
 OuzM5JTAnwI2LfRU4glpvRHwx681DBmy+J9TuOhQOckaqn/GbXi3/2y0NBH2L0DEPV12kw3mAKp
 Y3gDkm+LcU+bxnlVfstzj9/bBsjx5BTucn7I7VmEkhS3iWxe3PMDhNVJMe9nJSc3Xy9KUMcsY8H
 XWVUvpqpP0E/3F/0qgpue93GZ8dU0nHneH6imvfdzd6zzZY1UwUybRvzkcVDEvM3HHBUyb6El55
 mV5+hAUPS5/hodsqsQ7tMtx06R+Bwdhgn0JM8LKJdNyw0NrTQlX8NTZK9tjvI/ycgwtbU7Qdy8Z
 m8ACMo6srtpKIPS2oyw4Hj+VKnPomw==
X-Proofpoint-ORIG-GUID: 4YrFQCcLAdBXpQmWVlB1u-OrXIXvaBci
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfXztpMTgqs93xi
 TkDvtG+Y0s9yi75m8+VKsa30teyR+Mf/FpsIERgTBsjJ5ikErFyAR0sw7PzpX24ngGB0K37ir2u
 nDhfcqIvlI5LbjA/5LsqOnlIts7Q42FHHKmvyEtknzP34wYtxcM6
X-Proofpoint-GUID: 4YrFQCcLAdBXpQmWVlB1u-OrXIXvaBci
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11cc cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=NEAV23lmAAAA:8
 a=t7CeM3EgAAAA:8 a=AQLyHzcnz5Y5Qm3N_bcA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19767

This is an update to the previous series to rebase on master. It is also
available at: https://github.com/robwoolley/bitbake/tree/b4/add-pypi-v8

This version of the series integrates the vendoring module to update
beautifulsoup4, ply, progressbar, simplediff, and typing_extensions.

I also included Richard's latest commit to add version variables to the
bitbake scripts and dropped the mechanism that I proposed.

Here are the steps of the test procedure I used before sending this series:

```
python3 -m venv venv

source venv/bin/activate

pip install build

BB_SKIP_PYPI_TESTS=no bin/bitbake-selftest -v bb.tests.setup.PyPIPackagingTest

contrib/pypi/package-bitbake-setup.py -v

cd packaging_workspace/

pip install -e .

which bitbake-setup

bitbake-setup --version

bitbake-setup list

pip uninstall bitbake-setup

python3 -m build

pip install dist/bitbake_setup-2.19.0-py3-none-any.whl

which bitbake-setup

bitbake-setup --version

cd $(mktemp -d)

bitbake-setup init

. /tmp/tmp.cHLz5edo1w/bitbake-builds/oe-nodistro-master/build/init-build-env

which bitbake

cd /tmp/tmp.cHLz5edo1w/bitbake-builds/oe-nodistro-master/layers/bitbake

git remote add bitbake-setup-pypi /ala-lpggp31/rwoolley/bitbake-setup/bitbake

git remote update bitbake-setup-pypi

git checkout --track bitbake-setup-pypi/b4/add-pypi-v8

cd $BUILDDIR

bitbake quilt-native

bitbake core-image-minimal

bitbake-selftest
```

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
Richard Purdie (1):
      bin/*: Add/improve __version__ processing

Rob Woolley (10):
      bitbake-setup: Add version option
      pypi: Add PyPI packaging for bitbake-setup
      pypi: Add packaging documentation for developers
      gitignore: Ignore temporary staging directory
      Add pyproject.toml and vendor.txt for vendoring
      Add vendor patches
      Update vendorized modules
      vendor.txt: Add typing_extensions for bs4
      Update typing_extensions with vendoring
      bitbake-setup: Add exception for E402 for bb.__version__

 .gitignore                                         |    1 +
 bin/bitbake                                        |    2 +-
 bin/bitbake-diffsigs                               |    7 +
 bin/bitbake-getvar                                 |    6 +
 bin/bitbake-hashclient                             |    8 +
 bin/bitbake-hashserv                               |    7 +-
 bin/bitbake-layers                                 |    6 +
 bin/bitbake-prserv                                 |    8 +-
 bin/bitbake-selftest                               |    7 +
 bin/bitbake-server                                 |    6 +
 bin/bitbake-setup                                  |    7 +
 bin/bitbake-worker                                 |    6 +
 bin/toaster                                        |    2 +
 bin/toaster-eventreplay                            |    7 +
 contrib/pypi/BUILD.md                              |   50 +
 contrib/pypi/LICENSE                               |   23 +
 contrib/pypi/README.md                             |   42 +
 contrib/pypi/package-bitbake-setup.py              |   79 +
 contrib/pypi/pyproject.toml                        |   92 +
 lib/bb/_vendor/__init__.py                         |   18 -
 .../{bs4/LICENSE => beautifulsoup4.LICENSE}        |    0
 lib/bb/_vendor/bs4/AUTHORS                         |   49 -
 lib/bb/_vendor/bs4/CHANGELOG                       | 1839 ---------
 lib/bb/_vendor/bs4/__init__.py                     |  856 ++--
 lib/bb/_vendor/bs4/_deprecation.py                 |   80 +
 lib/bb/_vendor/bs4/_typing.py                      |  205 +
 lib/bb/_vendor/bs4/_warnings.py                    |   98 +
 lib/bb/_vendor/bs4/builder/__init__.py             |  828 ++--
 lib/bb/_vendor/bs4/builder/_html5lib.py            |  592 +--
 lib/bb/_vendor/bs4/builder/_htmlparser.py          |  426 +-
 lib/bb/_vendor/bs4/builder/_lxml.py                |  387 +-
 lib/bb/_vendor/bs4/css.py                          |  268 +-
 lib/bb/_vendor/bs4/dammit.py                       | 1622 +++++---
 lib/bb/_vendor/bs4/diagnose.py                     |  169 +-
 lib/bb/_vendor/bs4/element.py                      | 3494 ++++++++++------
 lib/bb/_vendor/bs4/exceptions.py                   |   28 +
 lib/bb/_vendor/bs4/filter.py                       |  764 ++++
 lib/bb/_vendor/bs4/formatter.py                    |  211 +-
 lib/bb/_vendor/bs4/py.typed                        |    0
 lib/bb/_vendor/ply.pyi                             |    1 +
 lib/bb/_vendor/ply/__init__.py                     |    1 +
 lib/bb/_vendor/ply/cpp.py                          |  918 +++++
 lib/bb/_vendor/ply/ctokens.py                      |  133 +
 lib/bb/_vendor/ply/lex.py                          |  845 ++--
 lib/bb/_vendor/ply/yacc.py                         | 2231 +++++-----
 lib/bb/_vendor/ply/ygen.py                         |   74 +
 lib/bb/_vendor/progressbar.pyi                     |    1 +
 lib/bb/_vendor/progressbar/__init__.py             |    4 +-
 lib/bb/_vendor/progressbar/progressbar.py          |   21 +-
 lib/bb/_vendor/progressbar/widgets.py              |   14 +-
 lib/bb/_vendor/simplediff.pyi                      |    1 +
 lib/bb/_vendor/simplediff/__init__.py              |    2 +-
 lib/bb/_vendor/typing_extensions.LICENSE           |  279 ++
 lib/bb/_vendor/typing_extensions.py                | 4317 ++++++++++++++++++++
 lib/bb/_vendor/typing_extensions.pyi               |    1 +
 lib/bb/main.py                                     |    2 +-
 lib/bb/tests/setup.py                              |  289 +-
 lib/hashserv/__init__.py                           |    2 +
 lib/prserv/__init__.py                             |    2 +-
 pyproject.toml                                     |   19 +
 vendor.txt                                         |    5 +
 vendor/licenses/ply/LICENSE                        |   32 +
 .../bs4-0010-lib-bs4-Avoid-soupsieve-warning.patch |   40 +
 vendor/patches/bs4-remove-double-imports.patch     |   23 +
 ...lib-implement-basic-task-progress-support.patch |  126 +
 ...-initial-pass-of-SPDX-license-headers-to-.patch |   80 +
 ...gressbar-accept-value-over-initial-maxval.patch |   55 +
 ...-Add-self._fd_console-to-use-for-self._ha.patch |   54 +
 ...ar-Make-bars-show-correctly-with-maxval-0.patch |   32 +
 ...-knotty-Allow-mixing-log-messages-and-pro.patch |   32 +
 70 files changed, 15318 insertions(+), 6618 deletions(-)
---
base-commit: 733161c76bd2ac777555d3eac113ff54b4c63ae2
change-id: 20260619-add-pypi-v8-89df7be8c5c2

Best regards,
--  
Rob Woolley <rob.woolley@windriver.com>


