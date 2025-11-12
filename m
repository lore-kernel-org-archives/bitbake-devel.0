Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A52CD4851
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 22:03:23 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9774.1762984998700693639
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 14:03:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=Q0CWpYxy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1329275-20251112220316a040458ca800020721-pyqy1y@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251112220316a040458ca800020721
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 12 Nov 2025 23:03:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mUGmwZHuVBVd8c0uF8XbXyjSqEmDfXXrwORkTfEtdRw=;
 b=Q0CWpYxy4FNsyMTZkuiEWoEv9IYPpuHkxBVlFbJ0rSIAnAMql59JCVpxoCBaFbfVdulXVX
 V0lhfDHnMvS/9R1HYlGNdCGhDrV/fNGPhU817RbVWsJAQH3goBM1rjjsGd7zLyNpSWRi15Ya
 5GMzGogKuRz+ZAbhRalpfYJrOl/5QxGmyNzqVjwytCYSMQwvS9HtzaEERG83Jlu1WRodBPD6
 cObICP8VIN9yZfntEg0GdlJEePXojPjZUaUqt7PylXZj5dFHSXK/5/to9BAl6hzLw2hnlMtJ
 0HFsUYkLMnUG0NrfIf7eTrfUPyd++thoSdcJh0UMqodBRX+E2lK3uNUw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 2/2] bitbake-selftest: setup: default to cwd for top-dir-prefix
Date: Wed, 12 Nov 2025 23:03:01 +0100
Message-ID: <20251112220301.3651499-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251112220301.3651499-1-adrian.freihofer@siemens.com>
References: <20251112220301.3651499-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 22:03:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18364

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Change to tempdir before the test starts. Then check if the tests run
from cwd which is now the default top-dir-prefix.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 6e9bf0365..73ba3b2bc 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -239,12 +239,15 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # check that --help works
         self.runbbsetup("--help")
 
-        # set up global location for top-dir-prefix
-        out = self.runbbsetup("settings set --global default top-dir-prefix {}".format(self.tempdir))
+        # change to self.tempdir to work with cwd-based default settings
+        os.chdir(self.tempdir)
+
+        # check that the default top-dir-prefix is cwd (now self.tempdir) with no global settings
+        out = self.runbbsetup("settings list")
+        self.assertIn("default top-dir-prefix {}".format(os.getcwd()), out[0])
+
+        # set up global location for dl-dir
         settings_path = "{}/global-config".format(self.tempdir)
-        self.assertIn(settings_path, out[0])
-        self.assertIn("From section 'default' the setting 'top-dir-prefix' was changed to", out[0])
-        self.assertIn("Settings written to".format(settings_path), out[0])
         out = self.runbbsetup("settings set --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
         self.assertIn("From section 'default' the setting 'dl-dir' was changed to", out[0])
         self.assertIn("Settings written to".format(settings_path), out[0])
-- 
2.51.1


