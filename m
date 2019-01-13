Return-Path: <andre.draszik@gmail.com>
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
	[209.85.208.54])
	by mail.openembedded.org (Postfix) with ESMTP id 5C73C7C075
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Jan 2019 11:18:26 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id d39so16422100edb.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Jan 2019 03:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=U54Uq3zGole5fEAKTbJTrCYPbW6iREKRbTs+kEbKj+8=;
	b=svomhkOqdwpeLwyAq3tfe9RlrJj+ewyHZpZDZdn3RE8PStlLnn1Low0sxq/Zqx8rmC
	1TakqFzrSEj5WGGTDV7/Iqulv3gpnJcGFbXjYEw81r7fJg9LemoF1HEbNKQuNLnw9pzG
	z8CutfaWWZciomei1WL/+XfV2m+Lt0zH+KtrClsyE0NJJVek5lGHsO9GQFjq2f5SEqdy
	X7EAUKYZCQG3ap2NkiOnmvuitgFg6xP/c6bLWwo7Tn7mRUiRZaDkIIlVnpMCRX78L1j8
	oXMEnlMZnK3ni1MPrHekVxk6TpTV2mh90pHocrhct+PR13xHM43/JF8QCg1Z4UdkEkZq
	Oo5w==
X-Gm-Message-State: AJcUukf2dl/UHoiXNfnEhdgb90Pbelssdr6qhx0BQHhUw70NymXLmX01
	SVyKjP3/0AelNE5JXOqIOfflPpwV
X-Google-Smtp-Source: ALg8bN7Pxb8Mme6GnDh1L0lt+DWNBCEmtmG33zDwg/FPRklkXQaczAP9SMJDjzt4GbAJ0hN5ehvk+w==
X-Received: by 2002:a17:906:3f55:: with SMTP id
	f21-v6mr16473164ejj.120.1547378306499; 
	Sun, 13 Jan 2019 03:18:26 -0800 (PST)
Received: from tfsielt31850.fritz.box (188-141-55-36.dynamic.upc.ie.
	[188.141.55.36]) by smtp.gmail.com with ESMTPSA id
	p22-v6sm1984542ejb.76.2019.01.13.03.18.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 13 Jan 2019 03:18:25 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 13 Jan 2019 11:18:24 +0000
Message-Id: <20190113111824.20921-1-git@andred.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [master][PATCH] bitbake: remove True option to getVar calls
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
X-List-Received-Date: Sun, 13 Jan 2019 11:18:26 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Draszik <andre.draszik@jci.com>

getVar() has been defaulting to expanding by default for
a long time (2016), thus remove the True option from
getVar() calls with a regex search and replace.

Search & replace made using the following command:
    sed -e 's|\(d\.getVar \?\)( \?\([^,()]*\), \?True)|\1(\2)|g' \
        -i $(git grep -E 'getVar ?\( ?([^,()]*), ?True\)' \
             | cut -d':' -f1 \
             | sort -u)

Signed-off-by: André Draszik <andre.draszik@jci.com>
---
 classes/base.bbclass  | 2 +-
 lib/bb/fetch2/git.py  | 2 +-
 lib/bb/tests/fetch.py | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/classes/base.bbclass b/classes/base.bbclass
index 71d9ec16..08441fe1 100644
--- a/classes/base.bbclass
+++ b/classes/base.bbclass
@@ -44,7 +44,7 @@ python do_showdata() {
 	# emit the metadata which isnt valid shell
 	for e in bb.data.keys(d):
 		if d.getVarFlag(e, 'python', False):
-			bb.plain("\npython %s () {\n%s}" % (e, d.getVar(e, True)))
+			bb.plain("\npython %s () {\n%s}" % (e, d.getVar(e)))
 }
 
 addtask listtasks
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 59a2ee8f..8ab4b7e1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -199,7 +199,7 @@ class Git(FetchMethod):
             depth_default = 1
         ud.shallow_depths = collections.defaultdict(lambda: depth_default)
 
-        revs_default = d.getVar("BB_GIT_SHALLOW_REVS", True)
+        revs_default = d.getVar("BB_GIT_SHALLOW_REVS")
         ud.shallow_revs = []
         ud.branches = {}
         for pos, name in enumerate(ud.names):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6848095c..7b5d9684 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1280,7 +1280,7 @@ class GitShallowTest(FetcherTest):
 
     def fetch(self, uri=None):
         if uri is None:
-            uris = self.d.getVar('SRC_URI', True).split()
+            uris = self.d.getVar('SRC_URI').split()
             uri = uris[0]
             d = self.d
         else:
@@ -1338,7 +1338,7 @@ class GitShallowTest(FetcherTest):
 
         srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
         self.d.setVar('SRCREV', srcrev)
-        uri = self.d.getVar('SRC_URI', True).split()[0]
+        uri = self.d.getVar('SRC_URI').split()[0]
         uri = '%s;nobranch=1;bare=1' % uri
 
         self.fetch_shallow(uri)
@@ -1510,7 +1510,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('f')
         self.assertRevCount(7, cwd=self.srcdir)
 
-        uri = self.d.getVar('SRC_URI', True).split()[0]
+        uri = self.d.getVar('SRC_URI').split()[0]
         uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
 
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
@@ -1536,7 +1536,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('f')
         self.assertRevCount(7, cwd=self.srcdir)
 
-        uri = self.d.getVar('SRC_URI', True).split()[0]
+        uri = self.d.getVar('SRC_URI').split()[0]
         uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
 
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
-- 
2.20.1


