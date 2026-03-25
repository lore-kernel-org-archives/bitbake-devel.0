Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62906FEA824
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:12 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16761.1774422847649927255
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=CLiPZyga;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-202603250714051f1e89d3250002071e-oihlzf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202603250714051f1e89d3250002071e
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lQl+SDuMsEQlaWthQityfwqt4cL3OxMVKG3k/JLkdZ4=;
 b=CLiPZyga9ZiU6VsClpmlXg6HcK9VFlpAgw2IQzV470TkEGuGjhk5i8yhUP7M7F/jLj4LMz
 bgg+sRVr2c9Ymxz85Gfo2zfO+RIzRrWK7jAGaA8nXWkuGSmX0961WahTrQz8jk9wYqPNG/kg
 gwn4djl5tHC/u5kyksiLY/Va30g8jsSFQKVmjntlq3u1szpTYLhTMDjJdFts6QfLOEB59XMj
 oVJ3NoNpY6NLRm+tu9WC9D38kio8Rzq1ti+rRstV7o4K8+6uQ/M0F7crPEiQoMxsgAvTfSbU
 qFDzlMOmfcjnPEQMQpMVQDhZGS8X8nz1ennKqna/qTQaVwqcI7UTxBpw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 04/10] bitbake-setup: always restore sys.stdout
Date: Wed, 25 Mar 2026 07:51:46 +0100
Message-ID: <20260325071342.47272-5-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19224

From: Adrian Freihofer <adrian.freihofer@siemens.com>

While working on the bitbake-setup update with a non destructive fetcher,
I noticed that if the fetcher raises an exception, sys.stdout is not
restored, which can lead to issues in the rest of the code. This change
ensures that sys.stdout is always restored, even if an exception occurs
during the fetch and unpack process.

Showing the full Traceback of the error would be a bit confusing because
it happened in code which is not yet ready for review, but the final
error was:
  ValueError: I/O operation on closed file.

and this little change seems to be a reasonable improvement to avoid
such issues.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index dcad9c169..e8d520687 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -793,9 +793,11 @@ def do_fetch(fetcher, dir):
     with open(fetchlog, 'a') as f:
         oldstdout = sys.stdout
         sys.stdout = f
-        fetcher.download()
-        fetcher.unpack_update(dir)
-        sys.stdout = oldstdout
+        try:
+            fetcher.download()
+            fetcher.unpack_update(dir)
+        finally:
+            sys.stdout = oldstdout
 
 def update_registry(registry, cachedir, d):
     registrydir = 'configurations'
-- 
2.53.0


