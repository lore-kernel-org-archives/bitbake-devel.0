Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qrslb-0005bF-2M for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 16:31:19 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CEQkCH012744
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 15:26:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12087-07 for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 15:26:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CEQcu2012738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 15:26:38 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 12 Aug 2011 15:25:58 +0100
Message-ID: <1313159158.14274.491.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/msg.py: Drop manually created domain lists
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
X-List-Received-Date: Fri, 12 Aug 2011 14:31:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patch removes the majority of the domain related code from bb.msg
on the grounds that we now support dynamic creation of logging domains
so having this hardcoded is just error prone and less flexible. It also
makes the msg code overly and needlessly complex.

It also removes the bb.msg.debug/note/warn/plain/error functions since
we might as well remove them rather than try and fix them at this point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index a3f8795..19b9045 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -94,35 +94,6 @@ class BBLogFilter(object):
         return False
 
 
-class Loggers(dict):
-    def __getitem__(self, key):
-        if key in self:
-            return dict.__getitem__(self, key)
-        else:
-            log = logging.getLogger("BitBake.%s" % domain._fields[key])
-            dict.__setitem__(self, key, log)
-            return log
-
-def _NamedTuple(name, fields):
-    Tuple = collections.namedtuple(name, " ".join(fields))
-    return Tuple(*range(len(fields)))
-
-domain = _NamedTuple("Domain", (
-    "Default",
-    "Build",
-    "Cache",
-    "Collection",
-    "Data",
-    "Depends",
-    "Fetcher",
-    "Parsing",
-    "PersistData",
-    "Provider",
-    "RunQueue",
-    "TaskData",
-    "Util"))
-logger = logging.getLogger("BitBake")
-loggers = Loggers()
 
 # Message control functions
 #
@@ -152,11 +123,6 @@ def addDefaultlogFilter(handler):
     for (domainarg, iterator) in groupby(domains):
         dlevel = len(tuple(iterator))
         debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
-        for index, msgdomain in enumerate(domain._fields):
-            if msgdomain == domainarg:
-                break
-        else:
-            warn(None, "Logging domain %s is not valid, ignoring" % domainarg)
 
     BBLogFilter(handler, level, debug_domains)
 
@@ -164,53 +130,10 @@ def addDefaultlogFilter(handler):
 # Message handling functions
 #
 
-def debug(level, msgdomain, msg):
-    warnings.warn("bb.msg.debug is deprecated in favor of the python 'logging' module",
-                  DeprecationWarning, stacklevel=2)
-    level = logging.DEBUG - (level - 1)
-    if not msgdomain:
-        logger.debug(level, msg)
-    else:
-        loggers[msgdomain].debug(level, msg)
-
-def plain(msg):
-    warnings.warn("bb.msg.plain is deprecated in favor of the python 'logging' module",
-                  DeprecationWarning, stacklevel=2)
-    logger.plain(msg)
-
-def note(level, msgdomain, msg):
-    warnings.warn("bb.msg.note is deprecated in favor of the python 'logging' module",
-                  DeprecationWarning, stacklevel=2)
-    if level > 1:
-        if msgdomain:
-            logger.verbose(msg)
-        else:
-            loggers[msgdomain].verbose(msg)
-    else:
-        if msgdomain:
-            logger.info(msg)
-        else:
-            loggers[msgdomain].info(msg)
-
-def warn(msgdomain, msg):
-    warnings.warn("bb.msg.warn is deprecated in favor of the python 'logging' module",
-                  DeprecationWarning, stacklevel=2)
-    if not msgdomain:
-        logger.warn(msg)
-    else:
-        loggers[msgdomain].warn(msg)
-
-def error(msgdomain, msg):
-    warnings.warn("bb.msg.error is deprecated in favor of the python 'logging' module",
-                  DeprecationWarning, stacklevel=2)
-    if not msgdomain:
-        logger.error(msg)
-    else:
-        loggers[msgdomain].error(msg)
-
 def fatal(msgdomain, msg):
-    if not msgdomain:
-        logger.critical(msg)
+    if msgdomain:
+        logger = logging.getLogger("BitBake.%s" % msgdomin)
     else:
-        loggers[msgdomain].critical(msg)
+        logger = logging.getLogger("BitBake")
+    logger.critical(msg)
     sys.exit(1)




