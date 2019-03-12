Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f173.google.com (mail-it1-f173.google.com
	[209.85.166.173])
	by mail.openembedded.org (Postfix) with ESMTP id 213F37C66B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:46 +0000 (UTC)
Received: by mail-it1-f173.google.com with SMTP id k193so7220421ita.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mquWExKTjAbmb823FrPita4YGM761fDdbCifRzgA78s=;
	b=jW6fEQakgvmVzHhuo1zwJCWbUSNJETzOMvs+NAJQ8m22D0UVKTvkw2jfrZumkz+6Ca
	8E4us+5wOIAz2rPLGKe2OVPWc3IxhfB1T4fLa5aYu2rK7lF/EVzsU0qs/tXlEpgcsy0B
	wAmMs3dbgPjSGpUd92BZCNnQzyoJ7C/6nyptg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mquWExKTjAbmb823FrPita4YGM761fDdbCifRzgA78s=;
	b=CjAgepQtn0E4mJz1ngtiFK44sDJfNxZZoGdk0Kmnqx0TUcCuqHNiAcQYSjlwhmW9gY
	HhM4SENewY/gC9MKez3rU5UfeE9LKoow4YnLu7S1ysnZtpPnLe+CVj6ueWTVDrM86qQ7
	JViHfVjrgq0gDKMI59OHuiIqxO5yvyDo1Yh9wjolwUEYaVPoQ8UeiD6mAg6N5Y1pjR+I
	DZh6BW2vMEu4zJ0RD//1QdDO67rJnhqrTeBapyjQHGBpknyQ1Tl26LN/dii7TrRlISEi
	sH0FaP2v/KEA7vs6jqCH/TO8CpXPFuXCRo+f/ri4DKgW5FLTA4j/Q96Mk3K+0K569OK1
	jIsg==
X-Gm-Message-State: APjAAAVadkZPafGPv6O+TBjZ7Jl6BXKfy5FMAuU6i+7fouAGZ+Emb+n5
	MsF0iii3LWgxkbbH7WTcE5gGt2X8uO8=
X-Google-Smtp-Source: APXvYqzV2CeqSlpsvtp/hVLKZJ8dWi5YXp3e4ZL/AuIRYiqAXUecar71qclfGfszSYtYxB35o0Gm9g==
X-Received: by 2002:a24:b30f:: with SMTP id e15mr111149itf.0.1552430567081;
	Tue, 12 Mar 2019 15:42:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:25 -0400
Message-Id: <20190312224627.12667-9-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 08/10] gitsm.py: Fix relative URLs
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:46 -0000

From: Mark Hatle <mark.hatle@windriver.com>

Prior code happened to work with relative URLs, when the code was recently
restructured it caused all relative urls to no longer work.  Restore the prior
code flow for relative support and better comment why that code is there.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 14bb383af0ca98e0e04ec217e537b6a899f3658e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 11 ++++++-----
 lib/bb/tests/fetch.py  |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 86198ee6..faffb4c7 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -98,6 +98,12 @@ class GitSM(Git):
                 uris[m] = md['url']
                 subrevision[m] = module_hash.split()[2]
 
+                # Convert relative to absolute uri based on parent uri
+                if uris[m].startswith('..'):
+                    newud = copy.copy(ud)
+                    newud.path = os.path.realpath(os.path.join(newud.path, uris[m]))
+                    uris[m] = Git._get_repo_url(self, newud)
+
         for module in submodules:
             # Translate the module url into a SRC_URI
 
@@ -120,11 +126,6 @@ class GitSM(Git):
                     # This has to be a file reference
                     proto = "file"
                     url = "gitsm://" + uris[module]
-                    if uris[module].startswith('..'):
-                        # Local on disk relative reference
-                        newud = copy.copy(ud)
-                        newud.path = os.path.realpath(os.path.join(newud.path, md['url']))
-                        url = "gitsm://" + Git._get_repo_url(self, newud)
 
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1497a3cf..de3b0ce7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -894,9 +894,9 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule(self):
         # URL with ssh submodules
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=f53765f515e0eeca569ed385bb1c89ce008bb058"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=132fea6e4dee56b61bcf5721c94e8b2445c6a017"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
-- 
2.17.2


