Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C8D41D46
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 14:26:03 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10382.1765463153510271052
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Dec 2025 06:25:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LuaLU0uE;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b47f662a0so103914f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765463152; x=1766067952; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HNK/TxNpJubyDtqPcCZV8/we3jKM3rhzgOwlqyknJE=;
        b=LuaLU0uEVzErGRznyrAlvBLjQv1/EMs4DzH5zA9R9Hlzc8OgHxFm7WYE30BdICaemk
         9AB59g89ElGbWL+YHS9nCOAEDyv4dAn1hvErDAxbfIapAnlQZcBXizAuD+6Kl82R1jt+
         8F6e9T1QK8qT9kiZR2OXW0VGmimoUwtnPh5cyuL9hl79CwWdXVLAZJKRXHviYH6SfRdX
         WoXxMYlHB7D7sieLAXM5Z09Y7PMQF9AftS2nFrr1C7lrbULWCWX94GHeCBtJAM7xLD9C
         BmDQjjsLG/YYB/3TW6rAmW9chnYdbe39WOlg7DEoHwcQ0+4omdE9jGSgteOYC6kTV6e7
         VQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765463152; x=1766067952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HNK/TxNpJubyDtqPcCZV8/we3jKM3rhzgOwlqyknJE=;
        b=Qm0ej/JsKT8s8VMaX+WyGZk120hsnLNpj9Mq18UDlmuxvdOPeHrr5GI1phEK3wPLmP
         8gpmFFq5p3SxHtb+xlIQGw61oMrN0piWnSy1w+MMPmFpYK6WHEARMvb21CU7nndKn3Lb
         jiBXsRsOF83xziYSi4bzcEG2mBXTKze9nUYcfxKyBS1H0JdrIoVxC2CsaPqZ+SeUqqjv
         2wsUYpjpCQN8gMwtF6RPq2rNkE8kv7+VlpkcNEsfLagI7McwZ8iF5bkr0J2eMbB+BOAj
         Di6R3Qdy3+YH4hXk/hvRBAHjbHFV8PVQltzQk2w5EuYpKT3BIHX86lGw/bq5JgKLbND7
         ZBiw==
X-Gm-Message-State: AOJu0Yy5oDHwNRDB5fxpkvmKUBNKax+Rp1EJJ9jwni49mCcUkZxRMay8
	xopC8GSSY6rIq/6U5D3ZrsXPGrPHCoMLi2W7U+nUqggh7i6YV9+Xh538W7v8hA==
X-Gm-Gg: AY/fxX5tJ8fvWaJSisSmtpUIRKcL6B2LPqpAYBsfjiPcphP8qdefrgL6xrhyYAdW1jk
	Rzs/CdRUwtRGAhLwIO5WXYZSCLC7LBQq5d7YxeOFkwUaVLBZkThO6FVqjQNIJpjxqt73fXQnaFg
	hqkRv0r9j4r7sQ2sFYncq5sXrwsY87dGKK0W9rK5wRInQIyeqsBx/cit8RX7Zm9GqnyZj7EnkMm
	XS9aQCMauE2L4nk9QElUEWXaTkjUdrOxXSb7K3O/Zbt10yGYQ7hD2w7OqnTP32UyBo2DTwwBl0J
	UskcDWOXbA47+fQ7SIBwX1tFX+T6vSGkwu7DHGclCEvLFlFVCWhcWLolaUolWCg5uLsDbMlsYXu
	kRXWEsEnqGXl0ae//uwD+fdFg4APskRdbp7Vb45JxnkOIdHD8hErg3nCctIhw/YjPRERTwGvtQD
	Jyo5yhMDWcmKBEdrJaudLx49Yl9mFFISH0zaYNRr2AJcLmH3I=
X-Google-Smtp-Source: AGHT+IHg2aOCOFfriPllZJGtzr8e8lSYFabgadVIzUn5eRjhwryvvROSpbN7YnFVWTCGsMuq/WfFXA==
X-Received: by 2002:a05:6000:250d:b0:429:ccd0:d36c with SMTP id ffacd0b85a97d-42fab263a8cmr2713771f8f.14.1765463151800;
        Thu, 11 Dec 2025 06:25:51 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a70394sm6214200f8f.14.2025.12.11.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 06:25:51 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/4] bitbake-setup: use separate functions for git-specific operations
Date: Thu, 11 Dec 2025 15:25:31 +0100
Message-ID: <20251211142532.983960-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211142532.983960-1-alex.kanavin@gmail.com>
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18569

From: Alexander Kanavin <alex@linutronix.de>

This prepares the code for adding different type of sources than git remotes:

- put git-specific operations into their own functions (no behavior changes)

- call them only if a git-remote entry actually exists in the configuration;
do not assume it is always there.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 8d4e9769a..1f83b1b2a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -90,16 +90,7 @@ def _write_layer_list(dest, repodirs):
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
 def checkout_layers(layers, layerdir, d):
-    layers_fixed_revisions = copy.deepcopy(layers)
-    repodirs = []
-    oesetupbuild = None
-    print("Fetching layer/tool repositories into {}".format(layerdir))
-    for r_name in layers:
-        r_data = layers[r_name]
-        repodir = r_data.get("path", r_name)
-        repodirs.append(repodir)
-
-        r_remote = r_data['git-remote']
+    def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
         remotes = r_remote['remotes']
@@ -118,6 +109,19 @@ def checkout_layers(layers, layerdir, d):
             revision = urldata.revision
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
 
+    layers_fixed_revisions = copy.deepcopy(layers)
+    repodirs = []
+    oesetupbuild = None
+    print("Fetching layer/tool repositories into {}".format(layerdir))
+    for r_name in layers:
+        r_data = layers[r_name]
+        repodir = r_data.get("path", r_name)
+        repodirs.append(repodir)
+
+        r_remote = r_data.get('git-remote')
+        if r_remote:
+            _checkout_git_remote(r_remote, repodir, layers_fixed_revisions)
+
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
             oeinitbuildenvdir = os.path.join(layerdir, repodir)
@@ -563,12 +567,8 @@ def get_diff(file1, file2):
     return None
 
 def are_layers_changed(layers, layerdir, d):
-    changed = False
-    for r_name in layers:
-        r_data = layers[r_name]
-        repodir = r_data.get("path", r_name)
-
-        r_remote = r_data['git-remote']
+    def _is_git_remote_changed(r_remote, repodir):
+        changed = False
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
         remotes = r_remote['remotes']
@@ -586,6 +586,16 @@ def are_layers_changed(layers, layerdir, d):
             if upstream_revision != local_revision:
                 changed = True
                 print('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
+        return changed
+
+    changed = False
+    for r_name in layers:
+        r_data = layers[r_name]
+        repodir = r_data.get("path", r_name)
+
+        git_remote = r_data.get('git-remote', repodir)
+        if git_remote:
+            changed = changed | _is_git_remote_changed(git_remote, repodir)
 
     return changed
 
-- 
2.47.3


