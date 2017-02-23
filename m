Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B296172FE9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2017 10:22:23 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Feb 2017 02:22:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,197,1484035200"; d="scan'208";a="61421099"
Received: from mburny-mobl.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.22.38])
	by orsmga004.jf.intel.com with ESMTP; 23 Feb 2017 02:22:24 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2017 12:22:19 +0200
Message-Id: <1487845339-26473-4-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1487845339-26473-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1487845339-26473-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 3/3] lib/oe/gpg_sign: fix rpm signing with gpg > 2.1
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
X-List-Received-Date: Thu, 23 Feb 2017 10:22:23 -0000

We need to check the gpg version and alter its command line options
accordingly.

[YOCTO #11054]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 meta/lib/oe/gpg_sign.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta/lib/oe/gpg_sign.py b/meta/lib/oe/gpg_sign.py
index 21dc5ea..b635d8b 100644
--- a/meta/lib/oe/gpg_sign.py
+++ b/meta/lib/oe/gpg_sign.py
@@ -32,6 +32,8 @@ class LocalSigner(object):
 
         cmd = self.rpm_bin + " --addsign --define '_gpg_name %s'  " % keyid
         cmd += "--define '_gpg_passphrase %s' " % passphrase
+        if self.gpg_version > (2,1,):
+            cmd += "--define '_gpg_sign_cmd_extra_args --pinentry-mode=loopback' "
         if self.gpg_bin:
             cmd += "--define '%%__gpg %s' " % self.gpg_bin
         if self.gpg_path:
-- 
2.6.6


