Return-Path: <clemens.lang@bmw-carit.de>
Received: from mail.bmw-carit.de (mail.bmw-carit.de [62.245.222.98])
	by mail.openembedded.org (Postfix) with ESMTP id 174806017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2015 14:27:43 +0000 (UTC)
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:44452
	helo=mail.bmw-carit.de)
	by mail.bmw-carit.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <Clemens.Lang@bmw-carit.de>)
	id 1YTtE5-0002cr-0M; Fri, 06 Mar 2015 15:27:41 +0100
Received: from localhost (172.20.20.163) by Exchange2010.bmw-carit.intra
	(192.168.100.28) with Microsoft SMTP Server (TLS) id 14.1.218.12;
	Fri, 6 Mar 2015 15:27:40 +0100
Date: Fri, 6 Mar 2015 15:27:40 +0100
From: Clemens Lang <clemens.lang@bmw-carit.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20150306142740.GQ5023@ulm-bmuc496424.bmw-carit.de>
References: <20150227120026.GA13973@ulm-bmuc496424.bmw-carit.de>
	<20150306114328.GN5023@ulm-bmuc496424.bmw-carit.de>
	<20150306122238.GF2337@jama>
	<20150306130320.GO5023@ulm-bmuc496424.bmw-carit.de>
	<20150306132917.GG2337@jama>
	<1425649365.26813.123.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1425649365.26813.123.camel@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [172.20.20.163]
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2: Revalidate checksums, YOCTO #5571
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
X-List-Received-Date: Fri, 06 Mar 2015 14:27:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Fri, Mar 06, 2015 at 01:42:45PM +0000, Richard Purdie wrote:
> I am nervous about the amount and kind of code changes this is
> involving. Having "binary" data format files in pickle format is
> suboptimal in that the user can't easily inspect or change them and
> its not clear what the contents means.

That's correct, but I don't see it as a large problem because any issues
with the file format can be resolved by just deleting the donestamp (or
with the next changeset, touching the downloaded file).


> I was wondering about whether we should just drop to one checksum
> format and simplify the problem somewhat. I understand the reasons for
> supporting multiple checksum types though and if we add in a
> requirement to track timestamps too, the single format doesn't buy us
> anything.

I think the advantages of having multiple checksums when one of the
algorithms is no longer considered secure (as is already the case with
md5) outweighs the increased complexity. I'd rather modify the code in a
way that no longer hardcodes the supported checksum formats, so moving
to a more modern checksum would be as simple as updating documentation
and recipes.

New patch incoming after this mail.

-- 
Clemens Lang • Development Specialist
BMW Car IT GmbH • Lise-Meitner-Str. 14 • 89081 Ulm • http://bmw-carit.com
-------------------------------------------------------------------------
BMW Car IT GmbH
Geschäftsführer: Michael Würtenberger und Reinhard Stolle
Sitz und Registergericht: München HRB 134810
-------------------------------------------------------------------------

