Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
	by mail.openembedded.org (Postfix) with ESMTP id B3F9660E4F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Feb 2020 09:38:02 +0000 (UTC)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:36714 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
	(envelope-from <rpjday@crashcourse.ca>) id 1j005K-005IAX-Or
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Feb 2020 04:38:03 -0500
Date: Fri, 7 Feb 2020 04:37:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.21.2002070435420.2056223@localhost.localdomain>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] doc: Standardize spelling on 'BitBake' throughout docs
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
X-List-Received-Date: Fri, 07 Feb 2020 09:38:02 -0000
Content-Type: text/plain; charset=US-ASCII


Since the proper spelling is, in fact, 'BitBake', might as well make
it consistent throughout the user manual.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 46dafeee..8f606676 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -113,7 +113,7 @@
         </para>

         <para>
-            Prior to parsing configuration files, Bitbake looks
+            Prior to parsing configuration files, BitBake looks
             at certain variables, including:
             <itemizedlist>
                 <listitem><para>
@@ -339,7 +339,7 @@
             <link linkend='var-bb-BB_HASHCONFIG_WHITELIST'><filename>BB_HASHCONFIG_WHITELIST</filename></link>)
             and then checking if the checksum matches.
             If that checksum matches what is in the cache and the recipe
-            and class files have not changed, Bitbake is able to use
+            and class files have not changed, BitBake is able to use
             the cache.
             BitBake then reloads the cached information about the recipe
             instead of reparsing it from scratch.
@@ -429,7 +429,7 @@
             The default
             <link linkend='var-bb-PREFERRED_PROVIDER'><filename>PREFERRED_PROVIDER</filename></link>
             is the provider with the same name as the target.
-            Bitbake iterates through each target it needs to build and
+            BitBake iterates through each target it needs to build and
             resolves them and their dependencies using this process.
         </para>

@@ -821,7 +821,7 @@

         <para>
             It is worth noting that BitBake's "-S" option lets you
-            debug Bitbake's processing of signatures.
+            debug BitBake's processing of signatures.
             The options passed to -S allow different debugging modes
             to be used, either using BitBake's own debug functions
             or possibly those defined in the metadata/signature handler
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index 68404085..d1bfc233 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -139,7 +139,7 @@
         </para>

         <para>
-            Since network accesses are slow, Bitbake maintains a
+            Since network accesses are slow, BitBake maintains a
             cache of files downloaded from the network.
             Any source files that are not local (i.e.
             downloaded from the Internet) are placed into the download
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.xml b/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
index 39066e4b..11eb36aa 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
@@ -166,7 +166,7 @@
                 Having a project directory is a good way to isolate your
                 project.
                 </para></listitem>
-            <listitem><para><emphasis>Run Bitbake:</emphasis>
+            <listitem><para><emphasis>Run BitBake:</emphasis>
                 At this point, you have nothing but a project directory.
                 Run the <filename>bitbake</filename> command and see what
                 it does:
@@ -197,7 +197,7 @@
                 <link linkend='var-bb-BBPATH'><filename>BBPATH</filename></link>
                 variable is what tells BitBake where to look for those files.
                 <filename>BBPATH</filename> is not set and you need to set it.
-                Without <filename>BBPATH</filename>, Bitbake cannot
+                Without <filename>BBPATH</filename>, BitBake cannot
                 find any configuration files (<filename>.conf</filename>)
                 or recipe files (<filename>.bb</filename>) at all.
                 BitBake also cannot find the <filename>bitbake.conf</filename>
@@ -225,7 +225,7 @@
                     as the shell would.
                 </note>
                 </para></listitem>
-            <listitem><para><emphasis>Run Bitbake:</emphasis>
+            <listitem><para><emphasis>Run BitBake:</emphasis>
                 Now that you have <filename>BBPATH</filename> defined, run
                 the <filename>bitbake</filename> command again:
                 <literallayout class='monospaced'>
@@ -313,7 +313,7 @@
                 example, click on the links to take you to the definitions in
                 the glossary.
                 </para></listitem>
-            <listitem><para><emphasis>Run Bitbake:</emphasis>
+            <listitem><para><emphasis>Run BitBake:</emphasis>
                 After making sure that the <filename>conf/bitbake.conf</filename>
                 file exists, you can run the <filename>bitbake</filename>
                 command again:
@@ -364,7 +364,7 @@
                 more depending on which build environments BitBake is
                 supporting.
                 </para></listitem>
-            <listitem><para><emphasis>Run Bitbake:</emphasis>
+            <listitem><para><emphasis>Run BitBake:</emphasis>
                 After making sure that the <filename>classes/base.bbclass</filename>
                 file exists, you can run the <filename>bitbake</filename>
                 command again:
@@ -434,7 +434,7 @@
                 For more information on these variables, follow the links
                 to the glossary.
                 </para></listitem>
-            <listitem><para><emphasis>Run Bitbake With a Target:</emphasis>
+            <listitem><para><emphasis>Run BitBake With a Target:</emphasis>
                 Now that a BitBake target exists, run the command and provide
                 that target:
                 <literallayout class='monospaced'>
@@ -468,7 +468,7 @@
                 You need to provide your own information for
                 <filename>you</filename> in the file.
                 </para></listitem>
-            <listitem><para><emphasis>Run Bitbake With a Target:</emphasis>
+            <listitem><para><emphasis>Run BitBake With a Target:</emphasis>
                 Now that you have supplied the <filename>bblayers.conf</filename>
                 file, run the <filename>bitbake</filename> command and provide
                 the target:
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index 8f2a960c..c87eac52 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -448,7 +448,7 @@
                 <listitem><para><emphasis>Using the BitBake that Comes With Your
                     Build Checkout:</emphasis>
                     A final possibility for getting a copy of BitBake is that it
-                    already comes with your checkout of a larger Bitbake-based build
+                    already comes with your checkout of a larger BitBake-based build
                     system, such as Poky.
                     Rather than manually checking out individual layers and
                     gluing them together yourself, you can check
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 421364c2..383f94b1 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -5,7 +5,7 @@
     <title>Syntax and Operators</title>

     <para>
-        Bitbake files have their own syntax.
+        BitBake files have their own syntax.
         The syntax has similarities to several
         other languages but also has some unique features.
         This section describes the available syntax and operators
@@ -1414,7 +1414,7 @@
         </section>

         <section id='bitbake-style-python-functions-versus-python-functions'>
-            <title>Bitbake-Style Python Functions Versus Python Functions</title>
+            <title>BitBake-Style Python Functions Versus Python Functions</title>

             <para>
                 Following are some important differences between
@@ -1895,7 +1895,7 @@
             <para>
                 Sometimes, it is useful to be able to obtain information
                 from the original execution environment.
-                Bitbake saves a copy of the original environment into
+                BitBake saves a copy of the original environment into
                 a special variable named
                 <link linkend='var-bb-BB_ORIGENV'><filename>BB_ORIGENV</filename></link>.
             </para>
@@ -2616,7 +2616,7 @@
             <para>
                 It is often necessary to access variables in the
                 BitBake datastore using Python functions.
-                The Bitbake datastore has an API that allows you this
+                The BitBake datastore has an API that allows you this
                 access.
                 Here is a list of available operations:
             </para>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index aca6741c..bae01d90 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1780,7 +1780,7 @@
                 </para>

                 <para>
-                    Bitbake normally issues a warning when building two
+                    BitBake normally issues a warning when building two
                     different recipes where each provides the same output.
                     This scenario is usually something the user does not
                     want.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

