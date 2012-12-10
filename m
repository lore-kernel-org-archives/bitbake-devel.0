Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ti7dr-0005tu-QP; Mon, 10 Dec 2012 18:59:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBAHjF1g004324;
	Mon, 10 Dec 2012 17:45:15 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02751-07; Mon, 10 Dec 2012 17:45:10 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBAHj50B004313
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Dec 2012 17:45:06 GMT
Message-ID: <1355161495.28775.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Mon, 10 Dec 2012 17:44:55 +0000
In-Reply-To: <CABcZANkOXMWf-v=6uEMgcGhnQZrgfOTDgjtJwarM9NRzGUupug@mail.gmail.com>
References: <1355155747.29967.31.camel@ted>
	<CABcZANkOXMWf-v=6uEMgcGhnQZrgfOTDgjtJwarM9NRzGUupug@mail.gmail.com>
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
X-List-Received-Date: Mon, 10 Dec 2012 17:59:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-12-10 at 10:29 -0700, Chris Larson wrote:
> On Mon, Dec 10, 2012 at 9:09 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         After Enrico's reported problem, I've been poking around the
>         EXPORT_FUNCTIONS code. Currently OE-Core metadata generates
>         list A
>         below. In particular, this leads to code like:
>         
>          do_configure calls gnomebase_do_configure
>          gnomebase_do_configure calls autotools_do_configure
>         
>         which has a level of indirection. The gnomebase class never
>         references
>         do_configure. I can appreciate adding in a default mapping of:
>         
>          do_configure calls autotools_do_configure
>         
>         since it allows a user to call into autotools_do_configure
>         from a custom
>         do_configure but I can't see the value of the intermediary
>         gnomebase_do_configure. Does anyone know of a use for it?
>         
>         I have a suspicion that if it ever did do anything useful, it
>         stopped
>         being useful long ago.
>         
>         I'm therefore strongly tempted to remove the intermediaries
>         from the
>         code. This would result in list B below which is a more direct
>         set of
>         mappings.
>         
>         Any thoughts/comments from anyone?
>
> In theory, I could see a situation where one class inherits another,
> rather than just individual components all inherited by the recipe.
>
> E.g. in class alpha:
>
> inherit beta
>
> alpha_do_stuff () {
>    pre_stuff
>    beta_do_stuff
>    post_stuff
> }
>
> But this is a theoretical case, and often we hack around things via
> _prepend/_append rather than doing things like this, so I doubt this
> is actually done anywhere in practice.

With an "EXPORT_FUNCTIONS = do_stuff" in alpha.bbclass, wouldn't that
still work without the intermediaries though?

Cheers,

Richard






