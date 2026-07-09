Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C037C44503
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 02:03:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.403.1783562630529263096
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2026 19:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AxrLyDxs;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1650fcb189=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6691gLpg1094724
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Jul 2026 02:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=FQ38VMttO
	rl27UFQHEnJnNvhRwCiJxgw18xqCtWbfTI=; b=AxrLyDxsK9I3GUB2iadwKeSvh
	9aBqNG0FOIF1XEjrQOCRY8+NAMWC+IN1D28xsnOH4n6aNCUr+D4n8QvRE/lyUQ5R
	dzEYULtz+MiRlAAB7wwACDBmpXtpP5PwyUGZxhVYtSPHMYFZIgOyWmHRPYQ8aRR0
	9aS9b3JrpeEKrSnj9EUSvDgdNrhpQmN2hDTDGZebDc+5INsOrmPTjL6K4GT0vTwN
	wfuRCqXelYqf6Djp5V0RAdzYUb0BDzWcFzUS1J4YMEfDOlBd2TKccAyEJnnKqpZL
	hLws00C9GOFxPPlyGj5s5KOAs/UYqzr//aXrHsSN0F8pPZ0q4gGdv24Doah/w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1h202nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 8 Jul 2026 19:03:47 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 8 Jul 2026 19:03:47 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Subject: [PATCH v5 0/9] bitbake-setup PyPI Packaging
Date: Wed, 8 Jul 2026 19:03:32 -0700
Message-ID: <20260708-add-pypi-v10-v5-0-7d5f457f4b9c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQBT2oC/yXMQQ5AMBBA0avIrE0yJGhcRSyqHYwFTYsQcXfF8
 i3+vyCwFw5QJxd43iXIMkcUaQJm1PPAKDYacspLqkihthbd6QT3jJAUK02Geso6iInz3Mvx7Zr
 2d9i6ic36PuC+H08Dd41wAAAA
X-Change-ID: 20260708-add-pypi-v10-08e8a0c0f01b
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a4f0185 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=NEAV23lmAAAA:8
 a=t7CeM3EgAAAA:8 a=NJR5tSWDJmsEFPLwFjUA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfXz5NRNb3hmgR/
 31/RWp/9zzsDQcP+RqikJL4UI7m/76tScYQ7edYol+1WhyFhPiCMbro041SqeAjxrwcOi0d4l2Z
 UtJskdItQmb5toFz2J7wSYX5CaKd68tBQCJar8iSgSqlnZr6Xghs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfX9RXeoZgWaLfF
 X7cZOcbjCyeLOi5GWu1i0lSwYJju/IL1hr5FaITiGdvn3VRBgoipklHA+6cT5iLQbUCuGLwQJ+R
 mNB6pFBOahP83dQE/81f2KUY+RgIUiu+csFwJtf7Ab5SkA0edLLMgQuhXdUdCRgHt0atILboKHq
 RLGVY8Vf9gA9aR0H32icYgqAFhNoSaomqJCOiGEayBWWOFnpxsgnR6+TwohZ8Omq6d+msj0ZT5m
 w1Im7u0YMWJ84CWv7NJGQGOEm2yze0oNoJct+x2huqbw+2qoPLczMZyYDC0MtJg0LdtZerbZ27i
 ULvG4O46blhtC2k5ljhbw6US903UEN+FKRvNHXr+ZvK5O9uniz/cQpnO10DsNlAd0Ajq1zxf2XK
 wAEpkH8yytD5rIgS0PVTt4A0mlWhRK17VWShUN0FSnoZmsCiWdDaSdqANC4e51Gq2BVjHcLHMi4
 GBAS6Kt5sDZXkcGSJmg==
X-Proofpoint-ORIG-GUID: QriNTfIEePBhifrhSI-8Lwf9X7ERhpLl
X-Proofpoint-GUID: QriNTfIEePBhifrhSI-8Lwf9X7ERhpLl
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
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19826

This is an update to the previous series to rebase on master. It is also
available at: https://github.com/robwoolley/bitbake/tree/add-pypi-v10

The latest changes were to:

* rebase on HEAD
* re-run "vendoring sync ." to update the sync commit from before
* rename contrib/pypi/ to packaging-pypi/bitbake-setup/
* add instructions on using vendoring to packaging-pypi/bitbake-setup/BUILD.md
* rename the temporary directory from packaging_workspace to packaging-workspace

Here are the steps of the test procedure I ran again for this series:

```
python3 -m venv venv

source venv/bin/activate

pip install build

BB_SKIP_PYPI_TESTS=no bin/bitbake-selftest -v bb.tests.setup.PyPIPackagingTest

packaging-pypi/bitbake-setup/package-bitbake-setup.py -v

cd packaging-workspace/

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
Rob Woolley (9):
      bitbake-setup: Add version option
      pypi: Add PyPI packaging for bitbake-setup
      pypi: Add packaging documentation for developers
      gitignore: Ignore temporary staging directory
      Add pyproject.toml and vendor.txt for vendoring
      Add vendor patches
      Update vendorized modules
      vendor.txt: Add typing_extensions for bs4
      Update typing_extensions with vendoring

 .gitignore                                         |    1 +
 bin/bitbake-selftest                               |    2 +
 bin/bitbake-setup                                  |    1 +
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
 lib/bb/tests/setup.py                              |  289 +-
 packaging-pypi/bitbake-setup/BUILD.md              |   67 +
 packaging-pypi/bitbake-setup/LICENSE               |   23 +
 packaging-pypi/bitbake-setup/README.md             |   42 +
 .../bitbake-setup/package-bitbake-setup.py         |   79 +
 packaging-pypi/bitbake-setup/pyproject.toml        |   92 +
 pyproject.toml                                     |   19 +
 vendor.txt                                         |    5 +
 vendor/licenses/ply/LICENSE                        |   32 +
 .../bs4-0010-lib-bs4-Avoid-soupsieve-warning.patch |   40 +
 vendor/patches/bs4-remove-double-imports.patch     |   23 +
 ...lib-implement-basic-task-progress-support.patch |  125 +
 ...-initial-pass-of-SPDX-license-headers-to-.patch |   79 +
 ...gressbar-accept-value-over-initial-maxval.patch |   54 +
 ...-Add-self._fd_console-to-use-for-self._ha.patch |   53 +
 ...ar-Make-bars-show-correctly-with-maxval-0.patch |   31 +
 ...-knotty-Allow-mixing-log-messages-and-pro.patch |   31 +
 56 files changed, 15254 insertions(+), 6611 deletions(-)
---
base-commit: 660965735c7f16a9e864d8d3cb91298db8c39b81
change-id: 20260708-add-pypi-v10-08e8a0c0f01b

Best regards,
--  
Rob Woolley <rob.woolley@windriver.com>


