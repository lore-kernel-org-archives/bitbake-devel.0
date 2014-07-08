Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 090977018E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 14:10:40 +0000 (UTC)
Received: from [69.196.158.250] (port=34562 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4W6T-00068W-3J for bitbake-devel@lists.openembedded.org;
	Tue, 08 Jul 2014 10:10:41 -0400
Date: Tue, 8 Jul 2014 10:10:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407081010150.14336@localhost>
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
Subject: [PATCH] Documentation: A few tweaks to Chapter 2, BitBake User Manual
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
X-List-Received-Date: Tue, 08 Jul 2014 14:10:49 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  only questionable part is my example of busybox supplying two
versions, perhaps that's outside the scope of this manual.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 8b6e0b4..403ad5b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -7,7 +7,8 @@
     <para>
         The primary purpose for running BitBake is to produce some kind
         of output such as a single installable package, a kernel, a software
-        development kit, or even a full, board-specific bootable Linux image.
+        development kit, or even a full, board-specific bootable Linux image,
+        complete with bootloader, kernel and root filesystem.
         Of course, you can execute the <filename>bitbake</filename>
         command with options that cause it to execute single tasks,
         compile single recipe files, capture or clear data, or simply
@@ -45,6 +46,11 @@
                 build host with hyper-threading will most likely show eight processors,
                 which is the value you would then assign to that variable.
             </para>
+
+            <para>
+                A possibly simpler solution is that some Linux distributions
+                (Debian, Ubuntu) provide the <filename>ncpus</filename> command.
+            </para>
         </note>
     </para>

@@ -84,7 +90,7 @@
             <link linkend='var-BBFILES'><filename>BBFILES</filename></link>.
             <filename>BBPATH</filename> is used to search for
             configuration and class files under the
-            <filename>conf</filename> and <filename>classes</filename>
+            <filename>conf/</filename> and <filename>classes/</filename>
             directories, respectively.
             <filename>BBFILES</filename> is used to locate both recipe
             and recipe append files
@@ -464,6 +470,29 @@
      PREFERRED_VERSION_a = "1.1"
             </literallayout>
         </para>
+
+        <note>
+            <para>
+                It's common for a recipe to provide two versions -- a stable,
+                numbered (and preferred) version, and a version that is
+                automatically checked out from a source code repository that
+                is considered more "bleeding edge" but can be selected only
+                explicitly.
+            </para>
+
+            <para>
+                For example, in the OpenEmbedded codebase, there is a standard,
+                versioned recipe file for BusyBox,
+                <filename>busybox_1.22.1.bb</filename>,
+                but there is also a Git-based version,
+                <filename>busybox_git.bb</filename>, which explicitly contains the line
+                <literallayout class='monospaced'>
+    DEFAULT_PREFERENCE = "-1"
+                </literallayout>
+                to ensure that the numbered, stable version is always preferred
+                unless the developer selects otherwise.
+            </para>
+        </note>
     </section>

     <section id='bb-bitbake-dependencies'>

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

