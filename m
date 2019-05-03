Return-Path: <rpjday@crashcourse.ca>
X-Greylist: delayed 1192 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 03 May 2019 18:47:18 UTC
Received: from somersetfoodbank.org (cpanel4.indieserve.net [199.212.143.9])
	by mail.openembedded.org (Postfix) with ESMTP id 515736D548
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 May 2019 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default;
	h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VJRbUK8w9Z+DFJtv9fQB+9dgRXOOBarM/h6TyFQc5Q0=;
	b=ZrE8TiyMXZjD7bLYlQ3/8t00Is
	8Usr4CbmPqL9N++/5/c+QNcJXaLIDMq60j4mvhttM8sPO2cuJxP2PvzEOjCdQAbgU8mJn3n4eyodA
	JIGNaShKcaT+GEjvmpXm8uzkCBw5pFUlCFVnYvme7NxxFNy6wd7HMU+jwEoVJNn0lDIWkL9fn/3TM
	cCaS3/bn02jYh90yHtPs6VVxFgxf08pNJkhWNELEji2dXf6XUV3rLDqjpVFzKYi6xrkrkgs7xpp2d
	ZI8RBh7mq2eBGjSEVF0X2wRr4utv//2eAud32A1gjZXwljnC3iM5v8Zxc59Z6TByXWW56M2h4qQBB
	WLJBeiSw==;
Received: from [72.142.126.219] (port=43290 helo=localhost.localdomain)
	by cpanel4.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
	(envelope-from <rpjday@crashcourse.ca>) id 1hMcu5-0002kl-LF
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 May 2019 14:27:26 -0400
Date: Fri, 3 May 2019 14:27:25 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.21.1905031426110.10665@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] help: reword "runall" entries to refer to a TASK
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
X-List-Received-Date: Fri, 03 May 2019 18:47:19 -0000
Content-Type: text/plain; charset=US-ASCII

Rewording argument to the word "TASK" should be self-evident.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index 02058a6f..74b74bff 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -573,10 +573,10 @@
                              Writes the event log of the build to a bitbake event
                              json file. Use '' (empty string) to assign the name
                              automatically.
-       --runall=RUNALL       Run the specified task for any recipe in the taskgraph
+       --runall=TASK         Run the specified task for any recipe in the taskgraph
                              of the specified target (even if it wouldn't otherwise
                              have run).
-       --runonly=RUNONLY     Run only the specified task within the taskgraph of
+       --runonly=TASK        Run only the specified task within the taskgraph of
                              the specified targets (and any task dependencies those
                              tasks may have).
                 </literallayout>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

