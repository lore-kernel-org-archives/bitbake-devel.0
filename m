Return-Path: <peter.hoyes@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE029EB64DB
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 12:38:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.7357.1686919109470562100
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 05:38:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: peter.hoyes@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1042A1FB;
	Fri, 16 Jun 2023 05:39:13 -0700 (PDT)
Received: from e125920.arm.com (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88C123F71E;
	Fri, 16 Jun 2023 05:38:28 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 5/5] bitbake: Bootstrap pytest for self-tests
Date: Fri, 16 Jun 2023 13:36:51 +0100
Message-Id: <20230616123651.915234-6-peter.hoyes@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616123651.915234-1-peter.hoyes@arm.com>
References: <20230616123651.915234-1-peter.hoyes@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 12:38:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14843

From: Peter Hoyes <Peter.Hoyes@arm.com>

To support running the bitbake self-tests using pytest, add a
pytest.ini This enables these tests to be run using the following
command from the bitbake directory.

  pytest

For now, testpaths only includes the bitbake selftests.

Add a note to the README.

Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
---
 bitbake/README                   | 5 +++++
 bitbake/lib/bb/tests/conftest.py | 8 ++++++++
 bitbake/pytest.ini               | 7 +++++++
 3 files changed, 20 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/conftest.py
 create mode 100644 bitbake/pytest.ini

diff --git a/bitbake/README b/bitbake/README
index bdb1e81dc1..78610e65f1 100644
--- a/bitbake/README
+++ b/bitbake/README
@@ -53,3 +53,8 @@ testsuite as follows:
=20
     export PATH=3D$(pwd)/bin:$PATH
     bin/bitbake-selftest
+
+The testsuite can alternatively be executed using pytest, e.g. obtained =
from PyPI (in this
+case, the PATH is configured automatically):
+
+    pytest
diff --git a/bitbake/lib/bb/tests/conftest.py b/bitbake/lib/bb/tests/conf=
test.py
new file mode 100644
index 0000000000..59a8c6753b
--- /dev/null
+++ b/bitbake/lib/bb/tests/conftest.py
@@ -0,0 +1,8 @@
+import pathlib
+import pytest
+
+BB_BIN_PATH =3D pathlib.Path(__file__).parents[3].resolve() / 'bin'
+
+@pytest.fixture(autouse=3DTrue)
+def bitbake_path(monkeypatch):
+    monkeypatch.setenv('PATH', str(BB_BIN_PATH), prepend=3D':')
diff --git a/bitbake/pytest.ini b/bitbake/pytest.ini
new file mode 100644
index 0000000000..3927e49021
--- /dev/null
+++ b/bitbake/pytest.ini
@@ -0,0 +1,7 @@
+[pytest]
+addopts =3D --import-mode=3Dimportlib
+minversion =3D 7.3
+junit_family =3D xunit1
+python_files =3D tests/*.py
+pythonpath =3D lib
+testpaths =3D lib/bb
--=20
2.34.1


