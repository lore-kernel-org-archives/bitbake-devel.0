Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
 by mx.groups.io with SMTP id smtpd.web12.6439.1588600010819204780
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 May 2020 06:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.8, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:49874 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1jVbQn-00DQM4-CR; Mon, 04 May 2020 09:46:49 -0400
Date: Mon, 4 May 2020 09:46:47 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: Richard Purdie <richard.purdie@linuxfoundation.org>
cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] bitbake manual: emphasizing "PROVIDES =", not "PROVIDES +="
In-Reply-To: <0f87055b188c7f590385f825ac37571ec86fdf7d.camel@linuxfoundation.org>
Message-ID: <alpine.LFD.2.21.2005040946080.209057@localhost.localdomain>
References: <alpine.LFD.2.21.2005040925430.208011@localhost.localdomain> <0f87055b188c7f590385f825ac37571ec86fdf7d.camel@linuxfoundation.org>
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

On Mon, 4 May 2020, Richard Purdie wrote:

> On Mon, 2020-05-04 at 09:29 -0400, Robert P. J. Day wrote:
> >   i believe we clarified recently that the use of "PROVIDES +=" was
> > superfluous, as ${PN} is already implicitly part of the PROVIDES
> > content of a recipe, so "PROVIDES =" is sufficient to add *extra*
> > entries.
>
> You keep bringing this up and sorry but I don't agree with you. I've
> said this several times but you keep ignoring me as you don't like
> my perspective as it isn't neat or clear cut.

  point taken, i'll let this go.

rday
