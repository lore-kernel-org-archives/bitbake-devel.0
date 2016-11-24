Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
	[209.85.223.180])
	by mail.openembedded.org (Postfix) with ESMTP id 3274971AE9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 07:21:05 +0000 (UTC)
Received: by mail-io0-f180.google.com with SMTP id a124so65397277ioe.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2016 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=MFCIMBVbCzd3NcKcglWhhH1FJgvjNI5iXcwbsXa8YIY=;
	b=Mw/VlUJ3zBlgnlB7UqpdrDb/wd0LpwS2SkWfW3KjjyJggOYuBPxeWLHzRaOPRShPwS
	osjp1+YKGoHGMfNMZAxnlUA1DmsUX6m4I2s4ElImNRgN1G2291rOJLM0UD4TZg8BHcOw
	qE9zbhhDvr5gpJIIOl/CnB1cuq5Kuuu4csa8KmF0OIZkPY5DavVXA34GJUqbahE7LGOZ
	ggD4t8aH1GXvuC9efnnEy0fFOtI4tDEaDpVnzT6q0qpUMQvCA4AAq8h7LqIKjyRJkenz
	SmAP/3RS8epnoFF/mZzPYmpFIheSOO2pZVLNCGPpzQ19tY5PT8AzRnoRiZCxwfmU4YVs
	Dy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=MFCIMBVbCzd3NcKcglWhhH1FJgvjNI5iXcwbsXa8YIY=;
	b=VZS9+92OzoRR8wbzpkU1PbkbvbKtukGZbmC8s+BxlkOuW98IONSCSz+5Qu71k+5Die
	EN9o8viBcP9G/HtIb/dqSzWCDWJ1YRzzNmMpmRgX9lmigrHju1nvQTL0pIHNVVswkpZU
	HJrZO2hUnO+mzn74Ig5QWPe7MKtaDOTAsVvba/nGoaACUXZKtRHaVFWPwDTS2jGVMQFR
	InhBxi96VL4ZSubngADtCPlqEGyMvOczJyr+4kwN6Nz3Z+eZXFjHxcjRSD3R4iyPOLN0
	fG7V2AD+c3x+ZI5w1mpJpWB6lux9TjwDgVf1eyij9bjbMzYh/JCfZtgHvj3vP8OvV71I
	6O4w==
X-Gm-Message-State: AKaTC03JjMSpwtwpfSTvEQD7AxpSqlrmYvzKDWe4j3PQ3CBIXh39ZzxGSaczbivByBkCaJEi
X-Received: by 10.36.152.68 with SMTP id n65mr807955itd.93.1479972066337;
	Wed, 23 Nov 2016 23:21:06 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8D6D7.dip0.t-ipconnect.de.
	[93.232.214.215])
	by smtp.gmail.com with ESMTPSA id t20sm2314035ita.7.2016.11.23.23.21.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Nov 2016 23:21:05 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 08:20:55 +0100
Message-Id: <1479972055-1998-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] pseudo: include fix for xattr corruption
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
X-List-Received-Date: Thu, 24 Nov 2016 07:21:07 -0000

pseudo_1.8.1.bb gets the backported patch and pseudo_git.bb gets
updated to include the commit, which currently is the most recent
commit on the pseudo master branch.

There's just one problem - it breaks other cases:

foo: security.SMACK64: No such attribute

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 .../pseudo/files/More-correctly-fix-xattrs.patch   | 37 ++++++++++++++++++++++
 meta/recipes-devtools/pseudo/pseudo_1.8.1.bb       |  1 +
 meta/recipes-devtools/pseudo/pseudo_git.bb         |  2 +-
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 meta/recipes-devtools/pseudo/files/More-correctly-fix-xattrs.patch

diff --git a/meta/recipes-devtools/pseudo/files/More-correctly-fix-xattrs.patch b/meta/recipes-devtools/pseudo/files/More-correctly-fix-xattrs.patch
new file mode 100644
index 0000000..3d178f9
--- /dev/null
+++ b/meta/recipes-devtools/pseudo/files/More-correctly-fix-xattrs.patch
@@ -0,0 +1,37 @@
+From 45eca34c754d416a38bee90fb2d3c110a0b6cc5f Mon Sep 17 00:00:00 2001
+From: Seebs <seebs@seebs.net>
+Date: Thu, 3 Nov 2016 11:36:12 -0500
+Subject: [PATCH] More-correctly fix xattrs
+
+Fix provided by Patrick Ohly <patrick.ohly@intel.com>. This resolves
+the actual cause of the path length mismatches, and explains why
+I couldn't quite explain why the previous one had only sometimes
+worked, also why it showed up on directories but not plain files.
+
+Signed-off-by: Seebs <seebs@seebs.net>
+
+Fixes [YOCTO #10623]
+
+Upstream-Status: Backport [commit 45eca34c754d416a38bee90fb2d3c110a0b6cc5f]
+
+Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
+---
+ pseudo_client.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/pseudo_client.c b/pseudo_client.c
+index 6a08df3..b1a00fa 100644
+--- a/pseudo_client.c
++++ b/pseudo_client.c
+@@ -1676,7 +1676,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
+ 	 * empty path for that.
+ 	 */
+ 	if (path_extra_1) {
+-		size_t full_len = path_extra_1len + 1 + pathlen;
++		size_t full_len = path_extra_1len + 1 + pathlen - strip_slash;
+ 		size_t partial_len = pathlen - 1 - strip_slash;
+ 		if (path_extra_2) {
+ 			full_len += path_extra_2len + 1;
+-- 
+2.1.4
+
diff --git a/meta/recipes-devtools/pseudo/pseudo_1.8.1.bb b/meta/recipes-devtools/pseudo/pseudo_1.8.1.bb
index fb70034..90b53c0 100644
--- a/meta/recipes-devtools/pseudo/pseudo_1.8.1.bb
+++ b/meta/recipes-devtools/pseudo/pseudo_1.8.1.bb
@@ -10,6 +10,7 @@ SRC_URI = "http://downloads.yoctoproject.org/releases/pseudo/${BPN}-${PV}.tar.bz
            file://0001-Quiet-diagnostics-during-startup-for-pseudo-d.patch \
            file://0002-Use-correct-file-descriptor.patch \
            file://0003-Fix-renameat-parallel-to-previous-fix-to-rename.patch \
+           file://More-correctly-fix-xattrs.patch \
            "
 
 SRC_URI[md5sum] = "ee38e4fb62ff88ad067b1a5a3825bac7"
diff --git a/meta/recipes-devtools/pseudo/pseudo_git.bb b/meta/recipes-devtools/pseudo/pseudo_git.bb
index 8110b1a..ac923bb 100644
--- a/meta/recipes-devtools/pseudo/pseudo_git.bb
+++ b/meta/recipes-devtools/pseudo/pseudo_git.bb
@@ -1,6 +1,6 @@
 require pseudo.inc
 
-SRCREV = "befc6dbd6469d428c9e0830dbe51bdf7ac39d9ae"
+SRCREV = "45eca34c754d416a38bee90fb2d3c110a0b6cc5f"
 PV = "1.8.1+git${SRCPV}"
 
 DEFAULT_PREFERENCE = "-1"
-- 
2.1.4


