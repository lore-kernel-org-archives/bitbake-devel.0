Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id C1CFE6FD66
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 15:26:20 +0000 (UTC)
Received: from [69.196.158.250] (port=39661 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxHki-0001Rx-ND for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jun 2014 11:26:20 -0400
Date: Wed, 18 Jun 2014 11:22:38 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406181120030.29194@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] bitbake-user-manual-execution.xml: Update parallelization note.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 18 Jun 2014 15:26:27 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Update the note to explain that current versions of BitBake
automatically calculate the proper values for BB_NUMBER_THREADS and
PARALLEL_MAKE so you no longer need to set those values manually.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 8514f23..6d49fb6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -29,11 +29,23 @@
     </para>

     <note>
-        Prior to executing BitBake, you should take advantage of parallel
-        thread execution by setting the
-        <link linkend='var-BB_NUMBER_THREADS'><filename>BB_NUMBER_THREADS</filename></link>
-        variable in your <filename>local.conf</filename>
-        configuration file.
+        In order to take advantage of parallel thread execution on your build
+        host, earlier versions of BitBake recommended setting the following
+        variables in your project's <filename>local.conf</filename> file,
+        based on your host's number of CPUs or multithreading
+        capability:
+        <literallayout class='monospaced'>
+     BB_NUMBER_THREADS ?= ...
+     PARALLEL_MAKE ?= ...
+        </literallayout>
+        The current version of BitBake now handles this automatically by
+        assigning default values to those variables as follows:
+        <literallayout class='monospaced'>
+     BB_NUMBER_THREADS ?= "${@oe.utils.cpu_count()}"
+     PARALLEL_MAKE ?= "-j ${@oe.utils.cpu_count()}"
+        </literallayout>
+        so you no longer need to worry about this, unless you specifically
+        want to override this for some reason.
     </note>

     <section id='parsing-the-base-configuration-metadata'>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

