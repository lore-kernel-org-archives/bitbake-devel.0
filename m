Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 37A1A7836C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 05:03:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v5F53IjW004681
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 22:03:18 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 22:03:18 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:54:32 -0700
Message-ID: <2f631650d8103d0f0a2e959516b729060f84b106.1497502344.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1497502344.git.David.Reyna@windriver.com>
References: <cover.1497502344.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 1/1] toaster: get_last_build_id not called correctly
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
X-List-Received-Date: Thu, 15 Jun 2017 05:03:17 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The method "get_last_build_id" missing the "()" in several calls. This
has been failing silently with Django 1.8 but intermittently crash with
Django 1.9.

[YOCTO #11570]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 6c5cfcd..a49f9a4 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -225,16 +225,16 @@ class Project(models.Model):
             return( -1 )
 
     def get_last_outcome(self):
-        build_id = self.get_last_build_id
+        build_id = self.get_last_build_id()
         if (-1 == build_id):
             return( "" )
         try:
-            return Build.objects.filter( id = self.get_last_build_id )[ 0 ].outcome
+            return Build.objects.filter( id = build_id )[ 0 ].outcome
         except (Build.DoesNotExist,IndexError):
             return( "not_found" )
 
     def get_last_target(self):
-        build_id = self.get_last_build_id
+        build_id = self.get_last_build_id()
         if (-1 == build_id):
             return( "" )
         try:
@@ -243,7 +243,7 @@ class Project(models.Model):
             return( "not_found" )
 
     def get_last_errors(self):
-        build_id = self.get_last_build_id
+        build_id = self.get_last_build_id()
         if (-1 == build_id):
             return( 0 )
         try:
@@ -252,7 +252,7 @@ class Project(models.Model):
             return( "not_found" )
 
     def get_last_warnings(self):
-        build_id = self.get_last_build_id
+        build_id = self.get_last_build_id()
         if (-1 == build_id):
             return( 0 )
         try:
@@ -269,7 +269,7 @@ class Project(models.Model):
         return last_build.get_image_file_extensions()
 
     def get_last_imgfiles(self):
-        build_id = self.get_last_build_id
+        build_id = self.get_last_build_id()
         if (-1 == build_id):
             return( "" )
         try:
-- 
1.9.1


