Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id D39D37C432
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 13:50:34 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 0E80F5C00D5;
	Sat, 26 Jan 2019 14:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1548510635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=BrYHXldq6CDT+5+qDQf0FYy0iizcIWliZ+d7tbUt4iY=;
	b=EdmJr4EoHK44S5S0dBqZRPFGWFOocmL+4t60Bb+lIANOZUzoqgoyRnfJDFYSGYsdJKkMLn
	u9L6Z2Xy+1uNHaUKUVUiZ3X5zhEa31LEhAuUJKo8ntWEKLq6cwlsCtM424u2pzufRUS35M
	pIPMih8AYq1d0o/0VUqm/eGz82T1uLU=
MIME-Version: 1.0
Date: Sat, 26 Jan 2019 14:50:30 +0100
From: Stefan Agner <stefan@agner.ch>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <a20f847aaf0c90f4659147bf5f2e2bbe3e74bf40.camel@linuxfoundation.org>
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
	<3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
	<CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
	<a20f847aaf0c90f4659147bf5f2e2bbe3e74bf40.camel@linuxfoundation.org>
Message-ID: <4fe3bea47ebbb8977f87a6031d332e43@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Cc: Patrick Vacek <patrickvacek@gmail.com>, stefan.agner@toradex.com,
	luka.pivk@toradex.com, liu.ming50@gmail.com,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Sat, 26 Jan 2019 13:50:35 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 26.01.2019 14:35, Richard Purdie wrote:
> On Sat, 2019-01-26 at 13:07 +0100, Patrick Vacek wrote:
>> On Sat, Jan 26, 2019 at 11:15 AM Stefan Agner <stefan@agner.ch>
>> wrote:
>> > > So it seems to be that something in the recipe was expecting
>> > semi-broken
>> > > behavior.. and its actually a recipe problem.
>> >
>> > Agreed, in this case we need to fix the recipe.
>>
>> Sorry, I must be missing something. What might be wrong with the
>> recipe? Is there more that needs to be specified than a SRCREV and a
>> branch? As far as I understand git, it keeps track of the submodules,
>> so I don't know what other information there would be to provide. The
>> reason this particular case is difficult is because there are
>> recursive submodules. When we build aktualizr, we have to be careful
>> to specify that. See
>> https://github.com/advancedtelematic/aktualizr#building:
>>
>> git submodule update --init --recursive
> 
> The problem is the checkout from the old version of the fetcher was
> broken, it incorrectly checked out that SRCREV. The recipe was written
> to build that broken checkout.
> 
> We've fixed the fetcher and Mark is saying that it now checks out the
> correct thing (as compared with a git checkout outside of the build
> system, independent of the fetcher).
> 
> The recipe assumed the old broken code so now fails to build. The
> recipe therefore needs to change to adapt to the now correct source
> code.

I was not able to reproduce Marks findings.

In particular:

> For instance, the submodule partial/extern/isotp-c:
> 
> In the current version is checked out on
> 4c5904bff3ed83ec471c8586b5faed62898d0224.  (Which matches the manual git behavior.)
> 
> While the gitsm fetcher in the older system checkedout commit
> 614fe48fe55aeea98b49804b7e31ef2d304f62de.  Which is incorrect.

That wasn't the case for me, the old code checked out 4c5904bf just
fine.

However, I think Ming Liu's recent findings point out the culprit.

The submodule isotp-c requires a submodule on its own, and the new code
seems not to unpack that.

--
Stefan

