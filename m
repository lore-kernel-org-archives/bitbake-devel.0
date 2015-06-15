Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 304467573C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 12:55:59 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 15 Jun 2015 05:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,618,1427785200"; d="scan'208";a="727618349"
Received: from sosalmel-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.29.110])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2015 05:55:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Jun 2015 13:55:59 +0100
Message-ID: <2537868.NScFGFhOWl@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.7 (Linux/4.0.4-202.fc21.x86_64; KDE/4.14.7; x86_64; ; )
In-Reply-To: <FDD27E4D-9B52-49FA-A99A-076F615C3A5D@gmail.com>
References: <355BE46A91031048906B695426A8D8E616BEA6C0@DEFTHW99EH4MSX.ww902.siemens.net>
	<CABcZANnmPX=wU8BNt+y3UnCLOkbB9LWR-Lwgw6zVxa-_+PF6kQ@mail.gmail.com>
	<FDD27E4D-9B52-49FA-A99A-076F615C3A5D@gmail.com>
MIME-Version: 1.0
Cc: Christopher Larson <clarson@kergoth.com>
Subject: Re: Allow access to specific git server while BB_FETCH_PREMIRRORONLY ="1"
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
X-List-Received-Date: Mon, 15 Jun 2015 12:56:00 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 14 June 2015 23:43:54 Bernhard Reutner-Fischer wrote:
> On June 12, 2015 3:04:17 PM GMT+02:00, Christopher Larson 
<clarson@kergoth.com> wrote:
> >On Fri, Jun 12, 2015 at 7:47 AM, Bach, Pascal <pascal.bach@siemens.com>
> >
> >wrote:
> >> I was wondering if there is a way to allow access to specific urls
> >
> >even if
> >
> >> BB_NO_NETWORK or BB_FETCH_PREMIRRORONLY is set.
> >> 
> >> The use case I have at hand it that we want to fetch all 3rd party
> >
> >sources
> >
> >> from a HTTP premirror we have internally. Except for some packages
> >
> >that
> >
> >> are hosted on a git server where we would like bitbake to always
> >
> >fetch from
> >
> >> there (no tarball on the pre mirror).
> >> 
> >> I tried:
> >> PREMIRROR_prepend = "git@local/foo.git git@local/foo.git \n"
> >> 
> >> 
> >> But this doesn't seem to work.
> >> 
> >> Is there way to achieve this with the current PREMIRROR variable? Or
> >
> >is
> >
> >> this functionality currently missing?
> >
> >See the recently added BB_TRUSTED_NETWORK variable.
> 
> I hope the v3 with BB_ALLOWED_NETWORKS was applied instead but cannot
> currently check.

Looking at master, it was - BB_ALLOWED_NETWORKS is indeed the new variable for 
this.

(Speaking of which, someone needs to add that to the docs...)

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

