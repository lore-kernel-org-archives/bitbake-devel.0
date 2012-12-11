Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TiDgQ-0005yq-A9; Tue, 11 Dec 2012 01:26:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBB0CHJ7006830;
	Tue, 11 Dec 2012 00:12:17 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04801-10; Tue, 11 Dec 2012 00:12:13 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBB0CAgW006824
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2012 00:12:11 GMT
Message-ID: <1355184730.6771.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Tue, 11 Dec 2012 00:12:10 +0000
In-Reply-To: <CABcZANnVEBGUFLNKgD4RQFdUsfKXapT65+9L5crBJ4F9No1Spw@mail.gmail.com>
References: <1355155747.29967.31.camel@ted>
	<CABcZANkOXMWf-v=6uEMgcGhnQZrgfOTDgjtJwarM9NRzGUupug@mail.gmail.com>
	<1355161495.28775.1.camel@ted>
	<CABcZANnVEBGUFLNKgD4RQFdUsfKXapT65+9L5crBJ4F9No1Spw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: EXPORT_FUNCTIONS - change in behaviour proposal
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
X-List-Received-Date: Tue, 11 Dec 2012 00:26:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-12-10 at 12:41 -0700, Chris Larson wrote:
> On Mon, Dec 10, 2012 at 10:44 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         > E.g. in class alpha:
>         >
>         > inherit beta
>         >
>         > alpha_do_stuff () {
>         >    pre_stuff
>         >    beta_do_stuff
>         >    post_stuff
>         > }
>         >
>         > But this is a theoretical case, and often we hack around
>         things via
>         > _prepend/_append rather than doing things like this, so I
>         doubt this
>         > is actually done anywhere in practice.
>         
>         
>         With an "EXPORT_FUNCTIONS = do_stuff" in alpha.bbclass,
>         wouldn't that
>         still work without the intermediaries though?
> 
> Hmm, yes, good point. Perhaps it was to allow the user to override an
> intermediate function that might or might not exist?
>
> E.g. in the do_configure calls gnomebase_do_configure calls
> autotools_do_configure case, the user could override
> gnomebase_do_configure, without having to know whether or not
> gnomebase actually defines a configure function?
>
> I'm guessing here, but that *could* be why it was implemented this
> way. In practice, however, we have to know what our classes are doing
> anyway, most of the time, for a wide variety of reasons. E.g. uses of
> overrides have to be operated against carefully to avoid your changes
> being blown away.

Could well be this was the reason. I think the exact class the current
code will pick for any intermediary is determined by parse order and I
can't find any case we actually use this property. As you say, I can't
see it being that useful in practise.

I've proposed a bitbake patch which removes the intermediary and
simplifies things a bit.

Cheers,

Richard




