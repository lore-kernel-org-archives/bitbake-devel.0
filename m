Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TGmUR-0007Q6-NQ
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 09:57:03 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 26 Sep 2012 00:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,489,1344236400"; d="scan'208";a="197235852"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by azsmga001.ch.intel.com with ESMTP; 26 Sep 2012 00:44:12 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Sep 2012 09:49:38 +0300
Message-Id: <1348642178-27405-2-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348642178-27405-1-git-send-email-constantinx.musca@intel.com>
References: <1348642178-27405-1-git-send-email-constantinx.musca@intel.com>
Cc: Constantin Musca <constantinx.musca@intel.com>,
	Constantin Musca <constantin.musca@gmail.com>
Subject: [PATCH] sanity.bbclass: bblayers.conf should be updated automatically
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
X-List-Received-Date: Wed, 26 Sep 2012 07:57:04 -0000

From: Constantin Musca <constantin.musca@gmail.com>

- add check_bblayers_conf bitbake function which does the bblayers.conf
v4 -> v5 update if necessary (every layer should make its specific
bblayers.conf upgrades appending to the check_bblayers_conf function)
- we ask the user to re-run bitbake because we can't trigger reparsing
without being invasive

[YOCTO #3082]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 meta/classes/sanity.bbclass |   56 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/meta/classes/sanity.bbclass b/meta/classes/sanity.bbclass
index 385d733..e25dcf5 100644
--- a/meta/classes/sanity.bbclass
+++ b/meta/classes/sanity.bbclass
@@ -4,6 +4,56 @@
 
 SANITY_REQUIRED_UTILITIES ?= "patch diffstat makeinfo git bzip2 tar gzip gawk chrpath wget cpio"
 
+python check_bblayers_conf() {
+    bblayers_fn = os.path.join(d.getVar('TOPDIR', True), 'conf/bblayers.conf')
+
+    current_lconf = int(d.getVar('LCONF_VERSION', True))
+    if not current_lconf:
+        sys.exit()
+    lconf_version = int(d.getVar('LAYER_CONF_VERSION', True))
+    lines = []
+
+    import re
+    def find_line(pattern, lines):
+        return next(((index, line)
+            for index, line in enumerate(lines)
+            if re.search(pattern, line)), (None, None))
+
+    if current_lconf < 4:
+        sys.exit()
+
+    with open(bblayers_fn, 'r') as f:
+        lines = f.readlines()
+
+    if current_lconf == 4:
+        topdir_var = '$' + '{TOPDIR}'
+        index, bbpath_line = find_line('BBPATH', lines)
+        if bbpath_line:
+            start = bbpath_line.find('"')
+            if start != -1 and (len(bbpath_line) != (start + 1)):
+                if bbpath_line[start + 1] == '"':
+                    lines[index] = (bbpath_line[:start + 1] +
+                                    topdir_var + bbpath_line[start + 1:])
+                else:
+                    if not topdir_var in bbpath_line:
+                        lines[index] = (bbpath_line[:start + 1] +
+                                    topdir_var + ':' + bbpath_line[start + 1:])
+            else:
+                sys.exit()
+        else:
+            index, bbfiles_line = find_line('BBFILES', lines)
+            if bbfiles_line:
+                lines.insert(index, 'BBPATH = "' + topdir_var + '"\n')
+            else:
+                sys.exit()
+
+        index, line = find_line('LCONF_VERSION', lines)
+        current_lconf += 1
+        lines[index] = 'LCONF_VERSION = "%d"\n' % current_lconf
+        with open(bblayers_fn, "w") as f:
+            f.write(''.join(lines))
+}
+
 def raise_sanity_error(msg, d):
     if d.getVar("SANITY_USE_EVENTS", True) == "1":
         bb.event.fire(bb.event.SanityCheckFailed(msg), d)
@@ -337,7 +387,11 @@ def check_sanity(sanity_data):
     current_lconf = sanity_data.getVar('LCONF_VERSION', True)
     lconf_version = sanity_data.getVar('LAYER_CONF_VERSION', True)
     if current_lconf != lconf_version:
-        messages = messages + "Your version of bblayers.conf was generated from an older version of bblayers.conf.sample and there have been updates made to this file. Please compare the two files and merge any changes before continuing.\nMatching the version numbers will remove this message.\n\"meld conf/bblayers.conf ${COREBASE}/meta*/conf/bblayers.conf.sample\" is a good way to visualise the changes.\n"
+        try:
+            bb.build.exec_func("check_bblayers_conf", sanity_data)
+            messages = messages + "Your bblayers.conf has been updated. Please re-run."
+        except Exception:
+            messages = messages + "Your version of bblayers.conf was generated from an older version of bblayers.conf.sample and there have been updates made to this file. Please compare the two files and merge any changes before continuing.\nMatching the version numbers will remove this message.\n\"meld conf/bblayers.conf ${COREBASE}/meta*/conf/bblayers.conf.sample\" is a good way to visualise the changes.\n"
 
     # If we have a site.conf, check it's valid
     if check_conf_exists("conf/site.conf", sanity_data):
-- 
1.7.9.5



