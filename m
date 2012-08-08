Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sz2eJ-0002bP-Ps for bitbake-devel@lists.openembedded.org;
	Wed, 08 Aug 2012 11:33:55 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q789M7Jt021065;
	Wed, 8 Aug 2012 10:22:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19671-08; Wed,  8 Aug 2012 10:22:03 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q789LvDL021059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Aug 2012 10:21:58 +0100
Message-ID: <1344417719.9756.324.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 08 Aug 2012 10:21:59 +0100
In-Reply-To: <5021DF9E.3090709@windriver.com>
References: <cover.1344346253.git.liezhi.yang@windriver.com>
	<16599840.OqlgMUDr4l@helios> <1344373262.9756.300.camel@ted>
	<5021DF9E.3090709@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1] bitbake-whatchanged: print what is about to happen
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
X-List-Received-Date: Wed, 08 Aug 2012 09:33:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-08-08 at 11:40 +0800, Robert Yang wrote:
> >> 2) I'm a little concerned with the general approach - is there no way of
> >> avoiding having to copy and move around the stamps directory? It seems
> >> a little risky if nothing else.
> >
> > I think adding a parameter to -S would be a good move for this, its
> > something people likely want in conjunction with that.
> >
> 
> Yes, add a parameter to "bitbake -S recipe" would be the correct way, but
> as far as I know, the "-S" is a bool option currently, it doesn't accept
> an argument, I think that we have the following 2 solutions:
> 
> 1) Modify the "-S" to accept an argument, but this may break the the usage
>     of the "bitbake -S", the currently usage is:
> 
>     bitbake -S <recipe>
> 
>     We may change it to:
> 
>     bitbake -S <tmpdir>(or stampsdir) <recipe>
> 
>     But it seems that it's not easy differentiate the argument behind "-S".

Hmm, we probably could change this option as long as we update the
manuals too. Ideally I would like some way to say "use the default
stamps directory" without having to put a full path in.

> 2) Use "TMPDIR(or STAMP)=<path> bitbake -S recipe", but we don't support it
>     currently, but we can add an os.getenv("TMPDIR") in bitbake to achieve it,
>     the BB_TMPDIR or BB_STAMP would be better, but I'm not sure whether it will
>     cause other problems.
> 
> I'd like to send a patch for 2) if you are OK with it.

Please don't use TMPDIR, bitbake has no knowledge of that variable, nor
should it have and it will change the cache directory. I'd suggest using
STAMP, that is what the variable is designed for. We just need to allow
it from the environment which Paul mentions and this is what I
originally proposed.

I'm leaning towards 2) and STAMP with BB_ENV_WHITELIST (or whatever the
variable is called) updated accordingly.

Cheers,

Richard



