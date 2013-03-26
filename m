Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UKPNR-0007I2-Ry
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Mar 2013 09:37:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 960712614C1;
	Tue, 26 Mar 2013 09:20:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oRDCLODvHWZZ; Tue, 26 Mar 2013 09:20:05 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by ra.se.axis.com (Postfix) with ESMTP id ED29D2614E1;
	Tue, 26 Mar 2013 09:12:14 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id AD0F53E3C1;
	Tue, 26 Mar 2013 09:12:14 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.176.0;
	Tue, 26 Mar 2013 09:12:14 +0100
Date: Tue, 26 Mar 2013 09:12:34 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20130326081234.GN7904@axis.com>
References: <1364239962-11399-1-git-send-email-olof.johansson@axis.com>
	<1364245781.3097.72.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1364245781.3097.72.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bb.tests.fetch: Opt-in for unittests that require network
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
X-List-Received-Date: Tue, 26 Mar 2013 08:37:07 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 2013-03-25 22:09, Richard Purdie wrote:
> On Mon, 2013-03-25 at 20:32 +0100, Olof Johansson wrote:
> > With this change, you have to opt-in to run unit tests that require an internet
> > connection. To opt-in, you'll set the environment variable BB_NETTESTS to 'yes'.
> 
> Can we do this the other way please and let people opt-out? I'd rather
> people make a conscious decision to opt-out than in.

Sure! I'm just used to unit tests not having (or having very
limited) side effects by default. But it's easy to change, so
I'll do it right away. Thanks for the feedback.

/Olof Johansson


