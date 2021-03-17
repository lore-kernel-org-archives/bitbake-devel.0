Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web10.1475.1616005495017503530
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Mar 2021 11:24:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:35548 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lMaqi-004xEY-Qu
	for bitbake-devel@lists.openembedded.org; Wed, 17 Mar 2021 14:24:54 -0400
Date: Wed, 17 Mar 2021 14:24:50 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: Ch 2, render "-S" bitbake option in monospaced font
Message-ID: <dbf4b753-edd4-a74e-7b1f-6296cfe61165@crashcourse.ca>
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


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d74e768f..6aa851fc 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -582,8 +582,8 @@ the build. This information includes:

 -  ``BB_TASKHASH``: The hash of the currently running task.

-It is worth noting that BitBake's "-S" option lets you debug BitBake's
-processing of signatures. The options passed to -S allow different
+It is worth noting that BitBake's ``-S`` option lets you debug BitBake's
+processing of signatures. The options passed to ``-S`` allow different
 debugging modes to be used, either using BitBake's own debug functions
 or possibly those defined in the metadata/signature handler itself. The
 simplest parameter to pass is "none", which causes a set of signature
@@ -597,7 +597,7 @@ where these two stamp trees diverge.
 .. note::

    It is likely that future versions of BitBake will provide other
-   signature handlers triggered through additional "-S" parameters.
+   signature handlers triggered through additional ``-S`` parameters.

 You can find more information on checksum metadata in the
 :ref:`bitbake-user-manual/bitbake-user-manual-metadata:task checksums and setscene`

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
