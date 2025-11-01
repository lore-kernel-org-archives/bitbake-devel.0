Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2851CCFA05
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:55:20 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5822.1762005417264429466
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Nov 2025 06:56:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jb5F52HK;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bcb25so1769780f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Nov 2025 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762005415; x=1762610215; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JRw9oWeLCx2Uq2gHDYhtsnXqTFf22JShTdwaKALnf4=;
        b=jb5F52HKiSK2D6PQYGks/AADEBFNJfd5JfcmsnPH7bKd29UvnmY2SXciZL/C3E+fzd
         mTAMnxPMvphDuPyE+pJkMkoHCYIQRNi/1D4kmNMX+9RJQEGhLkDLzRj4Y10qg5FfLLIV
         90MafpJL5subrgjKbERne+Eia6x3TEHuUQtNdxygvuVpOTuNd5mTajwKCppavrt0aVHD
         YXlj+1dFclxqbkb5VJO7knsIcF+Ol4rTwboSuneg2s4bazVVKPF/7ZTR78qROZtLBhXd
         /AsbOqrpMB2ziFyw8cGU8ZmUZ964H5qbszprhX1Bs2bCTupafkcR54IQFXSz1aLlWqV3
         uv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762005415; x=1762610215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JRw9oWeLCx2Uq2gHDYhtsnXqTFf22JShTdwaKALnf4=;
        b=aRbXa74Mq5qdw8CxZn24nyDu2njcpa4fiLs6TCEwQkUi3t60CtyetjX2H0qjiXVn9q
         rlBQNmTy2u/4Ddy34lw9gfJXJZ24OgkVS7hjCD5aYeIgZSxcgFldO8gDX+z2KRDgusE9
         XlaaRUr3sfegkx9Kr30qJ1Pm3c5Bxgtdx+m/AJTPCHEc3Alb5nwonk+bZLsY1oUOrPi6
         tuWUuwszI6NETCilbhaCOtonPoHgwcOY8wNWkx/aJLtX78XeCr6VGfC9IDfz8r9MuiCk
         FpaN99HYh+H0b0XWKeHz3jQ58UblFx04r33N3HQNRFwJZ+uy6wboS6xE/b7HVsbSVkYz
         v/ig==
X-Gm-Message-State: AOJu0YxUzNXynKRcOU2YFytxTZhxcEl6t0ToZV/x4+TmG/D7NdonWo6A
	isnN4EXKDuy2DfzZKXNbMblqmUUL1ss4JUGgvDo5Vne5ScUBS3EgpWyb03G8xno9
X-Gm-Gg: ASbGncuDXUuNPfTquTfyz7Y810lqtzqh+ovWV7NrQ6XZ6gS7Zi7Nb9O3fw09b0Z/Gfy
	EI0A7uadMTd5Zf5RdPeEGbkgZyuKTBK5E5+kQsW4P+Vxtv356MKjSo+981YUUYny/s8wzioiz1Q
	JAzGLJoPpwsbUf3ziKk5H6UGJRj1nJphRZmrKl32QSulk82eVgzbijd6/z0W35S4URTPDj1Y1HA
	xriqmuIVnu9kuG1Et0kiOq0+Gp6PEAiKbMxMeqGjIZyIDt/rvQ0JllonFCzXH+aTE+QFsh8PlT/
	O2fC9YsmCQpcy1cEp4cZra/qIj1iAGJyVjdbf+VIu4ocakNskAEYxG5/szo9gCoegoBd/4UiHx4
	nZv2HZ0XeH3rK3fBUMxIbxZCbtYWrUAbrv3tCewPnIs7uRAWTn7Z0C/WSf5EWzsEHftcSVLlHVT
	0I5VA=
X-Google-Smtp-Source: AGHT+IGkpPHOOIrkuLcojwn/UVG0W8/+NR7M8CXArc0ER4FNxSre7iHQwJMx/3AsxARpmMf3NmatPQ==
X-Received: by 2002:a05:6000:4305:b0:3ec:dd12:54d3 with SMTP id ffacd0b85a97d-429bd6a4c41mr5322566f8f.35.1762005415307;
        Sat, 01 Nov 2025 06:56:55 -0700 (PDT)
Received: from osama.. ([197.46.180.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f192fsm9040007f8f.38.2025.11.01.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:56:54 -0700 (PDT)
From: "Osama Abdelkader" <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] bitbake-layers: layerindex-fetch: respect --branch for already-configured layers
Date: Sat,  1 Nov 2025 15:56:51 +0200
Message-ID: <20251101135651.26560-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 11:55:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18236

[YOCTO #7852]

The layerindex-fetch command has two issues when --branch is specified:

1. If a layer is already in bblayers.conf, the command exits early with
   "You already have the requested layer(s)" without checking if the
   layer is on the requested branch.

2. For layers in bblayers.conf (cooker layers), the branch checking code
   added in commit 138dd7883ee (2022) never executes because cooker layers
   are skipped entirely in the fetch loop.

This patch fixes both issues by:

- Preventing the early exit (fast path) when --branch is specified, forcing
  branch verification even for already-configured layers.

- Adding branch check/switch logic for cooker layers when --branch is
  specified. The code finds each layer's git repository and calls
  get_fetch_layer() with the requested branch to perform the validation
  and checkout if needed.

- Fixing the branch detection in get_fetch_layer() to use
  'git rev-parse --abbrev-ref HEAD' instead of parsing 'git branch' output.

- Fixing undefined 'stderr' variable (should be 'completed_proc.stderr').

This completes the fix started in commit 138dd7883ee, allowing users to
use --branch to switch already-configured layers to different branches.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 bitbake/lib/bblayers/layerindex.py | 51 ++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
index ba91fac669..72d2eb8fb7 100644
--- a/bitbake/lib/bblayers/layerindex.py
+++ b/bitbake/lib/bblayers/layerindex.py
@@ -55,13 +55,15 @@ class LayerIndexPlugin(ActionPlugin):
             switching branches if necessary and possible.
             """
             base_cmd = ['git', '--git-dir=%s/.git' % repodir, '--work-tree=%s' % repodir]
-            cmd = base_cmd + ['branch']
+            # Get current branch name
+            cmd = base_cmd + ['rev-parse', '--abbrev-ref', 'HEAD']
             completed_proc = subprocess.run(cmd, text=True, capture_output=True)
             if completed_proc.returncode:
-                logger.error("Unable to validate repo %s (%s)" % (repodir, stderr))
+                logger.error("Unable to validate repo %s (%s)" % (repodir, completed_proc.stderr))
                 return None, None, None
             else:
-                if branch != completed_proc.stdout[2:-1]:
+                current_branch = completed_proc.stdout.strip()
+                if branch != current_branch:
                     cmd = base_cmd + ['status', '--short']
                     completed_proc = subprocess.run(cmd, text=True, capture_output=True)
                     if completed_proc.stdout.count('\n') != 0:
@@ -118,7 +120,8 @@ class LayerIndexPlugin(ActionPlugin):
 
         # Fast path, check if we already have what has been requested!
         (dependencies, invalidnames) = cookerIndex.find_dependencies(names=args.layername, ignores=ignore_layers)
-        if not args.show_only and not invalidnames:
+        if not args.show_only and not invalidnames and not args.branch:
+            # Only skip if no specific branch was requested
             logger.plain("You already have the requested layer(s): %s" % args.layername)
             return 0
 
@@ -202,8 +205,44 @@ class LayerIndexPlugin(ActionPlugin):
             for deplayerbranch in dependencies:
                 layerBranch = dependencies[deplayerbranch][0]
 
-                if layerBranch.index.config['TYPE'] == 'cooker':
-                    # Anything loaded via cooker is already local, skip it
+                is_cooker_layer = layerBranch.index.config['TYPE'] == 'cooker'
+
+                if is_cooker_layer:
+                    # Anything loaded via cooker is already local
+                    # If a branch was specified, we still need to check/switch branches
+                    if args.branch:
+                        # Map collection names to layer paths (same as cooker plugin does)
+                        layerconfs = self.tinfoil.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS')
+                        bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
+
+                        # Get the layer path for this cooker layer's collection
+                        collection_name = layerBranch.collection
+                        if collection_name in bbfile_collections:
+                            bblayer = bbfile_collections[collection_name]
+                            if os.path.exists(bblayer):
+                                try:
+                                    # Find the git repository root
+                                    gitdir_cmd = ['git', '-C', bblayer, 'rev-parse', '--show-toplevel']
+                                    result = subprocess.run(gitdir_cmd, capture_output=True, text=True)
+                                    if result.returncode == 0:
+                                        repo_root = result.stdout.strip()
+                                        # Get the subdir relative to repo root
+                                        rel_subdir = os.path.relpath(bblayer, repo_root) if bblayer != repo_root else ''
+                                        # Get parent dir of repo as fetchdir
+                                        parent_fetchdir = os.path.dirname(repo_root)
+                                        # Now call get_fetch_layer to check/switch branch
+                                        # Use args.branch (the requested branch) not layerBranch.actual_branch (current branch)
+                                        _, name, _ = self.get_fetch_layer(parent_fetchdir,
+                                                                          layerBranch.layer.vcs_url,
+                                                                          rel_subdir,
+                                                                          not args.show_only,
+                                                                          args.branch,
+                                                                          args.shallow)
+                                        if not name:
+                                            # Error during branch check/switch
+                                            return 1
+                                except subprocess.SubprocessError:
+                                    pass  # Not a git repo, skip
                     continue
 
                 subdir, name, layerdir = self.get_fetch_layer(fetchdir,
-- 
2.43.0


