Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id 36C4E7C661
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:47 +0000 (UTC)
Received: by mail-it1-f194.google.com with SMTP id e24so7232830itl.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=C3LOxG0j4tCzpxZmpAGaAOnMbq9tz1zE7JdNQmMYF/4=;
	b=QmLkfy6xhqGS46mrhHWmPB851gBA/kzNc3eaJduNNC42E3uFeUNh72IYAoeq8pEI1c
	SCpxirUpdWCtKj/tm83Ub4VKfL62RI/+fP6ieN73ybW07o+4C87Q3P++nXRvqYpq2O7g
	uQhQrauCx5+vF+XJJ4pcj4xLIDT4PK+SAT4ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=C3LOxG0j4tCzpxZmpAGaAOnMbq9tz1zE7JdNQmMYF/4=;
	b=oQEB9He/dDr4Juwl2EdrXT/I9xhZfh7jIcUIwY9w6vaSbGxg03Zc0Hu3coU8F+jJDK
	ZDgUCbMLbT4QASJpKdDZOhni8i6p3+lzouhWhfl8YVSlWnaSdyPHefqk70QrgTxJqoiJ
	K3VtEklxMDP+8niRxwi9JKUU5PnuL4HR416DjQVGy76c4SQpKU4hsMw6k7Ozih4JCvAn
	wxs2pbsERYxeBItAtyUhlA3/24X2RQcKqXse6zEWqWeY0Xo2eErwzk/cCZdB8uQBx/jX
	CkOYBIhsnzQrzki8drhGBWL+mZUCCJFpR/INv2OQehBeiSp0oV/yIkITGeNz2AmQq0/S
	gQxQ==
X-Gm-Message-State: APjAAAUWMNtRWlMgsqBoV+rfjbrdN4h7bGjI7wDarWHY/Ckoiwyqd//s
	NLgHjjAoNjGbv1V1ddIaD3WaSSw9TtA=
X-Google-Smtp-Source: APXvYqw7/SGmWqJA4oFNDf/QvQfXPe2ubyVkecRtAJzmA2SGD5o/bVUf7vUtCUdUMXhGW6shLksEgw==
X-Received: by 2002:a24:260d:: with SMTP id v13mr99348itv.148.1552430567903;
	Tue, 12 Mar 2019 15:42:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:26 -0400
Message-Id: <20190312224627.12667-10-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 09/10] gitsmy.py: Fix unpack of submodules of submodules
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:47 -0000

From: Mark Hatle <mark.hatle@windriver.com>

If the submodule is in a subdirectory, it needs to have that structure
preserved.  This means the unpack path needs to be in the 'dirname' of the
final path -- since the unpack directory name is specified in the URI.

Additional specific test cases were added to ensure this is working properly
based on two recent error reports.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8c8ecec2a722bc2885e2648d41ac8df07bdf660d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py |  9 ++++++---
 lib/bb/tests/fetch.py  | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index faffb4c7..f45546b4 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -176,12 +176,11 @@ class GitSM(Git):
 
             try:
                 newfetch = Fetch([url], d, cache=False)
-                newfetch.unpack(root=os.path.join(repo_conf, 'modules'))
+                newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 'modules', modpath)))
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (type(e).__name__, str(e)))
                 raise
 
-            newfetch = Fetch([url], d, cache=False)
             local_path = newfetch.localpath(url)
 
             # Correct the submodule references to the local download version...
@@ -191,7 +190,11 @@ class GitSM(Git):
                 runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
 
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
-            runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', modpath))
+            try:
+                runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', modpath))
+            except:
+                logger.error("Unable to set git config core.bare to false for %s" % os.path.join(repo_conf, 'modules', modpath))
+                raise
 
         Git.unpack(self, ud, destdir, d)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index de3b0ce7..e9ad8076 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -912,6 +912,32 @@ class FetcherNetworkTest(FetcherTest):
         if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
             self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule missing')
 
+        # The following external repositories have show failures in fetch and unpack operations
+        # We want to avoid regressions!
+        url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-dvar/config')), msg='Missing submodule config "subprojects/c-dvar"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-list/config')), msg='Missing submodule config "subprojects/c-list"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-rbtree/config')), msg='Missing submodule config "subprojects/c-rbtree"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-sundry/config')), msg='Missing submodule config "subprojects/c-sundry"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-utf8/config')), msg='Missing submodule config "subprojects/c-utf8"')
+
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
+
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
         # Ensure trusted_network returns False when the host IS in the list.
-- 
2.17.2


