Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TxFJC-00028F-P7 for bitbake-devel@lists.openembedded.org;
	Mon, 21 Jan 2013 12:13:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0LAvOoK015819;
	Mon, 21 Jan 2013 10:57:24 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04712-08; Mon, 21 Jan 2013 10:57:20 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0LAvFaD015804
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 10:57:16 GMT
Message-ID: <1358765836.14265.47.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 21 Jan 2013 10:57:16 +0000
In-Reply-To: <20121216201501.GG3448@jama>
References: <1355493212.32519.16.camel@ted> <20121216201501.GG3448@jama>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Philip Balister <philip@balister.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: BBHandler/ConfHandler: Improve multiline comment handling
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
X-List-Received-Date: Mon, 21 Jan 2013 11:13:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-12-16 at 21:15 +0100, Martin Jansa wrote:
> On Fri, Dec 14, 2012 at 01:53:32PM +0000, Richard Purdie wrote:
> > Faced with an expression like:
> > 
> >  # Some comment \
> >  FOO = "bar"
> > 
> > what should bitbake do? Technically, the \ character means its multiline and
> > currently the code treats this as a continuation of the comment. This can
> > surprise some people and is not intuitive.
> > 
> > This patch makes bitbake simply error and asks the user to be clearer
> > about what they mean.
> 
> I have at least 2 bb files with '# foo \', but error message is not nice:

Agreed, I held off the patch due to this. It was due to a corner case
of:

# foo \

with an empty line following. I've improved the patch to cope with that
and give a sensible error message, then merged it to master. Thanks for
the report.

Cheers,

Richard



