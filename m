Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
 by mx.groups.io with SMTP id smtpd.web10.7890.1588603922664768085
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 May 2020 07:52:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.8, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:50760 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1jVcRs-00DZyZ-NV
	for bitbake-devel@lists.openembedded.org; Mon, 04 May 2020 10:52:01 -0400
Date: Mon, 4 May 2020 10:51:58 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] docs: delete reference to obsolete recipe-depends.dot
Message-ID: <alpine.LFD.2.21.2005041048060.212516@localhost.localdomain>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: text/plain; charset=US-ASCII

Given that generation of recipe-depends.dot was removed:

  commit 4c484cc01e3eee7ab2ab0359fd680b4dbd31dc30
  Author: Chen Qi <Qi.Chen@windriver.com>
  Date:   Thu Aug 22 15:52:51 2019 +0800

      cooker.py: remove generation of recipe-depends.dot

      The information of recipe-depends.dot is misleading.

delete mention of it from the user manual.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index f5526c05..995c2fa7 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -694,14 +694,9 @@
                 </para>

                 <para>
-                    When you generate a dependency graph, BitBake writes three files
+                    When you generate a dependency graph, BitBake writes two files
                     to the current working directory:
                     <itemizedlist>
-                        <listitem><para>
-                            <emphasis><filename>recipe-depends.dot</filename>:</emphasis>
-                            Shows dependencies between recipes (i.e. a collapsed version of
-                            <filename>task-depends.dot</filename>).
-                            </para></listitem>
                         <listitem><para>
                             <emphasis><filename>task-depends.dot</filename>:</emphasis>
                             Shows dependencies between tasks.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
