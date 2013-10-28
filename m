Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 7140B6D13A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Oct 2013 11:23:20 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 28 Oct 2013 04:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="381086937"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by azsmga001.ch.intel.com with ESMTP; 28 Oct 2013 04:23:20 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Oct 2013 13:28:16 +0200
Message-Id: <1382959696-24874-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] toaster: set INHERIT var in the script that starts toaster
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
X-List-Received-Date: Mon, 28 Oct 2013 11:23:20 -0000

In order to use toaster, now you have to set INHERIT+="toaster buildhistory"
To keep it simple, I've done some changes in order to automate it. When toaster
is started, this line is added to local.conf. When it is stoped, it is removed.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/bin/toaster |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 16de52b..639b7b7 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -49,6 +49,21 @@ function webserverStartAll()
         return $retval
 }
 
+#Helper functions to add/remove a line from a configuration file
+
+function addtoConfiguration()
+{
+        echo "#added by toaster" >> ${BUILDDIR}/conf/$2
+        echo $1 >> ${BUILDDIR}/conf/$2
+}
+
+function removefromConfiguration()
+{
+        comment_line=$(grep -n "#added by toaster" "$file" | cut -f1 -d:)
+        variable_line=$((comment_line+1))
+        lines="${comment_line},${variable_line}"
+        sed -i "$lines"'d' ${BUILDDIR}/conf/$1
+}
 
 # We make sure we're running in the current shell and in a good environment
 
@@ -120,6 +135,7 @@ fi
 
 case $CMD in
     start )
+        addtoConfiguration "INHERIT+=\"toaster buildhistory\"" local.conf
         webserverStartAll || return 4
         unset BBSERVER
         bitbake --server-only -t xmlrpc -B localhost:8200
@@ -138,6 +154,7 @@ case $CMD in
         webserverKillAll
         # force stop any misbehaving bitbake server
         lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
+        removefromConfiguration local.conf
     ;;
 esac
 
-- 
1.7.9.5


