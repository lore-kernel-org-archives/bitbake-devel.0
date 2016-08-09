Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 4B46D77227
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 16:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id D5B8F2E233;
	Tue,  9 Aug 2016 18:26:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id wFUTDvjjsj+K; Tue,  9 Aug 2016 18:26:24 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id BB33C2E22C;
	Tue,  9 Aug 2016 18:26:24 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id A4BBE19B7;
	Tue,  9 Aug 2016 18:26:24 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 99B581942;
	Tue,  9 Aug 2016 18:26:24 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 97F91363;
	Tue,  9 Aug 2016 18:26:24 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 697C89C09F; Tue,  9 Aug 2016 18:26:29 +0200 (CEST)
Date: Tue, 9 Aug 2016 18:26:29 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <20160809162629.GT4674@axis.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
	<5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
	<20160809093647.GP4674@axis.com>
	<917EB417-8D19-45C7-AE21-E11828557010@gmail.com>
	<20160809150902.GR4674@axis.com>
	<601FD807-0341-4764-AE68-0E3DA0BB0E11@gmail.com>
MIME-Version: 1.0
In-Reply-To: <601FD807-0341-4764-AE68-0E3DA0BB0E11@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Tue, 09 Aug 2016 16:26:27 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 16-08-09 08:54 -0700, Khem Raj wrote:
> I am sorry if its coming across this way.I for one was trying to convey
> that there are reasons to not have such a patch e.g. predictable
> builds and general support problems with BB_NO_NETWORK.
> 
> We have been through this very same problem and decided to use srcrev
> collection approach which is similar to buildhistory collection
> approach. It was a bit of getting used to, but in the end it was
> a very good way.

Thanks for clarifying, this is a reasonable stance, and I can see
where you are coming from. But I'm not advocating that this
behavior should be forced upon anybody. What I'm trying to convey
is that not all environments have issues with volatile tags, and
from my pov, it's reasonably easy to fight people (within an
organization) moving tags if you own the Git infrastructure =).

(Having reproducible builds is another way to alleviate the risks
of using possibly volatile tags. If the build output is
different, then the input obviously is different as well (incl.
implicit inputs like datetime, TZ or locale). Just putting it out
there. People in the Debian community and elsewhere are doing a
lot of work in this area. [1])

> >> If you were to think of a tool to generate the srcrevs from
> >> tags, that IMO can be better solution here. Like Paul
> >> suggested.
> > 
> > Yes, Paul's suggestion was very constructive (thanks!), and
> > that's something we might do. But it still forces us to deal with
> > sha1 revision ids. Would require effort on our part to hide this
> > from our users and automate it somehow. Some issues that we would
> > like to handle:
> > 
> > - changing PV won't have any effect on what source is fetched/used
> 
> I believe it should not.

Yes, that's the heart of our disagreement, I think. We currently
set SRCREV = "${PV}". We believe that in our environment, we are
safe to do this even without syncing with the remote.

> > - changing SRCREV to another revision won't affect PV
> 
> If you do not utilize SRCPV in PV variable. SRCREV should not reflect
> in the PV

Exactly, so that's the problem for me. I'm hesitent to introduce
sha1s into the metadata in our layers as it will make us have two
variables to keep track of the version. I fear that they will
become out of sync.

If somebody tries to only update the SRCREV, the package
manifests and elsewhere will be confusing for people trying to
troubleshoot as the PV is that of the old version (the same way a
moved tag can cause massive confusion). If somebody tries to only
update the PV, the package manifest will look correct, but the
sources is that of something else. Is this something you have any
experience with?

-- 
olofjn

1: https://reproducible-builds.org/

