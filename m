Return-Path: <cristian.iorga@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 1CA8962222
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 11:05:25 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 31 May 2013 04:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,778,1363158000"; d="scan'208";a="310504208"
Received: from sentry.rb.intel.com ([10.237.105.54])
	by azsmga001.ch.intel.com with ESMTP; 31 May 2013 04:05:24 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 May 2013 14:06:24 +0300
Message-Id: <1369998384-20229-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH 1/2] autotools.bbclass: Factor out aclocal copying function
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 31 May 2013 11:05:26 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Some recipes may need to manually call the aclocal copying
functionality so factor this out into a function.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 meta/classes/autotools.bbclass |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/meta/classes/autotools.bbclass b/meta/classes/autotools.bbclass
index b19a871..66c0f5d 100644
--- a/meta/classes/autotools.bbclass
+++ b/meta/classes/autotools.bbclass
@@ -127,6 +127,26 @@ EXTRACONFFUNCS ??= ""
 do_configure[prefuncs] += "autotools_preconfigure ${EXTRACONFFUNCS}"
 do_configure[postfuncs] += "autotools_postconfigure"
 
+ACLOCALDIR = "${B}/aclocal-copy"
+
+autotools_copy_aclocal () {
+	# Remove any previous copy of the m4 macros
+	rm -rf ${ACLOCALDIR}/
+
+	# The aclocal directory could get modified by other processes
+	# uninstalling data from the sysroot. See Yocto #861 for details.
+	# We avoid this by taking a copy here and then files cannot disappear.
+	# We copy native first, then target. This avoids certain races since cp-noerror
+	# won't overwrite existing files.
+	mkdir -p ${ACLOCALDIR}/
+	if [ -d ${STAGING_DATADIR_NATIVE}/aclocal ]; then
+		cp-noerror ${STAGING_DATADIR_NATIVE}/aclocal/ ${ACLOCALDIR}/
+	fi
+	if [ -d ${STAGING_DATADIR}/aclocal -a "${STAGING_DATADIR_NATIVE}/aclocal" != "${STAGING_DATADIR}/aclocal" ]; then
+		cp-noerror ${STAGING_DATADIR}/aclocal/ ${ACLOCALDIR}/
+	fi
+}
+
 autotools_do_configure() {
 	# WARNING: gross hack follows:
 	# An autotools built package generally needs these scripts, however only
@@ -142,9 +162,8 @@ autotools_do_configure() {
 	if [ -e ${S}/configure.in -o -e ${S}/configure.ac ]; then
 		olddir=`pwd`
 		cd ${S}
-		# Remove any previous copy of the m4 macros
-		rm -rf ${B}/aclocal-copy/
-		ACLOCAL="aclocal --system-acdir=${B}/aclocal-copy/"
+		autotools_copy_aclocal
+		ACLOCAL="aclocal --system-acdir=${ACLOCALDIR}/"
 		if [ x"${acpaths}" = xdefault ]; then
 			acpaths=
 			for i in `find ${S} -maxdepth 2 -name \*.m4|grep -v 'aclocal.m4'| \
@@ -160,18 +179,6 @@ autotools_do_configure() {
 		if [ -d ${STAGING_DATADIR_NATIVE}/aclocal-$AUTOV ]; then
 			ACLOCAL="$ACLOCAL --automake-acdir=${STAGING_DATADIR_NATIVE}/aclocal-$AUTOV"
 		fi
-		# The aclocal directory could get modified by other processes 
-		# uninstalling data from the sysroot. See Yocto #861 for details.
-		# We avoid this by taking a copy here and then files cannot disappear.
-		# We copy native first, then target. This avoids certain races since cp-noerror
-		# won't overwrite existing files.
-		mkdir -p ${B}/aclocal-copy/
-		if [ -d ${STAGING_DATADIR_NATIVE}/aclocal ]; then
-			cp-noerror ${STAGING_DATADIR_NATIVE}/aclocal/ ${B}/aclocal-copy/
-		fi
-		if [ -d ${STAGING_DATADIR}/aclocal -a "${STAGING_DATADIR_NATIVE}/aclocal" != "${STAGING_DATADIR}/aclocal" ]; then
-			cp-noerror ${STAGING_DATADIR}/aclocal/ ${B}/aclocal-copy/
-		fi
 		# autoreconf is too shy to overwrite aclocal.m4 if it doesn't look
 		# like it was auto-generated.  Work around this by blowing it away
 		# by hand, unless the package specifically asked not to run aclocal.
-- 
1.7.10.4


