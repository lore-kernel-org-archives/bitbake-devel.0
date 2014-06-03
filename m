Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id D43676B81F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:18 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id cc10so6783902wib.11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Y/RzG1HawfG3UexsYFnI4en1W/rFRtMUerFcVtODtLc=;
	b=lPoZkmyb9rxn80tMJAMxH17I3KGOf0slklbYpAgcopj+zUQT7x34RCZ38mLKXynYfa
	XNT1DEy9C8YDVdofE7zyZL680TuZ9AaLzXYdwJPvyWOO7z5s0LKXiFp2b2tidBEosVd2
	tS3+ZGRvnStMAftXJZ3syrDKrGgi1ey43VWhkVdnetRbIW9dson9T8PQSJ5/qQX8GmSX
	MegoGF0vDeChcfWgNLB9zqeLYP6oBq8fwy7gfL8ePmsDhTZjnJ4OBLPsgWgx1Tnsww4Z
	a8merb8h6kmaFvd6pQCTLisUGuGBXXSspB9vrE9LyCA6NiDEvi1dgW2XqqsHKpqm/pr/
	vmzg==
X-Gm-Message-State: ALoCoQmOnOM0Bht7IjyNti2S+NHujap4PxY6NhB9WuwPA/2TxGj5Gl6qApC+meSKrT4MIaRzNV66
X-Received: by 10.180.97.131 with SMTP id ea3mr33107008wib.35.1401809179558;
	Tue, 03 Jun 2014 08:26:19 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	nb8sm42361074wic.18.2014.06.03.08.26.17 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:18 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D51D1561E08; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:17 +0100
Message-Id: <174ac007ddb06d9cfba6a248e9477a09c783a162.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 8/9] toaster: add project related models
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We introduce the notion of a project in Toaster as the item
that holds the specification for triggering a build: the set
of layers used, the set of configuration variable values, and
the set of targets to be build.

Builds triggered through Toaster will be associated with a
Project, and they will be configured based on the project
settings at the moment when the build is ordered.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8aa7126..8d4f21b 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -23,6 +23,10 @@ from django.db import models
 from django.db.models import F
 from django.utils.encoding import python_2_unicode_compatible
 
+class Project(models.Model):
+    name = models.CharField(max_length=100)
+    created     = models.DateTimeField(auto_now_add = True)
+    updated     = models.DateTimeField(auto_now = True)
 
 class Build(models.Model):
     SUCCEEDED = 0
@@ -37,6 +41,7 @@ class Build(models.Model):
 
     search_allowed_fields = ['machine', 'cooker_log_path', "target__target", "target__target_image_file__file_name"]
 
+    project = models.ForeignKey(Project)
     machine = models.CharField(max_length=100)
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
@@ -54,6 +59,9 @@ class Build(models.Model):
         tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
         return( tgts );
 
+class ProjectTarget(models.Model):
+    project = models.ForeignKey(Project)
+    target = models.CharField(max_length=100)
 
 @python_2_unicode_compatible
 class Target(models.Model):
@@ -324,6 +332,12 @@ class Recipe_Dependency(models.Model):
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
     objects = Recipe_DependencyManager()
 
+class ProjectLayer(models.Model):
+    project = models.ForeignKey(Project)
+    name = models.CharField(max_length = 100)
+    giturl = models.CharField(max_length = 254)
+    commit = models.CharField(max_length = 254)
+
 class Layer(models.Model):
     name = models.CharField(max_length=100)
     local_path = models.FilePathField(max_length=255)
@@ -338,6 +352,11 @@ class Layer_Version(models.Model):
     priority = models.IntegerField()
 
 
+class ProjectVariable(models.Model):
+    project = models.ForeignKey(Project)
+    name = models.CharField(max_length=100)
+    value = models.TextField(blank = True)
+
 class Variable(models.Model):
     search_allowed_fields = ['variable_name', 'variable_value',
                              'vhistory__file_name', "description"]
-- 
1.9.1


