Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 9277D606BF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jul 2016 20:55:33 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga104.fm.intel.com with ESMTP; 27 Jul 2016 13:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,431,1464678000"; d="scan'208";a="1015085290"
Received: from ndrai-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.178.75])
	by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2016 13:55:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Jul 2016 08:55:30 +1200
Message-ID: <9999959.NysMaTSW10@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.6.4-201.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <11574390.7kjj5FOXUz@peggleto-mobl.ger.corp.intel.com>
References: <cover.1469504165.git.paul.eggleton@linux.intel.com>
	<1469516922.23580.92.camel@linuxfoundation.org>
	<11574390.7kjj5FOXUz@peggleto-mobl.ger.corp.intel.com>
MIME-Version: 1.0
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
X-List-Received-Date: Wed, 27 Jul 2016 20:55:33 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thu, 28 Jul 2016 08:53:33 Paul Eggleton wrote:
> On Tue, 26 Jul 2016 08:08:42 Richard Purdie wrote:
> > On Tue, 2016-07-26 at 15:36 +1200, Paul Eggleton wrote:
> > > If using OE's externalsrc with a source tree that is not tracked by
> > > git and contains broken symlinks, you can receive "TypeError:
> > > unorderable
> > > 
> > > types: NoneType() < str()" within the file checksum code due to:
> > >  checksums.sort(key=operator.itemgetter(1))
> > > 
> > > Don't add files with no checksum to the checksums list in order to
> > > avoid this.
> > 
> > In some of the cache code we have to note whether files were checked
> > for but didn't exist. This means that if they then do exist in a later
> > run, we know to invalidate the cache.
> > 
> > Does this change break that?
> 
> Took me a couple of days to get back to this, but after double-checking both
> the code and the behaviour the answer is no. As you may recall the file
> checksum operation is broken into two parts:
> 
> 1) Getting the list of files regardless of whether they exist or not, which
> is done at parse time and goes into the cache
> 
> 2) Actually getting the checksum of each file that does exist, which is done
> when we calculate the task hashes. The hashes are also cached in their own
> separate cache file based on mtime.

Sorry, for clarity that should have read "The file checksums are also 
cached..."

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

