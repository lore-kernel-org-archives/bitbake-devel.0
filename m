Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 32FF6744AA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Jul 2018 21:55:06 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so4658881wmh.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Jul 2018 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=BEMRKPGYKIuzRhC/IrBOr9gB8iaKTrCXYyEUsxjybEQ=;
	b=K/AmdpIkr12Xu+pkvvunVcZ3LfSp3ZD9PEf29rrpnD3W5se5tVuGyQ3kC6on9u4+iK
	hKmBtIEYWGZKNI5BUbFo6netJIrY4AQoRwNZmnbQuk1lCDYvMrymdPbeA0Kjq7c3xeYY
	0ZlmYTPsgJThFBURbsmmp2og62VZ6qtnXcgP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=BEMRKPGYKIuzRhC/IrBOr9gB8iaKTrCXYyEUsxjybEQ=;
	b=tXLKu26NEgzIxlq0q0RRFzmeppIT8HIXhaiPXTWzX9QMuLIMzavkQn0/vuKJIl9fNA
	D0r2SO3qvutsP8zjgbm9UIo9qx5vweVxZYZ+rkSiLaWY+T2VGNE0NPPav/j4qdQPnjtY
	RYPUvJnwtyTEFhAOxjqtrn2lAal3/13WIXuDaMoiYQ3kGskc9IY1JTiznVHDV85lLQRe
	Ygq3A/yVm0XK2lX9rJuDaM47hrXhiRoCdtz0TPOZ/gW2jZNcc0fyVvBHUPuPjk9lNlod
	S5AorQcJ0w+Qlf9l4ue3LEQ3WOrHlQCyNO+MoI20Az8bcCIHvEnEidtBZY83r2P2vrhd
	TkKw==
X-Gm-Message-State: AOUpUlFZ4al32CjZErBQFgoT85AaeraB8jyEQ+g+s8RQulQLFw+Dka5s
	KFZfbzqPHniafs+NlwkOA3YYiXY+pYoLAQ==
X-Google-Smtp-Source: AAOMgpfId7sQZTuX5RYqpYqO5DSfSz10jJplu8hfiFgc4gHe8Neao3+Ka+vK9s/wwfGcGIzfvNDF4Q==
X-Received: by 2002:a1c:85cc:: with SMTP id
	h195-v6mr848541wmd.110.1533074106663; 
	Tue, 31 Jul 2018 14:55:06 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l5-v6sm13054733wrq.86.2018.07.31.14.55.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 31 Jul 2018 14:55:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Jul 2018 22:55:04 +0100
Message-Id: <20180731215504.12548-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] bblayers: Don't parse all recipes when calling add-layer
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 31 Jul 2018 21:55:06 -0000

When adding multiple layers in a chain of commands, reparsing all recipes
each time can be painfully slow. Instead just parse the base configuration
which gives some confidence things worked out correctly without as much
overhead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bblayers/action.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index aa575d1c09..a3f658f931 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -45,7 +45,7 @@ class ActionPlugin(LayerPlugin):
             notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None)
             if not (args.force or notadded):
                 try:
-                    self.tinfoil.parseRecipes()
+                    self.tinfoil.run_command('parseConfiguration')
                 except bb.tinfoil.TinfoilUIException:
                     # Restore the back up copy of bblayers.conf
                     shutil.copy2(backup, bblayers_conf)
-- 
2.17.1


