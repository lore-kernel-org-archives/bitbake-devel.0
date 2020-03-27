Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web12.172.1585349571549067863
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Mar 2020 15:52:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: david.reyna@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 02RMqUF5021150
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2020 15:52:41 -0700
Received: from honig-Precision-T5600.corp.ad.wrs.com (147.11.209.184) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 15:52:20 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 4/4] toaster: fix for import build directory with var refs in BBLAYERS
Date: Fri, 27 Mar 2020 15:51:02 -0700
Message-ID: <94595977ba28d8050ebe636f2844c3d757b5e806.1585348962.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585348962.git.david.reyna@windriver.com>
References: <cover.1585348962.git.david.reyna@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Paul Eggleton <paul.eggleton@linux.intel.com>

Update importing a build directory to support where bblayers.conf
sets BBLAYERS to a value that includes a variable reference e.g.:
  BBLAYERS = "${TOPDIR}/../meta \
              ${TOPDIR}/../meta-selftest"

[YOCTO #13707]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 .../toastermain/management/commands/buildimport.py   | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 7718caa57a..59da6ff7ac 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -114,6 +114,15 @@ class Command(BaseCommand):
             help='command (configure,reconfigure,import)',
             )
 
+    def get_var(self, varname):
+        value = self.vars.get(varname, '')
+        if value:
+            varrefs = re.findall('\${([^}]*)}', value)
+            for ref in varrefs:
+                if ref in self.vars:
+                    value = value.replace('${%s}' % ref, self.vars[ref])
+        return value
+
     # Extract the bb variables from a conf file
     def scan_conf(self,fn):
         vars = self.vars
@@ -241,7 +250,7 @@ class Command(BaseCommand):
     # Apply table of all layer versions
     def extract_bblayers(self):
         # set up the constants
-        bblayer_str = self.vars['BBLAYERS']
+        bblayer_str = self.get_var('BBLAYERS')
         TOASTER_DIR = os.environ.get('TOASTER_DIR')
         INSTALL_CLONE_PREFIX = os.path.dirname(TOASTER_DIR) + "/"
         TOASTER_CLONE_PREFIX = TOASTER_DIR + "/_toaster_clones/"
@@ -421,6 +430,7 @@ class Command(BaseCommand):
 
     # Scan the project's conf files (if any)
     def scan_conf_variables(self,project_path):
+        self.vars['TOPDIR'] = project_path
         # scan the project's settings, add any new layers or variables
         if os.path.isfile("%s/conf/local.conf" % project_path):
             self.scan_conf("%s/conf/local.conf" % project_path)
-- 
2.20.1

