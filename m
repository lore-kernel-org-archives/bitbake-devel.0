Return-Path: <fawzi.khaber@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B7C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 16:14:50 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.20352.1677773681322483446
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Mar 2023 08:14:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=FLtMha1+;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: fawzi.khaber@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso2155355wmq.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Mar 2023 08:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEro1HZ5q6KFs1yVry/kYfKWlyMYboCabqRJ9tvtIvM=;
        b=FLtMha1+VeYcLdcAIoWBzeiqqNABUopB2ZRyOU24TJEKWnxgbwT64MUkeCIHyjr1T2
         XMw8Zk/44Z0Af2TTtl9WrsJ91+r/YlLIhgdiGAd3Y2C7uAA/qiZM39JgydBjzTZguGhU
         NdoPRKcL+bTnZRDTjqZNvkPBNID+BSU+lhmlZkECKoCyYaQPKRMVzquRqBVe4d9Nv24g
         iMcccwO815kw8Njat1FgvS/FON1+XIfFNLfC/em491V6NTG2kQEBN3smfbDNR6wJgcYV
         +O/S7PS1m6O4GtOV9lzm/8kKEVVVR/fkKalgMsDeRpM98K2+PCzOEjoLSX+IYurWkPYn
         dkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEro1HZ5q6KFs1yVry/kYfKWlyMYboCabqRJ9tvtIvM=;
        b=X168jdld3qEST904qhfrQxOVnSvI61Thp23S277yOkhtsZFjNgnM6UiXXTT3Y2iMav
         M1si3twlftUoBxGfQKE/L8RJxTNADNocCzcraGhq1e5lLXnVjCP7B5Yf+cz8a6Kx0UmR
         hGw0h3KfYSw0Ycb7DZibX4V1AHGdnu5nJcMk7cP2bQeJHnRJ38qlwOWR849YWONpLfkT
         fMtc9NaSoDrqRASwMZXlTPzhC7J+WQxyaRDRJW3y3CW8MQVMKmT1A86oattLbyu8L29y
         hoHu7yenk8NDiTe+nrdV/5pSyNLCcuk4CBJk+JfNDYdg+4IiAESwQ9wm0mTAxyp/2/R8
         B1Kg==
X-Gm-Message-State: AO0yUKV0zTiaP/lTbT4EtgMws9LzK5TRw6Y7mg6pYjdzkLW3Uw8Kg0XH
	uvYV1TY8wrAzQ317DQrXD7/JaIlKF/pcYyL+
X-Google-Smtp-Source: AK7set+5S68uasuPBuZuDQ4MR3qS/EE0tcKRxm+bZhUosBOQUxtuLrorWFCzjjkN1p1Ycfd2J1Eamg==
X-Received: by 2002:a05:600c:190e:b0:3db:8de:6993 with SMTP id j14-20020a05600c190e00b003db08de6993mr1950635wmq.4.1677773679589;
        Thu, 02 Mar 2023 08:14:39 -0800 (PST)
Received: from localhost.localdomain (251.38.22.93.rev.sfr.net. [93.22.38.251])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b003e204fdb160sm3861779wmo.3.2023.03.02.08.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:14:39 -0800 (PST)
From: Fawzi KHABER <fawzi.khaber@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Fawzi KHABER <fawzi.khaber@smile.fr>,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Ever ATILANO <ever.atilano@smile.fr>,
	Yoann CONGAL <yoann.congal@smile.fr>
Subject: [PATCH v4 2/2] bitbake-user-manual: update Hello World example
Date: Thu,  2 Mar 2023 17:14:31 +0100
Message-Id: <20230302161431.8594-2-fawzi.khaber@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302161431.8594-1-fawzi.khaber@smile.fr>
References: <20230302161431.8594-1-fawzi.khaber@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Mar 2023 16:14:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14517

Fix broken link "Obtaining bitbake".
Update documentation for the bitbake hello world example, the output was
outdated.
Fix LAYERSERIES_COMPAT warning by adding dunfell as default compatible release.
Add proper formating for base.bbclass command.

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
---
 .../bitbake-user-manual-hello.rst             | 127 +++++++++---------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index 722dc5a2..c8251d2a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -18,28 +18,32 @@ it.
 Obtaining BitBake
 =================
 
-See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
+See the :ref:`bitbake-user-manual/bitbake-user-manual-intro:obtaining bitbake` section for
 information on how to obtain BitBake. Once you have the source code on
 your machine, the BitBake directory appears as follows::
 
    $ ls -al
-   total 100
-   drwxrwxr-x. 9 wmat wmat  4096 Jan 31 13:44 .
-   drwxrwxr-x. 3 wmat wmat  4096 Feb  4 10:45 ..
-   -rw-rw-r--. 1 wmat wmat   365 Nov 26 04:55 AUTHORS
-   drwxrwxr-x. 2 wmat wmat  4096 Nov 26 04:55 bin
-   drwxrwxr-x. 4 wmat wmat  4096 Jan 31 13:44 build
-   -rw-rw-r--. 1 wmat wmat 16501 Nov 26 04:55 ChangeLog
-   drwxrwxr-x. 2 wmat wmat  4096 Nov 26 04:55 classes
-   drwxrwxr-x. 2 wmat wmat  4096 Nov 26 04:55 conf
-   drwxrwxr-x. 3 wmat wmat  4096 Nov 26 04:55 contrib
-   -rw-rw-r--. 1 wmat wmat 17987 Nov 26 04:55 COPYING
-   drwxrwxr-x. 3 wmat wmat  4096 Nov 26 04:55 doc
-   -rw-rw-r--. 1 wmat wmat    69 Nov 26 04:55 .gitignore
-   -rw-rw-r--. 1 wmat wmat   849 Nov 26 04:55 HEADER
-   drwxrwxr-x. 5 wmat wmat  4096 Jan 31 13:44 lib
-   -rw-rw-r--. 1 wmat wmat   195 Nov 26 04:55 MANIFEST.in
-   -rw-rw-r--. 1 wmat wmat  2887 Nov 26 04:55 TODO
+   total 108
+   drwxr-xr-x  9 fawkh 10000  4096 feb 24 12:10 .
+   drwx------ 36 fawkh 10000  4096 mar  2 17:00 ..
+   -rw-r--r--  1 fawkh 10000   365 feb 24 12:10 AUTHORS
+   drwxr-xr-x  2 fawkh 10000  4096 feb 24 12:10 bin
+   -rw-r--r--  1 fawkh 10000 16501 feb 24 12:10 ChangeLog
+   drwxr-xr-x  2 fawkh 10000  4096 feb 24 12:10 classes
+   drwxr-xr-x  2 fawkh 10000  4096 feb 24 12:10 conf
+   drwxr-xr-x  5 fawkh 10000  4096 feb 24 12:10 contrib
+   drwxr-xr-x  6 fawkh 10000  4096 feb 24 12:10 doc
+   drwxr-xr-x  8 fawkh 10000  4096 mar  2 16:26 .git
+   -rw-r--r--  1 fawkh 10000    31 feb 24 12:10 .gitattributes
+   -rw-r--r--  1 fawkh 10000   392 feb 24 12:10 .gitignore
+   drwxr-xr-x 13 fawkh 10000  4096 feb 24 12:11 lib
+   -rw-r--r--  1 fawkh 10000  1224 feb 24 12:10 LICENSE
+   -rw-r--r--  1 fawkh 10000 15394 feb 24 12:10 LICENSE.GPL-2.0-only
+   -rw-r--r--  1 fawkh 10000  1286 feb 24 12:10 LICENSE.MIT
+   -rw-r--r--  1 fawkh 10000   229 feb 24 12:10 MANIFEST.in
+   -rw-r--r--  1 fawkh 10000  2413 feb 24 12:10 README
+   -rw-r--r--  1 fawkh 10000    43 feb 24 12:10 toaster-requirements.txt
+   -rw-r--r--  1 fawkh 10000  2887 feb 24 12:10 TODO
 
 At this point, you should have BitBake cloned to a directory that
 matches the previous listing except for dates and user names.
@@ -52,7 +56,7 @@ directory to where your local BitBake files are and run the following
 command::
 
   $ ./bin/bitbake --version
-  BitBake Build Tool Core version 1.23.0, bitbake version 1.23.0
+  BitBake Build Tool Core version 2.3.1
 
 The console output tells you what version
 you are running.
@@ -130,23 +134,8 @@ Following is the complete "Hello World" example.
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
@@ -179,20 +168,14 @@ Following is the complete "Hello World" example.
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
@@ -254,18 +237,14 @@ Following is the complete "Hello World" example.
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
@@ -284,7 +263,10 @@ Following is the complete "Hello World" example.
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
@@ -328,10 +310,19 @@ Following is the complete "Hello World" example.
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
@@ -389,12 +380,14 @@ Following is the complete "Hello World" example.
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


