Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
 by mx.groups.io with SMTP id smtpd.web11.25.1588804224157062740
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2020 15:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.8, mailfrom: rpjday@crashcourse.ca)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:59180 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1jWSYY-003SBx-J6
	for bitbake-devel@lists.openembedded.org; Wed, 06 May 2020 18:30:23 -0400
Date: Wed, 6 May 2020 18:30:20 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] user manual: properly tag content as <replaceable>
Message-ID: <alpine.LFD.2.21.2005061828570.16478@localhost.localdomain>
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

Tag a couple fields as replaceable to be consistent with rest of
manual.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 6c5234ed..e4251dff 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -618,12 +618,12 @@
         <para>
             Tasks can be either a shell task or a Python task.
             For shell tasks, BitBake writes a shell script to
-            <filename>${</filename><link linkend='var-bb-T'><filename>T</filename></link><filename>}/run.do_taskname.pid</filename>
+            <filename>${</filename><link linkend='var-bb-T'><filename>T</filename></link><filename>}/run.do_taskname.<replaceable>pid</replaceable></filename>
             and then executes the script.
             The generated shell script contains all the exported variables,
             and the shell functions with all variables expanded.
             Output from the shell script goes to the file
-            <filename>${T}/log.do_taskname.pid</filename>.
+            <filename>${T}/log.do_taskname.<replaceable>pid</replaceable></filename>.
             Looking at the expanded shell functions in the run file and
             the output in the log files is a useful debugging technique.
         </para>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
