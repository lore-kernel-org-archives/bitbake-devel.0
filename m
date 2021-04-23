Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web08.1602.1619194027605552565
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 09:07:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from localhost (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E9F4F40009;
	Fri, 23 Apr 2021 16:07:05 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH RESEND 1/2] doc: bitbake-user-manual: simplify colon usage
Date: Fri, 23 Apr 2021 18:06:47 +0200
Message-Id: <20210423160648.338561-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16788839AA7E13EF.3436@lists.openembedded.org>
References: <16788839AA7E13EF.3436@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- This replaces instances of ": ::" by "::", which
  generates identical HTML output

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-execution.rst         |  28 +--
 .../bitbake-user-manual-fetching.rst          |  42 ++---
 .../bitbake-user-manual-hello.rst             |  38 ++--
 .../bitbake-user-manual-intro.rst             |  38 ++--
 .../bitbake-user-manual-metadata.rst          | 172 +++++++++---------
 .../bitbake-user-manual-ref-variables.rst     |  68 +++----
 6 files changed, 193 insertions(+), 193 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 56abf773..14c342a6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -16,7 +16,7 @@ data, or simply return information about the execution environment.
 
 This chapter describes BitBake's execution process from start to finish
 when you use it to create an image. The execution process is launched
-using the following command form: ::
+using the following command form::
 
   $ bitbake target
 
@@ -32,7 +32,7 @@ the BitBake command and its options, see ":ref:`The BitBake Command
    your project's ``local.conf`` configuration file.
 
    A common method to determine this value for your build host is to run
-   the following: ::
+   the following::
 
      $ grep processor /proc/cpuinfo
 
@@ -139,7 +139,7 @@ in ``BBPATH`` in the same way as configuration files.
 
 A good way to get an idea of the configuration files and the class files
 used in your execution environment is to run the following BitBake
-command: ::
+command::
 
   $ bitbake -e > mybb.log
 
@@ -155,7 +155,7 @@ execution environment.
    pair of curly braces in a shell function, the closing curly brace
    must not be located at the start of the line without leading spaces.
 
-   Here is an example that causes BitBake to produce a parsing error: ::
+   Here is an example that causes BitBake to produce a parsing error::
 
       fakeroot create_shar() {
          cat << "EOF" > ${SDK_DEPLOY}/${TOOLCHAIN_OUTPUTNAME}.sh
@@ -185,7 +185,7 @@ During the configuration phase, BitBake will have set
 :term:`BBFILES`. BitBake now uses it to construct a
 list of recipes to parse, along with any append files (``.bbappend``) to
 apply. ``BBFILES`` is a space-separated list of available files and
-supports wildcards. An example would be: ::
+supports wildcards. An example would be::
 
   BBFILES = "/path/to/bbfiles/*.bb /path/to/appends/*.bbappend"
 
@@ -206,7 +206,7 @@ parses in order any append files found in ``BBFILES``.
 One common convention is to use the recipe filename to define pieces of
 metadata. For example, in ``bitbake.conf`` the recipe name and version
 are used to set the variables :term:`PN` and
-:term:`PV`: ::
+:term:`PV`::
 
    PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
    PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
@@ -238,7 +238,7 @@ Recipe file collections exist to allow the user to have multiple
 repositories of ``.bb`` files that contain the same exact package. For
 example, one could easily use them to make one's own local copy of an
 upstream repository, but with custom modifications that one does not
-want upstream. Here is an example: ::
+want upstream. Here is an example::
 
   BBFILES = "/stuff/openembedded/*/*.bb /stuff/openembedded.modified/*/*.bb"
   BBFILE_COLLECTIONS = "upstream local"
@@ -270,7 +270,7 @@ variable, which is optional.
 When a recipe uses ``PROVIDES``, that recipe's functionality can be
 found under an alternative name or names other than the implicit ``PN``
 name. As an example, suppose a recipe named ``keyboard_1.0.bb``
-contained the following: ::
+contained the following::
 
   PROVIDES += "fullkeyboard"
 
@@ -291,7 +291,7 @@ needs to prioritize providers by determining provider preferences.
 A common example in which a target has multiple providers is
 "virtual/kernel", which is on the ``PROVIDES`` list for each kernel
 recipe. Each machine often selects the best kernel provider by using a
-line similar to the following in the machine configuration file: ::
+line similar to the following in the machine configuration file::
 
   PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"
 
@@ -331,7 +331,7 @@ If the first recipe is named ``a_1.1.bb``, then the
 
 Thus, if a recipe named ``a_1.2.bb`` exists, BitBake will choose 1.2 by
 default. However, if you define the following variable in a ``.conf``
-file that BitBake parses, you can change that preference: ::
+file that BitBake parses, you can change that preference::
 
   PREFERRED_VERSION_a = "1.1"
 
@@ -498,7 +498,7 @@ to the task.
 
 Like the working directory case, situations exist where dependencies
 should be ignored. For these cases, you can instruct the build process
-to ignore a dependency by using a line like the following: ::
+to ignore a dependency by using a line like the following::
 
   PACKAGE_ARCHS[vardepsexclude] = "MACHINE"
 
@@ -508,7 +508,7 @@ even if it does reference it.
 
 Equally, there are cases where we need to add dependencies BitBake is
 not able to find. You can accomplish this by using a line like the
-following: ::
+following::
 
   PACKAGE_ARCHS[vardeps] = "MACHINE"
 
@@ -536,7 +536,7 @@ configuration file, we can give BitBake some extra information to help
 it construct the basehash. The following statement effectively results
 in a list of global variable dependency excludes - variables never
 included in any checksum. This example uses variables from OpenEmbedded
-to help illustrate the concept: ::
+to help illustrate the concept::
 
    BB_HASHBASE_WHITELIST ?= "TMPDIR FILE PATH PWD BB_TASKHASH BBPATH DL_DIR \
        SSTATE_DIR THISDIR FILESEXTRAPATHS FILE_DIRNAME HOME LOGNAME SHELL \
@@ -557,7 +557,7 @@ OpenEmbedded-Core uses: "OEBasic" and "OEBasicHash". By default, there
 is a dummy "noop" signature handler enabled in BitBake. This means that
 behavior is unchanged from previous versions. ``OE-Core`` uses the
 "OEBasicHash" signature handler by default through this setting in the
-``bitbake.conf`` file: ::
+``bitbake.conf`` file::
 
   BB_SIGNATURE_HANDLER ?= "OEBasicHash"
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 626278e4..3167ab13 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -27,7 +27,7 @@ and unpacking the files is often optionally followed by patching.
 Patching, however, is not covered by this module.
 
 The code to execute the first part of this process, a fetch, looks
-something like the following: ::
+something like the following::
 
    src_uri = (d.getVar('SRC_URI') or "").split()
    fetcher = bb.fetch2.Fetch(src_uri, d)
@@ -37,7 +37,7 @@ This code sets up an instance of the fetch class. The instance uses a
 space-separated list of URLs from the :term:`SRC_URI`
 variable and then calls the ``download`` method to download the files.
 
-The instantiation of the fetch class is usually followed by: ::
+The instantiation of the fetch class is usually followed by::
 
    rootdir = l.getVar('WORKDIR')
    fetcher.unpack(rootdir)
@@ -72,7 +72,7 @@ URLs by looking for source files in a specific search order:
 For each URL passed to the fetcher, the fetcher calls the submodule that
 handles that particular URL type. This behavior can be the source of
 some confusion when you are providing URLs for the ``SRC_URI`` variable.
-Consider the following two URLs: ::
+Consider the following two URLs::
 
    http://git.yoctoproject.org/git/poky;protocol=git
    git://git.yoctoproject.org/git/poky;protocol=http
@@ -81,7 +81,7 @@ In the former case, the URL is passed to the ``wget`` fetcher, which does not
 understand "git". Therefore, the latter case is the correct form since the Git
 fetcher does know how to use HTTP as a transport.
 
-Here are some examples that show commonly used mirror definitions: ::
+Here are some examples that show commonly used mirror definitions::
 
    PREMIRRORS ?= "\
       bzr://.*/.\*  http://somemirror.org/sources/ \\n \
@@ -111,19 +111,19 @@ File integrity is of key importance for reproducing builds. For
 non-local archive downloads, the fetcher code can verify SHA-256 and MD5
 checksums to ensure the archives have been downloaded correctly. You can
 specify these checksums by using the ``SRC_URI`` variable with the
-appropriate varflags as follows: ::
+appropriate varflags as follows::
 
    SRC_URI[md5sum] = "value"
    SRC_URI[sha256sum] = "value"
 
 You can also specify the checksums as
-parameters on the ``SRC_URI`` as shown below: ::
+parameters on the ``SRC_URI`` as shown below::
 
   SRC_URI = "http://example.com/foobar.tar.bz2;md5sum=4a8e0f237e961fd7785d19d07fdb994d"
 
 If multiple URIs exist, you can specify the checksums either directly as
 in the previous example, or you can name the URLs. The following syntax
-shows how you name the URIs: ::
+shows how you name the URIs::
 
    SRC_URI = "http://example.com/foobar.tar.bz2;name=foo"
    SRC_URI[foo.md5sum] = 4a8e0f237e961fd7785d19d07fdb994d
@@ -201,7 +201,7 @@ time the ``download()`` method is called.
 If you specify a directory, the entire directory is unpacked.
 
 Here are a couple of example URLs, the first relative and the second
-absolute: ::
+absolute::
 
    SRC_URI = "file://relativefile.patch"
    SRC_URI = "file:///Users/ich/very_important_software"
@@ -222,7 +222,7 @@ downloaded file is useful for avoiding collisions in
 :term:`DL_DIR` when dealing with multiple files that
 have the same name.
 
-Some example URLs are as follows: ::
+Some example URLs are as follows::
 
    SRC_URI = "http://oe.handhelds.org/not_there.aac"
    SRC_URI = "ftp://oe.handhelds.org/not_there_as_well.aac"
@@ -318,7 +318,7 @@ The supported parameters are as follows:
 
 -  *"port":* The port to which the CVS server connects.
 
-Some example URLs are as follows: ::
+Some example URLs are as follows::
 
    SRC_URI = "cvs://CVSROOT;module=mymodule;tag=some-version;method=ext"
    SRC_URI = "cvs://CVSROOT;module=mymodule;date=20060126;localdir=usethat"
@@ -360,7 +360,7 @@ The supported parameters are as follows:
    username is different than the username used in the main URL, which
    is passed to the subversion command.
 
-Following are three examples using svn: ::
+Following are three examples using svn::
 
    SRC_URI = "svn://myrepos/proj1;module=vip;protocol=http;rev=667"
    SRC_URI = "svn://myrepos/proj1;module=opie;protocol=svn+ssh"
@@ -433,7 +433,7 @@ This fetcher supports the following parameters:
    parameter implies no branch and only works when the transfer protocol
    is ``file://``.
 
-Here are some example URLs: ::
+Here are some example URLs::
 
    SRC_URI = "git://git.oe.handhelds.org/git/vip.git;tag=version-1"
    SRC_URI = "git://git.oe.handhelds.org/git/vip.git;protocol=http"
@@ -481,7 +481,7 @@ repository.
 
 To use this fetcher, make sure your recipe has proper
 :term:`SRC_URI`, :term:`SRCREV`, and
-:term:`PV` settings. Here is an example: ::
+:term:`PV` settings. Here is an example::
 
    SRC_URI = "ccrc://cc.example.org/ccrc;vob=/example_vob;module=/example_module"
    SRCREV = "EXAMPLE_CLEARCASE_TAG"
@@ -503,7 +503,7 @@ Following are options for the ``SRC_URI`` statement:
       The module and vob options are combined to create the load rule in the
       view config spec. As an example, consider the vob and module values from
       the SRC_URI statement at the start of this section. Combining those values
-      results in the following: ::
+      results in the following::
 
          load /example_vob/example_module
 
@@ -555,7 +555,7 @@ the server's URL and port number, and you can specify a username and
 password directly in your recipe within ``SRC_URI``.
 
 Here is an example that relies on ``P4CONFIG`` to specify the server URL
-and port, username, and password, and fetches the Head Revision: ::
+and port, username, and password, and fetches the Head Revision::
 
    SRC_URI = "p4://example-depot/main/source/..."
    SRCREV = "${AUTOREV}"
@@ -563,7 +563,7 @@ and port, username, and password, and fetches the Head Revision: ::
    S = "${WORKDIR}/p4"
 
 Here is an example that specifies the server URL and port, username, and
-password, and fetches a Revision based on a Label: ::
+password, and fetches a Revision based on a Label::
 
    P4PORT = "tcp:p4server.example.net:1666"
    SRC_URI = "p4://user:passwd@example-depot/main/source/..."
@@ -589,7 +589,7 @@ paths locally is desirable, the fetcher supports two parameters:
     paths locally for the specified location, even in combination with the
     ``module`` parameter.
 
-Here is an example use of the the ``module`` parameter: ::
+Here is an example use of the the ``module`` parameter::
 
    SRC_URI = "p4://user:passwd@example-depot/main;module=source/..."
 
@@ -597,7 +597,7 @@ In this case, the content of the top-level directory ``source/`` will be fetched
 to ``${P4DIR}``, including the directory itself.  The top-level directory will
 be accesible at ``${P4DIR}/source/``.
 
-Here is an example use of the the ``remotepath`` parameter: ::
+Here is an example use of the the ``remotepath`` parameter::
 
    SRC_URI = "p4://user:passwd@example-depot/main;module=source/...;remotepath=keep"
 
@@ -625,7 +625,7 @@ This fetcher supports the following parameters:
 
 -  *"manifest":* Name of the manifest file (default: ``default.xml``).
 
-Here are some example URLs: ::
+Here are some example URLs::
 
    SRC_URI = "repo://REPOROOT;protocol=git;branch=some_branch;manifest=my_manifest.xml"
    SRC_URI = "repo://REPOROOT;protocol=file;branch=some_branch;manifest=my_manifest.xml"
@@ -648,11 +648,11 @@ Such functionality is set by the variable:
    delegate access to resources, if this variable is set, the Az Fetcher will
    use it when fetching artifacts from the cloud.
 
-You can specify the AZ_SAS variable as shown below: ::
+You can specify the AZ_SAS variable as shown below::
 
    AZ_SAS = "se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
 
-Here is an example URL: ::
+Here is an example URL::
 
    SRC_URI = "az://<azure-storage-account>.blob.core.windows.net/<foo_container>/<bar_file>"
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index e3fd3215..62a0b597 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -20,7 +20,7 @@ Obtaining BitBake
 
 See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
 information on how to obtain BitBake. Once you have the source code on
-your machine, the BitBake directory appears as follows: ::
+your machine, the BitBake directory appears as follows::
 
    $ ls -al
    total 100
@@ -49,7 +49,7 @@ Setting Up the BitBake Environment
 
 First, you need to be sure that you can run BitBake. Set your working
 directory to where your local BitBake files are and run the following
-command: ::
+command::
 
   $ ./bin/bitbake --version
   BitBake Build Tool Core version 1.23.0, bitbake version 1.23.0
@@ -61,14 +61,14 @@ The recommended method to run BitBake is from a directory of your
 choice. To be able to run BitBake from any directory, you need to add
 the executable binary to your binary to your shell's environment
 ``PATH`` variable. First, look at your current ``PATH`` variable by
-entering the following: ::
+entering the following::
 
   $ echo $PATH
 
 Next, add the directory location
 for the BitBake binary to the ``PATH``. Here is an example that adds the
 ``/home/scott-lenovo/bitbake/bin`` directory to the front of the
-``PATH`` variable: ::
+``PATH`` variable::
 
   $ export PATH=/home/scott-lenovo/bitbake/bin:$PATH
 
@@ -116,7 +116,7 @@ Following is the complete "Hello World" example.
 
 #.  **Create a Project Directory:** First, set up a directory for the
     "Hello World" project. Here is how you can do so in your home
-    directory: ::
+    directory::
 
       $ mkdir ~/hello
       $ cd ~/hello
@@ -127,7 +127,7 @@ Following is the complete "Hello World" example.
     directory is a good way to isolate your project.
 
 #.  **Run BitBake:** At this point, you have nothing but a project
-    directory. Run the ``bitbake`` command and see what it does: ::
+    directory. Run the ``bitbake`` command and see what it does::
 
        $ bitbake
        The BBPATH variable is not set and bitbake did not
@@ -161,7 +161,7 @@ Following is the complete "Hello World" example.
     ``BBPATH`` variable up in a configuration file for each project.
 
     From your shell, enter the following commands to set and export the
-    ``BBPATH`` variable: ::
+    ``BBPATH`` variable::
 
       $ BBPATH="projectdirectory"
       $ export BBPATH
@@ -176,7 +176,7 @@ Following is the complete "Hello World" example.
        shell would.
 
 #.  **Run BitBake:** Now that you have ``BBPATH`` defined, run the
-    ``bitbake`` command again: ::
+    ``bitbake`` command again::
 
        $ bitbake
        ERROR: Traceback (most recent call last):
@@ -208,13 +208,13 @@ Following is the complete "Hello World" example.
     http://git.openembedded.org/bitbake/tree/conf/bitbake.conf.
 
     Use the following commands to create the ``conf`` directory in the
-    project directory: ::
+    project directory::
 
       $ mkdir conf
 
     From within the ``conf`` directory,
     use some editor to create the ``bitbake.conf`` so that it contains
-    the following: ::
+    the following::
 
        PN  = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
 
@@ -251,7 +251,7 @@ Following is the complete "Hello World" example.
     glossary.
 
 #.  **Run BitBake:** After making sure that the ``conf/bitbake.conf`` file
-    exists, you can run the ``bitbake`` command again: ::
+    exists, you can run the ``bitbake`` command again::
 
        $ bitbake
        ERROR: Traceback (most recent call last):
@@ -278,7 +278,7 @@ Following is the complete "Hello World" example.
     in the ``classes`` directory of the project (i.e ``hello/classes``
     in this example).
 
-    Create the ``classes`` directory as follows: ::
+    Create the ``classes`` directory as follows::
 
       $ cd $HOME/hello
       $ mkdir classes
@@ -291,7 +291,7 @@ Following is the complete "Hello World" example.
     environments BitBake is supporting.
 
 #.  **Run BitBake:** After making sure that the ``classes/base.bbclass``
-    file exists, you can run the ``bitbake`` command again: ::
+    file exists, you can run the ``bitbake`` command again::
 
        $ bitbake
        Nothing to do. Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.
@@ -314,7 +314,7 @@ Following is the complete "Hello World" example.
     Minimally, you need a recipe file and a layer configuration file in
     your layer. The configuration file needs to be in the ``conf``
     directory inside the layer. Use these commands to set up the layer
-    and the ``conf`` directory: ::
+    and the ``conf`` directory::
 
        $ cd $HOME
        $ mkdir mylayer
@@ -322,7 +322,7 @@ Following is the complete "Hello World" example.
        $ mkdir conf
 
     Move to the ``conf`` directory and create a ``layer.conf`` file that has the
-    following: ::
+    following::
 
       BBPATH .= ":${LAYERDIR}"
       BBFILES += "${LAYERDIR}/\*.bb"
@@ -335,7 +335,7 @@ Following is the complete "Hello World" example.
 
     You need to create the recipe file next. Inside your layer at the
     top-level, use an editor and create a recipe file named
-    ``printhello.bb`` that has the following: ::
+    ``printhello.bb`` that has the following::
 
        DESCRIPTION = "Prints Hello World"
        PN = 'printhello'
@@ -356,7 +356,7 @@ Following is the complete "Hello World" example.
     follow the links to the glossary.
 
 #. **Run BitBake With a Target:** Now that a BitBake target exists, run
-    the command and provide that target: ::
+    the command and provide that target::
 
       $ cd $HOME/hello
       $ bitbake printhello
@@ -376,7 +376,7 @@ Following is the complete "Hello World" example.
     ``hello/conf`` for this example).
 
     Set your working directory to the ``hello/conf`` directory and then
-    create the ``bblayers.conf`` file so that it contains the following: ::
+    create the ``bblayers.conf`` file so that it contains the following::
 
        BBLAYERS ?= " \
            /home/<you>/mylayer \
@@ -386,7 +386,7 @@ Following is the complete "Hello World" example.
 
 #. **Run BitBake With a Target:** Now that you have supplied the
     ``bblayers.conf`` file, run the ``bitbake`` command and provide the
-    target: ::
+    target::
 
        $ bitbake printhello
        Parsing recipes: 100% |##################################################################################|
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 6f9d3929..b3cea61f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -248,13 +248,13 @@ underlying, similarly-named recipe files.
 
 When you name an append file, you can use the "``%``" wildcard character
 to allow for matching recipe names. For example, suppose you have an
-append file named as follows: ::
+append file named as follows::
 
   busybox_1.21.%.bbappend
 
 That append file
 would match any ``busybox_1.21.``\ x\ ``.bb`` version of the recipe. So,
-the append file would match the following recipe names: ::
+the append file would match the following recipe names::
 
   busybox_1.21.1.bb
   busybox_1.21.2.bb
@@ -290,7 +290,7 @@ You can obtain BitBake several different ways:
    are using. The metadata is generally backwards compatible but not
    forward compatible.
 
-   Here is an example that clones the BitBake repository: ::
+   Here is an example that clones the BitBake repository::
 
      $ git clone git://git.openembedded.org/bitbake
 
@@ -298,7 +298,7 @@ You can obtain BitBake several different ways:
    Git repository into a directory called ``bitbake``. Alternatively,
    you can designate a directory after the ``git clone`` command if you
    want to call the new directory something other than ``bitbake``. Here
-   is an example that names the directory ``bbdev``: ::
+   is an example that names the directory ``bbdev``::
 
      $ git clone git://git.openembedded.org/bitbake bbdev
 
@@ -317,7 +317,7 @@ You can obtain BitBake several different ways:
          method for getting BitBake. Cloning the repository makes it easier
          to update as patches are added to the stable branches.
 
-   The following example downloads a snapshot of BitBake version 1.17.0: ::
+   The following example downloads a snapshot of BitBake version 1.17.0::
 
      $ wget http://git.openembedded.org/bitbake/snapshot/bitbake-1.17.0.tar.gz
      $ tar zxpvf bitbake-1.17.0.tar.gz
@@ -347,7 +347,7 @@ execution examples.
 Usage and syntax
 ----------------
 
-Following is the usage and syntax for BitBake: ::
+Following is the usage and syntax for BitBake::
 
    $ bitbake -h
    Usage: bitbake [options] [recipename/target recipe:do_task ...]
@@ -469,11 +469,11 @@ default task, which is "build". BitBake obeys inter-task dependencies
 when doing so.
 
 The following command runs the build task, which is the default task, on
-the ``foo_1.0.bb`` recipe file: ::
+the ``foo_1.0.bb`` recipe file::
 
   $ bitbake -b foo_1.0.bb
 
-The following command runs the clean task on the ``foo.bb`` recipe file: ::
+The following command runs the clean task on the ``foo.bb`` recipe file::
 
   $ bitbake -b foo.bb -c clean
 
@@ -497,13 +497,13 @@ functionality, or when there are multiple versions of a recipe.
 The ``bitbake`` command, when not using "--buildfile" or "-b" only
 accepts a "PROVIDES". You cannot provide anything else. By default, a
 recipe file generally "PROVIDES" its "packagename" as shown in the
-following example: ::
+following example::
 
   $ bitbake foo
 
 This next example "PROVIDES" the
 package name and also uses the "-c" option to tell BitBake to just
-execute the ``do_clean`` task: ::
+execute the ``do_clean`` task::
 
   $ bitbake -c clean foo
 
@@ -514,7 +514,7 @@ The BitBake command line supports specifying different tasks for
 individual targets when you specify multiple targets. For example,
 suppose you had two targets (or recipes) ``myfirstrecipe`` and
 ``mysecondrecipe`` and you needed BitBake to run ``taskA`` for the first
-recipe and ``taskB`` for the second recipe: ::
+recipe and ``taskB`` for the second recipe::
 
   $ bitbake myfirstrecipe:do_taskA mysecondrecipe:do_taskB
 
@@ -540,7 +540,7 @@ produce more readable graphs. This way, you can remove from the graph
 ``DEPENDS`` from inherited classes such as ``base.bbclass``.
 
 Here are two examples that create dependency graphs. The second example
-omits depends common in OpenEmbedded from the graph: ::
+omits depends common in OpenEmbedded from the graph::
 
   $ bitbake -g foo
 
@@ -582,17 +582,17 @@ accomplished by setting the
 configuration files for ``target1`` and ``target2`` defined in the build
 directory. The following statement in the ``local.conf`` file both
 enables BitBake to perform multiple configuration builds and specifies
-the two extra multiconfigs: ::
+the two extra multiconfigs::
 
   BBMULTICONFIG = "target1 target2"
 
 Once the target configuration files are in place and BitBake has been
 enabled to perform multiple configuration builds, use the following
-command form to start the builds: ::
+command form to start the builds::
 
   $ bitbake [mc:multiconfigname:]target [[[mc:multiconfigname:]target] ... ]
 
-Here is an example for two extra multiconfigs: ``target1`` and ``target2``: ::
+Here is an example for two extra multiconfigs: ``target1`` and ``target2``::
 
   $ bitbake mc::target mc:target1:target mc:target2:target
 
@@ -613,12 +613,12 @@ multiconfig.
 
 To enable dependencies in a multiple configuration build, you must
 declare the dependencies in the recipe using the following statement
-form: ::
+form::
 
   task_or_package[mcdepends] = "mc:from_multiconfig:to_multiconfig:recipe_name:task_on_which_to_depend"
 
 To better show how to use this statement, consider an example with two
-multiconfigs: ``target1`` and ``target2``: ::
+multiconfigs: ``target1`` and ``target2``::
 
   image_task[mcdepends] = "mc:target1:target2:image2:rootfs_task"
 
@@ -629,7 +629,7 @@ completion of the rootfs_task used to build out image2, which is
 associated with the "target2" multiconfig.
 
 Once you set up this dependency, you can build the "target1" multiconfig
-using a BitBake command as follows: ::
+using a BitBake command as follows::
 
   $ bitbake mc:target1:image1
 
@@ -639,7 +639,7 @@ the ``rootfs_task`` for the "target2" multiconfig build.
 
 Having a recipe depend on the root filesystem of another build might not
 seem that useful. Consider this change to the statement in the image1
-recipe: ::
+recipe::
 
   image_task[mcdepends] = "mc:target1:target2:image2:image_task"
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index d4190c26..615c9f9c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -26,7 +26,7 @@ assignment. ::
    VARIABLE = "value"
 
 As expected, if you include leading or
-trailing spaces as part of an assignment, the spaces are retained: ::
+trailing spaces as part of an assignment, the spaces are retained::
 
    VARIABLE = " value"
    VARIABLE = "value "
@@ -40,7 +40,7 @@ blank space (i.e. these are not the same values). ::
 
 You can use single quotes instead of double quotes when setting a
 variable's value. Doing so allows you to use values that contain the
-double quote character: ::
+double quote character::
 
    VARIABLE = 'I have a " in my value'
 
@@ -77,7 +77,7 @@ occurs, you can use BitBake to check the actual value of the suspect
 variable. You can make these checks for both configuration and recipe
 level changes:
 
--  For configuration changes, use the following: ::
+-  For configuration changes, use the following::
 
       $ bitbake -e
 
@@ -91,7 +91,7 @@ level changes:
       Variables that are exported to the environment are preceded by the
       string "export" in the command's output.
 
--  For recipe changes, use the following: ::
+-  For recipe changes, use the following::
 
       $ bitbake recipe -e \| grep VARIABLE="
 
@@ -105,7 +105,7 @@ Outside of :ref:`functions <bitbake-user-manual/bitbake-user-manual-metadata:fun
 BitBake joins any line ending in
 a backslash character ("\") with the following line before parsing
 statements. The most common use for the "\" character is to split
-variable assignments over multiple lines, as in the following example: ::
+variable assignments over multiple lines, as in the following example::
 
    FOO = "bar \
           baz \
@@ -116,7 +116,7 @@ character that follow it are removed when joining lines. Thus, no
 newline characters end up in the value of ``FOO``.
 
 Consider this additional example where the two assignments both assign
-"barbaz" to ``FOO``: ::
+"barbaz" to ``FOO``::
 
    FOO = "barbaz"
    FOO = "bar\
@@ -149,7 +149,7 @@ The "=" operator does not immediately expand variable references in the
 right-hand side. Instead, expansion is deferred until the variable
 assigned to is actually used. The result depends on the current values
 of the referenced variables. The following example should clarify this
-behavior: ::
+behavior::
 
    A = "${B} baz"
    B = "${C} bar"
@@ -177,7 +177,7 @@ Setting a default value (?=)
 You can use the "?=" operator to achieve a "softer" assignment for a
 variable. This type of assignment allows you to define a variable if it
 is undefined when the statement is parsed, but to leave the value alone
-if the variable has a value. Here is an example: ::
+if the variable has a value. Here is an example::
 
    A ?= "aval"
 
@@ -199,7 +199,7 @@ by using the "??=" operator. This assignment behaves identical to "?="
 except that the assignment is made at the end of the parsing process
 rather than immediately. Consequently, when multiple "??=" assignments
 exist, the last one is used. Also, any "=" or "?=" assignment will
-override the value set with "??=". Here is an example: ::
+override the value set with "??=". Here is an example::
 
    A ??= "somevalue"
    A ??= "someothervalue"
@@ -215,7 +215,7 @@ Immediate variable expansion (:=)
 ---------------------------------
 
 The ":=" operator results in a variable's contents being expanded
-immediately, rather than when the variable is actually used: ::
+immediately, rather than when the variable is actually used::
 
    T = "123"
    A := "test ${T}"
@@ -241,7 +241,7 @@ the "+=" and "=+" operators. These operators insert a space between the
 current value and prepended or appended value.
 
 These operators take immediate effect during parsing. Here are some
-examples: ::
+examples::
 
    B = "bval"
    B += "additionaldata"
@@ -260,7 +260,7 @@ If you want to append or prepend values without an inserted space, use
 the ".=" and "=." operators.
 
 These operators take immediate effect during parsing. Here are some
-examples: ::
+examples::
 
    B = "bval"
    B .= "additionaldata"
@@ -278,7 +278,7 @@ style syntax. When you use this syntax, no spaces are inserted.
 
 These operators differ from the ":=", ".=", "=.", "+=", and "=+"
 operators in that their effects are applied at variable expansion time
-rather than being immediately applied. Here are some examples: ::
+rather than being immediately applied. Here are some examples::
 
    B = "bval"
    B_append = " additional data"
@@ -309,7 +309,7 @@ syntax. Specifying a value for removal causes all occurrences of that
 value to be removed from the variable.
 
 When you use this syntax, BitBake expects one or more strings.
-Surrounding spaces and spacing are preserved. Here is an example: ::
+Surrounding spaces and spacing are preserved. Here is an example::
 
    FOO = "123 456 789 123456 123 456 123 456"
    FOO_remove = "123"
@@ -334,27 +334,27 @@ An advantage of the override style operations "_append", "_prepend", and
 "_remove" as compared to the "+=" and "=+" operators is that the
 override style operators provide guaranteed operations. For example,
 consider a class ``foo.bbclass`` that needs to add the value "val" to
-the variable ``FOO``, and a recipe that uses ``foo.bbclass`` as follows: ::
+the variable ``FOO``, and a recipe that uses ``foo.bbclass`` as follows::
 
    inherit foo
    FOO = "initial"
 
 If ``foo.bbclass`` uses the "+=" operator,
 as follows, then the final value of ``FOO`` will be "initial", which is
-not what is desired: ::
+not what is desired::
 
    FOO += "val"
 
 If, on the other hand, ``foo.bbclass``
 uses the "_append" operator, then the final value of ``FOO`` will be
-"initial val", as intended: ::
+"initial val", as intended::
 
    FOO_append = " val"
 
 .. note::
 
    It is never necessary to use "+=" together with "_append". The following
-   sequence of assignments appends "barbaz" to FOO: ::
+   sequence of assignments appends "barbaz" to FOO::
 
        FOO_append = "bar"
        FOO_append = "baz"
@@ -381,7 +381,7 @@ standard syntax operations previously mentioned work for variable flags
 except for override style syntax (i.e. "_prepend", "_append", and
 "_remove").
 
-Here are some examples showing how to set variable flags: ::
+Here are some examples showing how to set variable flags::
 
    FOO[a] = "abc"
    FOO[b] = "123"
@@ -393,7 +393,7 @@ respectively. The ``[a]`` flag becomes "abc 456".
 
 No need exists to pre-define variable flags. You can simply start using
 them. One extremely common application is to attach some brief
-documentation to a BitBake variable as follows: ::
+documentation to a BitBake variable as follows::
 
    CACHE[doc] = "The directory holding the cache of the metadata."
 
@@ -401,7 +401,7 @@ Inline Python Variable Expansion
 --------------------------------
 
 You can use inline Python variable expansion to set variables. Here is
-an example: ::
+an example::
 
    DATE = "${@time.strftime('%Y%m%d',time.gmtime())}"
 
@@ -410,7 +410,7 @@ This example results in the ``DATE`` variable being set to the current date.
 Probably the most common use of this feature is to extract the value of
 variables from BitBake's internal data dictionary, ``d``. The following
 lines select the values of a package name and its version number,
-respectively: ::
+respectively::
 
    PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
    PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
@@ -419,12 +419,12 @@ respectively: ::
 
    Inline Python expressions work just like variable expansions insofar as the
    "=" and ":=" operators are concerned. Given the following assignment, foo()
-   is called each time FOO is expanded: ::
+   is called each time FOO is expanded::
 
       FOO = "${@foo()}"
 
    Contrast this with the following immediate assignment, where foo() is only
-   called once, while the assignment is parsed: ::
+   called once, while the assignment is parsed::
 
       FOO := "${@foo()}"
 
@@ -437,7 +437,7 @@ Unsetting variables
 
 It is possible to completely remove a variable or a variable flag from
 BitBake's internal data dictionary by using the "unset" keyword. Here is
-an example: ::
+an example::
 
    unset DATE
    unset do_fetch[noexec]
@@ -452,7 +452,7 @@ When specifying pathnames for use with BitBake, do not use the tilde
 cause BitBake to not recognize the path since BitBake does not expand
 this character in the same way a shell would.
 
-Instead, provide a fuller path as the following example illustrates: ::
+Instead, provide a fuller path as the following example illustrates::
 
    BBLAYERS ?= " \
        /home/scott-lenovo/LayerA \
@@ -463,7 +463,7 @@ Exporting Variables to the Environment
 
 You can export variables to the environment of running tasks by using
 the ``export`` keyword. For example, in the following example, the
-``do_foo`` task prints "value from the environment" when run: ::
+``do_foo`` task prints "value from the environment" when run::
 
    export ENV_VARIABLE
    ENV_VARIABLE = "value from the environment"
@@ -481,7 +481,7 @@ It does not matter whether ``export ENV_VARIABLE`` appears before or
 after assignments to ``ENV_VARIABLE``.
 
 It is also possible to combine ``export`` with setting a value for the
-variable. Here is an example: ::
+variable. Here is an example::
 
    export ENV_VARIABLE = "variable-value"
 
@@ -518,7 +518,7 @@ variable.
    to satisfy conditions. Thus, if you have a variable that is
    conditional on "arm", and "arm" is in ``OVERRIDES``, then the
    "arm"-specific version of the variable is used rather than the
-   non-conditional version. Here is an example: ::
+   non-conditional version. Here is an example::
 
       OVERRIDES = "architecture:os:machine"
       TEST = "default"
@@ -535,7 +535,7 @@ variable.
    an OpenEmbedded metadata-based Linux kernel recipe file. The
    following lines from the recipe file first set the kernel branch
    variable ``KBRANCH`` to a default value, then conditionally override
-   that value based on the architecture of the build: ::
+   that value based on the architecture of the build::
 
       KBRANCH = "standard/base"
       KBRANCH_qemuarm = "standard/arm-versatile-926ejs"
@@ -547,7 +547,7 @@ variable.
 
 -  *Appending and Prepending:* BitBake also supports append and prepend
    operations to variable values based on whether a specific item is
-   listed in ``OVERRIDES``. Here is an example: ::
+   listed in ``OVERRIDES``. Here is an example::
 
       DEPENDS = "glibc ncurses"
       OVERRIDES = "machine:local"
@@ -557,14 +557,14 @@ variable.
 
    Again, using an OpenEmbedded metadata-based kernel recipe file as an
    example, the following lines will conditionally append to the
-   ``KERNEL_FEATURES`` variable based on the architecture: ::
+   ``KERNEL_FEATURES`` variable based on the architecture::
 
       KERNEL_FEATURES_append = " ${KERNEL_EXTRA_FEATURES}"
       KERNEL_FEATURES_append_qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
       KERNEL_FEATURES_append_qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
 
 -  *Setting a Variable for a Single Task:* BitBake supports setting a
-   variable just for the duration of a single task. Here is an example: ::
+   variable just for the duration of a single task. Here is an example::
 
       FOO_task-configure = "val 1"
       FOO_task-compile = "val 2"
@@ -580,7 +580,7 @@ variable.
    ``do_compile`` task.
 
    You can also use this syntax with other combinations (e.g.
-   "``_prepend``") as shown in the following example: ::
+   "``_prepend``") as shown in the following example::
 
       EXTRA_OEMAKE_prepend_task-compile = "${PARALLEL_MAKE} "
 
@@ -588,7 +588,7 @@ Key Expansion
 -------------
 
 Key expansion happens when the BitBake datastore is finalized. To better
-understand this, consider the following example: ::
+understand this, consider the following example::
 
    A${B} = "X"
    B = "2"
@@ -614,7 +614,7 @@ There is often confusion concerning the order in which overrides and
 various "append" operators take effect. Recall that an append or prepend
 operation using "_append" and "_prepend" does not result in an immediate
 assignment as would "+=", ".=", "=+", or "=.". Consider the following
-example: ::
+example::
 
    OVERRIDES = "foo"
    A = "Z"
@@ -631,7 +631,7 @@ Applying overrides, however, changes things. Since "foo" is listed in
 version, which is equal to "X". So effectively, ``A_foo`` replaces
 ``A``.
 
-This next example changes the order of the override and the append: ::
+This next example changes the order of the override and the append::
 
    OVERRIDES = "foo"
    A = "Z"
@@ -644,7 +644,7 @@ appended with "X". Consequently, ``A`` becomes "ZX". Notice that spaces
 are not appended.
 
 This next example has the order of the appends and overrides reversed
-back as in the first example: ::
+back as in the first example::
 
    OVERRIDES = "foo"
    A = "Y"
@@ -658,7 +658,7 @@ leaving the variable set to "ZX". Finally, applying the override for
 "foo" results in the conditional variable ``A`` becoming "ZX" (i.e.
 ``A`` is replaced with ``A_foo``).
 
-This final example mixes in some varying operators: ::
+This final example mixes in some varying operators::
 
    A = "1"
    A_append = "2"
@@ -720,7 +720,7 @@ file and then have your recipe inherit that class file.
 
 As an example, your recipes could use the following directive to inherit
 an ``autotools.bbclass`` file. The class file would contain common
-functionality for using Autotools that could be shared across recipes: ::
+functionality for using Autotools that could be shared across recipes::
 
    inherit autotools
 
@@ -734,7 +734,7 @@ In this case, BitBake would search for the directory
 
 If you want to use the directive to inherit multiple classes, separate
 them with spaces. The following example shows how to inherit both the
-``buildhistory`` and ``rm_work`` classes: ::
+``buildhistory`` and ``rm_work`` classes::
 
    inherit buildhistory rm_work
 
@@ -742,19 +742,19 @@ An advantage with the inherit directive as compared to both the
 :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>` and :ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
 directives is that you can inherit class files conditionally. You can
 accomplish this by using a variable expression after the ``inherit``
-statement. Here is an example: ::
+statement. Here is an example::
 
    inherit ${VARNAME}
 
 If ``VARNAME`` is
 going to be set, it needs to be set before the ``inherit`` statement is
 parsed. One way to achieve a conditional inherit in this case is to use
-overrides: ::
+overrides::
 
    VARIABLE = ""
    VARIABLE_someoverride = "myclass"
 
-Another method is by using anonymous Python. Here is an example: ::
+Another method is by using anonymous Python. Here is an example::
 
    python () {
        if condition == value:
@@ -764,7 +764,7 @@ Another method is by using anonymous Python. Here is an example: ::
    }
 
 Alternatively, you could use an in-line Python expression in the
-following form: ::
+following form::
 
    inherit ${@'classname' if condition else ''}
    inherit ${@functionname(params)}
@@ -790,7 +790,7 @@ encapsulated functionality or configuration that does not suit a
 ``.bbclass`` file.
 
 As an example, suppose you needed a recipe to include some self-test
-definitions: ::
+definitions::
 
    include test_defs.inc
 
@@ -831,7 +831,7 @@ include file named ``foo.inc`` that contains the common definitions
 needed to build "foo". You need to be sure ``foo.inc`` is located in the
 same directory as your two recipe files as well. Once these conditions
 are set up, you can share the functionality using a ``require``
-directive from within each recipe: ::
+directive from within each recipe::
 
    require foo.inc
 
@@ -844,7 +844,7 @@ class. BitBake only supports this directive when used within a
 configuration file.
 
 As an example, suppose you needed to inherit a class file called
-``abc.bbclass`` from a configuration file as follows: ::
+``abc.bbclass`` from a configuration file as follows::
 
    INHERIT += "abc"
 
@@ -862,7 +862,7 @@ subdirectory in one of the directories specified in ``BBPATH``.
 If you want to use the directive to inherit multiple classes, you can
 provide them on the same line in the ``local.conf`` file. Use spaces to
 separate the classes. The following example shows how to inherit both
-the ``autotools`` and ``pkgconfig`` classes: ::
+the ``autotools`` and ``pkgconfig`` classes::
 
    INHERIT += "autotools pkgconfig"
 
@@ -895,7 +895,7 @@ Shell Functions
 
 Functions written in shell script and executed either directly as
 functions, tasks, or both. They can also be called by other shell
-functions. Here is an example shell function definition: ::
+functions. Here is an example shell function definition::
 
    some_function () {
        echo "Hello World"
@@ -912,7 +912,7 @@ can also be applied to shell functions. Most commonly, this application
 would be used in a ``.bbappend`` file to modify functions in the main
 recipe. It can also be used to modify functions inherited from classes.
 
-As an example, consider the following: ::
+As an example, consider the following::
 
    do_foo() {
        bbplain first
@@ -931,7 +931,7 @@ As an example, consider the following: ::
        bbplain fourth
    }
 
-Running ``do_foo`` prints the following: ::
+Running ``do_foo`` prints the following::
 
    recipename do_foo: first
    recipename do_foo: second
@@ -952,7 +952,7 @@ BitBake-Style Python Functions
 These functions are written in Python and executed by BitBake or other
 Python functions using ``bb.build.exec_func()``.
 
-An example BitBake function is: ::
+An example BitBake function is::
 
    python some_python_function () {
        d.setVar("TEXT", "Hello World")
@@ -975,7 +975,7 @@ import these modules. Also in these types of functions, the datastore
 Similar to shell functions, you can also apply overrides and
 override-style operators to BitBake-style Python functions.
 
-As an example, consider the following: ::
+As an example, consider the following::
 
    python do_foo_prepend() {
        bb.plain("first")
@@ -989,7 +989,7 @@ As an example, consider the following: ::
        bb.plain("third")
    }
 
-Running ``do_foo`` prints the following: ::
+Running ``do_foo`` prints the following::
 
    recipename do_foo: first
    recipename do_foo: second
@@ -1004,7 +1004,7 @@ Python Functions
 These functions are written in Python and are executed by other Python
 code. Examples of Python functions are utility functions that you intend
 to call from in-line Python or from within other Python functions. Here
-is an example: ::
+is an example::
 
    def get_depends(d):
        if d.getVar('SOMECONDITION'):
@@ -1056,7 +1056,7 @@ functions and regular Python functions defined with "def":
 -  Regular Python functions are called with the usual Python syntax.
    BitBake-style Python functions are usually tasks and are called
    directly by BitBake, but can also be called manually from Python code
-   by using the ``bb.build.exec_func()`` function. Here is an example: ::
+   by using the ``bb.build.exec_func()`` function. Here is an example::
 
       bb.build.exec_func("my_bitbake_style_function", d)
 
@@ -1094,7 +1094,7 @@ Sometimes it is useful to set variables or perform other operations
 programmatically during parsing. To do this, you can define special
 Python functions, called anonymous Python functions, that run at the end
 of parsing. For example, the following conditionally sets a variable
-based on the value of another variable: ::
+based on the value of another variable::
 
    python () {
        if d.getVar('SOMEVAR') == 'value':
@@ -1107,7 +1107,7 @@ the name "__anonymous", rather than no name.
 Anonymous Python functions always run at the end of parsing, regardless
 of where they are defined. If a recipe contains many anonymous
 functions, they run in the same order as they are defined within the
-recipe. As an example, consider the following snippet: ::
+recipe. As an example, consider the following snippet::
 
    python () {
        d.setVar('FOO', 'foo 2')
@@ -1122,7 +1122,7 @@ recipe. As an example, consider the following snippet: ::
    BAR = "bar 1"
 
 The previous example is conceptually
-equivalent to the following snippet: ::
+equivalent to the following snippet::
 
    FOO = "foo 1"
    BAR = "bar 1"
@@ -1136,7 +1136,7 @@ available to tasks, which always run after parsing.
 
 Overrides and override-style operators such as "``_append``" are applied
 before anonymous functions run. In the following example, ``FOO`` ends
-up with the value "foo from anonymous": ::
+up with the value "foo from anonymous"::
 
    FOO = "foo"
    FOO_append = " from outside"
@@ -1173,24 +1173,24 @@ version of the function.
 
 To make use of this technique, you need the following things in place:
 
--  The class needs to define the function as follows: ::
+-  The class needs to define the function as follows::
 
       classname_functionname
 
    For example, if you have a class file
    ``bar.bbclass`` and a function named ``do_foo``, the class must
-   define the function as follows: ::
+   define the function as follows::
 
       bar_do_foo
 
 -  The class needs to contain the ``EXPORT_FUNCTIONS`` statement as
-   follows: ::
+   follows::
 
       EXPORT_FUNCTIONS functionname
 
    For example, continuing with
    the same example, the statement in the ``bar.bbclass`` would be as
-   follows: ::
+   follows::
 
       EXPORT_FUNCTIONS do_foo
 
@@ -1199,7 +1199,7 @@ To make use of this technique, you need the following things in place:
    class version of the function, it should call ``bar_do_foo``.
    Assuming ``do_foo`` was a shell function and ``EXPORT_FUNCTIONS`` was
    used as above, the recipe's function could conditionally call the
-   class version of the function as follows: ::
+   class version of the function as follows::
 
       do_foo() {
           if [ somecondition ] ; then
@@ -1233,7 +1233,7 @@ Tasks are either :ref:`shell functions <bitbake-user-manual/bitbake-user-manual-
 that have been promoted to tasks by using the ``addtask`` command. The
 ``addtask`` command can also optionally describe dependencies between
 the task and other tasks. Here is an example that shows how to define a
-task and declare some dependencies: ::
+task and declare some dependencies::
 
    python do_printdate () {
        import time
@@ -1264,12 +1264,12 @@ Additionally, the ``do_printdate`` task becomes dependent upon the
    rerun for experimentation purposes, you can make BitBake always
    consider the task "out-of-date" by using the
    :ref:`[nostamp] <bitbake-user-manual/bitbake-user-manual-metadata:Variable Flags>`
-   variable flag, as follows: ::
+   variable flag, as follows::
 
       do_printdate[nostamp] = "1"
 
    You can also explicitly run the task and provide the
-   -f option as follows: ::
+   -f option as follows::
 
       $ bitbake recipe -c printdate -f
 
@@ -1278,7 +1278,7 @@ Additionally, the ``do_printdate`` task becomes dependent upon the
    name.
 
 You might wonder about the practical effects of using ``addtask``
-without specifying any dependencies as is done in the following example: ::
+without specifying any dependencies as is done in the following example::
 
    addtask printdate
 
@@ -1286,7 +1286,7 @@ In this example, assuming dependencies have not been
 added through some other means, the only way to run the task is by
 explicitly selecting it with ``bitbake`` recipe ``-c printdate``. You
 can use the ``do_listtasks`` task to list all tasks defined in a recipe
-as shown in the following example: ::
+as shown in the following example::
 
    $ bitbake recipe -c listtasks
 
@@ -1312,7 +1312,7 @@ Deleting a Task
 
 As well as being able to add tasks, you can delete them. Simply use the
 ``deltask`` command to delete a task. For example, to delete the example
-task used in the previous sections, you would use: ::
+task used in the previous sections, you would use::
 
    deltask printdate
 
@@ -1328,7 +1328,7 @@ to run before ``do_a``.
 
 If you want dependencies such as these to remain intact, use the
 ``[noexec]`` varflag to disable the task instead of using the
-``deltask`` command to delete it: ::
+``deltask`` command to delete it::
 
    do_b[noexec] = "1"
 
@@ -1356,7 +1356,7 @@ environment, you must take these two steps:
    example, assume you want to prevent the build system from accessing
    your ``$HOME/.ccache`` directory. The following command "whitelists"
    the environment variable ``CCACHE_DIR`` causing BitBake to allow that
-   variable into the datastore: ::
+   variable into the datastore::
 
       export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE CCACHE_DIR"
 
@@ -1366,7 +1366,7 @@ environment, you must take these two steps:
    available in the datastore. To export it to the task environment of
    every running task, use a command similar to the following in your
    local configuration file ``local.conf`` or your distribution
-   configuration file: ::
+   configuration file::
 
       export CCACHE_DIR
 
@@ -1385,7 +1385,7 @@ environment into a special variable named :term:`BB_ORIGENV`.
 The ``BB_ORIGENV`` variable returns a datastore object that can be
 queried using the standard datastore operators such as
 ``getVar(, False)``. The datastore object is useful, for example, to
-find the original ``DISPLAY`` variable. Here is an example: ::
+find the original ``DISPLAY`` variable. Here is an example::
 
    origenv = d.getVar("BB_ORIGENV", False)
    bar = origenv.getVar("BAR", False)
@@ -1398,7 +1398,7 @@ Variable Flags
 
 Variable flags (varflags) help control a task's functionality and
 dependencies. BitBake reads and writes varflags to the datastore using
-the following command forms: ::
+the following command forms::
 
    variable = d.getVarFlags("variable")
    self.d.setVarFlags("FOO", {"func": True})
@@ -1537,7 +1537,7 @@ intent is to make it easy to do things like email notification on build
 failures.
 
 Following is an example event handler that prints the name of the event
-and the content of the ``FILE`` variable: ::
+and the content of the ``FILE`` variable::
 
    addhandler myclass_eventhandler
    python myclass_eventhandler() {
@@ -1676,7 +1676,7 @@ incarnations are buildable. These features are enabled through the
    also specify conditional metadata (using the
    :term:`OVERRIDES` mechanism) for a single
    version, or an optionally named range of versions. Here is an
-   example: ::
+   example::
 
       BBVERSIONS = "1.0 2.0 git"
       SRC_URI_git = "git://someurl/somepath.git"
@@ -1719,7 +1719,7 @@ Dependencies Internal to the ``.bb`` File
 BitBake uses the ``addtask`` directive to manage dependencies that are
 internal to a given recipe file. You can use the ``addtask`` directive
 to indicate when a task is dependent on other tasks or when other tasks
-depend on that recipe. Here is an example: ::
+depend on that recipe. Here is an example::
 
    addtask printdate after do_fetch before do_build
 
@@ -1743,7 +1743,7 @@ task depends on the completion of the ``do_printdate`` task.
 
    -  The directive ``addtask mytask after do_configure`` by itself
       never causes ``do_mytask`` to run. ``do_mytask`` can still be run
-      manually as follows: ::
+      manually as follows::
 
          $ bitbake recipe -c mytask
 
@@ -1757,7 +1757,7 @@ Build Dependencies
 BitBake uses the :term:`DEPENDS` variable to manage
 build time dependencies. The ``[deptask]`` varflag for tasks signifies
 the task of each item listed in ``DEPENDS`` that must complete before
-that task can be executed. Here is an example: ::
+that task can be executed. Here is an example::
 
    do_configure[deptask] = "do_populate_sysroot"
 
@@ -1799,7 +1799,7 @@ dependencies are discovered and added.
 
 The ``[recrdeptask]`` flag is most commonly used in high-level recipes
 that need to wait for some task to finish "globally". For example,
-``image.bbclass`` has the following: ::
+``image.bbclass`` has the following::
 
    do_rootfs[recrdeptask] += "do_packagedata"
 
@@ -1808,7 +1808,7 @@ the current recipe and all recipes reachable (by way of dependencies)
 from the image recipe must run before the ``do_rootfs`` task can run.
 
 BitBake allows a task to recursively depend on itself by
-referencing itself in the task list: ::
+referencing itself in the task list::
 
    do_a[recrdeptask] = "do_a do_b"
 
@@ -1825,7 +1825,7 @@ Inter-Task Dependencies
 BitBake uses the ``[depends]`` flag in a more generic form to manage
 inter-task dependencies. This more generic form allows for
 inter-dependency checks for specific tasks rather than checks for the
-data in ``DEPENDS``. Here is an example: ::
+data in ``DEPENDS``. Here is an example::
 
    do_patch[depends] = "quilt-native:do_populate_sysroot"
 
@@ -1920,7 +1920,7 @@ To help understand how BitBake does this, the section assumes an
 OpenEmbedded metadata-based example.
 
 These checksums are stored in :term:`STAMP`. You can
-examine the checksums using the following BitBake command: ::
+examine the checksums using the following BitBake command::
 
    $ bitbake-dumpsigs
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 489fa15f..e1b640e2 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -130,7 +130,7 @@ overview of their function and contents.
       you to control the build based on these parameters.
 
       Disk space monitoring is disabled by default. When setting this
-      variable, use the following form: ::
+      variable, use the following form::
 
          BB_DISKMON_DIRS = "<action>,<dir>,<threshold> [...]"
 
@@ -166,7 +166,7 @@ overview of their function and contents.
                not specify G, M, or K, Kbytes is assumed by
                default.  Do not use GB, MB, or KB.
 
-      Here are some examples: ::
+      Here are some examples::
 
          BB_DISKMON_DIRS = "ABORT,${TMPDIR},1G,100K WARN,${SSTATE_DIR},1G,100K"
          BB_DISKMON_DIRS = "STOPTASKS,${TMPDIR},1G"
@@ -207,7 +207,7 @@ overview of their function and contents.
       BB_DISKMON_WARNINTERVAL = "50M,5K"
 
       When specifying the variable in your configuration file, use the
-      following form: ::
+      following form::
 
          BB_DISKMON_WARNINTERVAL = "<disk_space_interval>,<disk_inode_interval>"
 
@@ -223,7 +223,7 @@ overview of their function and contents.
                G, M, or K for Gbytes, Mbytes, or Kbytes,
                respectively. You cannot use GB, MB, or KB.
 
-      Here is an example: ::
+      Here is an example::
 
          BB_DISKMON_DIRS = "WARN,${SSTATE_DIR},1G,100K"
          BB_DISKMON_WARNINTERVAL = "50M,5K"
@@ -329,7 +329,7 @@ overview of their function and contents.
       Specifies the name of the log files saved into
       ``${``\ :term:`T`\ ``}``. By default, the ``BB_LOGFMT``
       variable is undefined and the log file names get created using the
-      following form: ::
+      following form::
 
          log.{task}.{pid}
 
@@ -383,7 +383,7 @@ overview of their function and contents.
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the
       ``BB_RUNFMT`` variable is undefined and the run file names get
-      created using the following form: ::
+      created using the following form::
 
          run.{task}.{pid}
 
@@ -511,7 +511,7 @@ overview of their function and contents.
          This variable works similarly to the :term:`BB_TASK_NICE_LEVEL`
          variable except with a task's I/O priorities.
 
-      Set the variable as follows: ::
+      Set the variable as follows::
 
          BB_TASK_IONICE_LEVEL = "class.prio"
 
@@ -529,7 +529,7 @@ overview of their function and contents.
          In order for your I/O priority settings to take effect, you need the
          Completely Fair Queuing (CFQ) Scheduler selected for the backing block
          device. To select the scheduler, use the following command form where
-         device is the device (e.g. sda, sdb, and so forth): ::
+         device is the device (e.g. sda, sdb, and so forth)::
 
             $ sudo sh -c "echo cfq > /sys/block/device/queu/scheduler"
 
@@ -570,7 +570,7 @@ overview of their function and contents.
       To build a different variant of the recipe with a minimal amount of
       code, it usually is as simple as adding the variable to your recipe.
       Here are two examples. The "native" variants are from the
-      OpenEmbedded-Core metadata: ::
+      OpenEmbedded-Core metadata::
 
          BBCLASSEXTEND =+ "native nativesdk"
          BBCLASSEXTEND =+ "multilib:multilib_name"
@@ -658,12 +658,12 @@ overview of their function and contents.
       ``.bb`` files in case a layer is not present.  Use this avoid hard
       dependency on those other layers.
 
-      Use the following form for ``BBFILES_DYNAMIC``: ::
+      Use the following form for ``BBFILES_DYNAMIC``::
 
          collection_name:filename_pattern
 
       The following example identifies two collection names and two filename
-      patterns: ::
+      patterns::
 
          BBFILES_DYNAMIC += "\
              clang-layer:${LAYERDIR}/bbappends/meta-clang/*/*/*.bbappend \
@@ -671,14 +671,14 @@ overview of their function and contents.
          "
 
       When the collection name is prefixed with "!" it will add the file pattern in case
-      the layer is absent: ::
+      the layer is absent::
 
          BBFILES_DYNAMIC += "\
              !clang-layer:${LAYERDIR}/backfill/meta-clang/*/*/*.bb \
          "
 
       This next example shows an error message that occurs because invalid
-      entries are found, which cause parsing to abort: ::
+      entries are found, which cause parsing to abort::
 
          ERROR: BBFILES_DYNAMIC entries must be of the form {!}<collection name>:<filename pattern>, not:
          /work/my-layer/bbappends/meta-security-isafw/*/*/*.bbappend
@@ -701,7 +701,7 @@ overview of their function and contents.
    :term:`BBLAYERS`
       Lists the layers to enable during the build. This variable is defined
       in the ``bblayers.conf`` configuration file in the build directory.
-      Here is an example: ::
+      Here is an example::
 
          BBLAYERS = " \
              /home/scottrif/poky/meta \
@@ -735,13 +735,13 @@ overview of their function and contents.
 
       The following example uses a complete regular expression to tell
       BitBake to ignore all recipe and recipe append files in the
-      ``meta-ti/recipes-misc/`` directory: ::
+      ``meta-ti/recipes-misc/`` directory::
 
          BBMASK = "meta-ti/recipes-misc/"
 
       If you want to mask out multiple directories or recipes, you can
       specify multiple regular expression fragments. This next example
-      masks out multiple directories and individual recipes: ::
+      masks out multiple directories and individual recipes::
 
          BBMASK += "/meta-ti/recipes-misc/ meta-ti/recipes-ti/packagegroup/"
          BBMASK += "/meta-oe/recipes-support/"
@@ -762,7 +762,7 @@ overview of their function and contents.
       ``conf/local.conf`` configuration file.
 
       As an example, the following line specifies three multiconfigs, each
-      having a separate configuration file: ::
+      having a separate configuration file::
 
          BBMULTIFONFIG = "configA configB configC"
 
@@ -783,7 +783,7 @@ overview of their function and contents.
       If you run BitBake from a directory outside of the build directory,
       you must be sure to set ``BBPATH`` to point to the build directory.
       Set the variable as you would any environment variable and then run
-      BitBake: ::
+      BitBake::
 
          $ BBPATH="build_directory"
          $ export BBPATH
@@ -852,7 +852,7 @@ overview of their function and contents.
 
       Consider this simple example for two recipes named "a" and "b" that
       produce similarly named packages. In this example, the ``DEPENDS``
-      statement appears in the "a" recipe: ::
+      statement appears in the "a" recipe::
 
          DEPENDS = "b"
 
@@ -1074,7 +1074,7 @@ overview of their function and contents.
       recipes provide the same item. You should always suffix the variable
       with the name of the provided item, and you should set it to the
       :term:`PN` of the recipe to which you want to give
-      precedence. Some examples: ::
+      precedence. Some examples::
 
          PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
          PREFERRED_PROVIDER_virtual/xserver = "xserver-xf86"
@@ -1086,11 +1086,11 @@ overview of their function and contents.
       ``PREFERRED_PROVIDERS`` is identical to
       :term:`PREFERRED_PROVIDER`. However, the ``PREFERRED_PROVIDERS`` variable
       lets you define preferences for multiple situations using the following
-      form: ::
+      form::
 
          PREFERRED_PROVIDERS = "xxx:yyy aaa:bbb ..."
 
-      This form is a convenient replacement for the following: ::
+      This form is a convenient replacement for the following::
 
          PREFERRED_PROVIDER_xxx = "yyy"
          PREFERRED_PROVIDER_aaa = "bbb"
@@ -1106,7 +1106,7 @@ overview of their function and contents.
       through the "``%``" character. You can use the character to match any
       number of characters, which can be useful when specifying versions
       that contain long revision numbers that potentially change. Here are
-      two examples: ::
+      two examples::
 
          PREFERRED_VERSION_python = "2.7.3"
          PREFERRED_VERSION_linux-yocto = "4.12%"
@@ -1130,7 +1130,7 @@ overview of their function and contents.
 
       Typically, you would add a specific server for the build system to
       attempt before any others by adding something like the following to
-      your configuration: ::
+      your configuration::
 
          PREMIRRORS_prepend = "\
          git://.*/.* http://www.yoctoproject.org/sources/ \n \
@@ -1152,7 +1152,7 @@ overview of their function and contents.
       ``DEPENDS``.
 
       Consider the following example ``PROVIDES`` statement from a recipe
-      file ``libav_0.8.11.bb``: ::
+      file ``libav_0.8.11.bb``::
 
          PROVIDES += "libpostproc"
 
@@ -1175,7 +1175,7 @@ overview of their function and contents.
    :term:`PRSERV_HOST`
       The network based :term:`PR` service host and port.
 
-      Following is an example of how the ``PRSERV_HOST`` variable is set: ::
+      Following is an example of how the ``PRSERV_HOST`` variable is set::
 
          PRSERV_HOST = "localhost:0"
 
@@ -1196,7 +1196,7 @@ overview of their function and contents.
       you should always use the variable in a form with an attached package
       name. For example, suppose you are building a development package
       that depends on the ``perl`` package. In this case, you would use the
-      following ``RDEPENDS`` statement: ::
+      following ``RDEPENDS`` statement::
 
          RDEPENDS_${PN}-dev += "perl"
 
@@ -1207,11 +1207,11 @@ overview of their function and contents.
       BitBake supports specifying versioned dependencies. Although the
       syntax varies depending on the packaging format, BitBake hides these
       differences from you. Here is the general syntax to specify versions
-      with the ``RDEPENDS`` variable: ::
+      with the ``RDEPENDS`` variable::
 
          RDEPENDS_${PN} = "package (operator version)"
 
-      For ``operator``, you can specify the following: ::
+      For ``operator``, you can specify the following::
 
          =
          <
@@ -1220,7 +1220,7 @@ overview of their function and contents.
          >=
 
       For example, the following sets up a dependency on version 1.2 or
-      greater of the package ``foo``: ::
+      greater of the package ``foo``::
 
          RDEPENDS_${PN} = "foo (>= 1.2)"
 
@@ -1249,7 +1249,7 @@ overview of their function and contents.
 
       As with all package-controlling variables, you must always use the
       variable in conjunction with a package name override. Here is an
-      example: ::
+      example::
 
          RPROVIDES_${PN} = "widget-abi-2"
 
@@ -1263,11 +1263,11 @@ overview of their function and contents.
       BitBake supports specifying versioned recommends. Although the syntax
       varies depending on the packaging format, BitBake hides these
       differences from you. Here is the general syntax to specify versions
-      with the ``RRECOMMENDS`` variable: ::
+      with the ``RRECOMMENDS`` variable::
 
          RRECOMMENDS_${PN} = "package (operator version)"
 
-      For ``operator``, you can specify the following: ::
+      For ``operator``, you can specify the following::
 
          =
          <
@@ -1276,7 +1276,7 @@ overview of their function and contents.
          >=
 
       For example, the following sets up a recommend on version
-      1.2 or greater of the package ``foo``: ::
+      1.2 or greater of the package ``foo``::
 
          RRECOMMENDS_${PN} = "foo (>= 1.2)"
 
-- 
2.25.1

