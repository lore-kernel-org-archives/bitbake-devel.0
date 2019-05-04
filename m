Return-Path: <rpjday@crashcourse.ca>
Received: from emporiumvitreum.ca (cpanel4.indieserve.net [199.212.143.9])
	by mail.openembedded.org (Postfix) with ESMTP id A639F6C1CA
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 May 2019 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default;
	h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b/Id3tRB8ygsU89Px6Oc9qup2Can7M5NANUnU5kKLfE=;
	b=p1gUnGdzEbHqIOEemwnndAB9Ij
	OZR8+u5KCV7hkd+qFB4Dueqxvl5vlD7da+bmM0nkTnDw0CnsJZxB4ZDRVh6FPn0NbHhnj4vy0bRD/
	PBbyqLTFVxkCvqBLVmCvFGbX1pvvKkiZHF93RSVvLgI5kLcW3IlnUeByZfKMCO8do8LXmF0saIEQY
	0oo5CBk7FVI/tSwqT1KnNYMeqUfS+e4YLA6hgmGdmDr2M9Bn6RyM8Nh1wNsQ2l6wrBCbnQRcvuvr4
	meSevfBmgfgoHp7VFYRXAdFITTlMEmNgZTG4c9jtw4ez9usFYMPPASakIZKJH68IG43HrZOn7nqPz
	nrh9LL7Q==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:34612 helo=localhost.localdomain)
	by cpanel4.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
	(envelope-from <rpjday@crashcourse.ca>) id 1hN1pS-0003Vt-1e
	for bitbake-devel@lists.openembedded.org;
	Sat, 04 May 2019 17:04:18 -0400
Date: Sat, 4 May 2019 17:04:17 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.21.1905041701580.507@localhost.localdomain>
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
Subject: [PATCH] use the word "task" as the argument for --runall and --runonly
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
X-List-Received-Date: Sat, 04 May 2019 21:04:18 -0000
Content-Type: text/plain; charset=US-ASCII

The proper argument for "--runall" and "--runonly" should be "task".

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 8d1978f9..66ef84c7 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -280,10 +280,10 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Writes the event log of the build to a bitbake event json file. "
                                "Use '' (empty string) to assign the name automatically.")

-        parser.add_option("", "--runall", action="append", dest="runall",
+        parser.add_option("", "--runall", action="append", dest="task",
                           help="Run the specified task for any recipe in the taskgraph of the specified target (even if it wouldn't otherwise have run).")

-        parser.add_option("", "--runonly", action="append", dest="runonly",
+        parser.add_option("", "--runonly", action="append", dest="task",
                           help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")



-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

