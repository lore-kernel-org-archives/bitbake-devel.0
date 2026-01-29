Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36026D6100C
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 12:04:37 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13185.1769688268138790150
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jan 2026 04:04:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XUWsLjG+;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305914so893637f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 04:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769688266; x=1770293066; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLDlf5CELV31ncNl8r8OduqP1mS8Qm67x4WnQg4CXus=;
        b=XUWsLjG+XWiOOle16m9+okBD4xwd+6/h6wwkWQ84y+Hc+1HvFmdwkBBIXGuY9KiSQy
         VYKl4AzBYRACdxhxKRRg3z333KDtgr2FYknE/zPKdWusTzqwhr/47F5hjh8x+zZgeDwQ
         1fdfTzjA7mL8t24/xsP1YSfSDDyKWKT7YdRoLH7aIVpGfKTYI7O9BLJtN4A/IIz46nKb
         wxZRNJ8pM34N/9eDGld5fNCVcyqHgvL51d4LhXmoLCfkVrHyZMfAAuGc3QdQplpyZsmq
         1thUWd+T6rP0Dcm82GLrFUFFSeQ1Tw4xyqrnPCenozqWlX7/nZYC2s5+Dzfj79uUtBWs
         itjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688266; x=1770293066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLDlf5CELV31ncNl8r8OduqP1mS8Qm67x4WnQg4CXus=;
        b=ORzGBHkmvxn3wy8HrSBeJsugOb6qTZG8dgFwRMXdTYhr9AGwEZtmTGWHKH7zfaquxQ
         oXAlGgiVbPDCLgJP+wop+ffKzsZVawJY4OoUmBkDrMuxki21PAzYlsNCDuoQ1M7A+bAG
         f6n/yakCmZ2nhxRFRrhjH7gkZtKIwZideKLnG3Pj3mXbar1oSs/ybwvGVKpJLw8lieVa
         8hyHhuJ6dWycg7u2Fwqa87sEQlY6xwmLHTqGo1LwCv9ny33meWbJv1994wxUVNg0lJA9
         ouKDw4UKHE+ILthYM47SVVFfByQ69Jffg02cX8eMoQUfOdAB9WppSq9Ks2fimn+CRRzP
         nRrQ==
X-Gm-Message-State: AOJu0YxebSPidmntvdmWUwQxmg37tp9ygQBSNdV1wTP057+z7Ek4v+yK
	xJttEn5soLAixXS/nYjACCqkaQlOeLMCJPzwkdZooYk3Vzwy8vk99pg+ltTZXw==
X-Gm-Gg: AZuq6aKUbr+L8uK8ZyQ9EpFnrmTSZGRKODsh7cAKBK0cd0l/oijSrVZ7LZVv8GCC0fl
	xL/SSsyUkD2mr2rZnQappidAqGBRX0SUoxjPmM8SspollxjokwzY8EcEjAcIU2101W/0tkYUkbf
	LcL0T+IWt8fiV/1QJwRjOh/yrjb3gwFFqbvLQbJ5znwD9D1i15tcJZZ91nGQb2yFOSH5ZhacR4o
	EKGqxKJ1gqovefPTFc8PvvLu9l0XW4PMIUeEqydw0bmn5+SQ7dZ1ki6wWfSP7hhWgbFELhAj65K
	RYAJ7tEPngEU2wnKcY1nbZPk0sE98i7hEq+AdD/R1CmdbsNSfwwFIpj77BnEEyqILmaM/D5Rz65
	riKO1uFPmr/4+/AtBPir4rEnmbKj0UOFeHw14NTseqP7jzxLxSvUcfk7cOk78l/DCOhAeGqpl6G
	54qAD8vLZsCRvu5b2GRzpU3secc/Hv9QEh52WL05Dt48QwZIM=
X-Received: by 2002:a05:6000:2511:b0:435:a464:f468 with SMTP id ffacd0b85a97d-435dd1cd4ffmr12076261f8f.47.1769688266343;
        Thu, 29 Jan 2026 04:04:26 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354114sm15143594f8f.42.2026.01.29.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 04:04:26 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v3 2/2] bitbake-setup: share sstate by default between builds
Date: Thu, 29 Jan 2026 13:04:21 +0100
Message-ID: <20260129120421.4413-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129120421.4413-1-alex.kanavin@gmail.com>
References: <20260129120421.4413-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 12:04:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18934

From: Alexander Kanavin <alex@linutronix.de>

Nowadays sharing sstate must also include sharing the hash equivalency
information and thus, managing a hash equivalency server. There are
two ways to do it:

- starting/stopping the server outside the bitbake invocations, and
guaranteeing that it's available when bitbake is invoked.

- using bitbake's built-in start/stop code which launches a server
before a build starts and stops it when a build is finished; essentially
this is a private server, using a database private to a build directory
(by default).

I couldn't come up with a good way to do the first option in bitbake-setup:
it needs to be invisible to users, they should not have to run special commands
and they should not wonder why there is a mysterious background process.
It's not impossible to auto-start a shared server, but that will quickly
run into synchronization issues: if one server is being started, another
should not be started at the same time. If one server is shutting down
(e.g. after an inactivity timeout), another starting server should wait
until it frees the socket, and block all bitbake invocations on that.
Memory resident bitbake does this in lib/bb/server/process.py with a lot of
complexity, and I don't think it should be added to the hash server as well.

On the other hand, hash equivalency database is sqlite-driven, and sqlite
documentation reassures that sharing it between different simultaneous
processes is okay: nothing will get lost or corrupted: https://sqlite.org/faq.html#q5

I've confirmed this by running simultaneous builds that way: nothing
unusual happened, and sstate was shared as it's supposed to.

There's a new setting that turns off this behavior for situations
where the server and sstate are managed externally.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
v2: use ?= (weak assignments) for sstate variables to make it easier
to override them in particular builds, set hashserve db location
from value of SSTATE_DIR, rather than as direct value.

v3: use {{ }} to avoid brace-based format string expansion in python
and include literal braces instead.
---
 bin/bitbake-setup                             | 28 ++++++++++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 19 +++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7f6ea550c..f45cc8885 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -838,6 +838,31 @@ def create_siteconf(top_dir, non_interactive, settings):
 
         os.makedirs(top_dir, exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
+            sstate_settings = textwrap.dedent(
+                """
+                #
+                # Where to place shared-state files
+                #
+                # BitBake has the capability to accelerate builds based on previously built output.
+                # This is done using "shared state" files which can be thought of as cache objects
+                # and this option determines where those files are placed.
+                #
+                # You can wipe out TMPDIR leaving this directory intact and the build would regenerate
+                # from these files if no changes were made to the configuration. If changes were made
+                # to the configuration, only shared state files where the state was still valid would
+                # be used (done using checksums).
+                SSTATE_DIR ?= "{sstate_dir}"
+                #
+                # Hash Equivalence database location
+                #
+                # Hash equivalence improves reuse of sstate by detecting when a given sstate
+                # artifact can be reused as equivalent, even if the current task hash doesn't
+                # match the one that generated the artifact. This variable controls where the
+                # Hash Equivalence database ("hashserv.db") is stored and can be shared between
+                # concurrent builds.
+                BB_HASHSERVE_DB_DIR ?= "${{SSTATE_DIR}}"
+                """.format(sstate_dir=os.path.join(top_dir, ".sstate-cache"))
+            )
             siteconffile.write(
                 textwrap.dedent(
                     """\
@@ -855,7 +880,7 @@ def create_siteconf(top_dir, non_interactive, settings):
                     """.format(
                         dl_dir=settings["default"]["dl-dir"],
                     )
-                )
+                ) + (sstate_settings if settings["default"]["common-sstate"] == 'yes' else "")
             )
 
 
@@ -1061,6 +1086,7 @@ def main():
                          'top-dir-name':'bitbake-builds',
                          'registry':default_registry,
                          'use-full-setup-dir-name':'no',
+                         'common-sstate':'yes',
                          }
 
         global_settings = load_settings(global_settings_path(args))
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 3b6a73fd8..b7212f1af 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -517,6 +517,7 @@ A valid settings file would for example be:
    registry = /path/to/bitbake/default-registry
    dl-dir = /path/to/bitbake-setup-downloads
    use-full-setup-dir-name = yes
+   common-sstate = yes
 
 Settings and their values can be listed and modified with the ``bitbake-setup
 settings`` command. See the :ref:`ref-bbsetup-command-settings` section for
@@ -621,6 +622,24 @@ will override the suggestions for the :term:`Setup` directory name made by
 will make the directory names longer, but fully specific: they will contain
 all selections made during initialization.
 
+.. _ref-bbsetup-setting-common-sstate:
+
+``common-sstate``
+-----------------
+
+When this setting is set to ``yes`` (which is also the default), bitbake-setup will
+set up a common sstate directory and common hash equivalency database for all the
+:term:`setups <Setup>` in a :term:`Top Directory`. This is very beneficial for speeding
+up builds as build artefacts will be reused whenever possible between them.
+
+Set this to ``no`` for advanced use cases, such as placing the sstate directory on a NFS
+mount and maintaining a separate hash equivalency server, so that sstate and hash equivalency
+data can be shared between several computers. For such use cases the sstate settings need
+to be added to a build configuration separately.
+
+See https://docs.yoctoproject.org/dev-manual/hashequivserver.html for how to share sstate
+on the network.
+
 .. _ref-bbsetup-section-config-reference:
 
 Generic Configuration Files Reference
-- 
2.47.3


