Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E3DA360097
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 13:02:00 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 15 Jun 2015 06:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,618,1427785200"; d="scan'208";a="588065668"
Received: from sosalmel-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.29.110])
	by orsmga003.jf.intel.com with ESMTP; 15 Jun 2015 06:01:30 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
Date: Mon, 15 Jun 2015 14:01:29 +0100
Message-ID: <1785471.7vLHLlB4f6@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.7 (Linux/4.0.4-202.fc21.x86_64; KDE/4.14.7; x86_64; ; )
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB123798D20329F@ORSMSX101.amr.corp.intel.com>
References: <355BE46A91031048906B695426A8D8E616BEA6C0@DEFTHW99EH4MSX.ww902.siemens.net>
	<2537868.NScFGFhOWl@peggleto-mobl.ger.corp.intel.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB123798D20329F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Cc: Christopher Larson <clarson@kergoth.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 15 Jun 2015 13:02:01 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Scott,

I didn't add you to CC because I'd hoped it would be someone other than you or 
me this time :)

(Not that I intended to poke the people who were on CC to add it either 
though.)

Cheers,
Paul

On Monday 15 June 2015 12:57:34 Rifenbark, Scott M wrote:
> Someone?  Ha.
> 
> >-----Original Message-----
> >From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> >devel-bounces@lists.openembedded.org] On Behalf Of Paul Eggleton
> >Sent: Monday, June 15, 2015 5:56 AM
> >To: bitbake-devel@lists.openembedded.org
> >Cc: Christopher Larson
> >Subject: Re: [bitbake-devel] Allow access to specific git server while
> >BB_FETCH_PREMIRRORONLY ="1"
> >
> >On Sunday 14 June 2015 23:43:54 Bernhard Reutner-Fischer wrote:
> >> On June 12, 2015 3:04:17 PM GMT+02:00, Christopher Larson
> >
> ><clarson@kergoth.com> wrote:
> >> >On Fri, Jun 12, 2015 at 7:47 AM, Bach, Pascal
> >> ><pascal.bach@siemens.com>
> >> >
> >> >wrote:
> >> >> I was wondering if there is a way to allow access to specific urls
> >> >
> >> >even if
> >> >
> >> >> BB_NO_NETWORK or BB_FETCH_PREMIRRORONLY is set.
> >> >> 
> >> >> The use case I have at hand it that we want to fetch all 3rd party
> >> >
> >> >sources
> >> >
> >> >> from a HTTP premirror we have internally. Except for some packages
> >> >
> >> >that
> >> >
> >> >> are hosted on a git server where we would like bitbake to always
> >> >
> >> >fetch from
> >> >
> >> >> there (no tarball on the pre mirror).
> >> >> 
> >> >> I tried:
> >> >> PREMIRROR_prepend = "git@local/foo.git git@local/foo.git \n"
> >> >> 
> >> >> 
> >> >> But this doesn't seem to work.
> >> >> 
> >> >> Is there way to achieve this with the current PREMIRROR variable?
> >> >> Or
> >> >
> >> >is
> >> >
> >> >> this functionality currently missing?
> >> >
> >> >See the recently added BB_TRUSTED_NETWORK variable.
> >> 
> >> I hope the v3 with BB_ALLOWED_NETWORKS was applied instead but
> >
> >cannot
> >
> >> currently check.
> >
> >Looking at master, it was - BB_ALLOWED_NETWORKS is indeed the new
> >variable for this.
> >
> >(Speaking of which, someone needs to add that to the docs...)



-- 

Paul Eggleton
Intel Open Source Technology Centre

