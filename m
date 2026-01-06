Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4145CDC18E
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88589.1767701443846989429
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=grXnKxrl;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b72b495aa81so167841166b.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701442; x=1768306242; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJIQXmnQborxnXi2eTFT8le2aN/8gtl9AvwqxeK31H4=;
        b=grXnKxrleR2c7E+fXLZs9vBx9sryYDBQBq0i323rfOxeMD9sbvLPbJvt6NT8UYFl5W
         8Y3b2nYJHgV4NwvE1Fj2w3unICrMuiix53LpolyqjmWB6ktOAx/DstAlPUt47QPBFULa
         hRnzNjhEIhgw07a/Dh2U7m+kROcmOLWmMb15UGHeIy7O7ynuaSNNWyv71PUjdXEILB5j
         +6tpNa6raPCQeLaVH76nYfChAnVvbm4Hh7jJfeRDy1QjLiFE0LT407fUqCQaj8A3a8YX
         w0nByjW/vXcxoUwRwXL1lEr/7PwRNVaa+pbvh50YpJ23j6XqF/wUYVIdQHVijc+l1nvP
         thjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701442; x=1768306242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJIQXmnQborxnXi2eTFT8le2aN/8gtl9AvwqxeK31H4=;
        b=Tse4rllR1NLLRWI0CuvfgFqiWw+VUCCbbW92OUIozdGq9rh5BKIVFD1VGIHTJEXvu5
         p44sfOHDvmxNoFcXrxIJmfnqSvXjypeza8/SP/YjjxotAl0dafTOep89cAZKAQ8TjAuE
         tkZFj+d+D/CALIqI+xmdxYqeBgXDkBpT/NkTLtAFlxeeZbEKDSkz7/P5AjEFcVHQ5Ckf
         WnWIIBRdtba6UTqSLPS0G8jP90FdpRfyDNXebpLpRiPM4hg+7pKIqNN+TIdXgSb651Gz
         TwPzBhtOrpooy2JZOkeQTR+gH1+VTpjKqgIARRl3BUalZa/jonPoBcRzQeinSDLruMIA
         GndA==
X-Gm-Message-State: AOJu0YzWluy78kwRTNJEg92epwYcePgyrsQ+B13cC/iEirtD5HxRcthf
	EZlC706YRz9xRQOb8umJlWS8zD1jjjeaIn/DgaMPebpyi/MF8DmOo+tKctkgww==
X-Gm-Gg: AY/fxX7cn6Sxz5v+GzDpSLJL4gH3pxpXhhBGTlWVhZabN5H0o1+To9Pl2tQ/O9FlLKi
	yIVjZu9DEU7kH2NfOFDpPNdTc+qR/aPUjeDqbzGwzUHbmB0uKc1uXlNYZVfanqEEQNmYHUm/EyV
	+PgNkFsn/tWvctI/ABGHcrfz+JlUBc6L5SQnz0qkaZ5l4wzy92Y7kZBf+Od6PiJ0sfayfYjpXKV
	3E+gRaIlhNatSF2v1iLy9z1NUTn6zCv/0v17+O5H3FG5OSAJt2V5HkDqF3TwiwCdkiOFoFlWD7Z
	hYK6NpnwuMA/IXT0geZDlWLm5UXO5mDDttlZ7bT9mNsvduG5XaZypkHqo51sPX+AZwl30ACV7Lp
	FGafoNVlve+VBUEYNnf9EqIJDqVBe1Z5cNelHCTc4L9mwMvirV5+rRN0ZvaZDdj2K97HTiu7HnR
	V+B7mwBcyJW2gQZwKvBcgKp8BWfRp5Bx6lnXIYGWcxN8f47bA=
X-Google-Smtp-Source: AGHT+IF9K3qOLp/p0DPonw0DYPrhieDXFqmUZ9yKPEv+rRaPsedjB07NDTBhFm5adlIXlkVeBdGacQ==
X-Received: by 2002:a17:907:9301:b0:b6d:7f84:633 with SMTP id a640c23a62f3a-b8426a8398amr256730666b.20.1767701441971;
        Tue, 06 Jan 2026 04:10:41 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:41 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 08/10] bitbake-setup: symlink json with fixed revisions into layers/
Date: Tue,  6 Jan 2026 13:10:30 +0100
Message-ID: <20260106121033.3892596-8-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18698

From: Alexander Kanavin <alex@linutronix.de>

This makes the file more visible for users, and allows easier
checks of layers current content against what was checked out
by bitbake-setup (to ensure local modifications aren't wiped out).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 0d33f0896..06255b112 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -69,11 +69,15 @@ def write_upstream_config(config_dir, config_data):
     with open(os.path.join(config_dir, "config-upstream.json"),'w') as s:
         json.dump(config_data, s, sort_keys=True, indent=4)
 
-def write_sources_fixed_revisions(config_dir, config_data):
+def write_sources_fixed_revisions(config_dir, layer_dir, config_data):
+    json_path = os.path.join(config_dir, "sources-fixed-revisions.json")
+    json_link = os.path.join(layer_dir, "sources-fixed-revisions.json")
     sources = {}
     sources['sources'] = config_data
     with open(os.path.join(config_dir, "sources-fixed-revisions.json"),'w') as s:
         json.dump(sources, s, sort_keys=True, indent=4)
+    if not os.path.lexists(json_link):
+        os.symlink(os.path.relpath(json_path ,layer_dir), json_link)
 
 def commit_config(config_dir):
     bb.process.run("git -C {} add .".format(config_dir))
@@ -344,7 +348,7 @@ def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
-    write_sources_fixed_revisions(confdir, sources_fixed_revisions)
+    write_sources_fixed_revisions(confdir, layerdir, sources_fixed_revisions)
     commit_config(confdir)
 
 def int_input(allowed_values, prompt=''):
-- 
2.47.3


