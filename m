Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web08.7873.1615039820388443624
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Mar 2021 06:10:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:56214 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lIXdK-00070b-Ul
	for bitbake-devel@lists.openembedded.org; Sat, 06 Mar 2021 09:10:19 -0500
Date: Sat, 6 Mar 2021 09:10:16 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: what is the purpose of task "showdata" in bitbake base.bbclass?
Message-ID: <198d52df-dde0-6649-99a8-6532837ff6b8@crashcourse.ca>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: text/plain; charset=US-ASCII


  perusing current BB code base, and noticed this in BB's
base.bbclass:

...
addtask showdata
do_showdata[nostamp] = "1"
python do_showdata() {
...

  but i've never seen any mention of this task, i don't see where it's
invoked and it looks really old. is it still doing something?

rday
