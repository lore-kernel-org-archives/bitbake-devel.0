Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 65C0660616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:53 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48543886pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=YAoMw/a+TUHFNlIZJ5J4Th3Du0NH/sgD66id6oOzfdE=;
	b=MixqseOJVxkDMx3DfiL/ckxnidUZxISZX3G8JVI3j80n5hUSTiFHmElaSt2xbGi4Ud
	3DI9aceCGm+FGcg3B6jJYSrJcWIVj1UlDwyBF9IbQouw9h3iOvEB5+ti3cubNHutDhPK
	Euq5MaluYQF+1IRTQHgb+pcbRUou69+rf2mkkcHKm5dk6lBvXsxAjl182RMBcUq6oCSc
	62VOqU9h3xq7cY30SwuEVUBLqJyBef+7hBv7fH/sBorp5DQlmdftE1AL5DW/piSuKmD2
	cadv9bP4ILZzUOisHOm3/xWA3IEAdjpNBiK/KRHJYVtfPWoNDzEHxhT8qdauYOXfeYAP
	frAA==
X-Received: by 10.98.76.1 with SMTP id z1mr6499895pfa.115.1449079194474;
	Wed, 02 Dec 2015 09:59:54 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:53 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:52 -0800
Message-Id: <3f15ae9025cf8e06807172c9c70fe3ef531e278f.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 20/30] toaster: buildinfohelper Broaden the toaster created recipe data case
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:53 -0000

From: Michael Wood <michael.g.wood@intel.com>

When build information is the 'original' source of the information we
need to return the recipe that was created rather than the copy of the
recipe that is taken for keeping build history. We do this already for
command line triggered builds, but we also have this case for custom
images. We can simply check if the built_recipe exists instead of
special casing this.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 2b9302d..5ea9284 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -304,12 +304,11 @@ class ORMWrapper(object):
                 break
 
 
-        # If we're in analysis mode then we are wholly responsible for the data
+        # If we're in analysis mode or if this is a custom recipe
+        # then we are wholly responsible for the data
         # and therefore we return the 'real' recipe rather than the build
         # history copy of the recipe.
-        if  recipe_information['layer_version'].build is not None and \
-            recipe_information['layer_version'].build.project == \
-                Project.objects.get_default_project():
+        if built_recipe is None:
             return recipe
 
         return built_recipe
-- 
1.9.1


