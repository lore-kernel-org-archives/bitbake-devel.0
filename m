Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 30214606BF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jul 2016 20:53:36 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 27 Jul 2016 13:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,431,1464678000"; d="scan'208";a="1030358697"
Received: from ndrai-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.178.75])
	by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2016 13:53:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 28 Jul 2016 08:53:33 +1200
Message-ID: <11574390.7kjj5FOXUz@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.6.4-201.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <1469516922.23580.92.camel@linuxfoundation.org>
References: <cover.1469504165.git.paul.eggleton@linux.intel.com>
	<c6d59200973e19d358a2fa1a1e5bec4523894e69.1469504165.git.paul.eggleton@linux.intel.com>
	<1469516922.23580.92.camel@linuxfoundation.org>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] lib/bb/checksum: avoid exception on broken symlinks
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
X-List-Received-Date: Wed, 27 Jul 2016 20:53:38 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tue, 26 Jul 2016 08:08:42 Richard Purdie wrote:
> On Tue, 2016-07-26 at 15:36 +1200, Paul Eggleton wrote:
> > If using OE's externalsrc with a source tree that is not tracked by
> > git and contains broken symlinks, you can receive "TypeError: unorderable
> > 
> > types: NoneType() < str()" within the file checksum code due to:
> >  checksums.sort(key=operator.itemgetter(1))
> > 
> > Don't add files with no checksum to the checksums list in order to
> > avoid this.
> 
> In some of the cache code we have to note whether files were checked
> for but didn't exist. This means that if they then do exist in a later
> run, we know to invalidate the cache.
> 
> Does this change break that?

Took me a couple of days to get back to this, but after double-checking both 
the code and the behaviour the answer is no. As you may recall the file 
checksum operation is broken into two parts:

1) Getting the list of files regardless of whether they exist or not, which is 
done at parse time and goes into the cache

2) Actually getting the checksum of each file that does exist, which is done 
when we calculate the task hashes. The hashes are also cached in their own 
separate cache file based on mtime.

#1 is where we handle files that may appear at some time in future. This patch 
changes the code for #2 and doesn't have any effect on #1.

We should definitely have an oe-selftest test for this though.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

