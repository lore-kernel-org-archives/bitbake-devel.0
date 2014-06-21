Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id B3FDC6FE3F
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Jun 2014 11:24:25 +0000 (UTC)
Received: from [99.240.204.5] (port=37499 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WyJPF-0002Tf-US for bitbake-devel@lists.openembedded.org;
	Sat, 21 Jun 2014 07:24:26 -0400
Date: Sat, 21 Jun 2014 07:20:41 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406210718480.5097@localhost>
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
Subject: [PATCH v2] bitbake-user-manual-intro.xml: Grammar/editing tweaks.
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
X-List-Received-Date: Sat, 21 Jun 2014 11:24:28 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Minor fixes mostly involving grammar adjustments.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index ae267b4..b639027 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -8,9 +8,9 @@
         Welcome to the BitBake User Manual.
         This manual provides information on the BitBake tool.
         The information attempts to be as independent as possible regarding
-        systems that use BitBake, such as the Yocto Project and
-        OpenEmbedded.
-        In some cases, scenarios or examples that within the context of
+        systems that use BitBake, such as OpenEmbedded and the
+        Yocto Project.
+        In some cases, scenarios or examples within the context of
         a build system are used in the manual to help with understanding.
         For these cases, the manual clearly states the context.
     </para>
@@ -36,6 +36,7 @@
                     BitBake executes tasks according to provided
                     metadata that builds up the tasks.
                     Metadata is stored in recipe (<filename>.bb</filename>),
+                    recipe "append" (<filename>.bbappend</filename>),
                     configuration (<filename>.conf</filename>), and class
                     (<filename>.bbclass</filename>) files and provides
                     BitBake with instructions on what tasks to run and
@@ -43,19 +44,19 @@
                     </para></listitem>
                 <listitem><para>
                     BitBake includes a fetcher library for obtaining source
-                    code from various places such as source control
+                    code from various places such as local files, source control
                     systems or websites.
                     </para></listitem>
                 <listitem><para>
                     The instructions for each unit to be built (e.g. a piece
-                    of software) are known as recipe files and
+                    of software) are known as "recipe" files and
                     contain all the information about the unit
                     (dependencies, source file locations, checksums, description
                     and so on).
                     </para></listitem>
                 <listitem><para>
                     BitBake includes a client/server abstraction and can
-                    be used from a command line or used as a service over XMLRPC and
+                    be used from a command line or as a service over XMLRPC and
                     has several different user interfaces.
                     </para></listitem>
             </itemizedlist>
@@ -88,7 +89,7 @@
             an aspiring embedded Linux distribution.
             All of the build systems used by traditional desktop Linux
             distributions lacked important functionality, and none of the
-            ad-hoc Buildroot-based systems, prevalent in the
+            ad hoc Buildroot-based systems, prevalent in the
             embedded space, were scalable or maintainable.
         </para>

@@ -178,8 +179,8 @@
             what tasks are required to run, and executes those tasks.
             Similar to GNU Make, BitBake controls how software is
             built.
-            GNU Make achieves its control through "makefiles".
-            BitBake uses "recipes".
+            GNU Make achieves its control through "makefiles";
+            BitBake uses "recipe files".
         </para>

         <para>
@@ -205,12 +206,12 @@
                 <itemizedlist>
                     <listitem><para>Descriptive information about the package</para></listitem>
                     <listitem><para>The version of the recipe</para></listitem>
-                    <listitem><para>Existing Dependencies</para></listitem>
-                    <listitem><para>Where the source code resides</para></listitem>
+                    <listitem><para>Existing dependencies</para></listitem>
+                    <listitem><para>Where the source code resides and how to fetch it</para></listitem>
                     <listitem><para>Whether the source code requires any patches</para></listitem>
-                    <listitem><para>How to compile the source code</para></listitem>
+                    <listitem><para>How to configure and compile the source code</para></listitem>
                     <listitem><para>Where on the target machine to install the
-                        package being compiled</para></listitem>
+                        package(s) being compiled</para></listitem>
                 </itemizedlist>
             </para>

@@ -242,7 +243,7 @@
                 The main configuration file is the sample
                 <filename>bitbake.conf</filename> file, which is
                 located within the BitBake source tree
-                <filename>conf</filename> directory.
+                <filename>conf/</filename> directory.
             </para>
         </section>

@@ -256,8 +257,8 @@
                 The BitBake source tree currently comes with one class metadata file
                 called <filename>base.bbclass</filename>.
                 You can find this file in the
-                <filename>classes</filename> directory.
-                The <filename>base.bbclass</filename> is special since it
+                <filename>classes/</filename> directory.
+                The <filename>base.bbclass</filename> class file is special since it
                 is always included automatically for all recipes
                 and classes.
                 This class contains definitions for standard basic tasks such
@@ -284,7 +285,7 @@
                 To illustrate how you can use layers to keep things modular,
                 consider customizations you might make to support a specific target machine.
                 These types of customizations typically reside in a special layer,
-                rather than a general layer, called a Board Specific Package (BSP) Layer.
+                rather than a general layer, called a Board Support Package (BSP) Layer.
                 Furthermore, the machine customizations should be isolated from
                 recipes and metadata that support a new GUI environment, for
                 example.
@@ -304,9 +305,8 @@

             <para>
                 Append files, which are files that have the
-                <filename>.bbappend</filename> file extension, add or
-                extend build information to an existing
-                recipe file.
+                <filename>.bbappend</filename> file extension, extend or
+                override information in an existing recipe file.
             </para>

             <para>
@@ -559,14 +559,14 @@
                     when one wants to manage multiple <filename>.bb</filename>
                     files.
                     Clearly there needs to be a way to tell BitBake what
-                    files are available, and of those, which you
+                    files are available and, of those, which you
                     want to execute.
                     There also needs to be a way for each recipe
                     to express its dependencies, both for build-time and
                     runtime.
                     There must be a way for you to express recipe preferences
                     when multiple recipes provide the same functionality, or when
-                    there are multiple versions of a  recipe.
+                    there are multiple versions of a recipe.
                 </para>

                 <para>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

