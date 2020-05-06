Received: from cpanel7.indieserve.net (cpanel7.indieserve.net [199.212.143.8])
 by mx.groups.io with SMTP id smtpd.web11.2987.1588779663450930208
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2020 08:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.8, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:43092 helo=localhost.localdomain)
	by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1jWMAP-002Y19-KV
	for bitbake-devel@lists.openembedded.org; Wed, 06 May 2020 11:41:02 -0400
Date: Wed, 6 May 2020 11:40:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: BB user manual, "Variable Flags" can be applied to non-tasks, no?
Message-ID: <alpine.LFD.2.21.2005061136300.343666@localhost.localdomain>
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


  still poring over BB user manual -- Section 3.7 on variable flags
strongly suggests that numerous flags can be applied to tasks only,
but it seems that you can apply many of the same flags to non-task
functions. one example from package.bbclass:

  python perform_packagecopy () {
        ... snip ...
  }
  ...
  perform_packagecopy[cleandirs] = "${PKGD}"
  perform_packagecopy[dirs] = "${PKGD}"

pretty sure that function is not registered as a task, but still has a
couple flags applied to it. clarification?

rday

p.s. hang on ... it seems weird for the same routine to have both the
[dirs] and [cleandirs] flags set.
