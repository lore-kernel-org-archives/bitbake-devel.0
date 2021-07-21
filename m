Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web12.2098.1626889030935222760
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jul 2021 10:37:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id E8297240005;
	Wed, 21 Jul 2021 17:37:08 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: update bitbake option help
Date: Wed, 21 Jul 2021 19:36:57 +0200
Message-Id: <20210721173657.26846-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index b3cea61f..7c29c8c0 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -417,8 +417,8 @@ Following is the usage and syntax for BitBake::
      -l DEBUG_DOMAINS, --log-domains=DEBUG_DOMAINS
                            Show debug logging for the specified logging domains
      -P, --profile         Profile the command and save reports.
-     -u UI, --ui=UI        The user interface to use (knotty, ncurses or taskexp
-                           - default knotty).
+     -u UI, --ui=UI        The user interface to use (knotty, ncurses, taskexp or
+                           teamcity - default knotty).
      --token=XMLRPCTOKEN   Specify the connection token to be used when
                            connecting to a remote server.
      --revisions-changed   Set the exit code depending on whether upstream
@@ -433,6 +433,9 @@ Following is the usage and syntax for BitBake::
                            Environment variable BB_SERVER_TIMEOUT.
      --no-setscene         Do not run any setscene tasks. sstate will be ignored
                            and everything needed, built.
+     --skip-setscene       Skip setscene tasks if they would be executed. Tasks
+                           previously restored from sstate will be kept, unlike
+                           --no-setscene
      --setscene-only       Only run setscene tasks, don't run any real tasks.
      --remote-server=REMOTE_SERVER
                            Connect to the specified server.
-- 
2.25.1

