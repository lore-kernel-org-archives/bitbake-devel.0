Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216B8D59D8D
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 19:09:03 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1133.1765566535153013310
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 11:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BiDbdC2S;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so2852331a12.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765566533; x=1766171333; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph+daK79Ou00YTwOHIZNnlYG48ho0QoebMiBDmEhzPM=;
        b=BiDbdC2S8Qg/HdwffpVuZaLwT01xoDVgpLF2kq9NPauaVFGIDigkeixU10mOazhdGN
         WoIb0xvzbIiUdFdWkQWai70rgbB2aTptu6guGZtRP97df1c0eUwBPSR4tEcXsMWs3c47
         0PPxVAJiKlxJinP5r5Y8fL7xz9THwl8G8U8yXNm9k2PcyuM3b/XIEgSPpckkdenRI37X
         R+IXJVsYO8zrw5ZyxConZVPZNvaAHDXjHWQ0FNkwQ/myriff36HJLvjuYrIhIPTzKTyj
         PURYzuVJf/1XH///f4Ffw4bltWn69zI6anmVu8nO9N3hSmVsyS5K2X3wHxBfpJoeMSAx
         MutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765566533; x=1766171333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ph+daK79Ou00YTwOHIZNnlYG48ho0QoebMiBDmEhzPM=;
        b=oavaIUuowvkPkhinzD/QLGL+hQ4JGLKeuzftwuFzbx29TIx0jHMzF7je+gU7gQoig7
         E6xrCe2rqTsqNkJLcXI7kHNHUcNuuON2qAQ0TWYav0haQXWY/Dv6YBfiJ+JDPkTaHdfH
         WiB9kz7CJHgnOCzWc6+zZ7808pqz/3BImmyqdrYoTb1H2loA4bdQcAK3wuLVbTaDJus5
         uBVsAVOS/dlrR8x2H5SDYVX8LgQ1zOX6g9S+ruznQjzr05kwuZOVwy/uTmkMrMJsfPSv
         XiybYcGuDvf8kqE6XQeT4p2iWdQg6o/6epxiax1WxGAOp2vSfnFubZoZec6r4k9YIjzZ
         B11w==
X-Gm-Message-State: AOJu0YzzXI2qQ+nopd09blQnEWCGF6YCsPyys7NIIQ2es6/NpCLayLmf
	KF1XoNnrGT9ffLIFiduTxrZ/zvuJFEFj5Ndonl8XyMtbquL4PzD8Mx3YQPC4iw==
X-Gm-Gg: AY/fxX4HMdR/p7jVESWzmtfF9dUtTDgmeFGjv/vyX93ha4vI8dW9jFbZFMf2f62EZcx
	jXiaHSb+vS2jr4knvrbQ50OOiyLxh0x6RBOh5wg82p6tedi2KDf76TodXMM6rjQEoj6dl1cbssc
	kZKu3uxAfYpRXGwUB2bRuItqkMsFNV1uqp5hN8/4LDEr+p1brxXNBQGLVw1KcGNK1Y7RrNp5xDx
	7jnRJ0KNPebriVnGgk1iRbDO2j6Z5j7dcdmQ9vG1DhcGrzjPhgdaJ7i7FsFscYhmpeIbvKDvGJ7
	CIZjOESupq+by1k1FEJ2NmqZaIijMbpw7ffBggq8EPvWQgCF9UxDsrvW5sfI1UjVAdyfjkIFxRz
	PMD5si+GYAGVVGxEqg5WwdXQ/Ia6Z9QpfBQEwusmtxHUO7fdg4ATiRC1siP8jpNKamn8VN5snzR
	G9m2ezOjtTyGmeNwPcS501jPcAOQ==
X-Google-Smtp-Source: AGHT+IEcgRGq/HVyvdLB5U9AJt1Moc3vmx4zXLNF8UUH/xvhSbtuHw1vp0x7O+7c8lJHl7K8uWihGw==
X-Received: by 2002:a05:6402:5194:b0:649:2336:deed with SMTP id 4fb4d7f45d1cf-6499b1cc740mr3155054a12.16.1765566533395;
        Fri, 12 Dec 2025 11:08:53 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:1401:37b6:6a29:b0c5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210de23sm6147003a12.28.2025.12.12.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:08:51 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 4/4] bitbake-layers: layerindex-fetch: Add branch check/switch for cooker layers
Date: Fri, 12 Dec 2025 20:08:06 +0100
Message-ID: <20251212190806.32476-5-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212190806.32476-1-osama.abdelkader@gmail.com>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 19:09:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18583

For layers already in bblayers.conf (cooker layers), add logic to check
and switch branches when --branch is specified. Previously, cooker layers
were skipped entirely in the fetch loop, so branch checking never executed.

The code finds each layer's git repository root, determines the subdirectory
relative to the repo root, and calls get_fetch_layer() with the requested
branch to perform validation and checkout if needed.

This completes the fix started in previous commit, allowing users to
use --branch to switch already-configured layers to different branches.

[YOCTO #7852]

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 lib/bblayers/layerindex.py | 40 ++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index e0df630a7f..72d2eb8fb7 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -205,8 +205,44 @@ class LayerIndexPlugin(ActionPlugin):
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


