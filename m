Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TBmGe-00039D-7a
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Sep 2012 14:42:08 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Sep 2012 05:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,408,1344236400"; d="scan'208";a="221022578"
Received: from unknown (HELO helios.localnet) ([10.252.121.198])
	by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2012 05:29:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Chris Larson <clarson@kergoth.com>
Date: Wed, 12 Sep 2012 13:29:32 +0100
Message-ID: <1987076.DYWImTfRFL@helios>
Organization: Intel Corporation
User-Agent: KMail/4.9 (Linux/3.2.0-30-generic-pae; KDE/4.9.0; i686; ; )
In-Reply-To: <CABcZAN=_7d0ovDP6nHBTYCWbrs+QGF8bcinsNSrzQLSe3w14Aw@mail.gmail.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
	<2b9acb9c7fca686d4df885152458cae2e22f2cc5.1347382193.git.paul.eggleton@linux.intel.com>
	<CABcZAN=_7d0ovDP6nHBTYCWbrs+QGF8bcinsNSrzQLSe3w14Aw@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/3] lib/bb/command.py: ensure setVariable only sets values as strings
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
X-List-Received-Date: Wed, 12 Sep 2012 12:42:08 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 11 September 2012 15:57:24 Chris Larson wrote:
> On Tue, Sep 11, 2012 at 9:52 AM, Paul Eggleton
> <paul.eggleton@linux.intel.com> wrote:
> > This is the interface Hob uses to set variable values in many instances,
> > and at the moment it is possible that some of the values it passes are
> > not strings. If a non-string value gets into the datastore it can
> > trigger exceptions during parsing when we attempt to expand the variable
> > and substitute in the non-string value.
> > 
> > This fixes using the meta-ti layer within Hob - it currently has a
> > reference to BB_NUMBER_THREADS within a shell function and since this
> > is a variable that Hob was setting from its configuration as an integer,
> > due to the above this was triggering an ExpansionError.
> 
> This is probably a good change, but I think that failing expansion due
> to a non-string value is a bad behavior in bitbake. I think it should
> call str() on it as appropriate, as that's the most idiomatic
> solution: Don't check if something is a string, don't require only
> strings, but call str() to get your string

Hmm, I suppose so; I do still worry about existing python code assuming the 
result of getVar() is either None or a string though. Richard tells me that we 
have some non-string values mostly internal to BitBake that are considered 
legal, so that obviously isn't always 100% true, but it's a fair assumption to 
have made for most situations.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


