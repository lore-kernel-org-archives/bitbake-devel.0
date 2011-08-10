Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QrAX1-0004t3-DH for bitbake-devel@lists.openembedded.org;
	Wed, 10 Aug 2011 17:17:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7AFCmbw022243
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2011 16:12:48 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21814-01 for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2011 16:12:44 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7AFCftO022237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2011 16:12:42 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Aug 2011 16:12:06 +0100
Message-ID: <1312989126.14274.386.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/usermanual: Update to be more in sync with bitbake codebase
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 10 Aug 2011 15:17:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/doc/manual/usermanual.xml b/bitbake/doc/manual/usermanual.xml
index 7dea949..01b69b8 100644
--- a/bitbake/doc/manual/usermanual.xml
+++ b/bitbake/doc/manual/usermanual.xml
@@ -12,9 +12,10 @@
             <corpauthor>BitBake Team</corpauthor>
         </authorgroup>
         <copyright>
-            <year>2004, 2005, 2006</year>
+            <year>2004, 2005, 2006, 2011</year>
             <holder>Chris Larson</holder>
             <holder>Phil Blundell</holder>
+            <holder>Richard Purdie</holder>
         </copyright>
         <legalnotice>
             <para>This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit <ulink url="http://creativecommons.org/licenses/by/2.5/">http://creativecommons.org/licenses/by/2.5/</ulink> or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.</para>
@@ -26,7 +27,7 @@
             <title>Overview</title>
             <para>BitBake is, at its simplest, a tool for executing
 tasks and managing metadata.  As such, its similarities to GNU make and other
-build tools are readily apparent.  It was inspired by Portage, the package management system used by the Gentoo Linux distribution.  BitBake is the basis of the <ulink url="http://www.openembedded.org/">OpenEmbedded</ulink> project, which is being used to build and maintain a number of embedded Linux distributions, including OpenZaurus and Familiar.</para>
+build tools are readily apparent.  It was inspired by Portage, the package management system used by the Gentoo Linux distribution.  BitBake is the basis of the <ulink url="http://www.openembedded.org/">OpenEmbedded</ulink> project, which is being used to build and maintain a number of embedded Linux distributions/projects such as Angstrom and the Yocto project.</para>
         </section>
         <section>
             <title>Background and goals</title>
@@ -37,7 +38,7 @@ important functionality, and none of the ad-hoc
 <emphasis>buildroot</emphasis> systems, prevalent in the
 embedded space, were scalable or maintainable.</para>
 
-      <para>Some important goals for BitBake were:
+      <para>Some important original goals for BitBake were:
             <itemizedlist>
                 <listitem><para>Handle crosscompilation.</para></listitem>
                 <listitem><para>Handle interpackage dependencies (build time on target architecture, build time on native architecture, and runtime).</para></listitem>
@@ -53,10 +54,18 @@ between multiple projects using BitBake for their
 builds.</para></listitem>
 		<listitem><para>Should provide an inheritance mechanism to
 share common metadata between many packages.</para></listitem>
-                <listitem><para>Et cetera...</para></listitem>
             </itemizedlist>
         </para>
-        <para>BitBake satisfies all these and many more.  Flexibility and power have always been the priorities.  It is highly extensible, supporting embedded Python code and execution of any arbitrary tasks.</para>
+        <para>Over time it has become apparent that some further requirements were necessary:
+            <itemizedlist>
+                <listitem><para>Handle variants of a base recipe (native, sdk, mutliblib).</para></listitem>
+                <listitem><para>Able to split metadata into layers and allow layers to override each other.</para></listitem>
+                <listitem><para>Allow representation of a given set of input variables to a task as a checksum.</para></listitem>
+                <listitem><para>based on that checksum, allow acceleration of builds with prebuilt components.</para></listitem>
+            </itemizedlist>
+        </para>
+
+        <para>BitBake satisfies all the original requirements and many more with extensions being made to the basic functionality to reflect the additionl requirements.  Flexibility and power have always been the priorities.  It is highly extensible, supporting embedded Python code and execution of any arbitrary tasks.</para>
         </section>
     </chapter>
     <chapter>
@@ -94,10 +103,10 @@ share common metadata between many packages.</para></listitem>
                 <para>If <varname>A</varname> is set before the above is called, it will retain its previous value. If <varname>A</varname> is unset prior to the above call, <varname>A</varname> will be set to <literal>aval</literal>.  Note that this assignment is immediate, so if there are multiple ?= assignments to a single variable, the first of those will be used.</para>
             </section>
             <section>
-                <title>Setting a default value (??=)</title>
-                <para><screen><varname>A</varname> ??= "somevalue"</screen></para>
-                <para><screen><varname>A</varname> ??= "someothervalue"</screen></para>
-                <para>If <varname>A</varname> is set before the above, it will retain that value.  If <varname>A</varname> is unset prior to the above, <varname>A</varname> will be set to <literal>someothervalue</literal>.  This is a lazy version of ??=, in that the assignment does not occur until the end of the parsing process, so that the last, rather than the first, ??= assignment to a given variable will be used.</para>
+                <title>Setting a weak default value (??=)</title>
+                <para><screen><varname>A</varname> ??= "somevalue"
+<varname>A</varname> ??= "someothervalue"</screen></para>
+                <para>If <varname>A</varname> is set before the above, it will retain that value.  If <varname>A</varname> is unset prior to the above, <varname>A</varname> will be set to <literal>someothervalue</literal>.  This is a lazy/weak assignment in that the assignment does not occur until the end of the parsing process, so that the last, rather than the first, ??= assignment to a given variable will be used. Any other setting of A using = or ?= will however override the value set with ??=</para>
             </section>
             <section>
                 <title>Immediate variable expansion (:=)</title>
@@ -209,6 +218,19 @@ include</literal> directive.</para>
 addtask printdate before do_build</screen></para>
                 <para>This defines the necessary Python function and adds it as a task which is now a dependency of do_build, the default task.  If anyone executes the do_build task, that will result in do_printdate being run first.</para>
             </section>
+
+            <section>
+                <title>Task Flags</title>
+                <para>Tasks support a number of flags which control various functionality of the task. These are as follows:</para>
+                <para>'dirs' - directories which should be created before the task runs</para>
+                <para>'cleandirs' - directories which should created before the task runs but should be empty</para>
+                <para>'noexec' - marks the tasks as being empty and no execution required. These are used as dependency placeholders or used when added tasks need to be subsequently disabled.</para>
+                <para>'nostamp' - don't generate a stamp file for a task. This means the task is always rexecuted.</para>
+                <para>'fakeroot' - this task needs to be run in a fakeroot environment, obtained by adding the variables in FAKEROOTENV to the environment.</para>
+                <para>'umask' - the umask to run the task under.</para>
+                <para> For the 'deptask', 'rdeptask', 'recdeptask' and 'recrdeptask' flags please see the dependencies section.</para>
+            </section>
+
             <section>
                 <title>Events</title>
                 <para><emphasis>NOTE:</emphasis> This is only supported in .bb and .bbclass files.</para>
@@ -239,6 +261,51 @@ SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;pat
                 <para>Note that the name of the range will default to the original version of the recipe, so given OE, a recipe file of foo_1.0.0+.bb will default the name of its versions to 1.0.0+.  This is useful, as the range name is not only placed into overrides; it's also made available for the metadata to use in the form of the <varname>BPV</varname> variable, for use in file:// search paths (<varname>FILESPATH</varname>).</para>
             </section>
         </section>
+
+        <section>
+            <title>Variable interaction: Worked Examples</title>
+            <para>Despite the documentation of the different forms of variable definition above, it can be hard to work out what happens when variable operators are combined. This section documents some common questions people have regarding the way variables interact.</para>
+
+            <section>
+                <title>Override and append ordering</title>
+
+                <para>There is often confusion about which order overrides and the various append operators take effect.</para>
+
+                <para><screen><varname>OVERRIDES</varname> = "foo"
+<varname>A_foo_append</varname> = "X"</screen></para>
+                <para>In this case, X is unconditionally appended to the variable <varname>A_foo</varname>. Since foo is an override, A_foo would then replace <varname>A</varname>.</para>
+
+                 <para><screen><varname>OVERRIDES</varname> = "foo"
+<varname>A</varname> = "X"
+<varname>A_append_foo</varname> = "Y"</screen></para>
+                <para>In this case, only when foo is in OVERRIDES, Y is appended to the variable <varname>A</varname> so the value of <varname>A</varname> would become XY (NB: no spaces are appended).</para>
+
+                <para><screen><varname>OVERRIDES</varname> = "foo"
+<varname>A_foo_append</varname> = "X"
+<varname>A_foo_append</varname> += "Y"</screen></para>
+                <para>This behaves as per the first case above, but the value of <varname>A</varname> would be "X Y" instead of just "X".</para>
+
+                <para><screen><varname>A</varname> = "1"
+<varname>A_append</varname> = "2"
+<varname>A_append</varname> = "3"
+<varname>A</varname> += "4"
+<varname>A</varname> .= "5"</screen></para>
+
+                <para>Would ultimately result in <varname>A</varname> taking the value "1 4523" since the _append operator executes at the same time as the expansion of other overrides.</para>
+
+            </section>
+            <section>
+                <title>Key Expansion</title>
+
+                <para>Key expansion happens at the data store finalisation time just before overrides are expanded.</para>
+
+                <para><screen><varname>A${B}</varname> = "X"
+<varname>B</varname> = "2"
+<varname>A2</varname> = "Y"</screen></para>
+                <para>So in this case <varname>A2</varname> would take the value of "X".</para>
+            </section>
+
+        </section>
         <section>
             <title>Dependency handling</title>
             <para>BitBake 1.7.x onwards works with the metadata at the task level since this is optimal when dealing with multiple threads of execution. A robust method of specifing task dependencies is therefore needed. </para>
@@ -299,13 +366,35 @@ SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;pat
         <title>File download support</title>
         <section>
             <title>Overview</title>
-            <para>BitBake provides support to download files this procedure is called fetching. The SRC_URI is normally used to tell BitBake which files to fetch. The next sections will describe the available fetchers and their options. Each fetcher honors a set of variables and per URI parameters separated by a <quote>;</quote> consisting of a key and a value. The semantics of the variables and parameters are defined by the fetcher. BitBake tries to have consistent semantics between the different fetchers.
+            <para>BitBake provides support to download files this procedure is called fetching and it handled by the fetch and fetch2 modules. At this point the original fetch code is considered to be replaced by fetch2 and this manual only related to the fetch2 codebase.</para>
+
+            <para>The SRC_URI is normally used to tell BitBake which files to fetch. The next sections will describe the available fetchers and their options. Each fetcher honors a set of variables and per URI parameters separated by a <quote>;</quote> consisting of a key and a value. The semantics of the variables and parameters are defined by the fetcher. BitBake tries to have consistent semantics between the different fetchers.
             </para>
+
+            <para>The overall fetch process is that first, fetches are attempted from PREMIRRORS. If those don't work, the original SRC_URI is attempted and if that fails, bitbake will fall back to MIRRORS. Cross urls are supported, so its possible to mirror a git repostory on an http server as a tarball for example. Some example commonly used mirror defintions are:</para>
+
+            <para><screen><varname>PREMIRRORS</varname> ?= "\
+bzr://.*/.*   http://somemirror.org/sources/ \n \
+cvs://.*/.*   http://somemirror.org/sources/ \n \
+git://.*/.*   http://somemirror.org/sources/ \n \
+hg://.*/.*    http://somemirror.org/sources/ \n \
+osc://.*/.*   http://somemirror.org/sources/ \n \
+p4://.*/.*    http://somemirror.org/sources/ \n \
+svk://.*/.*   http://somemirror.org/sources/ \n \
+svn://.*/.*   http://somemirror.org/sources/ \n"
+
+<varname>MIRRORS</varname> =+ "\
+ftp://.*/.*      http://somemirror.org/sources/ \n \
+http://.*/.*     http://somemirror.org/sources/ \n \
+https://.*/.*    http://somemirror.org/sources/ \n"</screen></para>
+
+            <para>Non-local downloaded output is placed into the directory specified by the <varname>DL_DIR</varname>. For non local downloads the code can check checksums for the download to ensure the file has been downloaded correctly. These are specified in the form <varname>SRC_URI[md5sum]</varname> for the md5 checksum and <varname>SRC_URI[sha256sum]</varname> for the sha256 checksum. If <varname>BB_STRICT_CHECKSUM</varname> is set, any download without a checksum will trigger an error message. In cases where multiple files are listed in SRC_URI, the name parameter is used assign names to the urls and these are then specified in the checksums in the form SRC_URI[name.sha256sum].</para>
+
         </section>
 
         <section>
             <title>Local file fetcher</title>
-            <para>The URN for the local file fetcher is <emphasis>file</emphasis>. The filename can be either absolute or relative. If the filename is relative, <varname>FILESPATH</varname> and <varname>FILESDIR</varname> will be used to find the appropriate relative file, depending on the <varname>OVERRIDES</varname>. Single files and complete directories can be specified.
+            <para>The URN for the local file fetcher is <emphasis>file</emphasis>. The filename can be either absolute or relative. If the filename is relative, <varname>FILESPATH</varname> and failing that <varname>FILESDIR</varname> will be used to find the appropriate relative file. The metadata usually extend these variables to include variations of the values in <varname>OVERRIDES</varname>. Single files and complete directories can be specified.
 <screen><varname>SRC_URI</varname>= "file://relativefile.patch"
 <varname>SRC_URI</varname>= "file://relativefile.patch;this=ignored"
 <varname>SRC_URI</varname>= "file:///Users/ich/very_important_software"
@@ -314,8 +403,8 @@ SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;pat
         </section>
 
         <section>
-            <title>CVS file fetcher</title>
-            <para>The URN for the CVS fetcher is <emphasis>cvs</emphasis>. This fetcher honors the variables <varname>DL_DIR</varname>, <varname>SRCDATE</varname>, <varname>FETCHCOMMAND_cvs</varname>, <varname>UPDATECOMMAND_cvs</varname>. <varname>DL_DIR</varname> specifies where a temporary checkout is saved. <varname>SRCDATE</varname> specifies which date to use when doing the fetching (the special value of "now" will cause the checkout to be updated on every build). <varname>FETCHCOMMAND</varname> and <varname>UPDATECOMMAND</varname> specify which executables to use for the CVS checkout or update.
+            <title>CVS fetcher</title>
+            <para>The URN for the CVS fetcher is <emphasis>cvs</emphasis>. This fetcher honors the variables <varname>CVSDIR</varname>, <varname>SRCDATE</varname>, <varname>FETCHCOMMAND_cvs</varname>, <varname>UPDATECOMMAND_cvs</varname>. <varname>DL_DIR</varname> specifies where a temporary checkout is saved. <varname>SRCDATE</varname> specifies which date to use when doing the fetching (the special value of "now" will cause the checkout to be updated on every build). <varname>FETCHCOMMAND</varname> and <varname>UPDATECOMMAND</varname> specify which executables to use for the CVS checkout or update.
             </para>
             <para>The supported parameters are <varname>module</varname>, <varname>tag</varname>, <varname>date</varname>, <varname>method</varname>, <varname>localdir</varname>, <varname>rsh</varname> and <varname>scmdata</varname>. The <varname>module</varname> specifies which module to check out, the <varname>tag</varname> describes which CVS TAG should be used for the checkout. By default the TAG is empty. A <varname>date</varname> can be specified to override the SRCDATE of the configuration to checkout a specific date.  The special value of "now" will cause the checkout to be updated on every build.<varname>method</varname> is by default <emphasis>pserver</emphasis>. If <emphasis>ext</emphasis> is used the <varname>rsh</varname> parameter will be evaluated and <varname>CVS_RSH</varname> will be set. Finally, <varname>localdir</varname> is used to checkout into a special directory relative to <varname>CVSDIR</varname>.
 
@@ -327,28 +416,19 @@ SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;pat
 
         <section>
             <title>HTTP/FTP fetcher</title>
-            <para>The URNs for the HTTP/FTP fetcher are <emphasis>http</emphasis>, <emphasis>https</emphasis> and <emphasis>ftp</emphasis>. This fetcher honors the variables <varname>DL_DIR</varname>, <varname>FETCHCOMMAND_wget</varname>, <varname>PREMIRRORS</varname>, <varname>MIRRORS</varname>. The <varname>DL_DIR</varname> defines where to store the fetched file. <varname>FETCHCOMMAND</varname> contains the command used for fetching. <quote>${URI}</quote> and <quote>${FILES}</quote> will be replaced by the URI and basename of the file to be fetched. <varname>PREMIRRORS</varname> will be tried first when fetching a file. If that fails, the actual file will be tried and finally all <varname>MIRRORS</varname> will be tried.
-            </para>
-            <para>The only supported parameter is <varname>md5sum</varname>. After a fetch the <varname>md5sum</varname> of the file will be calculated and the two sums will be compared.
+            <para>The URNs for the HTTP/FTP fetcher are <emphasis>http</emphasis>, <emphasis>https</emphasis> and <emphasis>ftp</emphasis>. This fetcher honors the variables <varname>FETCHCOMMAND_wget</varname>. <varname>FETCHCOMMAND</varname> contains the command used for fetching. <quote>${URI}</quote> and <quote>${FILES}</quote> will be replaced by the URI and basename of the file to be fetched.
             </para>
-            <para><screen><varname>SRC_URI</varname> = "http://oe.handhelds.org/not_there.aac;md5sum=12343"
-<varname>SRC_URI</varname> = "ftp://oe.handhelds.org/not_there_as_well.aac;md5sum=1234"
-<varname>SRC_URI</varname> = "ftp://you@oe.handheld.sorg/home/you/secret.plan;md5sum=1234"
+            <para><screen><varname>SRC_URI</varname> = "http://oe.handhelds.org/not_there.aac"
+<varname>SRC_URI</varname> = "ftp://oe.handhelds.org/not_there_as_well.aac"
+<varname>SRC_URI</varname> = "ftp://you@oe.handheld.sorg/home/you/secret.plan"
 </screen></para>
         </section>
 
         <section>
-            <title>SVK fetcher</title>
-            <para>
-            <emphasis>Currently NOT supported</emphasis>
-            </para>
-        </section>
-
-        <section>
             <title>SVN fetcher</title>
             <para>The URN for the SVN fetcher is <emphasis>svn</emphasis>.
             </para>
-            <para>This fetcher honors the variables <varname>FETCHCOMMAND_svn</varname>, <varname>DL_DIR</varname>, <varname>SRCDATE</varname>. <varname>FETCHCOMMAND</varname> contains the subversion command. <varname>DL_DIR</varname> is the directory where tarballs will be saved. <varname>SRCDATE</varname> specifies which date to use when doing the fetching (the special value of "now" will cause the checkout to be updated on every build).
+            <para>This fetcher honors the variables <varname>FETCHCOMMAND_svn</varname>, <varname>SVNDIR</varname>, <varname>SRCREV</varname>. <varname>FETCHCOMMAND</varname> contains the subversion command. <varname>SRCREV</varname> specifies which revision to use when doing the fetching.
             </para>
             <para>The supported parameters are <varname>proto</varname>, <varname>rev</varname> and <varname>scmdata</varname>. <varname>proto</varname> is the Subversion protocol, <varname>rev</varname> is the Subversion revision. If <varname>scmdata</varname> is set to <quote>keep</quote>, the <quote>.svn</quote> directories will be available during compile-time.
             </para>
@@ -361,7 +441,7 @@ SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;pat
             <title>GIT fetcher</title>
             <para>The URN for the GIT Fetcher is <emphasis>git</emphasis>.
             </para>
-            <para>The Variables <varname>DL_DIR</varname>, <varname>GITDIR</varname> are used. <varname>DL_DIR</varname> will be used to store the checkedout version. <varname>GITDIR</varname> will be used as the base directory where the git tree is cloned to.
+            <para>The variable <varname>GITDIR</varname> will be used as the base directory where the git tree is cloned to.
             </para>
             <para>The parameters are <emphasis>tag</emphasis>, <emphasis>protocol</emphasis> and <emphasis>scmdata</emphasis>. <emphasis>tag</emphasis> is a Git tag, the default is <quote>master</quote>. <emphasis>protocol</emphasis> is the Git protocol to use and defaults to <quote>rsync</quote>. If <emphasis>scmdata</emphasis> is set to <quote>keep</quote>, the <quote>.git</quote> directory will be available during compile-time.
             </para>




