Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7821071A8C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Mar 2017 00:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490573857; x=1522109857;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=60sKHLvSLHodL2of9gIMHkxOXSvHxDy34Xzd1KLzJAc=;
	b=vBsGO144E6CS52qgAMpZX4+hxd5TR611clYBB7n9Mcy3YKMsylnk38sw
	ks4KBJdHlzmpR5JKXk2AqvlB+MY+cA==;
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Mar 2017 17:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,229,1486454400"; d="scan'208";a="80843989"
Received: from tienhauh-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.171.185])
	by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2017 17:17:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Mar 2017 13:17:27 +1300
Message-Id: <732c1cebd0c0c4c1772d4ae9cc4de3e01bbd17af.1490573768.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1490573768.git.paul.eggleton@linux.intel.com>
References: <cover.1490573768.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] lib/bb/msg: introduce logger_create() function
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 27 Mar 2017 00:17:35 -0000

We use this code to set up a logger with colour in a number of different
places, so create one function that does this and make some of bitbake's
utility scripts use it.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 14 ++------------
 bin/bitbake-dumpsig  | 14 ++------------
 bin/bitbake-layers   | 25 +++++--------------------
 lib/bb/msg.py        | 15 +++++++++++++++
 4 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index c087f99..1e3de09 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -30,19 +30,9 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
 
 import bb.tinfoil
 import bb.siggen
+import bb.msg
 
-def logger_create(name, output=sys.stderr):
-    logger = logging.getLogger(name)
-    console = logging.StreamHandler(output)
-    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-    if output.isatty():
-        format.enable_color()
-    console.setFormatter(format)
-    logger.addHandler(console)
-    logger.setLevel(logging.INFO)
-    return logger
-
-logger = logger_create('bitbake-diffsigs')
+logger = bb.msg.logger_create('bitbake-diffsigs')
 
 def find_compare_task(bbhandler, pn, taskname):
     """ Find the most recent signature files for the specified PN/task and compare them """
diff --git a/bin/bitbake-dumpsig b/bin/bitbake-dumpsig
index 38efd22..95ebd93 100755
--- a/bin/bitbake-dumpsig
+++ b/bin/bitbake-dumpsig
@@ -29,19 +29,9 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
 
 import bb.tinfoil
 import bb.siggen
+import bb.msg
 
-def logger_create(name, output=sys.stderr):
-    logger = logging.getLogger(name)
-    console = logging.StreamHandler(output)
-    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-    if output.isatty():
-        format.enable_color()
-    console.setFormatter(format)
-    logger.addHandler(console)
-    logger.setLevel(logging.INFO)
-    return logger
-
-logger = logger_create('bitbake-dumpsig')
+logger = bb.msg.logger_create('bitbake-dumpsig')
 
 def find_siginfo_task(bbhandler, pn, taskname):
     """ Find the most recent signature file for the specified PN/task """
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 66fc7ca..390ad05 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -30,26 +30,9 @@ topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
 import bb.tinfoil
+import bb.msg
 
-def logger_create(name, output=sys.stderr):
-    logger = logging.getLogger(name)
-    loggerhandler = logging.StreamHandler(output)
-    loggerhandler.setFormatter(logging.Formatter("%(levelname)s: %(message)s"))
-    logger.addHandler(loggerhandler)
-    logger.setLevel(logging.INFO)
-    return logger
-
-def logger_setup_color(logger, color='auto'):
-    from bb.msg import BBLogFormatter
-    console = logging.StreamHandler(sys.stdout)
-    formatter = BBLogFormatter("%(levelname)s: %(message)s")
-    console.setFormatter(formatter)
-    logger.handlers = [console]
-    if color == 'always' or (color == 'auto' and console.stream.isatty()):
-        formatter.enable_color()
-
-
-logger = logger_create('bitbake-layers', sys.stdout)
+logger = bb.msg.logger_create('bitbake-layers', sys.stdout)
 
 def main():
     parser = argparse.ArgumentParser(
@@ -74,7 +57,9 @@ def main():
     elif global_args.quiet:
         logger.setLevel(logging.ERROR)
 
-    logger_setup_color(logger, global_args.color)
+    # Need to re-run logger_create with color argument
+    # (will be the same logger since it has the same name)
+    bb.msg.logger_create('bitbake-layers', output=sys.stdout, color=global_args.color)
 
     plugins = []
     tinfoil = bb.tinfoil.Tinfoil(tracking=True)
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index b7c39fa..90b1582 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -201,3 +201,18 @@ def fatal(msgdomain, msg):
         logger = logging.getLogger("BitBake")
     logger.critical(msg)
     sys.exit(1)
+
+def logger_create(name, output=sys.stderr, level=logging.INFO, preserve_handlers=False, color='auto'):
+    """Standalone logger creation function"""
+    logger = logging.getLogger(name)
+    console = logging.StreamHandler(output)
+    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    if color == 'always' or (color == 'auto' and output.isatty()):
+        format.enable_color()
+    console.setFormatter(format)
+    if preserve_handlers:
+        logger.addHandler(console)
+    else:
+        logger.handlers = [console]
+    logger.setLevel(level)
+    return logger
-- 
2.9.3


