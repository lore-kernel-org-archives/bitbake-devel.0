Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 43B65719CB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Sep 2016 10:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8MAIeYi000575; Thu, 22 Sep 2016 11:18:40 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GyXLhPvou24r; Thu, 22 Sep 2016 11:18:40 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8MAHl1S000530
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Sep 2016 11:17:48 +0100
Message-ID: <1474539467.7207.357.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Pascal Bach <pascal.bach@siemens.com>, Christopher Larson
	<clarson@kergoth.com>
Date: Thu, 22 Sep 2016 11:17:47 +0100
In-Reply-To: <02946d54-8e3d-78ce-a094-e06365273cf3@siemens.com>
References: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
	<CABcZAN=E+cw8Dvay34EObcDcyoUh7OPUmrvx6iuQQ89jTHYk_A@mail.gmail.com>
	<508fb644-1ed9-8c92-e6ed-e09f52c03e00@siemens.com>
	<CABcZANn4D8Qog6ukM_7XM65ZY+OymnmD2K8DeipxoVOOaY1FcA@mail.gmail.com>
	<64d81891-801e-292e-e26c-1c44bd38a8c5@siemens.com>
	<02946d54-8e3d-78ce-a094-e06365273cf3@siemens.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: always use premirror first if update is required
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
X-List-Received-Date: Thu, 22 Sep 2016 10:18:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2016-09-22 at 09:45 +0200, Pascal Bach wrote:
> > 
> > > 
> > >     The tarball should only be fetched if the local ud.clonedir
> > > is out of date, this means the revision that is requested via
> > > SRCREV is not in the local repository.
> > >     In the case the revision is present the tarball should not be
> > > fetched again, at least that was the intention and my local tests
> > > didn't indicate otherwise.
> > > 
> > > 
> > > Yes, but it’s better to run ‘git fetch’ in an out of date clone
> > > than to re-download a 1gb mirror tarball which may well be out of
> > > date too.
> > Agreed, but this doesn't work in the case where the machine doesn't
> > have access to the upstream git repository. For example in the case
> > where BB_ALLOWED_NETWORKS = "*.my.company". The fetcher would still
> > got to to github.com which is not allowed, in that case it should
> > fall back to fetch the tarball from "mirror.my.company".
> > 
> > I'm open for suggestions how to make this more efficient.
> Does anyone have a suggestion how this should behave in the ideal
> case? In my opinion if there is an internal mirror defined it should
> always have precedence even if it might be less efficient.

"less efficient" in this case translates a few seconds of git fetch
operation on something like linux-yocto into a hundreds of megabytes
download.

Much as you might not like it, I really don't think we can change the
code as your patch does as it would badly affect standard usage for
many users.

We need to find an alternative which allows your use case to work but
I'm not sure what that is. Much as I hate it, we may just have to have
a setting which you can set which changes the behaviour. If we do that,
I will want to see test cases added for it though as the fetcher code
is a mass of different configurations and its very very difficult to
maintain as it is without yet more different code paths :(.

Cheers,

Richard





