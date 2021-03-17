Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web12.4248.1615975817653921188
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Mar 2021 03:10:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from bras-base-otwaon0916w-grc-29-64-229-255-220.dsl.bell.ca ([64.229.255.220]:47052 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lMT83-003IxP-UI
	for bitbake-devel@lists.openembedded.org; Wed, 17 Mar 2021 06:10:16 -0400
Date: Wed, 17 Mar 2021 06:10:14 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: Ch 1, render options in monospaced for clarity
Message-ID: <9c8573c-16cd-d88e-ccce-3a93749a2e1@crashcourse.ca>
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


Options are more visually obvious when rendered as monospaced.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 6f9d3929..f850c166 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -479,7 +479,7 @@ The following command runs the clean task on the ``foo.bb`` recipe file: ::

 .. note::

-   The "-b" option explicitly does not handle recipe dependencies. Other
+   The ``-b`` option explicitly does not handle recipe dependencies. Other
    than for debugging purposes, it is instead recommended that you use
    the syntax presented in the next section.

@@ -494,7 +494,7 @@ dependencies, both for build-time and runtime. There must be a way for
 you to express recipe preferences when multiple recipes provide the same
 functionality, or when there are multiple versions of a recipe.

-The ``bitbake`` command, when not using "--buildfile" or "-b" only
+The ``bitbake`` command, when not using ``--buildfile`` or ``-b`` only
 accepts a "PROVIDES". You cannot provide anything else. By default, a
 recipe file generally "PROVIDES" its "packagename" as shown in the
 following example: ::
@@ -502,7 +502,7 @@ following example: ::
   $ bitbake foo

 This next example "PROVIDES" the
-package name and also uses the "-c" option to tell BitBake to just
+package name and also uses the ``-c`` option to tell BitBake to just
 execute the ``do_clean`` task: ::

   $ bitbake -c clean foo
@@ -534,7 +534,7 @@ current working directory:
 -  ``pn-buildlist``: Shows a simple list of targets that are to be
    built.

-To stop depending on common depends, use the "-I" depend option and
+To stop depending on common depends, use the ``-I`` depend option and
 BitBake omits them from the graph. Leaving this information out can
 produce more readable graphs. This way, you can remove from the graph
 ``DEPENDS`` from inherited classes such as ``base.bbclass``.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
