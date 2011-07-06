Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QeUbO-0005s9-1K for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jul 2011 18:05:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p66G1ZYM016746
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jul 2011 17:01:35 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 16172-10 for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2011 17:01:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p66G1QFr016740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jul 2011 17:01:27 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 06 Jul 2011 17:00:52 +0100
Message-ID: <1309968052.20015.793.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: RFC: Bitbake logging/msg code changes
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
X-List-Received-Date: Wed, 06 Jul 2011 16:05:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

At the moment it bugs me a lot that we only have one effective logging
level for bitbake, despite the logging module having provision to do
more advanced things. I've included a proof of concept below which:

* Changes the core log level to the lowest level we have messages of 
  (DEBUG-2) so messages always flow through the core logger
* Allows build.py's task logging code to log all the output regardless 
  of what output is on the console
* Moves the verbose/debug/debug-domains code to be a UI side setting
* Adds a filter to the UI to only print the user requested output.

The result is more complete logfiles on disk but the usual output to the
console.

The problem with the patch is that some behaviours and API break and
certain operations become harder. In particular:

a) the -v option currently shares any task output to the console. In
multithreaded situations, this is not particularly desirable anyway and
would probably be better replaced with a UI message to the user that
"Logfiles from the task execution are available at: X".

b) The functions get_debug_levels, the debug_levels variable, the
set_debug_levels, the set_verbosity and set_debug_domains functions are
removed from bb.msg.

c) The "logging" init function changes format.

d) All messages get fired to all handlers all the time leading to an
increase in inter-process traffic. This could likely be hacked around
short term with a function for a UI to only request events greater than
level X. Longer term, having masks for event handlers would be better.

e) logger.getEffectiveLevel() is no longer a reliable guide to what 
will/won't get logged.

This code also raises the possibility of being able to easily drop more
code in the future from bb.msg including the domain Tuple and the
Loggers/loggers code when the deprecated bb.msg debug/warn/note
functions are removed.

In general I think the ideas in the patch are worthwhile and I have an
easier time understanding what the code is doing after these changes. It
should also make things easier to debug when builds fail and hence
improve usability.

Any objections to proceeding in this general direction and working on a
cleaned up version of this patch. Are the changes in behaviour
acceptable?

Cheers,

Richard



diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 206d97b..9740242 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -190,7 +190,7 @@ Default BBFILES are the .bb files in the current directory.""")
     # server is daemonized this logfile will be truncated.
     cooker_logfile = os.path.join(os.getcwd(), "cooker.log")
 
-    bb.utils.init_logger(bb.msg, configuration.verbose, configuration.debug,
+    bb.msg.init_msgconfig(configuration.verbose, configuration.debug,
                          configuration.debug_domains)
 
     # Ensure logging messages get sent to the UI as events
@@ -225,6 +225,7 @@ Default BBFILES are the .bb files in the current directory.""")
     try:
         return server.launchUI(ui_main, server_connection.connection, server_connection.events)
     finally:
+        bb.event.ui_queue = []
         server_connection.terminate()
 
     return 1
diff --git a/bitbake/bin/bitdoc b/bitbake/bin/bitdoc
index 98fb025..08a0173 100755
--- a/bitbake/bin/bitdoc
+++ b/bitbake/bin/bitdoc
@@ -430,9 +430,8 @@ Create a set of html pages (documentation) for a bitbake.conf....
                        action = "store_true", dest = "verbose", default = False )
 
     options, args = parser.parse_args( sys.argv )
-
-    if options.debug:
-        bb.msg.set_debug_level(options.debug)
+ 
+    bb.msg.init_msgconfig(options.verbose, options.debug)
 
     return options.config, options.output
 
diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index ef9d49d..b1d9b99 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -56,7 +56,7 @@ logging.setLoggerClass(BBLogger)
 
 logger = logging.getLogger("BitBake")
 logger.addHandler(NullHandler())
-logger.setLevel(logging.INFO)
+logger.setLevel(logging.DEBUG - 2)
 
 # This has to be imported after the setLoggerClass, as the import of bb.msg
 # can result in construction of the various loggers.
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 5c70309..ec83d38 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -234,10 +234,10 @@ def exec_func_shell(function, d, runfile, cwd=None):
 
     cmd = runfile
 
-    if logger.isEnabledFor(logging.DEBUG):
-        logfile = LogTee(logger, sys.stdout)
-    else:
-        logfile = sys.stdout
+    #if logger.isEnabledFor(logging.DEBUG):
+    #    logfile = LogTee(logger, sys.stdout)
+    #else:
+    logfile = sys.stdout
 
     try:
         bb.process.run(cmd, shell=False, stdin=NULL, log=logfile)
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 4769f94..a3f8795 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -75,6 +75,25 @@ class BBLogFormatter(logging.Formatter):
             msg += '\n' + ''.join(formatted)
         return msg
 
+class BBLogFilter(object):
+    def __init__(self, handler, level, debug_domains):
+        self.stdlevel = level
+        self.debug_domains = debug_domains
+        loglevel = level
+        for domain in debug_domains:
+            if debug_domains[domain] < loglevel:
+                loglevel = debug_domains[domain]
+        handler.setLevel(loglevel)
+        handler.addFilter(self)
+
+    def filter(self, record):
+        if record.levelno >= self.stdlevel:
+            return True
+        if record.name in self.debug_domains and record.levelno >= self.debug_domains[record.name]:
+            return True
+        return False
+
+
 class Loggers(dict):
     def __getitem__(self, key):
         if key in self:
@@ -84,12 +103,6 @@ class Loggers(dict):
             dict.__setitem__(self, key, log)
             return log
 
-class DebugLevel(dict):
-    def __getitem__(self, key):
-        if key == "default":
-            key = domain.Default
-        return get_debug_level(key)
-
 def _NamedTuple(name, fields):
     Tuple = collections.namedtuple(name, " ".join(fields))
     return Tuple(*range(len(fields)))
@@ -110,58 +123,42 @@ domain = _NamedTuple("Domain", (
     "Util"))
 logger = logging.getLogger("BitBake")
 loggers = Loggers()
-debug_level = DebugLevel()
 
 # Message control functions
 #
 
-def set_debug_level(level):
-    for log in loggers.itervalues():
-        log.setLevel(logging.NOTSET)
+loggerDefaults = [0, False, []]
 
-    if level:
-        logger.setLevel(logging.DEBUG - level + 1)
-    else:
-        logger.setLevel(logging.INFO)
+def init_msgconfig(verbose, debug, debug_domains = []):
+    """
+    Set default verbosity and debug levels config the logger
+    """
+    bb.msg.loggerDefaults = [debug, verbose, debug_domains]
 
-def get_debug_level(msgdomain = domain.Default):
-    if not msgdomain:
-        level = logger.getEffectiveLevel()
-    else:
-        level = loggers[msgdomain].getEffectiveLevel()
-    return max(0, logging.DEBUG - level + 1)
+def addDefaultlogFilter(handler):
+
+    debug = loggerDefaults[0]
+    verbose = loggerDefaults[1]
+    domains = loggerDefaults[2]
 
-def set_verbose(level):
-    if level:
-        logger.setLevel(BBLogFormatter.VERBOSE)
+    if debug:
+        level = BBLogFormatter.DEBUG - debug + 1
+    elif verbose:
+        level = BBLogFormatter.VERBOSE
     else:
-        logger.setLevel(BBLogFormatter.INFO)
+        level = BBLogFormatter.NOTE
 
-def set_debug_domains(domainargs):
-    for (domainarg, iterator) in groupby(domainargs):
+    debug_domains = {}
+    for (domainarg, iterator) in groupby(domains):
+        dlevel = len(tuple(iterator))
+        debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
         for index, msgdomain in enumerate(domain._fields):
             if msgdomain == domainarg:
-                level = len(tuple(iterator))
-                if level:
-                    loggers[index].setLevel(logging.DEBUG - level + 1)
                 break
         else:
             warn(None, "Logging domain %s is not valid, ignoring" % domainarg)
 
-def init_logger(logger, verbose, debug, debug_domains):
-    """
-    Set verbosity and debug levels in the logger
-    """
-
-    if debug:
-        set_debug_level(debug)
-    elif verbose:
-        set_verbose(True)
-    else:
-        set_debug_level(0)
-
-    if debug_domains:
-        set_debug_domains(debug_domains)
+    BBLogFilter(handler, level, debug_domains)
 
 #
 # Message handling functions
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 997eb3f..9c01812 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -74,6 +74,7 @@ def main(server, eventHandler):
 
     console = logging.StreamHandler(sys.stdout)
     format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    bb.msg.addDefaultlogFilter(console)
     console.setFormatter(format)
     logger.addHandler(console)
 
@@ -116,8 +117,8 @@ def main(server, eventHandler):
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to 
                 # include verbose/debug messages
-                if logger.getEffectiveLevel() > format.VERBOSE:
-                    if event.taskpid != 0 and event.levelno <= format.NOTE:
+                #if logger.getEffectiveLevel() > format.VERBOSE:
+                if event.taskpid != 0 and event.levelno <= format.NOTE:
                         continue
                 logger.handle(event)
                 continue
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index dce846b..742fcdf 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -830,9 +830,6 @@ def which(path, item, direction = 0):
 
     return ""
 
-def init_logger(logger, verbose, debug, debug_domains):
-    bb.msg.init_logger(logger, verbose, debug, debug_domains)
-
 def to_boolean(string, default=None):
     if not string:
         return default



