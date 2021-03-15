Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web08.7524.1615809270119071609
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Mar 2021 04:54:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:48212 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lLlnn-00ABfr-Us
	for bitbake-devel@lists.openembedded.org; Mon, 15 Mar 2021 07:54:28 -0400
Date: Mon, 15 Mar 2021 07:54:24 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: move BBFILES_DYNAMIC for alphabetical order
Message-ID: <8a9ed89-7a17-dfef-76e9-a0374df29132@crashcourse.ca>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: text/plain; charset=US-ASCII

Since BBFILES_DYNAMIC does not have a "BB_" prefix, it belongs further
down in the variable glossary.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index d8c88c61..1528b040 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -270,45 +270,6 @@ overview of their function and contents.
       ``my-recipe.bb`` is executing, the ``BB_FILENAME`` variable contains
       "/foo/path/my-recipe.bb".

-   :term:`BBFILES_DYNAMIC`
-      Activates content depending on presence of identified layers.  You
-      identify the layers by the collections that the layers define.
-
-      Use the ``BBFILES_DYNAMIC`` variable to avoid ``.bbappend`` files whose
-      corresponding ``.bb`` file is in a layer that attempts to modify other
-      layers through ``.bbappend`` but does not want to introduce a hard
-      dependency on those other layers.
-
-      Additionally you can prefix the rule with "!" to add ``.bbappend`` and
-      ``.bb`` files in case a layer is not present.  Use this avoid hard
-      dependency on those other layers.
-
-      Use the following form for ``BBFILES_DYNAMIC``: ::
-
-         collection_name:filename_pattern
-
-      The following example identifies two collection names and two filename
-      patterns: ::
-
-         BBFILES_DYNAMIC += "\
-             clang-layer:${LAYERDIR}/bbappends/meta-clang/*/*/*.bbappend \
-             core:${LAYERDIR}/bbappends/openembedded-core/meta/*/*/*.bbappend \
-         "
-
-      When the collection name is prefixed with "!" it will add the file pattern in case
-      the layer is absent: ::
-
-         BBFILES_DYNAMIC += "\
-             !clang-layer:${LAYERDIR}/backfill/meta-clang/*/*/*.bb \
-         "
-
-      This next example shows an error message that occurs because invalid
-      entries are found, which cause parsing to abort: ::
-
-         ERROR: BBFILES_DYNAMIC entries must be of the form {!}<collection name>:<filename pattern>, not:
-         /work/my-layer/bbappends/meta-security-isafw/*/*/*.bbappend
-         /work/my-layer/bbappends/openembedded-core/meta/*/*/*.bbappend
-
    :term:`BB_GENERATE_MIRROR_TARBALLS`
       Causes tarballs of the Git repositories, including the Git metadata,
       to be placed in the :term:`DL_DIR` directory. Anyone
@@ -684,6 +645,45 @@ overview of their function and contents.
       For details on the syntax, see the documentation by following the
       previous link.

+   :term:`BBFILES_DYNAMIC`
+      Activates content depending on presence of identified layers.  You
+      identify the layers by the collections that the layers define.
+
+      Use the ``BBFILES_DYNAMIC`` variable to avoid ``.bbappend`` files whose
+      corresponding ``.bb`` file is in a layer that attempts to modify other
+      layers through ``.bbappend`` but does not want to introduce a hard
+      dependency on those other layers.
+
+      Additionally you can prefix the rule with "!" to add ``.bbappend`` and
+      ``.bb`` files in case a layer is not present.  Use this avoid hard
+      dependency on those other layers.
+
+      Use the following form for ``BBFILES_DYNAMIC``: ::
+
+         collection_name:filename_pattern
+
+      The following example identifies two collection names and two filename
+      patterns: ::
+
+         BBFILES_DYNAMIC += "\
+             clang-layer:${LAYERDIR}/bbappends/meta-clang/*/*/*.bbappend \
+             core:${LAYERDIR}/bbappends/openembedded-core/meta/*/*/*.bbappend \
+         "
+
+      When the collection name is prefixed with "!" it will add the file pattern in case
+      the layer is absent: ::
+
+         BBFILES_DYNAMIC += "\
+             !clang-layer:${LAYERDIR}/backfill/meta-clang/*/*/*.bb \
+         "
+
+      This next example shows an error message that occurs because invalid
+      entries are found, which cause parsing to abort: ::
+
+         ERROR: BBFILES_DYNAMIC entries must be of the form {!}<collection name>:<filename pattern>, not:
+         /work/my-layer/bbappends/meta-security-isafw/*/*/*.bbappend
+         /work/my-layer/bbappends/openembedded-core/meta/*/*/*.bbappend
+
    :term:`BBINCLUDED`
       Contains a space-separated list of all of all files that BitBake's
       parser included during parsing of the current file.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
