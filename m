Return-Path: <fawzi.khaber@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AFBC7EE32
	for <webhook@archiver.kernel.org>; Wed,  1 Mar 2023 13:16:37 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.21409.1677676592963185673
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Mar 2023 05:16:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=bfrO2DCX;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: fawzi.khaber@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so7308154wmq.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Mar 2023 05:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5rgUVN07dYAZY06UcmRJM86fgvbypHFrlUlOcE2ZLY=;
        b=bfrO2DCXcXGoGKtmkMScwdoJQLSPKTDLouEYOC9VwJED8HZVRt5VkTu6EX9013Ku9u
         MoO/GitqzEQIIp+rcUCRydqIFBKvPkRx54fuQncSZdIShxa+olEtSq32C6QLWVj3iKMC
         tn0qqUm+jq+gpCqw3IhAvlMWOgnzgyeJMgC6AFHgDHaZytJGH27qxprEnORujeCUKFzL
         ybQ+8fdjCHEuHQjRfS1C+a6v9jTItUycEGilHLhYcOlIPcLuwROl++i72Si2OELbqtXR
         N+0l3pbdxOkwQPC67ealRPFtq55aYiaYnrpsTvMbEwwR/iZ7DCb36dEpVYu6hJOc9UEo
         laJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5rgUVN07dYAZY06UcmRJM86fgvbypHFrlUlOcE2ZLY=;
        b=0Ogm7O/iRGCYmsrMhJSjjAzbQjx9vJtww5gxTGS3+ATDt3Y2BKk5Jlwow/UGN1Nfkw
         xAHPB6zbjk9EVMTjaFSMSraJlnWGx5441I61rjsPJTfOxFe9nKwGVovzg88dnhVMIWbb
         wU9VxHSbCvLhwmPea++lxW4wbmc22BDgSnazRnImt49BBFtuqSHqRNvLFRvGXSa5YNyY
         ZcZAyhDEQV8EN9xNKA89MsPeX3MvlA8F7Nf/ExB2/rV+sarQc7vfzMu1Xk8VRjaROkds
         FdDyFauxO4YNRxGqUwZZadzofNx6vqZshZGCmxEDrOFty75syq+TLQzhQuaCAd5PPDl9
         yuzw==
X-Gm-Message-State: AO0yUKUB2ggglIUYZsNzSYZnHAishry5aS23ZMrE+0OBBOScnt9pNZ8s
	KIRj/ufvuBVarEnrpLNCOkkLs3A2n9vn5sYQ
X-Google-Smtp-Source: AK7set+2/dOKMRQLIigKxTRIMtmk1GPgIrELJ+n/tHFdg1O4QhkP+JVBSwmASV0sA/3ZAfhjr6AXPg==
X-Received: by 2002:a05:600c:a297:b0:3ea:c110:55ba with SMTP id hu23-20020a05600ca29700b003eac11055bamr5018364wmb.18.1677676591183;
        Wed, 01 Mar 2023 05:16:31 -0800 (PST)
Received: from P-ASN-SCRUM.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c4f0400b003df7b40f99fsm20800605wmq.11.2023.03.01.05.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 05:16:30 -0800 (PST)
From: Fawzi KHABER <fawzi.khaber@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Fawzi KHABER <fawzi.khaber@smile.fr>,
	Ever ATILANO <ever.atilano@smile.fr>,
	Yoann CONGAL <yoann.congal@smile.fr>
Subject: [PATCH v3 2/2] bitbake-user-manual: update Hello World example
Date: Wed,  1 Mar 2023 14:16:11 +0100
Message-Id: <20230301131611.16265-2-fawzi.khaber@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301131611.16265-1-fawzi.khaber@smile.fr>
References: <20230301131611.16265-1-fawzi.khaber@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Mar 2023 13:16:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14511

Fix broken link "Obtaining bitbake".
Update documentation for the bitbake hello world example, the output was
outdated.
Fix LAYERSERIES_COMPAT warning by adding dunfell as default compatible release.
Add proper formating for base.bbclass command.

Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
---
 .../bitbake-user-manual-hello.rst             | 89 ++++++++-----------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index 722dc5a2..2afa8e5c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -18,7 +18,7 @@ it.
 Obtaining BitBake
 =================
 
-See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
+See the :ref:`bitbake-user-manual/bitbake-user-manual-intro:obtaining bitbake` section for
 information on how to obtain BitBake. Once you have the source code on
 your machine, the BitBake directory appears as follows::
 
@@ -52,7 +52,7 @@ directory to where your local BitBake files are and run the following
 command::
 
   $ ./bin/bitbake --version
-  BitBake Build Tool Core version 1.23.0, bitbake version 1.23.0
+  BitBake Build Tool Core version 2.3.1
 
 The console output tells you what version
 you are running.
@@ -130,23 +130,8 @@ Following is the complete "Hello World" example.
     directory. Run the ``bitbake`` command and see what it does::
 
        $ bitbake
-       The BBPATH variable is not set and bitbake did not
-       find a conf/bblayers.conf file in the expected location.
+       ERROR: The BBPATH variable is not set and bitbake did not find a conf/bblayers.conf file in the expected location.
        Maybe you accidentally invoked bitbake from the wrong directory?
-       DEBUG: Removed the following variables from the environment:
-       GNOME_DESKTOP_SESSION_ID, XDG_CURRENT_DESKTOP,
-       GNOME_KEYRING_CONTROL, DISPLAY, SSH_AGENT_PID, LANG, no_proxy,
-       XDG_SESSION_PATH, XAUTHORITY, SESSION_MANAGER, SHLVL,
-       MANDATORY_PATH, COMPIZ_CONFIG_PROFILE, WINDOWID, EDITOR,
-       GPG_AGENT_INFO, SSH_AUTH_SOCK, GDMSESSION, GNOME_KEYRING_PID,
-       XDG_SEAT_PATH, XDG_CONFIG_DIRS, LESSOPEN, DBUS_SESSION_BUS_ADDRESS,
-       _, XDG_SESSION_COOKIE, DESKTOP_SESSION, LESSCLOSE, DEFAULTS_PATH,
-       UBUNTU_MENUPROXY, OLDPWD, XDG_DATA_DIRS, COLORTERM, LS_COLORS
-
-    The majority of this output is specific to environment variables that
-    are not directly relevant to BitBake. However, the very first
-    message regarding the :term:`BBPATH` variable and the
-    ``conf/bblayers.conf`` file is relevant.
 
     When you run BitBake, it begins looking for metadata files. The
     :term:`BBPATH` variable is what tells BitBake where
@@ -179,20 +164,14 @@ Following is the complete "Hello World" example.
     ``bitbake`` command again::
 
        $ bitbake
-       ERROR: Traceback (most recent call last):
-         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 163, in wrapped
-           return func(fn, *args)
-         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 173, in parse_config_file
-           return bb.parse.handle(fn, data, include)
-         File "/home/scott-lenovo/bitbake/lib/bb/parse/__init__.py", line 99, in handle
-           return h['handle'](fn, data, include)
-         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/ConfHandler.py", line 120, in handle
-           abs_fn = resolve_file(fn, data)
-         File "/home/scott-lenovo/bitbake/lib/bb/parse/__init__.py", line 117, in resolve_file
-           raise IOError("file %s not found in %s" % (fn, bbpath))
-       IOError: file conf/bitbake.conf not found in /home/scott-lenovo/hello
-
-       ERROR: Unable to parse conf/bitbake.conf: file conf/bitbake.conf not found in /home/scott-lenovo/hello
+       ERROR: Unable to parse /home/scott-lenovo/bitbake/lib/bb/parse/__init__.py
+       Traceback (most recent call last):
+       File "/home/scott-lenovo/bitbake/lib/bb/parse/__init__.py", line 127, in resolve_file(fn='conf/bitbake.conf', d=<bb.data_smart.DataSmart object at 0x7f22919a3df0>):
+             if not newfn:
+       >            raise IOError(errno.ENOENT, "file %s not found in %s" % (fn, bbpath))
+             fn = newfn
+       FileNotFoundError: [Errno 2] file conf/bitbake.conf not found in <projectdirectory>
+
 
     This sample output shows that BitBake could not find the
     ``conf/bitbake.conf`` file in the project directory. This file is
@@ -254,18 +233,14 @@ Following is the complete "Hello World" example.
     exists, you can run the ``bitbake`` command again::
 
        $ bitbake
-       ERROR: Traceback (most recent call last):
-         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 163, in wrapped
-           return func(fn, *args)
-         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 177, in _inherit
-           bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
-         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 92, in inherit
-           include(fn, file, lineno, d, "inherit")
-         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/ConfHandler.py", line 100, in include
-           raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
-       ParseError: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
-
-       ERROR: Unable to parse base: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
+       ERROR: Unable to parse /home/scott-lenovo/bitbake/lib/bb/parse/parse_py/BBHandler.py
+       Traceback (most recent call last):
+       File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 67, in inherit(files=['base'], fn='configuration INHERITs', lineno=0, d=<bb.data_smart.DataSmart object at 0x7fab6815edf0>):
+             if not os.path.exists(file):
+       >            raise ParseError("Could not inherit file %s" % (file), fn, lineno)
+     
+       bb.parse.ParseError: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
+
 
     In the sample output,
     BitBake could not find the ``classes/base.bbclass`` file. You need
@@ -284,7 +259,10 @@ Following is the complete "Hello World" example.
       $ mkdir classes
 
     Move to the ``classes`` directory and then create the
-    ``base.bbclass`` file by inserting this single line: addtask build
+    ``base.bbclass`` file by inserting this single line::
+   
+      addtask build
+   
     The minimal task that BitBake runs is the ``do_build`` task. This is
     all the example needs in order to build the project. Of course, the
     ``base.bbclass`` can have much more depending on which build
@@ -328,10 +306,19 @@ Following is the complete "Hello World" example.
       BBFILES += "${LAYERDIR}/*.bb"
       BBFILE_COLLECTIONS += "mylayer"
       BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
+      LAYERSERIES_CORENAMES = "hello_world_example"
+      LAYERSERIES_COMPAT_mylayer = "hello_world_example"
 
     For information on these variables, click on :term:`BBFILES`,
-    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS` or :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
-    to go to the definitions in the glossary.
+    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS`, :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
+    or :term:`LAYERSERIES_COMPAT` to go to the definitions in the glossary.
+
+    .. note::
+
+       We are setting both LAYERSERIES_CORENAMES and LAYERSERIES_COMPAT in this particular case, because we
+       are using bitbake without OpenEmbedded. 
+       You should usually just use LAYERSERIES_COMPAT to specify the OE-Core versions for which your layer
+       is compatible, and add the meta-openembedded layer to your project.
 
     You need to create the recipe file next. Inside your layer at the
     top-level, use an editor and create a recipe file named
@@ -389,12 +376,14 @@ Following is the complete "Hello World" example.
     target::
 
        $ bitbake printhello
+       Loading cache: 100% |
+       Loaded 0 entries from dependency cache.
        Parsing recipes: 100% |##################################################################################|
-       Time: 00:00:00
        Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0 skipped, 0 masked, 0 errors.
        NOTE: Resolving any missing task queue dependencies
-       NOTE: Preparing RunQueue
-       NOTE: Executing RunQueue Tasks
+       Initialising tasks: 100% |###############################################################################|
+       NOTE: No setscene tasks
+       NOTE: Executing Tasks
        ********************
        *                  *
        *  Hello, World!   *
-- 
2.39.2


