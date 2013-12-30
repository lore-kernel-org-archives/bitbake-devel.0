Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5FE4F60D67
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 22:10:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBUMAdZf023648; Mon, 30 Dec 2013 22:10:39 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iZpP-HuZT3sX; Mon, 30 Dec 2013 22:10:39 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBUMAYnx023639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Dec 2013 22:10:36 GMT
Message-ID: <1388441430.11527.80.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 30 Dec 2013 22:10:30 +0000
In-Reply-To: <20131230163534.GB3719@jama>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 30 Dec 2013 22:10:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2013-12-30 at 17:35 +0100, Martin Jansa wrote:
> On Mon, Dec 30, 2013 at 09:29:38AM -0700, Chris Larson wrote:
> > On Mon, Dec 30, 2013 at 9:18 AM, Chris Larson <clarson@kergoth.com> wrote:
> > 
> > > On Sat, Dec 28, 2013 at 6:24 AM, Martin Jansa <martin.jansa@gmail.com>wrote:
> > >
> > >> On Wed, Dec 18, 2013 at 04:21:27PM +0000, Richard Purdie wrote:
> > >> > Its useful to understand where the delta starts against an existing
> > >> sstate cache
> > >> > for a given target. Adding this to the output of the -S option seems
> > >> like a
> > >> > natural fit.
> > >> >
> > >> > We use the hashvalidate function to figure this out and assume it can
> > >> find siginfo
> > >> > files for more than just the setscene tasks.
> > >>
> > >> I haven't tried to find smaller reproducer or exact part of code where
> > >> it happends, but in bigger builds I have it fails with
> > >>
> > >> I'll try to reproduce and narrow it a bit, but if you have tip where
> > >> to look first..
> > >>
> > >> IndexError: list index out of range:
> > >
> > >
> > > I’m hitting this now as well.
> > 
> > 
> > To clarify further, I’m hitting this with stock poky master, qemux86,
> > bitbake -S core-image-base.
> > 
> > Actually, this is getting in my way trying to do something I don’t want it
> > doing anyway. I want to dump the signature data from one config, and use
> > bitbake-whatchanged from another build. If I wanted to compare something
> > right here, I’d have run bitbake-whatchanged. This change confuses me a
> > bit. -S emits signature data, according to the bitbake help and the
> > semantics of the command. Are we trying to kill bitbake-whatchanged in
> > favor of making -S do both jobs, emit and compare?
> 
> Same here, I'm using bitbake -S from
> oe-core/scripts/sstate-diff-machines.sh
> 
> and this added analysis and output is IMHO very useful, but it would be
> nice to control it with some new option (and keep default -S behavior
> fast and simple).
> 
> It looks like the error is triggered for every task which wasn't built
> before (e.g. running bitbake -S with empty sstate-cache/tmp-eglibc or
> bitbake -S world after bitbake some-image).
> 
> I see it for many do_fetch and do_rm_work_all tasks.

To put things in context, I was trying to work with the existing
"whatchanged" type tools or more specifically I wanted to know "why
isn't my sstate cache being used". Having to do a two step process for
any of these enquires seems a little odd. There are also two specific
and as it turns our quite different work flows:

a) What changed since my last build?
b) What is the least delta between my current build and whatever I have
cached?

Those experiments revealed some big holes in the sstate metadata and
some good improvements there. It also highlights that there are two
different questions which have different answers.

In the process, I found bitbake does have some state in runqueue which
can help pinpoint the "whatchanged" part of the problem much more
accurately/quickly. Obviously that state is lost after bitbake -S
finishes so I started printing out some extra data.

Clearly bitbake shouldn't crash, that is a bug and I think Martin is
heading in the right direction with the other patch.

As for bitbake -S being kept fast, I think (but I need to double check
with measurements) that the parsing part of bitbake -S is the slow part
and this extra data is effectively "for free".

So basically consider the current state an experiment to see if we can
make -S more useful/interesting (without much cost) and to try to better
understand where/what functionality we need going forward.

One possible outcome might be we generate an extra file (or files) (like
we do with task-depends.dot) which contains this extra tree data which
some other command can then parse and display to the user. I'm still
struggling to get a complete grip on the exact data and format that file
needs to be. Part of the reason for having -S print something was to see
if it printed what the user wanted to know or if not, we could then try
and figure out what the right thing was so we could improve it.

So sorry if this is causing pain, the code is easy to disable by
commenting out the call, or reverting the patch adding it. Equally, I
think we need to make sstate hashes and reasons for rebuilds more
accessible to users and I think this does move us closer to that
assuming we fix the crash.

I'm trying to take a bit of a break over the holiday period (been riding
a motorcycle in driving snow/rain today and am rather damp/cold) but
I'll get the crash fixed sometime next week at the latest.

Cheers,

Richard


