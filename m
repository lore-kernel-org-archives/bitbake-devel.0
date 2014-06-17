Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 5F94465D34
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jun 2014 14:34:07 +0000 (UTC)
Received: from [69.196.158.250] (port=47939 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WwuSe-0007vR-2m for bitbake-devel@lists.openembedded.org;
	Tue, 17 Jun 2014 10:34:08 -0400
Date: Tue, 17 Jun 2014 10:30:34 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406171027220.1538@localhost>
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
Subject: [PATCH] bitbake-user-manual-fetching.xml: Grammar and typo fixes.
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
X-List-Received-Date: Tue, 17 Jun 2014 14:34:15 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Various grammatical and typo tweaks all in fetching chapter, including
moving CVS section after wget section for more logical content flow.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index 858054f..0a4a6ff 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -8,14 +8,14 @@
         BitBake's fetch module is a standalone piece of library code
         that deals with the intricacies of downloading source code
         and files from remote systems.
-        Fetching source code is one of the corner stones of building software.
+        Fetching source code is one of the cornerstones of building software.
         As such, this module forms an important part of BitBake.
     </para>

     <para>
         The current fetch module is called "fetch2" and refers to the
         fact that it is the second major version of the API.
-        The original version is obsolete and removed from the codebase.
+        The original version is obsolete and has been removed from the codebase.
         Thus, in all cases, "fetch" refers to "fetch2" in this
         manual.
     </para>
@@ -59,18 +59,20 @@
             specified by <filename>WORKDIR</filename>.
             <note>
                 For convenience, the naming in these examples matches
-                the variables used by OpenEmbedded.
+                the variables used by OpenEmbedded. If you want to see
+                the above code in action, examine the OpenEmbedded class
+                file <filename>base.bbclass</filename>.
             </note>
             The <filename>SRC_URI</filename> and <filename>WORKDIR</filename>
-            variables are not coded into the fetcher.
-            They variables can (and are) called with different variable names.
+            variables are not hardcoded into the fetcher, since those fetcher
+            methods can be (and are) called with different variable names.
             In OpenEmbedded for example, the shared state (sstate) code uses
             the fetch module to fetch the sstate files.
         </para>

         <para>
             When the <filename>download()</filename> method is called,
-            BitBake tries to fulfill the URLs by looking for source files
+            BitBake tries to resolve the URLs by looking for source files
             in a specific search order:
             <itemizedlist>
                 <listitem><para><emphasis>Pre-mirror Sites:</emphasis>
@@ -84,7 +86,7 @@
                     <filename>SRC_URI</filename>).
                     </para></listitem>
                 <listitem><para><emphasis>Mirror Sites:</emphasis>
-                    If fetch failures occur, BitBake next uses mirror location as
+                    If fetch failures occur, BitBake next uses mirror locations as
                     defined by the
                     <link linkend='var-MIRRORS'><filename>MIRRORS</filename></link>
                     variable.
@@ -149,7 +151,7 @@
         <para>
             File integrity is of key importance for reproducing builds.
             For non-local archive downloads, the fetcher code can verify
-            sha256 and md5 checksums to ensure the archives have been
+            SHA-256 and MD5 checksums to ensure the archives have been
             downloaded correctly.
             You can specify these checksums by using the
             <filename>SRC_URI</filename> variable with the appropriate
@@ -260,8 +262,8 @@
             <para>
                 This submodule handles URLs that begin with
                 <filename>file://</filename>.
-                The filename you specify with in the URL can
-                either be an absolute or relative path to a file.
+                The filename you specify within the URL can be
+                either an absolute or relative path to a file.
                 If the filename is relative, the contents of the
                 <link linkend='var-FILESPATH'><filename>FILESPATH</filename></link>
                 variable is used in the same way
@@ -286,15 +288,45 @@
             </para>

             <para>
-                Here are some example URLs:
+                Here are a couple example URLs, the first relative and
+                the second absolute:
                 <literallayout class='monospaced'>
      SRC_URI = "file://relativefile.patch"
-     SRC_URI = "file://relativefile.patch;this=ignored"
      SRC_URI = "file:///Users/ich/very_important_software"
                 </literallayout>
             </para>
         </section>

+        <section id='http-ftp-fetcher'>
+            <title>HTTP/FTP wget fetcher (<filename>http://</filename>, <filename>ftp://</filename>, <filename>https://</filename>)</title>
+
+            <para>
+                This fetcher obtains files from web and FTP servers.
+                Internally, the fetcher uses the wget utility.
+            </para>
+
+            <para>
+                The executable and parameters used are specified by the
+                <filename>FETCHCMD_wget</filename> variable, which defaults
+                to sensible values.
+                The fetcher supports a parameter "downloadfilename" that
+                allows the name of the downloaded file to be specified.
+                Specifying the name of the downloaded file is useful
+                for avoiding collisions in
+                <link linkend='var-DL_DIR'><filename>DL_DIR</filename></link>
+                when dealing with multiple files that have the same name.
+            </para>
+
+            <para>
+                Some example URLs are as follows:
+                <literallayout class='monospaced'>
+     SRC_URI = "http://oe.handhelds.org/not_there.aac"
+     SRC_URI = "ftp://oe.handhelds.org/not_there_as_well.aac"
+     SRC_URI = "ftp://you@oe.handhelds.org/home/you/secret.plan"
+                </literallayout>
+            </para>
+        </section>
+
         <section id='cvs-fetcher'>
             <title>CVS fetcher (<filename>(cvs://</filename>)</title>

@@ -334,7 +366,7 @@
                 The supported parameters are as follows:
                 <itemizedlist>
                     <listitem><para><emphasis>"method":</emphasis>
-                        The protocol over which to communicate with the cvs server.
+                        The protocol over which to communicate with the CVS server.
                         By default, this protocol is "pserver".
                         If "method" is set to "ext", BitBake examines the
                         "rsh" parameter and sets <filename>CVS_RSH</filename>.
@@ -394,36 +426,6 @@
             </para>
         </section>

-        <section id='http-ftp-fetcher'>
-            <title>HTTP/FTP wget fetcher (<filename>http://</filename>, <filename>ftp://</filename>, <filename>https://</filename>)</title>
-
-            <para>
-                This fetcher obtains files from web and FTP servers.
-                Internally, the fetcher uses the wget utility.
-            </para>
-
-            <para>
-                The executable and parameters used are specified by the
-                <filename>FETCHCMD_wget</filename> variable, which defaults
-                to a sensible values.
-                The fetcher supports a parameter "downloadfilename" that
-                allows the name of the downloaded file to be specified.
-                Specifying the name of the downloaded file is useful
-                for avoiding collisions in
-                <link linkend='var-DL_DIR'><filename>DL_DIR</filename></link>
-                when dealing with multiple files that have the same name.
-            </para>
-
-            <para>
-                Some example URLs are as follows:
-                <literallayout class='monospaced'>
-     SRC_URI = "http://oe.handhelds.org/not_there.aac"
-     SRC_URI = "ftp://oe.handhelds.org/not_there_as_well.aac"
-     SRC_URI = "ftp://you@oe.handheld.sorg/home/you/secret.plan"
-                </literallayout>
-            </para>
-        </section>
-
         <section id='svn-fetcher'>
             <title>Subversion (SVN) Fetcher (<filename>svn://</filename>)</title>

@@ -476,14 +478,14 @@
         </section>

         <section id='git-fetcher'>
-            <title>GIT Fetcher (<filename>git://</filename>)</title>
+            <title>Git Fetcher (<filename>git://</filename>)</title>

             <para>
                 This fetcher submodule fetches code from the Git
                 source control system.
                 The fetcher works by creating a bare clone of the
                 remote into <filename>GITDIR</filename>, which is
-                usually <filename>DL_DIR/git</filename>.
+                usually <filename>DL_DIR/git2</filename>.
                 This bare clone is then cloned into the work directory during the
                 unpack stage when a specific tree is checked out.
                 This is done using alternates and by reference to
@@ -571,7 +573,7 @@
         </section>

         <section id='gitsm-fetcher'>
-            <title>GIT Submodule Fetcher (<filename>gitsm://</filename>)</title>
+            <title>Git Submodule Fetcher (<filename>gitsm://</filename>)</title>

             <para>
                 This fetcher inherits from the Git fetcher and extends its
@@ -579,7 +581,7 @@
                 Uri is passed to the Git fetcher so see <link linkend='git-fetcher'>
                 the git fetcher documentation for syntax</link>.
                 NOTE: You must clean a recipe when switching between 'git://' and
-                'gitsm://' urls.
+                'gitsm://' URLs.
             </para>
         </section>


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

