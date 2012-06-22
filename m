Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Shz6V-0001ib-6V for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jun 2012 10:20:31 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5M89h7h032168;
	Fri, 22 Jun 2012 09:09:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27315-06; Fri, 22 Jun 2012 09:09:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5M89XSP032162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 09:09:35 +0100
Message-ID: <1340352576.394.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Fri, 22 Jun 2012 09:09:36 +0100
In-Reply-To: <CAC1BbcQgOqcPTnRZksao5yFVH1k8UzcJOCGGO6gzBUWTiPUp7g@mail.gmail.com>
References: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
	<1340280968.1640.96.camel@ted>
	<CAC1BbcSr8K79m6idqVvDDrYG1KxgrMEVwmDVb2KWZ8xrUC0Z9Q@mail.gmail.com>
	<1340285156.1640.114.camel@ted>
	<CAC1BbcQgOqcPTnRZksao5yFVH1k8UzcJOCGGO6gzBUWTiPUp7g@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: do not try to checksum a socket
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
X-List-Received-Date: Fri, 22 Jun 2012 08:20:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-21 at 15:57 +0200, Bernhard Reutner-Fischer wrote:
> >
> > FWIW, the url you want is git:///mydir;protocol=file which should work.
> 
> Oh, that's rather surprising!
> The format suggested to me that, iff specified, with "protocol=" i can
> select the fetcher, regardless of the actual path-spec.
> Shouldn't protocol have precedence over any eventual path-implied fetcher?
> file:///mydir;protocol=rsync
>   rsync -a /mydir S
> file:///mydir;protocol=git
>   git clone -s file:///mydir S

No, things work the opposite way around, they always have done and
trying to change that now would be hard. It makes most sense when you
think about it that anything starting with "git://" gets passed to the
git fetcher code, anything "file://" to the local fetcher and so on.

Cheers,

Richard



