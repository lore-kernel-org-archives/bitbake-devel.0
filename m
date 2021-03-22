Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web09.10624.1616408380906885158
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Mar 2021 03:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from bras-base-otwaon0916w-grc-67-70-50-7-189.dsl.bell.ca ([70.50.7.189]:47492 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lOHes-00Aa4p-W0
	for bitbake-devel@lists.openembedded.org; Mon, 22 Mar 2021 06:19:39 -0400
Date: Mon, 22 Mar 2021 06:19:36 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: mention that addtask handles multiple dependencies
Message-ID: <169a106e-fd23-64de-fcf3-e06afb421ac6@crashcourse.ca>
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


Add a note explaining that "addtask" can accept multiple dependencies,
just in case someone runs across such an example and is confused.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 7ea68ade..5ecda744 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1296,6 +1296,17 @@ For more information on task dependencies, see the
 See the ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:variable flags`" section for information
 on variable flags you can use with tasks.

+.. note::
+
+   While it's infrequent, it's possible to define multiple tasks as
+   dependencies when calling ``addtask``. For example, here's a snippet
+   from the OpenEmbedded class file ``package_tar.bbclass``::
+
+     addtask package_write_tar before do_build after do_packagedata do_package
+
+   Note how the ``package_write_tar`` task has to wait until both of
+   ``do_packagedata`` and ``do_package`` complete.
+
 Deleting a Task
 ---------------


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
