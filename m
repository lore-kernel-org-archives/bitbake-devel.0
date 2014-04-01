Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9236C6F572
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 13:57:02 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s31DuRXR024932; Tue, 1 Apr 2014 14:56:56 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RveDJVbbiUpw; Tue,  1 Apr 2014 14:56:56 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s31DuqFu024958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 14:56:54 +0100
Message-ID: <1396360607.2910.22.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joe MacDonald <joe@deserted.net>
Date: Tue, 01 Apr 2014 14:56:47 +0100
In-Reply-To: <20140401135024.GA16104@deserted.net>
References: <1396298667-17975-1-git-send-email-joe@deserted.net>
	<1396342711.14790.92.camel@ted> <20140401135024.GA16104@deserted.net>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: parse: allow vars_from_file to consider inc files as recipes
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
X-List-Received-Date: Tue, 01 Apr 2014 13:57:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-04-01 at 09:50 -0400, Joe MacDonald wrote:
> > On Mon, 2014-03-31 at 16:44 -0400, joe@deserted.net wrote:

> I don't want to keep using meta-selinux as an example here, (since it
> mostly ends up looking bad for meta-selinux, I suppose) but I can
> actually see a case where -common would be organizationally desirable.
> Or at least not ugly.  recipies-security/selinux has a collection of
> core selinux recipes, each has their own patches directory which
> potentially co-mingles patches for versioned and git-based recipes or
> both.  Right now none of the recipes in there are doing the
> <specific> -> <versioned> -> <common> include thing, but it's not a huge
> stretch to imagine it being useful.
> 
> In other cases that'd be done with a versioned directory name and a
> files/ directory, but that would make things less clear, not more in
> this scenario.  So having a <recipie>-common directory would be kind of
> good.

Well, you can do that, but you should name it as such in the variable,
not abuse the PV variable like this! :)

> > I'd therefore much rather figure out what is happening to cause the
> > expansion of PV in the .inc file and see if we can't avoid that.
> > 
> > Looking at the layer, the issue is:
> > 
> > FILESEXTRAPATHS_prepend := "${THISDIR}/refpolicy-${PV}:"
> > 
> > and I'd suggest that line move to the .bb files in this case.
> 
> That's what I'll do if you're not convinced on this patch, but when I
> started down that path yesterday afternoon I got thinking about what I'd
> laid out above and that I would be duplicating the exact same line in
> three recipes right now (-mcs, -mls and -standard) and adding it to any
> other new policies that get submitted.  That really is a common piece
> shared among all the variants and it seemed like the right thing to do
> was have it only in one place.

I understand the concern there, you could do this with a "common" name
in the variable instead of PV though.

Cheers,

Richard


