Return-Path: <ross.burton@intel.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 90B517F362
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2019 23:57:37 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id b11so4363343wmb.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Nov 2019 15:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6k5ogX/HFeO9TczhfXPRYiZFnaKPfhmGk++C8pGPKSA=;
	b=ooCGsz/eJ0z1vfxW25UFxVqngYzbUAZfFoxzx28Rht3Y+5sVJQSblnAJKUFsLcw9y/
	BghHrEJ6OuYOmZbBb0yVMtJ1MVKpjWjp0+EWD7aMKokbzxlCsr+TCmAkjYhw0VuEHZNw
	w8D9yu1LPvwBY2NnPvRXbBJ2lM9TMW7nRx6lC9mR8OCpLJ3VKlSV5obX4cLkTWAPK9Pk
	GVQ4qLpaflFGNbgIB2Ja2cup+LMIPpqHiv2KLRfFNKgVt3Gag4rnS3WXv9svjcdQD4Jg
	gq/tJ00YGtMaM2xoBLpGeaGukKjz2BKSA/CTJK4X46gsCJuylAy4GdI7afrGi/UC+/S5
	GA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6k5ogX/HFeO9TczhfXPRYiZFnaKPfhmGk++C8pGPKSA=;
	b=gwlJOC48ZRMVID6rL9+Ls1acPFLxSG3bts+MkDa7y+UBQOopF6AffNVqSzauPU8C67
	kFVmObqvOCeZcamHNdMVyTCJIhS/R9lI5KVDMhZaBu1NF9DyEmica2sq9wSMGUjX3Qf6
	7t4ldu4PNcz7kgSWJe/Hcn47fmka8U6Lcec7xIPuEB2RhGpcZDhhG2LdE3h9iaYF1yOM
	9fT77CWe8WRRLbByIlSHswBpjbab6FILjmnuUgn5oHTSTspy7hicsRy0xq2z9xA2oJJZ
	f3Pj5rgSpmNe0R3uonSLpN6nV+YQbvvG8TkVtdPafYQszO1gE5OdR2VUusdNJCFmV4Nv
	zlRw==
X-Gm-Message-State: APjAAAWAnhmKzWa8Yy6HH5owlR5iBbDVlajlFul3xcgETXP7ODnvEwSm
	xlDTQcbOmfuGhQ1KnoptAm1D3ronF6U=
X-Google-Smtp-Source: APXvYqxxPEWEIRl/ggAsa3DazuOpZdedW6JLk8A1mXnzMCKveMfRyzLkOEYQ5BvhsytguCFx7m1cZg==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr5351124wmb.3.1573171057839;
	Thu, 07 Nov 2019 15:57:37 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	n17sm3626275wrp.40.2019.11.07.15.57.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 07 Nov 2019 15:57:36 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Nov 2019 23:57:32 +0000
Message-Id: <20191107235733.25853-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/2] tests: add test for the hashing functions
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
X-List-Received-Date: Thu, 07 Nov 2019 23:57:38 -0000
Content-Transfer-Encoding: 8bit

Add a basic test for bb.utils.md5_file() etc.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/utils.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/bitbake/lib/bb/tests/utils.py b/bitbake/lib/bb/tests/utils.py
index f4adf1d44b0..5c910b4b8eb 100644
--- a/bitbake/lib/bb/tests/utils.py
+++ b/bitbake/lib/bb/tests/utils.py
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
2.20.1


