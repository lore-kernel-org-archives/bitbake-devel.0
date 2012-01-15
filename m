Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5z-00084x-7e
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:51 +0100
Received: by opal (Postfix, from userid 111)
	id A4BD610337; Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101510.A4BD610337@opal>
Date: Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/knotty: don't count errors as warnings in summary
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 15 Jan 2012 10:13:51 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: d242d6ca81dd83b2b13a3ac77ac4cd829a69cf83
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=d242d6ca81dd83b2b13a3ac77ac4cd829a69cf83

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:45 2012 +0000

bitbake/knotty: don't count errors as warnings in summary

The count of warnings being shown in the summary at the end was also
including the number of errors.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/ui/knotty.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 0340619..5366386 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -127,7 +127,7 @@ def main(server, eventHandler):
                 if event.levelno >= format.ERROR:
                     errors = errors + 1
                     return_value = 1
-                if event.levelno >= format.WARNING:
+                elif event.levelno == format.WARNING:
                     warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to 



