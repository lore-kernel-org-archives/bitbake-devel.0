Return-Path: <nicolac76@yahoo.fr>
Received: from sonic302-19.consmr.mail.ir2.yahoo.com
	(sonic302-19.consmr.mail.ir2.yahoo.com [87.248.110.82])
	by mail.openembedded.org (Postfix) with ESMTP id CA55378741
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2018 07:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048;
	t=1529565208; bh=dZGQt6EvAuguuAJ4U0rsJ65imQ8LgMaih/4pipKyO4s=;
	h=From:To:Cc:Subject:Date:From:Subject;
	b=ksBgFXxxZ7GSRlkaX+v6N3AgoRIuZtTHkqQscZY0jwKxTR8WFi37eNdIekZZYOdDStguTdlgMynVpOMYIgtA1AeRirRS5qWodWy0fcUmEeeWqxEktYrg06MPbTOtjKgxZZ1rubETt5Dby66e3+wVFUvaxjl2txgPxyu0QnR080NOY4lkRpgedoltsvPgVJEl2I3H+t9ZDgTlkBgmC7c87XF59ql4ATvxo1Lwg1O+3+8ZE/qTE5hXeRymrIuWWWb4NrK//BaQhjtXkNbCD9cYexUqGrSwam1Y4P1xLlUdN/jSsXpg/chlfGJd2odZz5JK9ArSuPwZtVzOpk9dCK9u9A==
X-YMail-OSG: HBu2E1cVM1ketoyWnnrf5dia8WGhTYxEb6R45O7JZjxaL_7VoSo8O27rPQcL.HW
	WprnCMfnfwIAd1SQoRsUmC53gTtitloV0eEqU0B4TOMgkwTxSpmJs1Mzjz8s1gSUVnkUuyaabK01
	1QGD17ATlp.qmxvqCZbDPMzy_YKCi4hyBOc4MseFgZ6J17yc48Ucv_UT9EyL_nbXVSTNlRWch7Hv
	MU9.toCZLaBWLnajcxN8rsYrroBYKpxfB9iD1cJmvx8p0Cutkmo65J009x8SZltbYG_tQ8PQP04a
	S6VEp7Kri8F_qKKk3dEvL.JgaXVqIHKf7w5ZiNtSH.v1YMAtvkgURdENCzE8YbkCzOJFYGgTVWSd
	DELACf9Ah3I1Z1cqLf_ymb2x.cfllEu6PsYrb9jAd.hz9jxb1TCg22T7CGJbXXwYtW7Ngdajx3ca
	1RO.hkkHSLhKcR2w5HTOdLnkRWXCNoTmLWZyP5QYD4oX1Ugk4LEqXl.KzBT4iPUwB3zbrE80yqfH
	KSpq.NYxPhLg.ObwSoswpwGN5Qtvjpp3fcCwgCeJUTg1LCako9bL2iRL_4jH4MLDee4a87jsdTDZ
	Mt0X5v9Pv2Qq44fesMfrC0J4PafkBhSmCdocjNbjiEfW4UXVafd.GFdqra7dq2kYSg2WdVuTyLBE
	4jA0EbulCY648pQUdJeKb_c8eHmww695SDN1Z4HWvFoQ9jcd5K3r01qFJ_QDdjLznVOip1lqe.o_
	ntW5YFMFHqWKRiCbLPZsgBuOu2VyCE2sbR9nPCAtTVuwSQOUpRn9AW1taNUdpXpkQy2xc1_sDO9P
	Ch167IfAV.oKtz1tHS7U85TEPAVlya43GGHdwPnhKaMkFWPplLVIjm.2wVeshvqSkok7qRx6jOkh
	CIBBTBu5s433_mnX09A5pSXrYvW61s9xnEHuD.UrQgaekJhyAkBIQnBrRB1eqplaX1NlS15M6fGD
	ALe17GgBwQnlf7ASTt_U-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic302.consmr.mail.ir2.yahoo.com with HTTP;
	Thu, 21 Jun 2018 07:13:28 +0000
Received: from 80.245.18.66 (EHLO Achlys.localdomain.com) ([80.245.18.66])
	by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	58ab1fde4e7aedb035adb3c164b436de; 
	Thu, 21 Jun 2018 07:13:24 +0000 (UTC)
From: Nicolas Cornu <nicolac76@yahoo.fr>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jun 2018 09:13:12 +0200
Message-Id: <20180621071312.1182-1-nicolac76@yahoo.fr>
X-Mailer: git-send-email 2.17.1
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
X-List-Received-Date: Thu, 21 Jun 2018 07:13:28 -0000

From: Nicolas Cornu <n.cornu@overkiz.com>

Today this fetcher copy the whole repo projects in each sub-project.
---
This patch is not here to be merged, but to have review on it.
The problem that this patch try to fix is that if your google-repo got 150 projects, and you want to build each with
a specific recipe, sources will be copied each time.
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


