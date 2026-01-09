Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A3D1A627
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 13:20:18 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9819.1767964816334836372
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 05:20:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OJJscVSf;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3136328f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767964814; x=1768569614; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l38EmLbEs/q+pJtj4FX5IOhTWDuJ3EOLPFjZG4IX070=;
        b=OJJscVSfrQ1d+C9lMqagP/zLTdI7/OIQELNO5I1vw+IT32SS1bl7LcggY30D25pICd
         9NeO2DcZhJxnKMj1M3R+OX06IIvsfYXpl2K4/y4YUL33Wqta/dINcLDFhF628lHNBW/9
         wqaVfrNRgy5pwR4fqDlV+Oh8hM65XnPlnNse9LeEx5V3tKsJRnM4zYTAZgIAs57Q+hPs
         1I00wolou+7l38FQdaT5sf2FkF+8tkC0mwsx3GUZrCwbrT0gGBBgkutkCsP7vLK4VODw
         MPkd/dqbKXSprKx8uRza+Hj3O9GGLukhj2xhLnB0IxnwhJ2BsvHzbUnsbzxJB+TH2pC5
         lIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964814; x=1768569614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l38EmLbEs/q+pJtj4FX5IOhTWDuJ3EOLPFjZG4IX070=;
        b=JdC3r1ldWRsrcBxSDaINF4+bMZT4CFQf6dCf5puBU7uvGfXJ2EjNZUE4fWVhFqynQg
         0moM9gOYPzHUu913R3pE3dv/d2WtIwpDjk6DQLTbIHtr4L924SZIJ4VNJq7c9E2Uwe50
         NlMo4SxP1jGs+lbvCPJQ2qnUylrc5d1lqS+Ypb2FlJXlLHmh2w5z1VNXCxO6iNc5PvEl
         p7Icno6ChkZ+qRCK01hZdLWWWKgLKQyS1s5llvyRd6APhw0/hDCmyrAOKfvqhIZVTlG9
         2j7ATtDJ+eO3wn95p8TR/ph0CDB5iy91jpcchwOqrJBENLUdqwyYR1O5TrozTE0uM+Qy
         e4HQ==
X-Gm-Message-State: AOJu0Yxrwn9RMgGysSJcxBNTqOkJQDOwfjF2q8jmvD7/CuuYbqKRUqsU
	OnftlsuGvxLeGUZCLa6SpTDMH0HsOhcekaASHbADPJSMFc4DqaGUyc+HkiCL1Q==
X-Gm-Gg: AY/fxX78GwhGv2b4htzxmdCbXGUjY0yCJ3LgF/gxoNdl8jWHBb4GKtnF7J8YgOsGppH
	fN5oAPheLMNbFDkWPTY+UyonJO4uNlF7ijznbv3wDm5W1a+B/asp/BWfGEeeSyCrHOAC1fWn4Lg
	L0AN9Y7Gix7PWUFAJLraGIhc2VV4O//8IZaDvzKIkW0RP1jozcuTaJNqOQ6uADbU+qJ45n7rIoL
	gZiGmTCB+97ytfo70JO2HV4E9FXI9GoBfMJudGUPtNForcBwxMGvm04hOJTupaA4qvzAgeiLba8
	6zQhLY9mG5QeEcGoro44WCQ9OYYCEd2mNxxUs7+jh0tdTGBRF2waO2p3O9EUHFTrnGrSSzvpZE6
	Bk+pMs4mQdx+IyKeXAyHEyliDFsHv2K3X7m8r4s4+sg2p3mQZClq4rS4d9o/mP3tbI/0KdaaANo
	ty/v1bJN/d3hDr2LSbTtwk0i5SorWMCaeh7JMDQBHp91TtJ5c=
X-Google-Smtp-Source: AGHT+IGrSagSKiCIRb0Cmgu3zUd8kehei5FVFpq+DWMFEFBR3lANreQ5lPVDUW5Gdq8UxoyMqOW+3A==
X-Received: by 2002:a05:600c:4ed1:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-47d84b54031mr112401295e9.33.1767964809835;
        Fri, 09 Jan 2026 05:20:09 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm202291505e9.5.2026.01.09.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:20:08 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/5] bitbake-setup: correct several scenarios in layer updates
Date: Fri,  9 Jan 2026 14:19:59 +0100
Message-ID: <20260109132000.2372791-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109132000.2372791-1-alex.kanavin@gmail.com>
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 13:20:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18727

From: Alexander Kanavin <alex@linutronix.de>

There were untested scenarios in layer updates which did not work properly.

The most serious of them is updating a remote layer which had user-made local
modifications (e.g. newly made local commits or edited files
without a commit). Bitbake-setup relies on git fetcher's unpack operation
which simply wipes it all out. Yes, the user should've used -L option
to symlink a local clone from elsewhere; this advice doesn't help when their
work is gone.

To address this, a git hook is added that prevents making commits in checkouts
under layers/ that are managed by bitbake-setup. The hook directs users to clone
the layer they'd like to modify separately and then use 'init -L' option.

(note: later on this workflow can be streamlined by converting parts of an existing
setup to local sources, or perhaps ability to 'detach' parts of layers/ from
bitbake-setup's modifications, so that it's not necessary to do a full re-init).

This still does not cover local modifications without making commits, so there's
also a function that checks if such modifications have been
made, and a code that moves the layer into a backup location if the function
returns true. I considered asking the user what to do (similar to bitbake
config handling), but this would've resulted in a half-updated, possibly
broken layer set which ultimately just would be more confusing.

The local modification check is a part of a broader newly added logic block
that handles already existing sources, and in particular addresses yet another
issue: when a local source replaces a git remote or another local source, this
scenario failed with 'file exists' errors (thanks to Anibal Limon for spotting
that). In this case the original symlink is removed first. If the original is a
git checkout, it is backed up if there are local modifications, or simply removed
otherwise.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 93c11bd09..abe7614c8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -104,7 +104,7 @@ def add_unique_timestamp_to_path(path):
                 break
     return path_unique
 
-def checkout_layers(layers, layerdir, d):
+def checkout_layers(layers, confdir, layerdir, d):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
@@ -128,6 +128,31 @@ def checkout_layers(layers, layerdir, d):
         logger.plain("Making a symbolic link {} pointing to {}".format(dst, src))
         os.symlink(src, dst)
 
+    def _has_local_modifications(r_name, r_path):
+        fixed_revisions = json.load(open(os.path.join(confdir, "sources-fixed-revisions.json")))
+        rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
+        status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
+        if status:
+            return True
+        diff = bb.process.run('git -C {} diff {}'.format(r_path, rev))[0]
+        if diff:
+            return True
+        return False
+
+    def _restrict_commits(r_name, r_path):
+        hook_path = os.path.join(r_path, '.git', 'hooks', 'pre-commit')
+        restrict_hook = """#!/bin/sh
+echo "This repository is managed by bitbake-setup, and making commits is restricted.
+If you wish to make local modifications, clone it separately, and re-initialize using
+bitbake-setup init -L {} /path/to/repo/checkout"
+exit 1
+""".format(r_name)
+        with open(hook_path, 'w') as f:
+            f.write(restrict_hook)
+        import stat
+        st = os.stat(hook_path)
+        os.chmod(hook_path, st.st_mode | stat.S_IEXEC)
+
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
     oesetupbuild = None
@@ -141,10 +166,26 @@ def checkout_layers(layers, layerdir, d):
         r_local = r_data.get('local')
         if r_remote and r_local:
             raise Exception("Source {} contains both git-remote and local properties.".format(r_name))
+
+        repodir_path = os.path.join(layerdir, repodir)
+        if os.path.lexists(repodir_path):
+            if os.path.islink(repodir_path):
+                os.remove(repodir_path)
+            elif _has_local_modifications(r_name, repodir_path):
+                backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
+                logger.warning("""Source {} in {} contains local modifications. Renaming to {} to preserve them.
+For local development work it is recommended to clone the needed layers separately and re-initialize using -L option:
+bitbake-setup init -L {} /path/to/repo/checkout""".format(
+                    r_name, repodir_path, backup_path, r_name))
+                os.rename(repodir_path, backup_path)
+            else:
+                shutil.rmtree(repodir_path)
+
         if r_remote:
             _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
+            _restrict_commits(r_name, repodir_path)
         if r_local:
-            _symlink_local(os.path.expanduser(r_local["path"]), os.path.join(layerdir,repodir))
+            _symlink_local(os.path.expanduser(r_local["path"]), repodir_path)
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
@@ -354,7 +395,7 @@ def merge_overrides_into_sources(sources, overrides):
 
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
     layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
-    sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
+    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
-- 
2.47.3


