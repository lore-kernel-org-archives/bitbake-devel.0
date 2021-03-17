Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web11.4505.1615977290249163074
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Mar 2021 03:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:47116 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lMTVo-003Ngo-FD
	for bitbake-devel@lists.openembedded.org; Wed, 17 Mar 2021 06:34:49 -0400
Date: Wed, 17 Mar 2021 06:34:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: Mention OE routine for setting BB_NUMBER_THREADS
Message-ID: <9914cbb9-eb88-c215-4fec-185762583ed@crashcourse.ca>
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

Given the discussion of BB_NUMBER_THREADS, what it means and how to
set it, it seems only fair to mention that it's probably already set.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d74e768f..a2003997 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -45,6 +45,13 @@ the BitBake command and its options, see ":ref:`The BitBake Command
    A possibly simpler solution is that some Linux distributions (e.g.
    Debian and Ubuntu) provide the ``ncpus`` command.

+   If you're using a relatively recent version of Poky or Openembedded,
+   the provided ``bitbake.conf`` file already comes with a call to an OE
+   utility routine that does this calculation for you::
+
+     # Default to setting automatically based on cpu count
+     BB_NUMBER_THREADS ?= "${@oe.utils.cpu_count()}"
+
 Parsing the Base Configuration Metadata
 =======================================


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
