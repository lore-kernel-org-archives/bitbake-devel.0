Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB80CCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 19:06:48 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17663.1762369606955805997
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 11:06:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=juuAKkB1;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so708969f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 11:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369605; x=1762974405; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaPcqo1cwNZKj4kdI43WPHXz75QZ7K5gQseHaOSdP1s=;
        b=juuAKkB1u6q+TWVjTGj2WM40QeqDva03l6ZydUaJ52KDW3EfpVjW96PHeA3IjhBuPO
         LuOwtfJ8rMZiKS/zNlsotWtVJQJi0WUhrmF1nJAm0bP/exAijbmCCPRpblZml6d5DqHS
         xWUYDzvJh5hk18MbVv/lbvu24zVY04TByalTmCD5qkRQi682Kfbks0saxo7jfRi3N/F9
         w6buqafDN/MdsiBCgzNipPdYVWrsA8ElANC3ekFFqBKBVTxKRR1FvAgF0s8BiN3807kj
         kuzEu39mlLHiCRsFJf0M3Ug14s8vWlACiCOtJRpmmDm/NF27MzcTwqpYBvuE1jnjhs58
         6dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369605; x=1762974405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaPcqo1cwNZKj4kdI43WPHXz75QZ7K5gQseHaOSdP1s=;
        b=eRPUzmiND1RTf7ZKRWH9C6ZvERYtPFwN7GOOVk38BIa7aRk27QraUz/vqzWqibNUO3
         zyUAKSIettLfOzVYJ5FJWxCtk9EG+1tRxKWszw2J33Ke+KfdEXSzVdzjTjWz1p8EFSOG
         BI5pHoEO9CAB3dWLVIvzr7UieDZT9wVyrB7EnofF+8RvOBnnYOITia+YCmKZNfCuNp6X
         hkGEY3EpCeJhb8l3E8AkdNtEvSjuc2e1DvFAQdtOwH3cRStTF4GH6IshgwmmSbgT6GN5
         B6WongLEVzBBwxE87w3t3GWtGCAnJAJmb2Aj6WtPrSGWCo/3jiD8u3DeMwDNfASFcCvr
         xLAw==
X-Gm-Message-State: AOJu0YwTBIFaZ7/FsU3c0ts7nfXMbyRvYlz8WfpvS39Yde0fac5+xLMf
	6y8jClkQclzAFRsvW0l+vRLdKUyXvisWqng7UPKoHFgRH+pkpq/3TeZYA1d9Tg==
X-Gm-Gg: ASbGnctRnvu+8whF/Ui2T+i3iD9u2u2KL67OZvZH6mdj10O/b3/iSdP/t/u6gcTQytg
	e5s1tMXbGcwmc3XCdRnqYdn/JUxc+EDgumfbsWH5VKfbtyRPsXleGzXkmchKdTDSftRTOZn/u4/
	mNJ0joASfj+xedXhJWS9P+UbvaD4hKC9/FRPLsRzVaEx3xeRj4iHmwExgGzl5QAfEdP4ARqnU1Y
	N6VKx9neqEvDgrn4ZUW9TD/MU42U5bgUoC5IScHyz7ptmB7bmZyI2lxa4wPGnVewslj2/PiOVTv
	5RZmOX0Wzrn5olkiCstr9wjTGGiEPg4hY4fvdibJDfabQd7tnj33gRHvyVzFVEJtKDJZUO7GIT1
	qpDxLAxal3XbbHNBI/18tsn5xYUmGR9mgYz4BMC++fm9p36K9x/P7edW6IdUn0cQOT3sZJM/LvW
	PS6PuKoMZsitcAzZQbsMb1qck88CtA7gs4Rx8J
X-Google-Smtp-Source: AGHT+IE4ATEVkDFBXkax8iuJTJqM0UJqWdp2Q7pEpMNb6V/poW4xEWUm0EILTD+cGJ7tMOdniEEKXw==
X-Received: by 2002:a05:6000:1848:b0:429:cb8b:b58e with SMTP id ffacd0b85a97d-429eb1a2b33mr482711f8f.28.1762369605205;
        Wed, 05 Nov 2025 11:06:45 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm313840f8f.29.2025.11.05.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:06:44 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 6/6] bitbake-setup: capture revisions while checking out layers
Date: Wed,  5 Nov 2025 20:06:36 +0100
Message-Id: <20251105190636.679388-6-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105190636.679388-1-alex.kanavin@gmail.com>
References: <20251105190636.679388-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 19:06:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18275

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

When initializing a build setup from a conf.json that only sets 'rev'
to a tag or branch, the actual revision would not be captured or
logged.

To capture the current layer state after an 'init' or 'update', the
checkout_layers function is extended to store the revision the
bb.fetch.Fetch pulled, and write that information into a
sources-fixed-revisions.json file. This file can then be fed back into
bitbake-setup init as: --sources-overrides

This new 'sources-fixed-revisions.json' is written during 'update_build' and
stored alongside the 'config-upstream.json' in the config dir. And put
with the later under version control by calling 'commit_config" after
'update_build'.

The use of 'deepcopy' is necessary to not modify the original input
data - which python passes around as reference.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup     | 20 +++++++++++++++++---
 lib/bb/tests/setup.py |  6 ++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ff753557c..47de4654e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -18,6 +18,7 @@ import configparser
 import datetime
 import glob
 import subprocess
+import copy
 
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
@@ -61,6 +62,12 @@ def write_upstream_config(config_dir, config_data):
     with open(os.path.join(config_dir, "config-upstream.json"),'w') as s:
         json.dump(config_data, s, sort_keys=True, indent=4)
 
+def write_sources_fixed_revisions(config_dir, config_data):
+    sources = {}
+    sources['sources'] = config_data
+    with open(os.path.join(config_dir, "sources-fixed-revisions.json"),'w') as s:
+        json.dump(sources, s, sort_keys=True, indent=4)
+
 def commit_config(config_dir):
     bb.process.run("git -C {} add .".format(config_dir))
     bb.process.run("git -C {} commit --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
@@ -76,6 +83,7 @@ def _write_layer_list(dest, repodirs):
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
 def checkout_layers(layers, layerdir, d):
+    layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
     oesetupbuild = None
     print("Fetching layer/tool repositories into {}".format(layerdir))
@@ -99,6 +107,9 @@ def checkout_layers(layers, layerdir, d):
                 src_uri = f"{fetchuri};protocol={prot};rev={rev};nobranch=1;destsuffix={repodir}"
             fetcher = bb.fetch.Fetch([src_uri], d)
             do_fetch(fetcher, layerdir)
+            urldata = fetcher.ud[src_uri]
+            revision = urldata.revision
+            layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
@@ -115,6 +126,8 @@ def checkout_layers(layers, layerdir, d):
                 os.remove(symlink)
             os.symlink(os.path.relpath(t,layerdir),symlink)
 
+    return layers_fixed_revisions
+
 def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
     def _setup_build_conf(layers, build_conf_dir):
         os.makedirs(build_conf_dir)
@@ -269,15 +282,16 @@ def get_registry_config(registry_path, id):
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
 def update_build(config, confdir, setupdir, layerdir, d):
-    layer_config = config["data"]["sources"]
+    layer_config = copy.deepcopy(config["data"]["sources"])
     layer_overrides = config["source-overrides"]["sources"]
     for k,v in layer_overrides.items():
         if k in layer_config:
             layer_config[k]["git-remote"] = v["git-remote"]
-    checkout_layers(layer_config, layerdir, d)
+    sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir)
+    write_sources_fixed_revisions(confdir, sources_fixed_revisions)
 
 def int_input(allowed_values):
     n = None
@@ -471,8 +485,8 @@ def init_config(top_dir, settings, args, d):
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
     write_upstream_config(confdir, upstream_config)
-    commit_config(confdir)
     update_build(upstream_config, confdir, setupdir, layerdir, d)
+    commit_config(confdir)
 
     bb.event.remove("bb.build.TaskProgress", None)
 
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index e18d6fc6a..767a6298d 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -187,6 +187,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         bb_conf_path = os.path.join(bb_build_path, 'conf')
         self.assertTrue(os.path.exists(os.path.join(bb_build_path, 'init-build-env')))
 
+        with open(os.path.join(setuppath, 'config', "sources-fixed-revisions.json")) as f:
+            sources_fixed_revisions = json.load(f)
+        self.assertTrue('test-repo' in sources_fixed_revisions['sources'].keys())
+        revision = self.git('rev-parse HEAD', cwd=self.testrepopath).strip()
+        self.assertEqual(revision, sources_fixed_revisions['sources']['test-repo']['git-remote']['rev'])
+
         if "oe-template" in bitbake_config:
             with open(os.path.join(bb_conf_path, 'conf-summary.txt')) as f:
                 self.assertEqual(f.read(), bitbake_config["oe-template"])
-- 
2.39.5


