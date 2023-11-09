Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B84C41535
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:15:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.1082.1699550121091804461
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 09:15:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Dy7fE2UE;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 579829C34CB
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 12:15:19 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7DNx4tUDwVH9; Thu,  9 Nov 2023 12:15:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8F8369C34C9;
	Thu,  9 Nov 2023 12:15:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8F8369C34C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699550118; bh=UIGNNkOZkPdPaITzoMQaeJ4ltHASOcVfYHdjJYH72BE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Dy7fE2UEAZJqb0pHkqygicBTZDwthYVQsrgId890fTo7HiwDfAQU8/8U4Ft2xmJNS
	 Tyy1ng7mKZ2PdsUOISCYK1HeED1oARLuALULWrytelalppxVgDqXO5PsCr/IyuplWW
	 VKyDsUEB8MIrLVYBSbzDB6XVEPKvkHbqzp67oanVzN/csrIW8H1eqYIqrt0ZdPEhIj
	 yakpxlm/w0I2nA7rpHliSzurEtImnHOOFOHoWso6oMYF5Iowy/1pbp3+w03qOKkI6B
	 qI6+dq6WMtj0gsKWVXjsTxHr9WhbiN5Lyb876TNc0dRZSr9eXC9t6lZqpCyzcfPGnl
	 TmRmOJsioj2pg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LOKbtLoC77zQ; Thu,  9 Nov 2023 12:15:18 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id ABD8F9C3290;
	Thu,  9 Nov 2023 12:15:17 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v4 1/7] Toaster: Update toaster-requirements.txt and Added pytest.ini
Date: Thu,  9 Nov 2023 18:14:56 +0100
Message-Id: <20231109171502.205787-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 17:15:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15471

*** Update toaster-requirements.txt ***
Add pytest and some plugin's
- Pytest-html is a plugin for pytest that generates a HTML report for tes=
t results.
- Pytest-django allows us to test Django project/applications with the py=
test testing tool.
- Pytest-env is a pytest plugin that enables us to set environment variab=
les in a pytest.ini or pyproject.toml file
- Pytest-metadata is a plugin for pytest that provides access to test ses=
sion metadata, required by pytest-html plugin
to provides metadata information in the HTML report like below:

Python 3.10.12
Platform Linux-6.2.0-35-generic-x86_64-with-glibc2.35
Packages:
    - pytest: 7.4.2
    - pluggy: 1.3.0
Plugins	:
    - django: 4.5.2
    - metadata: 3.0.0
    - order: 1.1.0
    - html: 4.0.2
    - env: 1.1.0

*** Added pytest.ini file ***
The main reason for using pytest is to be able to generate a positive tes=
t report
using the pytest-html plugin.

Integrating Pytest with Tox is a straightforward process, this can be
done using tox.ini instead of pytest.ini used to configure pytest, that
is another reason for using pytest. Tox is a tool that automates testing
across different virtual environments, it can help ensure application
will be tested against multiple Python versions and environments.
https://github.com/pytest-dev/pytest/blob/main/tox.ini

Generated reports create a historical record of test results over time.
This can help track the progress of the application's stability and quali=
ty

Documentation and Transparency: Test reports provide us a clear and detai=
led
documentation of the test results. They show what tests were executed,
which ones passed, and which ones failed. This transparency is critical
for understanding the current state of the application and its test cover=
age.

Communication: Test reports are an effective means of communication among=
 community
to understand the testing progress and results.

Debugging, Troubleshooting Historical Tracking and Regression Testing:
In case of test failures, a detailed test report can be invaluable for de=
bugging.
It provides information about the specific test case that failed,
the input data used, and any error messages.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/pytest.ini   | 19 +++++++++++++++++++
 toaster-requirements.txt |  5 +++++
 2 files changed, 24 insertions(+)
 create mode 100644 lib/toaster/pytest.ini

diff --git a/lib/toaster/pytest.ini b/lib/toaster/pytest.ini
new file mode 100644
index 00000000..f07076b7
--- /dev/null
+++ b/lib/toaster/pytest.ini
@@ -0,0 +1,19 @@
+# -- FILE: pytest.ini (or tox.ini)
+[pytest]
+DJANGO_SETTINGS_MODULE =3D toastermain.settings_test
+
+python_files =3D db/test_*.py commands/test_*.py views/test_*.py browser=
/test_*.py functional/test_*.py
+
+# --create-db - force re creation of the test database
+# https://pytest-django.readthedocs.io/en/latest/database.html#create-db=
-force-re-creation-of-the-test-database
+
+# --html=3Dreport.html --self-contained-html
+# https://docs.pytest.org/en/latest/usage.html#creating-html-reports
+# https://pytest-html.readthedocs.io/en/latest/user_guide.html#creating-=
a-self-contained-report
+addopts =3D --create-db --html=3D"Toaster Tests Report.html" --self-cont=
ained-html=20
+
+# Define environment variables using pytest-env
+# A pytest plugin that enables you to set environment variables in the p=
ytest.ini file.
+# https://pypi.org/project/pytest-env/
+env =3D
+    TOASTER_BUILDSERVER=3D1
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index d8e48b7f..19bf6fd2 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -2,3 +2,8 @@ Django>4.2,<4.3
 beautifulsoup4>=3D4.4.0
 pytz
 django-log-viewer=3D=3D1.1.7
+pytest=3D=3D7.4.2
+pytest-django=3D=3D4.5.2
+pytest-env=3D=3D1.1.0
+pytest-html=3D=3D4.0.2
+pytest-metadata=3D=3D3.0.0
--=20
2.34.1


