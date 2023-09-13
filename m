Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CACCA550F
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 08:43:53 +0000 (UTC)
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by mx.groups.io with SMTP id smtpd.web11.7103.1694594632815291033
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 01:43:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lakka.kapsi.fi, ip: 91.232.154.25, mailfrom: mcfrisk@lakka.kapsi.fi)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1qgLTS-003PEm-1q;
	Wed, 13 Sep 2023 11:43:50 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1qgLTS-0007s4-Ax; Wed, 13 Sep 2023 11:43:50 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH] bitbake: fetch2: git: revert path checks
Date: Wed, 13 Sep 2023 11:43:44 +0300
Message-Id: <20230913084344.29928-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.4 (-)
X-Rspam-Report: Action: no action
 Symbol: ARC_NA(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Symbol: R_SPF_ALLOW(-0.20)
 Symbol: MIME_GOOD(-0.10)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: BLOCKLISTDE_FAIL(0.00)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: NEURAL_HAM(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20230913084344.29928-1-mikko.rapeli@linaro.org
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 08:43:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15042

Commit 10f38157a069cb6938323cadd5e523037a29ace9
triggers re-clones of uptodate repositories when their
access path changes. This is wrong. It is enough that
needed commits are found from the git repo. For example
when same DL_DIR is accessed using two different paths
due to a symlink, then the resulting absolute paths will
differ but the content is the same. Trust the content.

Avoids extra downloads of large repositories like linux-yocto
for kernel when the local cache was already uptodate.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 bitbake/lib/bb/fetch2/git.py | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index e11271b757..0c547ea303 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -371,19 +371,7 @@ class Git(FetchMethod):
             # The directory may exist, but not be the top level of a bare git
             # repository in which case it needs to be deleted and re-cloned.
             try:
-                # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
-                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
-
-                toplevel = os.path.abspath(output.rstrip())
-                abs_clonedir = os.path.abspath(ud.clonedir).rstrip('/')
-                # The top level Git directory must either be the clone directory
-                # or a child of the clone directory. Any ancestor directory of
-                # the clone directory is not valid as the Git directory (and
-                # probably belongs to some other unrelated repository), so a
-                # clone is required
-                if os.path.commonprefix([abs_clonedir, toplevel]) != abs_clonedir:
-                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
-                    needs_clone = True
+                runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
             except bb.fetch2.FetchError as e:
                 logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
                 needs_clone = True
-- 
2.34.1


