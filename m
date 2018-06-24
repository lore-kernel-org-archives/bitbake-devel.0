Return-Path: <rpjday@crashcourse.ca>
X-Greylist: delayed 1375 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 24 Jun 2018 18:39:19 UTC
Received: from cpanel4.indieserve.net (cpanel4.indieserve.net [199.212.143.9])
	by mail.openembedded.org (Postfix) with ESMTP id 0B07771C54
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Jun 2018 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default;
	h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bbfyxvQ314Uxxb4aj0bGpnRAuyM/4VXIm0sh++F9mdQ=;
	b=ase9c9iTbLW592+LP0LaMr0/fU
	xvZEFZ9bTp3zGbtTJQEm2mXU3ZHN9J8N96Oesuo51i4o8w54+t9q/buWRynckClfNzl2w1MCeuOkV
	zyQaHt88uD3YZO4KOgrEiPDlRilD6xMvcdZJwX0EHmazLYNb6pB7Xk26fBfdRA6PT818+4WIGZ9H5
	8GJEFO0MlmwtXQipnWLKJY1Y5KDQXtn9uJZ8gNxkaakXfIdP9UnbEKk6yFJIpMhqOAo8wWMgbvch+
	8vkWqSpfBWJTo7kuIZALYxzKm9bUfqQP9X7SWfF3xkpk0ComTwB1ugpfBK3h/zHsrBG/d8fSG20u/
	fEk6WfOA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:46668 helo=localhost.localdomain)
	by cpanel4.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
	(envelope-from <rpjday@crashcourse.ca>) id 1fX9Yk-006PFa-K3
	for bitbake-devel@lists.openembedded.org;
	Sun, 24 Jun 2018 14:16:23 -0400
Date: Sun, 24 Jun 2018 14:16:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.21.1806241413250.29780@localhost.localdomain>
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
Subject: is there a replacement for "bitbake -c fetchall"?
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
X-List-Received-Date: Sun, 24 Jun 2018 18:39:20 -0000
Content-Type: text/plain; charset=US-ASCII


  haven't messed with OE/YP for a few months, just now noticed that
the "fetchall" task has been removed, is there something equivalent
since i found that useful for grabbing everything i would need later,
and updating my local source mirror in the process.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

