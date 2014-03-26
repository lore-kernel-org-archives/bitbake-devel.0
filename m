Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 79FCD6F9AC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 09:27:05 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s2Q9R6bd011434
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 02:27:06 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.169.1; Wed, 26 Mar 2014 02:27:06 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Mar 2014 05:27:05 -0400
Message-ID: <6d78004e5ccfd737bac24e5346d079aab11df2e7.1395802560.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1395802560.git.liezhi.yang@windriver.com>
References: <cover.1395802560.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Wed, 26 Mar 2014 09:27:05 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

When specifying tags, they're searched for unanchored so foo/bar could
match:

refs/heads/abc/foo/bar
refs/heads/xyz/foo/bar
refs/heads/foo/bar

This change anchors the expressions so they are based against heads
or tags (or any other base level tree that has been created).

(Bitbake master rev: df2e0972cd1db7abd5ec8b7cb295fb0c42e284a4)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Conflicts:
	bitbake/lib/bb/fetch2/git.py
	(ud.basecmd and basecmd conflicts, keep using basecmd)

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 6175e4c..cff5ce1 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -305,8 +305,8 @@ class Git(FetchMethod):
             username = ""
 
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (basecmd, ud.proto, username, ud.host, ud.path, ud.branches[name])
+        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s" % \
+              (basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name], ud.unresolvedrev[name])
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
         output = runfetchcmd(cmd, d, True)
-- 
1.7.10.4


