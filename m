Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
	[209.85.166.172])
	by mail.openembedded.org (Postfix) with ESMTP id AFE697F7C1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2019 15:50:39 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id q15so18050322ils.8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2019 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=1cqvzWJ9dX1ZZEYG0fdTN8LbRXdJRNF3FHOhINihRE4=;
	b=lNTEeoPpmBw7kxtKePe2S8d970+VhKl5PmcD0SGchPACkGNqImfipfTra8xycmZ7Qu
	kYdIKSuE1RZrifbIwh4X6tesXq8nfgksdZiibdEkvsQg1zUeAH/k9PZnH3IgPZz8bbGt
	VJDrmMYzXoBTBjIZpJG1d241rit2T/QXSQPf0tczRFTyNDXhU2/+QXpRx6pj7bFlEF9x
	/oBxjnW0QzpoAY2lggMYIvPxGjL+jdpBLmMB16zeLgOIJ7mXxoHLVQIpIQiPvXW3xWly
	9wF0PdI6DMIwUwJPg7ZH8G5InomDreBY51z4pdK4WxITtPJE5fKMc1V5Zvf8+S3r5G43
	44eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=1cqvzWJ9dX1ZZEYG0fdTN8LbRXdJRNF3FHOhINihRE4=;
	b=aS+oP0/Ql1Nuea0g6sOdhzy+3bgJH9mKvV2eEDr2cfLEEmvGAIILbn9s3KoMG2xXj0
	5Z+CeipDpUYrtNHMtkeREEpuE5qx8QoEx6IEuGuvstBjeYFqCUTpS14JyEwWap0rnpd8
	rSGip0EVNwf9q/CUivSrtVYg7s8NbPIw/uixMCrQDIOsuWGCr3YWUFPvYvDe954m34Ix
	lZsvp5k0ayVMZwd28iUqJ1fbDJ+N6Md+C4mhcw6x5cIBtlXgho9SRZ17HQiMSsalJlu5
	mGHb5M2lWSVfsw29Al7Y5bB7e9jylVZ3j/vlHUQ0zrFGfMODd0jXeNQbiaX6IMIe7cei
	CEzw==
X-Gm-Message-State: APjAAAXOfbiwDvuLwENO4ADLUk0OHBl+abaeILef2rprweNCK3EOlb9S
	/oc+tcsp+geRjEc01LJXBeMls6qJ36s=
X-Google-Smtp-Source: APXvYqzFxSSypl7yL+pHF56rT+qeKHyDylDOFhFICHeqSCTmZRy2o/MrVyvUOJWnD6uTCr2z1eJBTQ==
X-Received: by 2002:a92:5a45:: with SMTP id o66mr24272944ilb.67.1574783440338; 
	Tue, 26 Nov 2019 07:50:40 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id y1sm2708700iob.42.2019.11.26.07.50.39
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 26 Nov 2019 07:50:39 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Nov 2019 09:50:36 -0600
Message-Id: <20191126155036.1541537-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Subject: [PATCH] hashserv: Merge divergent output hashes
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
X-List-Received-Date: Tue, 26 Nov 2019 15:50:39 -0000
Content-Transfer-Encoding: 8bit

Instructs the hash equivalence server to merge diverging output hashes
to the same unihash when one is reported that unifies them. The primary
use for this is -cross and -native recipes where the outputs will never
match on different host architectures, but the unihashes need to
converge.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/__init__.py |  1 +
 bitbake/lib/hashserv/server.py   | 31 +++++++++++++++++++++++--
 bitbake/lib/hashserv/tests.py    | 39 ++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index c3318620f54..218a54a04d8 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -48,6 +48,7 @@ def setup_database(database, sync=True):
         # Create new indexes
         cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup_v2 ON tasks_v2 (method, taskhash, created)')
         cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup_v2 ON tasks_v2 (method, outhash)')
+        cursor.execute('CREATE INDEX IF NOT EXISTS unihash_lookup_v2 ON tasks_v2 (method, unihash)')
 
     return db
 
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index 0aff77688e4..0a294b4b1a0 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -267,9 +267,36 @@ class ServerClient(object):
                 # If a row matching the outhash was found, the unihash for
                 # the new taskhash should be the same as that one.
                 # Otherwise the caller provided unihash is used.
-                unihash = data['unihash']
-                if row is not None:
+                if row is not None and data['unihash'] != row['unihash']:
+                    # Update unihashes to ensure all branches are converging on
+                    # the same unihash. This is generally a bad thing because
+                    # it means that builds are not reproducible, but it
+                    # occasionally is unavoidable such as in the case of -cross
+                    # and -native tasks for different build host architectures.
+                    # For example, take the following taskhashes that produce
+                    # the given outhashes and unihashes:
+                    #
+                    #  taskhash outhash unihash
+                    #  A        Z       1
+                    #  B        Y       2
+                    #  C        Y       3 -> 2
+                    #  B        Z       2 -> 1
+                    #
+                    # In this case, the B task isn't being built reproducibly,
+                    # but for the second B the server sees it matches the
+                    # outhash of A, and reports that the unihash should be
+                    # changed from 2 to 1.
+                    #
+                    # The inconsistency is that there are still entries that
+                    # refer to unihash 2. These should be remapped to unihash
+                    # 1, since the latest entry shows that these are
+                    # equivalent.
+                    cursor.execute('''UPDATE tasks_v2 SET unihash=:new_unihash WHERE method=:method AND unihash=:old_unihash''',
+                            {'method': data['method'], 'new_unihash': row['unihash'], 'old_unihash': data['unihash']})
+
                     unihash = row['unihash']
+                else:
+                    unihash = data['unihash']
 
                 insert_data = {
                     'method': data['method'],
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index a5472a996d2..ee9107a9aa8 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -99,6 +99,45 @@ class TestHashEquivalenceServer(object):
         result = self.client.get_unihash(self.METHOD, taskhash)
         self.assertEqual(result, unihash)
 
+    def test_hash_merging(self):
+        # Verify that unihashes are correctly merged together when diverging
+        # hashes are found. Uses the following table which describes how each
+        # task is reported:
+        #
+        #  taskhash outhash unihash
+        #  A        Z       A
+        #  B        Y       B
+        #  C        Y       C -> B
+        #  B        Z       B -> A
+        #
+        A_taskhash = "A"
+        B_taskhash = "B"
+        C_taskhash = "C"
+        Z_outhash = "Z"
+        Y_outhash = "Y"
+
+        result = self.client.report_unihash(A_taskhash, self.METHOD, Z_outhash, A_taskhash)
+        self.assertEqual(result['unihash'], A_taskhash, 'Server reported bad unihash change for task A')
+
+        result = self.client.report_unihash(B_taskhash, self.METHOD, Y_outhash, B_taskhash)
+        self.assertEqual(result['unihash'], B_taskhash, 'Server reported bad unihash change for task A')
+
+        result = self.client.report_unihash(C_taskhash, self.METHOD, Y_outhash, C_taskhash)
+        self.assertEqual(result['unihash'], B_taskhash, 'Server reported bad unihash change for task C')
+
+        # Report a second B with the Z outhash. It should be change to A's unihash
+        result = self.client.report_unihash(B_taskhash, self.METHOD, Z_outhash, B_taskhash)
+        self.assertEqual(result['unihash'], A_taskhash, 'Server reported bad unihash change for task B')
+
+        # The unihash for C should also be A's unihash
+        result = self.client.get_unihash(self.METHOD, C_taskhash)
+        self.assertEqual(result, A_taskhash, 'Server returned bad unihash for task C')
+
+        # The reported unihash for B should also be A. NOTE: this *should*
+        # return the first B reported because it is older
+        result = self.client.get_unihash(self.METHOD, B_taskhash)
+        self.assertEqual(result, A_taskhash, 'Server returned bad unihash for task B')
+
     def test_stress(self):
         def query_server(failures):
             client = Client(self.server.address)
-- 
2.23.0


