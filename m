Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 345A060064
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 22:00:19 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w6NM0G0s006501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Mon, 23 Jul 2018 23:00:17 +0100
Message-ID: <3bace14d7cbf7d350b146849d6f9eefc00fe9733.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jul 2018 23:00:15 +0100
In-Reply-To: <20180723154259.9076-1-urs.fassler@bbv.ch>
References: <20180723154259.9076-1-urs.fassler@bbv.ch>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 0/9] Always use the url specified in the recipe as a base for the git shallow tarball naming
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
X-List-Received-Date: Mon, 23 Jul 2018 22:00:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2018-07-23 at 17:42 +0200, Urs Fässler wrote:
> The existing behavior was to use the url where the repository was
> cloned from.
> It happened that the tarball was not found when a mirror rewrite rule
> was active.
> 
> We now use the url specified in the recipe to name the shallow
> tarball. It fixes that the tarball is not found under certain
> conditions. In addition, the naming is independent of network/server
> failure and the mapping of the name is easier to understand.

I'm not sure why but throughout this patch series you've used function
names and variables prefixed with "__". We don't do this with any of
our other code so it seems out of keeping with the rest of the coding
style.

With regard to the function "__has_up_to_date_clonedir" you added, its
very unclear why some checks would go in that function and some checks
would go in the other. The commit description helps understand it a bit
more but that doesn't help the function naming or someone looking at
the code in future.

Finally, I'm still not convinced that passing around the original url
and forcing the original url naming into any mirroring code is the
right solution to the problem. I said that at the start and looking at
this code change, I'm still not convinced this is right. Part of the
reason I continue to believe that is you just added a N*N testing
problem to the fetcher where the fetchers now behave differently
depending on two urls passed in rather than just one :(.

Cheers,

Richard





