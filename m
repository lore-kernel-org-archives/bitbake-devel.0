Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
	[209.85.216.44])
	by mail.openembedded.org (Postfix) with ESMTP id 996277F67E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:31 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id bo14so5593080pjb.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=XIEkXxV3as/e2gfUKFsW8iQDscmyKhW92PP7lYtMVkc=;
	b=Bm1H8T8cwPbntxQ0f1eDZaQAbMBEo17zSCOv1x8bHqP6+cLz60QvsyxXegtGZv5Z72
	/uo73tFuCbHuFHwfvGP/6OwjGWjYdy/HDSRDlhm9jFJDE/9LK5yIUJGHfuwL9xb/bYac
	OqoE9roDhC7b+O6ZEtmki6RUwNOko8jmflnDjq6TRgTIRBgaFNIKPwcDWgFu2SDG7T7V
	XLfQ4klrnnOoOU37SDNSZkBXtqnWjxjx51f+LN9MH5cP/mKeJ+//7BwHM3I3iSwAIPDV
	tnDfyjhnnPlSTA+PuYhdA+CgjI4LS0D/f1o3XzIV3F7Ci4sg3IXQLroipPeobDQ1pk7g
	MSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=XIEkXxV3as/e2gfUKFsW8iQDscmyKhW92PP7lYtMVkc=;
	b=HtfgPMh5FCV4fb9pWmaPqG/bSftZmC7KSW4SWnn6SIcBRBJwgWMpVirDGyr5f1dAL8
	Z82u4yvblW6/99f4yMLkESB8kQ6sycEmMTwvoyXiqe7KaNJORztaM9O1ULRZzUrIY1kq
	U9NmeVXd/lJt6uusQnYxRnxCL197F6P4L9gVaImWmzf9upMC4R42Hyn+PNfy6J98Ua2v
	XAhTs/76VwGB2qM/yPBsixOrqhA8Klj5NDHxB5nC1e2jqFVnLByIqg/bVFfab5K/kLDK
	iz33a2M5TiBuo3ye/9Sh6pKx1JTJUWJjwnASWyt0pifnRh1RF7SP8/3I2xSV4jkmEw17
	tHCw==
X-Gm-Message-State: APjAAAUcYblxNu5MDWI37y+m/RtvKMckTuYV6SWRK79gyYG7wUgh+tgc
	ifrlKbNY2XcXdq6bnq7t97RjEZin
X-Google-Smtp-Source: APXvYqzZHgUIBLrnQShLypvTC1Lsp9THt0gUJWWGLpJyG3af4qOOBlQZXvSUQSgbf3YMlxt8+yAQkQ==
X-Received: by 2002:a17:90b:1243:: with SMTP id
	gx3mr34324812pjb.98.1574639012599; 
	Sun, 24 Nov 2019 15:43:32 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:32 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:19 -0800
Message-Id: <d535e78b14136e74d6e96ff24d3464d62637459d.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 6/9] tests: add test for the hashing functions
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:32 -0000

From: Ross Burton <ross.burton@intel.com>

Add a basic test for bb.utils.md5_file() etc.

Signed-off-by: Ross Burton <ross.burton@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/tests/utils.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index f4adf1d..5c910b4 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -103,6 +103,32 @@ class Path(unittest.TestCase):
             result = bb.utils._check_unsafe_delete_path(arg1)
             self.assertEqual(result, correctresult, '_check_unsafe_delete_path("%s") != %s' % (arg1, correctresult))
 
+class Checksum(unittest.TestCase):
+    filler = b"Shiver me timbers square-rigged spike Gold Road galleon bilge water boatswain wherry jack pirate. Mizzenmast rum lad Privateer jack salmagundi hang the jib piracy Pieces of Eight Corsair. Parrel marooned black spot yawl provost quarterdeck cable no prey, no pay spirits lateen sail."
+
+    def test_md5(self):
+        import hashlib
+        with tempfile.NamedTemporaryFile() as f:
+            f.write(self.filler)
+            f.flush()
+            checksum = bb.utils.md5_file(f.name)
+            self.assertEqual(checksum, "bd572cd5de30a785f4efcb6eaf5089e3")
+
+    def test_sha1(self):
+        import hashlib
+        with tempfile.NamedTemporaryFile() as f:
+            f.write(self.filler)
+            f.flush()
+            checksum = bb.utils.sha1_file(f.name)
+            self.assertEqual(checksum, "249eb8fd654732ea836d5e702d7aa567898eca71")
+
+    def test_sha256(self):
+        import hashlib
+        with tempfile.NamedTemporaryFile() as f:
+            f.write(self.filler)
+            f.flush()
+            checksum = bb.utils.sha256_file(f.name)
+            self.assertEqual(checksum, "fcfbae8bf6b721dbb9d2dc6a9334a58f2031a9a9b302999243f99da4d7f12d0f")
 
 class EditMetadataFile(unittest.TestCase):
     _origfile = """
-- 
2.7.4


