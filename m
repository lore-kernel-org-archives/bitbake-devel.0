Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id B59BB610F7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 22:26:32 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8IMeqJQ027906 for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 23:40:52 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p7K8_mjY1swW for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 23:40:52 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8IMeilK027896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 23:40:50 +0100
Message-ID: <1379543175.18603.66.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Sep 2013 23:26:15 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: bin/bitbake: Improve --help text
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
X-List-Received-Date: Wed, 18 Sep 2013 22:26:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The --help text was rather inconsistent in style and plain incorrect in places,
using confusing terminology in others. I guess most people know what the options
do and don't read this but its confusing to new users.

This updates it to use the terms recipe and task consistently, remove
the references to stage, bbread and generally try and make the output
more useful.

[YOCTO #4856]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index b4506ef..567a65d 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -107,22 +107,22 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
     be executed.  BBFILES does support wildcards.
     Default BBFILES are the .bb files in the current directory.""")
 
-        parser.add_option("-b", "--buildfile", help = "execute the task against this .bb file, rather than a package from BBFILES. Does not handle any dependencies.",
+        parser.add_option("-b", "--buildfile", help = "execute tasks from a specific .bb recipe directly. WARNING: Does not handle any dependencies from other recipes.",
                    action = "store", dest = "buildfile", default = None)
 
-        parser.add_option("-k", "--continue", help = "continue as much as possible after an error. While the target that failed, and those that depend on it, cannot be remade, the other dependencies of these targets can be processed all the same.",
+        parser.add_option("-k", "--continue", help = "continue as much as possible after an error. While the target that failed and anything depending on it cannot be built, as much as possible will be before stopping.",
                    action = "store_false", dest = "abort", default = True)
 
         parser.add_option("-a", "--tryaltconfigs", help = "continue with builds by trying to use alternative providers where possible.",
                    action = "store_true", dest = "tryaltconfigs", default = False)
 
-        parser.add_option("-f", "--force", help = "force run of specified cmd, regardless of stamp status",
+        parser.add_option("-f", "--force", help = "force the specified targets/task to run, invalidating any existing stamp file",
                    action = "store_true", dest = "force", default = False)
 
-        parser.add_option("-c", "--cmd", help = "Specify task to execute. Note that this only executes the specified task for the providee and the packages it depends on, i.e. 'compile' does not implicitly call stage for the dependencies (IOW: use only if you know what you are doing). Depending on the base.bbclass a listtasks tasks is defined and will show available tasks",
+        parser.add_option("-c", "--cmd", help = "Specify the task to execute. The exact options available depend on the metadata but examples might be 'compile' or 'populate_sysroot' or 'listtasks' may give a list of the tasks available.",
                    action = "store", dest = "cmd")
 
-        parser.add_option("-C", "--clear-stamp", help = "Invalidate the stamp for the specified cmd such as 'compile' and run the default task for the specified target(s)",
+        parser.add_option("-C", "--clear-stamp", help = "Invalidate the stamp for the specified task such as 'compile' and then run the default task for the specified target(s)",
                     action = "store", dest = "invalidate_stamp")
 
         parser.add_option("-r", "--read", help = "read the specified file before bitbake.conf",
@@ -131,7 +131,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-R", "--postread", help = "read the specified file after bitbake.conf",
                           action = "append", dest = "postfile", default = [])
 
-        parser.add_option("-v", "--verbose", help = "output more chit-chat to the terminal",
+        parser.add_option("-v", "--verbose", help = "output more log message data to the terminal",
                    action = "store_true", dest = "verbose", default = False)
 
         parser.add_option("-D", "--debug", help = "Increase the debug level. You can specify this more than once.",
@@ -143,16 +143,16 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-S", "--dump-signatures", help = "don't execute, just dump out the signature construction information",
                    action = "store_true", dest = "dump_signatures", default = False)
 
-        parser.add_option("-p", "--parse-only", help = "quit after parsing the BB files (developers only)",
+        parser.add_option("-p", "--parse-only", help = "quit after parsing the BB recipes files",
                    action = "store_true", dest = "parse_only", default = False)
 
         parser.add_option("-s", "--show-versions", help = "show current and preferred versions of all recipes",
                    action = "store_true", dest = "show_versions", default = False)
 
-        parser.add_option("-e", "--environment", help = "show the global or per-package environment (this is what used to be bbread)",
+        parser.add_option("-e", "--environment", help = "show the global or per-package environment complete with information about where variables were set/changed",
                    action = "store_true", dest = "show_environment", default = False)
 
-        parser.add_option("-g", "--graphviz", help = "emit the dependency trees of the specified packages in the dot syntax, and the pn-buildlist to show the build list",
+        parser.add_option("-g", "--graphviz", help = "emit dependency tree information for the specified targets in the dot syntax",
                     action = "store_true", dest = "dot_graph", default = False)
 
         parser.add_option("-I", "--ignore-deps", help = """Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
@@ -161,10 +161,10 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-l", "--log-domains", help = """Show debug logging for the specified logging domains""",
                     action = "append", dest = "debug_domains", default = [])
 
-        parser.add_option("-P", "--profile", help = "profile the command and print a report",
+        parser.add_option("-P", "--profile", help = "profile the command and save reports",
                    action = "store_true", dest = "profile", default = False)
 
-        parser.add_option("-u", "--ui", help = "userinterface to use",
+        parser.add_option("-u", "--ui", help = "userinterface to use (e.g. knotty, hob, depexp)",
                    action = "store", dest = "ui")
 
         parser.add_option("-t", "--servertype", help = "Choose which server to use, process or xmlrpc",
@@ -173,13 +173,13 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not",
                    action = "store_true", dest = "revisions_changed", default = False)
 
-        parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
+        parser.add_option("", "--server-only", help = "Run bitbake without a UI, only starting a server (cooker) process",
                    action = "store_true", dest = "server_only", default = False)
 
         parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
                    action = "store", dest = "bind", default = False)
 
-        parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks, forces builds",
+        parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks so sstate is ignored and everything needed is built",
                    action = "store_true", dest = "nosetscene", default = False)
 
         parser.add_option("", "--remote-server", help = "Connect to the specified server",



