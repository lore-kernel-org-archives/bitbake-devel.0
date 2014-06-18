Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 26BA56FD5C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 12:41:46 +0000 (UTC)
Received: from [69.196.158.250] (port=37606 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxFBS-0007ZB-HD for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jun 2014 08:41:46 -0400
Date: Wed, 18 Jun 2014 08:38:04 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406180835440.24706@localhost>
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
Subject: [PATCH] bitbake-user-manual-intro.xml: Semantic cleanup, clarifications.
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
X-List-Received-Date: Wed, 18 Jun 2014 12:41:48 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

Some basic proofreading, grammatical fixes within that single
chapter file.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index ae267b4..5f14976 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -10,7 +10,7 @@
         The information attempts to be as independent as possible regarding
         systems that use BitBake, such as the Yocto Project and
         OpenEmbedded.
-        In some cases, scenarios or examples that within the context of
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
@@ -44,11 +45,11 @@
                 <listitem><para>
                     BitBake includes a fetcher library for obtaining source
                     code from various places such as source control
-                    systems or websites.
+                    systems, websites or local files.
                     </para></listitem>
                 <listitem><para>
                     The instructions for each unit to be built (e.g. a piece
-                    of software) are known as recipe files and
+                    of software) are known as "recipe" files and
                     contain all the information about the unit
                     (dependencies, source file locations, checksums, description
                     and so on).
@@ -69,7 +70,7 @@
             BitBake was originally a part of the OpenEmbedded project.
             It was inspired by the Portage package management system
             used by the Gentoo Linux distribution.
-            On December 7, 2004, OpenEmbedded project team member,
+            On December 7, 2004, OpenEmbedded project team member
             Chris Larson split the project into two distinct pieces:
             <itemizedlist>
                 <listitem><para>BitBake, a generic task executor</para></listitem>
@@ -138,7 +139,7 @@
                     projects for their builds.
                     </para></listitem>
                 <listitem><para>
-                    Provide an inheritance mechanism that share
+                    Provide an inheritance mechanism to share
                     common metadata between many packages.
                     </para></listitem>
             </itemizedlist>
@@ -178,14 +179,14 @@
             what tasks are required to run, and executes those tasks.
             Similar to GNU Make, BitBake controls how software is
             built.
-            GNU Make achieves its control through "makefiles".
+            GNU Make achieves its control through "makefiles";
             BitBake uses "recipes".
         </para>

         <para>
             BitBake extends the capabilities of a simple
-            tool like GNU Make by allowing for much more complex tasks
-            to be completed, such as assembling entire embedded Linux
+            tool like GNU Make by allowing for the definition of much more
+            complex tasks, such as assembling entire embedded Linux
             distributions.
         </para>

@@ -203,12 +204,12 @@
                 <filename>.bb</filename>, are the most basic metadata files.
                 These recipe files provide BitBake with the following:
                 <itemizedlist>
-                    <listitem><para>Descriptive information about the package</para></listitem>
+                    <listitem><para>Descriptive information about the package (author, homepage, license and so on)</para></listitem>
                     <listitem><para>The version of the recipe</para></listitem>
-                    <listitem><para>Existing Dependencies</para></listitem>
+                    <listitem><para>Existing dependencies (both build and runtime dependencies)</para></listitem>
                     <listitem><para>Where the source code resides</para></listitem>
                     <listitem><para>Whether the source code requires any patches</para></listitem>
-                    <listitem><para>How to compile the source code</para></listitem>
+                    <listitem><para>How to configure and compile the source code</para></listitem>
                     <listitem><para>Where on the target machine to install the
                         package being compiled</para></listitem>
                 </itemizedlist>
@@ -284,7 +285,7 @@
                 To illustrate how you can use layers to keep things modular,
                 consider customizations you might make to support a specific target machine.
                 These types of customizations typically reside in a special layer,
-                rather than a general layer, called a Board Specific Package (BSP) Layer.
+                rather than a general layer, called a Board Support Package (BSP) Layer.
                 Furthermore, the machine customizations should be isolated from
                 recipes and metadata that support a new GUI environment, for
                 example.
@@ -413,6 +414,18 @@
                     you have a directory entitled
                     <filename>bitbake-1.17.0</filename>.
                     </para></listitem>
+                <listitem><para><emphasis>Using the BitBake that comes with your build checkout:</emphasis>
+                    A final possibility for getting a copy of BitBake is that it
+                    already comes with your checkout of a larger Bitbake-based build system,
+                    such as Poky or Yocto Project. Rather than manually checking out
+                    individual layers and gluing them together yourself, you can check
+                    out an entire build system such as Poky with something like:
+                    <literallayout class='monospaced'>
+     $ git clone git://git.yoctoproject.org/poky
+                    </literallayout>
+                    where that checkout will already include a version of BitBake which
+                    has been thoroughly tested for compatibility with the other components.
+                    </para></listitem>
             </itemizedlist>
         </para>
     </section>

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

