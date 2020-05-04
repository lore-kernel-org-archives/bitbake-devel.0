Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
 by mx.groups.io with SMTP id smtpd.web11.6105.1588598961100654434
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 May 2020 06:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.8, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:49580 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1jVb9r-00DNaO-TY
	for bitbake-devel@lists.openembedded.org; Mon, 04 May 2020 09:29:20 -0400
Date: Mon, 4 May 2020 09:29:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: bitbake manual: emphasizing "PROVIDES =", not "PROVIDES +="
Message-ID: <alpine.LFD.2.21.2005040925430.208011@localhost.localdomain>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
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


  i believe we clarified recently that the use of "PROVIDES +=" was
superfluous, as ${PN} is already implicitly part of the PROVIDES
content of a recipe, so "PROVIDES =" is sufficient to add *extra*
entries.

  Section 2.3 of the BB manual gives the distinct impression that one
should use "+=", so i can submit a patch to adjust that. there's quite
a lot of "+=" usage in the oe-core layer -- is it worth cleaning that
up? it does not, of course, hurt anything, but it potentially leads to
confusion if one is RTFS.

rday
