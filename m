Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 19B4C79AA5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 07:17:56 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w9F7HbqI018255
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Oct 2018 00:17:48 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 15 Oct 2018 00:17:27 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Oct 2018 00:14:17 -0700
Message-ID: <c663a32fd81f500aa371ab0469d3b885e8ee0cce.1539558338.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1539558338.git.David.Reyna@windriver.com>
References: <cover.1539558338.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 1/3] toaster: bad link for distro conf file
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
X-List-Received-Date: Mon, 15 Oct 2018 07:18:02 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The distro source path link is missing "conf/distro/", and the
display is using the machine link instead of the distro link.

[YOCTO #12957]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py        | 2 +-
 lib/toaster/toastergui/tables.py | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 849c22e..7720290 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1877,7 +1877,7 @@ class Distro(models.Model):
     description = models.CharField(max_length=255)
 
     def get_vcs_distro_file_link_url(self):
-        path = self.name+'.conf'
+        path = 'conf/distro/%s.conf' % self.name
         return self.layer_version.get_vcs_file_link_url(path)
 
     def __unicode__(self):
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 03bd2ae..9ff756b 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -1615,14 +1615,12 @@ class DistrosTable(ToasterTable):
                         hidden=True,
                         field_name="layer_version__get_vcs_reference")
 
-        wrtemplate_file_template = '''<code>conf/machine/{{data.name}}.conf</code>
-        <a href="{{data.get_vcs_machine_file_link_url}}" target="_blank"><span class="glyphicon glyphicon-new-window"></i></a>'''
-
+        distro_file_template = '''<code>conf/distro/{{data.name}}.conf</code>
+        {% if 'None' not in data.get_vcs_distro_file_link_url %}<a href="{{data.get_vcs_distro_file_link_url}}" target="_blank"><span class="glyphicon glyphicon-new-window"></i></a>{% endif %}'''
         self.add_column(title="Distro file",
                         hidden=True,
                         static_data_name="templatefile",
-                        static_data_template=wrtemplate_file_template)
-
+                        static_data_template=distro_file_template)
 
         self.add_column(title="Select",
                         help_text="Sets the selected distro to the project",
-- 
1.9.1


