Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
	by mail.openembedded.org (Postfix) with ESMTP id 4F8EC60ACB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Feb 2020 09:52:10 +0000 (UTC)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:36902 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
	(envelope-from <rpjday@crashcourse.ca>) id 1j00J0-005JD1-Px
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Feb 2020 04:52:11 -0500
Date: Fri, 7 Feb 2020 04:52:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.21.2002070449140.2057256@localhost.localdomain>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] doc: Explain dynamic calculation of BB_NUMBER_THREADS
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
X-List-Received-Date: Fri, 07 Feb 2020 09:52:10 -0000
Content-Type: text/plain; charset=US-ASCII


While it's useful for the reader to know about BB_NUMBER_THREADS, make
it clear that that value will be calculated automatically by default.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 46dafeee..f22ab36e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -53,6 +53,15 @@
                 A possibly simpler solution is that some Linux distributions
                 (e.g. Debian and Ubuntu) provide the <filename>ncpus</filename> command.
             </para>
+
+	    <para>
+		If you don't explicitly set this variable, OpenEmbedded
+		will do it for you via the default <filename>bitbake.conf</filename>
+		file by running an OE-supplied utility routine:
+		<literallayout class='monospaced'>
+     BB_NUMBER_THREADS ?= "${@oe.utils.cpu_count()}"
+		</literallayout>
+	    </para>
         </note>
     </para>

@@ -569,7 +578,8 @@

         <para>
             It is worth noting that you can greatly speed up the build time by properly setting
-            the <filename>BB_NUMBER_THREADS</filename> variable.
+            the <filename>BB_NUMBER_THREADS</filename> variable although, if you don't,
+	    its value will be determined dynamically by an OpenEmbedded utility routine.
         </para>

         <para>

--

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

