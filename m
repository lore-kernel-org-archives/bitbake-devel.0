Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web08.8111.1628691633835876983
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Aug 2021 07:20:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E0C7C1C0009;
	Wed, 11 Aug 2021 14:20:31 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: replace "file name" by "filename"
Date: Wed, 11 Aug 2021 16:20:23 +0200
Message-Id: <20210811142023.161649-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are many more instances of "filename" or "filenames" than
of "file name" or "file names".

The winner takes it all!

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst      | 2 +-
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b0494d08..ff60381f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1941,7 +1941,7 @@ Wildcard Support in Variables
 =============================
 
 Support for wildcard use in variables varies depending on the context in
-which it is used. For example, some variables and file names allow
+which it is used. For example, some variables and filenames allow
 limited use of wildcards through the "``%``" and "``*``" characters.
 Other variables or names support Python's
 `glob <https://docs.python.org/3/library/glob.html>`_ syntax,
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 6283c265..d97bb259 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -335,7 +335,7 @@ overview of their function and contents.
    :term:`BB_LOGFMT`
       Specifies the name of the log files saved into
       ``${``\ :term:`T`\ ``}``. By default, the :term:`BB_LOGFMT`
-      variable is undefined and the log file names get created using the
+      variable is undefined and the log filenames get created using the
       following form::
 
          log.{task}.{pid}
@@ -389,7 +389,7 @@ overview of their function and contents.
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the
-      :term:`BB_RUNFMT` variable is undefined and the run file names get
+      :term:`BB_RUNFMT` variable is undefined and the run filenames get
       created using the following form::
 
          run.{task}.{pid}
-- 
2.25.1

