Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UKnqP-0005Lg-2P
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Mar 2013 11:44:38 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Mar 2013 03:27:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,917,1355126400"; d="scan'208";a="219373037"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Mar 2013 03:27:10 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Mar 2013 12:27:51 +0200
Message-Id: <1364380074-16382-4-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 3/6] packageinfo.bbclass : extended functionality
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 27 Mar 2013 10:44:50 -0000

Extended the functionality of packageinfo.bbclass
so that the sistem retrieves information about the
files brought in by each package. This is done
(without activating buildhistory) by parsing
the packages-split directory for each package.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 meta/classes/packageinfo.bbclass |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/meta/classes/packageinfo.bbclass b/meta/classes/packageinfo.bbclass
index bd7b249..f55af87 100644
--- a/meta/classes/packageinfo.bbclass
+++ b/meta/classes/packageinfo.bbclass
@@ -8,6 +8,25 @@ python packageinfo_handler () {
         package_archs = e.data.getVar('PACKAGE_ARCHS', True)
         packaging = e.data.getVar('PACKAGE_CLASSES', True).split()[0].split('_')[1]
         deploy_dir = e.data.getVar('DEPLOY_DIR', True) + '/' + packaging
+        dirs = os.listdir(tmpdir + '/work/')
+        pkgsplit_dir = tmpdir + '/work/'
+        items = {}
+        passing = ''
+        for directories in dirs:
+                temp_dirs = os.listdir(pkgsplit_dir + directories)
+                for temps1 in temp_dirs:
+                        if os.path.exists(pkgsplit_dir + directories + '/' + temps1 + '/' + os.listdir(pkgsplit_dir + directories + '/' + temps1)[0] + '/packages-split'):
+                                oau = pkgsplit_dir + directories + '/' + temps1 + '/' + os.listdir(pkgsplit_dir + directories + '/' + temps1)[0] + '/packages-split'
+                                for temps in os.listdir(oau):
+                                        items[temps] = {}
+                                        for path, dirs, files in os.walk(pkgsplit_dir + directories + '/' + temps1 + '/' + os.listdir(pkgsplit_dir + directories + '/' + temps1)[0] + '/packages-split' + '/' + temps):                                                   
+                                                        file_list = []
+                                                        if os.listdir(path) != []:
+                                                                items[temps][path] = []                                                   
+                                                                for f in files:
+                                                                        file_list.append(f)
+                                                                items[temps][path].append(file_list)
+                                           
         for arch in package_archs.split():
             pkgdata_dir = tmpdir + '/pkgdata/' + arch + target_vendor + '-' + target_os + '/runtime/'
             if os.path.exists(pkgdata_dir):
@@ -19,6 +38,8 @@ python packageinfo_handler () {
                             try:
                                 sdata = oe.packagedata.read_pkgdatafile(pkgdatafile)
                                 sdata['PKG'] = pkgname
+                                if pkgname in items:
+                                        sdata['FILES_INFO'] = items[pkgname]        
                                 pkginfolist.append(sdata)
                             except Exception as e:
                                 bb.warn("Failed to read pkgdata file %s: %s: %s" % (pkgdatafile, e.__class__, str(e)))
-- 
1.7.9.5



