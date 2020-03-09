Return-Path: <pbarker@konsulko.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 0CAC260C0E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 13:52:17 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id v11so11227846wrm.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=24all8ezQCf7+fyjVCNekf1dOKX1FL7U9MeZ6eIUHIA=;
	b=ro/qQLSgFzLYrnsResaRY6vIvqS2yEcEfr55SjI+CxoRCiEaC2ClkZEQm8nqT5mJHb
	jkuWA0mMfqIAoDjJl1Cj/Hju3+y44ly6kva7kSi4xwua29+fajCk3w5B5dALkHeQlGc5
	JwLQbB2J4RkxgYeILo76asAb8qHsUHefGhZrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=24all8ezQCf7+fyjVCNekf1dOKX1FL7U9MeZ6eIUHIA=;
	b=M4cJvT7DfOp0flLNINudamdW6T7gVc+quBawY4fs9e0egCAnclTGNhX6odKsrBTWqJ
	ssqT6eEEvMUi6SV72MgdKnlxFXzuMWpQeKBL5K2AJez7WK8Nwud0ZcVIObH9q4CoSXGK
	i6ivw07J25h+aK0ZCqmGYKnl89xO5nYmGrH+u0nBcchGQBYXl9VBqsLp2lbmf+cPlHn1
	/fVte0jbB0nhvp5FlerMDaGGZtN53kSYDjVqd7jTOKUVoAL1Ss3VT8RdfyRmkvGGhwWo
	dJo2O9/74drDLGzT2XAIQzCdEqTE61TFBFL3fC2dMmJhL7bzp/oV/k4r0/tFV2onHqTh
	sqaw==
X-Gm-Message-State: ANhLgQ1l0SENkNW9ImLX7lBByu/XcLdKLSDmP12sFXVmPby9C/phdGGP
	ZWo85yYFstjKh2C59YIKW8HtEf9H9Xlj76te
X-Google-Smtp-Source: ADFU+vtq+qhU9FO8GJLcUp1AKUhV3+vO5yqceVOXrM/KCzJly+WOs7Kk6YYmTitSTqjO8rNbK4mgbA==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr18756444wrt.191.1583761938192;
	Mon, 09 Mar 2020 06:52:18 -0700 (PDT)
Received: from ub1910.Hitronhub.home ([213.48.11.149])
	by smtp.gmail.com with ESMTPSA id l5sm25510021wml.3.2020.03.09.06.52.16
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 06:52:17 -0700 (PDT)
From: Paul Barker <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 13:52:13 +0000
Message-Id: <20200309135213.14279-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] tests: Add test for gitsm fetcher with shallow mirror tarballs
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
X-List-Received-Date: Mon, 09 Mar 2020 13:52:18 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/tests/fetch.py | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 45dc9e5d..d0c161a7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1691,6 +1691,47 @@ class GitShallowTest(FetcherTest):
         # Verify the submodule is also shallow
         self.assertRevCount(1, cwd=os.path.join(self.gitdir, 'gitsubmodule'))
 
+    def test_shallow_submodule_mirrors(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        smdir = os.path.join(self.tempdir, 'gitsubmodule')
+        bb.utils.mkdirhier(smdir)
+        self.git('init', cwd=smdir)
+        # Make this look like it was cloned from a remote...
+        self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
+        self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
+        self.add_empty_file('asub', cwd=smdir)
+        self.add_empty_file('bsub', cwd=smdir)
+
+        self.git('submodule init', cwd=self.srcdir)
+        self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
+        self.git('submodule update', cwd=self.srcdir)
+        self.git('commit -m submodule -a', cwd=self.srcdir)
+
+        uri = 'gitsm://%s;protocol=file;subdir=${S}' % self.srcdir
+
+        # Fetch once to generate the shallow tarball
+        fetcher, ud = self.fetch(uri)
+
+        # Set up the mirror
+        mirrordir = os.path.join(self.tempdir, 'mirror')
+        os.rename(self.dldir, mirrordir)
+        self.d.setVar('PREMIRRORS', 'gitsm://.*/.* file://%s/\n' % mirrordir)
+
+        # Fetch from the mirror
+        bb.utils.remove(self.dldir, recurse=True)
+        bb.utils.remove(self.gitdir, recurse=True)
+        self.fetch_and_unpack(uri)
+
+        # Verify the main repository is shallow
+        self.assertRevCount(1)
+
+        # Verify the gitsubmodule directory is present
+        assert os.listdir(os.path.join(self.gitdir, 'gitsubmodule'))
+
+        # Verify the submodule is also shallow
+        self.assertRevCount(1, cwd=os.path.join(self.gitdir, 'gitsubmodule'))
 
     if any(os.path.exists(os.path.join(p, 'git-annex')) for p in os.environ.get('PATH').split(':')):
         def test_shallow_annex(self):
-- 
2.20.1


