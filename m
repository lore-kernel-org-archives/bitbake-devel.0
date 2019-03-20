Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 98AB571E5A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Mar 2019 06:21:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x2K6LkLx024017
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 23:21:46 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Tue, 19 Mar 2019 23:21:45 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Mar 2019 14:40:51 +0800
Message-ID: <db5c32f158267831427a769f4db1a4f80125fd92.1553063929.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1553063929.git.liezhi.yang@windriver.com>
References: <cover.1553063929.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] fetch2: Unify BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Wed, 20 Mar 2019 06:21:46 -0000
Content-Type: text/plain

The fetch2/__init__.py checks whether "BB_FETCH_PREMIRRORONLY" == "1", but
fetch2/git.py and hg.py checks whether it is None, this makes it discontinuous,
and BB_FETCH_PREMIRRORONLY = "0" doens't work as expected in the later case,
so unify it to the previous one. (As BB_NO_NETWORK does).

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 2 +-
 bitbake/lib/bb/fetch2/hg.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 1a8ebe3..e021f33 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -318,7 +318,7 @@ class Git(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
+        if d.getVar("BB_FETCH_PREMIRRORONLY") == "1":
             return True
         if os.path.exists(ud.clonedir):
             return False
diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 936d043..5a3db92 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -99,7 +99,7 @@ class Hg(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
+        if d.getVar("BB_FETCH_PREMIRRORONLY") == "1":
             return True
         if os.path.exists(ud.moddir):
             return False
-- 
2.7.4


