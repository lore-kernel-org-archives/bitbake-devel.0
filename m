Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id 255586FF60
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:41:09 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id p185so17787977pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=/DSQhG1zdVgEje0DtV28OxjYztpBjxGWsplXma/57Bw=;
	b=ql31xPeoyxlvHfF4XURySh4OhiELOmevuQn9kIpf6BHQU49RDmJ5uRtwq7bQGifU8u
	YtMKL8x4oxTRJ4o/pUPjS/DD8Eb4KgLSYPKt7aYoy3CaJJ7uKd/fcakz8K478BGQygZU
	rWijNzh85fvnIShzwD8+HvncQGMwLMNF7qaHbjEwWqU2INJOMi9LXWBcEtCQAmF2B7dn
	0Vp6CerrZ+Ww4wnTEl5XCkyIbUUumIi7VLzvy6mLh9GCAI76xX4FH85NCuU+Oh7Uvglg
	8PTQFTTp1jkKdazyHxxUPQYE07KX9iuB7EgiP21cBI8vEyFD1onV+0qs/dhX5khzqIeA
	vpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/DSQhG1zdVgEje0DtV28OxjYztpBjxGWsplXma/57Bw=;
	b=ajY+rwvG9LBWdaxGIJKn6efdJnng2Y/lFv9qboNMQsBUQvldr4l/dSSC/SDIjfjqIf
	YnLkX7ZwW2amFZcV3N9QmOVA62Kllj1C+ePL6uEwl89FxwxlUoxLqSzYgD7mJj2zdSoJ
	tZf2kN1sQEVPPsLisnSmmDu4Nm7hpoQp5o47ub+gUKA42XYXQTux5I1uywiqc0sKU3es
	hWg0JlPks4PvvYi8ffL8I2sIKgd/WVrzvz9fbuzGUsswGn/exyH+lajf/yp3vlgkU5/c
	a2nAdbKaYanxvD3Jb0WZbBJuU1k1oCy4kOBYTMngP+Iz70MTXi2vw08LwP13bqy8Cje8
	gGCg==
X-Gm-Message-State: AOPr4FUsrPTfa6ce8LJM3N8ysushx4wGYkRgPHdzW21lot6biKWahP/QLtGUQTKFqRfdbA==
X-Received: by 10.98.102.20 with SMTP id a20mr38847633pfc.137.1462045270184;
	Sat, 30 Apr 2016 12:41:10 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	d78sm33226530pfb.59.2016.04.30.12.41.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:41:08 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:40:59 -0700
Message-Id: <2a2139b78efa73e434ec9bbe9e2101645c9a80f4.1462041562.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
References: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
In-Reply-To: <cover.1462041562.git.chris_larson@mentor.com>
References: <cover.1462041562.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [RFC master][PATCH 3/4] bb.utils: let loaded plugins provide a plugin object
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
X-List-Received-Date: Sat, 30 Apr 2016 19:41:10 -0000

From: Christopher Larson <chris_larson@mentor.com>

This lets us avoid treating the module like an object, so no globals are
needed, if one chooses to do so.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/utils.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index c54ff5b..5e735d3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1477,5 +1477,7 @@ def load_plugins(logger, plugins, pluginpath):
         if name != '__init__':
             plugin = load_plugin(name)
             if hasattr(plugin, 'plugin_init'):
-                plugin.plugin_init(plugins)
-            plugins.append(plugin)
+                obj = plugin.plugin_init(plugins)
+                plugins.append(obj or plugin)
+            else:
+                plugins.append(plugin)
-- 
2.8.0


