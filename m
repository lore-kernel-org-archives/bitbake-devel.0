Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 27A5677327
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 12:17:14 +0000 (UTC)
Received: by mail-pa0-f46.google.com with SMTP id yy13so109611802pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 04:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=vmHnvjqQ77K5AUisj1GPLQ9x5+TQYN60/PPdJ4cZ0d8=;
	b=M7cZVW1pqo2DndhuutdtsRNQEX91b2evJZZZ4yAqTs0oRyIOFYtQPFkhhLDK6m/jf4
	9yiSTEpEdEYSUEJASVsRiwsI79DylN7xYpTN+1KHX2unt82+eIOfebiRfPQBMC7H8+dN
	Jj3M3okNePASbzB3OOuXUh3YRHRPi5zvte4Q5Fgn+4m2AdpGnfOcgA1k0jP/waxkikZP
	gMN6zg5jSGjeE0DyiPSEqoWKTUm62b+TNJby+hPN+e46e8uB5Jko5v3UkkT9EMLKhQqf
	nSWFl7fJ/HrtPMpaFxZNG1pHolmiidQmOx0bUPqirtZOHrpZhYoOD2JKQUOhwdwPsA+0
	FQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=vmHnvjqQ77K5AUisj1GPLQ9x5+TQYN60/PPdJ4cZ0d8=;
	b=BxELN4vTYRznaz8TOlfJCW9OMF9cza9PX4B8fp0nGd6bjrkuLCkTv19Naw7gxjTgWz
	iIhLAEldW5KUqho/Kca3tMiAzIkqkVqCAGiHWi+wI0An0COqmXDyTb2ElFp0MRLcKz1E
	I2DxItYplHWL7jraoPsTubb5Ef/lHaYecUSrjngx/pHgLpSpsvi0QJv34R+S/krR2Izo
	IqUc5SPrwgnMtNkvGVuFAdfwucPHDMhAH9j2GbjZqUPHv9WOx4AmJRalRXN/Nmj1TCm5
	kA/xpmzgA+v4ufmOREPVirVBVch0TImFbb4QeqxkqbnvUhR6vakPt3WBCB9YD5+4iWEc
	Agrg==
X-Gm-Message-State: AG10YOQffqWJwu6Pz2o2sO5K8JNpIMgw56CSAThipWStaFOVFl7TENjaYirn1oTeGyCz/oMl
X-Received: by 10.66.248.198 with SMTP id yo6mr45376590pac.54.1456229834977;
	Tue, 23 Feb 2016 04:17:14 -0800 (PST)
Received: from dorado.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id
	h66sm43820709pfd.91.2016.02.23.04.17.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 23 Feb 2016 04:17:14 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Feb 2016 12:17:04 +0000
Message-Id: <1456229824-4849-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH] toaster: show suffix for image files and basename for artifact files
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
X-List-Received-Date: Tue, 23 Feb 2016 12:17:15 -0000

From: Elliot Smith <elliot.smith@intel.com>

The build dashboard doesn't show image and artifact files correctly,
as it shows the full filename for images and the filename plus
path relative to DEPLOY_DIR for artifacts.

Instead, show just the suffix for image files, and the basename
for artifact files.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/orm/models.py                          |  8 ++++++++
 .../toastergui/templates/builddashboard.html       | 22 +++++++++++-----------
 lib/toaster/toastergui/views.py                    |  7 ++++++-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index ab6940f..93b5df3 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -550,6 +550,8 @@ class BuildArtifact(models.Model):
 
         return self.file_name
 
+    def get_basename(self):
+        return os.path.basename(self.file_name)
 
     def is_available(self):
         return self.build.buildrequest.environment.has_artifact(self.file_name)
@@ -588,6 +590,12 @@ class Target_Image_File(models.Model):
     file_name = models.FilePathField(max_length=254)
     file_size = models.IntegerField()
 
+    @property
+    def suffix(self):
+        filename, suffix = os.path.splitext(self.file_name)
+        suffix = suffix.lstrip('.')
+        return suffix
+
 class Target_File(models.Model):
     ITYPE_REGULAR = 1
     ITYPE_DIRECTORY = 2
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 7857aba..a0da71e 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -110,7 +110,7 @@
                                   </p>
                     </div>
                 </div>
-                        {% else %}
+        {% else %}
             <dt>
                 <i class="icon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></i>
 
@@ -125,18 +125,18 @@
             </dt>
             <dd>
                 <ul>
-                                  {% for i in target.imageFiles %}
-            {% if build.project %}
-                    <li><a href="{% url 'build_artifact' build.pk 'imagefile' i.id %}">{{i.path}}</a>
-            {% else %}
-                    <li>{{i.path}}
-            {% endif %}
-                    ({{i.size|filtered_filesizeformat}})</li>
-                                  {% endfor %}
+                    {% for i in target.imageFiles %}
+                        <li>
+                            <a href="{% url 'build_artifact' build.pk 'imagefile' i.id %}">
+                                {{i.suffix}}
+                            </a>
+                            &nbsp;({{i.size|filtered_filesizeformat}})
+                        </li>
+                    {% endfor %}
                 </ul>
             </dd>
         </dl>
-                        {% endif %}
+        {% endif %}
     </div>
         {% endif %}
     {% endfor %}
@@ -160,7 +160,7 @@
             <dd><div>
               {% for ba in build.buildartifact_set.all|dictsort:"file_name" %}
                 <a href="{%url 'build_artifact' build.id 'buildartifact' ba.id %}">
-                    {{ba.get_local_file_name}}
+                    {{ba.get_basename}}
                 </a>
 
                 ({{ba.file_size|filtered_filesizeformat}}) <br/>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 13489af..28b03d3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -480,7 +480,12 @@ def builddashboard( request, build_id ):
             if ( ndx < 0 ):
                 ndx = 0;
             f = i.file_name[ ndx + 1: ]
-            imageFiles.append({ 'id': i.id, 'path': f, 'size' : i.file_size })
+            imageFiles.append({
+                'id': i.id,
+                'path': f,
+                'size': i.file_size,
+                'suffix': i.suffix
+            })
         if t.is_image and (len(imageFiles) <= 0 or len(t.license_manifest_path) <= 0):
             targetHasNoImages = True
         elem[ 'imageFiles' ] = imageFiles
-- 
2.5.0


