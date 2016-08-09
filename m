Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id DC1D3771A3
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 09:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 6364B18396;
	Tue,  9 Aug 2016 11:36:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id yAEif6qHCslS; Tue,  9 Aug 2016 11:36:43 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 9C6B418194;
	Tue,  9 Aug 2016 11:36:43 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 868B61C30;
	Tue,  9 Aug 2016 11:36:43 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 7B6441778;
	Tue,  9 Aug 2016 11:36:43 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by seth.se.axis.com (Postfix) with ESMTP id 79BBD466;
	Tue,  9 Aug 2016 11:36:43 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 1F0A99C09F; Tue,  9 Aug 2016 11:36:48 +0200 (CEST)
Date: Tue, 9 Aug 2016 11:36:48 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Khem Raj <raj.khem@gmail.com>, bitbake-devel@lists.openembedded.org
Message-ID: <20160809093647.GP4674@axis.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
	<5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
X-List-Received-Date: Tue, 09 Aug 2016 09:36:45 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 16-08-08 10:22 -0700, Khem Raj wrote:
> you are confusing how a tool is specifying its functions with
> process that could emulate a different behavior. OE does not
> have any control over the internal processes of its users and
> it should not have.

No, I don't think I'm confusing anything. Are you confusing OE
and bitbake? We maintain and develop an in-house Poky based
distribution, and unlike OE, we know a lot about our
users/developers.

> > Tags are only a problem in git if people insist on
> > modifying/deleting them.
> 
> Fact is, its allowed rewrite tags in git, how people use it or not
> is irrelevant here.

Nope, Git is a protocol; git the tool can't do nothing about a
server refusing to (re)move a tag. Your view of what a git tags
is yours. Tags are meant to be static, otherwise they wouldn't
have been synced to all clones in such a silly namespace.

While I agreed with Tobias' patch ("if you use tags in your
builds, and use BB_NO_NETWORK, you are ok with falling back to
what you have locally"), RP had a point about this making
BB_NO_NETWORK have non-obvious side-effects, and also making it
harder to catch cases where tags aren't wanted (like in community
maintained layers).

But *we* still want to use human readable tags as the only
version string internally (for our layers), where we know we are
in control. So, introducing a variable that lets us opt-in to
this behavior sounds like something that could be accepted?

-- 
olofjn

