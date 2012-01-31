Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsI9g-00032i-MK
	for bitbake-devel@lists.openembedded.org;
	Tue, 31 Jan 2012 19:10:08 +0100
Received: by opal (Postfix, from userid 111)
	id D60741032F; Tue, 31 Jan 2012 17:50:21 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120131175021.D60741032F@opal>
Date: Tue, 31 Jan 2012 17:50:21 +0000 (UTC)
From: git@git.openembedded.org
Subject: Christopher Larson : cooker: add missing shutdowns to the exception handling
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
X-List-Received-Date: Tue, 31 Jan 2012 18:10:08 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: c9f58ef6b897d3fa5b0d23734b5f2cb3dabb057a
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=c9f58ef6b897d3fa5b0d23734b5f2cb3dabb057a

Author: Christopher Larson <chris_larson@mentor.com>
Date:   Tue Jan 31 11:47:07 2012 -0600

cooker: add missing shutdowns to the exception handling

Signed-off-by: Christopher Larson <chris_larson@mentor.com>

---

 lib/bb/cooker.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b6bd740..ac99e91 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1519,8 +1519,10 @@ class CookerParser(object):
             bb.fatal('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexception)))
         except (bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
+            self.shutdown(clean=False)
             bb.fatal(str(exc))
         except SyntaxError as exc:
+            self.shutdown(clean=False)
             logger.error('Unable to parse %s', exc.recipe)
             sys.exit(1)
         except Exception as exc:



