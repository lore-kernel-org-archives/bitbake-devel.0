Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E999CDE000
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12947.1782321619328716956
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=mNoT2d/8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxO2602576;
	Wed, 24 Jun 2026 10:20:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=L5KksOtieDECjFnMFcVVqxfMSodcL9Z/WUAEbqcyXfg=; b=
	mNoT2d/8XK2RaFksnhx3JrP4QzwjTGNEaSZ8k6f44+BhqRqWED1vEDhvFFQscwZt
	1Chm6CeI9wddoObImbn78mw2V4+UM9148DXsUGtkYuj2caNKexq8H6FTOfDxSiK8
	/ebpJYBCR/8Q6BcUoRfo7U/DLaeihf/N/fZGDk+I7ukeohAfwQh4TIHEF3Mvmxgm
	1JZRMf6cFlfXOHP5qJbHaiDrw02g6lpzx+hfVC6s43c8KM9XMy4zEVu9y+iCtuHn
	KblsuJhR4cNuBeg2LmxHpkjAqJZDy/cqbr2X2feh0RM9IfgNr3OmTXLjTQ0NL/G+
	Kc+c7EdcqrWKmo9ipkUG4g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Jun 2026 10:20:17 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:12 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:12 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:01 -0700
Subject: [PATCH v4 01/11] bin/*: Add/improve __version__ processing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-add-pypi-v8-v4-1-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Richard Purdie
	<richard.purdie@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX2jWXU1VIjDbD
 G7R6rRKjxjb7md0hOkhDuGNcdo9SuL5jrNCqcJ7AYsT7TcrnyuP0566UFwX1qYDE7L5g2flSBkF
 zNsDnS0XKt0jO4cyfyt8SHgYDbWlrYEYTN4WdKN1czfk69DCpSV4AlMRmlt39zFg/ZYBAbWcVt8
 G6cAdHd+QP1XMcS2dclkaWDqCgjdd8TMpKXLiu2OrpwqrX5laPBn3Q5aScjoO9/BQ4Gdu8uClAh
 52TMxM4IOmcgmdWrtVFNXYxuzsKUlf3d4UKH61VlxjkWe3D32DmIkRGo3ENWAujf7UVIdXjKbjg
 4Tr0zO+PNJZRGNWqgll7CPshhH0b1OdDOM9cTLzIzp3J5nB7/Tpr6fLWy80Mg55r83gqaRYlgdt
 KcroN7Ltwjkzquyl45u4UJJX0SKAgg==
X-Proofpoint-ORIG-GUID: K5RHXYEgTeYVS3Zrz3qJywOorcURoq68
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX/oIw/96+tgf3
 QzUN/6ebjW8CSdYeoZTxhHjSERMmtmGAXqeRgeUfOBMtXBYnN4btpzuZ7hLsGi698kqjHmo8Eu6
 tIK1TCx2j408fSh4eRqUiTDLnZm/qd5sVKBlGPWZ/9dpzUkoSrPD
X-Proofpoint-GUID: K5RHXYEgTeYVS3Zrz3qJywOorcURoq68
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11d1 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=ag1SF4gXAAAA:8
 a=AZ9A8onwP7jMkqFZqIcA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19768

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
 bin/bitbake              | 2 +-
 bin/bitbake-diffsigs     | 7 +++++++
 bin/bitbake-getvar       | 6 ++++++
 bin/bitbake-hashclient   | 8 ++++++++
 bin/bitbake-hashserv     | 7 +++++--
 bin/bitbake-layers       | 6 ++++++
 bin/bitbake-prserv       | 8 ++++++--
 bin/bitbake-selftest     | 5 +++++
 bin/bitbake-server       | 6 ++++++
 bin/bitbake-setup        | 6 ++++++
 bin/bitbake-worker       | 6 ++++++
 bin/toaster              | 2 ++
 bin/toaster-eventreplay  | 7 +++++++
 lib/bb/main.py           | 2 +-
 lib/hashserv/__init__.py | 2 ++
 lib/prserv/__init__.py   | 2 +-
 16 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index fd5511c62..0f155158c 100755
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
index 9d6cb8c94..25a8d3068 100755
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
index 378fb1357..0ee33cfba 100755
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
index b8755c579..3a2bf5c0d 100755
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
index 01503736b..4818584e9 100755
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
index c49a5f30e..afbf50666 100755
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
index 3992e84ea..d46c38516 100755
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
 
-VERSION = "2.0.0"
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
index fb7c57dd8..7f6a64438 100755
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
index 1428f72a7..6860876b7 100755
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
index 664bffee3..d1e40c9a6 100755
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
index aa14ef191..400737126 100755
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
index 16a64bab6..51bad203d 100755
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
index 74a319320..30767f956 100755
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
index 597cb2784..73a66468f 100755
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
index ba8e0acce..39bb29da5 100644
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
index ffc5a40a2..b30249b13 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -5,7 +5,7 @@
 #
 
 
-__version__ = "2.0.0"
+__version__ = "2.19.0"
 
 import logging
 logger = logging.getLogger("BitBake.PRserv")

-- 
2.49.0


