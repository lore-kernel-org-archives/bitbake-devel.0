Return-Path: <jan.kiszka@siemens.com>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by mail.openembedded.org (Postfix) with ESMTP id 3830078A0F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Sep 2018 08:43:27 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w828hSq5029466
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 2 Sep 2018 10:43:28 +0200
Received: from [139.22.33.198] ([139.22.33.198])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w828hRQ2030401
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 2 Sep 2018 10:43:27 +0200
To: bitbake-devel@lists.openembedded.org
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <192b8cc1-4ea9-1cd7-5a3f-f4c150868a0e@siemens.com>
Date: Sun, 2 Sep 2018 10:43:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Subject: [PATCH] process: Flush server stdout/stderr before reporting failure
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
X-List-Received-Date: Sun, 02 Sep 2018 08:43:28 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

We need to print exceptions and flush output channels before telling the
client that the server failed. Otherwise the daemon log file may still
be empty when the client opens it for printing.

This fixes error reporting when the output is redirected to a pipe, e.g.
"bitbake target | cat" with a syntax error in a recipes or config file.
That's specifically annoying when bitbake is under the control of a
frontend process such as kas.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/bb/server/process.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 9e5e709f..bcc4eb40 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -29,6 +29,7 @@ import array
 import os
 import sys
 import time
+import traceback
 import select
 import socket
 import subprocess
@@ -435,7 +436,11 @@ class BitBakeServer(object):
         try:
             self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
             writer.send("ready")
-        except:
+        except (Exception, SystemExit) as e:
+            if type(e) != SystemExit:
+                traceback.print_exc()
+            sys.stdout.flush()
+            sys.stderr.flush()
             writer.send("fail")
             raise
         finally:
-- 
2.16.4

