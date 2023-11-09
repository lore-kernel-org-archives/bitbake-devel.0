Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E05CC4167D
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:44:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.368.1699551860465831538
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 09:44:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=pWuB/A0C;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C1C039C2CD7
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 12:44:19 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 27A82z5-kEC8; Thu,  9 Nov 2023 12:44:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 476E69C34BD;
	Thu,  9 Nov 2023 12:44:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 476E69C34BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699551859; bh=GesLj5+Tfp6+cElUD4N1oiRTqPVAwnFMvCqk+qYl7BU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=pWuB/A0CTHPwFRlHmDv4jb5be0SI/FtrDQHUU5clu153eTutXKbXs5VNlcFmf+h0+
	 pL5T8q8Q0WnrL59X6sLEad2ZB/izfsSYGfCsVSOG+p4JLxFje9lFWJhf4SjguYc6EX
	 cn2b1I1nnKR+gpZA858EttXlaHH0qraz6PmFrg1wazV8JWnLnoD7jsK7xbXvm6tFAB
	 yu7CoLPTrCUP7GpO4O+BYyuzVuoWgTQZKQ+shHSAl5zJppH1P7EQOCGw1g6ZLxQWMm
	 6Cj2scdGv4wfabRarzRCoJ0F/I0h9j8xw49nV7MnfVnTELV0zFlBrI4HX1wf7CKGiV
	 oL6r2ooMnm+hg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id T5hYskwqSAvV; Thu,  9 Nov 2023 12:44:19 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 62CD29C2CD7;
	Thu,  9 Nov 2023 12:44:18 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v5 3/6] Toaster: Bug-fix pytest and Failed: Database access not allowed
Date: Thu,  9 Nov 2023 18:44:09 +0100
Message-Id: <20231109174412.257199-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
References: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 17:44:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15480

Remove load and create build environment from tests/functional/functional=
_helpers
- Testcases in the FunctionalTestCase do not require a build process,
- Also marked setUpClass or class with pytest django_db, db ... not
  working, as declared above of file functional_helpers.py, The database =
access
  process runs as an external process, separate from the test case proces=
s
  and outside the context of pytest.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/functional_helpers.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toa=
ster/tests/functional/functional_helpers.py
index c3191f66..b80d403b 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -15,8 +15,6 @@ import time
 import re
=20
 from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
-from tests.builds.buildtest import load_build_environment
-from bldcontrol.models import BuildEnvironment
 from selenium.webdriver.common.by import By
 from selenium.common.exceptions import NoSuchElementException
=20
@@ -33,10 +31,6 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase)=
:
             raise RuntimeError("Please initialise django with the tests =
settings:  " \
                 "DJANGO_SETTINGS_MODULE=3D'toastermain.settings_test'")
=20
-        if BuildEnvironment.objects.count() =3D=3D 0:
-            BuildEnvironment.objects.create(betype=3DBuildEnvironment.TY=
PE_LOCAL)
-        load_build_environment()
-
         # start toaster
         cmd =3D "bash -c 'source toaster start'"
         p =3D subprocess.Popen(
--=20
2.34.1


