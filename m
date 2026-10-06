Return-Path: <wafgo01@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351BFCA5FED
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 13:41:07 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45891.1791294057068501075
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Oct 2026 06:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=R4X5ajAE;
 spf=pass (domain: gmail.com, ip: 209.85.208.42, mailfrom: wafgo01@gmail.com)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a9e5ba741aso1042777a12.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791294055; x=1791898855; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kb4eVtK2uoY3+RmA+t3DmUHgxsFXAhOPVZbk4jq525Y=;
        b=R4X5ajAElMUIfaSWAJEU0k3d+GnU78UgPZ7DfwCCqAu24Vy7oW1vgMWtlIaN+Ov2C9
         mRz47MHLShjmS673TprzVxVZpawz2bRymzoPq/KDx0Zsw9m68keyd92Y5hyoogGBgN4v
         r9GyrNP/HV53Ram5QBmvH96LHs/j7wanno/6WmU5a2qyY14jiPzTqV7ALcKTHL+nTaP2
         vmOTq5YkCnrkhheXAs7JgFH8sI1/cm0pxSs953HiFZDVntSKRCvquWk7MYHjZARFPMDi
         6CmdyU8inRYz/S5khy1UXZNpiZMuOUrlBaQHxMrRdjeG1R5jjqVfjuEeU6s4jkdJ4W/n
         DQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294055; x=1791898855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kb4eVtK2uoY3+RmA+t3DmUHgxsFXAhOPVZbk4jq525Y=;
        b=GkW3tsdZ+qwK90xayMM/ZI3zCzDczK8UnSFUTo0dKsmsBRKvPNyFGnZxPMSdroyVqn
         5LKhy4pisqt0avFizqpGO8jrNQE5Y/D3KVnimt2vaZg1IMp8qPI0vfc0mcARJlc9Mupp
         37r8HY5IkbsnZFxbJrqzV3xLok8nyVr28CBfvI3bDKSYWKn3tc7LF4dx6EvzWylbvZic
         vfjOWYqFzrJsWp5qN5O/AhwsN5sYpfWNXLWO+URZIhzZ8+XIfji/tOroMGotKfmo2c+o
         vMf56tnOnc5YcNb+KB7MfXAJnxnMTeNgd2Q+24yn3ehm2rE92FfokAe4/EPSWrQE9DXr
         jK4g==
X-Gm-Message-State: AFq9FYJx7XV92Lm4tQGzHA+ak7a2J3XPyloXO17sqKy0P1MbWFjhfoy3
	wK5JXYEIx//kSc9y7Z3FKZCJ1MqjJ2ke/ui3n2eZ+Dh2Nv7i3S/n4dIBlnikP+h8
X-Gm-Gg: AYBFou2lsMScMW6LXoRRAakG0NYd9V5hsGQpXdvFvwylgCZoWAnIjYWRHDs35memxO8
	0XKOOxn+QzAhThcTTIskydaj1I2FWb+jcTG8ngSy3OSI4+3o29xxt+eJywp6UV3gLKoyvwj/zZF
	8xT3F2zCnfmSkZ7gzeFe4lcW6POz3/Ea1mUSp2U2hiHpfWXBFx8NxDvBU89o69e5z0baFHdlgGt
	wB+vlg4rb37CaPC0t2uA4KcwMqgoBFzRnrd8K3yVMoGGfKVBnqLHcbPNDXsFivBoiYbRcMJKWms
	T4h66zA/1WHZtHOaZWmawhEsWKuaNRU+S15ARTwPzTOKJ4z0/eE8me3cBcqm+60WbHMLkH8RUME
	TF6+SCBUsadRw3OJlL6PXXPwkSTexPVkHim92ZjbgCZIssQD6S/TpumfljVE1RrzlNoGqgyxS94
	dZ7aAJv1KHd+d6TW3+hUmo/X1+NZ07fV4J8TaP9Udnvg3npc+YLiOCBENua0Wc8wVn6ds21XB4h
	7yLuMhmv4zd0O69Lg==
X-Received: by 2002:a05:6402:52d3:b0:6ac:5e42:5b45 with SMTP id 4fb4d7f45d1cf-6afe29ea45amr1129174a12.34.1791294054958;
        Tue, 06 Oct 2026 06:40:54 -0700 (PDT)
Received: from DE-PF5B95TD.clients.cmblu.de ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb021a5e9sm4884965a12.29.2026.10.06.06.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:40:54 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Wadim Mueller <wafgo01@gmail.com>
Subject: [2.8][PATCH] prserv: commit new revisions when a request succeeds
Date: Tue,  6 Oct 2026 15:40:52 +0200
Message-ID: <20261006134052.1778484-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 13:41:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20298

PRServerClient.dispatch_message() is meant to commit new PR values after
every request that succeeds:

    try:
        return await super().dispatch_message(msg)
    except:
        self.server.table.sync()
        raise
    else:
        self.server.table.sync_if_dirty()

The else clause of a try statement does not run when the try suite leaves
through a return statement, so sync_if_dirty() is never called after a
successful request. The database connection keeps an open EXCLUSIVE
transaction and the values are written to the database file only when the
server stops or receives a signal. Until then the file stays unchanged and
other readers fail with "database is locked".

A long running server therefore holds all revisions it has handed out since
its start only in memory. After a crash, a kill or a power loss the file
returns to the state of the last clean stop, the numbering restarts there and
a client sees package revisions go backwards.

Reproduced with a server started with --file on an empty database: three
getPR() calls for new checksums leave the file untouched until the server is
stopped. With this change the entries are in the file after each request.

Keep the response, commit, then return it.

This is specific to the 2.8 branch. The server was reworked for master and
2.10 ("prserv: enable database sharing" and the commits around it), which
commits where values are stored and uses WAL, so master does not have this
problem and the commit cannot be backported as it is.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 lib/prserv/serv.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index dc4be5b..cff57a8 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -39,12 +39,12 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
 
     async def dispatch_message(self, msg):
         try:
-            return await super().dispatch_message(msg)
+            response = await super().dispatch_message(msg)
         except:
             self.server.table.sync()
             raise
-        else:
-            self.server.table.sync_if_dirty()
+        self.server.table.sync_if_dirty()
+        return response
 
     async def handle_test_pr(self, request):
         '''Finds the PR value corresponding to the request. If not found, returns None and doesn't insert a new value'''
-- 
2.43.0


