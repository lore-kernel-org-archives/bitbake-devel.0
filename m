Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 9F179606A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:03 +0000 (UTC)
Received: by pacwq6 with SMTP id wq6so40245016pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=BvXPsavJ4d2Leqt5i3C0DxTc35CMnDb6f6Ag7JvQDoo=;
	b=TrZ40KG4Mi/KWRAltPGDjPNGZX8aHQQD6nGRv1c/6liF+etuRBACsTtnvOxWZLfUpi
	OmDK9xYpIQNZW2liPvwaGGokbldhCcFyRF9DVWDNhnt2/lu4z/sfLJ4tRxoLDYYEjn3g
	ielO3EyK3qAdAxxb5Eacv31OWPCQRiNckyC3bd4C41jSwdn+njk5qlgUQ7QalkFhcCdf
	bREVzwScfADacHeQ2NnQZeF5KqVFm+B+xG222xUkc4F1D+pwkfFNRZvnUKKjrk/h9A5N
	N0+8DWV8BC62i16UzSjmR/SG5BmxA3oR5CDl5GyiNTAUtE0Z8sDTFiSECGUfJ4bGxr3L
	BQqA==
X-Received: by 10.67.30.227 with SMTP id kh3mr13187403pad.69.1449719584732;
	Wed, 09 Dec 2015 19:53:04 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:04 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:31 -0800
Message-Id: <9b34d964799a9c80ace730b30a182f9199d9c895.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 06/18] toaster: rename get_query_set -> get_queryset
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:03 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Renamed get_query_set to get_queryset as get_queryset causes
deprecation warning in Django 1.7 and is deprecated in Django 1.8

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4a868e7..b25910a 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -598,8 +598,8 @@ class Package(models.Model):
 class Package_DependencyManager(models.Manager):
     use_for_related_fields = True
 
-    def get_query_set(self):
-        return super(Package_DependencyManager, self).get_query_set().exclude(package_id = F('depends_on__id'))
+    def get_queryset(self):
+        return super(Package_DependencyManager, self).get_queryset().exclude(package_id = F('depends_on__id'))
 
 class Package_Dependency(models.Model):
     TYPE_RDEPENDS = 0
@@ -699,8 +699,8 @@ class Recipe(models.Model):
 class Recipe_DependencyManager(models.Manager):
     use_for_related_fields = True
 
-    def get_query_set(self):
-        return super(Recipe_DependencyManager, self).get_query_set().exclude(recipe_id = F('depends_on__id'))
+    def get_queryset(self):
+        return super(Recipe_DependencyManager, self).get_queryset().exclude(recipe_id = F('depends_on__id'))
 
 class Recipe_Dependency(models.Model):
     TYPE_DEPENDS = 0
-- 
1.9.1


