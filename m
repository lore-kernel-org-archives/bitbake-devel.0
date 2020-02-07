Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
	by mail.openembedded.org (Postfix) with ESMTP id 1E32560D3C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Feb 2020 10:51:14 +0000 (UTC)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:37992 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
	(envelope-from <rpjday@crashcourse.ca>) id 1j01EA-005Nmo-Mt
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Feb 2020 05:51:15 -0500
Date: Fri, 7 Feb 2020 05:51:11 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.21.2002070549200.2077441@localhost.localdomain>
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
Subject: [PATCH] doc: minor tweaks to ch 1 of BB user manual
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
X-List-Received-Date: Fri, 07 Feb 2020 10:51:15 -0000
Content-Type: text/plain; charset=US-ASCII


Tweaks include:

  - hyphenation
  - rewording for brevity or clarification
  - adding <firstterm> markup where appropriate

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index 8f2a960c..3d11b60b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -127,7 +127,7 @@
                     (e.g. Cygwin, the BSDs, and so forth).
                     </para></listitem>
                 <listitem><para>
-                    Be self contained, rather than tightly
+                    Be self-contained, rather than tightly
                     integrated into the build machine's root
                     filesystem.
                     </para></listitem>
@@ -221,6 +221,8 @@
                         them</para></listitem>
                     <listitem><para>How to configure and compile the
                         source code</para></listitem>
+                    <listitem><para>How to assemble the generated artifacts into
+                        one or more installable packages</para></listitem>
                     <listitem><para>Where on the target machine to install the
                         package or packages created</para></listitem>
                 </itemizedlist>
@@ -229,7 +231,7 @@
             <para>
                 Within the context of BitBake, or any project utilizing BitBake
                 as its build system, files with the <filename>.bb</filename>
-                extension are referred to as recipes.
+                extension are referred to as <firstterm>recipes</firstterm>.
                 <note>
                     The term "package" is also commonly used to describe recipes.
                     However, since the same word is used to describe packaged
@@ -252,9 +254,9 @@
                 various configuration variables that govern the project's build
                 process.
                 These files fall into several areas that define
-                machine configuration options, distribution configuration
-                options, compiler tuning options, general common
-                configuration options, and user configuration options.
+                machine configuration, distribution configuration,
+                possible compiler tuning, general common
+                configuration, and user configuration.
                 The main configuration file is the sample
                 <filename>bitbake.conf</filename> file, which is
                 located within the BitBake source tree
@@ -292,7 +294,7 @@
                 Layers allow you to isolate different types of
                 customizations from each other.
                 While you might find it tempting to keep everything in one layer
-                when working on a single project, the more modular you organize
+                when working on a single project, the more modular
                 your metadata, the easier it is to cope with future changes.
             </para>

@@ -300,8 +302,8 @@
                 To illustrate how you can use layers to keep things modular,
                 consider customizations you might make to support a specific target machine.
                 These types of customizations typically reside in a special layer,
-                rather than a general layer, called a Board Support Package (BSP)
-                Layer.
+                rather than a general layer, called a <firstterm>Board Support Package</firstterm> (BSP)
+                layer.
                 Furthermore, the machine customizations should be isolated from
                 recipes and metadata that support a new GUI environment, for
                 example.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

