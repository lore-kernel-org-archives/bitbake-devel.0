Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B6A6B78778
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jan 2018 11:16:50 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0JBGn8m011749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 19 Jan 2018 11:16:50 GMT
Message-ID: <1516360609.24502.18.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 19 Jan 2018 11:16:49 +0000
In-Reply-To: <9a21e82b35b935826dd28413684f0918c00f9eb0.1516265726.git.liezhi.yang@windriver.com>
References: <cover.1516265726.git.liezhi.yang@windriver.com>
	<9a21e82b35b935826dd28413684f0918c00f9eb0.1516265726.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 2/2] parse: don't add attempted files to dependencies
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
X-List-Received-Date: Fri, 19 Jan 2018 11:16:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-01-18 at 16:57 +0800, Robert Yang wrote:
> The attempts are the files that it tries to search but don't exist,
> it searches the file in BBPATH until find it, so the attempts might
> be very long when there are many layers, which causes bb_cache.dat
> very big (I have 54 layers, the bb_cache.dat can be 119M, and even
> much bigger depends on the order of BBLAYERS).
> 
> Here is the testing data of 54 layers before and after the patch.
> 
>                     Before          After
> Parsing time        33s             9s
> Loading time        30s             5s
> Cache size          119M            20M
> 
> The time and size can be more or less depends on the order of
> BBLAYERS before the patch.
> 
> I checked the code, but didn't find why we need the attempts as
> dependencies, the one that I can think of is the file doesn't exist
> when parsing, and added to the attempts location after parsing, but
> the parseBaseConfiguration() can detect and handle this well (and
> will cause reparse in such a case), so I think that we can safely
> remove them from dependencies since they have side effects.

If you have a memory resident bitbake you need to know which files to
watch for with inotify. If a file is created somewhere which would have
been parsed had it existed when we originally parsed, we need to
invalidate the cache and reparse. This needs to happen for the metadata
itself, not just the base configuration.

I therefore strongly suspect we do need these unfortunately. There may
be some ways we can condense the dependency information though to
reduce the cache load times.

Cheers,

Richard

