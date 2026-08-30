Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53384C61DB9
	for <webhook@archiver.kernel.org>; Sun, 30 Aug 2026 10:26:48 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6496.1788085603797131762
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 30 Aug 2026 03:26:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=jJ7U4IFW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260830102640dffc27028c00020762-oizlo1@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260830102640dffc27028c00020762
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 30 Aug 2026 12:26:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5/3SHA2APKAspr3h84UBX/QkA0bueo4HXMXPUAjwSsg=;
 b=jJ7U4IFWvwfsVr8XX/K93l4Tqs81S9BqmZ3Po6N7lQ0cr2zSuRRs5S0HCA4ge1fj+ofI11
 3OulKOiRosC1/dhjFg3ow5/8cooqbvcAUUCuBlhJRN9loCM2nnUXRgH8EYd2JEl0Dj3e1/td
 w5q0sYrAKZX11vgPLVQo7xKlBsVOI7kOR7QILlvpYsdYdZa1Kt4/wZtN3eZMJYzKItiZGV/0
 vds0g2fRaAO3W2wSzHUMrnnJplq4/1wRRJS02shLXWZG9ZeodDLl8cm5/tFASOtnMWSAnNvI
 Om7inlbJn4PkwpjgdTLkwDpw4GOsMVID5nO6EUaLc5woCLJd7QXzGL6w==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH] fetch2/wget: remove orphaned NamedTemporaryFile in _fetch_index
Date: Sun, 30 Aug 2026 12:26:35 +0200
Message-ID: <20260830102635.2402088-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 30 Aug 2026 10:26:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20127

From: Adrian Freihofer <adrian.freihofer@siemens.com>

_fetch_index() created a tempfile.NamedTemporaryFile() that was
immediately shadowed by the following "with ... as f:" statement, so
it was never used or closed. The GC eventually reclaims it and prints
a ResourceWarning ("Implicitly cleaning up ...") during upstream
version checks (e.g. "devtool latest-version").

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/fetch2/wget.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 0d2b7f5c8..f732a0be2 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -562,7 +562,6 @@ class Wget(FetchMethod):
         """
         Run fetch checkstatus to get directory information
         """
-        f = tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
             fetchcmd = self.basecmd + ["--output-document=%s" % f.name, uri]
             try:
-- 
2.55.0


