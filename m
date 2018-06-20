Return-Path: <nicolac76@yahoo.fr>
Received: from sonic308-20.consmr.mail.ir2.yahoo.com
	(sonic308-20.consmr.mail.ir2.yahoo.com [77.238.178.148])
	by mail.openembedded.org (Postfix) with ESMTP id EBA417608A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2018 06:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048;
	t=1529475215; bh=HCLdi5aeZpg0kx1VyEg+WydyCbdxkthzmgtzZNJAVOg=;
	h=From:To:Cc:Subject:Date:From:Subject;
	b=PqT1p1CU41nDWtMwO47Z5LKvZUPFwFimiN/6fc3O89qp5jHSOS0OdpU7JFwmjUzj9YUnZygIVU1jhX100iFpRiDTXHIU9eX5UPBRACV29+Cx/K7Lg9FizC+26Da9lOhsVNMdEx+0yYGw0gbKcHDuLh+ZDcvg8/eeanfFdDpzZyu/piu7L8eiR9rgR9h1ZPhlqO1rBVIEqzYxZhhfDVSEX3J+A4I29GnOPxk5mVCsYmYX5nGdBisnvtTByXuHnzpxxrT73ZTqf0narTL1STNbc9o8Ou4MR4jARViK/QodOlDFVB5mElO1VtLcBinfLUPJr9kqPmiTNjal1uHj+MwLkw==
X-YMail-OSG: g1UUsW4VM1nQUpZ.JOIC46pQ5tL146_I_XNgamRozMh0qZJGKgF81TzKjLry5jl
	S8v1cA4IOrr.Sl5Q_jNBgC56GdZzX8bhK7vo2oazb7yWLTlCUv46ml9ENApAVQtbIKUW5VwNvf42
	FqY_5j59e.5xNJkbyMTD0IUIGg4noKvmov8lorwk0dByWWaRnLtKXv_J4kXvI4oueyLLGbTVRvDI
	GfEIyU1oxRaXbNRlm7.04y9G.270hrJV_5yptvbc8qajDpYowl5j1wNtSJpjwUicIzFMkqa9OTRn
	ZYKcZcniClP_mRSJs2yvUPaPtdtnKTHKADUBWXARhwYAfHnnpGdyVpv1SVSI.5xzArJJJp_6Wako
	aFD9dl3j256MR_GsaoczLHWfp_jI3QQYub55hGW2lv2vwDwihNgYB1cWUBW3gk4OcW5RhS_N6jrQ
	LcXg2e4M0WDyydlBuymj8n11ufxt_MxWN9_RfLmogzuaad1TMwpIZA4MSUMK4GL60FRvUt58TMDF
	EnKrWx4bnjl.kDXAPAwL2su9MJFcVscNll9H_HZgqwE0rf2h_uD3EPC8d1g6VA_8g4TKrp6C4O5P
	w98wbrVBn1VQj5kuTo1DOhq5DqV7JFS_6IFvpQ9jzcwUMOCnRzfxVSgt2leDVZ9luwZ8IW_.IkZ_
	3oYLz9dzMro5zGqnJEzTWt22FJ5LMfwCX7SBewiewv2WxxwtILn2BIXkKwq3lV4n._hF6OfjiH_F
	ZfwoBoJc7Ho8.91WdlA6uyYiJAAGwFIwCJdi2jpFBpkvdjWN_BOqBAN5JNhDadbis9W0Eu1vhvs6
	1XTWbk1iBQNfVKiPUS0hBrJ3s0WqyYPOlwgz2xpwBjU_8YYeD3X5iedmZezl5HUWbg7RBf0tFu9z
	xUQck14_ZAjjM6MMynrLhpH96HKvdwr2tYxjOiE6OvdJZTBcObcf7aFgwGiMHgeCi3kIxvtTFhwx
	ghxCpP5dMtlcLrq85QMU-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic308.consmr.mail.ir2.yahoo.com with HTTP;
	Wed, 20 Jun 2018 06:13:35 +0000
Received: from 80.245.18.66 (EHLO Achlys.localdomain.com) ([80.245.18.66])
	by smtp415.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	2bbbe6ae42c78613f50bc794229faca3; 
	Wed, 20 Jun 2018 06:13:31 +0000 (UTC)
From: Nicolas Cornu <nicolac76@yahoo.fr>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2018 08:13:20 +0200
Message-Id: <20180620061320.6846-1-nicolac76@yahoo.fr>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 25 Jun 2018 21:21:50 +0000
Cc: Nicolas Cornu <n.cornu@overkiz.com>
Subject: [PATCH] fetch2/repo.py: improve unpack to copy only asked project.
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
X-List-Received-Date: Wed, 20 Jun 2018 06:13:35 -0000

From: Nicolas Cornu <n.cornu@overkiz.com>

Today this fetcher copy the whole repo projects in each sub-project.
---
This patch is not here to be merged, but to have review on it.
The problem is that if your google-repo got 150 projects, and you want to build each with a specific recipe, sources
will be copied for each.

 lib/bb/fetch2/repo.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 8c7e8185..a01a548d 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -89,6 +89,23 @@ class Repo(FetchMethod):
         # Create a cache
         runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d, workdir=codir)
 
+    def unpack(self, ud, destdir, d):
+        """unpack the project from repo source directories"""
+
+        repodir = d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo")
+        gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
+        codir = os.path.join(repodir, gitsrcname, ud.manifest)
+        repodir = os.path.join(codir, "repo")
+
+        # With this command I get the full path to the project in the "repo" download dir.
+        full_path_to_download = runfetchcmd("%s list --path-only --fullpath %s" % ("repo", d.getVar("PN")), d, workdir=repodir)
+
+        # I do this or git clone say the directory is not empty.
+        runfetchcmd("rm -rf %s" % d.getVar("S"), d, workdir=destdir)
+
+        # Is it ok, here to use "S" directly? I see no fetcher do that.
+        runfetchcmd("git clone %s %s" % (full_path_to_download.strip(), d.getVar("S")), d, workdir=destdir)
+
     def supports_srcrev(self):
         return False
 
-- 
2.17.1


