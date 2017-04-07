Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7DD8477D83
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491558533; x=1523094533;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=yZlBJeQLR6P/dKg5mg+HQz0zXTbjL6K5fejbBI8NuIs=;
	b=ZOordYZrHIiJMnnmHgs6WWwoHijJy38uw7dSW4YJfKNzcXYOvW1DYHa9
	ba9uKK3wXfR9WwdTy5eoy17tf+GO0A==;
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Apr 2017 02:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,164,1488873600"; d="scan'208";a="245777702"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.179])
	by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2017 02:48:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Date: Fri, 07 Apr 2017 21:48:45 +1200
Message-ID: <2242713.2CccdMob4L@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <1491555278.10884.71.camel@intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
	<51436031.kQGnlfrvNB@peggleto-mobl.ger.corp.intel.com>
	<1491555278.10884.71.camel@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/11] bitbake-diffsigs fixes/improvements
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
X-List-Received-Date: Fri, 07 Apr 2017 09:48:51 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 7 April 2017 8:54:38 PM NZST Patrick Ohly wrote:
> On Fri, 2017-04-07 at 20:32 +1200, Paul Eggleton wrote:
> > On Friday, 7 April 2017 8:29:18 PM NZST Paul Eggleton wrote:
> > > On Friday, 7 April 2017 7:56:19 PM NZST Patrick Ohly wrote:
> > > > Am I using the tool incorrectly or are my expectations wrong?
> > > > 
> > > > My expectation was that "bitbake-diffsigs -t m4 do_build" would tell
> > > > me
> > > > that m4 was rebuilt because some tasks that it depends on changed, and
> > > > then I would drill down to those tasks, eventually arriving at
> > > > do_install.
> > > 
> > > Hmm, something has gone wrong here because this is the exact scenario
> > > it's
> > > supposed to handle. In my similar tests it did work, so I'm not sure why
> > > it
> > > didn't work in this case - I'll have to give it a try here.
> > 
> > I send and then I immediately realised what might be wrong - you said
> > you're using poky master which implies that you haven't also applied the
> > patches for lib/oe/sstatesig.py that I sent to the OE-Core list today. If
> > you haven't, try doing that, it should fix the problem.
> 
> Indeed, I had missed that part. It's working now for do_install.
> 
> What about do_build? Should bitbake-diffsigs be usable with that?

If it changed (i.e. there are two signature files to compare) then yes, -t 
should be able to work back from those. For some reason though you don't seem 
to have sigdata files for do_build, which is odd - a quick look in my stamps 
directory here suggests that you should.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

