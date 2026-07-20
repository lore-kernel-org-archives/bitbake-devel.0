Return-Path: <amery@apptly.co>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29301C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 19:58:43 +0000 (UTC)
Received: from v523.v5ed9ac7d.euw1.send.eu.mailgun.net (v523.v5ed9ac7d.euw1.send.eu.mailgun.net [141.193.32.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6314.1784577516775120514
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Jul 2026 12:58:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@e.apptly.co header.s=mta header.b=OEvkiEuy;
 spf=pass (domain: e.apptly.co, ip: 141.193.32.23, mailfrom: bounce+ec7242.b6604b-bitbake-devel=lists.openembedded.org@e.apptly.co)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=e.apptly.co; q=dns/txt; s=mta; t=1784577514; x=1784584714;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject: To: To: From: From: Sender: Sender;
 bh=VhfdZccVj+l/3xOsPxRUgVifLo5+rPiC/eJkYY7bKaE=;
 b=OEvkiEuyuqtRVRAmGzhtoQZfL+zHqjgj9b090+WwYXake6C6OJqoexaszP7K53FMfRThFdwLNcxwzdBPqd48bng/Hb/7ZrgNYd4nKR//APcMC9xCyYe/WAp72HbgODOOlHv/0sp7KnGLM3m3jQjtZqsBR7mBhYrM7MToYF/WCAk=
X-Mailgun-Sid: WyI5YTJmMyIsImJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyIsImI2NjA0YiJd
Received: from localhost (unknown [51.179.224.164]) by
 57d00acbdea48da1018033e4e1c21bac7bc40d5753215abfcd9992e8ee833e10 with SMTP id
 6a5e7dea9735dec078647bd2 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 20 Jul 2026 19:58:34 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
Sender: amery=apptly.co@e.apptly.co
From: Alejandro Mery <amery@apptly.co>
To: bitbake-devel@lists.openembedded.org
Subject: [2.18][PATCH] bitbake-worker: Evaluate exported_vars() before emptying the environment
Date: Mon, 20 Jul 2026 19:58:34 +0000
Message-ID: <20260720195834.2496647-1-amery@apptly.co>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Jul 2026 19:58:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19845

exported_vars() returns a lazy generator. It was bound before
empty_environment() cleared the process environment and only iterated
afterwards, so any datastore expansion deferred until iteration ran with
PATH already wiped.

Recipes whose exported variables expand a command during that loop hit
this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git while
PATH is empty, so the git wrapper on PATH is bypassed and the real git
runs directly. Under pseudo this fakes uid 0 against a repository owned
by the real user, and git aborts with "detected dubious ownership",
failing do_package intermittently (only on reparse, when the value is
re-expanded rather than served from cache).

Materialise the generator into a list before emptying the environment so
every expansion happens while PATH is still intact.

Signed-off-by: Alejandro Mery <amery@apptly.co>
---
 bin/bitbake-worker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index aa14ef191..0db1531e0 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -290,7 +290,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
-                exports = bb.data.exported_vars(the_data)
+                exports = list(bb.data.exported_vars(the_data))
 
                 bb.utils.empty_environment()
                 for e, v in exports:
-- 
2.47.3


