Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B82C83F0A
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 18:17:06 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.web10.4085.1752085022223879260
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Jul 2025 11:17:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=TKIGQ+Hu;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i8dM6Fia8aTjzpVJ4IMs4rIt58RccrGhFnTqgfJXD+A=; b=TKIGQ+HuDuCZdZwfKBj5ER/YdM
	oISHoCz3+MkJnQNPP9qkrMFuAzzE93ZAC5Fa1x7FOFH1MZZLV87iVBZ7w59+NhFKNm6pbxl9gQvqB
	vKaZR1k4c2xa1aVRwfjpRx2y7Ec59hn/vpNBWaijnECWdtrbpgJn+AqoB2V5f4cchjFVmpb8CbqnF
	c30zAPkJSnO7PAA+W/L9ApvyDCXp3vBbORQSBPMsY+rC8K8YUXZif0AEwZwFP7bzz3/2txFjXyZID
	U+wo0yKusH806scR6Luz6+uo0wd1x1zwDLJrJyKqprDbp3iVRNrHmENrJEOd0j2biQktB6E0TLinl
	THD6GYjg==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:56352 helo=asus)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1uZZLm-0000000BYhO-0DD4;
	Wed, 09 Jul 2025 14:17:00 -0400
Date: Wed, 9 Jul 2025 14:16:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bitbake: clarify significance of "include_all" directive
Message-ID: <f7199bf7-9b0c-9218-1a8d-15f8a83bc869@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel10.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel10.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel10.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Jul 2025 18:17:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17766


Rewrite the include and include_all sections to drive home the fact
that the include_all directive is relevant in only very specific
cases, and not something developers should expect to use in normal
operation.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index f60a9d831..1042c65d8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -874,58 +874,67 @@ becomes a no-op.
 ``include`` Directive
 ---------------------

-BitBake understands the ``include`` directive. This directive causes
-BitBake to parse whatever file you specify, and to insert that file at
-that location. The directive is much like its equivalent in Make except
-that if the path specified on the include line is a relative path,
-BitBake locates the first file it can find within :term:`BBPATH`.
-
-The include directive is a more generic method of including
+The ``include`` directive causes BitBake to parse a given file,
+and to include that file's contents at the location of the
+``include`` statement. This directive is similar to its equivalent
+in Make, except that if the path specified on the BitBake ``include``
+line is a relative path, BitBake will search for it on the path designated
+by :term:`BBPATH` and will include *only the first matching file*.
+
+The ``include`` directive is a more generic method of including
 functionality as compared to the :ref:`inherit <bitbake-user-manual/bitbake-user-manual-metadata:\`\`inherit\`\` directive>`
 directive, which is restricted to class (i.e. ``.bbclass``) files. The
-include directive is applicable for any other kind of shared or
+``include`` directive is applicable for any other kind of shared or
 encapsulated functionality or configuration that does not suit a
 ``.bbclass`` file.

-As an example, suppose you needed a recipe to include some self-test
-definitions::
+For example, if you needed a recipe to include some self-test definitions,
+you might write::

    include test_defs.inc

+The ``include`` directive does not produce an error if the specified file
+cannot be found. If the included file *must* exist, then you should use
+use :ref:`require <require-inclusion>` instead, which will generate an error
+if the file cannot be found.
+
 .. note::

-   The include directive does not produce an error when the file cannot be
-   found.  Consequently, it is recommended that if the file you are including is
-   expected to exist, you should use :ref:`require <require-inclusion>` instead
-   of include . Doing so makes sure that an error is produced if the file cannot
-   be found.
+   Note well that the ``include`` directive will include the first matching
+   file and nothing further (which is almost always the behaviour you want).
+   If you need to include all matching files, you need to use the
+   ``include_all`` directive, explained below.

 ``include_all`` Directive
 -------------------------

 The ``include_all`` directive works like the :ref:`include
 <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
-directive but will include all of the files that match the specified path in
+directive but will include *all* of the files that match the specified path in
 the enabled layers (layers part of :term:`BBLAYERS`).

-For example, let's say a ``maintainers.inc`` file is present in different layers
-and is conventionally placed in the ``conf/distro/include`` directory of each
-layer. In that case the ``include_all`` directive can be used to include
-the ``maintainers.inc`` file for all of these layers::
+.. note::

-   include_all conf/distro/include/maintainers.inc
+   This behaviour is rarely what you want in normal operation, and should
+   be reserved for only those situations when you explicitly want to parse
+   and include all matching files found across all layers, as the following
+   example shows.

-In other words, the ``maintainers.inc`` file for each layer is included through
-the :ref:`include <bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
-directive.
+As a realistic example of this directive, imagine that all of your active
+layers contain a file ``conf/distro/include/maintainers.inc``, containing
+maintainer information for the recipes in that layer, and you wanted to
+collect all of the content from all of those files across all of those layers.
+You could use the statement::
+
+   include_all conf/distro/include/maintainers.inc

-BitBake will iterate through the colon-separated :term:`BBPATH` list to look for
-matching files to include, from left to right. As a consequence, matching files
-are included in that order.
+In this case, BitBake will iterate through all of the directories in
+the colon-separated :term:`BBPATH` (from left to right) and collect the
+contents of all matching files, so you end up with the maintainer
+information of all of your active layers, not just the first one.

-As the ``include_all`` directive uses the :ref:`include
-<bitbake-user-manual/bitbake-user-manual-metadata:\`\`include\`\` directive>`
-directive in the background, no error is produced if no files are matched.
+As the ``include_all`` directive uses the ``include`` directive in the
+background, as with ``include``, no error is produced if no files are matched.

 .. _require-inclusion:


