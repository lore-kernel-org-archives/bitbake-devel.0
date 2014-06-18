Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id F2E086FE3C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 14:35:40 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 18 Jun 2014 07:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,501,1400050800"; d="scan'208";a="447049526"
Received: from tlankage-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.87])
	by azsmga001.ch.intel.com with ESMTP; 18 Jun 2014 07:35:40 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 18 Jun 2014 15:35:38 +0100
Message-ID: <7886309.jgNHRpTCme@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.5 (Linux/3.14.7-200.fc20.x86_64; KDE/4.12.5; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1406170936190.619@localhost>
References: <alpine.LFD.2.11.1406170936190.619@localhost>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: some questions about bitbake user manual, fetching chapter
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
X-List-Received-Date: Wed, 18 Jun 2014 14:35:45 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Robert,

On Tuesday 17 June 2014 10:12:42 Robert P. J. Day wrote:
>   working my way thru the fetching chapter, some questions:
> 
> * manual doesn't explain what happens if you don't supply *both*
> checksums for downloading -- what if you supply only one? or both
> and one is correct while the other is incorrect? i think this would
> be useful info for the reader.

Our convention within OE is to specify both, and because of that I haven't 
tried only specifying one for quite some time. Last I did it only required one 
of them; but for recipes that you're going to submit to OE layers, both are 
expected. (We're talking about the bitbake manual here though so it's not 
really appropriate to have OE references in there other than for the purpose 
of giving examples.)

> * right now, manual says FILESDIR is still "deprecated". is it just
> deprecated, or is it at the point where it can be killed outright?
> currently, there's nothing in the entire poky checkout that uses it.
> have people been given sufficient warning at this point?

A quick check on my side shows that there are still some isolated references 
to it across the various layers. I don't know that we have a specific timeframe 
for removing it.
 
> * i asked about this a long time ago -- in section 4.3.1 (local file
> fetcher), there's an alleged sample line:
> 
>  SRC_URI = "file://relativefile.patch;this=ignored"
> 
> "this=ignored"? can that be replaced by, say, a sample line involving
> "apply=yes" or "apply=no"? or any other relevant examples?

So, yes it's a bad example; but I think we have to be careful about what we do 
put there - e.g. apply= isn't actually handled by BitBake at all, it's 
implemented in OE in patch.bbclass.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

