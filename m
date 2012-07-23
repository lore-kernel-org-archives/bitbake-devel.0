Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1StLs5-0008QQ-N8 for bitbake-devel@lists.openembedded.org;
	Mon, 23 Jul 2012 18:52:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6NGfBu7023797
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2012 17:41:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06321-10 for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2012 17:41:07 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6NGf2r3023790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2012 17:41:04 +0100
Message-ID: <1343061661.21788.106.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 23 Jul 2012 17:41:01 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] cooker.py: Ensure we track parser errors and only show bbappend issues on complete parse
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
X-List-Received-Date: Mon, 23 Jul 2012 16:52:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if any parsing failure occurs, there can be a long list of
bbappends that are "dangling" based on the fact that recipes were not
parsed. This change firstly ensures the error counter is incremented
and secondly that the bbappends list is only shown on a completed
parse list.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 361bc88..5d01af3 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1205,8 +1205,9 @@ class BBCooker:
 
         if not self.parser.parse_next():
             collectlog.debug(1, "parsing complete")
-            self.show_appends_with_no_recipes()
-            self.buildDepgraph()
+            if not self.parser.error:
+                self.show_appends_with_no_recipes()
+                self.buildDepgraph()
             self.state = state.running
             return None
 
@@ -1601,6 +1602,7 @@ class CookerParser(object):
                                             self.skipped, self.masked,
                                             self.virtuals, self.error,
                                             self.total)
+
             bb.event.fire(event, self.cfgdata)
             self.feeder_quit.put(None)
             for process in self.processes:
@@ -1658,20 +1660,25 @@ class CookerParser(object):
             self.shutdown()
             return False
         except ParsingFailure as exc:
+            self.error += 1
             logger.error('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexception)))
             self.shutdown(clean=False)
         except bb.parse.ParseError as exc:
+            self.error += 1
             logger.error(str(exc))
             self.shutdown(clean=False)
         except bb.data_smart.ExpansionError as exc:
+            self.error += 1
             _, value, _ = sys.exc_info()
             logger.error('ExpansionError during parsing %s: %s', value.recipe, str(exc))
             self.shutdown(clean=False)
         except SyntaxError as exc:
+            self.error += 1
             logger.error('Unable to parse %s', exc.recipe)
             self.shutdown(clean=False)
         except Exception as exc:
+            self.error += 1
             etype, value, tb = sys.exc_info()
             logger.error('Unable to parse %s', value.recipe,
                          exc_info=(etype, value, exc.traceback))




