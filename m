Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B9E7F74598
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Aug 2019 11:31:27 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7FBVSLY022689
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Aug 2019 04:31:28 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Thu, 15 Aug 2019 04:31:28 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Aug 2019 19:56:51 +0800
Message-ID: <e1c4b93b2596e6c3aca25edc8791e217cdd428b7.1565870107.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1565870107.git.liezhi.yang@windriver.com>
References: <cover.1565870107.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: server/process: Handle BBHandledException to avoid unexpected exceptions
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
X-List-Received-Date: Thu, 15 Aug 2019 11:31:27 -0000
Content-Type: text/plain

The parseBaseConfiguration() raises bb.BBHandledException(), but
BitBakeServer() didn't handle it, so we always got unexpected exceptions when
there were errors. For example:

=== Case 1:
* Add "print "hello"' in base.bbclass' def oe_import() function
def oe_import(d):
    print "hello"
[snip]

$ bitbake -p
ERROR: Unable to start bitbake server (None)
ERROR: Last 60 lines of server log for this session (/buildarea1/lyang1/test_hy/bitbake-cookerdaemon.log):
  File "/buildarea1/lyang1/poky/meta/classes/base.bbclass", line 21
    print "hello"
                ^
SyntaxError: Missing parentheses in call to 'print'

<The first exception>
During handling of the above exception, another exception occurred:
<Tracebacks>

<The second exception>
During handling of the above exception, another exception occurred:
<Tracebacks>

<The third exception>
During handling of the above exception, another exception occurred:
<Tracebacks>
[snip]

Now it looks like:
$ bitbake -p
ERROR: Unable to start bitbake server (None)
ERROR: Server log for this session (/buildarea1/lyang1/test_hy/bitbake-cookerdaemon.log):
ERROR: Error in compiling python function in /buildarea1/lyang1/poky/meta/classes/base.bbclass, line 21:

The code lines resulting in this error were:
     0001:def oe_import(d):
 *** 0002:    print "hello"
     0003:    import sys
     0004:
     0005:    bbpath = d.getVar("BBPATH").split(":")
     0006:    sys.path[0:0] = [os.path.join(dir, "lib") for dir in bbpath]
SyntaxError: Missing parentheses in call to 'print' (base.bbclass, line 21)

=== Case 2:
* Add 'HOSTTOOLS += "hello"' to conf/local.conf:
$ bitbake -p
ERROR: Unable to start bitbake server (None)
ERROR: Server log for this session (/buildarea1/lyang1/test_hy/bitbake-cookerdaemon.log):
<Tracebacks>
[snip]
During handling of the above exception, another exception occurred:
[snip]
<Tracebacks>
ERROR: The following required tools (as specified by HOSTTOOLS) appear to be unavailable in PATH, please install them in order to proceed:
  hello

The error message is printed by bb.fatal() which raises bb.BBHandledException(),
but BitBakeServer() doesn't handle it, so we got it.

Now it looks like:
ERROR: Unable to start bitbake server (None)
ERROR: Server log for this session (/buildarea1/lyang1/test_hy/bitbake-cookerdaemon.log):
ERROR: The following required tools (as specified by HOSTTOOLS) appear to be unavailable in PATH, please install them in order to proceed:
  hello

No unexpected exceptions anymore.

[YOCTO #13267]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/server/process.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index f901fe5..69aae62 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -456,7 +456,10 @@ class BitBakeServer(object):
         self.configuration.setServerRegIdleCallback(server.register_idle_function)
         os.close(self.readypipe)
         writer = ConnectionWriter(self.readypipein)
-        self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
+        try:
+            self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
+        except bb.BBHandledException:
+            return None
         writer.send("r")
         writer.close()
         server.cooker = self.cooker
-- 
2.7.4


