Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F98FCDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 19:48:15 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.10815.1697658492268050581
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Oct 2023 12:48:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Z4pa7f9A;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8071A9C2AFF
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 15:48:11 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 60sDWasZbO86; Wed, 18 Oct 2023 15:48:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B7B489C3265;
	Wed, 18 Oct 2023 15:48:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B7B489C3265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697658490; bh=XRWnOIteylIgRo5+sufAPUnD3BIZ47aoEBlFsSl8S4s=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Z4pa7f9Ahagq9VWNgvqUxlxC7JwltKEThcuPxB+R2o6VTB3VikzudpcxBbVZPa9Tv
	 Uov4qp8BnktZ6p8/MaYMeIxoFKUqBvDM4o0VaNZLItvtL7InLRRtdzsOmzHhdlEXLR
	 oCHb6CqO167zQbfVOkAXX5P8WmBi65bBFzsh256/aHIPOSmUbfw92avlf4lKMLd3rk
	 MT+L53SvHs5CFvr/84nhuwXMxylol3iCnrEvMW7y1CwvIni5jhRj7VmWD723rd9uCv
	 fvPRAkMIokaUJZ3cwWJVJpADUb12zIEtOvYnjQOr3G9axveSfiIJL0obvWAEfNwhs1
	 e6BOSp1TmxNaQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id BoKamKVEUY2S; Wed, 18 Oct 2023 15:48:10 -0400 (EDT)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9CAB09C3262;
	Wed, 18 Oct 2023 15:48:10 -0400 (EDT)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH] toaster: add tox.ini file to execute flake8 and test suite
Date: Wed, 18 Oct 2023 15:48:08 -0400
Message-Id: <20231018194808.2710433-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Oct 2023 19:48:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15258

Added configuration file for tox https://tox.wiki/en/4.11.3/ that include=
s flake8 and the test suite.
This file can be execute using the command 'tox tox.ini' and can be used =
in autobuilder.

By adding flake8 to the validation of toaster the following aspects have =
to be take into consideration:
Objective
- To comply with PEP8 standards, we propose to utilize a linting tool(Fla=
ke8) that checks toaster's codebase for errors, styling issues and comple=
xity

Ruleset
- See complete list of rules : https://www.flake8rules.com/

Assumptions
- We are aware that not all Flake8 rules can be applied to current codeba=
se (those determined to be more troublesome can be excluded).
- The patches can be integrated gradually by sections and/or rules.
- The tox.ini will include the execution of the test suite.

Pros
- Standardized codebase for future integrations.
- Majority of the patches will be syntax modifications and not affecting =
application logic.

Cons
- Major refactor of the codebase.

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/toaster/tox.ini | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 lib/toaster/tox.ini

diff --git a/lib/toaster/tox.ini b/lib/toaster/tox.ini
new file mode 100644
index 00000000..bcdfdb4f
--- /dev/null
+++ b/lib/toaster/tox.ini
@@ -0,0 +1,25 @@
+[tox]
+envlist =3D py310
+skipsdist =3D True
+toxworkdir =3D {env:TOX_WORKDIR:.tox}
+passenv =3D *
+
+[testenv]
+setenv =3D
+    DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_test
+    TOASTER_BUILDSERVER=3D1
+    EVENTREPLAY_DIR=3D{toxinidir}/../../../build/
+    BUILDDIR=3D{toxinidir}/../../../build/
+commands =3D
+    flake8
+    python3 {toxinidir}/manage.py test tests.db tests.commands tests.bui=
lds tests.browser tests.functional tests.views
+deps =3D=20
+    -r ../../toaster-requirements.txt
+    -r {toxinidir}/tests/toaster-tests-requirements.txt
+    flake8
+
+[flake8]
+ignore =3D E501, F403
+
+[testenv:chrome]
+commands=3D{[testenv]commands} --splinter-webdriver=3Dchrome
\ No newline at end of file
--=20
2.34.1


