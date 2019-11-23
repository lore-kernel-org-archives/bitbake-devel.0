Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
	[209.85.216.47])
	by mail.openembedded.org (Postfix) with ESMTP id 462A07F6B5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:06 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id f7so4523729pjw.5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XIEkXxV3as/e2gfUKFsW8iQDscmyKhW92PP7lYtMVkc=;
	b=gIubUHRFnV6m93IaWAj46eIaZjJcBeGZdEu/S7/gLwNGRwJGzRfDwcaGAM4UeolzNV
	k1ABoq0H5WzbjAay4fpnNqOZevnVX78cfZsh1Mlb5fpKC/VoxJBw7mE9eSIFTDBHbLHf
	fX9zK/BLG6ZfRoD/Fp8gCrdV+PghMFeU/whgNLmE6RafHGBAYrcHzTPmKj4vJR2tB5Gw
	nVjz9uJTeKg/RlZGK1DW6H80DRz5bprzYuY8YOTiDOC6iTqahs7YMPp3Xw9Zb15uZnsW
	WO/l2seeapIooWDEv1R15ALhz+w4Rypk+72PfuHwmhQsvf/pwbMijRXWmxhO3jxQBjf2
	TXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XIEkXxV3as/e2gfUKFsW8iQDscmyKhW92PP7lYtMVkc=;
	b=CXhabTtfjlzvvEYavlP7mDl8eDGTdcSdrPvnMMCptBF9hmAVazmAmVMvzrGXkyyfbW
	7Bf/QnnXWB6uEPsYfgUWaokanL9qe6FmktD888+KxT4ZOVrEafIpmZuGDD8XnzOTTeW8
	eZTxJuQDggar/Yva597bNt12YiRtFqu5SDN8QVvNj4ct4qAr1A0H1Q7+0uhaPBo2dQQL
	RAycYjtV7IrBexvd3jx89/CTijEZum6+mxXD9xFa8NDdSh4C614ucY8IFhd0HDFWytnx
	kOYHc7pqX/j/StpV5OvMx8G/crdwZVhmZXQgAD4z3u0bkYOhYgpDF3ypLPIZsQIhCupd
	nDwg==
X-Gm-Message-State: APjAAAVbHMyymeJtkARyptCyQfRnMCzf76WYzNfJbiE9wUr3PI4fgqKx
	Qh0P7M5o0C1eUkPJhvJviOriahAl
X-Google-Smtp-Source: APXvYqyggRku5UTofkJCcAYa4r40huH5OX2zNiyyV22FQaXixj+DM5rGwXUMsS5NooLjosWFnKNg7A==
X-Received: by 2002:a17:902:b10b:: with SMTP id
	q11mr20157856plr.172.1574526307039; 
	Sat, 23 Nov 2019 08:25:07 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:06 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:56 -0800
Message-Id: <1574526299-21018-6-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Subject: [1.44][PATCH 6/9] tests: add test for the hashing functions
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:06 -0000

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


