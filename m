Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id CADF272FE2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2017 10:22:21 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Feb 2017 02:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,197,1484035200"; d="scan'208";a="61421078"
Received: from mburny-mobl.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.22.38])
	by orsmga004.jf.intel.com with ESMTP; 23 Feb 2017 02:22:22 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2017 12:22:17 +0200
Message-Id: <1487845339-26473-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1487845339-26473-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1487845339-26473-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 1/3] rpm: support customizing gpg command line
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
X-List-Received-Date: Thu, 23 Feb 2017 10:22:22 -0000

Add a new %_gpg_sign_cmd_extra_args macro that allows customizing the
gpg options used when signing rpm packages. This is needed to be able to
sign packages with gpg 2.1 which requires "--pinentry-mode loopback" to
allow non-interactive signing.

[YOCTO #11054]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 .../0001-macros-add-_gpg_sign_cmd_extra_args.patch | 43 ++++++++++++++++++++++
 meta/recipes-devtools/rpm/rpm_5.4.16.bb            |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 meta/recipes-devtools/rpm/rpm/0001-macros-add-_gpg_sign_cmd_extra_args.patch

diff --git a/meta/recipes-devtools/rpm/rpm/0001-macros-add-_gpg_sign_cmd_extra_args.patch b/meta/recipes-devtools/rpm/rpm/0001-macros-add-_gpg_sign_cmd_extra_args.patch
new file mode 100644
index 0000000..eb43a87
--- /dev/null
+++ b/meta/recipes-devtools/rpm/rpm/0001-macros-add-_gpg_sign_cmd_extra_args.patch
@@ -0,0 +1,43 @@
+From fa9726ff69f86d6a87c4c4bd7e3d2881999a872a Mon Sep 17 00:00:00 2001
+From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
+Date: Thu, 23 Feb 2017 11:14:20 +0200
+Subject: [PATCH] macros: add %_gpg_sign_cmd_extra_args
+
+Similar to what rpm4 has. This macro can be used to customize the
+gpg command line options when signing packages. This is needed for
+gpg 2.1 which requires "--pinentry-mode loopback" to allow
+non-interactive signing.
+
+Upstream-Status: Pending
+
+Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
+---
+ macros/macros.in | 5 ++++-
+ 1 file changed, 4 insertions(+), 1 deletion(-)
+
+diff --git a/macros/macros.in b/macros/macros.in
+index 8bc5840..fda3c66 100644
+--- a/macros/macros.in
++++ b/macros/macros.in
+@@ -524,7 +524,9 @@ $_arbitrary_tags_tests	Foo:Bar
+ %_gpg_passphrase_way %{?_gpg_passphrase:--passphrase "%{_gpg_passphrase}"}%{!?_gpg_passphrase:--passphrase-fd 3}
+ 
+ %__gpg_check_password_cmd	%{__gpg} \
+-	gpg --batch --no-verbose %{_gpg_passphrase_way} -u "%{_gpg_name}" -so -
++	gpg --batch --no-verbose %{_gpg_passphrase_way} \
++	%{?_gpg_sign_cmd_extra_args:%{_gpg_sign_cmd_extra_args}} \
++	-u "%{_gpg_name}" -so -
+ #%__pgp_check_password_cmd	%{__pgp} \
+ #	pgp +batchmode=on +verbose=0 "%{_pgp_name}" -sf
+ #%__pgp5_check_password_cmd	%{__pgp} \
+@@ -532,6 +534,7 @@ $_arbitrary_tags_tests	Foo:Bar
+ 
+ %__gpg_sign_cmd			%{__gpg} \
+ 	gpg --batch --no-verbose --no-armor %{_gpg_passphrase_way}  --no-secmem-warning \
++	%{?_gpg_sign_cmd_extra_args:%{_gpg_sign_cmd_extra_args}} \
+ 	-u "%{_gpg_name}" -sbo %{__signature_filename} %{__plaintext_filename}
+ #%__pgp_sign_cmd			%{__pgp} \
+ #	pgp +batchmode=on +verbose=0 +armor=off \
+-- 
+2.10.2
+
diff --git a/meta/recipes-devtools/rpm/rpm_5.4.16.bb b/meta/recipes-devtools/rpm/rpm_5.4.16.bb
index 883dbc7..17c5818 100644
--- a/meta/recipes-devtools/rpm/rpm_5.4.16.bb
+++ b/meta/recipes-devtools/rpm/rpm_5.4.16.bb
@@ -119,6 +119,7 @@ SRC_URI += " \
 	   file://gcc6-stdlib.patch \
 	   file://0001-system.h-query.c-support-nosignature.patch \
 	   file://rpm-ensure-rpm2cpio-call-rpm-relocation-code.patch \
+	   file://0001-macros-add-_gpg_sign_cmd_extra_args.patch \
 "
 
 # OE specific changes
-- 
2.6.6


