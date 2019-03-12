Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id 3CA387C6D9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:48 +0000 (UTC)
Received: by mail-it1-f194.google.com with SMTP id g17so7212700ita.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=5FA0X9m2bntjzx99akSKqXN9UcEY9rgmrGe9A+KlY14=;
	b=XQ4i7PKZGh6aYASWVAA4d3cbncLQc+zpUgPCX0rRm6ecnY5VFhebHl8KgQ6ktcD+U0
	odVJ4qOc4irPhF0agH1gO8QcSU5qesa2RbUIwtLzygQpuMBkdE63VzQEt61pZcCq+KKi
	yHazUE5iRs1+eUkfXHb2UvHn4bG+aHpeV6RWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=5FA0X9m2bntjzx99akSKqXN9UcEY9rgmrGe9A+KlY14=;
	b=uTX4vZXTHS/Zy4jtKd5D8xMmt3lqindz4HarvVjO+qOxKr8CosCT+R0cw/8rKJa0cR
	bgYT0PNbvP7PZ6mSYly3ytZFU/s4ZhNvea7KFe9kZqHa7RulviBF29VdVKbaPVmuRSjW
	gqu8s5ZsHb7djLmHcywc/3sbxOVWS+yuEu6kY4A17NO15MI2+jzXUBjDUkehHVCsDxQk
	L+bVsCW3UeOW50JIYh7rI551q7dMcAlub3ZB7gB04J+P+8CBKXNhnryyBdFTFHUWhSG1
	ERWJ2t65va+ACeMsp3jMBRkspnQZ6Tpp9Pr/TvaRmoNfhPKLUkH1QLTHO3msb809AgBq
	IyUg==
X-Gm-Message-State: APjAAAXGg6KRq3XdIc5sdwsgWnsjtQf1ahwv1XnpNmBQubj7vksDbDar
	cAGc2wxe5FLpA3NpMkkFMiG7oIrm0js=
X-Google-Smtp-Source: APXvYqzIdamvCCjBrqsLU58BS9AjJJR3hAXsd6T2wZvn/0sl/M/ZXQpkcQj76S9s2Uukhm+gOWf47g==
X-Received: by 2002:a24:7a4b:: with SMTP id a72mr101148itc.178.1552430569179; 
	Tue, 12 Mar 2019 15:42:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:27 -0400
Message-Id: <20190312224627.12667-11-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 10/10] gitsm: The fetcher did not process some recursive submodules properly.
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:48 -0000

From: Mark Hatle <mark.hatle@windriver.com>

Move the submodule processing outside of the if statement to avoid any
optimizations that may happen.

Update the test cases to include the additional case, and split the other
test cases into individual tests to make it easier to figure out what
the failure may be.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0ec98c01ae50f95c9c74acf53013ac59e0e72b08)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py |  4 +++-
 lib/bb/tests/fetch.py  | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f45546b4..b21fed26 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -198,6 +198,8 @@ class GitSM(Git):
 
         Git.unpack(self, ud, destdir, d)
 
-        if not ud.bareclone and self.process_submodules(ud, ud.destdir, unpack_submodules, d):
+        ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
+
+        if not ud.bareclone and ret:
             # Run submodule update, this sets up the directories -- without touching the config
             runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e9ad8076..522d2024 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -912,6 +912,7 @@ class FetcherNetworkTest(FetcherTest):
         if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
             self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule missing')
 
+    def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
         url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2"
@@ -928,16 +929,35 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-sundry/config')), msg='Missing submodule config "subprojects/c-sundry"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-utf8/config')), msg='Missing submodule config "subprojects/c-utf8"')
 
+    def test_git_submodule_CLI11(self):
         url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
         fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
 
+    def test_git_submodule_aktualizr(self):
+        url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/partial/extern/isotp-c/config')), msg='Missing submodule config "partial/extern/isotp-c/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/partial/extern/isotp-c/modules/deps/bitfield-c/config')), msg='Missing submodule config "partial/extern/isotp-c/modules/deps/bitfield-c/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'partial/extern/isotp-c/deps/bitfield-c/.git')), msg="Submodule of submodule isotp-c did not unpack properly")
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/tests/tuf-test-vectors/config')), msg='Missing submodule config "tests/tuf-test-vectors/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/googletest/config')), msg='Missing submodule config "third_party/googletest/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/HdrHistogram_c/config')), msg='Missing submodule config "third_party/HdrHistogram_c/config"')
+
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
         # Ensure trusted_network returns False when the host IS in the list.
-- 
2.17.2


