Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id D5F42760B0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 15:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 34A0D2E18B;
	Tue,  9 Aug 2016 17:08:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 2+ueGiKo4YbI; Tue,  9 Aug 2016 17:08:58 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id A06DF2E182;
	Tue,  9 Aug 2016 17:08:58 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 89FD819AC;
	Tue,  9 Aug 2016 17:08:58 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 7EDC29F3;
	Tue,  9 Aug 2016 17:08:58 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by seth.se.axis.com (Postfix) with ESMTP id 7D3481FF;
	Tue,  9 Aug 2016 17:08:58 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 23D899C09F; Tue,  9 Aug 2016 17:09:03 +0200 (CEST)
Date: Tue, 9 Aug 2016 17:09:02 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <20160809150902.GR4674@axis.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
	<5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
	<20160809093647.GP4674@axis.com>
	<917EB417-8D19-45C7-AE21-E11828557010@gmail.com>
MIME-Version: 1.0
In-Reply-To: <917EB417-8D19-45C7-AE21-E11828557010@gmail.com>
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
X-List-Received-Date: Tue, 09 Aug 2016 15:09:02 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 16-08-09 07:34 -0700, Khem Raj wrote:
> Too literal, I guess a reader is getting what I was referring to

No, a reader did not understood what you are talking about.
Quite frankly, you're not being constructive here Khem. Assuming
that I'm confusing things because we have differences in
opinions, and that it doesn't matter that I don't understand what
you are saying as long as you think that other people do is not
very helpful. What's the point in discussing anything with you?

> If you were to think of a tool to generate the srcrevs from
> tags, that IMO can be better solution here. Like Paul
> suggested.

Yes, Paul's suggestion was very constructive (thanks!), and
that's something we might do. But it still forces us to deal with
sha1 revision ids. Would require effort on our part to hide this
from our users and automate it somehow. Some issues that we would
like to handle:

 - changing PV won't have any effect on what source is fetched/used
 - changing SRCREV to another revision won't affect PV

-- 
olofjn

