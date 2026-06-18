Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB701CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 13:25:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19526.1781789120096478828
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 06:25:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GzSlyrP9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so7042555e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781789118; x=1782393918; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLvQ12BqENHM4b9OfCGcZNux3yJUcQv9qtY9G0vjJOk=;
        b=GzSlyrP9c0In1upvabyQaVPDEo6eO7NXuyWtr26uAwHzOCYZuwAOBnAR+lEOYgEHT/
         N5v3rc78KuJAetcb60C5um6ym2el6QstQPbtrJy3BH+BsIkz6lQ3Jm60vwjW67L3N20I
         lIpjl/OrEquUf5mkvbMI+Pl9vhBwl0dDunhyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789118; x=1782393918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLvQ12BqENHM4b9OfCGcZNux3yJUcQv9qtY9G0vjJOk=;
        b=os+XDufGZ/kk5+cILCliNYF8Tj4gLtZLCMo86HXlTuEs7d1YrGhC7D0S4HgsOQGeka
         kvhtjxf2WY1PhcHSj/yuRnmK0F47lGU9COHtjMAJVDeCix7ZmBfzXZ2UBcZrYiKIsldr
         JtRhFhXqyY2gAgz/yNT9zQwr3d1ttV2IvAbVSaz6gDyF6kTUBlseVYiNu27utTWsfQpg
         uoor0mnfMdniRa2M95GNEiVPtiDlek6orsMCwJDePtMWerOAbr1APpSuzwHrOZafmGuw
         y1l7g+kEhMxhmS8UH4jwP7ZUkKxi7sLFFmSufvUs3w5n1hYV9X8swtxTv6sl/XsVRmAp
         UKdQ==
X-Gm-Message-State: AOJu0YywL2hHNZQMkN79BBrrAiY7B1/QZFla2Cc3xaMYAvKfkMT/+I4T
	YBYBRVMKvzDvy+eNWnAWsmBZTQLmSCx0qLrh0caKyAPnxF3OshUgeLNGvAgaLSPRmUfHAF1AiVQ
	Ua3OY
X-Gm-Gg: AfdE7ckuTTvJCT/Vg0GPUqlUS37iSeZev8RC+saAbt9I9G1kW+1rU47T8CHylnTXBKS
	JKz/sZo+EzjWBEOlRB/ncIpyTVTP66TBfTgMRCrkmmcLZDHOw1YTz/uOtOAReBz8uXCVym0joEr
	mNCh0h308y8a6GozMIhdB3GQk2bfQQIUylk0W1HW7rfhHfxk04iPrz+ChKT76hydwsNtrkbCSjZ
	QcmQVuVV+/JqBhwo2amYDyicC5XGYXduumfZVZRz5k7pEMTWv5kHHJ3CfnKszssAw5inP6Z1jM1
	d9s9sT82j8MYCpgiGSY+PGJKQ5BIAvvSIPNhd9vb5nzwZvO0+ODBOOEkfZsB7JV5LcF7q1ugDbb
	s6QZDUfzWuAvpzP2nZsxmLmRV78O8hT4EDVzzY5ChvxFbSUDYSDf3GBlSrfqZVhJYaY4IaCt1wq
	cCzIqsZsgvLccChxQXqBCcSjQ8jC+B25Hz9L1JuB/mOw==
X-Received: by 2002:a05:600c:c84:b0:492:259d:567 with SMTP id 5b1f17b1804b1-4923412f44emr120918275e9.23.1781789117315;
        Thu, 18 Jun 2026 06:25:17 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:70bd:e97f:6372:90f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f264333sm66061992f8f.4.2026.06.18.06.25.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:25:16 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bin/*: Add/improve __version__ processing
Date: Thu, 18 Jun 2026 14:25:15 +0100
Message-ID: <20260618132515.4145843-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 13:25:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19739

Add __version__ entries to hashserv and prserv libraries, then update
all the bin/* scripts to verify the library versions they get match
themselves.

We've avoided doing this for maintenance reasons but with the possibility
of finding a pypi based bitbake and mismatching, we really need to do this
now.

A couple of existing version strings were replaced with a more standard
format so it is easy to update.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake              |  2 +-
 bin/bitbake-diffsigs     |  7 +++++++
 bin/bitbake-getvar       |  6 ++++++
 bin/bitbake-hashclient   |  8 ++++++++
 bin/bitbake-hashserv     |  7 +++++--
 bin/bitbake-layers       |  6 ++++++
 bin/bitbake-prserv       | 10 +++++++---
 bin/bitbake-selftest     |  5 +++++
 bin/bitbake-server       |  6 ++++++
 bin/bitbake-setup        |  6 ++++++
 bin/bitbake-worker       |  6 ++++++
 bin/toaster              |  2 ++
 bin/toaster-eventreplay  |  7 +++++++
 lib/bb/main.py           |  2 +-
 lib/hashserv/__init__.py |  2 ++
 lib/prserv/__init__.py   |  2 +-
 16 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index fd5511c62ab..0f155158c26 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -31,7 +31,7 @@ __version__ = "2.19.0"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
-        sys.exit("Bitbake core version and program version mismatch!")
+        sys.exit("Bitbake core library version and program version mismatch!")
     try:
         sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
                               cookerdata.CookerConfiguration()))
diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 9d6cb8c944b..25a8d30684f 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -22,6 +22,13 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
 import bb.tinfoil
 import bb.siggen
 import bb.msg
+from bb import __version__ as libbb_version
+
+__version__ = "2.19.0"
+
+if __version__ != libbb_version:
+    sys.exit("Bitbake core library version and program version mismatch!")
+
 
 myname = os.path.basename(sys.argv[0])
 logger = bb.msg.logger_create(myname)
diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 378fb135724..0ee33cfba90 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -19,8 +19,14 @@ sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
 import bb.providers
 import bb.tinfoil
+from bb import __version__ as libbb_version
+
+__version__ = "2.19.0"
 
 if __name__ == "__main__":
+    if __version__ != libbb_version:
+        sys.exit("Bitbake core library version and program version mismatch!")
+
     parser = argparse.ArgumentParser(description="Bitbake Query Variable")
     parser.add_argument("variable", help="variable name to query")
     parser.add_argument("-r", "--recipe", help="Recipe name to query", default=None, required=False)
diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index b8755c57976..3a2bf5c0d35 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -20,6 +20,8 @@ import statistics
 import textwrap
 warnings.simplefilter("default")
 
+__version__ = "2.19.0"
+
 try:
     import tqdm
     ProgressBar = tqdm.tqdm
@@ -41,6 +43,12 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib
 
 import hashserv
 import bb.asyncrpc
+from bb import __version__ as libbb_version
+
+if __version__ != libbb_version:
+    sys.exit("Bitbake core library version and program version mismatch!")
+if __version__ != hashserv.__version__:
+    sys.exit("Bitbake hashserv library version and program version mismatch!")
 
 DEFAULT_ADDRESS = 'unix://./hashserve.sock'
 METHOD = 'stress.test.method'
diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 01503736b93..4818584e9fa 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -12,6 +12,8 @@ import argparse
 import sqlite3
 import warnings
 
+__version__ = "2.19.0"
+
 warnings.simplefilter("default")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "lib"))
@@ -19,14 +21,15 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "lib
 import hashserv
 from hashserv.server import DEFAULT_ANON_PERMS
 
-VERSION = "1.0.0"
+if __version__ != hashserv.__version__:
+    sys.exit("Bitbake library hashserv version and program version mismatch!")
 
 DEFAULT_BIND = "unix://./hashserve.sock"
 
 
 def main():
     parser = argparse.ArgumentParser(
-        description="Hash Equivalence Reference Server. Version=%s" % VERSION,
+        description="Hash Equivalence Reference Server. Version=%s" % __version__,
         formatter_class=argparse.RawTextHelpFormatter,
         epilog="""
 The bind address may take one of the following formats:
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index c49a5f30eef..afbf50666df 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -17,6 +17,8 @@ import argparse
 import warnings
 warnings.simplefilter("default")
 
+__version__ = "2.19.0"
+
 bindir = os.path.dirname(__file__)
 toolname = os.path.basename(__file__).split(".")[0]
 topdir = os.path.dirname(bindir)
@@ -25,6 +27,10 @@ sys.path[0:0] = [os.path.join(topdir, 'lib')]
 import bb.tinfoil
 import bb.cooker
 import bb.msg
+from bb import __version__ as libbb_version
+
+if __version__ != libbb_version:
+    sys.exit("Bitbake library version and program version mismatch!")
 
 logger = bb.msg.logger_create(toolname, sys.stdout)
 
diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 3992e84eab0..c26362b2e18 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -11,12 +11,16 @@ import argparse
 import warnings
 warnings.simplefilter("default")
 
+__version__ = "2.19.0"
+
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "lib"))
 
 import prserv
 import prserv.serv
-
-VERSION = "2.0.0"
+ 
+if __name__ == "__main__":
+    if __version__ != prserv.__version__:
+        sys.exit("Bitbake prserv library version and program version mismatch!")
 
 PRHOST_DEFAULT="0.0.0.0"
 PRPORT_DEFAULT=8585
@@ -30,7 +34,7 @@ def init_logger(logfile, loglevel):
 
 def main():
     parser = argparse.ArgumentParser(
-        description="BitBake PR Server. Version=%s" % VERSION,
+        description="BitBake PR Server. Version=%s" % __version__,
         formatter_class=argparse.RawTextHelpFormatter)
 
     parser.add_argument(
diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index fb7c57dd837..7f6a6443823 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -11,6 +11,8 @@ import warnings
 warnings.simplefilter("default")
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib'))
 
+__version__ = "2.19.0"
+
 import unittest
 try:
     import bb
@@ -20,6 +22,9 @@ try:
 except RuntimeError as exc:
     sys.exit(str(exc))
 
+if __version__ != bb.__version__:
+    sys.exit("Bitbake core library version and program version mismatch!")
+
 tests = ["bb.tests.codeparser",
          "bb.tests.color",
          "bb.tests.cooker",
diff --git a/bin/bitbake-server b/bin/bitbake-server
index 1428f72a7e5..6860876b7ca 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -12,6 +12,8 @@ warnings.simplefilter("default")
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
+__version__ = "2.19.0"
+
 import bb
 
 bb.utils.check_system_locale()
@@ -23,6 +25,10 @@ if len(sys.argv) != 11 or not sys.argv[1].startswith("decafbad"):
 
 import bb.server.process
 
+if __name__ == "__main__":
+    if __version__ != bb.__version__:
+        sys.exit("Bitbake core library version and program version mismatch!")
+
 lockfd = int(sys.argv[2])
 readypipeinfd = int(sys.argv[3])
 logfile = sys.argv[4]
diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2829e753e14..9537e721c9a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -21,12 +21,18 @@ import sys
 import textwrap
 import time
 
+__version__ = "2.19.0"
 
 bindir = os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
 
 import bb.msg  # noqa: E402
 import bb.process  # noqa: E402
+from bb import __version__ as libbb_version
+
+if __name__ == "__main__":
+    if __version__ != libbb_version:
+        sys.exit("Bitbake core library version and program version mismatch!")
 
 logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
 
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 5f3fd993394..29d8cdcff4b 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -25,6 +25,12 @@ import subprocess
 import fcntl
 from threading import Thread
 
+__version__ = "2.19.0"
+ 
+if __name__ == "__main__":
+    if __version__ != bb.__version__:
+        sys.exit("Bitbake core library version and program version mismatch!")
+
 Lock = bb.multiprocessing.Lock
 
 # Remove when we have a minimum of python 3.10
diff --git a/bin/toaster b/bin/toaster
index 16a64bab60e..51bad203da1 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -7,6 +7,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 
+__version__ = "2.19.0"
+
 HELP="
 Usage 1: source toaster start|stop [webport=<address:port>] [noweb] [nobuild] [toasterdir]
     Optional arguments:
diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 74a319320e2..30767f95675 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -31,6 +31,13 @@ sys.path.insert(0, join(dirname(dirname(abspath(__file__))), 'lib'))
 import bb.cooker
 from bb.ui import toasterui
 from bb.ui import eventreplay
+from bb import __version__ as libbb_version
+
+__version__ = "2.19.0"
+
+if __name__ == "__main__":
+    if __version__ != libbb_version:
+        sys.exit("Bitbake core library version and program version mismatch!")
 
 def main(argv):
     with open(argv[-1]) as eventfile:
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 597cb278464..73a66468fef 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -316,7 +316,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         options = parser.parse_intermixed_args(argv[1:])
 
         if options.version:
-            print("BitBake Build Tool Core version %s" % bb.__version__)
+            print("BitBake Build Tool version %s" % bb.__version__)
             sys.exit(0)
 
         if options.quiet and options.verbose:
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index ba8e0accea6..39bb29da5b5 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -12,6 +12,8 @@ from collections import namedtuple
 from urllib.parse import urlparse
 from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS
 
+__version__ = "2.19.0"
+
 User = namedtuple("User", ("username", "permissions"))
 
 UNIHASH_REGEX = re.compile(r"^[0-9a-f]{64}$")
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index ffc5a40a287..b30249b13b1 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -5,7 +5,7 @@
 #
 
 
-__version__ = "2.0.0"
+__version__ = "2.19.0"
 
 import logging
 logger = logging.getLogger("BitBake.PRserv")

