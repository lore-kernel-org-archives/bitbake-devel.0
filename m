Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id B5C766E4CC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 22:37:52 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0LMbkeS005332; Tue, 21 Jan 2014 22:37:46 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5Lux1C8B_Tl8; Tue, 21 Jan 2014 22:37:46 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0LMbdGX005269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Jan 2014 22:37:41 GMT
Message-ID: <1390343853.874.130.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Tue, 21 Jan 2014 22:37:33 +0000
In-Reply-To: <1388619481.11527.98.camel@ted>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
	<CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
	<1388619481.11527.98.camel@ted>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 21 Jan 2014 22:37:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-01-01 at 23:38 +0000, Richard Purdie wrote:
> Nothing changed in the data -S writes out. 
> 
> Yes, it does currently crash in some cases which is obviously a bug
> however assuming we fix that you can ignore what -S prints on the screen
> or writes to a file or whatever we end up doing and just do what you're
> doing now.
> 
> On the other hand we have a huge hole in the current model when you
> don't have the two environments to compare. You have the current build
> and you want to know why the cache isn't being used. That is a valid
> user question which shouldn't need another build to compare against.
> 
> So can we find the "least delta" fast? Its not actually that hard
> computationally or on resources, at least in the experiments I've made.
> We know the hashes of the current target's tasks and we can quickly tell
> which are in the cache and which are not (using the same function sstate
> uses for that purpose).
> 
> That gives you a set of delta points with the sstate cache but you also
> know the recipe name and other details about the target of interest and
> that they should have common parent tasks. Based on that information you
> can come up with a list of possibilities of least difference and sort
> those by date (which bitbake-diffsigs -t uses) or whatever other
> mechanism we end up choosing to display the data.
> 
> I agree its not always going to give useful information but its a start
> in the right direction and my local tests suggest its perhaps good
> enough to give the user the hints they want about cache reuse (or lack
> of).
> 
> I agree we're not there yet, equally, to be quite honest the current
> debug of sstate sucks and we need to do something about it. Whilst you
> and I may understand it and are able to debug issues, many users are
> struggling with it :(.

I appreciate its taken me a while to loop back around on this but I do
now have an idea. What I'm proposing we do is add an optional parameter
to -S. Without any parameter it would behave as it did classically.

With a parameter, it could trigger the current "debug sstate" behaviour
to stdout and it also allows it to trigger an sstate siggen specific
behaviour as appripriate. I have some prototype code with writes out a
"locked-sigs.inc" file for example, triggered from this same code block.

I think this should let us do more creative things with sstate (even
from the OE siggen class) yet also let it remain useful for different
people.

I don't have any code to do this yet but at least we have a plan
assuming no strong objections.

Cheers,

Richard



