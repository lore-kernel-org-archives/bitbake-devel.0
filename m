Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 4E3CF6AC4B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Jan 2016 00:09:04 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 04 Jan 2016 16:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,522,1444719600"; d="scan'208";a="883780356"
Received: from hlee31-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.171.9])
	by orsmga002.jf.intel.com with ESMTP; 04 Jan 2016 16:09:03 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Tue, 05 Jan 2016 13:08:59 +1300
Message-ID: <7335424.sZSo7NCKgN@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.2.8-300.fc23.x86_64; KDE/4.14.14; x86_64; ;
	)
In-Reply-To: <568AD79D.80307@windriver.com>
References: <1451933503-25881-1-git-send-email-juro.bystricky@intel.com>
	<568AD79D.80307@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] Add support for 7-Zip compressed files
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
X-List-Received-Date: Tue, 05 Jan 2016 00:09:05 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mon, 04 Jan 2016 14:35:41 Mark Hatle wrote:
> On 1/4/16 12:51 PM, Juro Bystricky wrote:
> > 7-Zip offers substantially better compression than other compression
> > formats. In fact, 7-Zip explicitly claims it provides the best compression
> > ratio. To quickly test the claim, I compressed a gcc 5.2 538.8 MB tree
> > snapshot in various ways:
> > 
> > tar.bz2: 114.0 MB
> > tar.gz:  112.4 MB
> > tar.7z:   70.3 MB
> 
> I thought 7z was an archive format, that included compression information.
> 
> Since the compression that makes 7z better then bz2 is lzma, and 'xz' uses
> lzma as it's compression format.  (In my experience, .xz is really common
> on Linux -- 7z is only common on Windows.)
> 
> I'm not saying don't support .7z, but adding support for .tar.xz and others
> would make equal sense to me.  (There are a number of formats out there that
> could and likely should be added.)

We already support tar.xz FYI (and use it within the metadata quite a lot).

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

