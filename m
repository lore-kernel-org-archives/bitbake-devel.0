Return-Path: <rhi@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D6C282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 12:55:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.52553.1741006508914979097
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 04:55:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: rhi@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1tp5K6-0008FT-AO; Mon, 03 Mar 2025 13:55:06 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1tp5K6-003ndr-04;
	Mon, 03 Mar 2025 13:55:06 +0100
Received: from rhi by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1tp5K5-00CKiM-32;
	Mon, 03 Mar 2025 13:55:05 +0100
From: Roland Hieber <rhi@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Roland Hieber <rhi@pengutronix.de>
Subject: [PATCH] contrib: vim: ftdetect: don't conflict with other filetypes
Date: Mon,  3 Mar 2025 13:55:02 +0100
Message-Id: <20250303125502.2939507-1-rhi@pengutronix.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 12:55:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17368

Use :setfiletype instead of :set filetype. The former only sets the
'filetype' option if it has not been set before, which makes it possible
to override the syntax of certain *.inc files in autocommands from e.g.
.vimrc or modelines. All other ftdetect plugins in upstream vim also use
:setfiletype for this reason.

The detection for bitbake *.inc files is now upstream since Vim 9.0
patch 0055 [1]. If we're running an earlier Vim, use the detection
heuristic from upstream [2] to overwrite the filetype explicitely if we
find bitbake code. But don't always assuming that *.inc files are
bitbake files so as not to break Perl, PHP, Assembly, Povray, etc.

[1]: https://github.com/vim/vim/commit/fa49eb482729
[2]: https://github.com/vim/vim/blob/fb49e3cde79d/runtime/autoload/dist/ft.vim#L715

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 contrib/vim/ftdetect/bitbake.vim | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbake.vim
index 09fc4dc74c25..427ab5b987c3 100644
--- a/contrib/vim/ftdetect/bitbake.vim
+++ b/contrib/vim/ftdetect/bitbake.vim
@@ -11,10 +11,18 @@ if &compatible || version < 600 || exists("b:loaded_bitbake_plugin")
 endif
 
 " .bb, .bbappend and .bbclass
-au BufNewFile,BufRead *.{bb,bbappend,bbclass}  set filetype=bitbake
+au BufNewFile,BufRead *.{bb,bbappend,bbclass}  setfiletype bitbake
 
-" .inc
-au BufNewFile,BufRead *.inc		set filetype=bitbake
+" .inc -- meanwhile included upstream
+if !has("patch-9.0.0055")
+    au BufNewFile,BufRead *.inc                call s:BBIncDetect()
+    def s:BBIncDetect()
+        l:lines = getline(1) .. getline(2) .. getline(3)
+        if l:lines =~# '\<\%(require\|inherit\)\>' || lines =~# '[A-Z][A-Za-z0-9_:${}]*\s\+\%(??\|[?:+]\)\?= '
+            set filetype bitbake
+        endif
+    enddef
+endif
 
 " .conf
 au BufNewFile,BufRead *.conf
-- 
2.39.5


