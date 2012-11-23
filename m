Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TbzPO-00018y-Nu; Fri, 23 Nov 2012 20:59:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qANJjKX8006703;
	Fri, 23 Nov 2012 19:45:20 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04388-08; Fri, 23 Nov 2012 19:45:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qANJjAgX006659
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 23 Nov 2012 19:45:12 GMT
Message-ID: <1353699909.7352.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Date: Fri, 23 Nov 2012 19:45:09 +0000
In-Reply-To: <CAP9ODKqPx8AE9O66ALLkpwXDFxr1outs_tdeDG2DnyZdw9Q=Ag@mail.gmail.com>
References: <1353691611.1361.28.camel@ted>
	<CAP9ODKqPx8AE9O66ALLkpwXDFxr1outs_tdeDG2DnyZdw9Q=Ag@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Constantin Musca <constantinx.musca@intel.com>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] RFC: Versioning of git recipes (and incremental PR)
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
X-List-Received-Date: Fri, 23 Nov 2012 19:59:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-11-23 at 17:23 -0200, Otavio Salvador wrote:
> I like to idea of a single updating place. What I dislike is AUTOINC
> not being taken care in the fetcher.
>
> In this case any GIT revision changes, the AUTOINC won't bump as usual
> (without PR server)?

Why do you need AUTOINC to bump? The only reason we have increments in
the fetcher is for package upgrading...

Cheers,

Richard






