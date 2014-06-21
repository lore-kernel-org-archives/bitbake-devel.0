Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id A1A646FEB6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Jun 2014 14:13:17 +0000 (UTC)
Received: from [99.240.204.5] (port=41338 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WyM2f-0003ll-Ps for bitbake-devel@lists.openembedded.org;
	Sat, 21 Jun 2014 10:13:17 -0400
Date: Sat, 21 Jun 2014 10:09:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406211006570.20792@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH v2] bitbake-user-manual-execution.xml: Grammar/typo fixes.
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
X-List-Received-Date: Sat, 21 Jun 2014 14:13:22 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Collection of typo and grammar fixes from "Execution" chapter.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  supersedes earlier patch submitted for this chapter; does not cover
entire chapter, i'm still working on that.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 8514f23..d689d8a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -6,8 +6,8 @@

     <para>
         The primary purpose for running BitBake is to produce some kind
-        of output such as an image, a kernel, or a software development
-        kit.
+        of output such as a single installable package, a kernel, a software
+        development kit, or even a full, board-specific bootable Linux image.
         Of course, you can execute the <filename>bitbake</filename>
         command with options that cause it to execute single tasks,
         compile single recipe files, capture or clear data, or simply
@@ -29,11 +29,24 @@
     </para>

     <note>
-        Prior to executing BitBake, you should take advantage of parallel
-        thread execution by setting the
-        <link linkend='var-BB_NUMBER_THREADS'><filename>BB_NUMBER_THREADS</filename></link>
-        variable in your <filename>local.conf</filename>
-        configuration file.
+        <para>
+            Prior to executing BitBake, you should take advantage of available
+            parallel thread execution on your build host by setting the
+            <link linkend='var-BB_NUMBER_THREADS'><filename>BB_NUMBER_THREADS</filename></link>
+            variable in your project's <filename>local.conf</filename>
+            configuration file.
+        </para>
+
+        <para>
+            A common way to determine this value for your build host is to run:
+            <literallayout class='monospaced'>
+     $ grep processor /proc/cpuinfo
+            </literallayout>
+            and count the number of processors displayed. Note that the number of
+            processors will take into account hyper-threading, so that a quad-core
+            build host with hyper-threading will most likely show eight processors,
+            which is the value you would then assign to that variable.
+        </para>
     </note>

     <section id='parsing-the-base-configuration-metadata'>
@@ -42,7 +55,7 @@
         <para>
             The first thing BitBake does is parse base configuration
             metadata.
-            Base configuration metadata consists of the
+            Base configuration metadata consists of your project's
             <filename>bblayers.conf</filename> file to determine what
             layers BitBake needs to recognize, all necessary
             <filename>layer.conf</filename> files (one from each layer),
@@ -71,10 +84,11 @@
             and
             <link linkend='var-BBFILES'><filename>BBFILES</filename></link>.
             <filename>BBPATH</filename> is used to search for
-            configuration and class files under
-            <filename>conf/</filename> and <filename>class/</filename>
-            directories, respectively.
-            <filename>BBFILES</filename> is used to find recipe files
+            configuration and class files under the
+            <filename>conf/</filename> and <filename>classes/</filename>
+            directories, respectively, while
+            <filename>BBFILES</filename> is used to locate both recipe
+            and recipe append files
             (<filename>.bb</filename> and <filename>.bbappend</filename>).
             If there is no <filename>bblayers.conf</filename> file,
             it is assumed the user has set the <filename>BBPATH</filename>
@@ -82,7 +96,7 @@
         </para>

         <para>
-            Next, the <filename>bitbake.conf</filename> file is searched
+            Next, the <filename>bitbake.conf</filename> file is located
             using the <filename>BBPATH</filename> variable that was
             just constructed.
             The <filename>bitbake.conf</filename> file may also include other
@@ -117,18 +131,18 @@
             optional <filename>conf/bblayers.conf</filename> configuration file.
             This file is expected to contain a
             <link linkend='var-BBLAYERS'><filename>BBLAYERS</filename></link>
-            variable that is a space delimited list of 'layer' directories.
+            variable that is a space-delimited list of 'layer' directories.
             Recall that if BitBake cannot find a <filename>bblayers.conf</filename>
-            file then it is assumed the user has set the <filename>BBPATH</filename>
+            file, then it is assumed the user has set the <filename>BBPATH</filename>
             and <filename>BBFILES</filename> directly in the environment.
         </para>

         <para>
             For each directory (layer) in this list, a <filename>conf/layer.conf</filename>
-            file is searched for and parsed with the
+            file is located and parsed with the
             <link linkend='var-LAYERDIR'><filename>LAYERDIR</filename></link>
             variable being set to the directory where the layer was found.
-            The idea is these files automatically setup
+            The idea is these files automatically set up
             <link linkend='var-BBPATH'><filename>BBPATH</filename></link>
             and other variables correctly for a given build directory.
         </para>
@@ -143,7 +157,7 @@

         <para>
             Only variable definitions and include directives are allowed
-            in <filename>.conf</filename> files.
+            in BitBake <filename>.conf</filename> files.
             Some variables directly influence BitBake's behavior.
             These variables might have been set from the environment
             depending on the environment variables previously
@@ -166,9 +180,9 @@
             Other classes that are specified in the configuration using the
             <link linkend='var-INHERIT'><filename>INHERIT</filename></link>
             variable are also included.
-            BitBake searches for class files in a "classes" subdirectory under
-            the paths in <filename>BBPATH</filename> in the same way as
-            configuration files.
+            BitBake searches for class files in a <filename>classes/</filename>
+            subdirectory under the paths in <filename>BBPATH</filename> in the
+            same way as configuration files.
         </para>

         <para>
@@ -189,7 +203,7 @@
                 If a recipe uses a closing curly brace within the function and
                 the character has no leading spaces, BitBake produces a parsing
                 error.
-                If you use a pair of curly brace in a shell function, the
+                If you use a pair of curly braces in a shell function, the
                 closing curly brace must not be located at the start of the line
                 without leading spaces.
             </para>
@@ -261,14 +275,14 @@
             One common convention is to use the recipe filename to define
             pieces of metadata.
             For example, in <filename>bitbake.conf</filename> the recipe
-            name and version set
+            name and version are used to set the variables
             <link linkend='var-PN'><filename>PN</filename></link> and
             <link linkend='var-PV'><filename>PV</filename></link>:
             <literallayout class='monospaced'>
-     PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] or '1.0'}"
      PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[0] or 'defaultpkgname'}"
+     PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] or '1.0'}"
             </literallayout>
-            In this example, a recipe called "something_1.2.3.bb" sets
+            In this example, a recipe called "something_1.2.3.bb" would set
             <filename>PN</filename> to "something" and
             <filename>PV</filename> to "1.2.3".
         </para>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

