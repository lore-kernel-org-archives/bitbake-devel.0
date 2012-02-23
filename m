Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S0ax0-0003j2-0F
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 16:51:22 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Feb 2012 07:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="111228891"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.61])
	by orsmga001.jf.intel.com with ESMTP; 23 Feb 2012 07:42:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 15:42:52 +0000
Message-Id: <e22cf3ce86bd3e323c67f0b905b2211efdd334a2.1330011581.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330011581.git.paul.eggleton@linux.intel.com>
References: <cover.1330011581.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330011581.git.paul.eggleton@linux.intel.com>
References: <cover.1330011581.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake: fix parse errors not being reported
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
X-List-Received-Date: Thu, 23 Feb 2012 15:51:22 -0000

Fixes a regression introduced in BitBake rev
c9f58ef6b897d3fa5b0d23734b5f2cb3dabb057a which prevents errors during
parsing from being fully reported because BitBake shuts down before it
can print them. Move the error printing to before the shutdown in order
to fix it.

Also, fix handling of general unexpected exceptions during parsing (i.e.
print out a usable stack trace).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f0778e5..5653874 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1605,22 +1605,18 @@ class CookerParser(object):
             self.shutdown()
             return False
         except ParsingFailure as exc:
-            self.shutdown(clean=False)
-            bb.fatal('Unable to parse %s: %s' %
+            logger.error('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexception)))
+            self.shutdown(clean=False)
         except (bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
+            logger.error(str(exc))
             self.shutdown(clean=False)
-            bb.fatal(str(exc))
         except SyntaxError as exc:
-            self.shutdown(clean=False)
             logger.error('Unable to parse %s', exc.recipe)
-            sys.exit(1)
+            self.shutdown(clean=False)
         except Exception as exc:
-            etype, value, tb = sys.exc_info()
-            logger.error('Unable to parse %s', value.recipe,
-                         exc_info=(etype, value, exc.traceback))
+            logger.error('Error during parsing %s: %s\n%s' % (exc.recipe, str(exc), ''.join(bb.exceptions.format_extracted(exc.traceback, limit=5))))
             self.shutdown(clean=False)
-            sys.exit(1)
 
         self.current += 1
         self.virtuals += len(result)
-- 
1.7.5.4



