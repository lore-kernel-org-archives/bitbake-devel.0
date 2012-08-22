Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4GsB-0001YZ-PA for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 21:45:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJXjXc006091
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:33:45 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05660-06 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:33:40 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJXbLS006085
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:33:38 +0100
Message-ID: <1345664019.3907.135.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 20:33:39 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] cooker: Ensure parsing failures stop the build
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
X-List-Received-Date: Wed, 22 Aug 2012 19:45:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently parsing failures still allow bitbake to continue on and try
and execute a build. This is clearly a bad idea and this patch adds in
more correct error handling and stops the build.

The use of sys.exit is nasty but this patches other usage in this function
so is at least consisent and its better than the current situation of
trying to execure a half parsed set of recipes. There are probably better
ways this could be improved to use to stop the build.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 23fffc9..c0870b7 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1206,9 +1206,10 @@ class BBCooker:
 
         if not self.parser.parse_next():
             collectlog.debug(1, "parsing complete")
-            if not self.parser.error:
-                self.show_appends_with_no_recipes()
-                self.buildDepgraph()
+            if self.parser.error:
+                sys.exit(1)
+            self.show_appends_with_no_recipes()
+            self.buildDepgraph()
             self.state = state.running
             return None
 
@@ -1665,25 +1666,30 @@ class CookerParser(object):
             logger.error('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexception)))
             self.shutdown(clean=False)
+            return False
         except bb.parse.ParseError as exc:
             self.error += 1
             logger.error(str(exc))
             self.shutdown(clean=False)
+            return False
         except bb.data_smart.ExpansionError as exc:
             self.error += 1
             _, value, _ = sys.exc_info()
             logger.error('ExpansionError during parsing %s: %s', value.recipe, str(exc))
             self.shutdown(clean=False)
+            return False
         except SyntaxError as exc:
             self.error += 1
             logger.error('Unable to parse %s', exc.recipe)
             self.shutdown(clean=False)
+            return False
         except Exception as exc:
             self.error += 1
             etype, value, tb = sys.exc_info()
             logger.error('Unable to parse %s', value.recipe,
                          exc_info=(etype, value, exc.traceback))
             self.shutdown(clean=False)
+            return False
 
         self.current += 1
         self.virtuals += len(result)




