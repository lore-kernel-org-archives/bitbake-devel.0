Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Sz2VC-0002RT-4M
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Aug 2012 11:24:30 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Aug 2012 02:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,732,1336374000"; d="scan'208";a="204873385"
Received: from unknown (HELO helios.localnet) ([10.252.121.56])
	by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2012 02:12:41 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 08 Aug 2012 10:12:40 +0100
Message-ID: <3338596.LFW82p3Yzv@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-27-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <5021DF9E.3090709@windriver.com>
References: <cover.1344346253.git.liezhi.yang@windriver.com>
	<1344373262.9756.300.camel@ted> <5021DF9E.3090709@windriver.com>
MIME-Version: 1.0
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
X-List-Received-Date: Wed, 08 Aug 2012 09:24:30 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 08 August 2012 11:40:14 Robert Yang wrote:
> On 08/08/2012 05:01 AM, Richard Purdie wrote:
> > On Tue, 2012-08-07 at 18:12 +0100, Paul Eggleton wrote:
> >> A couple of other things:
> >> 
> >> 1) We ought to be able to assume that TMPDIR is the same regardless of
> >> the recipe specified; this avoids having to parse all of the recipes just
> >> to get the value of this variable.
> 
> I'm sorry, I don't understand what did you mean here. it seems that what
> I did is the same as you said: Use "bitbake -e" to figure out the TMPDIR at
> the beginning, then use it elsewhere.

Sorry, I wasn't being very clear. If you specify the recipe with bitbake -e, 
bitbake has to go through a parse of the recipes (retrieving from the cache if 
available of course, but even that still takes a few seconds). I'm suggesting 
you don't specify the recipe as TMPDIR shouldn't be recipe-specific, and save 
quite a bit of time.

> >> 2) I'm a little concerned with the general approach - is there no way of
> >> avoiding having to copy and move around the stamps directory? It seems
> >> a little risky if nothing else.
> > 
> > I think adding a parameter to -S would be a good move for this, its
> > something people likely want in conjunction with that.
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

I have to admit I'm not sure what -S is currently being used for; so it's hard 
for me to comment on what might get broken if we change this. I suspect it's 
not being used very much at all though.
 
> 2) Use "TMPDIR(or STAMP)=<path> bitbake -S recipe", but we don't support it
>     currently, but we can add an os.getenv("TMPDIR") in bitbake to achieve
> it, the BB_TMPDIR or BB_STAMP would be better, but I'm not sure whether it
> will cause other problems.
> 
> I'd like to send a patch for 2) if you are OK with it.

We already have a mechanism to allow through variables from the environment - 
BB_ENV_WHITELIST / BB_ENV_EXTRAWHITE, and we should make use of that in 
preference to os.getenv(). I think we would not want this change in stamp 
writing behaviour to take effect unless -S is being used though, which suggests 
it ought to be a new variable that is not checked unless -S has been specified.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


