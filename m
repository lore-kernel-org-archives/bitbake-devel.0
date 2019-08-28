Return-Path: <andrew@aj.id.au>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
	[64.147.123.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6FE727F0FB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2019 14:38:04 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 32AB2598;
	Wed, 28 Aug 2019 10:38:05 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
	by compute4.internal (MEProxy); Wed, 28 Aug 2019 10:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
	mime-version:message-id:in-reply-to:references:date:from:to:cc
	:subject:content-type; s=fm3; bh=FqhKLOumLYx8elEGe8+3tYyr8R/KRaV
	jwgNl3UE8LNQ=; b=OOYIIIqg1E7v+4//EfY0ZlVk5rBhenEchQtmnC5ALbkhrN5
	S6paV3a/3/x43k10rlnr3IdLpZsrV/zdtDuZlBSyHO7FKAaXkl3o35utYxpQdw1Z
	uxGg8RA8ntPO7Lphi3zAl9dY3f5jVnZcAXqn1FMSBgf2D68v+sHxfzu495GXxwhR
	l73DHnPPNDWWKWcyGuo3RiIn4+hfkVPCdRIKulAJ06Z/bjpFGFx6lNP8VrONVjhY
	a8VmJxSIMIY9B8/vrsxM9CW+a87J8Eoj16AnhWfey7RiQISzjSqtzoKvxzdIK8Nm
	HJ5HoA81Qorw/g7wvD4Hyx77ChhvVabOUSdx01w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FqhKLO
	umLYx8elEGe8+3tYyr8R/KRaVjwgNl3UE8LNQ=; b=1hk9dx0r5uY2gkzZyJRk4k
	1V4Ipu55TucpVkPl/alxctPlfA3p61z/5ZRuor74cyXiBflhb3O5SHbdxqEQmnrm
	AbXF8++LWjxhZkPg0JsnWIrW0dc8ULfoSgQVaOMCzZfxQXDynkgDOJNjkC5SCYOv
	0Ulh0xD38asIybLMfyBL3qujVXGiytOnawOyBwEqJ91MRZGChwXbO57FTAqVs7/2
	VbalH/auEBIJWdT5WGHeVHUxH7kw/xq5tsehXclXs1Ji/MGxnqlb/iGHZsQdWt3L
	zBq+6pwstkL1749O1nbzOpghg2NZe8XSHeU+LlPnCRBtLoEUFAwOv0CQnms1TdTg
	==
X-ME-Sender: <xms:zJFmXfgJcMjFrEi7q76Ba42-sGmYMwJJudpJaVoZhb2jddY840KT8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeitddgjeelucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
	cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
	rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
	grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
	rhfuihiivgeptd
X-ME-Proxy: <xmx:zJFmXdQqo7x7J5FGoRVf3bk2ZGltnCFpiUWwy7rfHGJXMInu7w1yXA>
	<xmx:zJFmXXi4K8BPcxZ_JF7gCPqbkrJq59q9WvF-qZtBdReUTsPTgDix1A>
	<xmx:zJFmXSdsaovuGMf3Ut6_8ynnb3nRh0Qnm68SfGyukA5dw3HZm1WdCw>
	<xmx:zJFmXWjUgQnqpocfo-CSLf4nsnoTkMhQzydt52A_BV3cqBhV2jec6Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 46122E00A2; Wed, 28 Aug 2019 10:38:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-139-g73fcb67-fmstable-20190826v1
Mime-Version: 1.0
Message-Id: <2e4b0f4a-8288-490a-8bc2-7d49f460487e@www.fastmail.com>
In-Reply-To: <a0279d01-3d06-3648-f63c-9392be141397@windriver.com>
References: <20190827000358.25777-1-andrew@aj.id.au>
	<a0279d01-3d06-3648-f63c-9392be141397@windriver.com>
Date: Thu, 29 Aug 2019 00:08:25 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Mark Hatle" <mark.hatle@windriver.com>,
	bitbake-devel@lists.openembedded.org
Cc: Brad Bishop <bradleyb@fuzziesquirrel.com>, ojayanth@in.ibm.com
Subject: Re: [RESEND RFC PATCH] gitsm: Control submodule recursion
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
X-List-Received-Date: Wed, 28 Aug 2019 14:38:04 -0000
Content-Type: text/plain

Hi Mark,

On Wed, 28 Aug 2019, at 23:30, Mark Hatle wrote:
> On 8/26/19 7:03 PM, Andrew Jeffery wrote:
> > There exist some use-cases where repositories related by submodules do
> > not require submodules be recursively initialised despite needing the
> > first layer of submodules to be fetched. Enable this usecase in gitsm by
> > implementing a `recurse=X` SRC_URI parameter. The current implementation
> > of the recurse parameter defaults to enabling exhaustive recursion to
> > match the current behaviour of gitsm, with the one alternative being no
> > recursion. Enough rope is provided to allow specific recursion depths to
> > be implemented if necessary via the same interface. Values currently
> > unsupported for the recurse parameter raise a ValueError to ensure
> > forward compatibility.
> 
> I was thinking about this patch and I'm not sure it's needed.  There are ways to
> do this without using gitsm.
> 
> If you don't want recursion, then why are you specifying 'gitsm' at all? 

As far as I'm aware the git fetcher doesn't handle submodules at all. If I
have a misunderstanding there and this patch is unnecessary then that's
excellent, because I hate it :D

> The
> 'git' fetcher won't recurse and can be used to pull down a subset of what would
> have been a recursive fetch.  The 'subpath' parameter can even be used to
> combine the items in the same way as the gitsm fetcher if really needed.

Can you expand a bit more on how I'd do this (examples?), or point me in
the right direction with documentation? There don't appear to be any
pointers in the git:// fetcher section of the mega manual.

Just for clarity, the repository structure this patch is trying to cater for
looks like:

      +---->C
      |
      +---->D
      +
A+--->B+--->E
      +
      +---->F
      |
      +---->G

We have a recipe for A, whose repository has a submodule B, and B has
several submodules C, D, E, F, G. Repositories C-G are large and actually
irrelevant for the purpose of what we're doing in A, but the content of B
is required for A to build.

I hate the patch because the scenario seems like such a corner-case,
but here we are with a real-world use-case.

> 
> (A few more comments below, as more of a technical review)
> 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  lib/bb/fetch2/gitsm.py | 34 ++++++++++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > index c622771d21aa..5a8426b486e3 100644
> > --- a/lib/bb/fetch2/gitsm.py
> > +++ b/lib/bb/fetch2/gitsm.py
> > @@ -6,7 +6,15 @@ after cloning.
> >  
> >  SRC_URI = "gitsm://<see Git fetcher for syntax>"
> >  
> > -See the Git fetcher, git://, for usage documentation.
> > +Supported SRC_URI options are:
> > +
> > +- recurse
> > +    Control recursive nature of submodule initialisation.
> > +
> > +    The default value is -1, which will recursively initialise all submodules.
> > +    Set to 0 to disable recursiion.
> > +
> > +See the Git fetcher, git://, for further usage documentation.
> >  
> >  NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your recipe.
> >  
> > @@ -26,6 +34,15 @@ from   bb.fetch2 import logger
> >  from   bb.fetch2 import Fetch
> >  from   bb.fetch2 import BBFetchException
> >  
> > +def should_recurse(ud):
> > +    recurse = ud.parm.get("recurse", "-1")
> > +
> > +    # Change this condition if we end up supporting specific maximum depths
> > +    if recurse in ( "-1", "0" ):
> > +        return recurse == "-1"
> > +
> > +    raise ValueError("Recursion control value not supported: %s" % (recurse))
> > +
> >  class GitSM(Git):
> >      def supports(self, ud, d):
> >          """
> > @@ -95,25 +112,28 @@ class GitSM(Git):
> >          for module in submodules:
> >              # Translate the module url into a SRC_URI
> >  
> > +            recurse = should_recurse(ud)
> >              if "://" in uris[module]:
> >                  # Properly formated URL already
> >                  proto = uris[module].split(':', 1)[0]
> > -                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
> > +                desired = "gitsm:" if recurse else "git:"
> > +                url = uris[module].replace('%s:' % proto, desired, 1)
> 
> Above 'desired' is used, below 'scheme' is used.  You should use the same
> variable for both, and set it before the first 'if'.  To me 'scheme' is a better
> variable.

Yep, will address this if we go forward with the approach.

Thanks for the feedback!

Andrew

