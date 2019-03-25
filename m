Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id CEED36C0ED
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Mar 2019 07:51:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2P7pZeh029977
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Mar 2019 00:51:51 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Mon, 25 Mar 2019 00:51:46 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Mar 2019 16:10:57 +0800
Message-ID: <c7a631be58f181230307ca3d0d211996cf0e368b.1553501143.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1553501143.git.liezhi.yang@windriver.com>
References: <cover.1553501143.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2 v2] fetch2: Unify BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Mon, 25 Mar 2019 07:51:59 -0000
Content-Type: text/plain

The fetch2/__init__.py checks whether "BB_FETCH_PREMIRRORONLY" == "1", but
fetch2/git.py and hg.py checks whether it is None, this makes it discontinuous,
and BB_FETCH_PREMIRRORONLY = "0" doens't work as expected in the later case,
so unify it to the previous one. (As BB_NO_NETWORK does).

And also use bb.utils.to_boolean() to make them consistent.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 bitbake/lib/bb/fetch2/git.py      | 2 +-
 bitbake/lib/bb/fetch2/hg.py       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 26ad388..6445184 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1642,7 +1642,7 @@ class Fetch(object):
             urls = self.urls
 
         network = self.d.getVar("BB_NO_NETWORK")
-        premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY") == "1")
+        premirroronly = bb.utils.to_boolean(self.d.getVar("BB_FETCH_PREMIRRORONLY"))
 
         for u in urls:
             ud = self.ud[u]
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index cf8bee7..8185bf4 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -318,7 +318,7 @@ class Git(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
+        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
             return True
         if os.path.exists(ud.clonedir):
             return False
diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 936d043..5a2985e 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -99,7 +99,7 @@ class Hg(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
+        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
             return True
         if os.path.exists(ud.moddir):
             return False
-- 
2.7.4


