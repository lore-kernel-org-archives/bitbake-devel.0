Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 8425E7035F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jul 2014 13:47:29 +0000 (UTC)
Received: from [69.196.158.250] (port=40676 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X49GU-0005HM-32 for bitbake-devel@lists.openembedded.org;
	Mon, 07 Jul 2014 09:47:30 -0400
Date: Mon, 7 Jul 2014 09:47:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407070945460.9880@localhost>
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
Subject: [PATCH] Documentation: A few more tweaks to Chapter 1, BitBake User Manual.
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
X-List-Received-Date: Mon, 07 Jul 2014 13:47:37 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index af2400f..bf39857 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -212,11 +212,12 @@
                     <listitem><para>Where the source code resides and
                         how to fetch it</para></listitem>
                     <listitem><para>Whether the source code requires
-                        any patches</para></listitem>
+                        any patches, where to find them and how to apply
+                        them</para></listitem>
                     <listitem><para>How to configure and compile the
                         source code</para></listitem>
                     <listitem><para>Where on the target machine to install the
-                        package or packages being compiled</para></listitem>
+                        package or packages created</para></listitem>
                 </itemizedlist>
             </para>

@@ -228,7 +229,10 @@
                     The term "package" is also commonly used to describe recipes.
                     However, since the same word is used to describe packaged
                     output from a project, it is best to maintain a single
-                    descriptive term, "recipes".
+                    descriptive term, "recipes". Put another way, a single
+                    "recipe" file is quite capable of generating a number of
+                    related but separately installable "packages"; this is
+                    actually fairly common.
                 </note>
             </para>
         </section>
@@ -248,7 +252,7 @@
                 The main configuration file is the sample
                 <filename>bitbake.conf</filename> file, which is
                 located within the BitBake source tree
-                <filename>conf</filename> directory.
+                <filename>conf/</filename> directory.
             </para>
         </section>

@@ -262,7 +266,7 @@
                 The BitBake source tree currently comes with one class metadata file
                 called <filename>base.bbclass</filename>.
                 You can find this file in the
-                <filename>classes</filename> directory.
+                <filename>classes/</filename> directory.
                 The <filename>base.bbclass</filename> class files is special since it
                 is always included automatically for all recipes
                 and classes.
@@ -313,7 +317,6 @@
                 Append files, which are files that have the
                 <filename>.bbappend</filename> file extension, extend or
                 override information in an existing recipe file.
-                recipe file.
             </para>

             <para>
@@ -326,8 +329,8 @@
             </para>

             <para>
-                Information in append files overrides the information in the
-                similarly-named recipe file.
+                Information in append files extends or overrides the information in the
+                underlying, similarly-named recipe file.
             </para>

             <para>
@@ -352,6 +355,12 @@
                 However, if you named the append file
                 <filename>busybox_1.%.bbappend</filename>, then you would have a match.
             </para>
+
+            <para>
+                In the most general case, you could name the append file something as
+                simple as <filename>busybox_%.bbappend</filename> to be entirely
+                version independent.
+            </para>
         </section>
     </section>

@@ -359,7 +368,7 @@
         <title>Obtaining BitBake</title>

         <para>
-            You can obtain BitBake several different ways:
+            You can obtain BitBake in one of several different ways:
             <itemizedlist>
                 <listitem><para><emphasis>Cloning BitBake:</emphasis>
                     Using Git to clone the BitBake source code repository
@@ -432,7 +441,7 @@
                     has been thoroughly tested for compatibility with the other
                     components.
                     For information on how to check out a particular BitBake-based
-                    build system, the build system's supporting documentation.
+                    build system, consult that build system's supporting documentation.
                     </para></listitem>
             </itemizedlist>
         </para>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

