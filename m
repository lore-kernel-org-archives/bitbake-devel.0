Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD13FB5168
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 20:24:57 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64178.1775507090714686345
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 13:24:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=gTuaRyoZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-202604062024487d9059058c000207bb-gnr_91@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202604062024487d9059058c000207bb
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 06 Apr 2026 22:24:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XH4IOArApZVDEVG2LUg6sWwiGV8EVXDZ+HOpIVnxhiE=;
 b=gTuaRyoZSqNt+Dov3DG6Kpk4kLbnDorEgY9ktGbQD/u6A9O/quBUMpT1g8T89CwVrXcSx1
 SK5EHyk5cDKC9Ih23S1IG52PG+2Sqp+vr+FM2z2N9Txi7iS+foydis56Cl4G3WEgWLVG7sfC
 fPV0iCaQ2/iCNvDBVx9aOy75SMf3/cO7N8Z/2X8FZaC/Mga4gRtxvvA8tznkxwdpdZpAUCWB
 u/E4dFQsx1UDykbCi+nBB9W2Mw8p4Ure4zxpGTRqT3F6fE3mA+Q3Xk0XAeoX5M2BsEXuKkKo
 dN8eFSUMdYdgys40pHVe4mOIdsg0mFgCMuuQD5cngnZk5XHLPbSuwJ+g==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 4/4] bitbake-selftest: setup: add test_extra_remotes
Date: Mon,  6 Apr 2026 22:24:05 +0200
Message-ID: <20260406202430.1856836-5-adrian.freihofer@siemens.com>
In-Reply-To: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 20:24:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19335

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Test the extra-remotes feature added in the preceding commit:

1. Default 'non-optional' filter: the non-optional remote is added to
   the checked-out layer, the optional one is skipped.
2. --extra-remotes-filter=all: both optional and non-optional remotes
   are added.
3. --extra-remotes-filter=none: no extra remotes are added.
4. --extra-remotes-filter=<name>: only the explicitly named remote is
   added.
5. update re-applies extra remotes and calls 'git remote set-url' when
   the URI of an existing remote changes.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 107 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 638d56d3b..7b259cc97 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -726,3 +726,110 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertEqual(f.read(), 'conflicting-upstream\n',
                              "re-cloned layer must contain the upstream content after conflict backup")
         del os.environ['BBPATH']
+
+    def test_extra_remotes(self):
+        """
+        Test that extra-remotes are added and filtered correctly during init and update.
+
+        Covers:
+          1. Default 'non-optional' filter: non-optional remote added, optional skipped.
+          2. --extra-remotes-filter=all: both optional and non-optional remotes added.
+          3. --extra-remotes-filter=none: no extra remotes added.
+          4. --extra-remotes-filter=<name>: only the explicitly named remote added.
+          5. update re-applies extra remotes and updates the URI of an existing remote.
+        """
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+        os.chdir(self.tempdir)
+
+        self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        self.add_file_to_testrepo('test-file', 'initial\n')
+
+        # Two local repos used as extra remote targets (remote_a = initial URI, remote_b = updated URI)
+        remote_a = os.path.join(self.tempdir, 'extra-remote-a')
+        remote_b = os.path.join(self.tempdir, 'extra-remote-b')
+        for remote in (remote_a, remote_b):
+            os.makedirs(remote)
+            self.git_init(cwd=remote)
+            self.git('commit --allow-empty -m "Initial commit"', cwd=remote)
+
+        # Config with one non-optional and one optional extra-remote
+        sources_both = '''
+        "test-repo": {
+            "git-remote": {
+                "remotes": {"origin": {"uri": "file://%s"}},
+                "branch": "master",
+                "rev": "master",
+                "extra-remotes": {
+                    "required-remote": {"uri": "file://%s"},
+                    "optional-remote": {"uri": "file://%s", "optional": true}
+                }
+            }
+        }
+        ''' % (self.testrepopath, remote_a, remote_b)
+        self._add_json_config_to_registry_helper('er-test.conf.json', sources_both)
+
+        def get_remotes(layer_path):
+            return self.git('remote', cwd=layer_path).split()
+
+        # 1. Default filter 'non-optional': required-remote added, optional-remote skipped
+        out = self.runbbsetup("init --non-interactive er-test gadget")
+        setuppath = self.get_setup_path('er-test', 'gadget')
+        layer_path = os.path.join(setuppath, 'layers', 'test-repo')
+        remotes = get_remotes(layer_path)
+        self.assertIn('required-remote', remotes,
+                      "non-optional extra remote must be added with the default 'non-optional' filter")
+        self.assertNotIn('optional-remote', remotes,
+                         "optional extra remote must be skipped by the default 'non-optional' filter")
+        self.assertEqual(
+            self.git('remote get-url required-remote', cwd=layer_path).strip(),
+            'file://' + remote_a)
+        self.assertIn("Added extra remote 'required-remote'", out[0])
+
+        # 2. --extra-remotes-filter=all: both optional and non-optional remotes added
+        self.runbbsetup("init --non-interactive --extra-remotes-filter=all --setup-dir-name er-filter-all er-test gadget")
+        all_layer = os.path.join(self.tempdir, 'bitbake-builds', 'er-filter-all', 'layers', 'test-repo')
+        remotes = get_remotes(all_layer)
+        self.assertIn('required-remote', remotes)
+        self.assertIn('optional-remote', remotes)
+
+        # 3. --extra-remotes-filter=none: no extra remotes added
+        self.runbbsetup("init --non-interactive --extra-remotes-filter=none --setup-dir-name er-filter-none er-test gadget")
+        none_layer = os.path.join(self.tempdir, 'bitbake-builds', 'er-filter-none', 'layers', 'test-repo')
+        remotes = get_remotes(none_layer)
+        self.assertNotIn('required-remote', remotes)
+        self.assertNotIn('optional-remote', remotes)
+
+        # 4. --extra-remotes-filter=<name>: only the explicitly named remote added
+        self.runbbsetup("init --non-interactive --extra-remotes-filter=optional-remote --setup-dir-name er-filter-named er-test gadget")
+        named_layer = os.path.join(self.tempdir, 'bitbake-builds', 'er-filter-named', 'layers', 'test-repo')
+        remotes = get_remotes(named_layer)
+        self.assertNotIn('required-remote', remotes)
+        self.assertIn('optional-remote', remotes)
+
+        # 5. update re-applies extra remotes and updates the URI of an existing remote
+        sources_updated = '''
+        "test-repo": {
+            "git-remote": {
+                "remotes": {"origin": {"uri": "file://%s"}},
+                "branch": "master",
+                "rev": "master",
+                "extra-remotes": {
+                    "required-remote": {"uri": "file://%s"}
+                }
+            }
+        }
+        ''' % (self.testrepopath, remote_b)
+        config_path = os.path.join(self.registrypath, 'er-test.conf.json')
+        os.remove(config_path)
+        self._add_json_config_to_registry_helper('er-test.conf.json', sources_updated)
+
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='no'")
+        del os.environ['BBPATH']
+
+        self.assertEqual(
+            self.git('remote get-url required-remote', cwd=layer_path).strip(),
+            'file://' + remote_b,
+            "update must call 'git remote set-url' to update the existing remote to the new URI")
+        self.assertIn("Updated extra remote 'required-remote'", out[0])
-- 
2.53.0


