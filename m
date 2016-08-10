Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D07BA6FF78
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 08:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7A8sJtp023960; Wed, 10 Aug 2016 09:54:19 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BVH3fehJTUVU; Wed, 10 Aug 2016 09:54:19 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7A8sFd8023956
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Aug 2016 09:54:17 +0100
Message-ID: <1470819255.8166.67.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>, Khem Raj <raj.khem@gmail.com>
Date: Wed, 10 Aug 2016 09:54:15 +0100
In-Reply-To: <20160809162629.GT4674@axis.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
	<5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
	<20160809093647.GP4674@axis.com>
	<917EB417-8D19-45C7-AE21-E11828557010@gmail.com>
	<20160809150902.GR4674@axis.com>
	<601FD807-0341-4764-AE68-0E3DA0BB0E11@gmail.com>
	<20160809162629.GT4674@axis.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Wed, 10 Aug 2016 08:54:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-08-09 at 18:26 +0200, Olof Johansson wrote:
> On 16-08-09 08:54 -0700, Khem Raj wrote:
> > I am sorry if its coming across this way.I for one was trying to
> > convey
> > that there are reasons to not have such a patch e.g. predictable
> > builds and general support problems with BB_NO_NETWORK.
> > 
> > We have been through this very same problem and decided to use
> > srcrev
> > collection approach which is similar to buildhistory collection
> > approach. It was a bit of getting used to, but in the end it was
> > a very good way.
> 
> Thanks for clarifying, this is a reasonable stance, and I can see
> where you are coming from. But I'm not advocating that this
> behavior should be forced upon anybody. What I'm trying to convey
> is that not all environments have issues with volatile tags, and
> from my pov, it's reasonably easy to fight people (within an
> organization) moving tags if you own the Git infrastructure =).

The trouble is that whilst you and others posting on this mailing list
understand this problem (in some cases now its been explained), in the
general case people don't realise that git tags can be rewritten.

If there is an "easy" option to make a failure go away, people will
take it every time, without understanding why it can be a bad idea.
People prefer not to think if they don't need to.

I've watched git tags get rewritten by upstreams who you'd have thought
would have known better, with all kinds of nasty fallout from the
result as few people understood what happened, why or how to fix it.
The usual "solution" is to blame bitbake or sstate, since they're
complex, people don't understand them and they're therefore clearly at
fault and broken.

So my position on this is based on experience of how badly you can get
burnt by it. I was very reluctant to make bitbake behave in the way it
does today originally but in the end various discussions brought me to
that conclusion.

What I'm trying to avoid in the fetcher is too many code paths. We
already have a lot of them, probably too many, and it makes maintaining
and enhancing the fetchers very very hard as you generally end up
trampling on some weird usecase someone relies upon. I therefore in
general don't like magic switches that drastically alter behaviour,
prefering to have one standard path we all use. Add to that the
concerns above and the idea of making this optional for people makes me
very nervous.

Having better descriptions of revisions is a semi-tangential issue.
There have been a few different approaches to using the output of git
describe or counting revisions and injecting it into PV. The
gitpkgv.bbclass was one similar idea and we did end up putting a method
into the fetcher to better enable this where the revision number was
based on numbers of commits in a branch. I'd be ok with extending or
supplementing that idea to work with git describe so that package
output revisions are human readable. I would however want the recipes
and fetcher to primarily work with the real sha revisions as those are
what define a specific revision in git.

Cheers,

Richard


