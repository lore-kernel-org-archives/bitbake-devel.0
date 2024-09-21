Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C91FCF9C69
	for <webhook@archiver.kernel.org>; Sat, 21 Sep 2024 12:45:44 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.8953.1726922742180477017
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Sep 2024 05:45:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=v/sL5Yzu;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so24741285e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1726922740; x=1727527540; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg3QFD8hNijVoxMofhpDaeLq/eZhrxeEDT1+staUbsw=;
        b=v/sL5Yzu1YrPaGvJmKXIFKQCK5cnFZ9O/UPf6jO8XGgVYUDKJoSIkwenzw34/h29ex
         vYjqEGPy1QMiN+mMEqIzPx1o7rHythZJEOReP7ELnKxxXvhRRmgYdfnnUCUta+mm7QTu
         5T6ZDyKhYDxMn35bct23pcZt79tyyMqm8VHlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726922740; x=1727527540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kg3QFD8hNijVoxMofhpDaeLq/eZhrxeEDT1+staUbsw=;
        b=DbubVw6Kq7GSgoxEO3CS9kAVgQKP6qV/TZ90FHK3nYW++HxcFGIBCgeXZ2M/BIm6g8
         BTpMTGdanSLs4PPG/xwldC4iaGoDC6rhgCPM9NULW+C9tqQr7rwuB8s7RepIhbCDM4pF
         Is5GAtCIycEjQ4dVEWw6q65sMe9e29R8KH7ZgZnjtmu6Yq4lOCB4OXJaQ1hez5gYqiKB
         +sXTCvP/PrdlpkcnBVvSYVsTyPHkjesSFvW2LGoCivdgh0GH7lnA/LFzEdgotpa8Hj0H
         yvmEgbXBj6tMSpNyISx15xZQU61c9GCP/myD5GTJ4bGSkQ1DqPdb9xSgFaQb89U4CXr4
         +Esg==
X-Gm-Message-State: AOJu0YyxV0+TiHyy8lQdhOex3yFkcsqx1H/f7Gs+CS15x0HjG5wg0mYP
	kCvbvn+hh+YrXmK1Wf/YDVevHhJdc+BygSgyJzO/+bnjfq8MiofycKcAyqRK8RzdAYHJ/KC+KyG
	5
X-Google-Smtp-Source: AGHT+IECeqIafbNgC+OPc74peKPT6WCC6JJ6BJ6BFzeRT/mWtTaegQMAGCsP4niNO32AGoMESjPXgw==
X-Received: by 2002:a05:600c:1c29:b0:42c:bb75:4f86 with SMTP id 5b1f17b1804b1-42e7add501emr43847835e9.32.1726922740260;
        Sat, 21 Sep 2024 05:45:40 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afe1437sm49274505e9.33.2024.09.21.05.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 05:45:33 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] doc/user-manual: Refresh help output
Date: Sat, 21 Sep 2024 14:44:33 +0200
Message-Id: <20240921124433.1961318-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 12:45:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16580

From: Yoann Congal <yoann.congal@smile.fr>

In commit 9257c48c3e36 ("Group and reorder options in bitbake help"),
help output was changed, update the doc to match the new output.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 .../bitbake-user-manual-intro.rst             | 173 ++++++++++--------
 1 file changed, 98 insertions(+), 75 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 35ffb88b0..86905f4a8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -349,40 +349,84 @@ Usage and syntax
 Following is the usage and syntax for BitBake::
 
    $ bitbake -h
-   Usage: bitbake [options] [recipename/target recipe:do_task ...]
-
-       Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
-       It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
-       will provide the layer, BBFILES and other configuration information.
-
-   Options:
-     --version             show program's version number and exit
-     -h, --help            show this help message and exit
-     -b BUILDFILE, --buildfile=BUILDFILE
-                           Execute tasks from a specific .bb recipe directly.
-                           WARNING: Does not handle any dependencies from other
-                           recipes.
-     -k, --continue        Continue as much as possible after an error. While the
-                           target that failed and anything depending on it cannot
-                           be built, as much as possible will be built before
-                           stopping.
+   usage: bitbake [-s] [-e] [-g] [-u UI] [--version] [-h] [-f] [-c CMD]
+                  [-C INVALIDATE_STAMP] [--runall RUNALL] [--runonly RUNONLY]
+                  [--no-setscene] [--skip-setscene] [--setscene-only] [-n] [-p]
+                  [-k] [-P] [-S SIGNATURE_HANDLER] [--revisions-changed]
+                  [-b BUILDFILE] [-D] [-l DEBUG_DOMAINS] [-v] [-q]
+                  [-w WRITEEVENTLOG] [-B BIND] [-T SERVER_TIMEOUT]
+                  [--remote-server REMOTE_SERVER] [-m] [--token XMLRPCTOKEN]
+                  [--observe-only] [--status-only] [--server-only] [-r PREFILE]
+                  [-R POSTFILE] [-I EXTRA_ASSUME_PROVIDED]
+                  [recipename/target ...]
+   
+   It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH
+   which will provide the layer, BBFILES and other configuration information.
+   
+   General options:
+     recipename/target     Execute the specified task (default is 'build') for
+                           these target recipes (.bb files).
+     -s, --show-versions   Show current and preferred versions of all recipes.
+     -e, --environment     Show the global or per-recipe environment complete
+                           with information about where variables were
+                           set/changed.
+     -g, --graphviz        Save dependency tree information for the specified
+                           targets in the dot syntax.
+     -u UI, --ui UI        The user interface to use (knotty, ncurses, taskexp,
+                           taskexp_ncurses or teamcity - default knotty).
+     --version             Show programs version and exit.
+     -h, --help            Show this help message and exit.
+   
+   Task control options:
      -f, --force           Force the specified targets/task to run (invalidating
                            any existing stamp file).
-     -c CMD, --cmd=CMD     Specify the task to execute. The exact options
+     -c CMD, --cmd CMD     Specify the task to execute. The exact options
                            available depend on the metadata. Some examples might
                            be 'compile' or 'populate_sysroot' or 'listtasks' may
                            give a list of the tasks available.
-     -C INVALIDATE_STAMP, --clear-stamp=INVALIDATE_STAMP
+     -C INVALIDATE_STAMP, --clear-stamp INVALIDATE_STAMP
                            Invalidate the stamp for the specified task such as
                            'compile' and then run the default task for the
                            specified target(s).
-     -r PREFILE, --read=PREFILE
-                           Read the specified file before bitbake.conf.
-     -R POSTFILE, --postread=POSTFILE
-                           Read the specified file after bitbake.conf.
-     -v, --verbose         Enable tracing of shell tasks (with 'set -x'). Also
-                           print bb.note(...) messages to stdout (in addition to
-                           writing them to ${T}/log.do_&lt;task&gt;).
+     --runall RUNALL       Run the specified task for any recipe in the taskgraph
+                           of the specified target (even if it wouldn't otherwise
+                           have run).
+     --runonly RUNONLY     Run only the specified task within the taskgraph of
+                           the specified targets (and any task dependencies those
+                           tasks may have).
+     --no-setscene         Do not run any setscene tasks. sstate will be ignored
+                           and everything needed, built.
+     --skip-setscene       Skip setscene tasks if they would be executed. Tasks
+                           previously restored from sstate will be kept, unlike
+                           --no-setscene.
+     --setscene-only       Only run setscene tasks, don't run any real tasks.
+   
+   Execution control options:
+     -n, --dry-run         Don't execute, just go through the motions.
+     -p, --parse-only      Quit after parsing the BB recipes.
+     -k, --continue        Continue as much as possible after an error. While the
+                           target that failed and anything depending on it cannot
+                           be built, as much as possible will be built before
+                           stopping.
+     -P, --profile         Profile the command and save reports.
+     -S SIGNATURE_HANDLER, --dump-signatures SIGNATURE_HANDLER
+                           Dump out the signature construction information, with
+                           no task execution. The SIGNATURE_HANDLER parameter is
+                           passed to the handler. Two common values are none and
+                           printdiff but the handler may define more/less. none
+                           means only dump the signature, printdiff means
+                           recursively compare the dumped signature with the most
+                           recent one in a local build or sstate cache (can be
+                           used to find out why tasks re-run when that is not
+                           expected)
+     --revisions-changed   Set the exit code depending on whether upstream
+                           floating revisions have changed or not.
+     -b BUILDFILE, --buildfile BUILDFILE
+                           Execute tasks from a specific .bb recipe directly.
+                           WARNING: Does not handle any dependencies from other
+                           recipes.
+   
+   Logging/output control options:
      -D, --debug           Increase the debug level. You can specify this more
                            than once. -D sets the debug level to 1, where only
                            bb.debug(1, ...) messages are printed to stdout; -DD
@@ -392,65 +436,44 @@ Following is the usage and syntax for BitBake::
                            -D only affects output to stdout. All debug messages
                            are written to ${T}/log.do_taskname, regardless of the
                            debug level.
+     -l DEBUG_DOMAINS, --log-domains DEBUG_DOMAINS
+                           Show debug logging for the specified logging domains.
+     -v, --verbose         Enable tracing of shell tasks (with 'set -x'). Also
+                           print bb.note(...) messages to stdout (in addition to
+                           writing them to ${T}/log.do_<task>).
      -q, --quiet           Output less log message data to the terminal. You can
                            specify this more than once.
-     -n, --dry-run         Don't execute, just go through the motions.
-     -S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
-                           Dump out the signature construction information, with
-                           no task execution. The SIGNATURE_HANDLER parameter is
-                           passed to the handler. Two common values are none and
-                           printdiff but the handler may define more/less. none
-                           means only dump the signature, printdiff means compare
-                           the dumped signature with the cached one.
-     -p, --parse-only      Quit after parsing the BB recipes.
-     -s, --show-versions   Show current and preferred versions of all recipes.
-     -e, --environment     Show the global or per-recipe environment complete
-                           with information about where variables were
-                           set/changed.
-     -g, --graphviz        Save dependency tree information for the specified
-                           targets in the dot syntax.
-     -I EXTRA_ASSUME_PROVIDED, --ignore-deps=EXTRA_ASSUME_PROVIDED
-                           Assume these dependencies don't exist and are already
-                           provided (equivalent to ASSUME_PROVIDED). Useful to
-                           make dependency graphs more appealing
-     -l DEBUG_DOMAINS, --log-domains=DEBUG_DOMAINS
-                           Show debug logging for the specified logging domains
-     -P, --profile         Profile the command and save reports.
-     -u UI, --ui=UI        The user interface to use (knotty, ncurses, taskexp or
-                           teamcity - default knotty).
-     --token=XMLRPCTOKEN   Specify the connection token to be used when
-                           connecting to a remote server.
-     --revisions-changed   Set the exit code depending on whether upstream
-                           floating revisions have changed or not.
-     --server-only         Run bitbake without a UI, only starting a server
-                           (cooker) process.
-     -B BIND, --bind=BIND  The name/address for the bitbake xmlrpc server to bind
+     -w WRITEEVENTLOG, --write-log WRITEEVENTLOG
+                           Writes the event log of the build to a bitbake event
+                           json file. Use '' (empty string) to assign the name
+                           automatically.
+   
+   Server options:
+     -B BIND, --bind BIND  The name/address for the bitbake xmlrpc server to bind
                            to.
-     -T SERVER_TIMEOUT, --idle-timeout=SERVER_TIMEOUT
+     -T SERVER_TIMEOUT, --idle-timeout SERVER_TIMEOUT
                            Set timeout to unload bitbake server due to
                            inactivity, set to -1 means no unload, default:
                            Environment variable BB_SERVER_TIMEOUT.
-     --no-setscene         Do not run any setscene tasks. sstate will be ignored
-                           and everything needed, built.
-     --skip-setscene       Skip setscene tasks if they would be executed. Tasks
-                           previously restored from sstate will be kept, unlike
-                           --no-setscene
-     --setscene-only       Only run setscene tasks, don't run any real tasks.
-     --remote-server=REMOTE_SERVER
+     --remote-server REMOTE_SERVER
                            Connect to the specified server.
      -m, --kill-server     Terminate any running bitbake server.
+     --token XMLRPCTOKEN   Specify the connection token to be used when
+                           connecting to a remote server.
      --observe-only        Connect to a server as an observing-only client.
      --status-only         Check the status of the remote bitbake server.
-     -w WRITEEVENTLOG, --write-log=WRITEEVENTLOG
-                           Writes the event log of the build to a bitbake event
-                           json file. Use '' (empty string) to assign the name
-                           automatically.
-     --runall=RUNALL       Run the specified task for any recipe in the taskgraph
-                           of the specified target (even if it wouldn't otherwise
-                           have run).
-     --runonly=RUNONLY     Run only the specified task within the taskgraph of
-                           the specified targets (and any task dependencies those
-                           tasks may have).
+     --server-only         Run bitbake without a UI, only starting a server
+                           (cooker) process.
+   
+   Configuration options:
+     -r PREFILE, --read PREFILE
+                           Read the specified file before bitbake.conf.
+     -R POSTFILE, --postread POSTFILE
+                           Read the specified file after bitbake.conf.
+     -I EXTRA_ASSUME_PROVIDED, --ignore-deps EXTRA_ASSUME_PROVIDED
+                           Assume these dependencies don't exist and are already
+                           provided (equivalent to ASSUME_PROVIDED). Useful to
+                           make dependency graphs more appealing.
 
 .. _bitbake-examples:
 

