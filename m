Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4E0C00A8F
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 18:28:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.155426.1698172114088564223
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Oct 2023 11:28:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=QmBuuvta;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A368D9C29BE;
	Tue, 24 Oct 2023 14:28:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id HVmCx1J5H4fP; Tue, 24 Oct 2023 14:28:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EC3CE9C3240;
	Tue, 24 Oct 2023 14:28:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EC3CE9C3240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698172112; bh=jybJ8BnJW425jdT2+wpjyqJMR9Bc7TROudgguEbcq+s=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=QmBuuvtaBod8eXhd8FwGwjVIUuqunoW2X3VM0fgSvfA0N+3VwN67QH1Oad7RBFJdS
	 Qdq9KsByQNQWMPVk0JOlsrZN2/Co7DBoDJsGrLYRa0RZDveNOK/qtBaUOLZalp+wBo
	 /P4EH9fR703dhxY5wojffwUDAh4KdIFcKA6iis1AccmzAzoViuBdf/gJpbZBB+LYbx
	 ArFG/DVC7D5mkb1OIZ4R8ACeHbzJgdSirMkRyURE457MfA9lVobht4G//w93OGYjsu
	 i8pAhqfo9p+JOOvn8XDwpi93hl+paSjaH7vl7z+p33+m62ZjzLXOxc9vr4eTBvlUdB
	 cdWUd6wc/YvJw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MdEwX1NLUDmF; Tue, 24 Oct 2023 14:28:31 -0400 (EDT)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C21F59C29BE;
	Tue, 24 Oct 2023 14:28:31 -0400 (EDT)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH v2] toaster: add tox.ini file to execute test suite
Date: Tue, 24 Oct 2023 14:28:28 -0400
Message-Id: <20231024182828.156237-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 18:28:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15281

Updated tox file to fix enviroments variables.
to run tox use the following command:
tox -e env_name -c /path/to/file/tox.ini
See tox cli https://tox.wiki/en/latest/cli_interface.html
The variable env_name is linked to the python versions (py38, py39, py310=
).
If env_name option is not set,  the test suite will run for all indicated=
 versions.

It was also modified the webdriver options for chrome to run selenium tes=
t in console because of the error detected in the previous test run
selenium.common.exceptions.SessionNotCreatedException: Message: session n=
ot created: Chrome failed to start: exited normally.
  (session not created: DevToolsActivePort file doesn't exist)
(The process started from chrome location /usr/bin/google-chrome is no lo=
nger running, so ChromeDriver is assuming that Chrome has crashed.)

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>

Changes in v2
- Updated variable path BUILDDIR and EVENTREPLAY_DIR to use enviroment va=
lue
- Updated toaster-requirements.txt file path
- Removed flake8
- Added webdriver options to chrome
---
 .../tests/browser/selenium_helpers_base.py    |  8 +++++++-
 lib/toaster/tox.ini                           | 20 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 lib/toaster/tox.ini

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toa=
ster/tests/browser/selenium_helpers_base.py
index 9a4e27a3..e0ac4376 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -33,7 +33,13 @@ def create_selenium_driver(cls,browser=3D'chrome'):
         browser =3D env_browser
=20
     if browser =3D=3D 'chrome':
-        return webdriver.Chrome()
+        options =3D webdriver.ChromeOptions()
+        options.add_argument('headless')
+        options.add_argument('--disable-infobars')
+        options.add_argument('--disable-dev-shm-usage')
+        options.add_argument('--no-sandbox')
+        options.add_argument('--remote-debugging-port=3D9222')
+        return webdriver.Chrome(options=3Doptions)
     elif browser =3D=3D 'firefox':
         return webdriver.Firefox()
     elif browser =3D=3D 'marionette':
diff --git a/lib/toaster/tox.ini b/lib/toaster/tox.ini
new file mode 100644
index 00000000..8c0fe171
--- /dev/null
+++ b/lib/toaster/tox.ini
@@ -0,0 +1,20 @@
+[tox]
+envlist =3D py38, py39, py310
+skipsdist =3D True
+toxworkdir =3D {env:TOX_WORKDIR:.tox}
+passenv =3D *
+
+[testenv]
+setenv =3D
+    DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_test
+    TOASTER_BUILDSERVER=3D1
+    BUILDDIR =3D {env:BUILDDIR}
+    EVENTREPLAY_DIR =3D {env:EVENTREPLAY_DIR:BUILDDIR}
+commands =3D
+    python3 {toxinidir}/manage.py test tests.db tests.commands tests.bui=
lds tests.browser tests.functional tests.views
+deps =3D=20
+    -r {toxinidir}/../../toaster-requirements.txt
+    -r {toxinidir}/tests/toaster-tests-requirements.txt
+
+[testenv:chrome]
+commands=3D{[testenv]commands} --splinter-webdriver=3Dchrome
\ No newline at end of file
--=20
2.34.1


