Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A337CC6B3A
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 05:04:25 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32853.1792040655161915648
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Oct 2026 22:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=g5h6ylOb;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso14744265e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Oct 2026 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1792040653; x=1792645453; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KCkIuNkCOSA2/5BzMITuUeyZbR/mzyXRuBZLRCT0HmQ=;
        b=g5h6ylObuSEizKYvyLN1TwmnadZioQNn5xeK5aTpY+WHO1g8zyvj/dNrOpPnJmUH5k
         B8Xx+QEF6pQmjrwYyBNlfZ4FaZpqgEk7F1fc6I4hmmiiMlAFs0JXKGl0WaAFRDQru7q6
         nj8CdPEQZ1OziPcOXY2J9pFPOifT8fHTwyKJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040653; x=1792645453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KCkIuNkCOSA2/5BzMITuUeyZbR/mzyXRuBZLRCT0HmQ=;
        b=miVpoz1MiUb8R/OzGxqnfJcPWJ3eropfqugZZE7TKwHHjDQSmUykkDp3xf1/g5vrzG
         6942EojLPHFZ/nxdBBHwK4+w2W6gQ2rPznJHiI+nURLUSAIJ1MoBJ9pZ+va2oGyLYGUP
         V4EHI6Xw2AfEcJe9nWTelHtBMDVz3VeOFJ8CLnSBPH9mZKtK2tr0gkv3sklYbQGRzhG6
         kx+1Ia2sey2PnfX658y1SssWOcq/mchLWSSCFhOvHsRggqtYC/cul83csQKI4AiSis6a
         6lk9m4Dfp7dIhDZs4ah3m481zlAcbR7Tg607pgt+wh/Vo+bnGSFPNtlblO/l+4KuDwSG
         4JGQ==
X-Gm-Message-State: AFq9FYIMK84qvDN0DJ+rs8zTC2jTS8ckpT9LpvlPcntFsCeIyOVH8nOq
	zKpsPl0gJ3NBfmDpXsMLfV5NFAS1YWbDWjLW7EZdMX7O74Hb+bJ2KZTt4xmG/YLaxy0wv/hxt+H
	TSBcPvZY=
X-Gm-Gg: AYBFou3miCbozA2u/Ut74ztnHQxfqSQh7QIRLEL84RwDaQieYCC3cwel63PdhRpkesi
	utUIOmk6iuTjNhcyc7caMkP5IjEY1hYbmvUkvVlpJlmtIMPI1Uab37SHq4fTnfbsnnYsRnylmLc
	2zMFvNe68JYbUL2C87T7uwnMyggSoNyay4jmtq4uYPuNys/VoPfp7ro92trnFT2KgwVv8QiOP5N
	QDpZ3y2rDReer43NPLkVi2jcIX+9oiFTv/5WubPz0bDpVCAFCU+aYbKGVENChl44XB/YDCSMK6b
	zXVUs8tpVJfIoFALhG0f3c5g6K2WDHVR7GkEVjlqy1GEDRF6hWUb7Hud2Uuqi96AOOKCh1+jbV0
	2VHEFSUNROKyoMq1s+R5Tl92nt4ccrA62NQ2vZBD0ZclISrz8u0GyA1kLNS7VThtph8/3RiRcCR
	Bekt0I2HGM1cpL2L3Kx1XIWxj/603p2IsX+qCmjgMfwlB74Z4BRc9Sf6f58S1W6xLXxGUU1sHJU
	aoIC29YSlq9t6FYvWiok3xJYGFSwN29mJ24dtcSKEG4GSSbOr3Avf3SZDf0pbWTFzKr0ROZ6AFD
	ELGSibQ9
X-Received: by 2002:a05:600c:4e89:b0:4a0:22d5:908c with SMTP id 5b1f17b1804b1-4a18e4a4976mr386623775e9.12.1792040653390;
        Wed, 14 Oct 2026 22:04:13 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df758258fsm452195f8f.17.2026.10.14.22.04.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:04:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] prserv: commit new revisions when a request succeeds
Date: Thu, 15 Oct 2026 07:04:02 +0200
Message-ID: <6b443060ee96a62efb94723c97f22b51c9b20507.1792020468.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792020468.git.yoann.congal@smile.fr>
References: <cover.1792020468.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 05:04:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20342

From: Wadim Mueller <wafgo01@gmail.com>

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
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/prserv/serv.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index dc4be5b62..cff57a8cc 100644
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

