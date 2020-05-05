Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
 by mx.groups.io with SMTP id smtpd.web12.7685.1588685228064521680
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2020 06:27:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.8, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:56798 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1jVxbG-00GdG6-Lx
	for bitbake-devel@lists.openembedded.org; Tue, 05 May 2020 09:27:07 -0400
Date: Tue, 5 May 2020 09:27:04 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: more nitpickery: difference between d.getVar() and d.expand()?
Message-ID: <alpine.LFD.2.21.2005050921570.14090@localhost.localdomain>
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


  no, wait, hear me out :-). still crawling through BB user manual,
section 3.5.2, talks about using d.getVar("X") "or for more
complicated expressions, use d.expand()".

  fair enough, but it seems like a lot of the code bounces back and
forth when getting the value of a simple variable, as in:

  libdir = d.getVar("libdir")
  libdir = d.expand("${libdir}")

given that d.getVar() by default expands the value, is there some
difference between the two statements above when specifically
accessing a single variable in the data dictionary?

rday
