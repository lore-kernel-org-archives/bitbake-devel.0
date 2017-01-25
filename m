Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 00C6771CAA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jan 2017 19:17:48 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Jan 2017 11:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,285,1477983600"; d="scan'208";a="926608474"
Received: from wlim11-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.191.49])
	by orsmga003.jf.intel.com with ESMTP; 25 Jan 2017 11:17:29 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 26 Jan 2017 08:17:25 +1300
Message-ID: <2926401.9a0hO52TuJ@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/5.3.3 (Linux/4.9.5-200.fc25.x86_64; KDE/5.29.0; x86_64; ; )
In-Reply-To: <1485342777.30673.79.camel@linuxfoundation.org>
References: <16e4f38d781445449f3290f035a655ed@XBOX02.axis.com>
	<1485342777.30673.79.camel@linuxfoundation.org>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: Drop package-depends.dot and pn-depends.dot generation
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
X-List-Received-Date: Wed, 25 Jan 2017 19:17:52 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 25 January 2017 11:12:57 AM NZDT Richard Purdie wrote:
> On Wed, 2017-01-25 at 11:05 +0000, Peter Kjellerstedt wrote:
> > pn-dependes.dot when visualizing the dependencies between packages. 
> > Even though task-depends.dot is more complete, trying to render it 
> > is near impossible given the sheer number of nodes and edges it 
> > contains. Already visualizing pn-depends.dot is hard but possible 
> > with some gvpr and tred filtering. Here are some statistics from 
> > one of my typical builds:
> > 
> >                         Nodes  Edges
> >                         -----  ------
> > pn-depends.dot           1183   12087
> > package-depends.dot      5939   55615
> > task-depends.dot        13756  125870
> > 
> > As can be seen, the number of nodes and edges in task-depends.dot 
> > is a magnitude greater than in pn-depends.dot.
> 
> Its certainly simpler, but the data is just plain buggy. I'm not sure
> I'd trust anything those files told me, even if they are easier to
> view.
> 
> I appreciate task-depends is hard to load graphically, it is helpful
> even as a text file though, I do use it a lot since its a near direct
> dump of bitbake's internal parsed task dependencies.

What if we collapsed down task-depends.dot to PNs only in order to produce 
pn-depends.dot? Then at least it would be reasonably accurate.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

