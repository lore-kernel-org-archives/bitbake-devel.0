Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD105CA9ED2
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 12:14:10 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5693.1791893647838995197
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 05:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=judHLpw3;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 248B01A1202;
	Tue, 13 Oct 2026 12:14:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ECF7F60362;
	Tue, 13 Oct 2026 12:14:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2B3811D7105D;
	Tue, 13 Oct 2026 14:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791893645; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pcJ85W9j5jNJ5Ja+H32XlE877a3GQa2KGJSDBd5MWf8=;
	b=judHLpw3ZdvxVdaQ3kla1z74gXwvHF8OhXEW3NUUf0guxSRYvvndPGyPAPoqrZJDZqVMob
	S24iLuizQcYHz+yfzxBG4defW0NUdJcQVUk7/SB/mL59WnhcmtUfXCaS7Y50v1ldHnpvOE
	7CWR0kpXpaDhwlGLAcuEu991r+YLI4ZXyYUvkfwefvD0Dbh9lwkex0ZjAW+kKW3B8ka6zP
	qdybCz4dXJ2bGJQ/+QG0glnLcu6UcPbaY3U3AbErpT4toWNP1i2HzeDqNTE/9ADRTqRVe+
	XfSSfZtv1EmgkaoNbq57DYqMfzKow8DpPv5q9cL7IxPh7uvMyDPY97I9oSL5cQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 13 Oct 2026 14:13:37 +0200
Subject: [PATCH 4/4] doc/bitbake-user-manual-intro.rst: refresh bitbake's
 help message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-warn-as-errors-v1-4-ab3658758ceb@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
In-Reply-To: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6961;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=tae5mbacN8YTT0dnqeQJpmQ9y30ZC/ALYFPnKl5B85Q=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqziB0fejzayLco+myJ0ohZOENdSTBx818BhHpO
 ero8ZVDS1WJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCas4gdAAKCRDRgEFAKaOo
 NvDJEACuTRxVdmCd2Gn6O7dedAV+0IqHYM/iWQ1rMUjJLXHEq96s/4QBxs9q7B/xixXTFirbFHS
 CBwHV9B1Wuxe7QYG5gc6crtiBGWLtChP7yipuyu8r2ufbNfoWykFQLr5PLLnLKKLXK0x/pu4dO2
 DBgipz+osrZYfCZb4JATXl+TBBNlWJ3+IpfujoLfIPA7qZBjIq71l7XnhEdsQ4O1hzJ97cBiIAD
 /4Dt2HHw7CrpqDf5OpzmOqwA+JHl0J0PbqM5rZ0XfMbGQ5Gkw7YkqO6KdMjLP4IARYaW7uU0fta
 lJNGNBNLbyQokWvVxlr7IapfTk2kqAYqVlty6J/gF6J2BssvET6kDu4QIM72r3OJxdUAKWtmNsn
 tvZkB9iXDb5mcJWi1ueGRtO5jhMAOz4JIfcXCujtBZzUumt15aDOQjjhdOX874LUdJsVrJ3Lt1y
 TBSXa0LTIV6in0Ydyi2hDFV8+EWvVKYfLFrzHu1hMNjvrbNLgGKfQ3nciT9giDgz8FytWGDMLzo
 +MQ4CljHZsFNkzyMK+Id3+LEi2q0qI7jqF61vRoJwAoqK8Mt6Ns4WEzG/t0L5R3XUp9jbNJ83pZ
 DUJsQbHklN1szfTFNMFlGNSt/i3DvbBrdLDMc12460SVbKxm2fP7lpq63GJIgz6cxT6J8WIzS2L
 rbTnHg8iv7iJL0w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 12:14:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20329

Refresh the bitbake help message with all recent changes.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-intro.rst                  | 36 ++++++++++++----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 6801323e2fb..af6dfed8915 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -415,8 +415,8 @@ Following is the usage and syntax for BitBake::
    usage: bitbake [-s] [-e] [-g] [-u UI] [--version] [-h] [-f] [-c CMD]
                   [-C INVALIDATE_STAMP] [--runall RUNALL] [--runonly RUNONLY]
                   [--no-setscene] [--skip-setscene] [--setscene-only] [-n] [-p]
-                  [-k] [-P] [-S SIGNATURE_HANDLER] [--revisions-changed]
-                  [-b BUILDFILE] [-D] [-l DEBUG_DOMAINS] [-v] [-q]
+                  [-k] [-P PROFILE] [-S SIGNATURE_HANDLER] [--revisions-changed]
+                  [-b BUILDFILE] [-D] [-l DEBUG_DOMAINS] [-v] [-q] [-W]
                   [-w WRITEEVENTLOG] [-B BIND] [-T SERVER_TIMEOUT]
                   [--remote-server REMOTE_SERVER] [-m] [--token XMLRPCTOKEN]
                   [--observe-only] [--status-only] [--server-only] [-r PREFILE]
@@ -435,7 +435,7 @@ Following is the usage and syntax for BitBake::
                            set/changed.
      -g, --graphviz        Save dependency tree information for the specified
                            targets in the dot syntax.
-     -u UI, --ui UI        The user interface to use (knotty, ncurses, taskexp,
+     -u, --ui UI           The user interface to use (knotty, ncurses,
                            taskexp_ncurses or teamcity - default knotty).
      --version             Show programs version and exit.
      -h, --help            Show this help message and exit.
@@ -443,11 +443,11 @@ Following is the usage and syntax for BitBake::
    Task control options:
      -f, --force           Force the specified targets/task to run (invalidating
                            any existing stamp file).
-     -c CMD, --cmd CMD     Specify the task to execute. The exact options
+     -c, --cmd CMD         Specify the task to execute. The exact options
                            available depend on the metadata. Some examples might
                            be 'compile' or 'populate_sysroot' or 'listtasks' may
                            give a list of the tasks available.
-     -C INVALIDATE_STAMP, --clear-stamp INVALIDATE_STAMP
+     -C, --clear-stamp INVALIDATE_STAMP
                            Invalidate the stamp for the specified task such as
                            'compile' and then run the default task for the
                            specified target(s).
@@ -471,8 +471,11 @@ Following is the usage and syntax for BitBake::
                            target that failed and anything depending on it cannot
                            be built, as much as possible will be built before
                            stopping.
-     -P, --profile         Profile the command and save reports.
-     -S SIGNATURE_HANDLER, --dump-signatures SIGNATURE_HANDLER
+     -P, --profile PROFILE
+                           Profile the command and save reports. Specify 'main',
+                           'idle' or 'parsing' to indicate which bitbake code to
+                           profile.
+     -S, --dump-signatures SIGNATURE_HANDLER
                            Dump out the signature construction information, with
                            no task execution. The SIGNATURE_HANDLER parameter is
                            passed to the handler. Two common values are none and
@@ -484,7 +487,7 @@ Following is the usage and syntax for BitBake::
                            expected)
      --revisions-changed   Set the exit code depending on whether upstream
                            floating revisions have changed or not.
-     -b BUILDFILE, --buildfile BUILDFILE
+     -b, --buildfile BUILDFILE
                            Execute tasks from a specific .bb recipe directly.
                            WARNING: Does not handle any dependencies from other
                            recipes.
@@ -499,22 +502,24 @@ Following is the usage and syntax for BitBake::
                            -D only affects output to stdout. All debug messages
                            are written to ${T}/log.do_taskname, regardless of the
                            debug level.
-     -l DEBUG_DOMAINS, --log-domains DEBUG_DOMAINS
+     -l, --log-domains DEBUG_DOMAINS
                            Show debug logging for the specified logging domains.
      -v, --verbose         Enable tracing of shell tasks (with 'set -x'). Also
                            print bb.note(...) messages to stdout (in addition to
                            writing them to ${T}/log.do_<task>).
      -q, --quiet           Output less log message data to the terminal. You can
                            specify this more than once.
-     -w WRITEEVENTLOG, --write-log WRITEEVENTLOG
+     -W, --warnings-as-errors
+                           Treat warnings as errors.
+     -w, --write-log WRITEEVENTLOG
                            Writes the event log of the build to a bitbake event
                            json file. Use '' (empty string) to assign the name
                            automatically.
 
    Server options:
-     -B BIND, --bind BIND  The name/address for the bitbake xmlrpc server to bind
+     -B, --bind BIND       The name/address for the bitbake xmlrpc server to bind
                            to.
-     -T SERVER_TIMEOUT, --idle-timeout SERVER_TIMEOUT
+     -T, --idle-timeout SERVER_TIMEOUT
                            Set timeout to unload bitbake server due to
                            inactivity, set to -1 means no unload, default:
                            Environment variable BB_SERVER_TIMEOUT.
@@ -529,11 +534,10 @@ Following is the usage and syntax for BitBake::
                            (cooker) process.
 
    Configuration options:
-     -r PREFILE, --read PREFILE
-                           Read the specified file before bitbake.conf.
-     -R POSTFILE, --postread POSTFILE
+     -r, --read PREFILE    Read the specified file before bitbake.conf.
+     -R, --postread POSTFILE
                            Read the specified file after bitbake.conf.
-     -I EXTRA_ASSUME_PROVIDED, --ignore-deps EXTRA_ASSUME_PROVIDED
+     -I, --ignore-deps EXTRA_ASSUME_PROVIDED
                            Assume these dependencies don't exist and are already
                            provided (equivalent to ASSUME_PROVIDED). Useful to
                            make dependency graphs more appealing.

-- 
2.55.0


