Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C9FA871E4B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Jun 2017 10:07:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v52A7dYA002416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 2 Jun 2017 11:07:40 +0100
Message-ID: <1496398059.6630.89.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 02 Jun 2017 11:07:39 +0100
In-Reply-To: <c3f2c1773900f6f0282d72861802d540cf59018f.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
	<c3f2c1773900f6f0282d72861802d540cf59018f.1494623828.git.chris_larson@mentor.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 02 Jun 2017 11:07:41 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: Scott Rifenbark <srifenbark@gmail.com>,
	Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH 2/8] git-make-shallow: add script to make a git repo shallow
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
X-List-Received-Date: Fri, 02 Jun 2017 10:07:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2017-05-13 at 02:46 +0500, Christopher Larson wrote:
> This script will be used by the git fetcher to create shallow mirror
> tarballs.
> 
>     usage: git-make-shallow [-h] [--ref REF] [--shrink] REVISION
> [REVISION ...]
> 
>     Remove the history of the specified revisions, then optionally
> filter the
>     available refs to those specified.
> 
>     positional arguments:
>       REVISION           a git revision/commit
> 
>     optional arguments:
>       -h, --help         show this help message and exit
>       --ref REF, -r REF  remove all but the specified refs
> (cumulative)
>       --shrink, -s       shrink the git repository by repacking and
> pruning
> 
> While git does provide the ability to clone at a specific depth, and
> fetch all
> remote refs at a particular depth, the depth is across all
> branches/tags, and
> doesn't provide the flexibility we need, hence this script.
> 
> Refs (branches+tags) can be filtered, as the process of history
> removal scales
> up rapidly with the number of refs. Even the existing `git fetch --
> depth=` is
> extremely slow on an upstream kernel repository with all the branches
> and tags
> kept.
> 
> This uses the same underlying mechanism to implement the history
> removal which
> git itself uses (.git/shallow), and the results, when configured
> similarly, are
> in line with the results git itself produces with `fetch --depth`.

Sorry about the delay in getting to this. In general the series looks
great. One minor thing that bothers me a bit is the name of this
script. If git itself ever creates something similar it may cause us
issues. I wondered if we wanted to namespace this more closely to
bitbake?

I'm leaning towards merging this and then perhaps tweaking the naming.

The other thing I'd really like to see is the documentation collected
out the commit messages and sent to Scott Rifenbark (cc'd) as a summary
of the changes so he can update the manual, particularly the section on
the git fetcher. If you could review it once Scott has done that, that
would be awesome :).

I do have my worries about how much complexity this adds to the git
fetcher but I guess its inevitable and at least we have the tests
(thanks!).

In the back of my mind there is another way I've been wondering about
assisting fetches, namely a "common reference repo" which urls may name
(e.g. git://xxx;refrepo=linux-kernel). If this was specified, any clone
would happen into the reference name as a subset namespace before a
clone by reference into the main repo name. With kernels, this would
mean one core repo and then all the subset kernels would clone by
reference from it. That should mean all kernels would share a common
repo so once you have one things should all be fast. Obviously shallow
clones solve a different problem in some ways but there is overlap.

Cheers,

Richard

