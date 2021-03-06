Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web11.7883.1615040423714639163
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Mar 2021 06:20:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:56242 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lIXn4-0000C2-Bp
	for bitbake-devel@lists.openembedded.org; Sat, 06 Mar 2021 09:20:22 -0500
Date: Sat, 6 Mar 2021 09:20:20 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: what is the purpose of task "showdata" in bitbake base.bbclass?
In-Reply-To: <198d52df-dde0-6649-99a8-6532837ff6b8@crashcourse.ca>
Message-ID: <d784d262-3e6a-40f5-f328-6f97949760ae@crashcourse.ca>
References: <198d52df-dde0-6649-99a8-6532837ff6b8@crashcourse.ca>
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

On Sat, 6 Mar 2021, Robert P. J. Day wrote:

>
>   perusing current BB code base, and noticed this in BB's
> base.bbclass:
>
> ...
> addtask showdata
> do_showdata[nostamp] = "1"
> python do_showdata() {
> ...
>
>   but i've never seen any mention of this task, i don't see where it's
> invoked and it looks really old. is it still doing something?

  never mind ... i *think* i just noticed that, when using OE, the
class files from OE override the identical ones from BB, so that tasks
defined in BB's base.bbclass don't exist; rather, some of them are
duplicated in OE's utility-tasks.bbclass. at least that's how it
appears.

rday
