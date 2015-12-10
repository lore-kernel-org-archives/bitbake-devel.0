Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 8F30370057
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:11 +0000 (UTC)
Received: by pabur14 with SMTP id ur14so40486883pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=FNlSiwPwLOCVb7firtdLyvdfbO5Gb1FRDiiVlKvRyqI=;
	b=REqFUF6io9koqnEL15mat84KxdvK3NeBUmTfP/bh1kQcdIfLxeQadv2kYvJmKAG2a+
	edfFCqUxSTMJoDYCD9dZjqzNvbp4PZxBdOXxE5dMaQ+rnJ7IKtLYb0C3ItsxAaFt5F/j
	DPCa0iOz48z1vwUbDbwEzr5fi7sysRvyhCvP77PK4ojUOsEKrtwpYY+tfZKYLSJm6aK2
	VLsROZ+A2/GF2HKp8aTeCbOn2yv2dqdwH85DWxNavEWiv9kevrhsKQU+9eLrh3Ij4KKN
	LQOvOgNn3yYD4oRbZQycD19Ycmydy+rlTUwgp8/ImXRUeDEZh0dT9Y3QNiQNm96K8vpb
	ydBw==
X-Received: by 10.66.216.200 with SMTP id os8mr13339493pac.143.1449719591881; 
	Wed, 09 Dec 2015 19:53:11 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:11 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:39 -0800
Message-Id: <f08f0a3df4358d1da23f6d5469db17d48c42fbfe.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 14/18] toaster: fixed format strings
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:12 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Printing id as a number breaks toaster if object is not saved
yet as id/pk is None in this case.

Changed format spec to print id as a string in __str__
and __unicode__ methods of Build, Task and LayerVersion models.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index f07feda..3c51c6f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -370,7 +370,7 @@ class Build(models.Model):
             return self.get_outcome_text()
 
     def __str__(self):
-        return "%d %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
+        return "%s %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
 
 
 # an Artifact is anything that results from a Build, and may be of interest to the user, and is not stored elsewhere
@@ -552,7 +552,7 @@ class Task(models.Model):
     sstate_text  = property(get_sstate_text)
 
     def __unicode__(self):
-        return "%d(%d) %s:%s" % (self.pk, self.build.pk, self.recipe.name, self.task_name)
+        return "%s(%s) %s:%s" % (self.pk, self.build.pk, self.recipe.name, self.task_name)
 
     class Meta:
         ordering = ('order', 'recipe' ,)
@@ -1203,7 +1203,7 @@ class Layer_Version(models.Model):
         return sorted(result, key=lambda x: x.layer.name)
 
     def __unicode__(self):
-        return "%d %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
+        return "%s %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
 
     class Meta:
         unique_together = ("layer_source", "up_id")
-- 
1.9.1


