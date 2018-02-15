Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B3D6860190
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 10:59:18 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w1FAxGpD014662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 15 Feb 2018 10:59:17 GMT
Message-ID: <1518692356.24236.122.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>,
	Ryan Harkin <ryan.harkin@linaro.org>
Date: Thu, 15 Feb 2018 10:59:16 +0000
In-Reply-To: <CAP71WjygD3eM2fhhU5JG6Kn3_y=mH1fzy+aVrQFKtp+ED_yoog@mail.gmail.com>
References: <CAP71WjygD3eM2fhhU5JG6Kn3_y=mH1fzy+aVrQFKtp+ED_yoog@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: git fetcher and github pull requests
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
X-List-Received-Date: Thu, 15 Feb 2018 10:59:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2018-02-07 at 16:04 +0100, Nicolas Dechesne wrote:
> we've been debugging an issue these days on our builder which ended
> up
>  do_fetch failing with
> 
> LANG=C git -c core.fsyncobjectfiles=0 fetch -f --prune --progress
> git://github.com/OP-TEE/optee_test.git refs/*:refs/* failed with exit
> code 128, output:
> error: Could not read 48e440f5f8d033e1ace6e41f424ecf6e6d96e5f2
> error: Could not read 019a8db54beb29388e1108831d2e2dc135c1cd73
> 
> It happens that these refs correspond to pull requests done on github
> which existed at some point, but have been updated with newer
> commits,
> and won't exist anymore.
> 
> the bitbake fetcher seems to be greedy and fetches refs/* which ends
> up fetching pull request when fetching from github, e.g. in my
> workspace:
> 
> in $DL_DIR/git2/
> 
> github.com.docker.containerd.git/refs/pull/66
> github.com.docker.containerd.git/refs/pull/459
> github.com.docker.containerd.git/refs/pull/551
> github.com.docker.containerd.git/refs/pull/321
> github.com.docker.containerd.git/refs/pull/60
> github.com.docker.containerd.git/refs/pull/523
> github.com.docker.containerd.git/refs/pull/40
> github.com.docker.containerd.git/refs/pull/561
> 
> It looks inefficient to fetch and store on each builder pull
> requests.
> I understand this is just because how PR are implemented in github,
> but github is quite central, so many we should/could do something
> about it?
> 
> Beyond the inefficiencies, we now are seeing unrelated build issues
> as well.
> 
> What do you think? Should we try to avoid fetching refs/pull/* from
> github? or is it our git fetch command that needs to be improve to
> work in this situation?

The git fetcher deals with a complicated set of problems since it needs
to handle offline mirroring (with mirror tarballs) and a variety of
different scenarios. The reason its pulling a complete set of
references is likely to because of the mirroring and other demands
placed upon it from the different scenarios. This isn't bad as such,
github really shouldn't be sharing repos with invalid references in
them.

I did read this when you sent it, I just don't have any good
recommendation for you :(

I dread "special casing" in the git fetcher as has burnt us a lot in
the past, equally, that may be the only way to avoid this kind of
problem...

Cheers,

Richard




