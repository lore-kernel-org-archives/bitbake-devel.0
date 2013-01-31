Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U0tjt-0005Ak-Ni for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 13:59:40 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0VCmQSI027270; Thu, 31 Jan 2013 12:48:27 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6My8of3fuqko; Thu, 31 Jan 2013 12:48:26 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0VCmIal027253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 31 Jan 2013 12:48:21 GMT
Message-ID: <1359636205.14071.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Thu, 31 Jan 2013 12:43:25 +0000
In-Reply-To: <20130130075555.GA7508@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
	<1359445811-6394-1-git-send-email-olof.johansson@axis.com>
	<20130130075555.GA7508@axis.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2 0/6] fetch2: Updated SFTP fetcher
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
X-List-Received-Date: Thu, 31 Jan 2013 12:59:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-01-30 at 08:55 +0100, Olof Johansson wrote:
> Hi,
> 
> On 2013-01-29 08:50, Olof Johansson wrote:
> > Olof Johansson (6):
> >   fetch2: Remove unused code in wget fetcher
> >   fetch2: Add a class representing a generic URI
> >   fetch2: unittests for bb.fetch2.URI class
> >   fetch2: Adapt encode/decode url to use URI class
> >   fetch2: Add editor modelines for bb.tests.*
> >   fetch2: Add SFTP fetcher
> 
> One thing I forgot to mention; after speaking with kergoth on IRC
> last Friday, we found that there are some performance penelties
> in using the URI class instead of encode/decodeurl. I tried to
> profile and see if there were any obvious ways to get it down to
> the level of the old encode/decodeurl, but nothing obvious.
> 
> I did the performance evaluation by running the unittests.
> 
> Forking and running the unittests in seperate processes shows no
> change:
> 
>  http://codepad.org/SYsVsckY
> 
> However, running them in a single process with the timeit module
> shows a pretty big (proportional) regression:
> 
>  http://codepad.org/Vzu7Pqqw
> 
> Is this significant? Running the tests 10000, each run creating
> three URI objects, takes ~2 seconds.

In the scheme of things and other bitbake overheads, I'd suspect its not
significant although it is a good thing to check...

What were the other changes between v1 and v2? In cases like this a 0/6
summary email is helpful.

Cheers,

Richard





