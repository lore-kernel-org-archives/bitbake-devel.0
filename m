Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B75D3409B
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15113.1769529914735031333
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=jsDDWqqL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZ7880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=OiXddaZnd9G7bX/+D/yU
	9GfxwQ6X6SzftyciOrhN+dE=; b=jsDDWqqLV5MJ02K3X+woJHrHShKbIfE0DYyl
	84iRMohh1dq/rbjw/0oSztd8wvDwa5pIbcT8x+9h4OzyQwrswc1dLnLZv6TeHWEC
	crmJ5F86VdDb0RzjM9MXunrQb9dh4kWMKhvwPqeY7I6c7BjYEPfsiBS3oZedUhFD
	Ctm3DOS7tbYogRF4sRra/76+DQMYcpJXMEqcPEmfIzaFnRVqOYsAww0Eojj1OHCG
	IBqpkVycM1ouMeI7J/scdKeypY7AFVXCs1zIz76urMVzLqrM0ZygbFmPbv0ljpRc
	ky6Svm9MukTf9+dK62qkWigAVQC9NFFZqYpSupGZquVrEPDNuw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:14 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:13 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:13 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 00/10] Package bitbake-setup for PyPI
Date: Tue, 27 Jan 2026 08:04:57 -0800
Message-ID: <20260127160508.3392732-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eyYVuS00pAkDM54HkIb6-OpZNFcSoRSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfXzGARwMbM6VUZ
 UDTS3YfdsvNvq3nRtnAD5cmQKIm2uEsYNF8o1Q9jiH8cwS17kHQJrPI9zzvbwWSiQUb4ZTP8UFG
 GpFIfd3mmCgJTJBXsWCbVibmPFxF6535vdRwHEBWZPyYQ1JsACq8bkQvhux/rTdwVBLHkYlHO8R
 5qCYDqoeS1IoVek12tC4i5Kj317Dd4j+kczVbp6RZ7cmo50asWHqHs2GdwZyXLlxlL4aB7+hk+h
 x617FOKb74rnYgcG+bw0Lju6gLSmiGtOLXwBsA78h+xRyj44wJHKlGu6dBeUu5MC9mp6ZrRGNmQ
 QDMEoaQ/cs44lcNlGokFzhXe8InMUnw5vVX44NpuUUscXeU5rZciqn0dNYmj4J1XQhFCWgR1m5S
 SqRrEYlYL7a7b/NC5la01gKI7Ab+bukL5kUROSCd8DwYbeIWMBYn/KN0UakAxWd/ozbUCeQfpaC
 UIJ7vFC4ZDis8pdAmSg==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=dXvAoEkxAAAA:8
 a=vHhVP-sAvxzUB1Ac2dAA:9 a=s8f_z96wkXEA:10 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=iJ39DRKJB4kz2P1Iyp3E:22
X-Proofpoint-GUID: eyYVuS00pAkDM54HkIb6-OpZNFcSoRSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270131
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 16:05:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18889

Thanks for the feedback from the 1st series.  I included all requested
changes:
   * Moved packaging files from top-level to contrib/pypi
   * Created package-bitbake-setup.py to create a new workspace to
     build the package and be compliant with PEP 517
   * Changed the title of patch #4 to start with bitbake-setup:
   * Converted setup.cfg to pyproject.toml
   * Remove old license classifiers
   * Made AND operator uppercase for license entry
   * Set the minimum Python requirement to 3.9
   * Created a custom README.md and BUILD.md for bitbake-setup
   * Changed the URL to https://git.openembedded.org/bitbake/
   * Added support for nox to automate the packaging including
     linting, building, and testing

There was a question about the wildcards in the includes section.
In this context they are not used for filename globbing and instead
denote to include any Python sub-modules as well.  See the Python
documentation for details:
https://setupttools.pypa.io/en/latest/userguide/package_discovery.html

The bitbake-setup script is no longer being turned into a module in
the git repository.  Instead it is being done by the script.  The
rationale for doing this is that it:
   * ensures the module works reliably on all platforms
   * avoids shebang and path issues
   * places nicely with wheels, venvs, and zipapps
   * easier to test

I did make an attempt to ensure that pyproject.toml and noxfile.py
are compatible with older tools.  Building the wheel using the
pyprojet.toml should be supported with pip >=19.

Wheels built newer versions of pip should remain backwards
compatible with pip when installing on older systems.

Outstanding:
   * Determine a release strategy and version scheme
   * Document steps for publishing the module to PyPI

To run the automated tests all that should be required is to
install the python3-nox package or nox Python module.  Then run

nox -s lint
nox -s build
nox -s tests

Rob Woolley (10):
  bitbake-setup: Add the conditional script stanza
  bitbake-setup: Add pypi packaging
  bitbake-setup: Remove extraneous variable from str.format()
  bitbake-setup: Sort and format imports
  bitbake-setup: Resolve unused loop control variables
  bitbake-setup: Fix ambiguous variable names
  bitbake-setup: Remove unused stdout variable
  bitbake-setup: Replace f-string without placeholders
  bitbake-setup: Remove unused Namespace import
  bitbake-setup: Remove unused parser_settings_list

 .gitignore                            |  1 +
 bin/bitbake-setup                     | 76 ++++++++++-----------
 contrib/pypi/BUILD.md                 | 57 ++++++++++++++++
 contrib/pypi/LICENSE                  |  9 +++
 contrib/pypi/README.md                | 42 ++++++++++++
 contrib/pypi/noxfile.py               | 30 +++++++++
 contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++++++
 contrib/pypi/pyproject.toml           | 97 +++++++++++++++++++++++++++
 contrib/pypi/tests/test_install.py    | 17 +++++
 9 files changed, 383 insertions(+), 39 deletions(-)
 create mode 100644 contrib/pypi/BUILD.md
 create mode 100644 contrib/pypi/LICENSE
 create mode 100644 contrib/pypi/README.md
 create mode 100644 contrib/pypi/noxfile.py
 create mode 100755 contrib/pypi/package-bitbake-setup.py
 create mode 100644 contrib/pypi/pyproject.toml
 create mode 100644 contrib/pypi/tests/test_install.py

-- 
2.49.0


