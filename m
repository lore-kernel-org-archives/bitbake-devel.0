Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 6370F76F9D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:43:56 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so198600147pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/f8uzMWPrhsbZY5/lUXOfDfMQuoyDx+DxZkpQ/Bvh4o=;
	b=tppeQM3do6Ls0ZVQTmXWE97tHLlfNjfcowo21Rmtvv095QQeGFtxgYKxVm6tBpcJNP
	A3nzq9/CVq6s1bGW/iC22jKorBxaYtFauC6agKIHuHFQz7pLZ/PvsSsnFuO7VrzqzqmR
	hrTzCv2UQdKKJvze5S2hGGiM4X22Qtt5TIW8b4CUDaTMtXa+XjWgHCf6t2v/QzE4IM+B
	MabYMiahTAAOsoT8f8WdxxCJ6VyYDFPmNh5EisZ8O4IZosk3ha1zjMLYoHE/GYSRX77h
	9xSXO8fsvY82rt5CkGMXxxaks7FxdsmLjXJjsh1ul6FRoXkwdLvU8M24lLw7z+sEVjn8
	Y56A==
X-Received: by 10.66.219.195 with SMTP id pq3mr30396397pac.98.1443501835936;
	Mon, 28 Sep 2015 21:43:55 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.43.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:43:55 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:11 -0700
Message-Id: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 01/22] toaster: make a workaround for old style index
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
X-List-Received-Date: Tue, 29 Sep 2015 04:43:58 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

For a new style indexes 'inherits' field is used to determine if
recipe is an image recipe.

As old style indexes don't have 'inherits' field this can be
guessed from recipe name. Let's consider recipe an image recipe
if recipe name contains '-image-'.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 883ecf4..b5c8643 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -974,6 +974,8 @@ class LayerIndexLayerSource(LayerSource):
                 ro.file_path = ri['filepath'] + "/" + ri['filename']
                 if 'inherits' in ri:
                     ro.is_image = 'image' in ri['inherits'].split()
+                else: # workaround for old style layer index
+                    ro.is_image = "-image-" in ri['pn']
                 ro.save()
             except IntegrityError as e:
                 logger.debug("Failed saving recipe, ignoring: %s (%s:%s)" % (e, ro.layer_version, ri['filepath']+"/"+ri['filename']))
-- 
1.9.1


