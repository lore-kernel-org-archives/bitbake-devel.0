Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web08.13588.1615066042958902494
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Mar 2021 13:27:23 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:33124 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lIeSH-00058F-C3
	for bitbake-devel@lists.openembedded.org; Sat, 06 Mar 2021 16:27:21 -0500
Date: Sat, 6 Mar 2021 16:27:19 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] properly render backslash characters
Message-ID: <f5f6d56c-2097-2287-7aa0-1cb33c2b50de@crashcourse.ca>
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


Currently, with only a single backslash character in the docs, no
character shows up. This was tested by building the sphinx docs and
verifying the backslash showing up.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 7ea68ade..2e3f706c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -103,15 +103,15 @@ Line Joining

 Outside of :ref:`functions <bitbake-user-manual/bitbake-user-manual-metadata:functions>`,
 BitBake joins any line ending in
-a backslash character ("\") with the following line before parsing
-statements. The most common use for the "\" character is to split
+a backslash character ("\\") with the following line before parsing
+statements. The most common use for the "\\" character is to split
 variable assignments over multiple lines, as in the following example: ::

    FOO = "bar \
           baz \
           qaz"

-Both the "\" character and the newline
+Both the "\\" character and the newline
 character that follow it are removed when joining lines. Thus, no
 newline characters end up in the value of ``FOO``.

@@ -124,7 +124,7 @@ Consider this additional example where the two assignments both assign

 .. note::

-   BitBake does not interpret escape sequences like "\n" in variable
+   BitBake does not interpret escape sequences like "\\n" in variable
    values. For these to have an effect, the value must be passed to some
    utility that interprets escape sequences, such as
    ``printf`` or ``echo -n``.


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
