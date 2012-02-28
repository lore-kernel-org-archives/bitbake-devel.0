Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S2LuH-000647-6e for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 13:11:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1SC3LTB016721;
	Tue, 28 Feb 2012 12:03:21 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15714-08; Tue, 28 Feb 2012 12:03:17 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1SC3Cuc016715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Feb 2012 12:03:13 GMT
Message-ID: <1330430595.9185.109.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andreas Oberritter <obi@opendreambox.org>
Date: Tue, 28 Feb 2012 12:03:15 +0000
In-Reply-To: <4F4CC00F.10608@opendreambox.org>
References: <4F4CC00F.10608@opendreambox.org>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Git, AUTOREV and SSH
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 28 Feb 2012 12:11:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-02-28 at 12:52 +0100, Andreas Oberritter wrote:
> Hi,
> 
> there's a problem with the Git fetcher when used with AUTOREV, at least
> with SSH URIs. "git ls-remote" may output warnings on stderr, e.g.:
> 
> X11 forwarding request failed on channel 0
> 
> When this happens, "X11" becomes the SRCREV and the fetcher subsequently
> fails. Certainly, other warnings by Git, SSH or a different SCM or
> transport could appear under other circumstances. Even localized strings
> may appear. Fetch2 merges stderr into stdout on purpose [1], so I'm not
> sure a proper fix should look like.
> 
> Regards,
> Andreas
> 
> [1] See runfetchcmd() in lib/bb/fetch2/__init__.py

Would the change in
http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-January/001771.html help?

I've still not had a chance to rebase and apply that patch :(

Cheers,

Richard



