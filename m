Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AAFC61DE7
	for <webhook@archiver.kernel.org>; Sun, 22 Mar 2026 19:35:08 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1879.1774208105449107866
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2026 12:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=JFLT8R5B;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260322193502de1edffa0a000207f7-8mtxqw@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260322193502de1edffa0a000207f7
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 22 Mar 2026 20:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RVLQ4C+UbxiW6niKodR5U+DE8mzTjaaQsYbv/zRg7T0=;
 b=JFLT8R5B3ZI16z38iAM9QWB4hqf3ZX9LxXnxW6bsIzaX8mZBldqENgBEOf+BSRZ8BIHGXO
 +PE/XNZgjrjFl9Gjpt4uHdUmrHyccLjXydGBa3laxvk1x9O6ncm9W5j9+LXfFFOMaPwPnG1C
 EcaAzkfSR7V59DZfIus9WlrX8gfDQim/dAz7Vpn+OHLTYHNgN/8BEkyjCr/4yNfUimhAImbg
 Efug2qs+FHi2Ra8MONTu1ssmXrZiDD0JguI5gj5LFVuaBEMSdIjqOvDSAnbaNt3V28SF6tuz
 CQ7rJrwEhAmHhkMWyYAZZQEkyoBp6iCMa5ZCaACYuBkZpyzVJTCyyU3g==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 5/9] bitbake-setup: report local modifications blocking an update
Date: Sun, 22 Mar 2026 20:34:16 +0100
Message-ID: <20260322193440.870120-6-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-1-adrian.freihofer@siemens.com>
References: <20260322193440.870120-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2026 19:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19197

From: Adrian Freihofer <adrian.freihofer@siemens.com>

When unpack_update() detects uncommitted changes in a layer repository
it raises an UnpackError, which previously propagated as an unhandled
exception with an opaque traceback.

Catch the UnpackError in _checkout_git_remote and re-raise it as a
plain Exception with a message that:
- names the affected source and its path
- tells the user to commit, stash or discard the changes
- includes the original error detail for diagnostics

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index e8d520687..6d24f8fcc 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -182,7 +182,14 @@ def checkout_layers(layers, confdir, layerdir, d):
             else:
                 src_uri = f"{fetchuri};protocol={prot};rev={rev};nobranch=1;destsuffix={repodir}"
             fetcher = bb.fetch.Fetch([src_uri], d)
-            do_fetch(fetcher, layerdir)
+            repodir_path = os.path.join(layerdir, repodir)
+            try:
+                do_fetch(fetcher, layerdir)
+            except bb.fetch2.UnpackError as e:
+                raise Exception(
+                    "Cannot update source '{}' in {} because it has local modifications.\n"
+                    "Please commit, stash or discard your changes and re-run the update.\n"
+                    "Details: {}".format(r_name, repodir_path, e)) from None
             urldata = fetcher.ud[src_uri]
             revision = urldata.revision
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
-- 
2.53.0


