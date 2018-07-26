Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id C7B6C78AE1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 11:10:33 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so1583032wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=2SQQDb99dzDh1D115u9wNHxZ0gEFVLva3bpFhC5Hl2E=;
	b=j0Iz2MNcP1cEd9s8vPRAzRBlqM7qTxDxMSbglFnjXeRi5+HPNSYi77BNvDoygKWnqq
	6gYnIx58UACn/oeckzhYpBJqe/h576XNc7GpflsBVP6GUGDaZKnEjoGhW5P8IPdf/H7/
	xiR3ZUVz1jdR3Zbo0HRKvVan4vP7kztf8PO7vcDfMswHNkH00/3EZPR4dEvcFKojIkpn
	F5dout1mxPHkzorpmM5GcgQyJn6cUnR5ZPuV+Vrq5aLZHat2bst3FZK+E85NvT9sxk+e
	lBYxf3FoitL5zHPZM714MxVb7oepZxv6CI+koE1+FeL5liznLRqxThmYxETYCsRumTN3
	I8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=2SQQDb99dzDh1D115u9wNHxZ0gEFVLva3bpFhC5Hl2E=;
	b=Cbnci585I7ppZYzB5y8ZPmpPj8toEoRVplTPZelTxStSbijuvE4QN9qZu3yss93VXB
	JjRkS7ZeoQfZkvIbpsIHWBWPc5GKbmAAIGNH5rvhNG9wOKgN8X626BchXZu7/kRUCZ6O
	mVNbinytYRfFY+0vBgN5Y6uat6qj7c3OeFVa/DxFU0be6tgUtRSVb5h1Z+qu/7JaDyrF
	oQcqjSxDDDxcSuW/+BmVcCxGowFd0BbJ1O8KurEQeLJ2aqiOAq2xjSy5vsDIUBD8HO+d
	u7AYvT63WgdYtL8hPjhsicdB/bBsfKUQpQhMwU5rI0humbOeuI8iteRvMYsCbn2o7kk1
	3acw==
X-Gm-Message-State: AOUpUlHva/gcJVR9jShsb+FBRBxzalHdWomcRvCkxgBb0Av7LtUY0c1G
	ksIidJFuv6rqj17QEIwijwp3WcZb
X-Google-Smtp-Source: AAOMgpc2TOW4pgnnY+yf7duMYwZY9SeGlTeVQ06rV8HW2jOo/EP/G8sgp7qCHCPlNe18Y1ZsMZ7v6w==
X-Received: by 2002:a1c:1188:: with SMTP id
	130-v6mr1275573wmr.138.1532603434464; 
	Thu, 26 Jul 2018 04:10:34 -0700 (PDT)
Received: from localhost ([217.30.68.212]) by smtp.gmail.com with ESMTPSA id
	t186-v6sm1844365wmf.14.2018.07.26.04.10.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 26 Jul 2018 04:10:33 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Jul 2018 11:10:31 +0000
Message-Id: <20180726111031.665-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] codeparser: Track oe.utils.conditional usage
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
X-List-Received-Date: Thu, 26 Jul 2018 11:10:34 -0000

* base_conditional was already removed from oe-core:
  http://git.openembedded.org/openembedded-core/commit/?id=0391fcad9103abca0796a068f957d0df63ab4776
  after the usage was migrated to oe.utils.conditional:
  http://git.openembedded.org/openembedded-core/commit/?id=c97acbd034532895ce57c6717ed1b3ccc7900b0d
  so we can handle just ".conditional" version

* add 1st parameter to variable dependencies, that way when you use
  FOO = "${@oe.utils.conditional('VAR', 'VALUE', 'true', 'false')"
  FOO variable will have dependency on VAR variable and you don't need
  to add FOO[vardeps] += "VAR" manually every time you use
  oe.utils.conditional

* this is similar to contains tracking from:
  https://bugzilla.yoctoproject.org/show_bug.cgi?id=3890
  http://git.openembedded.org/bitbake/commit/?id=ed2d0a22a80299de0cfd377999950cf4b26c512e
  http://git.openembedded.org/bitbake/commit/?id=0b9d117631ce909312d53b93289e61defc6be01c
  but conditional is simpler, we don't need to handle the first
  parameter as a set

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/cache.py      | 2 +-
 lib/bb/codeparser.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 5325f571..93014cc4 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -37,7 +37,7 @@ import bb.utils
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "151"
+__cache_version__ = "152"
 
 def getCacheFile(path, filename, data_hash):
     return os.path.join(path, filename + "." + data_hash)
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 530f44e5..ddd1b97d 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -140,7 +140,7 @@ class CodeParserCache(MultiProcessCache):
     # so that an existing cache gets invalidated. Additionally you'll need
     # to increment __cache_version__ in cache.py in order to ensure that old
     # recipe caches don't trigger "Taskhash mismatch" errors.
-    CACHE_VERSION = 9
+    CACHE_VERSION = 10
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -214,7 +214,7 @@ class BufferedLogger(Logger):
         self.buffer = []
 
 class PythonParser():
-    getvars = (".getVar", ".appendVar", ".prependVar")
+    getvars = (".getVar", ".appendVar", ".prependVar", "oe.utils.conditional")
     getvarflags = (".getVarFlag", ".appendVarFlag", ".prependVarFlag")
     containsfuncs = ("bb.utils.contains", "base_contains")
     containsanyfuncs = ("bb.utils.contains_any",  "bb.utils.filter")
-- 
2.17.1


