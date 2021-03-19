Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web09.5570.1616157378595401303
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Mar 2021 05:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from bras-base-otwaon0916w-grc-29-64-229-255-220.dsl.bell.ca ([64.229.255.220]:57286 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lNEMS-00Eefd-Tb
	for bitbake-devel@lists.openembedded.org; Fri, 19 Mar 2021 08:36:17 -0400
Date: Fri, 19 Mar 2021 08:36:15 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: update example explaining DEFAULT_PREFERENCE
Message-ID: <ec846c59-9b49-9483-7a47-3c4c24fad833@crashcourse.ca>
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


Since busybox actually doesn't show an example of DEFAULT_PREFERENCE
anymore, use an existing example ripped from meta-python layer.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d74e768f..b77f038a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -336,21 +336,22 @@ file that BitBake parses, you can change that preference: ::

 .. note::

-   It is common for a recipe to provide two versions -- a stable,
-   numbered (and preferred) version, and a version that is automatically
-   checked out from a source code repository that is considered more
-   "bleeding edge" but can be selected only explicitly.
-
-   For example, in the OpenEmbedded codebase, there is a standard,
-   versioned recipe file for BusyBox, ``busybox_1.22.1.bb``, but there
-   is also a Git-based version, ``busybox_git.bb``, which explicitly
-   contains the line ::
-
+   The most common usage of ``DEFAULT_PREFERENCE`` is to add a
+   more recent, perhaps unstable or development version of a recipe,
+   while leaving an older, stable version in place as the default.
+
+   For example, in the current OpenEmbedded ``meta-python`` layer,
+   there are two supported versions of the recipe ``python3-django``:
+   the default stable version 2.2.16, and the newer version 3.1.1,
+   which contains the snippet::
+
+     # Set DEFAULT_PREFERENCE so that the LTS version of django is built by
+     # default. To build the 3.x branch,
+     # PREFERRED_VERSION_python3-django = "3.1.1" can be added to local.conf
      DEFAULT_PREFERENCE = "-1"

-   to ensure that the
-   numbered, stable version is always preferred unless the developer
-   selects otherwise.
+   to make sure the newer version is not selected unless the developer
+   explicitly asks for it.

 .. _bb-bitbake-dependencies:


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
