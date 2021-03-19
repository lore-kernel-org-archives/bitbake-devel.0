Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web12.5291.1616156131269746027
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Mar 2021 05:15:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from bras-base-otwaon0916w-grc-29-64-229-255-220.dsl.bell.ca ([64.229.255.220]:57262 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lNE2L-00Ea3Y-8O
	for bitbake-devel@lists.openembedded.org; Fri, 19 Mar 2021 08:15:29 -0400
Date: Fri, 19 Mar 2021 08:15:27 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: fix syntax error in layer.conf example
Message-ID: <5bb8f97b-33b0-9a69-ee9-34613313a84@crashcourse.ca>
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


While this example really needs to be rewritten to not define multiple
patterns in the same layer.conf, as long as it's there, it might as
well be syntactically correct.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d74e768f..56abf773 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -244,7 +244,8 @@ want upstream. Here is an example: ::
   BBFILE_COLLECTIONS = "upstream local"
   BBFILE_PATTERN_upstream = "^/stuff/openembedded/"
   BBFILE_PATTERN_local = "^/stuff/openembedded.modified/"
-  BBFILE_PRIORITY_upstream = "5" BBFILE_PRIORITY_local = "10"
+  BBFILE_PRIORITY_upstream = "5"
+  BBFILE_PRIORITY_local = "10"

 .. note::


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
