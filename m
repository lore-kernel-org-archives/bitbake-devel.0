Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D3C5DF72
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 13:47:40 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9201.1786801649528139380
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=PnAmZXYq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-20260815134726af2a17cec7000207b7-zzxhyu@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260815134726af2a17cec7000207b7
        for <bitbake-devel@lists.openembedded.org>;
        Sat, 15 Aug 2026 15:47:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s2hwCxkhz+DiyjPA/d3nuKSAYwmJQWcsmjHBBte2dBI=;
 b=PnAmZXYq+E2JMMUQ0FtHXXhTIHuk575It8Mo3OgLdFTBp2qew1o1AEHyitzhjINBfCNeE0
 3dSNRXSUCvO27+vAr6QUN6ey6mhW7y7wmnAFPHMmlAcaY3N24LyZ65cab8WTblkV2zcHOh+h
 nfzDnEU6onv1zr+kc69fjMKz0S2mdebybbkFF6GEhHZF2PwrSfGF0VnOQNF8JEsYL98TxDzr
 2yEdhOKVZ4tGgHBjdfZYxZmJX895NtBRm/t72sbbUIWNGzgmN1OUJuIXRip8w6t9+C7ol/nD
 KbZGgs8qvoQHtPgzp0zlUDGC7pZ/jpY84PB8iygUebItCsAyfTDqn/TA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 7/7] parse/ast: skip empty BBPATH segments in include_all
Date: Sat, 15 Aug 2026 15:46:58 +0200
Message-ID: <20260815134722.497586-8-adrian.freihofer@siemens.com>
In-Reply-To: <20260815134722.497586-1-adrian.freihofer@siemens.com>
References: <20260815134722.497586-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 13:47:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19952

From: Adrian Freihofer <adrian.freihofer@siemens.com>

BBPATH can end up with an empty ":"-split segment when different
layer.conf files mix the "${LAYERDIR}:" (prepend) and ":${LAYERDIR}"
(append) idioms, e.g. openembedded-core's own meta/conf/layer.conf uses
"BBPATH .= \":${LAYERDIR}\"" while every other layer.conf in a typical
poky setup uses "BBPATH =. \"${LAYERDIR}:\"". Combined, this produces a
literal "::" in the final value.

IncludeAllNode.eval() iterates every BBPATH segment and calls
os.path.join(path, s) to build the candidate file to include. For an
empty segment, os.path.join("", s) returns s unchanged, i.e. a
relative path instead of an absolute one. include_single_file() then
takes its relative-path branch, which does its own independent search
across the whole BBPATH and marks every path it tries (found or not)
as a dependency via mark_dependency(), as a side effect of resolving
that one (bogus) relative candidate.

If that side search happens to try the real target file before this
loop's own iteration for its actual BBPATH entry runs,
check_dependency() reports it as already seen and include_single_file()
logs a spurious "Duplicate inclusion" warning for it, even though the
file is only ever included once. This is how e.g. oe-core's
"include_all conf/distro/include/maintainers.inc" in defaultsetup.conf
ends up warning about itself on every parse.

Skip empty segments so an empty BBPATH entry cannot trigger this
false-positive dependency marking.

 AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/parse/ast.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index a372b3534..866ab8ed1 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -56,6 +56,10 @@ class IncludeAllNode(AstNode):
         logger.debug2("CONF %s:%s: including %s", self.filename, self.lineno, s)
 
         for path in data.getVar("BBPATH").split(":"):
+            # Skip empty segments (e.g. from a stray "::" if some layer.conf
+            # uses ".= \":${LAYERDIR}\"" instead of "=. \"${LAYERDIR}:\"").
+            if not path:
+                continue
             bb.parse.ConfHandler.include(self.filename, os.path.join(path, s), self.lineno, data, False)
 
 class ExportNode(AstNode):
-- 
2.55.0


