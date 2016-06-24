Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8862D606D0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 13:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5ODFOrs015175; Fri, 24 Jun 2016 14:15:24 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8o6Dpd2ZTLj7; Fri, 24 Jun 2016 14:15:24 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5ODFMdL015167
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Jun 2016 14:15:23 +0100
Message-ID: <1466774122.3319.235.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org, "Wessel, Jason"
	<jason.wessel@windriver.com>, Mark Hatle <mark.hatle@windriver.com>
Date: Fri, 24 Jun 2016 14:15:22 +0100
In-Reply-To: <ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
References: <cover.1466754896.git.liezhi.yang@windriver.com>
	<ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] fetch2: remove "." in the end
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
X-List-Received-Date: Fri, 24 Jun 2016 13:15:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-06-24 at 00:55 -0700, Robert Yang wrote:
> From: Jason Wessel <jason.wessel@windriver.com>
> 
> The filename can't be "foo." for MS Windows filesystem, it will
> renamed
> to "foo" automatically, so we can't upload sources like "foo." to the
> Windows server, remove "." in the end will fix the problem.

This patch on its own is probably ok. What I worry about is that if I
merge this, I'll then get all the follow ups which for example force
lower or upper case everywhere, remove ":" characters from all
filenames (including sstate?), remove various other characters and so
on.

We don't run on windows filesystems and we're not likely ever to be
able to.

So what are we aiming for here?

Cheers,

Richard

