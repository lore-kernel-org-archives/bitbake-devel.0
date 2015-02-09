Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id 0560B732CC
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:08 +0000 (UTC)
Received: by pdbft15 with SMTP id ft15so32774262pdb.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=QeKlutCN74K8kXA67/QNJNXxbPYk8kBNdR6QLjz68MI=;
	b=bhROXGSw9Kp/pwy3WQpn2yrNciwAAU+9pKoDu6T3cg94ofgs7Z0pe8nOkUifMcUX8j
	QBQ2uiki1KIA3aiFL68k1Am/j4X0hZhPy2Lx7OzTPbvEYsdpJmDjUwRHhoAZxMDqSBVm
	YPbFRUs7IXSYndIpsKlU/S8GFH60xU/klHM3Q6ynAxPK3+8srE9r+fJlH59NPJyYb/ON
	5BDEJTWuSpBarZ/zmkQeX2zlycPX8RRsQaVm5gak4gYjosXGiVKkof3OIQxFy/R0ZHBO
	7zsiwR6WtuOQmu+WLsNcXAdStrocb5IARV5X1+Ot+sOAE+EkMH0MPgOc7WyIRJVGmfPL
	NueA==
X-Gm-Message-State: ALoCoQkFVG2361XvbGHsXS5XGlc2mtCVuxwuaXrXMmmUDokqO+ZfUgk8wzXBMQb+q24E/ZHazDQx
X-Received: by 10.68.221.34 with SMTP id qb2mr30952407pbc.47.1423504929725;
	Mon, 09 Feb 2015 10:02:09 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id c2sm16962396pbu.49.2015.02.09.10.02.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:09 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5F22A5661AF; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:46 +0000
Message-Id: <c1462c0530fe6c34ffef87bcde7a363995b503c9.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 16/27] toaster: All machines add a column to link back to machine conf
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:09 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add a column with the "path" to the machine file and add a link back to
the vcs web to view the machine configuration file.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py                      | 7 ++++++-
 lib/toaster/toastergui/templates/machines.html | 1 +
 lib/toaster/toastergui/views.py                | 5 ++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 454f369..ad7a856 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -538,6 +538,11 @@ class Machine(models.Model):
     name = models.CharField(max_length=255)
     description = models.CharField(max_length=255)
 
+    def get_vcs_machine_file_link_url(self):
+        path = 'conf/machine/'+self.name+'.conf'
+
+        return self.layer_version.get_vcs_file_link_url(path)
+
     def __unicode__(self):
         return "Machine " + self.name + "(" + self.description + ")"
 
@@ -901,7 +906,7 @@ class Layer_Version(models.Model):
 
     # code lifted, with adaptations, from the layerindex-web application https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
     def _handle_url_path(self, base_url, path):
-        import re
+        import re, posixpath
         if base_url:
             if self.dirpath:
                 if path:
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index c0d4c6c..e3329bf 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -48,6 +48,7 @@
   <td class="layer"><a href="{%url "layerdetails" o.layer_version.id %}">{{o.layer_version.layer.name}}</a></td>
   <td class="source">{{o.layer_source.name}}</td>
   <td class="branch">{{o.layer_version.commit}}</td>
+  <td class="machinefile"><code>/machine/conf/{{o.name}}.conf</code><a href="{{o.get_vcs_machine_file_link_url}}" target="_blank"><i class="icon-share get-info"></i></a></td>
   <td class="select-or-add">
     <a href="#" class="btn btn-block select-machine-btn" data-machine-name="{{o.name}}" data-layer-version-id="{{o.layer_version.id}}"
         {%if o.layer_version.id not in project_layers %}style="display:none" {%endif%}  >Select machine</a>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9d85a93..c89b67b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2797,7 +2797,6 @@ if toastermain.settings.MANAGED:
         # retrieve the objects that will be displayed in the table; machines a paginator and gets a page range to display
         machine_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
 
-
         context = {
             'objects' : machine_info,
             'project_layers' : project_layers,
@@ -2834,6 +2833,10 @@ if toastermain.settings.MANAGED:
                     'qhelp' : "The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project",
                     'hidden': 1,
                 },
+                {   'name' : 'Machine file',
+                    'clclass' : 'machinefile',
+                    'hidden' : 1,
+                },
                 {   'name': 'Select',
                     'dclass': 'span2',
                     'qhelp': "Add or delete machines to / from your project ",
-- 
1.9.1


