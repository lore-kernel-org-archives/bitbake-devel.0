Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <brandon.stafford@gmail.com>) id 1QSX4R-0005TN-Cj
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 18:18:00 +0200
Received: by vxd7 with SMTP id 7so1700514vxd.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jun 2011 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:content-type;
	bh=A8QTMd9cZ1bgRcNEC5F3mmTYp/yWFP94DzBUT/YP4+g=;
	b=m7j2sw0BjucrV3+F1isSl5OgWTSahzGevVvqqhS+3eMAdKMjzraDhLKXhKhRMgAjZD
	8dE8oxpiDLXAAXYqfYHulW+Eise5JZhsk6BsVzfBhp2V8Yf4F0MdeQGbeGEtEwUqbdOr
	rMM0qVecCUzJo/6eECCEae9z+MQN2DdkgceQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:content-type;
	b=WToa1XoioCk/BOOpiktkSeAtaB/CZLrUun7gEhpM6+QexMu6uz88ABQaMPNRV9F/bm
	k/3j8JOwuKDHYGHwZdnYL9Nk1vyXukA2XlKx4XNKGigQOl5nahMycVAwEgD0ZULhBsrQ
	Im4g/d/oalvx5+KiBnIbgCC1pThdjLrDjClOw=
MIME-Version: 1.0
Received: by 10.52.180.169 with SMTP id dp9mr1852134vdc.134.1307117686052;
	Fri, 03 Jun 2011 09:14:46 -0700 (PDT)
Sender: brandon.stafford@gmail.com
Received: by 10.52.181.137 with HTTP; Fri, 3 Jun 2011 09:14:46 -0700 (PDT)
In-Reply-To: <AANLkTikY20mQoKfNaY6xsokcVabDnnaQKrvAmumBvv77@mail.gmail.com>
References: <AANLkTikY20mQoKfNaY6xsokcVabDnnaQKrvAmumBvv77@mail.gmail.com>
Date: Fri, 3 Jun 2011 12:14:46 -0400
X-Google-Sender-Auth: pijNdAHVq3tgw03tkvLipXoHiKI
Message-ID: <BANLkTi=RWRFGQ1ujgCY8Gk8jhr62HMo_vw@mail.gmail.com>
From: Brandon Stafford <brandon@pingswept.org>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Mon, 06 Jun 2011 17:01:03 +0200
Subject: [PATCH 1/1] Fix some punctuation, wording, and caps in manual
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
X-List-Received-Date: Fri, 03 Jun 2011 16:18:00 -0000
Content-Type: multipart/alternative; boundary=bcaec5101c735b584204a4d10df2

--bcaec5101c735b584204a4d10df2
Content-Type: text/plain; charset=ISO-8859-1

This patch contains what I hope are non-controversial improvements to the
manual. Most of the changes are single characters, but the line-by-line diff
makes the patch look large.

This is my first patch to Bitbake, so please don't kill me immediately. (I
originally sent this message, minus this sentence, around 2011-03-10, but
the bitbake-dev list appeared to be silently dropping messages from
2011-03-07 until 2011-03-24. I resent it again on 2011-03-27. I'm now
sending it to the post-migration bitbake-devel list on 2011-06-03.)

Signed-off-by: Brandon Stafford <brandon@pingswept.org>
---
 doc/manual/usermanual.xml |  131
++++++++++++++++++++++-----------------------
 1 files changed, 65 insertions(+), 66 deletions(-)

diff --git a/doc/manual/usermanual.xml b/doc/manual/usermanual.xml
index 32b40ee..946a812 100644
--- a/doc/manual/usermanual.xml
+++ b/doc/manual/usermanual.xml
@@ -29,7 +29,7 @@ tasks and managing metadata.  As such, its similarities to
GNU make and other
 build tools are readily apparent.  It was inspired by Portage, the package
management system used by the Gentoo Linux distribution.  BitBake is the
basis of the <ulink url="http://www.openembedded.org/">OpenEmbedded</ulink>
project, which is being used to build and maintain a number of embedded
Linux distributions, including OpenZaurus and Familiar.</para>
        </section>
        <section>
-            <title>Background and Goals</title>
+            <title>Background and goals</title>
            <para>Prior to BitBake, no other build tool adequately met
 the needs of an aspiring embedded Linux distribution.  All of the
 buildsystems used by traditional desktop Linux distributions lacked
@@ -42,9 +42,9 @@ embedded space, were scalable or maintainable.</para>
                <listitem><para>Handle crosscompilation.</para></listitem>
                <listitem><para>Handle interpackage dependencies (build time
on target architecture, build time on native architecture, and
runtime).</para></listitem>
                <listitem><para>Support running any number of tasks within a
given package, including, but not limited to, fetching upstream sources,
unpacking them, patching them, configuring them, et
cetera.</para></listitem>
-                <listitem><para>Must be linux distribution agnostic (both
build and target).</para></listitem>
+                <listitem><para>Must be Linux distribution agnostic (both
build and target).</para></listitem>
                <listitem><para>Must be architecture
agnostic</para></listitem>
-                <listitem><para>Must support multiple build and target
operating systems (including cygwin, the BSDs, etc).</para></listitem>
+                <listitem><para>Must support multiple build and target
operating systems (including Cygwin, the BSDs, etc).</para></listitem>
                <listitem><para>Must be able to be self contained, rather
than tightly integrated into the build machine's root
filesystem.</para></listitem>
                <listitem><para>There must be a way to handle conditional
metadata (on target architecture, operating system, distribution,
machine).</para></listitem>
                <listitem><para>It must be easy for the person using the
tools to supply their own local metadata and packages to operate
against.</para></listitem>
@@ -91,7 +91,7 @@ share common metadata between many
packages.</para></listitem>
            <section>
                <title>Setting a default value (?=)</title>
                <para><screen><varname>A</varname> ?= "aval"</screen></para>
-                <para>If <varname>A</varname> is set before the above is
called, it will retain it's previous value. If <varname>A</varname> is unset
prior to the above call, <varname>A</varname> will be set to
<literal>aval</literal>.  Note that this assignment is immediate, so if
there are multiple ?= assignments to a single variable, the first of those
will be used.</para>
+                <para>If <varname>A</varname> is set before the above is
called, it will retain its previous value. If <varname>A</varname> is unset
prior to the above call, <varname>A</varname> will be set to
<literal>aval</literal>.  Note that this assignment is immediate, so if
there are multiple ?= assignments to a single variable, the first of those
will be used.</para>
            </section>
            <section>
                <title>Setting a default value (??=)</title>
@@ -125,7 +125,7 @@ share common metadata between many
packages.</para></listitem>
 <varname>B</varname> .= "additionaldata"
 <varname>C</varname> = "cval"
 <varname>C</varname> =. "test"</screen></para>
-                <para>In this example, <varname>B</varname> is now
<literal>bvaladditionaldata</literal> and <varname>C</varname> is
<literal>testcval</literal>. In contrast to the above Appending and
Prepending operators no additional space
+                <para>In this example, <varname>B</varname> is now
<literal>bvaladditionaldata</literal> and <varname>C</varname> is
<literal>testcval</literal>. In contrast to the above appending and
prepending operators, no additional space
 will be introduced.</para>
            </section>
            <section>
@@ -147,12 +147,12 @@ will be introduced.</para>
            </section>
            <section>
                <title>Inclusion</title>
-                <para>Next, there is the <literal>include</literal>
directive, which causes BitBake to parse in whatever file you specify, and
insert it at that location, which is not unlike <command>make</command>.
 However, if the path specified on the <literal>include</literal> line is a
relative path, BitBake will locate the first one it can find within
<envar>BBPATH</envar>.</para>
+                <para>Next, there is the <literal>include</literal>
directive, which causes BitBake to parse whatever file you specify, and
insert it at that location, which is not unlike <command>make</command>.
 However, if the path specified on the <literal>include</literal> line is a
relative path, BitBake will locate the first one it can find within
<envar>BBPATH</envar>.</para>
            </section>
            <section>
-                <title>Requiring Inclusion</title>
+                <title>Requiring inclusion</title>
                <para>In contrast to the <literal>include</literal>
directive, <literal>require</literal> will
-raise an ParseError if the to be included file can not be found. Otherwise
it will behave just like the <literal>
+raise an ParseError if the file to be included cannot be found. Otherwise
it will behave just like the <literal>
 include</literal> directive.</para>
            </section>
            <section>
@@ -171,10 +171,10 @@ include</literal> directive.</para>
    import time
    print time.strftime('%Y%m%d', time.gmtime())
 }</screen></para>
-                <para>This is the similar to the previous, but flags it as
python so that BitBake knows it is python code.</para>
+                <para>This is the similar to the previous, but flags it as
Python so that BitBake knows it is Python code.</para>
            </section>
            <section>
-                <title>Defining python functions into the global python
namespace</title>
+                <title>Defining Python functions into the global Python
namespace</title>
                <para><emphasis>NOTE:</emphasis> This is only supported in
.bb and .bbclass files.</para>
                <para><screen>def get_depends(bb, d):
    if bb.data.getVar('SOMECONDITION', d, True):
@@ -187,8 +187,8 @@ include</literal> directive.</para>
                <para>This would result in <varname>DEPENDS</varname>
containing <literal>dependencywithcond</literal>.</para>
            </section>
            <section>
-                <title>Variable Flags</title>
-                <para>Variables can have associated flags which provide a
way of tagging extra information onto a variable. Several flags are used
internally by bitbake but they can be used externally too if needed. The
standard operations mentioned above also work on flags.</para>
+                <title>Variable flags</title>
+                <para>Variables can have associated flags which provide a
way of tagging extra information onto a variable. Several flags are used
internally by BitBake but they can be used externally too if needed. The
standard operations mentioned above also work on flags.</para>

<para><screen><varname>VARIABLE</varname>[<varname>SOMEFLAG</varname>] =
"value"</screen></para>
                <para>In this example, <varname>VARIABLE</varname> has a
flag, <varname>SOMEFLAG</varname> which is set to
<literal>value</literal>.</para>
            </section>
@@ -200,19 +200,19 @@ include</literal> directive.</para>
            <section>
                <title>Tasks</title>
                <para><emphasis>NOTE:</emphasis> This is only supported in
.bb and .bbclass files.</para>
-                <para>In BitBake, each step that needs to be run for a
given .bb is known as a task.  There is a command <literal>addtask</literal>
to add new tasks (must be a defined python executable metadata and must
start with <quote>do_</quote>) and describe intertask dependencies.</para>
+                <para>In BitBake, each step that needs to be run for a
given .bb is known as a task.  There is a command <literal>addtask</literal>
to add new tasks (must be a defined Python executable metadata and must
start with <quote>do_</quote>) and describe intertask dependencies.</para>
                <para><screen>python do_printdate () {
    import time
    print time.strftime('%Y%m%d', time.gmtime())
 }

 addtask printdate before do_build</screen></para>
-                <para>This defines the necessary python function and adds
it as a task which is now a dependency of do_build (the default task).  If
anyone executes the do_build task, that will result in do_printdate being
run first.</para>
+                <para>This defines the necessary Python function and adds
it as a task which is now a dependency of do_build, the default task.  If
anyone executes the do_build task, that will result in do_printdate being
run first.</para>
            </section>
            <section>
                <title>Events</title>
                <para><emphasis>NOTE:</emphasis> This is only supported in
.bb and .bbclass files.</para>
-                <para>BitBake allows to install event handlers.  Events are
triggered at certain points during operation, such as, the beginning of
operation against a given .bb, the start of a given task, task failure, task
success, et cetera.  The intent was to make it easy to do things like email
notifications on build failure.</para>
+                <para>BitBake allows installation of event handlers.
 Events are triggered at certain points during operation, such as the
beginning of operation against a given .bb, the start of a given task, task
failure, task success, et cetera.  The intent is to make it easy to do
things like email notification on build failure.</para>
                <para><screen>addhandler myclass_eventhandler
 python myclass_eventhandler() {
    from bb.event import getName
@@ -228,20 +228,20 @@ of the event and the content of the
<varname>FILE</varname> variable.</para>
            </section>
            <section>
                <title>Variants</title>
-                <para>Two Bitbake features exist to facilitate the creation
of multiple buildable incarnations from a single recipe file.</para>
-                <para>The first is <varname>BBCLASSEXTEND</varname>.  This
variable is a space separated list of classes to utilize to "extend" the
recipe for each variant.  As an example, setting <screen>BBCLASSEXTEND =
"native"</screen> results in a second incarnation of the current recipe
being available.  This second incarantion will have the "native" class
inherited.</para>
-                <para>The second feature is <varname>BBVERSIONS</varname>.
 This variable allows a single recipe to be able to build multiple versions
of a project from a single recipe file, and allows you to specify
conditional metadata (using the <varname>OVERRIDES</varname> mechanism) for
a single version, or an optionally named range of versions:</para>
+                <para>Two BitBake features exist to facilitate the creation
of multiple buildable incarnations from a single recipe file.</para>
+                <para>The first is <varname>BBCLASSEXTEND</varname>.  This
variable is a space separated list of classes used to "extend" the recipe
for each variant.  As an example, setting <screen>BBCLASSEXTEND =
"native"</screen> results in a second incarnation of the current recipe
being available.  This second incarantion will have the "native" class
inherited.</para>
+                <para>The second feature is <varname>BBVERSIONS</varname>.
 This variable allows a single recipe to build multiple versions of a
project from a single recipe file, and allows you to specify conditional
metadata (using the <varname>OVERRIDES</varname> mechanism) for a single
version, or an optionally named range of versions:</para>
                <para><screen>BBVERSIONS = "1.0 2.0 git"
 SRC_URI_git = "git://someurl/somepath.git"</screen></para>
                <para><screen>BBVERSIONS = "1.0.[0-6]:1.0.0+ \
              1.0.[7-9]:1.0.7+"
 SRC_URI_append_1.0.7+ =
"file://some_patch_which_the_new_versions_need.patch;patch=1"</screen></para>
-                <para>Note that the name of the range will default to the
original version of the recipe, so given OE, a recipe file of foo_1.0.0+.bb
will default the name of its versions to 1.0.0+.  This is useful, as the
range name is not only placed into overrides, it's also made available for
the metadata to use in the form of the <varname>BPV</varname> variable, for
use in file:// search paths (<varname>FILESPATH</varname>).</para>
+                <para>Note that the name of the range will default to the
original version of the recipe, so given OE, a recipe file of foo_1.0.0+.bb
will default the name of its versions to 1.0.0+.  This is useful, as the
range name is not only placed into overrides; it's also made available for
the metadata to use in the form of the <varname>BPV</varname> variable, for
use in file:// search paths (<varname>FILESPATH</varname>).</para>
            </section>
        </section>
        <section>
-            <title>Dependency Handling</title>
-            <para>Bitbake 1.7.x onwards works with the metadata at the task
level since this is optimal when dealing with multiple threads of execution.
A robust method of specifing task dependencies is therefore needed. </para>
+            <title>Dependency handling</title>
+            <para>BitBake 1.7.x onwards works with the metadata at the task
level since this is optimal when dealing with multiple threads of execution.
A robust method of specifing task dependencies is therefore needed. </para>
            <section>
                <title>Dependencies internal to the .bb file</title>
                <para>Where the dependencies are internal to a given .bb
file, the dependencies are handled by the previously detailed addtask
directive.</para>
@@ -249,26 +249,26 @@ SRC_URI_append_1.0.7+ =
"file://some_patch_which_the_new_versions_need.patch;pat

            <section>
                <title>DEPENDS</title>
-                <para>DEPENDS is taken to specify build time dependencies.
The 'deptask' flag for tasks is used to signify the task of each DEPENDS
which must have completed before that task can be executed.</para>
+                <para>DEPENDS lists build time dependencies. The 'deptask'
flag for tasks is used to signify the task of each item listed in DEPENDS
which must have completed before that task can be executed.</para>
                <para><screen>do_configure[deptask] =
"do_populate_staging"</screen></para>
                <para>means the do_populate_staging task of each item in
DEPENDS must have completed before do_configure can execute.</para>
            </section>
            <section>
                <title>RDEPENDS</title>
-                <para>RDEPENDS is taken to specify runtime dependencies.
The 'rdeptask' flag for tasks is used to signify the task of each RDEPENDS
which must have completed before that task can be executed.</para>
+                <para>RDEPENDS lists runtime dependencies. The 'rdeptask'
flag for tasks is used to signify the task of each item listed in RDEPENDS
which must have completed before that task can be executed.</para>
                <para><screen>do_package_write[rdeptask] =
"do_package"</screen></para>
                <para>means the do_package task of each item in RDEPENDS
must have completed before do_package_write can execute.</para>
            </section>
            <section>
                <title>Recursive DEPENDS</title>
-                <para>These are specified with the 'recdeptask' flag and is
used signify the task(s) of each DEPENDS which must have completed before
that task can be executed. It applies recursively so also, the DEPENDS of
each item in the original DEPENDS must be met and so on.</para>
+                <para>These are specified with the 'recdeptask' flag and is
used signify the task(s) of each DEPENDS which must have completed before
that task can be executed. It applies recursively so the DEPENDS of each
item in the original DEPENDS must be met and so on.</para>
            </section>
            <section>
                <title>Recursive RDEPENDS</title>
-                <para>These are specified with the 'recrdeptask' flag and
is used signify the task(s) of each RDEPENDS which must have completed
before that task can be executed. It applies recursively so also, the
RDEPENDS of each item in the original RDEPENDS must be met and so on. It
also runs all DEPENDS first too.</para>
+                <para>These are specified with the 'recrdeptask' flag and
is used signify the task(s) of each RDEPENDS which must have completed
before that task can be executed. It applies recursively so the RDEPENDS of
each item in the original RDEPENDS must be met and so on. It also runs all
DEPENDS first.</para>
            </section>
            <section>
-                <title>Inter Task</title>
+                <title>Inter task</title>
                <para>The 'depends' flag for tasks is a more generic form of
which allows an interdependency on specific tasks rather than specifying the
data in DEPENDS or RDEPENDS.</para>
                <para><screen>do_patch[depends] =
"quilt-native:do_populate_staging"</screen></para>
                <para>means the do_populate_staging task of the target
quilt-native must have completed before the do_patch can execute.</para>
@@ -278,35 +278,34 @@ SRC_URI_append_1.0.7+ =
"file://some_patch_which_the_new_versions_need.patch;pat
        <section>
            <title>Parsing</title>
            <section>
-                <title>Configuration Files</title>
-                <para>The first of the classifications of metadata in
BitBake is configuration metadata.  This metadata is global, and therefore
affects <emphasis>all</emphasis> packages and tasks which are
executed.</para>
-                <para>Bitbake will first search the current working
directory for an optional "conf/bblayers.conf" configuration file. This file
is expected to contain a BBLAYERS variable which is a space delimited list
of 'layer' directories. For each directory in this list a "conf/layer.conf"
file will be searched for and parsed with the LAYERDIR variable being set to
the directory where the layer was found. The idea is these files will setup
BBPATH and other variables correctly for a given build directory
automatically for the user.</para>
-                <para>Bitbake will then expect to find 'conf/bitbake.conf'
somewhere in the user specified <envar>BBPATH</envar>.  That configuration
file generally has include directives to pull in any other metadata
(generally files specific to architecture, machine,
<emphasis>local</emphasis> and so on.</para>
+                <title>Configuration files</title>
+                <para>The first kind of metadata in BitBake is
configuration metadata.  This metadata is global, and therefore affects
<emphasis>all</emphasis> packages and tasks which are executed.</para>
+                <para>BitBake will first search the current working
directory for an optional "conf/bblayers.conf" configuration file. This file
is expected to contain a BBLAYERS variable which is a space delimited list
of 'layer' directories. For each directory in this list, a "conf/layer.conf"
file will be searched for and parsed with the LAYERDIR variable being set to
the directory where the layer was found. The idea is these files will setup
BBPATH and other variables correctly for a given build directory
automatically for the user.</para>
+                <para>BitBake will then expect to find 'conf/bitbake.conf'
somewhere in the user specified <envar>BBPATH</envar>.  That configuration
file generally has include directives to pull in any other metadata
(generally files specific to architecture, machine,
<emphasis>local</emphasis> and so on).</para>
                <para>Only variable definitions and include directives are
allowed in .conf files.</para>
            </section>
            <section>
                <title>Classes</title>
-                <para>BitBake classes are our rudimentary inheritance
mechanism.  As briefly mentioned in the metadata introduction, they're
parsed when an <literal>inherit</literal> directive is encountered, and they
are located in classes/ relative to the dirs in
<envar>BBPATH</envar>.</para>
+                <para>BitBake classes are our rudimentary inheritance
mechanism.  As briefly mentioned in the metadata introduction, they're
parsed when an <literal>inherit</literal> directive is encountered, and they
are located in classes/ relative to the directories in
<envar>BBPATH</envar>.</para>
            </section>
            <section>
-                <title>.bb Files</title>
+                <title>.bb files</title>
                <para>A BitBake (.bb) file is a logical unit of tasks to be
executed.  Normally this is a package to be built.  Inter-.bb dependencies
are obeyed.  The files themselves are located via the
<varname>BBFILES</varname> variable, which is set to a space separated list
of .bb files, and does handle wildcards.</para>
            </section>
        </section>
    </chapter>

    <chapter>
-        <title>File Download support</title>
+        <title>File download support</title>
        <section>
            <title>Overview</title>
-            <para>BitBake provides support to download files this procedure
is called fetching. The SRC_URI is normally used to indicate BitBake which
files to fetch. The next sections will describe th available fetchers and
the options they have. Each Fetcher honors a set of Variables and
-a per URI parameters separated by a <quote>;</quote> consisting of a key
and a value. The semantic of the Variables and Parameters are defined by the
Fetcher. BitBakes tries to have a consistent semantic between the different
Fetchers.
+            <para>BitBake provides support to download files this procedure
is called fetching. The SRC_URI is normally used to tell BitBake which files
to fetch. The next sections will describe the available fetchers and their
options. Each fetcher honors a set of variables and per URI parameters
separated by a <quote>;</quote> consisting of a key and a value. The
semantics of the variables and parameters are defined by the fetcher.
BitBake tries to have consistent semantics between the different fetchers.
            </para>
        </section>

        <section>
-            <title>Local File Fetcher</title>
-            <para>The URN for the Local File Fetcher is
<emphasis>file</emphasis>. The filename can be either absolute or relative.
If the filename is relative <varname>FILESPATH</varname> and
<varname>FILESDIR</varname> will be used to find the appropriate relative
file depending on the <varname>OVERRIDES</varname>. Single files and
complete directories can be specified.
+            <title>Local file fetcher</title>
+            <para>The URN for the local file fetcher is
<emphasis>file</emphasis>. The filename can be either absolute or relative.
If the filename is relative, <varname>FILESPATH</varname> and
<varname>FILESDIR</varname> will be used to find the appropriate relative
file, depending on the <varname>OVERRIDES</varname>. Single files and
complete directories can be specified.
 <screen><varname>SRC_URI</varname>= "file://relativefile.patch"
 <varname>SRC_URI</varname>= "file://relativefile.patch;this=ignored"
 <varname>SRC_URI</varname>= "file:///Users/ich/very_important_software"
@@ -315,10 +314,11 @@ a per URI parameters separated by a <quote>;</quote>
consisting of a key and a v
        </section>

        <section>
-            <title>CVS File Fetcher</title>
-            <para>The URN for the CVS Fetcher is <emphasis>cvs</emphasis>.
This Fetcher honors the variables <varname>DL_DIR</varname>,
<varname>SRCDATE</varname>, <varname>FETCHCOMMAND_cvs</varname>,
<varname>UPDATECOMMAND_cvs</varname>. <varname>DL_DIR</varname> specifies
where a temporary checkout is saved, <varname>SRCDATE</varname> specifies
which date to use when doing the fetching (the special value of "now" will
cause the checkout to be updated on every build),
<varname>FETCHCOMMAND</varname> and <varname>UPDATECOMMAND</varname> specify
which executables should be used when doing the CVS checkout or update.
+            <title>CVS file fetcher</title>
+            <para>The URN for the CVS fetcher is <emphasis>cvs</emphasis>.
This fetcher honors the variables <varname>DL_DIR</varname>,
<varname>SRCDATE</varname>, <varname>FETCHCOMMAND_cvs</varname>,
<varname>UPDATECOMMAND_cvs</varname>. <varname>DL_DIR</varname> specifies
where a temporary checkout is saved. <varname>SRCDATE</varname> specifies
which date to use when doing the fetching (the special value of "now" will
cause the checkout to be updated on every build).
<varname>FETCHCOMMAND</varname> and <varname>UPDATECOMMAND</varname> specify
which executables to use for the CVS checkout or update.
            </para>
-            <para>The supported Parameters are <varname>module</varname>,
<varname>tag</varname>, <varname>date</varname>, <varname>method</varname>,
<varname>localdir</varname>, <varname>rsh</varname> and
<varname>scmdata</varname>. The <varname>module</varname> specifies which
module to check out, the <varname>tag</varname> describes which CVS TAG
should be used for the checkout. By default the TAG is empty. A
<varname>date</varname> can be specified to override the SRCDATE of the
configuration to checkout a specific date.  The special value of "now" will
cause the checkout to be updated on every build.<varname>method</varname> is
by default <emphasis>pserver</emphasis>, if <emphasis>ext</emphasis> is used
the <varname>rsh</varname> parameter will be evaluated and
<varname>CVS_RSH</varname> will be set. Finally <varname>localdir</varname>
is used to checkout into a special directory relative to
<varname>CVSDIR</varname>. If <varname>scmdata</varname> is set to
<quote>keep</quote>
+            <para>The supported parameters are <varname>module</varname>,
<varname>tag</varname>, <varname>date</varname>, <varname>method</varname>,
<varname>localdir</varname>, <varname>rsh</varname> and
<varname>scmdata</varname>. The <varname>module</varname> specifies which
module to check out, the <varname>tag</varname> describes which CVS TAG
should be used for the checkout. By default the TAG is empty. A
<varname>date</varname> can be specified to override the SRCDATE of the
configuration to checkout a specific date.  The special value of "now" will
cause the checkout to be updated on every build.<varname>method</varname> is
by default <emphasis>pserver</emphasis>. If <emphasis>ext</emphasis> is used
the <varname>rsh</varname> parameter will be evaluated and
<varname>CVS_RSH</varname> will be set. Finally, <varname>localdir</varname>
is used to checkout into a special directory relative to
<varname>CVSDIR</varname>.
+
 <screen><varname>SRC_URI</varname> =
"cvs://CVSROOT;module=mymodule;tag=some-version;method=ext"
 <varname>SRC_URI</varname> =
"cvs://CVSROOT;module=mymodule;date=20060126;localdir=usethat"
 </screen>
@@ -326,11 +326,10 @@ a per URI parameters separated by a <quote>;</quote>
consisting of a key and a v
        </section>

        <section>
-            <title>HTTP/FTP Fetcher</title>
-            <para>The URNs for the HTTP/FTP are <emphasis>http</emphasis>,
<emphasis>https</emphasis> and <emphasis>ftp</emphasis>. This Fetcher honors
the variables <varname>DL_DIR</varname>,
<varname>FETCHCOMMAND_wget</varname>, <varname>PREMIRRORS</varname>,
<varname>MIRRORS</varname>. The <varname>DL_DIR</varname> defines where to
store the fetched file, <varname>FETCHCOMMAND</varname> contains the command
used for fetching. <quote>${URI}</quote> and <quote>${FILES}</quote> will be
replaced by the uri and basename of the to be fetched file.
<varname>PREMIRRORS</varname>
-will be tried first when fetching a file if that fails the actual file will
be tried and finally all <varname>MIRRORS</varname> will be tried.
+            <title>HTTP/FTP fetcher</title>
+            <para>The URNs for the HTTP/FTP fetcher are
<emphasis>http</emphasis>, <emphasis>https</emphasis> and
<emphasis>ftp</emphasis>. This fetcher honors the variables
<varname>DL_DIR</varname>, <varname>FETCHCOMMAND_wget</varname>,
<varname>PREMIRRORS</varname>, <varname>MIRRORS</varname>. The
<varname>DL_DIR</varname> defines where to store the fetched file.
<varname>FETCHCOMMAND</varname> contains the command used for fetching.
<quote>${URI}</quote> and <quote>${FILES}</quote> will be replaced by the
URI and basename of the file to be fetched. <varname>PREMIRRORS</varname>
will be tried first when fetching a file. If that fails, the actual file
will be tried and finally all <varname>MIRRORS</varname> will be tried.
            </para>
-            <para>The only supported Parameter is
<varname>md5sum</varname>. After a fetch the <varname>md5sum</varname> of
the file will be calculated and the two sums will be compared.
+            <para>The only supported parameter is
<varname>md5sum</varname>. After a fetch the <varname>md5sum</varname> of
the file will be calculated and the two sums will be compared.
            </para>
            <para><screen><varname>SRC_URI</varname> = "
http://oe.handhelds.org/not_there.aac;md5sum=12343"
 <varname>SRC_URI</varname> = "
ftp://oe.handhelds.org/not_there_as_well.aac;md5sum=1234"
@@ -339,19 +338,19 @@ will be tried first when fetching a file if that fails
the actual file will be t
        </section>

        <section>
-            <title>SVK Fetcher</title>
+            <title>SVK fetcher</title>
            <para>
            <emphasis>Currently NOT supported</emphasis>
            </para>
        </section>

        <section>
-            <title>SVN Fetcher</title>
-            <para>The URN for the SVN Fetcher is <emphasis>svn</emphasis>.
+            <title>SVN fetcher</title>
+            <para>The URN for the SVN fetcher is <emphasis>svn</emphasis>.
            </para>
-            <para>This Fetcher honors the variables
<varname>FETCHCOMMAND_svn</varname>, <varname>DL_DIR</varname>,
<varname>SRCDATE</varname>. <varname>FETCHCOMMAND</varname> contains the
subversion command, <varname>DL_DIR</varname> is the directory where
tarballs will be saved, <varname>SRCDATE</varname> specifies which date to
use when doing the fetching (the special value of "now" will cause the
checkout to be updated on every build).
+            <para>This fetcher honors the variables
<varname>FETCHCOMMAND_svn</varname>, <varname>DL_DIR</varname>,
<varname>SRCDATE</varname>. <varname>FETCHCOMMAND</varname> contains the
subversion command. <varname>DL_DIR</varname> is the directory where
tarballs will be saved. <varname>SRCDATE</varname> specifies which date to
use when doing the fetching (the special value of "now" will cause the
checkout to be updated on every build).
            </para>
-            <para>The supported Parameters are <varname>proto</varname>,
<varname>rev</varname> and <varname>scmdata</varname>.
<varname>proto</varname> is the subversion protocol, <varname>rev</varname>
is the subversion revision. If <varname>scmdata</varname> is set to
<quote>keep</quote>, the <quote>.svn</quote> directories will be available
during compile-time.
+            <para>The supported parameters are <varname>proto</varname>,
<varname>rev</varname> and <varname>scmdata</varname>.
<varname>proto</varname> is the Subversion protocol, <varname>rev</varname>
is the Subversion revision. If <varname>scmdata</varname> is set to
<quote>keep</quote>, the <quote>.svn</quote> directories will be available
during compile-time.
            </para>
            <para><screen><varname>SRC_URI</varname> = "svn://
svn.oe.handhelds.org/svn;module=vip;proto=http;rev=667"
 <varname>SRC_URI</varname> = "svn://
svn.oe.handhelds.org/svn/;module=opie;proto=svn+ssh;date=20060126"
@@ -359,12 +358,12 @@ will be tried first when fetching a file if that fails
the actual file will be t
        </section>

        <section>
-            <title>GIT Fetcher</title>
+            <title>GIT fetcher</title>
            <para>The URN for the GIT Fetcher is <emphasis>git</emphasis>.
            </para>
            <para>The Variables <varname>DL_DIR</varname>,
<varname>GITDIR</varname> are used. <varname>DL_DIR</varname> will be used
to store the checkedout version. <varname>GITDIR</varname> will be used as
the base directory where the git tree is cloned to.
            </para>
-            <para>The Parameters are <emphasis>tag</emphasis>,
<emphasis>protocol</emphasis> and <emphasis>scmdata</emphasis>.
<emphasis>tag</emphasis> is a git tag, the default is <quote>master</quote>.
<emphasis>protocol</emphasis> is the git protocol to use and defaults to
<quote>rsync</quote>. If <emphasis>scmdata</emphasis> is set to
<quote>keep</quote>, the <quote>.git</quote> directory will be available
during compile-time.
+            <para>The parameters are <emphasis>tag</emphasis>,
<emphasis>protocol</emphasis> and <emphasis>scmdata</emphasis>.
<emphasis>tag</emphasis> is a Git tag, the default is <quote>master</quote>.
<emphasis>protocol</emphasis> is the Git protocol to use and defaults to
<quote>rsync</quote>. If <emphasis>scmdata</emphasis> is set to
<quote>keep</quote>, the <quote>.git</quote> directory will be available
during compile-time.
            </para>
            <para><screen><varname>SRC_URI</varname> = "git://
git.oe.handhelds.org/git/vip.git;tag=version-1"
 <varname>SRC_URI</varname> = "git://
git.oe.handhelds.org/git/vip.git;protocol=http"
@@ -375,13 +374,13 @@ will be tried first when fetching a file if that fails
the actual file will be t


    <chapter>
-        <title>The bitbake command</title>
+        <title>The BitBake command</title>
            <section>
                <title>Introduction</title>
                <para>bitbake is the primary command in the system.  It
facilitates executing tasks in a single .bb file, or executing a given task
on a set of multiple .bb files, accounting for interdependencies amongst
them.</para>
            </section>
            <section>
-                <title>Usage and Syntax</title>
+                <title>Usage and syntax</title>
                <para>
                    <screen><prompt>$ </prompt>bitbake --help
 usage: bitbake [options] [package ...]
@@ -438,7 +437,7 @@ options:
                <para>
                <example>
                    <title>Executing a task against a single .bb</title>
-                    <para>Executing tasks for a single file is relatively
simple.  You specify the file in question, and bitbake parses it and
executes the specified task (or <quote>build</quote> by default).  It obeys
intertask dependencies when doing so.</para>
+                    <para>Executing tasks for a single file is relatively
simple.  You specify the file in question, and BitBake parses it and
executes the specified task (or <quote>build</quote> by default).  It obeys
intertask dependencies when doing so.</para>
                    <para><quote>clean</quote> task:</para>
                    <para><screen><prompt>$ </prompt>bitbake -b blah_1.0.bb -c
clean</screen></para>
                    <para><quote>build</quote> task:</para>
@@ -448,8 +447,8 @@ options:
                <para>
                <example>
                    <title>Executing tasks against a set of .bb
files</title>
-                    <para>There are a number of additional complexities
introduced when one wants to manage multiple .bb files.  Clearly there needs
to be a way to tell bitbake what files are available, and of those, which we
want to execute at this time.  There also needs to be a way for each .bb to
express its dependencies, both for build time and runtime.  There must be a
way for the user to express their preferences when multiple .bb's provide
the same functionality, or when there are multiple versions of a .bb.</para>
-                    <para>The next section, Metadata, outlines how one goes
about specifying such things.</para>
+                    <para>There are a number of additional complexities
introduced when one wants to manage multiple .bb files.  Clearly there needs
to be a way to tell BitBake what files are available, and of those, which we
want to execute at this time.  There also needs to be a way for each .bb to
express its dependencies, both for build time and runtime.  There must be a
way for the user to express their preferences when multiple .bb's provide
the same functionality, or when there are multiple versions of a .bb.</para>
+                    <para>The next section, Metadata, outlines how to
specify such things.</para>
                    <para>Note that the bitbake command, when not using
--buildfile, accepts a <varname>PROVIDER</varname>, not a filename or
anything else.  By default, a .bb generally PROVIDES its packagename,
packagename-version, and packagename-version-revision.</para>
                    <screen><prompt>$ </prompt>bitbake blah</screen>
                    <screen><prompt>$ </prompt>bitbake blah-1.0</screen>
@@ -461,8 +460,8 @@ options:
                <example>
                    <title>Generating dependency graphs</title>
                    <para>BitBake is able to generate dependency graphs
using the dot syntax. These graphs can be converted
-to images using the <application>dot</application> application from <ulink
url="http://www.graphviz.org">graphviz</ulink>.
-Two files will be written into the current working directory,
<emphasis>depends.dot</emphasis> containing dependency information at the
package level and <emphasis>task-depends.dot</emphasis> containing a
breakdown of the dependencies at the task level. To stop depending on common
depends one can use the <prompt>-I depend</prompt> to omit these from the
graph. This can lead to more readable graphs. E.g. this way
<varname>DEPENDS</varname> from inherited classes, e.g. base.bbclass, can be
removed from the graph.</para>
+to images using the <application>dot</application> application from <ulink
url="http://www.graphviz.org">Graphviz</ulink>.
+Two files will be written into the current working directory,
<emphasis>depends.dot</emphasis> containing dependency information at the
package level and <emphasis>task-depends.dot</emphasis> containing a
breakdown of the dependencies at the task level. To stop depending on common
depends, one can use the <prompt>-I depend</prompt> to omit these from the
graph. This can lead to more readable graphs.  This way,
<varname>DEPENDS</varname> from inherited classes such as base.bbclass can
be removed from the graph.</para>
                    <screen><prompt>$ </prompt>bitbake -g blah</screen>
                    <screen><prompt>$ </prompt>bitbake -g -I
virtual/whatever -I bloom blah</screen>
                </example>
@@ -470,20 +469,20 @@ Two files will be written into the current working
directory, <emphasis>depends.
            </section>
            <section>
                <title>Special variables</title>
-                <para>Certain variables affect bitbake operation:</para>
+                <para>Certain variables affect BitBake operation:</para>
                <section>
                    <title><varname>BB_NUMBER_THREADS</varname></title>
-                    <para> The number of threads bitbake should run at once
(default: 1).</para>
+                    <para> The number of threads BitBake should run at once
(default: 1).</para>
                </section>
            </section>
            <section>
                <title>Metadata</title>
-                <para>As you may have seen in the usage information, or in
the information about .bb files, the BBFILES variable is how the bitbake tool
locates its files.  This variable is a space separated list of files that
are available, and supports wildcards.
+                <para>As you may have seen in the usage information, or in
the information about .bb files, the <varname>BBFILES</varname> variable is
how the BitBake tool locates its files.  This variable is a space separated
list of files that are available, and supports wildcards.
                <example>
                    <title>Setting BBFILES</title>
                    <programlisting><varname>BBFILES</varname> =
"/path/to/bbfiles/*.bb"</programlisting>
                </example></para>
-                <para>With regard to dependencies, it expects the .bb to
define a <varname>DEPENDS</varname> variable, which contains a space
separated list of <quote>package names</quote>, which themselves are the
<varname>PN</varname> variable.  The <varname>PN</varname> variable is, in
general, by default, set to a component of the .bb filename.</para>
+                <para>With regard to dependencies, it expects the .bb to
define a <varname>DEPENDS</varname> variable, which contains a space
separated list of <quote>package names</quote>, which themselves are the
<varname>PN</varname> variable.  The <varname>PN</varname> variable is, in
general, set to a component of the .bb filename by default.</para>
                <example>
                    <title>Depending on another .bb</title>
                    <para>a.bb:
@@ -496,7 +495,7 @@ DEPENDS += "package-b"</screen>
                </example>
                <example>
                    <title>Using PROVIDES</title>
-                    <para>This example shows the usage of the PROVIDES
variable, which allows a given .bb to specify what functionality it
provides.</para>
+                    <para>This example shows the usage of the
<varname>PROVIDES</varname> variable, which allows a given .bb to specify
what functionality it provides.</para>
                    <para>package1.bb:
    <screen>PROVIDES += "virtual/package"</screen>
                    </para>
@@ -506,16 +505,16 @@ DEPENDS += "package-b"</screen>
                    <para>package3.bb:
    <screen>PROVIDES += "virtual/package"</screen>
                    </para>
-                    <para>As you can see, here there are two different
.bb's that provide the same functionality (virtual/package).  Clearly, there
needs to be a way for the person running bitbake to control which of those
providers gets used.  There is, indeed, such a way.</para>
+                    <para>As you can see, we have two different .bb's that
provide the same functionality (virtual/package).  Clearly, there needs to
be a way for the person running BitBake to control which of those providers
gets used.  There is, indeed, such a way.</para>
                    <para>The following would go into a .conf file, to
select package1:
    <screen>PREFERRED_PROVIDER_virtual/package = "package1"</screen>
                    </para>
                </example>
                <example>
                    <title>Specifying version preference</title>
-                    <para>When there are multiple <quote>versions</quote>
of a given package, bitbake defaults to selecting the most recent version,
unless otherwise specified.  If the .bb in question has a
<varname>DEFAULT_PREFERENCE</varname> set lower than the other .bb's
(default is 0), then it will not be selected.  This allows the person or
persons maintaining the repository of .bb files to specify their preferences
for the default selected version.  In addition, the user can specify their
preferences with regard to version.</para>
+                    <para>When there are multiple <quote>versions</quote>
of a given package, BitBake defaults to selecting the most recent version,
unless otherwise specified.  If the .bb in question has a
<varname>DEFAULT_PREFERENCE</varname> set lower than the other .bb's
(default is 0), then it will not be selected.  This allows the person or
persons maintaining the repository of .bb files to specify their preference
for the default selected version.  In addition, the user can specify their
preferred version.</para>
                    <para>If the first .bb is named
<filename>a_1.1.bb</filename>,
then the <varname>PN</varname> variable will be set to <quote>a</quote>, and
the <varname>PV</varname> variable will be set to 1.1.</para>
-                    <para>If we then have an <filename>a_1.2.bb
</filename>, bitbake will choose 1.2 by default.  However, if we define the
following variable in a .conf that bitbake parses, we can change that.
+                    <para>If we then have an <filename>a_1.2.bb
</filename>, BitBake will choose 1.2 by default.  However, if we define the
following variable in a .conf that BitBake parses, we can change that.
    <screen>PREFERRED_VERSION_a = "1.1"</screen>
                    </para>
                </example>
--
1.7.1

--bcaec5101c735b584204a4d10df2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><span style=3D"border-collapse:collapse;font-fam=
ily:arial, sans-serif;font-size:13px">This patch contains what I hope are n=
on-controversial improvements to the manual. Most of the changes are single=
 characters, but the line-by-line diff makes the patch look large.<br>


<br>This is my first patch to=A0<span style=3D"background-color:rgb(169, 21=
8, 146);color:rgb(34, 34, 34);background-repeat:initial initial">Bitbake</s=
pan>, so please don&#39;t kill me immediately. (I originally sent this mess=
age, minus this sentence, around 2011-03-10, but the bitbake-dev list appea=
red to be silently dropping messages from 2011-03-07 until 2011-03-24. I re=
sent it again on 2011-03-27. I&#39;m now sending it to the post-migration b=
itbake-devel list on 2011-06-03.)<br>


<br>Signed-off-by: Brandon Stafford &lt;<a href=3D"mailto:brandon@pingswept=
.org" style=3D"color:rgb(51, 51, 204)" target=3D"_blank">brandon@pingswept.=
org</a>&gt;<br>---<br>=A0doc/manual/usermanual.xml | =A0131 +++++++++++++++=
+++++++-----------------------<br>


=A01 files changed, 65 insertions(+), 66 deletions(-)<br><br>diff --git a/d=
oc/manual/usermanual.xml b/doc/manual/usermanual.xml<br>index 32b40ee..946a=
812 100644<br>--- a/doc/manual/usermanual.xml<br>+++ b/doc/manual/usermanua=
l.xml<br>


@@ -29,7 +29,7 @@ tasks and managing metadata. =A0As such, its similarities=
 to GNU make and other<br>=A0build tools are readily apparent. =A0It was in=
spired by Portage, the package management system used by the Gentoo Linux d=
istribution. =A0<span style=3D"background-color:rgb(169, 218, 146);color:rg=
b(34, 34, 34);background-repeat:initial initial">BitBake</span>=A0is the ba=
sis of the &lt;ulink url=3D&quot;<a href=3D"http://www.openembedded.org/" s=
tyle=3D"color:rgb(51, 51, 204)" target=3D"_blank">http://www.openembedded.o=
rg/</a>&quot;&gt;OpenEmbedded&lt;/ulink&gt; project, which is being used to=
 build and maintain a number of embedded Linux distributions, including Ope=
nZaurus and Familiar.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 &lt;section&gt;<br>- =
=A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Background and Goals&lt;/title&gt;<br>+=
 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Background and goals&lt;/title&gt;<br>=
=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;Prior to=A0<span style=3D"background-co=
lor:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial init=
ial">BitBake</span>, no other build tool adequately met<br>


=A0the needs of an aspiring embedded Linux distribution. =A0All of the<br>=
=A0buildsystems used by traditional desktop Linux distributions lacked<br>@=
@ -42,9 +42,9 @@ embedded space, were scalable or maintainable.&lt;/para&gt=
;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;listitem&gt;&lt;para&gt;Handle crosscom=
pilation.&lt;/para&gt;&lt;/listitem&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
&lt;listitem&gt;&lt;para&gt;Handle interpackage dependencies (build time on=
 target architecture, build time on native architecture, and runtime).&lt;/=
para&gt;&lt;/listitem&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;listitem&gt;&lt;para&gt;Support running=
 any number of tasks within a given package, including, but not limited to,=
 fetching upstream sources, unpacking them, patching them, configuring them=
, et cetera.&lt;/para&gt;&lt;/listitem&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;listitem&gt;&lt;para&gt;Must be linux =
distribution agnostic (both build and target).&lt;/para&gt;&lt;/listitem&gt=
;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;listitem&gt;&lt;para&gt;Must be L=
inux distribution agnostic (both build and target).&lt;/para&gt;&lt;/listit=
em&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;listitem&gt;&lt;para&gt;Must be archite=
cture agnostic&lt;/para&gt;&lt;/listitem&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&lt;listitem&gt;&lt;para&gt;Must support multiple build and target o=
perating systems (including cygwin, the BSDs, etc).&lt;/para&gt;&lt;/listit=
em&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;listitem&gt;&lt;para&gt;Must support m=
ultiple build and target operating systems (including Cygwin, the BSDs, etc=
).&lt;/para&gt;&lt;/listitem&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;lis=
titem&gt;&lt;para&gt;Must be able to be self contained, rather than tightly=
 integrated into the build machine&#39;s root filesystem.&lt;/para&gt;&lt;/=
listitem&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;listitem&gt;&lt;para&gt;There must be a=
 way to handle conditional metadata (on target architecture, operating syst=
em, distribution, machine).&lt;/para&gt;&lt;/listitem&gt;<br>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &lt;listitem&gt;&lt;para&gt;It must be easy for the per=
son using the tools to supply their own local metadata and packages to oper=
ate against.&lt;/para&gt;&lt;/listitem&gt;<br>


@@ -91,7 +91,7 @@ share common metadata between many packages.&lt;/para&gt;=
&lt;/listitem&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Setting a default value (?=3D)&lt;/title&=
gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;&lt;varnam=
e&gt;A&lt;/varname&gt; ?=3D &quot;aval&quot;&lt;/screen&gt;&lt;/para&gt;<br=
>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;If &lt;varname&gt;A&lt;/varnam=
e&gt; is set before the above is called, it will retain it&#39;s previous v=
alue. If &lt;varname&gt;A&lt;/varname&gt; is unset prior to the above call,=
 &lt;varname&gt;A&lt;/varname&gt; will be set to &lt;literal&gt;aval&lt;/li=
teral&gt;. =A0Note that this assignment is immediate, so if there are multi=
ple ?=3D assignments to a single variable, the first of those will be used.=
&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;If &lt;varname&gt;A&lt;/varnam=
e&gt; is set before the above is called, it will retain its previous value.=
 If &lt;varname&gt;A&lt;/varname&gt; is unset prior to the above call, &lt;=
varname&gt;A&lt;/varname&gt; will be set to &lt;literal&gt;aval&lt;/literal=
&gt;. =A0Note that this assignment is immediate, so if there are multiple ?=
=3D assignments to a single variable, the first of those will be used.&lt;/=
para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Setting a default =
value (??=3D)&lt;/title&gt;<br>@@ -125,7 +125,7 @@ share common metadata be=
tween many packages.&lt;/para&gt;&lt;/listitem&gt;<br>


=A0&lt;varname&gt;B&lt;/varname&gt; .=3D &quot;additionaldata&quot;<br>=A0&=
lt;varname&gt;C&lt;/varname&gt; =3D &quot;cval&quot;<br>=A0&lt;varname&gt;C=
&lt;/varname&gt; =3D. &quot;test&quot;&lt;/screen&gt;&lt;/para&gt;<br>- =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;In this example, &lt;varname&gt;B&l=
t;/varname&gt; is now &lt;literal&gt;bvaladditionaldata&lt;/literal&gt; and=
 &lt;varname&gt;C&lt;/varname&gt; is &lt;literal&gt;testcval&lt;/literal&gt=
;. In contrast to the above Appending and Prepending operators no additiona=
l space<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;In this example, &lt;varname&g=
t;B&lt;/varname&gt; is now &lt;literal&gt;bvaladditionaldata&lt;/literal&gt=
; and &lt;varname&gt;C&lt;/varname&gt; is &lt;literal&gt;testcval&lt;/liter=
al&gt;. In contrast to the above appending and prepending operators, no add=
itional space<br>


=A0will be introduced.&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section=
&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>@@ -147,12 +147,12 @@ wi=
ll be introduced.&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<=
br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Inclusion&lt;/title&gt;<br>- =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Next, there is the &lt;literal&g=
t;include&lt;/literal&gt; directive, which causes=A0<span style=3D"backgrou=
nd-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial=
 initial">BitBake</span>=A0to parse in whatever file you specify, and inser=
t it at that location, which is not unlike &lt;command&gt;make&lt;/command&=
gt;. =A0However, if the path specified on the &lt;literal&gt;include&lt;/li=
teral&gt; line is a relative path,=A0<span style=3D"background-color:rgb(16=
9, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">BitBa=
ke</span>=A0will locate the first one it can find within &lt;envar&gt;BBPAT=
H&lt;/envar&gt;.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Next, there is the &lt;literal=
&gt;include&lt;/literal&gt; directive, which causes=A0<span style=3D"backgr=
ound-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initi=
al initial">BitBake</span>=A0to parse whatever file you specify, and insert=
 it at that location, which is not unlike &lt;command&gt;make&lt;/command&g=
t;. =A0However, if the path specified on the &lt;literal&gt;include&lt;/lit=
eral&gt; line is a relative path,=A0<span style=3D"background-color:rgb(169=
, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">BitBak=
e</span>=A0will locate the first one it can find within &lt;envar&gt;BBPATH=
&lt;/envar&gt;.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Requiring Inclusi=
on&lt;/title&gt;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Requiring=
 inclusion&lt;/title&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;In =
contrast to the &lt;literal&gt;include&lt;/literal&gt; directive, &lt;liter=
al&gt;require&lt;/literal&gt; will<br>


-raise an ParseError if the to be included file can not be found. Otherwise=
 it will behave just like the &lt;literal&gt;<br>+raise an ParseError if th=
e file to be included cannot be found. Otherwise it will behave just like t=
he &lt;literal&gt;<br>


=A0include&lt;/literal&gt; directive.&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =
=A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>@@ -171,=
10 +171,10 @@ include&lt;/literal&gt; directive.&lt;/para&gt;<br>=A0 =A0 im=
port time<br>=A0 =A0 print time.strftime(&#39;%Y%m%d&#39;, time.gmtime())<b=
r>


=A0}&lt;/screen&gt;&lt;/para&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;pa=
ra&gt;This is the similar to the previous, but flags it as python so that=
=A0<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34)=
;background-repeat:initial initial">BitBake</span>=A0knows it is python cod=
e.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;This is the similar to the pre=
vious, but flags it as Python so that=A0<span style=3D"background-color:rgb=
(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">Bi=
tBake</span>=A0knows it is Python code.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Defining python f=
unctions into the global python namespace&lt;/title&gt;<br>+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0&lt;title&gt;Defining Python functions into the global P=
ython namespace&lt;/title&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;emphasis&gt;NOTE:&lt;/empha=
sis&gt; This is only supported in .bb and .bbclass files.&lt;/para&gt;<br>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;def get_depends(b=
b, d):<br>=A0 =A0 if bb.data.getVar(&#39;SOMECONDITION&#39;, d, True):<br>


@@ -187,8 +187,8 @@ include&lt;/literal&gt; directive.&lt;/para&gt;<br>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;This would result in &lt;varname&gt=
;DEPENDS&lt;/varname&gt; containing &lt;literal&gt;dependencywithcond&lt;/l=
iteral&gt;.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Variable Flags&lt=
;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Variables can h=
ave associated flags which provide a way of tagging extra information onto =
a variable. Several flags are used internally by=A0<span style=3D"backgroun=
d-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial =
initial">bitbake</span>=A0but they can be used externally too if needed. Th=
e standard operations mentioned above also work on flags.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Variable flags&lt;/title&gt;<=
br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Variables can have associat=
ed flags which provide a way of tagging extra information onto a variable. =
Several flags are used internally by=A0<span style=3D"background-color:rgb(=
169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">Bit=
Bake</span>=A0but they can be used externally too if needed. The standard o=
perations mentioned above also work on flags.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;&lt;varname&gt;VA=
RIABLE&lt;/varname&gt;[&lt;varname&gt;SOMEFLAG&lt;/varname&gt;] =3D &quot;v=
alue&quot;&lt;/screen&gt;&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
lt;para&gt;In this example, &lt;varname&gt;VARIABLE&lt;/varname&gt; has a f=
lag, &lt;varname&gt;SOMEFLAG&lt;/varname&gt; which is set to &lt;literal&gt=
;value&lt;/literal&gt;.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>@@ -200,19 +200,19 @@ include&l=
t;/literal&gt; directive.&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;secti=
on&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Tasks&lt;/title&gt;<=
br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;emphasis&gt;NOTE:&lt;/em=
phasis&gt; This is only supported in .bb and .bbclass files.&lt;/para&gt;<b=
r>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;In=A0<span style=3D"background=
-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial i=
nitial">BitBake</span>, each step that needs to be run for a given .bb is k=
nown as a task. =A0There is a command &lt;literal&gt;addtask&lt;/literal&gt=
; to add new tasks (must be a defined python executable metadata and must s=
tart with &lt;quote&gt;do_&lt;/quote&gt;) and describe intertask dependenci=
es.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;In=A0<span style=3D"background=
-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial i=
nitial">BitBake</span>, each step that needs to be run for a given .bb is k=
nown as a task. =A0There is a command &lt;literal&gt;addtask&lt;/literal&gt=
; to add new tasks (must be a defined Python executable metadata and must s=
tart with &lt;quote&gt;do_&lt;/quote&gt;) and describe intertask dependenci=
es.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;python do_printda=
te () {<br>=A0 =A0 import time<br>=A0 =A0 print time.strftime(&#39;%Y%m%d&#=
39;, time.gmtime())<br>=A0}<br><br>=A0addtask printdate before do_build&lt;=
/screen&gt;&lt;/para&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;This defines the necessary pyt=
hon function and adds it as a task which is now a dependency of do_build (t=
he default task). =A0If anyone executes the do_build task, that will result=
 in do_printdate being run first.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;This defines the necessary Pyt=
hon function and adds it as a task which is now a dependency of do_build, t=
he default task. =A0If anyone executes the do_build task, that will result =
in do_printdate being run first.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Events&lt;/title&g=
t;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;emphasis&gt;NOTE:&lt;=
/emphasis&gt; This is only supported in .bb and .bbclass files.&lt;/para&gt=
;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">BitBake</span>=A0allows to install event handlers. =A0Events are trigger=
ed at certain points during operation, such as, the beginning of operation =
against a given .bb, the start of a given task, task failure, task success,=
 et cetera. =A0The intent was to make it easy to do things like email notif=
ications on build failure.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">BitBake</span>=A0allows installation of event handlers. =A0Events are tr=
iggered at certain points during operation, such as the beginning of operat=
ion against a given .bb, the start of a given task, task failure, task succ=
ess, et cetera. =A0The intent is to make it easy to do things like email no=
tification on build failure.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;addhandler myclas=
s_eventhandler<br>=A0python myclass_eventhandler() {<br>=A0 =A0 from bb.eve=
nt import getName<br>@@ -228,20 +228,20 @@ of the event and the content of =
the &lt;varname&gt;FILE&lt;/varname&gt; variable.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Variants&lt;/title=
&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Two=A0<span style=3D"b=
ackground-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:=
initial initial">Bitbake</span>=A0features exist to facilitate the creation=
 of multiple buildable incarnations from a single recipe file.&lt;/para&gt;=
<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The first is &lt;varname&gt;BB=
CLASSEXTEND&lt;/varname&gt;. =A0This variable is a space separated list of =
classes to utilize to &quot;extend&quot; the recipe for each variant. =A0As=
 an example, setting &lt;screen&gt;BBCLASSEXTEND =3D &quot;native&quot;&lt;=
/screen&gt; results in a second incarnation of the current recipe being ava=
ilable. =A0This second incarantion will have the &quot;native&quot; class i=
nherited.&lt;/para&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The second feature is &lt;varn=
ame&gt;BBVERSIONS&lt;/varname&gt;. =A0This variable allows a single recipe =
to be able to build multiple versions of a project from a single recipe fil=
e, and allows you to specify conditional metadata (using the &lt;varname&gt=
;OVERRIDES&lt;/varname&gt; mechanism) for a single version, or an optionall=
y named range of versions:&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Two=A0<span style=3D"backgroun=
d-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial =
initial">BitBake</span>=A0features exist to facilitate the creation of mult=
iple buildable incarnations from a single recipe file.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The first is &lt;varname&gt;BB=
CLASSEXTEND&lt;/varname&gt;. =A0This variable is a space separated list of =
classes used to &quot;extend&quot; the recipe for each variant. =A0As an ex=
ample, setting &lt;screen&gt;BBCLASSEXTEND =3D &quot;native&quot;&lt;/scree=
n&gt; results in a second incarnation of the current recipe being available=
. =A0This second incarantion will have the &quot;native&quot; class inherit=
ed.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The second feature is &lt;varn=
ame&gt;BBVERSIONS&lt;/varname&gt;. =A0This variable allows a single recipe =
to build multiple versions of a project from a single recipe file, and allo=
ws you to specify conditional metadata (using the &lt;varname&gt;OVERRIDES&=
lt;/varname&gt; mechanism) for a single version, or an optionally named ran=
ge of versions:&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;BBVERSIONS =3D &q=
uot;1.0 2.0 git&quot;<br>=A0SRC_URI_git =3D &quot;git://someurl/somepath.gi=
t&quot;&lt;/screen&gt;&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;=
para&gt;&lt;screen&gt;BBVERSIONS =3D &quot;1.0.[0-6]:1.0.0+ \<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 1.0.[7-9]:1.0.7+&quot;<br>=A0SRC_URI_append_1.0=
.7+ =3D &quot;file://some_patch_which_the_new_versions_need.patch;patch=3D1=
&quot;&lt;/screen&gt;&lt;/para&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;=
para&gt;Note that the name of the range will default to the original versio=
n of the recipe, so given OE, a recipe file of foo_1.0.0+.bb will default t=
he name of its versions to 1.0.0+. =A0This is useful, as the range name is =
not only placed into overrides, it&#39;s also made available for the metada=
ta to use in the form of the &lt;varname&gt;BPV&lt;/varname&gt; variable, f=
or use in file:// search paths (&lt;varname&gt;FILESPATH&lt;/varname&gt;).&=
lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Note that the name of the rang=
e will default to the original version of the recipe, so given OE, a recipe=
 file of foo_1.0.0+.bb will default the name of its versions to 1.0.0+. =A0=
This is useful, as the range name is not only placed into overrides; it&#39=
;s also made available for the metadata to use in the form of the &lt;varna=
me&gt;BPV&lt;/varname&gt; variable, for use in file:// search paths (&lt;va=
rname&gt;FILESPATH&lt;/varname&gt;).&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 &lt;/section&gt=
;<br>=A0 =A0 =A0 =A0 &lt;section&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;title&=
gt;Dependency Handling&lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&g=
t;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);=
background-repeat:initial initial">Bitbake</span>=A01.7.x onwards works wit=
h the metadata at the task level since this is optimal when dealing with mu=
ltiple threads of execution. A robust method of specifing task dependencies=
 is therefore needed. &lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Dependency handling&lt;/title&gt;<br>=
+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-color:rgb(16=
9, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">BitBa=
ke</span>=A01.7.x onwards works with the metadata at the task level since t=
his is optimal when dealing with multiple threads of execution. A robust me=
thod of specifing task dependencies is therefore needed. &lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
&lt;title&gt;Dependencies internal to the .bb file&lt;/title&gt;<br>=A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;Where the dependencies are internal to=
 a given .bb file, the dependencies are handled by the previously detailed =
addtask directive.&lt;/para&gt;<br>


@@ -249,26 +249,26 @@ SRC_URI_append_1.0.7+ =3D &quot;file://some_patch_whi=
ch_the_new_versions_need.patch;pat<br><br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;secti=
on&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;DEPENDS&lt;/title&gt=
;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;DEPENDS is taken to speci=
fy build time dependencies. The &#39;deptask&#39; flag for tasks is used to=
 signify the task of each DEPENDS which must have completed before that tas=
k can be executed.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;DEPENDS lists build time depen=
dencies. The &#39;deptask&#39; flag for tasks is used to signify the task o=
f each item listed in DEPENDS which must have completed before that task ca=
n be executed.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;do_configure[dept=
ask] =3D &quot;do_populate_staging&quot;&lt;/screen&gt;&lt;/para&gt;<br>=A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;means the do_populate_staging task=
 of each item in DEPENDS must have completed before do_configure can execut=
e.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;RDEPENDS&lt;/title=
&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;RDEPENDS is taken to s=
pecify runtime dependencies. The &#39;rdeptask&#39; flag for tasks is used =
to signify the task of each RDEPENDS which must have completed before that =
task can be executed.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;RDEPENDS lists runtime depende=
ncies. The &#39;rdeptask&#39; flag for tasks is used to signify the task of=
 each item listed in RDEPENDS which must have completed before that task ca=
n be executed.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;do_package_write[=
rdeptask] =3D &quot;do_package&quot;&lt;/screen&gt;&lt;/para&gt;<br>=A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;means the do_package task of each item=
 in RDEPENDS must have completed before do_package_write can execute.&lt;/p=
ara&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Recursive DEPENDS&=
lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;These are spe=
cified with the &#39;recdeptask&#39; flag and is used signify the task(s) o=
f each DEPENDS which must have completed before that task can be executed. =
It applies recursively so also, the DEPENDS of each item in the original DE=
PENDS must be met and so on.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;These are specified with the &=
#39;recdeptask&#39; flag and is used signify the task(s) of each DEPENDS wh=
ich must have completed before that task can be executed. It applies recurs=
ively so the DEPENDS of each item in the original DEPENDS must be met and s=
o on.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Recursive RDEPENDS=
&lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;These are sp=
ecified with the &#39;recrdeptask&#39; flag and is used signify the task(s)=
 of each RDEPENDS which must have completed before that task can be execute=
d. It applies recursively so also, the RDEPENDS of each item in the origina=
l RDEPENDS must be met and so on. It also runs all DEPENDS first too.&lt;/p=
ara&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;These are specified with the &=
#39;recrdeptask&#39; flag and is used signify the task(s) of each RDEPENDS =
which must have completed before that task can be executed. It applies recu=
rsively so the RDEPENDS of each item in the original RDEPENDS must be met a=
nd so on. It also runs all DEPENDS first.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Inter Task&lt;/ti=
tle&gt;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Inter task&lt;/tit=
le&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;The &#39;depends&#39;=
 flag for tasks is a more generic form of which allows an interdependency o=
n specific tasks rather than specifying the data in DEPENDS or RDEPENDS.&lt=
;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;screen&gt;do_patch[depends]=
 =3D &quot;quilt-native:do_populate_staging&quot;&lt;/screen&gt;&lt;/para&g=
t;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;means the do_populate_sta=
ging task of the target quilt-native must have completed before the do_patc=
h can execute.&lt;/para&gt;<br>


@@ -278,35 +278,34 @@ SRC_URI_append_1.0.7+ =3D &quot;file://some_patch_whi=
ch_the_new_versions_need.patch;pat<br>=A0 =A0 =A0 =A0 &lt;section&gt;<br>=
=A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Parsing&lt;/title&gt;<br>=A0 =A0 =A0 =
=A0 =A0 =A0 &lt;section&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&g=
t;Configuration Files&lt;/title&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The first of the classificatio=
ns of metadata in=A0<span style=3D"background-color:rgb(169, 218, 146);colo=
r:rgb(34, 34, 34);background-repeat:initial initial">BitBake</span>=A0is co=
nfiguration metadata. =A0This metadata is global, and therefore affects &lt=
;emphasis&gt;all&lt;/emphasis&gt; packages and tasks which are executed.&lt=
;/para&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">Bitbake</span>=A0will first search the current working directory for an =
optional &quot;conf/bblayers.conf&quot; configuration file. This file is ex=
pected to contain a BBLAYERS variable which is a space delimited list of &#=
39;layer&#39; directories. For each directory in this list a &quot;conf/lay=
er.conf&quot; file will be searched for and parsed with the LAYERDIR variab=
le being set to the directory where the layer was found. The idea is these =
files will setup BBPATH and other variables correctly for a given build dir=
ectory automatically for the user.&lt;/para&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">Bitbake</span>=A0will then expect to find &#39;conf/<span style=3D"backg=
round-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:init=
ial initial">bitbake</span>.conf&#39; somewhere in the user specified &lt;e=
nvar&gt;BBPATH&lt;/envar&gt;. =A0That configuration file generally has incl=
ude directives to pull in any other metadata (generally files specific to a=
rchitecture, machine, &lt;emphasis&gt;local&lt;/emphasis&gt; and so on.&lt;=
/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Configuration files&lt;/title=
&gt;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The first kind of meta=
data in=A0<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, =
34, 34);background-repeat:initial initial">BitBake</span>=A0is configuratio=
n metadata. =A0This metadata is global, and therefore affects &lt;emphasis&=
gt;all&lt;/emphasis&gt; packages and tasks which are executed.&lt;/para&gt;=
<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">BitBake</span>=A0will first search the current working directory for an =
optional &quot;conf/bblayers.conf&quot; configuration file. This file is ex=
pected to contain a BBLAYERS variable which is a space delimited list of &#=
39;layer&#39; directories. For each directory in this list, a &quot;conf/la=
yer.conf&quot; file will be searched for and parsed with the LAYERDIR varia=
ble being set to the directory where the layer was found. The idea is these=
 files will setup BBPATH and other variables correctly for a given build di=
rectory automatically for the user.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">BitBake</span>=A0will then expect to find &#39;conf/<span style=3D"backg=
round-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:init=
ial initial">bitbake</span>.conf&#39; somewhere in the user specified &lt;e=
nvar&gt;BBPATH&lt;/envar&gt;. =A0That configuration file generally has incl=
ude directives to pull in any other metadata (generally files specific to a=
rchitecture, machine, &lt;emphasis&gt;local&lt;/emphasis&gt; and so on).&lt=
;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;Only variable definitions and i=
nclude directives are allowed in .conf files.&lt;/para&gt;<br>=A0 =A0 =A0 =
=A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Classes&lt;/title&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">BitBake</span>=A0classes are our rudimentary inheritance mechanism. =A0A=
s briefly mentioned in the metadata introduction, they&#39;re parsed when a=
n &lt;literal&gt;inherit&lt;/literal&gt; directive is encountered, and they=
 are located in classes/ relative to the dirs in &lt;envar&gt;BBPATH&lt;/en=
var&gt;.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">BitBake</span>=A0classes are our rudimentary inheritance mechanism. =A0A=
s briefly mentioned in the metadata introduction, they&#39;re parsed when a=
n &lt;literal&gt;inherit&lt;/literal&gt; directive is encountered, and they=
 are located in classes/ relative to the directories in &lt;envar&gt;BBPATH=
&lt;/envar&gt;.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;.bb Files&lt;/tit=
le&gt;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;.bb files&lt;/title=
&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;A=A0<span style=3D"back=
ground-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:ini=
tial initial">BitBake</span>=A0(.bb) file is a logical unit of tasks to be =
executed. =A0Normally this is a package to be built. =A0Inter-.bb dependenc=
ies are obeyed. =A0The files themselves are located via the &lt;varname&gt;=
BBFILES&lt;/varname&gt; variable, which is set to a space separated list of=
 .bb files, and does handle wildcards.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 &lt;/section&gt=
;<br>=A0 =A0 &lt;/chapter&gt;<br><br>=A0 =A0 &lt;chapter&gt;<br>- =A0 =A0 =
=A0 =A0&lt;title&gt;File Download support&lt;/title&gt;<br>+ =A0 =A0 =A0 =
=A0&lt;title&gt;File download support&lt;/title&gt;<br>


=A0 =A0 =A0 =A0 &lt;section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Ove=
rview&lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"=
background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat=
:initial initial">BitBake</span>=A0provides support to download files this =
procedure is called fetching. The SRC_URI is normally used to indicate=A0<s=
pan style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);back=
ground-repeat:initial initial">BitBake</span>=A0which files to fetch. The n=
ext sections will describe th available fetchers and the options they have.=
 Each Fetcher honors a set of Variables and<br>


-a per URI parameters separated by a &lt;quote&gt;;&lt;/quote&gt; consistin=
g of a key and a value. The semantic of the Variables and Parameters are de=
fined by the Fetcher. BitBakes tries to have a consistent semantic between =
the different Fetchers.<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;<span style=3D"background-color:rgb(16=
9, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">BitBa=
ke</span>=A0provides support to download files this procedure is called fet=
ching. The SRC_URI is normally used to tell=A0<span style=3D"background-col=
or:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initi=
al">BitBake</span>=A0which files to fetch. The next sections will describe =
the available fetchers and their options. Each fetcher honors a set of vari=
ables and per URI parameters separated by a &lt;quote&gt;;&lt;/quote&gt; co=
nsisting of a key and a value. The semantics of the variables and parameter=
s are defined by the fetcher.=A0<span style=3D"background-color:rgb(169, 21=
8, 146);color:rgb(34, 34, 34);background-repeat:initial initial">BitBake</s=
pan>=A0tries to have consistent semantics between the different fetchers.<b=
r>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>=A0 =A0 =A0 =A0 &lt;/section&gt;<b=
r><br>=A0 =A0 =A0 =A0 &lt;section&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;title=
&gt;Local File Fetcher&lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&g=
t;The URN for the Local File Fetcher is &lt;emphasis&gt;file&lt;/emphasis&g=
t;. The filename can be either absolute or relative. If the filename is rel=
ative &lt;varname&gt;FILESPATH&lt;/varname&gt; and &lt;varname&gt;FILESDIR&=
lt;/varname&gt; will be used to find the appropriate relative file dependin=
g on the &lt;varname&gt;OVERRIDES&lt;/varname&gt;. Single files and complet=
e directories can be specified.<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Local file fetcher&lt;/title&gt;<br>+=
 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The URN for the local file fetcher is &=
lt;emphasis&gt;file&lt;/emphasis&gt;. The filename can be either absolute o=
r relative. If the filename is relative, &lt;varname&gt;FILESPATH&lt;/varna=
me&gt; and &lt;varname&gt;FILESDIR&lt;/varname&gt; will be used to find the=
 appropriate relative file, depending on the &lt;varname&gt;OVERRIDES&lt;/v=
arname&gt;. Single files and complete directories can be specified.<br>


=A0&lt;screen&gt;&lt;varname&gt;SRC_URI&lt;/varname&gt;=3D &quot;file://rel=
ativefile.patch&quot;<br>=A0&lt;varname&gt;SRC_URI&lt;/varname&gt;=3D &quot=
;file://relativefile.patch;this=3Dignored&quot;<br>=A0&lt;varname&gt;SRC_UR=
I&lt;/varname&gt;=3D &quot;file:///Users/ich/very_important_software&quot;<=
br>


@@ -315,10 +314,11 @@ a per URI parameters separated by a &lt;quote&gt;;&lt=
;/quote&gt; consisting of a key and a v<br>=A0 =A0 =A0 =A0 &lt;/section&gt;=
<br><br>=A0 =A0 =A0 =A0 &lt;section&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;tit=
le&gt;CVS File Fetcher&lt;/title&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The URN for the CVS Fetcher is &lt;emp=
hasis&gt;cvs&lt;/emphasis&gt;. This Fetcher honors the variables &lt;varnam=
e&gt;DL_DIR&lt;/varname&gt;, &lt;varname&gt;SRCDATE&lt;/varname&gt;, &lt;va=
rname&gt;FETCHCOMMAND_cvs&lt;/varname&gt;, &lt;varname&gt;UPDATECOMMAND_cvs=
&lt;/varname&gt;. &lt;varname&gt;DL_DIR&lt;/varname&gt; specifies where a t=
emporary checkout is saved, &lt;varname&gt;SRCDATE&lt;/varname&gt; specifie=
s which date to use when doing the fetching (the special value of &quot;now=
&quot; will cause the checkout to be updated on every build), &lt;varname&g=
t;FETCHCOMMAND&lt;/varname&gt; and &lt;varname&gt;UPDATECOMMAND&lt;/varname=
&gt; specify which executables should be used when doing the CVS checkout o=
r update.<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;CVS file fetcher&lt;/title&gt;<br>+ =
=A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The URN for the CVS fetcher is &lt;empha=
sis&gt;cvs&lt;/emphasis&gt;. This fetcher honors the variables &lt;varname&=
gt;DL_DIR&lt;/varname&gt;, &lt;varname&gt;SRCDATE&lt;/varname&gt;, &lt;varn=
ame&gt;FETCHCOMMAND_cvs&lt;/varname&gt;, &lt;varname&gt;UPDATECOMMAND_cvs&l=
t;/varname&gt;. &lt;varname&gt;DL_DIR&lt;/varname&gt; specifies where a tem=
porary checkout is saved. &lt;varname&gt;SRCDATE&lt;/varname&gt; specifies =
which date to use when doing the fetching (the special value of &quot;now&q=
uot; will cause the checkout to be updated on every build). &lt;varname&gt;=
FETCHCOMMAND&lt;/varname&gt; and &lt;varname&gt;UPDATECOMMAND&lt;/varname&g=
t; specify which executables to use for the CVS checkout or update.<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&=
gt;The supported Parameters are &lt;varname&gt;module&lt;/varname&gt;, &lt;=
varname&gt;tag&lt;/varname&gt;, &lt;varname&gt;date&lt;/varname&gt;, &lt;va=
rname&gt;method&lt;/varname&gt;, &lt;varname&gt;localdir&lt;/varname&gt;, &=
lt;varname&gt;rsh&lt;/varname&gt; and &lt;varname&gt;scmdata&lt;/varname&gt=
;. The &lt;varname&gt;module&lt;/varname&gt; specifies which module to chec=
k out, the &lt;varname&gt;tag&lt;/varname&gt; describes which CVS TAG shoul=
d be used for the checkout. By default the TAG is empty. A &lt;varname&gt;d=
ate&lt;/varname&gt; can be specified to override the SRCDATE of the configu=
ration to checkout a specific date. =A0The special value of &quot;now&quot;=
 will cause the checkout to be updated on every build.&lt;varname&gt;method=
&lt;/varname&gt; is by default &lt;emphasis&gt;pserver&lt;/emphasis&gt;, if=
 &lt;emphasis&gt;ext&lt;/emphasis&gt; is used the &lt;varname&gt;rsh&lt;/va=
rname&gt; parameter will be evaluated and &lt;varname&gt;CVS_RSH&lt;/varnam=
e&gt; will be set. Finally &lt;varname&gt;localdir&lt;/varname&gt; is used =
to checkout into a special directory relative to &lt;varname&gt;CVSDIR&lt;/=
varname&gt;. If &lt;varname&gt;scmdata&lt;/varname&gt; is set to &lt;quote&=
gt;keep&lt;/quote&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The supported parameters are &lt;varna=
me&gt;module&lt;/varname&gt;, &lt;varname&gt;tag&lt;/varname&gt;, &lt;varna=
me&gt;date&lt;/varname&gt;, &lt;varname&gt;method&lt;/varname&gt;, &lt;varn=
ame&gt;localdir&lt;/varname&gt;, &lt;varname&gt;rsh&lt;/varname&gt; and &lt=
;varname&gt;scmdata&lt;/varname&gt;. The &lt;varname&gt;module&lt;/varname&=
gt; specifies which module to check out, the &lt;varname&gt;tag&lt;/varname=
&gt; describes which CVS TAG should be used for the checkout. By default th=
e TAG is empty. A &lt;varname&gt;date&lt;/varname&gt; can be specified to o=
verride the SRCDATE of the configuration to checkout a specific date. =A0Th=
e special value of &quot;now&quot; will cause the checkout to be updated on=
 every build.&lt;varname&gt;method&lt;/varname&gt; is by default &lt;emphas=
is&gt;pserver&lt;/emphasis&gt;. If &lt;emphasis&gt;ext&lt;/emphasis&gt; is =
used the &lt;varname&gt;rsh&lt;/varname&gt; parameter will be evaluated and=
 &lt;varname&gt;CVS_RSH&lt;/varname&gt; will be set. Finally, &lt;varname&g=
t;localdir&lt;/varname&gt; is used to checkout into a special directory rel=
ative to &lt;varname&gt;CVSDIR&lt;/varname&gt;.<br>


+<br>=A0&lt;screen&gt;&lt;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;cvs:=
//CVSROOT;module=3Dmymodule;tag=3Dsome-version;method=3Dext&quot;<br>=A0&lt=
;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;cvs://CVSROOT;module=3Dmymodu=
le;date=3D20060126;localdir=3Dusethat&quot;<br>


=A0&lt;/screen&gt;<br>@@ -326,11 +326,10 @@ a per URI parameters separated =
by a &lt;quote&gt;;&lt;/quote&gt; consisting of a key and a v<br>=A0 =A0 =
=A0 =A0 &lt;/section&gt;<br><br>=A0 =A0 =A0 =A0 &lt;section&gt;<br>- =A0 =
=A0 =A0 =A0 =A0 =A0&lt;title&gt;HTTP/FTP Fetcher&lt;/title&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The URNs for the HTTP/FTP are &lt;emph=
asis&gt;http&lt;/emphasis&gt;, &lt;emphasis&gt;https&lt;/emphasis&gt; and &=
lt;emphasis&gt;ftp&lt;/emphasis&gt;. This Fetcher honors the variables &lt;=
varname&gt;DL_DIR&lt;/varname&gt;, &lt;varname&gt;FETCHCOMMAND_wget&lt;/var=
name&gt;, &lt;varname&gt;PREMIRRORS&lt;/varname&gt;, &lt;varname&gt;MIRRORS=
&lt;/varname&gt;. The &lt;varname&gt;DL_DIR&lt;/varname&gt; defines where t=
o store the fetched file, &lt;varname&gt;FETCHCOMMAND&lt;/varname&gt; conta=
ins the command used for fetching. &lt;quote&gt;${URI}&lt;/quote&gt; and &l=
t;quote&gt;${FILES}&lt;/quote&gt; will be replaced by the uri and basename =
of the to be fetched file. &lt;varname&gt;PREMIRRORS&lt;/varname&gt;<br>


-will be tried first when fetching a file if that fails the actual file wil=
l be tried and finally all &lt;varname&gt;MIRRORS&lt;/varname&gt; will be t=
ried.<br>+ =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;HTTP/FTP fetcher&lt;/title&g=
t;<br>+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The URNs for the HTTP/FTP fetche=
r are &lt;emphasis&gt;http&lt;/emphasis&gt;, &lt;emphasis&gt;https&lt;/emph=
asis&gt; and &lt;emphasis&gt;ftp&lt;/emphasis&gt;. This fetcher honors the =
variables &lt;varname&gt;DL_DIR&lt;/varname&gt;, &lt;varname&gt;FETCHCOMMAN=
D_wget&lt;/varname&gt;, &lt;varname&gt;PREMIRRORS&lt;/varname&gt;, &lt;varn=
ame&gt;MIRRORS&lt;/varname&gt;. The &lt;varname&gt;DL_DIR&lt;/varname&gt; d=
efines where to store the fetched file. &lt;varname&gt;FETCHCOMMAND&lt;/var=
name&gt; contains the command used for fetching. &lt;quote&gt;${URI}&lt;/qu=
ote&gt; and &lt;quote&gt;${FILES}&lt;/quote&gt; will be replaced by the URI=
 and basename of the file to be fetched. &lt;varname&gt;PREMIRRORS&lt;/varn=
ame&gt; will be tried first when fetching a file. If that fails, the actual=
 file will be tried and finally all &lt;varname&gt;MIRRORS&lt;/varname&gt; =
will be tried.<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&=
gt;The only supported Parameter is &lt;varname&gt;md5sum&lt;/varname&gt;. A=
fter a fetch the &lt;varname&gt;md5sum&lt;/varname&gt; of the file will be =
calculated and the two sums will be compared.<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The only supported parameter is &lt;va=
rname&gt;md5sum&lt;/varname&gt;. After a fetch the &lt;varname&gt;md5sum&lt=
;/varname&gt; of the file will be calculated and the two sums will be compa=
red.<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&g=
t;&lt;screen&gt;&lt;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;<a href=3D=
"http://oe.handhelds.org/not_there.aac;md5sum=3D12343" style=3D"color:rgb(5=
1, 51, 204)" target=3D"_blank">http://oe.handhelds.org/not_there.aac;md5sum=
=3D12343</a>&quot;<br>


=A0&lt;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;<a href=3D"ftp://oe.han=
dhelds.org/not_there_as_well.aac;md5sum=3D1234" style=3D"color:rgb(51, 51, =
204)" target=3D"_blank">ftp://oe.handhelds.org/not_there_as_well.aac;md5sum=
=3D1234</a>&quot;<br>


@@ -339,19 +338,19 @@ will be tried first when fetching a file if that fail=
s the actual file will be t<br>=A0 =A0 =A0 =A0 &lt;/section&gt;<br><br>=A0 =
=A0 =A0 =A0 &lt;section&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;SVK Fe=
tcher&lt;/title&gt;<br>

+ =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;SVK fetcher&lt;/title&gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;emphasi=
s&gt;Currently NOT supported&lt;/emphasis&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &l=
t;/para&gt;<br>=A0 =A0 =A0 =A0 &lt;/section&gt;<br><br>=A0 =A0 =A0 =A0 &lt;=
section&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;SVN Fetcher&lt;/title&=
gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The URN for the SVN Fetcher is &lt;emp=
hasis&gt;svn&lt;/emphasis&gt;.<br>+ =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;SVN=
 fetcher&lt;/title&gt;<br>+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The URN for =
the SVN fetcher is &lt;emphasis&gt;svn&lt;/emphasis&gt;.<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&=
gt;This Fetcher honors the variables &lt;varname&gt;FETCHCOMMAND_svn&lt;/va=
rname&gt;, &lt;varname&gt;DL_DIR&lt;/varname&gt;, &lt;varname&gt;SRCDATE&lt=
;/varname&gt;. &lt;varname&gt;FETCHCOMMAND&lt;/varname&gt; contains the sub=
version command, &lt;varname&gt;DL_DIR&lt;/varname&gt; is the directory whe=
re tarballs will be saved, &lt;varname&gt;SRCDATE&lt;/varname&gt; specifies=
 which date to use when doing the fetching (the special value of &quot;now&=
quot; will cause the checkout to be updated on every build).<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;This fetcher honors the variables &lt;=
varname&gt;FETCHCOMMAND_svn&lt;/varname&gt;, &lt;varname&gt;DL_DIR&lt;/varn=
ame&gt;, &lt;varname&gt;SRCDATE&lt;/varname&gt;. &lt;varname&gt;FETCHCOMMAN=
D&lt;/varname&gt; contains the subversion command. &lt;varname&gt;DL_DIR&lt=
;/varname&gt; is the directory where tarballs will be saved. &lt;varname&gt=
;SRCDATE&lt;/varname&gt; specifies which date to use when doing the fetchin=
g (the special value of &quot;now&quot; will cause the checkout to be updat=
ed on every build).<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&=
gt;The supported Parameters are &lt;varname&gt;proto&lt;/varname&gt;, &lt;v=
arname&gt;rev&lt;/varname&gt; and &lt;varname&gt;scmdata&lt;/varname&gt;. &=
lt;varname&gt;proto&lt;/varname&gt; is the subversion protocol, &lt;varname=
&gt;rev&lt;/varname&gt; is the subversion revision. If &lt;varname&gt;scmda=
ta&lt;/varname&gt; is set to &lt;quote&gt;keep&lt;/quote&gt;, the &lt;quote=
&gt;.svn&lt;/quote&gt; directories will be available during compile-time.<b=
r>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The supported parameters are &lt;varna=
me&gt;proto&lt;/varname&gt;, &lt;varname&gt;rev&lt;/varname&gt; and &lt;var=
name&gt;scmdata&lt;/varname&gt;. &lt;varname&gt;proto&lt;/varname&gt; is th=
e Subversion protocol, &lt;varname&gt;rev&lt;/varname&gt; is the Subversion=
 revision. If &lt;varname&gt;scmdata&lt;/varname&gt; is set to &lt;quote&gt=
;keep&lt;/quote&gt;, the &lt;quote&gt;.svn&lt;/quote&gt; directories will b=
e available during compile-time.<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&g=
t;&lt;screen&gt;&lt;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;svn://<a h=
ref=3D"http://svn.oe.handhelds.org/svn;module=3Dvip;proto=3Dhttp;rev=3D667"=
 style=3D"color:rgb(51, 51, 204)" target=3D"_blank">svn.oe.handhelds.org/sv=
n;module=3Dvip;proto=3Dhttp;rev=3D667</a>&quot;<br>


=A0&lt;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;svn://<a href=3D"http:/=
/svn.oe.handhelds.org/svn/;module=3Dopie;proto=3Dsvn+ssh;date=3D20060126" s=
tyle=3D"color:rgb(51, 51, 204)" target=3D"_blank">svn.oe.handhelds.org/svn/=
;module=3Dopie;proto=3Dsvn+ssh;date=3D20060126</a>&quot;<br>


@@ -359,12 +358,12 @@ will be tried first when fetching a file if that fail=
s the actual file will be t<br>=A0 =A0 =A0 =A0 &lt;/section&gt;<br><br>=A0 =
=A0 =A0 =A0 &lt;section&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;GIT Fe=
tcher&lt;/title&gt;<br>

+ =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;GIT fetcher&lt;/title&gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;The URN for the GIT Fetcher is &lt;emph=
asis&gt;git&lt;/emphasis&gt;.<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>=
=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;The Variables &lt;varname&gt;DL_DIR&lt;=
/varname&gt;, &lt;varname&gt;GITDIR&lt;/varname&gt; are used. &lt;varname&g=
t;DL_DIR&lt;/varname&gt; will be used to store the checkedout version. &lt;=
varname&gt;GITDIR&lt;/varname&gt; will be used as the base directory where =
the git tree is cloned to.<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0&lt;para&=
gt;The Parameters are &lt;emphasis&gt;tag&lt;/emphasis&gt;, &lt;emphasis&gt=
;protocol&lt;/emphasis&gt; and &lt;emphasis&gt;scmdata&lt;/emphasis&gt;. &l=
t;emphasis&gt;tag&lt;/emphasis&gt; is a git tag, the default is &lt;quote&g=
t;master&lt;/quote&gt;. &lt;emphasis&gt;protocol&lt;/emphasis&gt; is the gi=
t protocol to use and defaults to &lt;quote&gt;rsync&lt;/quote&gt;. If &lt;=
emphasis&gt;scmdata&lt;/emphasis&gt; is set to &lt;quote&gt;keep&lt;/quote&=
gt;, the &lt;quote&gt;.git&lt;/quote&gt; directory will be available during=
 compile-time.<br>


+ =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The parameters are &lt;emphasis&gt;tag=
&lt;/emphasis&gt;, &lt;emphasis&gt;protocol&lt;/emphasis&gt; and &lt;emphas=
is&gt;scmdata&lt;/emphasis&gt;. &lt;emphasis&gt;tag&lt;/emphasis&gt; is a G=
it tag, the default is &lt;quote&gt;master&lt;/quote&gt;. &lt;emphasis&gt;p=
rotocol&lt;/emphasis&gt; is the Git protocol to use and defaults to &lt;quo=
te&gt;rsync&lt;/quote&gt;. If &lt;emphasis&gt;scmdata&lt;/emphasis&gt; is s=
et to &lt;quote&gt;keep&lt;/quote&gt;, the &lt;quote&gt;.git&lt;/quote&gt; =
directory will be available during compile-time.<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&g=
t;&lt;screen&gt;&lt;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;git://<a h=
ref=3D"http://git.oe.handhelds.org/git/vip.git;tag=3Dversion-1" style=3D"co=
lor:rgb(51, 51, 204)" target=3D"_blank">git.oe.handhelds.org/git/vip.git;ta=
g=3Dversion-1</a>&quot;<br>


=A0&lt;varname&gt;SRC_URI&lt;/varname&gt; =3D &quot;git://<a href=3D"http:/=
/git.oe.handhelds.org/git/vip.git;protocol=3Dhttp" style=3D"color:rgb(51, 5=
1, 204)" target=3D"_blank">git.oe.handhelds.org/git/vip.git;protocol=3Dhttp=
</a>&quot;<br>


@@ -375,13 +374,13 @@ will be tried first when fetching a file if that fail=
s the actual file will be t<br><br><br>=A0 =A0 &lt;chapter&gt;<br>- =A0 =A0=
 =A0 =A0&lt;title&gt;The=A0<span style=3D"background-color:rgb(169, 218, 14=
6);color:rgb(34, 34, 34);background-repeat:initial initial">bitbake</span>=
=A0command&lt;/title&gt;<br>


+ =A0 =A0 =A0 =A0&lt;title&gt;The=A0<span style=3D"background-color:rgb(169=
, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">BitBak=
e</span>=A0command&lt;/title&gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
&lt;title&gt;Introduction&lt;/title&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
&lt;para&gt;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34=
, 34, 34);background-repeat:initial initial">bitbake</span>=A0is the primar=
y command in the system. =A0It facilitates executing tasks in a single .bb =
file, or executing a given task on a set of multiple .bb files, accounting =
for interdependencies amongst them.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;sec=
tion&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Usage and Syntax&=
lt;/title&gt;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;title&gt;Usage and sy=
ntax&lt;/title&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;screen&gt;&lt;prompt&gt;$ &lt;/=
prompt&gt;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, =
34, 34);background-repeat:initial initial">bitbake</span>=A0--help<br>
=A0usage:=A0<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34=
, 34, 34);background-repeat:initial initial">bitbake</span>=A0[options] [pa=
ckage ...]<br>
@@ -438,7 +437,7 @@ options:<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt=
;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;example&gt;<br>=A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Executing a task against a single .bb&lt;=
/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Executin=
g tasks for a single file is relatively simple. =A0You specify the file in =
question, and=A0<span style=3D"background-color:rgb(169, 218, 146);color:rg=
b(34, 34, 34);background-repeat:initial initial">bitbake</span>=A0parses it=
 and executes the specified task (or &lt;quote&gt;build&lt;/quote&gt; by de=
fault). =A0It obeys intertask dependencies when doing so.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Executing tasks for a =
single file is relatively simple. =A0You specify the file in question, and=
=A0<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34)=
;background-repeat:initial initial">BitBake</span>=A0parses it and executes=
 the specified task (or &lt;quote&gt;build&lt;/quote&gt; by default). =A0It=
 obeys intertask dependencies when doing so.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;quote&gt;clean&lt;/=
quote&gt; task:&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt=
;para&gt;&lt;screen&gt;&lt;prompt&gt;$ &lt;/prompt&gt;<span style=3D"backgr=
ound-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initi=
al initial">bitbake</span>=A0-b=A0<a href=3D"http://blah_1.0.bb/" style=3D"=
color:rgb(51, 51, 204)" target=3D"_blank">blah_1.0.bb</a>=A0-c clean&lt;/sc=
reen&gt;&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;&lt;quote&gt;build&lt;/=
quote&gt; task:&lt;/para&gt;<br>@@ -448,8 +447,8 @@ options:<br>=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;ex=
ample&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Executing=
 tasks against a set of .bb files&lt;/title&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;There are a number of =
additional complexities introduced when one wants to manage multiple .bb fi=
les. =A0Clearly there needs to be a way to tell=A0<span style=3D"background=
-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial i=
nitial">bitbake</span>=A0what files are available, and of those, which we w=
ant to execute at this time. =A0There also needs to be a way for each .bb t=
o express its dependencies, both for build time and runtime. =A0There must =
be a way for the user to express their preferences when multiple .bb&#39;s =
provide the same functionality, or when there are multiple versions of a .b=
b.&lt;/para&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The next section, Meta=
data, outlines how one goes about specifying such things.&lt;/para&gt;<br>+=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;There are a number of a=
dditional complexities introduced when one wants to manage multiple .bb fil=
es. =A0Clearly there needs to be a way to tell=A0<span style=3D"background-=
color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial in=
itial">BitBake</span>=A0what files are available, and of those, which we wa=
nt to execute at this time. =A0There also needs to be a way for each .bb to=
 express its dependencies, both for build time and runtime. =A0There must b=
e a way for the user to express their preferences when multiple .bb&#39;s p=
rovide the same functionality, or when there are multiple versions of a .bb=
.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;The next section, Meta=
data, outlines how to specify such things.&lt;/para&gt;<br>=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;Note that the=A0<span style=3D"backgrou=
nd-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial=
 initial">bitbake</span>=A0command, when not using --buildfile, accepts a &=
lt;varname&gt;PROVIDER&lt;/varname&gt;, not a filename or anything else. =
=A0By default, a .bb generally PROVIDES its packagename, packagename-versio=
n, and packagename-version-revision.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;screen&gt;&lt;prompt&gt;$ &lt;/=
prompt&gt;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, =
34, 34);background-repeat:initial initial">bitbake</span>=A0blah&lt;/screen=
&gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;screen&gt;&lt;prompt&gt;$ &lt;/=
prompt&gt;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, =
34, 34);background-repeat:initial initial">bitbake</span>=A0blah-1.0&lt;/sc=
reen&gt;<br>
@@ -461,8 +460,8 @@ options:<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;example=
&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Generating dep=
endency graphs&lt;/title&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt=
;para&gt;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 3=
4, 34);background-repeat:initial initial">BitBake</span>=A0is able to gener=
ate dependency graphs using the dot syntax. These graphs can be converted<b=
r>


-to images using the &lt;application&gt;dot&lt;/application&gt; application=
 from &lt;ulink url=3D&quot;<a href=3D"http://www.graphviz.org/" style=3D"c=
olor:rgb(51, 51, 204)" target=3D"_blank">http://www.graphviz.org</a>&quot;&=
gt;graphviz&lt;/ulink&gt;.<br>


-Two files will be written into the current working directory, &lt;emphasis=
&gt;depends.dot&lt;/emphasis&gt; containing dependency information at the p=
ackage level and &lt;emphasis&gt;task-depends.dot&lt;/emphasis&gt; containi=
ng a breakdown of the dependencies at the task level. To stop depending on =
common depends one can use the &lt;prompt&gt;-I depend&lt;/prompt&gt; to om=
it these from the graph. This can lead to more readable graphs. E.g. this w=
ay &lt;varname&gt;DEPENDS&lt;/varname&gt; from inherited classes, e.g. base=
.bbclass, can be removed from the graph.&lt;/para&gt;<br>


+to images using the &lt;application&gt;dot&lt;/application&gt; application=
 from &lt;ulink url=3D&quot;<a href=3D"http://www.graphviz.org/" style=3D"c=
olor:rgb(51, 51, 204)" target=3D"_blank">http://www.graphviz.org</a>&quot;&=
gt;Graphviz&lt;/ulink&gt;.<br>


+Two files will be written into the current working directory, &lt;emphasis=
&gt;depends.dot&lt;/emphasis&gt; containing dependency information at the p=
ackage level and &lt;emphasis&gt;task-depends.dot&lt;/emphasis&gt; containi=
ng a breakdown of the dependencies at the task level. To stop depending on =
common depends, one can use the &lt;prompt&gt;-I depend&lt;/prompt&gt; to o=
mit these from the graph. This can lead to more readable graphs. =A0This wa=
y, &lt;varname&gt;DEPENDS&lt;/varname&gt; from inherited classes such as ba=
se.bbclass can be removed from the graph.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;screen&gt;&lt;prompt&gt;$ &lt;/=
prompt&gt;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, =
34, 34);background-repeat:initial initial">bitbake</span>=A0-g blah&lt;/scr=
een&gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;screen&gt;&lt;prompt&gt;$ &lt;/=
prompt&gt;<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, =
34, 34);background-repeat:initial initial">bitbake</span>=A0-g -I virtual/w=
hatever -I bloom blah&lt;/screen&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/example&gt;<br>@@ -470,20 +469,20 @@ T=
wo files will be written into the current working directory, &lt;emphasis&g=
t;depends.<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =
=A0 =A0 &lt;section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Spe=
cial variables&lt;/title&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Certain variables affect=A0<sp=
an style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);backg=
round-repeat:initial initial">bitbake</span>=A0operation:&lt;/para&gt;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;Certain variables affect=A0<sp=
an style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);backg=
round-repeat:initial initial">BitBake</span>=A0operation:&lt;/para&gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &lt;title&gt;&lt;varname&gt;BB_NUMBER_THREADS&lt;/varname&g=
t;&lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt; T=
he number of threads=A0<span style=3D"background-color:rgb(169, 218, 146);c=
olor:rgb(34, 34, 34);background-repeat:initial initial">bitbake</span>=A0sh=
ould run at once (default: 1).&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt; The number of threads=
=A0<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34)=
;background-repeat:initial initial">BitBake</span>=A0should run at once (de=
fault: 1).&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0=
 &lt;/section&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 &lt;section&gt;<br>=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &lt;title&gt;Metadata&lt;/title&gt;<br>- =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0&lt;para&gt;As you may have seen in the usage informatio=
n, or in the information about .bb files, the BBFILES variable is how the=
=A0<span style=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34)=
;background-repeat:initial initial">bitbake</span>=A0tool locates its files=
. =A0This variable is a space separated list of files that are available, a=
nd supports wildcards.<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;As you may have seen in the us=
age information, or in the information about .bb files, the &lt;varname&gt;=
BBFILES&lt;/varname&gt; variable is how the=A0<span style=3D"background-col=
or:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initi=
al">BitBake</span>=A0tool locates its files. =A0This variable is a space se=
parated list of files that are available, and supports wildcards.<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;example&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &lt;title&gt;Setting BBFILES&lt;/title&gt;<br>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;programlisting&gt;&lt;varname&gt;BBFILES&lt=
;/varname&gt; =3D &quot;/path/to/bbfiles/*.bb&quot;&lt;/programlisting&gt;<=
br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/example&gt;&lt;/para&gt;<br>- =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;With regard to dependencies, it expects =
the .bb to define a &lt;varname&gt;DEPENDS&lt;/varname&gt; variable, which =
contains a space separated list of &lt;quote&gt;package names&lt;/quote&gt;=
, which themselves are the &lt;varname&gt;PN&lt;/varname&gt; variable. =A0T=
he &lt;varname&gt;PN&lt;/varname&gt; variable is, in general, by default, s=
et to a component of the .bb filename.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;With regard to dependencies, i=
t expects the .bb to define a &lt;varname&gt;DEPENDS&lt;/varname&gt; variab=
le, which contains a space separated list of &lt;quote&gt;package names&lt;=
/quote&gt;, which themselves are the &lt;varname&gt;PN&lt;/varname&gt; vari=
able. =A0The &lt;varname&gt;PN&lt;/varname&gt; variable is, in general, set=
 to a component of the .bb filename by default.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;example&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &lt;title&gt;Depending on another .bb&lt;/title&gt;<br>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;<a href=3D"http://a.bb/" st=
yle=3D"color:rgb(51, 51, 204)" target=3D"_blank">a.bb</a>:<br>


@@ -496,7 +495,7 @@ DEPENDS +=3D &quot;package-b&quot;&lt;/screen&gt;<br>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/example&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &lt;example&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;tit=
le&gt;Using PROVIDES&lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0&lt;para&gt;This example shows the usage of the PROVIDES variable, whic=
h allows a given .bb to specify what functionality it provides.&lt;/para&gt=
;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;This example shows the=
 usage of the &lt;varname&gt;PROVIDES&lt;/varname&gt; variable, which allow=
s a given .bb to specify what functionality it provides.&lt;/para&gt;<br>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;<a href=3D"http://packa=
ge1.bb/" style=3D"color:rgb(51, 51, 204)" target=3D"_blank">package1.bb</a>=
:<br>


=A0 =A0 &lt;screen&gt;PROVIDES +=3D &quot;virtual/package&quot;&lt;/screen&=
gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>@@ -506,16 =
+505,16 @@ DEPENDS +=3D &quot;package-b&quot;&lt;/screen&gt;<br>=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;<a href=3D"http://package3.bb/" st=
yle=3D"color:rgb(51, 51, 204)" target=3D"_blank">package3.bb</a>:<br>


=A0 =A0 &lt;screen&gt;PROVIDES +=3D &quot;virtual/package&quot;&lt;/screen&=
gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>- =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;As you can see, here there are t=
wo different .bb&#39;s that provide the same functionality (virtual/package=
). =A0Clearly, there needs to be a way for the person running=A0<span style=
=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-re=
peat:initial initial">bitbake</span>=A0to control which of those providers =
gets used. =A0There is, indeed, such a way.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;As you can see, we hav=
e two different .bb&#39;s that provide the same functionality (virtual/pack=
age). =A0Clearly, there needs to be a way for the person running=A0<span st=
yle=3D"background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background=
-repeat:initial initial">BitBake</span>=A0to control which of those provide=
rs gets used. =A0There is, indeed, such a way.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;The following would go =
into a .conf file, to select package1:<br>=A0 =A0 &lt;screen&gt;PREFERRED_P=
ROVIDER_virtual/package =3D &quot;package1&quot;&lt;/screen&gt;<br>=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/example&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &lt;example&gt;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;tit=
le&gt;Specifying version preference&lt;/title&gt;<br>- =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0&lt;para&gt;When there are multiple &lt;quote&gt;version=
s&lt;/quote&gt; of a given package,=A0<span style=3D"background-color:rgb(1=
69, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initial">bitb=
ake</span>=A0defaults to selecting the most recent version, unless otherwis=
e specified. =A0If the .bb in question has a &lt;varname&gt;DEFAULT_PREFERE=
NCE&lt;/varname&gt; set lower than the other .bb&#39;s (default is 0), then=
 it will not be selected. =A0This allows the person or persons maintaining =
the repository of .bb files to specify their preferences for the default se=
lected version. =A0In addition, the user can specify their preferences with=
 regard to version.&lt;/para&gt;<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;When there are multipl=
e &lt;quote&gt;versions&lt;/quote&gt; of a given package,=A0<span style=3D"=
background-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat=
:initial initial">BitBake</span>=A0defaults to selecting the most recent ve=
rsion, unless otherwise specified. =A0If the .bb in question has a &lt;varn=
ame&gt;DEFAULT_PREFERENCE&lt;/varname&gt; set lower than the other .bb&#39;=
s (default is 0), then it will not be selected. =A0This allows the person o=
r persons maintaining the repository of .bb files to specify their preferen=
ce for the default selected version. =A0In addition, the user can specify t=
heir preferred version.&lt;/para&gt;<br>


=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;para&gt;If the first .bb is nam=
ed &lt;filename&gt;<a href=3D"http://a_1.1.bb/" style=3D"color:rgb(51, 51, =
204)" target=3D"_blank">a_1.1.bb</a>&lt;/filename&gt;, then the &lt;varname=
&gt;PN&lt;/varname&gt; variable will be set to &lt;quote&gt;a&lt;/quote&gt;=
, and the &lt;varname&gt;PV&lt;/varname&gt; variable will be set to 1.1.&lt=
;/para&gt;<br>


- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;If we then have an &lt=
;filename&gt;<a href=3D"http://a_1.2.bb/" style=3D"color:rgb(51, 51, 204)" =
target=3D"_blank">a_1.2.bb</a>&lt;/filename&gt;,=A0<span style=3D"backgroun=
d-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial =
initial">bitbake</span>=A0will choose 1.2 by default. =A0However, if we def=
ine the following variable in a .conf that=A0<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">bitbake</span>=A0parses, we can change that.<br>


+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&lt;para&gt;If we then have an &lt=
;filename&gt;<a href=3D"http://a_1.2.bb/" style=3D"color:rgb(51, 51, 204)" =
target=3D"_blank">a_1.2.bb</a>&lt;/filename&gt;,=A0<span style=3D"backgroun=
d-color:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial =
initial">BitBake</span>=A0will choose 1.2 by default. =A0However, if we def=
ine the following variable in a .conf that=A0<span style=3D"background-colo=
r:rgb(169, 218, 146);color:rgb(34, 34, 34);background-repeat:initial initia=
l">BitBake</span>=A0parses, we can change that.<br>


=A0 =A0 &lt;screen&gt;PREFERRED_VERSION_a =3D &quot;1.1&quot;&lt;/screen&gt=
;<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;/para&gt;<br>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &lt;/example&gt;<br><font color=3D"#888888"><font color=
=3D"#888888">--<br>1.7.1</font></font></span>
</div><br>

--bcaec5101c735b584204a4d10df2--
