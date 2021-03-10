Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web08.7410.1615375721023329065
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Mar 2021 03:28:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from bras-base-otwaon0916w-grc-29-64-229-255-220.dsl.bell.ca ([64.229.255.220]:57218 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lJx15-0007su-2r
	for bitbake-devel@lists.openembedded.org; Wed, 10 Mar 2021 06:28:40 -0500
Date: Wed, 10 Mar 2021 06:28:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: add another example of single-task variable setting
Message-ID: <1fb59c96-b675-b578-c426-f211efb28acf@crashcourse.ca>
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


Might as well give the reader an extra example of setting a variable
in the context of a single task.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 7ea68ade..9893ad02 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -580,9 +580,10 @@ variable.
    ``do_compile`` task.

    You can also use this syntax with other combinations (e.g.
-   "``_prepend``") as shown in the following example: ::
+   ``_prepend`` or ``_append``) as shown in the following examples: ::

       EXTRA_OEMAKE_prepend_task-compile = "${PARALLEL_MAKE} "
+      EXTRA_OEMAKE_append_task-configure = " JOBS=1"

 Key Expansion
 -------------

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
