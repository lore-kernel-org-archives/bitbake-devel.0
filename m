Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A2FCD98F3
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1754.1781645505826862962
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=YBIkuqDK;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVjSq290773
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=mxMlLFqYH
	cAOt53uxF1x3DZddZuTIotFnziQLDzzslM=; b=YBIkuqDKR0jWNy8cjp0wHqCvq
	bAHTHQXOWUvFOjfW1s7en5o0zdUBOBKhMTpYw9u4vBYgki+CRw2rcJEuvyPzkgOm
	OFC25uu2+1l9W6e2QL0YkSSXD5uPPOvbYglD5gE+eCiEAb8uWHN5sWngrMZffrDR
	G9EgML8mKLI7FI7cFo0RzQGkuQ7Vx6k8m455XUIi8nSQbpYqnFZp8YGf88wXEiay
	vfXbNWnaG0rM9PoULAC9Dgt1gtZlwCXmzNLSM0I3WYxi0T5srYbdQxsjYEhGpRv1
	4n+3xT1cdI2x97H1HePLfYu/T62/sEvEQxtqsjztjso0kxNOidb3kyImK/lug==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbr03v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:45 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 14:31:44 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 14:31:44 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Subject: [PATCH v3 00/10] bitbake-setup PyPI Packaging
Date: Tue, 16 Jun 2026 14:31:20 -0700
Message-ID: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKjAMWoC/yXMTQ5EQBBA4atIrVVSftJirjKxQBXKwnS6R4eIu
 2ssv8V7B3hxKh4+yQFOgnr9LRFFmkA/tcsoqBwNOeWGTGawZUa7W8VQIRVCxCVT3RmIhXUy6Pb
 cvs1rv3az9P97Aed5AQoMwZxvAAAA
X-Change-ID: 20260616-add-pypi-v7-03e00d4d09b6
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: tUN72tW8Ezs6wBEJaGbWDhnNFb_rXRNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfXz/e2MZuFilvw
 SJTJHRzuJJeNfnh2J73/qvbn1c77ZG4NEfQPHKr2ZP4IBJNbViNvtWh5s7qYUhVaKsqw/Xn3sOz
 MM8kuvRxc7DBlkguUPzt08cLoDaBQMAurxEwn7gv8y1d2zx13UosiAFm8CXnGsfEeeBmPZ01jKG
 DLAwCqYUD5ajh3QBHt1srm2hMcvAvTy87S7Fd4kz+pFhjGBiqpFwJErilED5dtnYV09SKvrwOHO
 Ox7m56xLsrPbIB06kCdr/XpvUiDOUYpGqU4X3xcI698U0mopgonalNl+Ci4IrbKoHAjVzcWbCLS
 vp0EJQ2Ty7yg+8V63kyTxNxtWVrRBFI67w3mgVJn4mphPQFMU+MbzlKDtCkZdZknIBs5sXZb5o1
 cnn3pgoTWnyaJzVj2Yp2dNw8ARRGjA==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a31c0c1 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=NEAV23lmAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=0kG3Q5GP4oJFsGM7eX4A:9 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: tUN72tW8Ezs6wBEJaGbWDhnNFb_rXRNr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX3dktTfNmPveM
 vZ3sFhHMeMmUNw+CKHnwRWzm/1/UW564+tPQ76DT1YvYbAIG3ifN5UzhhBuIqBD4D5MrAyZj4n6
 /WuIkB+h/2NyMsmOECSHoaUIIJfdsDUQ6neZIpMPmxqltE2yq2zu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606160218
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 21:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19713

This is an update to the previous series to rebase on master. It is also
available at: https://github.com/robwoolley/bitbake/tree/add-pypi-v7

This is a work-in-progress and I am sharing it so others can try it out.

Not included in this series is the work I started to vendorize bundled
third-party libraries with the vendoring module. This was recommended by Ross:
   https://lists.openembedded.org/g/bitbake-devel/message/19419

I will send an updated series again when I have resolved issues related to
upgrading the vendorized modules.

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

git checkout --track bitbake-setup-pypi/add-pypi-v7

cd $BUILDDIR

bitbake quilt-native

bitbake core-image-minimal

bitbake-selftest
```

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
Rob Woolley (10):
      bitbake-setup: Resolve unused loop control variables
      bitbake-setup: Fix ambiguous variable names
      bitbake-setup: Add checks for version information
      bitbake-setup: Add version option
      bitbake-setup: Add version check and catch exceptions
      bitbake: Add checks for importing bb module
      pypi: Add PyPI packaging for bitbake-setup
      pypi: Add packaging documentation for developers
      gitignore: Ignore temporary staging directory
      lib: Vendorize bundled third-party libraries under bb._vendor

 .gitignore                                      |   1 +
 bin/bitbake                                     |  24 +-
 bin/bitbake-selftest                            |   2 +
 bin/bitbake-setup                               |  77 +++++--
 contrib/pypi/BUILD.md                           |  50 ++++
 contrib/pypi/LICENSE                            |   9 +
 contrib/pypi/README.md                          |  42 ++++
 contrib/pypi/package-bitbake-setup.py           |  79 +++++++
 contrib/pypi/pyproject.toml                     |  92 ++++++++
 lib/bb/_vendor/__init__.py                      |  18 ++
 lib/{ => bb/_vendor}/bs4/AUTHORS                |   0
 lib/{ => bb/_vendor}/bs4/CHANGELOG              |   0
 lib/{ => bb/_vendor}/bs4/LICENSE                |   0
 lib/{ => bb/_vendor}/bs4/__init__.py            |   0
 lib/{ => bb/_vendor}/bs4/builder/__init__.py    |   2 +-
 lib/{ => bb/_vendor}/bs4/builder/_html5lib.py   |  12 +-
 lib/{ => bb/_vendor}/bs4/builder/_htmlparser.py |   6 +-
 lib/{ => bb/_vendor}/bs4/builder/_lxml.py       |   6 +-
 lib/{ => bb/_vendor}/bs4/css.py                 |   2 +-
 lib/{ => bb/_vendor}/bs4/dammit.py              |   0
 lib/{ => bb/_vendor}/bs4/diagnose.py            |   9 +-
 lib/{ => bb/_vendor}/bs4/element.py             |   6 +-
 lib/{ => bb/_vendor}/bs4/formatter.py           |   2 +-
 lib/{ => bb/_vendor}/ply/__init__.py            |   0
 lib/{ => bb/_vendor}/ply/lex.py                 |   0
 lib/{ => bb/_vendor}/ply/yacc.py                |   6 +-
 lib/{ => bb/_vendor}/progressbar/LICENSE.txt    |   0
 lib/{ => bb/_vendor}/progressbar/__init__.py    |   0
 lib/{ => bb/_vendor}/progressbar/compat.py      |   0
 lib/{ => bb/_vendor}/progressbar/progressbar.py |   0
 lib/{ => bb/_vendor}/progressbar/widgets.py     |   0
 lib/{ => bb/_vendor}/simplediff/LICENSE         |   0
 lib/{ => bb/_vendor}/simplediff/__init__.py     |   0
 lib/bb/fetch2/wget.py                           |   4 +-
 lib/bb/pysh/pyshlex.py                          |   2 +-
 lib/bb/pysh/pyshyacc.py                         |   2 +-
 lib/bb/siggen.py                                |   2 +-
 lib/bb/tests/setup.py                           | 289 +++++++++++++++++++++++-
 lib/bb/ui/knotty.py                             |   2 +-
 lib/toaster/tests/views/test_views.py           |   2 +-
 40 files changed, 679 insertions(+), 69 deletions(-)
---
base-commit: 7e6466f48191c1e4ab9b91705deb237eff2c7f01
change-id: 20260616-add-pypi-v7-03e00d4d09b6

Best regards,
--  
Rob Woolley <rob.woolley@windriver.com>


