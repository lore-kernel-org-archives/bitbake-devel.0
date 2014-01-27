Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 3BE206C765
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 13:23:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0RDMn1n031257; Mon, 27 Jan 2014 13:23:36 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZhBG2NFF1zMs; Mon, 27 Jan 2014 13:23:35 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0RDNU6W031265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Jan 2014 13:23:32 GMT
Message-ID: <1390829005.17424.238.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Mon, 27 Jan 2014 13:23:25 +0000
In-Reply-To: <1390343853.874.130.camel@ted>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
	<CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
	<1388619481.11527.98.camel@ted> <1390343853.874.130.camel@ted>
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
X-List-Received-Date: Mon, 27 Jan 2014 13:23:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-01-21 at 22:37 +0000, Richard Purdie wrote:
> I appreciate its taken me a while to loop back around on this but I do
> now have an idea. What I'm proposing we do is add an optional parameter
> to -S. Without any parameter it would behave as it did classically.
> 
> With a parameter, it could trigger the current "debug sstate" behaviour
> to stdout and it also allows it to trigger an sstate siggen specific
> behaviour as appripriate. I have some prototype code with writes out a
> "locked-sigs.inc" file for example, triggered from this same code block.
> 
> I think this should let us do more creative things with sstate (even
> from the OE siggen class) yet also let it remain useful for different
> people.

So we have a small potential issue here. We use python's optparse which
doesn't allow optional arguments. This means we can make -S take options
but the options must always be specified.

It has good reason for this as its near impossible for optparse to tell
the difference between:

bitbake image -S tracesigs
and
bitbake image -S image2

So our options are:

a) Require a new parameter to -S always
b) Hack it to use the option after -S as a parameter (meaning -S should
always be last on the commandline). I do have a proof of concept but it
makes me uneasy
c) Add a new option with a different name

In the interests of not doing something which binds us into a problem in
future, I'm thinking -S should start to always take a parameter. The
only issue is I'd like that parameter to be metadata (siggen) definable
so we can't validate the option passed.

Any opinions?

Cheers,

Richard


