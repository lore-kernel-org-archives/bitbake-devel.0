Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.33815.1601900835626241432
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 05:27:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=lShhNhvM;
 spf=pass (domain: linaro.org, ip: 209.85.221.67, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wr1-f67.google.com with SMTP id o5so9326711wrn.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2020 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RxvP1+o0agsNTtjNfYsg467RjeqSAz/bjMwqh5m3UI=;
        b=lShhNhvMJk08UHi+IJmObfDGoh3qopfleeVkeUn3Wj2cznfNepTn9MXp1aFlBb61r0
         iCEFEOhxg9i+V9FZm6tnCIuFeSCzpev6UugtCv48ZOUlIz0kieQUU2VNBAQxAAiOta8u
         37ZS6A1+Uj+EZvlOtH+DNkEnUl5Gpb0eimv2izKR8uZPFH8bxdbgwQzA9niU77dwF2yu
         Vf/0NbJvhOWG7V8LmDDvIdM3k3MPI0i36lZHnoZGGYGG4kSxDVX7/uaWlO+sPImP27a8
         k9oeR5UPvbXBRtA1yqUr+LTPGP/8UBuQ2oyTCf6eZt0mpPuO+hrCmtpUj369MM4PSBPG
         nVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RxvP1+o0agsNTtjNfYsg467RjeqSAz/bjMwqh5m3UI=;
        b=MWhTpekXb7WDoBeLPMfO0EuTPexrBYgOxRGR1CSDD8RVQIVe//GlBLlu5Gw9bssijV
         CRTmaGwSpKy6ziYEuM2k4QswpNeC5ZkAP3CNsJnxTp1fjWQ14wcn8ZKuaNXpal5Bx/WD
         zgUFg06XnTPdiEHvmwFAZpmuzgz16L0UtFpJEGUk9u3RCs8HTPgoaXbO2PJstC5C0Ar5
         s6MSZ9ACidkwOm1AndU9rYkdDvvoVC5U/KaSYBMpGd2ZuekOfPbqfOeCGHRc1e3tj6V7
         3PMmNwVcQqfmegXmjdpexdYaMwx/g440BV0a5lycl15EI1PSjr/yOcVYX6/rs5KWamRy
         zxcg==
X-Gm-Message-State: AOAM531CQaGyY+/3/JHeKMVCAZ8vZ+wWUe8frafS5GgTEMSgNUcuKCn0
	Y1zJT+SjcEWV1U3scLJJnpDL9I2WRUHi8w==
X-Google-Smtp-Source: ABdhPJxK/QXB8EEF3WDOqHkKcqoLBGtLEBQMDtcqg03+Fm8PrDZaYjIM9W/S+RovCc/fl6MS69cDHg==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr17519502wrw.253.1601900832356;
        Mon, 05 Oct 2020 05:27:12 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from localhost.localdomain (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id c130sm1953628wma.17.2020.10.05.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:11 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: foss@0leil.net,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH 1/5] docs: ref-variables: add links to terms in glossary
Date: Mon,  5 Oct 2020 14:26:48 +0200
Message-Id: <20201005122652.392528-2-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
References: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is similar to this change in yocto-docs:
9e468274eaad (docs: ref-manual: ref-variables: add links to terms in glossary)

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 .../bitbake-user-manual-ref-variables.rst     | 244 +++++++++---------
 1 file changed, 122 insertions(+), 122 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index fb1b353c..3de2a9ff 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -29,7 +29,7 @@ overview of their function and contents.
 
 .. glossary::
 
-   ASSUME_PROVIDED
+   :term:`ASSUME_PROVIDED`
       Lists recipe names (:term:`PN` values) BitBake does not
       attempt to build. Instead, BitBake assumes these recipes have already
       been built.
@@ -39,11 +39,11 @@ overview of their function and contents.
       when specified allows for the Git binary from the host to be used
       rather than building ``git-native``.
 
-   B
+   :term:`B`
       The directory in which BitBake executes functions during a recipe's
       build process.
 
-   BB_ALLOWED_NETWORKS
+   :term:`BB_ALLOWED_NETWORKS`
       Specifies a space-delimited list of hosts that the fetcher is allowed
       to use to obtain the required source code. Following are
       considerations surrounding this variable:
@@ -83,15 +83,15 @@ overview of their function and contents.
       fetcher does not attempt to use the host listed in ``SRC_URI`` after
       a successful fetch from the ``PREMIRRORS`` occurs.
 
-   BB_CONSOLELOG
+   :term:`BB_CONSOLELOG`
       Specifies the path to a log file into which BitBake's user interface
       writes output during the build.
 
-   BB_CURRENTTASK
+   :term:`BB_CURRENTTASK`
       Contains the name of the currently running task. The name does not
       include the ``do_`` prefix.
 
-   BB_DANGLINGAPPENDS_WARNONLY
+   :term:`BB_DANGLINGAPPENDS_WARNONLY`
       Defines how BitBake handles situations where an append file
       (``.bbappend``) has no corresponding recipe file (``.bb``). This
       condition often occurs when layers get out of sync (e.g. ``oe-core``
@@ -103,12 +103,12 @@ overview of their function and contents.
       given something is out of sync. It is important to realize when your
       changes are no longer being applied.
 
-   BB_DEFAULT_TASK
+   :term:`BB_DEFAULT_TASK`
       The default task to use when none is specified (e.g. with the ``-c``
       command line option). The task name specified should not include the
       ``do_`` prefix.
 
-   BB_DISKMON_DIRS
+   :term:`BB_DISKMON_DIRS`
       Monitors disk space and available inodes during the build and allows
       you to control the build based on these parameters.
 
@@ -175,7 +175,7 @@ overview of their function and contents.
       free inodes in the ``${TMPDIR}`` directory drops below 100 Kbytes. No
       disk space monitoring for the directory itself occurs in this case.
 
-   BB_DISKMON_WARNINTERVAL
+   :term:`BB_DISKMON_WARNINTERVAL`
       Defines the disk space and free inode warning intervals.
 
       If you are going to use the ``BB_DISKMON_WARNINTERVAL`` variable, you
@@ -218,7 +218,7 @@ overview of their function and contents.
       based on the interval occur each time a respective interval is
       reached beyond the initial warning (i.e. 1 Gbytes and 100 Kbytes).
 
-   BB_ENV_WHITELIST
+   :term:`BB_ENV_WHITELIST`
       Specifies the internal whitelist of variables to allow through from
       the external environment into BitBake's datastore. If the value of
       this variable is not specified (which is the default), the following
@@ -230,7 +230,7 @@ overview of their function and contents.
          You must set this variable in the external environment in order
          for it to work.
 
-   BB_ENV_EXTRAWHITE
+   :term:`BB_ENV_EXTRAWHITE`
       Specifies an additional set of variables to allow through (whitelist)
       from the external environment into BitBake's datastore. This list of
       variables are on top of the internal list set in
@@ -241,19 +241,19 @@ overview of their function and contents.
          You must set this variable in the external environment in order
          for it to work.
 
-   BB_FETCH_PREMIRRORONLY
+   :term:`BB_FETCH_PREMIRRORONLY`
       When set to "1", causes BitBake's fetcher module to only search
       :term:`PREMIRRORS` for files. BitBake will not
       search the main :term:`SRC_URI` or
       :term:`MIRRORS`.
 
-   BB_FILENAME
+   :term:`BB_FILENAME`
       Contains the filename of the recipe that owns the currently running
       task. For example, if the ``do_fetch`` task that resides in the
       ``my-recipe.bb`` is executing, the ``BB_FILENAME`` variable contains
       "/foo/path/my-recipe.bb".
 
-   BBFILES_DYNAMIC
+   :term:`BBFILES_DYNAMIC`
       Activates content depending on presence of identified layers.  You
       identify the layers by the collections that the layers define.
 
@@ -292,7 +292,7 @@ overview of their function and contents.
          /work/my-layer/bbappends/meta-security-isafw/*/*/*.bbappend
          /work/my-layer/bbappends/openembedded-core/meta/*/*/*.bbappend
 
-   BB_GENERATE_MIRROR_TARBALLS
+   :term:`BB_GENERATE_MIRROR_TARBALLS`
       Causes tarballs of the Git repositories, including the Git metadata,
       to be placed in the :term:`DL_DIR` directory. Anyone
       wishing to create a source mirror would want to enable this variable.
@@ -302,7 +302,7 @@ overview of their function and contents.
 
          BB_GENERATE_MIRROR_TARBALLS = "1"
 
-   BB_HASHCONFIG_WHITELIST
+   :term:`BB_HASHCONFIG_WHITELIST`
       Lists variables that are excluded from base configuration checksum,
       which is used to determine if the cache can be reused.
 
@@ -314,14 +314,14 @@ overview of their function and contents.
       and ``DATE`` because these variables are always changing. If you did
       not exclude them, BitBake would never reuse the cache.
 
-   BB_HASHBASE_WHITELIST
+   :term:`BB_HASHBASE_WHITELIST`
       Lists variables that are excluded from checksum and dependency data.
       Variables that are excluded can therefore change without affecting
       the checksum mechanism. A common example would be the variable for
       the path of the build. BitBake's output should not (and usually does
       not) depend on the directory in which it was built.
 
-   BB_HASHCHECK_FUNCTION
+   :term:`BB_HASHCHECK_FUNCTION`
       Specifies the name of the function to call during the "setscene" part
       of the task's execution in order to validate the list of task hashes.
       The function returns the list of setscene tasks that should be
@@ -335,19 +335,19 @@ overview of their function and contents.
       However, the more accurate the data returned, the more efficient the
       build will be.
 
-   BB_INVALIDCONF
+   :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
       re-parsing the base metadata (i.e. all the recipes). The
       ``ConfigParsed`` event can set the variable to trigger the re-parse.
       You must be careful to avoid recursive loops with this functionality.
 
-   BB_LOGCONFIG
+   :term:`BB_LOGCONFIG`
       Specifies the name of a config file that contains the user logging
       configuration. See
       :ref:`bitbake-user-manual/bitbake-user-manual-execution:logging`
       for additional information
 
-   BB_LOGFMT
+   :term:`BB_LOGFMT`
       Specifies the name of the log files saved into
       ``${``\ :term:`T`\ ``}``. By default, the ``BB_LOGFMT``
       variable is undefined and the log file names get created using the
@@ -358,13 +358,13 @@ overview of their function and contents.
       If you want to force log files to take a specific name, you can set this
       variable in a configuration file.
 
-   BB_NICE_LEVEL
+   :term:`BB_NICE_LEVEL`
       Allows BitBake to run at a specific priority (i.e. nice level).
       System permissions usually mean that BitBake can reduce its priority
       but not raise it again. See :term:`BB_TASK_NICE_LEVEL` for
       additional information.
 
-   BB_NO_NETWORK
+   :term:`BB_NO_NETWORK`
       Disables network access in the BitBake fetcher modules. With this
       access disabled, any command that attempts to access the network
       becomes an error.
@@ -373,16 +373,16 @@ overview of their function and contents.
       running builds when not connected to the Internet, and when operating
       in certain kinds of firewall environments.
 
-   BB_NUMBER_THREADS
+   :term:`BB_NUMBER_THREADS`
       The maximum number of tasks BitBake should run in parallel at any one
       time. If your host development system supports multiple cores, a good
       rule of thumb is to set this variable to twice the number of cores.
 
-   BB_NUMBER_PARSE_THREADS
+   :term:`BB_NUMBER_PARSE_THREADS`
       Sets the number of threads BitBake uses when parsing. By default, the
       number of threads is equal to the number of cores on the system.
 
-   BB_ORIGENV
+   :term:`BB_ORIGENV`
       Contains a copy of the original external environment in which BitBake
       was run. The copy is taken before any whitelisted variable values are
       filtered into BitBake's datastore.
@@ -392,7 +392,7 @@ overview of their function and contents.
          The contents of this variable is a datastore object that can be
          queried using the normal datastore operations.
 
-   BB_PRESERVE_ENV
+   :term:`BB_PRESERVE_ENV`
       Disables whitelisting and instead allows all variables through from
       the external environment into BitBake's datastore.
 
@@ -401,7 +401,7 @@ overview of their function and contents.
          You must set this variable in the external environment in order
          for it to work.
 
-   BB_RUNFMT
+   :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the
       ``BB_RUNFMT`` variable is undefined and the run file names get
@@ -412,12 +412,12 @@ overview of their function and contents.
       If you want to force run files to take a specific name, you can set this
       variable in a configuration file.
 
-   BB_RUNTASK
+   :term:`BB_RUNTASK`
       Contains the name of the currently executing task. The value includes
       the "do\_" prefix. For example, if the currently executing task is
       ``do_config``, the value is "do_config".
 
-   BB_SCHEDULER
+   :term:`BB_SCHEDULER`
       Selects the name of the scheduler to use for the scheduling of
       BitBake tasks. Three options exist:
 
@@ -431,14 +431,14 @@ overview of their function and contents.
       -  *completion* - Causes the scheduler to try to complete a given
          recipe once its build has started.
 
-   BB_SCHEDULERS
+   :term:`BB_SCHEDULERS`
       Defines custom schedulers to import. Custom schedulers need to be
       derived from the ``RunQueueScheduler`` class.
 
       For information how to select a scheduler, see the
       :term:`BB_SCHEDULER` variable.
 
-   BB_SETSCENE_DEPVALID
+   :term:`BB_SETSCENE_DEPVALID`
       Specifies a function BitBake calls that determines whether BitBake
       requires a setscene dependency to be met.
 
@@ -448,7 +448,7 @@ overview of their function and contents.
       The function specified by this variable returns a "True" or "False"
       depending on whether the dependency needs to be met.
 
-   BB_SETSCENE_VERIFY_FUNCTION2
+   :term:`BB_SETSCENE_VERIFY_FUNCTION2`
       Specifies a function to call that verifies the list of planned task
       execution before the main task execution happens. The function is
       called once BitBake has a list of setscene tasks that have run and
@@ -459,7 +459,7 @@ overview of their function and contents.
       the function can force BitBake to run the task, which is necessary
       under certain metadata defined circumstances.
 
-   BB_SIGNATURE_EXCLUDE_FLAGS
+   :term:`BB_SIGNATURE_EXCLUDE_FLAGS`
       Lists variable flags (varflags) that can be safely excluded from
       checksum and dependency data for keys in the datastore. When
       generating checksum or dependency data for keys in the datastore, the
@@ -469,7 +469,7 @@ overview of their function and contents.
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:variable flags`"
       section.
 
-   BB_SIGNATURE_HANDLER
+   :term:`BB_SIGNATURE_HANDLER`
       Defines the name of the signature handler BitBake uses. The signature
       handler defines the way stamp files are created and handled, if and
       how the signature is incorporated into the stamps, and how the
@@ -478,7 +478,7 @@ overview of their function and contents.
       A new signature handler can be added by injecting a class derived
       from the ``SignatureGenerator`` class into the global namespace.
 
-   BB_SRCREV_POLICY
+   :term:`BB_SRCREV_POLICY`
       Defines the behavior of the fetcher when it interacts with source
       control systems and dynamic source revisions. The
       ``BB_SRCREV_POLICY`` variable is useful when working without a
@@ -492,7 +492,7 @@ overview of their function and contents.
       -  *clear* - Queries the source controls system every time. With this
          policy, there is no cache. The "clear" policy is the default.
 
-   BB_STAMP_POLICY
+   :term:`BB_STAMP_POLICY`
       Defines the mode used for how timestamps of stamp files are compared.
       You can set the variable to one of the following modes:
 
@@ -510,18 +510,18 @@ overview of their function and contents.
          Stamp policies are largely obsolete with the introduction of
          setscene tasks.
 
-   BB_STAMP_WHITELIST
+   :term:`BB_STAMP_WHITELIST`
       Lists files whose stamp file timestamps are compared when the stamp
       policy mode is set to "whitelist". For information on stamp policies,
       see the :term:`BB_STAMP_POLICY` variable.
 
-   BB_STRICT_CHECKSUM
+   :term:`BB_STRICT_CHECKSUM`
       Sets a more strict checksum mechanism for non-local URLs. Setting
       this variable to a value causes BitBake to report an error if it
       encounters a non-local URL that does not have at least one checksum
       specified.
 
-   BB_TASK_IONICE_LEVEL
+   :term:`BB_TASK_IONICE_LEVEL`
       Allows adjustment of a task's Input/Output priority. During
       Autobuilder testing, random failures can occur for tasks due to I/O
       starvation. These failures occur during various QEMU runtime
@@ -555,7 +555,7 @@ overview of their function and contents.
 
             $ sudo sh -c “echo cfq > /sys/block/device/queu/scheduler
 
-   BB_TASK_NICE_LEVEL
+   :term:`BB_TASK_NICE_LEVEL`
       Allows specific tasks to change their priority (i.e. nice level).
 
       You can use this variable in combination with task overrides to raise
@@ -564,22 +564,22 @@ overview of their function and contents.
       in images is given a higher priority as compared to build tasks to
       ensure that images do not suffer timeouts on loaded systems.
 
-   BB_TASKHASH
+   :term:`BB_TASKHASH`
       Within an executing task, this variable holds the hash of the task as
       returned by the currently enabled signature generator.
 
-   BB_VERBOSE_LOGS
+   :term:`BB_VERBOSE_LOGS`
       Controls how verbose BitBake is during builds. If set, shell scripts
       echo commands and shell script output appears on standard out
       (stdout).
 
-   BB_WORKERCONTEXT
+   :term:`BB_WORKERCONTEXT`
       Specifies if the current context is executing a task. BitBake sets
       this variable to "1" when a task is being executed. The value is not
       set when the task is in server context during parsing or event
       handling.
 
-   BBCLASSEXTEND
+   :term:`BBCLASSEXTEND`
       Allows you to extend a recipe so that it builds variants of the
       software. Some examples of these variants for recipes from the
       OpenEmbedded-Core metadata are "natives" such as ``quilt-native``,
@@ -611,7 +611,7 @@ overview of their function and contents.
          since ``include`` statements are processed when the recipe is
          parsed.
 
-   BBDEBUG
+   :term:`BBDEBUG`
       Sets the BitBake debug output level to a specific value as
       incremented by the ``-D`` command line option.
 
@@ -620,19 +620,19 @@ overview of their function and contents.
          You must set this variable in the external environment in order
          for it to work.
 
-   BBFILE_COLLECTIONS
+   :term:`BBFILE_COLLECTIONS`
       Lists the names of configured layers. These names are used to find
       the other ``BBFILE_*`` variables. Typically, each layer appends its
       name to this variable in its ``conf/layer.conf`` file.
 
-   BBFILE_PATTERN
+   :term:`BBFILE_PATTERN`
       Variable that expands to match files from
       :term:`BBFILES` in a particular layer. This
       variable is used in the ``conf/layer.conf`` file and must be suffixed
       with the name of the specific layer (e.g.
       ``BBFILE_PATTERN_emenlow``).
 
-   BBFILE_PRIORITY
+   :term:`BBFILE_PRIORITY`
       Assigns the priority for recipe files in each layer.
 
       This variable is useful in situations where the same recipe appears
@@ -658,7 +658,7 @@ overview of their function and contents.
          You can use the command bitbake-layers show-layers to list all
          configured layers along with their priorities.
 
-   BBFILES
+   :term:`BBFILES`
       A space-separated list of recipe files BitBake uses to build
       software.
 
@@ -667,21 +667,21 @@ overview of their function and contents.
       For details on the syntax, see the documentation by following the
       previous link.
 
-   BBINCLUDED
+   :term:`BBINCLUDED`
       Contains a space-separated list of all of all files that BitBake's
       parser included during parsing of the current file.
 
-   BBINCLUDELOGS
+   :term:`BBINCLUDELOGS`
       If set to a value, enables printing the task log when reporting a
       failed task.
 
-   BBINCLUDELOGS_LINES
+   :term:`BBINCLUDELOGS_LINES`
       If :term:`BBINCLUDELOGS` is set, specifies
       the maximum number of lines from the task log file to print when
       reporting a failed task. If you do not set ``BBINCLUDELOGS_LINES``,
       the entire log is printed.
 
-   BBLAYERS
+   :term:`BBLAYERS`
       Lists the layers to enable during the build. This variable is defined
       in the ``bblayers.conf`` configuration file in the build directory.
       Here is an example: ::
@@ -696,12 +696,12 @@ overview of their function and contents.
       This example enables four layers, one of which is a custom, user-defined
       layer named ``meta-mykernel``.
 
-   BBLAYERS_FETCH_DIR
+   :term:`BBLAYERS_FETCH_DIR`
       Sets the base location where layers are stored. This setting is used
       in conjunction with ``bitbake-layers layerindex-fetch`` and tells
       ``bitbake-layers`` where to place the fetched layers.
 
-   BBMASK
+   :term:`BBMASK`
       Prevents BitBake from processing recipes and recipe append files.
 
       You can use the ``BBMASK`` variable to "hide" these ``.bb`` and
@@ -737,7 +737,7 @@ overview of their function and contents.
          When specifying a directory name, use the trailing slash character
          to ensure you match just that directory name.
 
-   BBMULTICONFIG
+   :term:`BBMULTICONFIG`
       Enables BitBake to perform multiple configuration builds and lists
       each separate configuration (multiconfig). You can use this variable
       to cause BitBake to build multiple targets where each target has a
@@ -758,7 +758,7 @@ overview of their function and contents.
       ":ref:`bitbake-user-manual/bitbake-user-manual-intro:executing a multiple configuration build`"
       section.
 
-   BBPATH
+   :term:`BBPATH`
       Used by BitBake to locate class (``.bbclass``) and configuration
       (``.conf``) files. This variable is analogous to the ``PATH``
       variable.
@@ -772,15 +772,15 @@ overview of their function and contents.
          $ export BBPATH
          $ bitbake target
 
-   BBSERVER
+   :term:`BBSERVER`
       Points to the server that runs memory-resident BitBake. The variable
       is only used when you employ memory-resident BitBake.
 
-   BBTARGETS
+   :term:`BBTARGETS`
       Allows you to use a configuration file to add to the list of
       command-line target recipes you want to build.
 
-   BBVERSIONS
+   :term:`BBVERSIONS`
       Allows a single recipe to build multiple versions of a project from a
       single recipe file. You also able to specify conditional metadata
       using the :term:`OVERRIDES` mechanism for a
@@ -790,7 +790,7 @@ overview of their function and contents.
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:variants - class extension mechanism`"
       section.
 
-   BITBAKE_UI
+   :term:`BITBAKE_UI`
       Used to specify the UI module to use when running BitBake. Using this
       variable is equivalent to using the ``-u`` command-line option.
 
@@ -799,23 +799,23 @@ overview of their function and contents.
          You must set this variable in the external environment in order
          for it to work.
 
-   BUILDNAME
+   :term:`BUILDNAME`
       A name assigned to the build. The name defaults to a datetime stamp
       of when the build was started but can be defined by the metadata.
 
-   BZRDIR
+   :term:`BZRDIR`
       The directory in which files checked out of a Bazaar system are
       stored.
 
-   CACHE
+   :term:`CACHE`
       Specifies the directory BitBake uses to store a cache of the metadata
       so it does not need to be parsed every time BitBake is started.
 
-   CVSDIR
+   :term:`CVSDIR`
       The directory in which files checked out under the CVS system are
       stored.
 
-   DEFAULT_PREFERENCE
+   :term:`DEFAULT_PREFERENCE`
       Specifies a weak bias for recipe selection priority.
 
       The most common usage of this is variable is to set it to "-1" within
@@ -830,7 +830,7 @@ overview of their function and contents.
          :term:`BBFILE_PRIORITY` if that variable is different between two
          layers that contain different versions of the same recipe.
 
-   DEPENDS
+   :term:`DEPENDS`
       Lists a recipe's build-time dependencies (i.e. other recipe files).
 
       Consider this simple example for two recipes named "a" and "b" that
@@ -847,16 +847,16 @@ overview of their function and contents.
       For information on runtime dependencies, see the :term:`RDEPENDS`
       variable.
 
-   DESCRIPTION
+   :term:`DESCRIPTION`
       A long description for the recipe.
 
-   DL_DIR
+   :term:`DL_DIR`
       The central download directory used by the build process to store
       downloads. By default, ``DL_DIR`` gets files suitable for mirroring for
       everything except Git repositories. If you want tarballs of Git
       repositories, use the :term:`BB_GENERATE_MIRROR_TARBALLS` variable.
 
-   EXCLUDE_FROM_WORLD
+   :term:`EXCLUDE_FROM_WORLD`
       Directs BitBake to exclude a recipe from world builds (i.e.
       ``bitbake world``). During world builds, BitBake locates, parses and
       builds all recipes found in every layer exposed in the
@@ -872,68 +872,68 @@ overview of their function and contents.
          recipe to ``EXCLUDE_FROM_WORLD`` only ensures that the recipe is not
          explicitly added to the list of build targets in a world build.
 
-   FAKEROOT
+   :term:`FAKEROOT`
       Contains the command to use when running a shell script in a fakeroot
       environment. The ``FAKEROOT`` variable is obsolete and has been
       replaced by the other ``FAKEROOT*`` variables. See these entries in
       the glossary for more information.
 
-   FAKEROOTBASEENV
+   :term:`FAKEROOTBASEENV`
       Lists environment variables to set when executing the command defined
       by :term:`FAKEROOTCMD` that starts the
       bitbake-worker process in the fakeroot environment.
 
-   FAKEROOTCMD
+   :term:`FAKEROOTCMD`
       Contains the command that starts the bitbake-worker process in the
       fakeroot environment.
 
-   FAKEROOTDIRS
+   :term:`FAKEROOTDIRS`
       Lists directories to create before running a task in the fakeroot
       environment.
 
-   FAKEROOTENV
+   :term:`FAKEROOTENV`
       Lists environment variables to set when running a task in the
       fakeroot environment. For additional information on environment
       variables and the fakeroot environment, see the
       :term:`FAKEROOTBASEENV` variable.
 
-   FAKEROOTNOENV
+   :term:`FAKEROOTNOENV`
       Lists environment variables to set when running a task that is not in
       the fakeroot environment. For additional information on environment
       variables and the fakeroot environment, see the
       :term:`FAKEROOTENV` variable.
 
-   FETCHCMD
+   :term:`FETCHCMD`
       Defines the command the BitBake fetcher module executes when running
       fetch operations. You need to use an override suffix when you use the
       variable (e.g. ``FETCHCMD_git`` or ``FETCHCMD_svn``).
 
-   FILE
+   :term:`FILE`
       Points at the current file. BitBake sets this variable during the
       parsing process to identify the file being parsed. BitBake also sets
       this variable when a recipe is being executed to identify the recipe
       file.
 
-   FILESPATH
+   :term:`FILESPATH`
       Specifies directories BitBake uses when searching for patches and
       files. The "local" fetcher module uses these directories when
       handling ``file://`` URLs. The variable behaves like a shell ``PATH``
       environment variable. The value is a colon-separated list of
       directories that are searched left-to-right in order.
 
-   GITDIR
+   :term:`GITDIR`
       The directory in which a local copy of a Git repository is stored
       when it is cloned.
 
-   HGDIR
+   :term:`HGDIR`
       The directory in which files checked out of a Mercurial system are
       stored.
 
-   HOMEPAGE
+   :term:`HOMEPAGE`
       Website where more information about the software the recipe is
       building can be found.
 
-   INHERIT
+   :term:`INHERIT`
       Causes the named class or classes to be inherited globally. Anonymous
       functions in the class or classes are not executed for the base
       configuration and in each individual recipe. The OpenEmbedded build
@@ -943,7 +943,7 @@ overview of their function and contents.
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:\`\`inherit\`\` configuration directive`"
       section.
 
-   LAYERDEPENDS
+   :term:`LAYERDEPENDS`
       Lists the layers, separated by spaces, upon which this recipe
       depends. Optionally, you can specify a specific layer version for a
       dependency by adding it to the end of the layer name with a colon,
@@ -956,20 +956,20 @@ overview of their function and contents.
       use the specific layer name as a suffix to the variable (e.g.
       ``LAYERDEPENDS_mylayer``).
 
-   LAYERDIR
+   :term:`LAYERDIR`
       When used inside the ``layer.conf`` configuration file, this variable
       provides the path of the current layer. This variable is not
       available outside of ``layer.conf`` and references are expanded
       immediately when parsing of the file completes.
 
-   LAYERDIR_RE
+   :term:`LAYERDIR_RE`
       When used inside the ``layer.conf`` configuration file, this variable
       provides the path of the current layer, escaped for use in a regular
       expression (:term:`BBFILE_PATTERN`). This
       variable is not available outside of ``layer.conf`` and references
       are expanded immediately when parsing of the file completes.
 
-   LAYERVERSION
+   :term:`LAYERVERSION`
       Optionally specifies the version of a layer as a single number. You
       can use this variable within
       :term:`LAYERDEPENDS` for another layer in
@@ -979,10 +979,10 @@ overview of their function and contents.
       use the specific layer name as a suffix to the variable (e.g.
       ``LAYERDEPENDS_mylayer``).
 
-   LICENSE
+   :term:`LICENSE`
       The list of source licenses for the recipe.
 
-   MIRRORS
+   :term:`MIRRORS`
       Specifies additional paths from which BitBake gets source code. When
       the build system searches for source code, it first tries the local
       download directory. If that location fails, the build system tries
@@ -990,7 +990,7 @@ overview of their function and contents.
       upstream source, and then locations specified by ``MIRRORS`` in that
       order.
 
-   MULTI_PROVIDER_WHITELIST
+   :term:`MULTI_PROVIDER_WHITELIST`
       Allows you to suppress BitBake warnings caused when building two
       separate recipes that provide the same output.
 
@@ -1003,7 +1003,7 @@ overview of their function and contents.
       To use the variable, list provider names (e.g. recipe names,
       ``virtual/kernel``, and so forth).
 
-   OVERRIDES
+   :term:`OVERRIDES`
       BitBake uses ``OVERRIDES`` to control what variables are overridden
       after BitBake parses recipes and configuration files.
 
@@ -1013,14 +1013,14 @@ overview of their function and contents.
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:conditional syntax
       (overrides)`" section.
 
-   P4DIR
+   :term:`P4DIR`
       The directory in which a local copy of a Perforce depot is stored
       when it is fetched.
 
-   PACKAGES
+   :term:`PACKAGES`
       The list of packages the recipe creates.
 
-   PACKAGES_DYNAMIC
+   :term:`PACKAGES_DYNAMIC`
       A promise that your recipe satisfies runtime dependencies for
       optional modules that are found in other recipes.
       ``PACKAGES_DYNAMIC`` does not actually satisfy the dependencies, it
@@ -1030,29 +1030,29 @@ overview of their function and contents.
       ``PACKAGES_DYNAMIC`` variable, but a package with the module name is
       never actually produced, then the other package will be broken.
 
-   PE
+   :term:`PE`
       The epoch of the recipe. By default, this variable is unset. The
       variable is used to make upgrades possible when the versioning scheme
       changes in some backwards incompatible way.
 
-   PERSISTENT_DIR
+   :term:`PERSISTENT_DIR`
       Specifies the directory BitBake uses to store data that should be
       preserved between builds. In particular, the data stored is the data
       that uses BitBake's persistent data API and the data used by the PR
       Server and PR Service.
 
-   PF
+   :term:`PF`
       Specifies the recipe or package name and includes all version and
       revision numbers (i.e. ``eglibc-2.13-r20+svnr15508/`` and
       ``bash-4.2-r1/``).
 
-   PN
+   :term:`PN`
       The recipe name.
 
-   PR
+   :term:`PR`
       The revision of the recipe.
 
-   PREFERRED_PROVIDER
+   :term:`PREFERRED_PROVIDER`
       Determines which recipe should be given preference when multiple
       recipes provide the same item. You should always suffix the variable
       with the name of the provided item, and you should set it to the
@@ -1063,7 +1063,7 @@ overview of their function and contents.
          PREFERRED_PROVIDER_virtual/xserver = "xserver-xf86"
          PREFERRED_PROVIDER_virtual/libgl ?= "mesa"
 
-   PREFERRED_PROVIDERS
+   :term:`PREFERRED_PROVIDERS`
       Determines which recipe should be given preference for cases where
       multiple recipes provide the same item. Functionally,
       ``PREFERRED_PROVIDERS`` is identical to
@@ -1078,7 +1078,7 @@ overview of their function and contents.
          PREFERRED_PROVIDER_xxx = "yyy"
          PREFERRED_PROVIDER_aaa = "bbb"
 
-   PREFERRED_VERSION
+   :term:`PREFERRED_VERSION`
       If there are multiple versions of recipes available, this variable
       determines which recipe should be given preference. You must always
       suffix the variable with the :term:`PN` you want to
@@ -1100,7 +1100,7 @@ overview of their function and contents.
          end of the string. You cannot use the wildcard character in any other
          location of the string.
 
-   PREMIRRORS
+   :term:`PREMIRRORS`
       Specifies additional paths from which BitBake gets source code. When
       the build system searches for source code, it first tries the local
       download directory. If that location fails, the build system tries
@@ -1122,7 +1122,7 @@ overview of their function and contents.
       use ``file://`` URLs to point to local directories or network shares as
       well.
 
-   PROVIDES
+   :term:`PROVIDES`
       A list of aliases by which a particular recipe can be known. By
       default, a recipe's own ``PN`` is implicitly already in its
       ``PROVIDES`` list. If a recipe uses ``PROVIDES``, the additional
@@ -1151,7 +1151,7 @@ overview of their function and contents.
       "virtual/function" (e.g. "virtual/kernel"). The slash is simply part
       of the name and has no syntactical significance.
 
-   PRSERV_HOST
+   :term:`PRSERV_HOST`
       The network based :term:`PR` service host and port.
 
       Following is an example of how the ``PRSERV_HOST`` variable is set: ::
@@ -1162,10 +1162,10 @@ overview of their function and contents.
       service. You can set ``PRSERV_HOST`` to other values to use a remote PR
       service.
 
-   PV
+   :term:`PV`
       The version of the recipe.
 
-   RDEPENDS
+   :term:`RDEPENDS`
       Lists a package's runtime dependencies (i.e. other packages) that
       must be installed in order for the built package to run correctly. If
       a package in this list cannot be found during the build, you will get
@@ -1206,11 +1206,11 @@ overview of their function and contents.
       For information on build-time dependencies, see the :term:`DEPENDS`
       variable.
 
-   REPODIR
+   :term:`REPODIR`
       The directory in which a local copy of a ``google-repo`` directory is
       stored when it is synced.
 
-   RPROVIDES
+   :term:`RPROVIDES`
       A list of package name aliases that a package also provides. These
       aliases are useful for satisfying runtime dependencies of other
       packages both during the build and on the target (as specified by
@@ -1222,7 +1222,7 @@ overview of their function and contents.
 
          RPROVIDES_${PN} = "widget-abi-2"
 
-   RRECOMMENDS
+   :term:`RRECOMMENDS`
       A list of packages that extends the usability of a package being
       built. The package being built does not depend on this list of
       packages in order to successfully build, but needs them for the
@@ -1249,10 +1249,10 @@ overview of their function and contents.
 
          RRECOMMENDS_${PN} = "foo (>= 1.2)"
 
-   SECTION
+   :term:`SECTION`
       The section in which packages should be categorized.
 
-   SRC_URI
+   :term:`SRC_URI`
       The list of source files - local or remote. This variable tells
       BitBake which bits to pull for the build and how to pull them. For
       example, if the recipe or append file needs to fetch a single tarball
@@ -1316,12 +1316,12 @@ overview of their function and contents.
       -  ``downloadfilename`` : Specifies the filename used when storing
          the downloaded file.
 
-   SRCDATE
+   :term:`SRCDATE`
       The date of the source code used to build the package. This variable
       applies only if the source was fetched from a Source Code Manager
       (SCM).
 
-   SRCREV
+   :term:`SRCREV`
       The revision of the source code used to build the package. This
       variable applies only when using Subversion, Git, Mercurial and
       Bazaar. If you want to build a fixed revision and you want to avoid
@@ -1329,7 +1329,7 @@ overview of their function and contents.
       your recipe, you should specify a ``SRCREV`` that is a full revision
       identifier and not just a tag.
 
-   SRCREV_FORMAT
+   :term:`SRCREV_FORMAT`
       Helps construct valid :term:`SRCREV` values when
       multiple source controlled URLs are used in
       :term:`SRC_URI`.
@@ -1343,30 +1343,30 @@ overview of their function and contents.
       ``AUTOINC`` placeholder is added and if needed. And, this placeholder
       is placed at the start of the returned string.
 
-   STAMP
+   :term:`STAMP`
       Specifies the base path used to create recipe stamp files. The path
       to an actual stamp file is constructed by evaluating this string and
       then appending additional information.
 
-   STAMPCLEAN
+   :term:`STAMPCLEAN`
       Specifies the base path used to create recipe stamp files. Unlike the
       :term:`STAMP` variable, ``STAMPCLEAN`` can contain
       wildcards to match the range of files a clean operation should
       remove. BitBake uses a clean operation to remove any other stamps it
       should be removing when creating a new stamp.
 
-   SUMMARY
+   :term:`SUMMARY`
       A short summary for the recipe, which is 72 characters or less.
 
-   SVNDIR
+   :term:`SVNDIR`
       The directory in which files checked out of a Subversion system are
       stored.
 
-   T
+   :term:`T`
       Points to a directory were BitBake places temporary files, which
       consist mostly of task logs and scripts, when building a particular
       recipe.
 
-   TOPDIR
+   :term:`TOPDIR`
       Points to the build directory. BitBake automatically sets this
       variable.
-- 
2.28.0

