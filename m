Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF1DD3F2A6
	for <webhook@archiver.kernel.org>; Fri, 18 Oct 2024 21:36:44 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.32957.1729287396967825631
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Oct 2024 14:36:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=frMLSEsL;
 spf=pass (domain: smile.fr, ip: 209.85.221.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so856498f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 18 Oct 2024 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1729287395; x=1729892195; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwGmYEUygvD9/+dmc5JK0o6I9+kt3L9y7PenUvhO9bA=;
        b=frMLSEsLaz37kEshVOeTonAGrnQaQHA+xpuf445OdE6c4XT+Yuhf4JODcODGlYYTZw
         RAU+oJehsapogfkt7VoE+Mpuc+Dz7kB13hI069HhwbiQpnUz0O9hsJv4ImL22WCuTF8m
         wL+eodv+cA3pkTPypKxLqUFzgQBbu3N4jYdfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287395; x=1729892195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwGmYEUygvD9/+dmc5JK0o6I9+kt3L9y7PenUvhO9bA=;
        b=BOY3+RwNfLhqxahtlSpT68hVXocA+77EG9xN6n/tEHGsDRhmypnjxCCjHBW9Ily7Xd
         A3qm4GxG1mlEBTorbvHyRqIdtgkMmK6OiVg009GY39MAxVanzx1i/MCB4wWRFPBiUf0I
         6MGFdo2cjH4CGC6I/MHGIunIEfDgJJwjVs2SwQHtPCvMCd68XkPnK39P1c4TwKO85q+8
         r48dBOgd7VLB8dyrWQJWNTDI8WLjY1GB0ZHdkx3LueFfPOsAFPNDxEZPBResycFJtRrx
         fWYdFPOHGbXGsL+cmuWrBMshKyW3rnElL4uAIN+ljZNwSItDAC04GW6VWAF8mjomdcgk
         q0/w==
X-Gm-Message-State: AOJu0YwR/w5sidQIPAypaJJmAswMwrUuVb/CDVjXW85y9nsdgubdcc0D
	ee70Q/QxRFAnMM8B+Up53ORod7dYjZsA/5X8PD1i7AEqoDr9VYINn2CjuBQ/zON35hBjAEameGo
	f
X-Google-Smtp-Source: AGHT+IFIBZE6EK/W+dzpApSZCeeuTX1dalr5effNSHYtwve0o5XIUu+LeRd0MEn2gc8Paq+UeUbnEQ==
X-Received: by 2002:adf:e70c:0:b0:37d:4846:3d29 with SMTP id ffacd0b85a97d-37ea2198725mr2838892f8f.28.1729287394930;
        Fri, 18 Oct 2024 14:36:34 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027c77sm2860728f8f.21.2024.10.18.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:36:34 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Yoann Congal <yoann.congal@smile.fr>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2] doc/user-manual: Refresh help output
Date: Fri, 18 Oct 2024 23:36:26 +0200
Message-Id: <20241018213626.2102737-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Oct 2024 21:36:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16691

From: Yoann Congal <yoann.congal@smile.fr>

In commit 9257c48c3e36 ("Group and reorder options in bitbake help"),
help output was changed, update the doc to match the new output.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v1->v2: Review from Quentin Schulz
 * Add Reviewed-By
 * Add a comment with the command that generated the output
 * whitespace cleanup
---
 .../bitbake-user-manual-intro.rst             | 174 ++++++++++--------
 1 file changed, 100 insertions(+), 74 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 35ffb88b0..539bb62d8 100644
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
@@ -392,65 +436,47 @@ Following is the usage and syntax for BitBake::
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
+
+..
+    Bitbake help output generated with "stty columns 80; bin/bitbake -h"
 
 .. _bitbake-examples:
 

