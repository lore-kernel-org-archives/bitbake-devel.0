Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E49CC4167D
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 15:56:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.125087.1699545392617890980
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 07:56:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Wtjyl3md;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7D7DD9C347B
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 10:56:30 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id UbFX_r4a3RsA; Thu,  9 Nov 2023 10:56:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C95459C2CF2;
	Thu,  9 Nov 2023 10:56:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C95459C2CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699545389; bh=BPR02CalnQGhc+d1+wUbGs41++5XFhSUW+8cTF1uJz8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Wtjyl3mduDJkZ2fGptBztpVnkdFr4QqsWiwDVED4k9ckdO/yijkOaZ1nDnUBT/1I4
	 MzLdQ46TbBAsQ9qFViymMOe5GwUdtVZAmJiH3Fh+ycGiRaaBd6IQ8FdtN6bhXSTRrn
	 5FFic3BMfZMVFfTYRXbmi3HYFabnFQE1rA9ZaAtBSMkRPLDUBs9tJ7ZjLpF4MItWIg
	 MwncAZagK/t5LrUNWgpMRJ9daTua6IKOqhf1ud4puisnC0VlwRNoGxHMXFK+aHesIg
	 dS5ImWYyLRugJj637BeHaHAKG1rOpwxg+4vSVVtae10sq8VfOEi97+R/Bkn8jiWHJn
	 MkiIVIurRhJng==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 1c8TpUGcdv_4; Thu,  9 Nov 2023 10:56:29 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 128679C34B2;
	Thu,  9 Nov 2023 10:56:28 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 8/8] Toaster: Added pytest.ini file
Date: Thu,  9 Nov 2023 16:56:18 +0100
Message-Id: <20231109155618.133124-8-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109155618.133124-1-alassane.yattara@savoirfairelinux.com>
References: <20231109155618.133124-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 15:56:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15470

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
 lib/toaster/pytest.ini | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
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
--=20
2.34.1


