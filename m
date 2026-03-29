Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698FFC97EE
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:31 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34479.1774809263056646482
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=Ko4ujvs+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260329183420abf5bff7c90002075e-o_ph0s@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260329183420abf5bff7c90002075e
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=u9P8iHjY758z1s97xk1S5g+9p+0GWZEJkZE1QI9MrqA=;
 b=Ko4ujvs+w7E6fePlIQpD4ogz2FcScRNBNUqY54Pzw5m0MgwougFVXKE8LR6r9O+UyUtX5e
 wDSG6Gh/btXMcNjgiC7RtEkyhaT7k9DZuLC7yHgHTxCAUYkeT3LYysDey34aA76yZ5cFZQVB
 uEjWzQyiqhogjO57BnDhfpl3LLKv7DelfYAzEUBZwIHJg0qgvD6jR418VOyXp91FJClOKLBe
 z3++PKjYcQq2XlCklUqR7clBFCmyBraonNWhUko5zWgKw4xudQPtV7XJ33nfPyqRQl+oy1Yp
 IzxpdQE9951HqBktoI771nECXGtYkcj7q+Mseh0wJeOe3o5b/L1w12Qw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 05/14] doc: document the unpack_update() non-destructive git update method
Date: Sun, 29 Mar 2026 20:32:52 +0200
Message-ID: <20260329183332.1996183-6-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19273

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add a new "The Non-Destructive Update (unpack_update)" section to the
fetching chapter, describing the in-place update mode introduced in
"fetch/git: Add an 'update' unpack mode to the fetchers (git only for now)"
e7d5e156275782948d3346f299780389ab263ab6.

The section covers:
- what unpack_update() does and when to use it vs. unpack()
- the three-step internal process: add/update the dldir remote,
  fetch the new upstream revision, rebase local commits on top
- the error conditions: LocalModificationsError (uncommitted changes),
  RebaseError (conflicting local commits), and the shallow/stale-dldir
  case
- the current limitation that only the Git fetcher supports it

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 .../bitbake-user-manual-fetching.rst          | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 6af803591..c2747c401 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -186,6 +186,51 @@ cloning the tree into the final directory. The process is completed
 using references so that there is only one central copy of the Git
 metadata needed.
 
+.. _bb-the-unpack-update:
+
+The Non-Destructive Update (``unpack_update``)
+==============================================
+
+.. note::
+
+   This is a specialised method intended for tools that manage persistent
+   layer checkouts on behalf of the user, such as
+   :ref:`bitbake-setup update <ref-bbsetup-command-update>`. It is not part of the
+   normal recipe fetch/unpack flow.
+
+For Git URLs, an alternative ``unpack_update()`` method is available
+that updates an existing checkout *in place* rather than removing and
+re-cloning it. This is useful when the target directory may contain
+local commits that should be preserved across updates.
+
+The code to call the non-destructive update looks like the following::
+
+   rootdir = l.getVar('UNPACKDIR')
+   fetcher.unpack_update(rootdir)
+
+``unpack_update()`` performs the following steps:
+
+1. A ``dldir`` git remote is added (or updated) in the existing
+   checkout, pointing at the local download cache. This remote may
+   also be useful for manually resolving conflicts outside the fetcher.
+2. The new upstream revision is fetched from the ``dldir`` remote into
+   the existing repository.
+3. Any local commits are rebased on top of the new upstream revision,
+   preserving local work.
+
+The method raises an error if:
+
+-  The working tree contains staged or unstaged changes to tracked
+   files (``LocalModificationsError``).
+-  Local commits cannot be cleanly rebased onto the new upstream
+   revision (``RebaseError``). A failed rebase is automatically aborted
+   before the exception is raised.
+-  The download cache does not contain a sufficiently recent clone
+   of the repository, or the checkout is a shallow clone.
+
+Currently only the Git fetcher supports ``unpack_update()``. All other
+fetcher types raise ``RuntimeError`` if it is called.
+
 .. _bb-fetchers:
 
 Fetchers
-- 
2.53.0


