Return-Path: <peter.hoyes@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B11EB64D8
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 12:38:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.7320.1686919098027989518
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 05:38:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: peter.hoyes@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8369C1FB;
	Fri, 16 Jun 2023 05:39:01 -0700 (PDT)
Received: from e125920.arm.com (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF71F3F71E;
	Fri, 16 Jun 2023 05:38:16 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 0/5] RFC: Support pytest for bitbake self-tests
Date: Fri, 16 Jun 2023 13:36:46 +0100
Message-Id: <20230616123651.915234-1-peter.hoyes@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 12:38:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14838

From: Peter Hoyes <Peter.Hoyes@arm.com>

pytest [1] is a test runner for Python test suites. Its advantages
over vanilla unittest are:

 * An existing tool with a familiar entry-point.
 * A flexible plugin architecture that supports a large plugin
   ecosystem, including for parallel testing and embedded testing.
 * Fixtures, for more flexible and granular sharing of setup/teardown
   logic.

This patch chain proposes introducing pytest as an alternative test
runner for the Bitbake self-tests.

pytest is mostly compatible with unittest TestCases out of the box,
but some small adaptations are included in this patch chain, alongside
a pytest.ini file and an update to the README.

This patch chain does not mandate how the pytest package is obtained,
apart from a reference to PyPI in the README. The 'minversion' is set
to 7.3, the latest version, in the pytest.ini file.

[1] https://docs.pytest.org/

Peter Hoyes (5):
  bitbake: tests/fetch: Mark TestTimeout as not a test suite
  bitbake: tests/fetch: Rename assertRaisesRegexp to assertRaisesRegex
  bitbake: tests/fetch: Set git config if not already set
  bitbake: tests: Use assertLogs to test logging output
  bitbake: Bootstrap pytest for self-tests

 bitbake/README                   |  8 ++++++--
 bitbake/lib/bb/tests/conftest.py |  8 ++++++++
 bitbake/lib/bb/tests/fetch.py    | 23 +++++++++++++++--------
 bitbake/lib/bb/tests/parse.py    | 16 +++++++++-------
 bitbake/pytest.ini               |  7 +++++++
 5 files changed, 45 insertions(+), 17 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/conftest.py
 create mode 100644 bitbake/pytest.ini

--=20
2.34.1


