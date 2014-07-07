Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 0F5F465C83
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jul 2014 11:53:51 +0000 (UTC)
Received: from [69.196.158.250] (port=39257 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X47UT-00016Y-Nd for bitbake-devel@lists.openembedded.org;
	Mon, 07 Jul 2014 07:53:49 -0400
Date: Mon, 7 Jul 2014 07:53:41 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407070749140.6927@localhost>
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
Subject: [PATCH] Documentation: User manual, chapter 1: Minor tweaks.
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
X-List-Received-Date: Mon, 07 Jul 2014 11:53:53 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Some minor fixes and additions to the first couple sections of the
BitBake User Manual.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  first in what will probably be a series of patches fiddling around
with the bitbake user manual, since i want to use it in an upcoming
yocto course so i might as well add in the stuff i'd be pointing out,
anyway.

  this is for just the first part of chapter 1 -- i'll submit patches
in bite-size pieces rather than trying to do monster patches all at
once. some of this isn't really fixing stuff so much as just my idea
of rewording, but i'll always bundle in stuff like that with actual
corrections.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index af2400f..2df30ad 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -34,18 +34,19 @@
             <itemizedlist>
                 <listitem><para>
                     BitBake executes tasks according to provided
-                    metadata that builds up the tasks.
-                    Metadata is stored in recipe (<filename>.bb</filename>),
-                    recipe "append" (<filename>.bbappend</filename>),
-                    configuration (<filename>.conf</filename>), and class
-                    (<filename>.bbclass</filename>) files and provides
+                    metadata that builds up the tasks. Metadata is stored in
+                    recipe (<filename>.bb</filename>) and related
+                    recipe "append" (<filename>.bbappend</filename>) files,
+                    configuration (<filename>.conf</filename>) and underlying
+                    include (<filename>.inc</filename>) files, and class
+                    (<filename>.bbclass</filename>) files, and provides
                     BitBake with instructions on what tasks to run and
                     the dependencies between those tasks.
                     </para></listitem>
                 <listitem><para>
                     BitBake includes a fetcher library for obtaining source
                     code from various places such as local files, source control
-                    systems, websites, or local files.
+                    systems or websites.
                     </para></listitem>
                 <listitem><para>
                     The instructions for each unit to be built (e.g. a piece
@@ -56,7 +57,7 @@
                     </para></listitem>
                 <listitem><para>
                     BitBake includes a client/server abstraction and can
-                    be used from a command line or used as a service over XMLRPC and
+                    be used from a command line or used as a service over XML-RPC and
                     has several different user interfaces.
                     </para></listitem>
             </itemizedlist>
@@ -80,8 +81,10 @@
             Today, BitBake is the primary basis of the
             <ulink url="http://www.openembedded.org/">OpenEmbedded</ulink>
             project, which is being used to build and maintain Linux
-            distributions such as the Angstrom Distribution and which is used
-            as the build tool for Linux projects such as the Yocto Project.
+            distributions such as the
+            <ulink url="http://www.angstrom-distribution.org/">Angstrom Distribution</ulink>
+            and which is used as the build tool for Linux projects such as the
+            <ulink url="https://www.yoctoproject.org/">Yocto Project</ulink>.
         </para>

         <para>
@@ -152,7 +155,7 @@
                     </para></listitem>
                 <listitem><para>
                     Split metadata into layers and allow layers
-                    to override each other.
+                    to enhance or override other layers.
                     </para></listitem>
                 <listitem><para>
                     Allow representation of a given set of input variables

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

