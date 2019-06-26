Return-Path: <luca.boccassi@gmail.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id C49836D147
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 15:12:19 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id k11so3196675wrl.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=fSdHaoTLD+UlRKG+IAf2zkGgwGpEnz4+fUqtp0jz0dM=;
	b=oBOOtyrXMqp8rcZ3u4gSwdqCxX+1jKJVocKeEsvfQfpZ5Q7vZcxd1JNjiswz5jOsqC
	dMxcztKvFq8AG25D0LTg6S95udn7Tgd6gprW5Z49kAuHplvuRjDP4Q7pvMCiRGUBgO29
	PAFriHm2KBbFvhhJge3McNVQIFNtw7qBtk9hGMz1FZPGWqQQAHAp7sIuyUeUYXIPXcSl
	UnPvXfb0Vsv4SEjXqskjPuYvwlIoOxHvAt4jbbb8HyLTY7CGIbuzOI0OSSJP/mNYoLF+
	w3K95tCB5+zn0J+67ORi77Jkyu9P0MiCWn6iBMEsuQttNUWJIm34kDtj6K1329ZfmBLP
	T+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=fSdHaoTLD+UlRKG+IAf2zkGgwGpEnz4+fUqtp0jz0dM=;
	b=rdu10JnQ+D9Znll1ouu6mUbKOnSSkYkKgms6nAyTvUcAUFP347G4jftF6/IVYxx9Gi
	s7MZroauVNjwxS2IO39WdLTW48ZaRmdws60kSdMnwLbQDlW4AKeH2uzF+1PPDsikVS7p
	3d0xlwuxKQ5+cx6nlPWQDGXQndQd1+uDVt4pCnwwALyqyjY4RYNIeuHn1bLfih/a5Tb0
	JZKQnvz40CIgiDUCTIHGve1RNt87QBcpvLRMNA8pVDWvhNpHQ9Z9l1pWlQeNtk2ZaY2Q
	7F0Qle3GKbyODwVk3n9BGub+qRO3LhIRmsRgt6hhIkXJujS3qDtAQr2q29IpyGnrvob3
	WvpA==
X-Gm-Message-State: APjAAAXQa0J32uhbtnBNq4ugbedfjiwsfYUGaSafRuqjAIVAXvsFiOTI
	25qNSYiNJ30Nt071gTUfkyt5lbV2
X-Google-Smtp-Source: APXvYqwZEiZx45CJPbDqj904qJAQDAGZkVJjZkKEj9yVbvVbbzeCddObET+vAQ75S1Oc0rBbc577Cw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr3992135wrw.309.1561561940034; 
	Wed, 26 Jun 2019 08:12:20 -0700 (PDT)
Received: from localhost ([88.98.246.218]) by smtp.gmail.com with ESMTPSA id
	y44sm17218362wrd.13.2019.06.26.08.12.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 26 Jun 2019 08:12:19 -0700 (PDT)
From: luca.boccassi@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Jun 2019 16:12:17 +0100
Message-Id: <20190626151217.16298-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] tests/fetch.py: add missing skipIfNoNetwork tags to tests that try to git clone
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
X-List-Received-Date: Wed, 26 Jun 2019 15:12:20 -0000
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <luca.boccassi@microsoft.com>

test_git_submodule_dbus_broker, test_git_submodule_CLI11, test_git_submodule_update_CLI11,
test_git_submodule_aktualizr and test_git_submodule_iotedge try to access the network via
git clone, which fails when there is no network available. Add the relevant skip tag.

Signed-off-by: Luca Boccassi <luca.boccassi@microsoft.com>
---
 bitbake/lib/bb/tests/fetch.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 16f975b137..23c6338a46 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -899,6 +899,7 @@ class FetcherNetworkTest(FetcherTest):
         if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
             self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule missing')
 
+    @skipIfNoNetwork()
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
@@ -916,6 +917,7 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-sundry/config')), msg='Missing submodule config "subprojects/c-sundry"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-utf8/config')), msg='Missing submodule config "subprojects/c-utf8"')
 
+    @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
         url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
         fetcher = bb.fetch.Fetch([url], self.d)
@@ -929,6 +931,7 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
 
+    @skipIfNoNetwork()
     def test_git_submodule_update_CLI11(self):
         """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
         url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714"
@@ -948,6 +951,7 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
 
+    @skipIfNoNetwork()
     def test_git_submodule_aktualizr(self):
         url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
         fetcher = bb.fetch.Fetch([url], self.d)
@@ -964,6 +968,7 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/googletest/config')), msg='Missing submodule config "third_party/googletest/config"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/HdrHistogram_c/config')), msg='Missing submodule config "third_party/HdrHistogram_c/config"')
 
+    @skipIfNoNetwork()
     def test_git_submodule_iotedge(self):
         """ Prevent regression on deeply nested submodules not being checked out properly, even though they were fetched. """
 
-- 
2.20.1


