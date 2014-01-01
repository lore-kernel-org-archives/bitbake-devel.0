Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9B3746B6BC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jan 2014 23:38:15 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s01Nc8WC004065; Wed, 1 Jan 2014 23:38:08 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GrZ-YjkhTzuH; Wed,  1 Jan 2014 23:38:07 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s01Nc4aD004057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Jan 2014 23:38:06 GMT
Message-ID: <1388619481.11527.98.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Wed, 01 Jan 2014 23:38:01 +0000
In-Reply-To: <CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
	<CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
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
X-List-Received-Date: Wed, 01 Jan 2014 23:38:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-12-30 at 15:34 -0700, Chris Larson wrote:
> I can see that, but I think you're making the semantics of the
> command-line argument confusing by trying to combine the two
> operations into one. I also think that trying to find the "least
> delta" is extremely weird, and not always likely to produce anything
> worthwhile. My SSTATE_DIR has weeks if not months of output from
> hundreds of builds of different combinations of machine, distro, layer
> selection, upstream vs mel, as well as between tons of build
> environments with slight local alterations. Unless I'm
> misunderstanding something, how exactly is it going to know what I
> want it to compare against, and how it is going to keep finding the
> "least delta" fast, amongst all that data? With the current tools, I
> can explicitly use -S in one env and whatchanged in another (with
> appropriate STAMPS_DIR) to compare between two exact build
> environments, rather than letting bitbake try to automagically find
> what I meant. Now that the two are combined into one, I'm not seeing
> how to do what I'm currently doing. Can you explain this?

Nothing changed in the data -S writes out. 

Yes, it does currently crash in some cases which is obviously a bug
however assuming we fix that you can ignore what -S prints on the screen
or writes to a file or whatever we end up doing and just do what you're
doing now.

On the other hand we have a huge hole in the current model when you
don't have the two environments to compare. You have the current build
and you want to know why the cache isn't being used. That is a valid
user question which shouldn't need another build to compare against.

So can we find the "least delta" fast? Its not actually that hard
computationally or on resources, at least in the experiments I've made.
We know the hashes of the current target's tasks and we can quickly tell
which are in the cache and which are not (using the same function sstate
uses for that purpose).

That gives you a set of delta points with the sstate cache but you also
know the recipe name and other details about the target of interest and
that they should have common parent tasks. Based on that information you
can come up with a list of possibilities of least difference and sort
those by date (which bitbake-diffsigs -t uses) or whatever other
mechanism we end up choosing to display the data.

I agree its not always going to give useful information but its a start
in the right direction and my local tests suggest its perhaps good
enough to give the user the hints they want about cache reuse (or lack
of).

I agree we're not there yet, equally, to be quite honest the current
debug of sstate sucks and we need to do something about it. Whilst you
and I may understand it and are able to debug issues, many users are
struggling with it :(.

Cheers,

Richard





