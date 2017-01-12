Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C582E71C48
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 17:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0CHfCoe013206; Thu, 12 Jan 2017 17:41:12 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7ajRSquFPomu; Thu, 12 Jan 2017 17:41:12 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0CHfADc013189
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Jan 2017 17:41:11 GMT
Message-ID: <1484242870.4367.219.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Date: Thu, 12 Jan 2017 17:41:10 +0000
In-Reply-To: <DA1C4B84-D5CA-4BE4-97D3-CA19F1E89C2F@linux.intel.com>
References: <1482352057-26139-1-git-send-email-jianxun.zhang@linux.intel.com>
	<1482397158.9843.130.camel@linuxfoundation.org>
	<48AEE85D-1072-4C81-922D-D9DF9A3E4D66@linux.intel.com>
	<DA1C4B84-D5CA-4BE4-97D3-CA19F1E89C2F@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] use multiple processes to dump signatures.
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
X-List-Received-Date: Thu, 12 Jan 2017 17:41:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 2017-01-10 at 14:54 -0800, Jianxun Zhang wrote:
> Do you have further suggestion based on my explanation?
> 
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=10352

I needed to sit and look at that patch for a while to check a few
things but I think you have it right. I've been doing some local
testing and its now queued in -next, thanks!

Just out of interest, before:

oe-selftest -r sstatetests.SStateTests.test_sstate_allarch_samesigs_multilib

2017-01-12 17:06:18 -   test_sstate_allarch_samesigs_multilib (oeqa.selftest.sstatetests.SStateTests) ... OK (325.084s)

and after:

2017-01-12 16:58:59 -   test_sstate_allarch_samesigs_multilib (oeqa.selftest.sstatetests.SStateTests) ... OK (93.926s)

and this change should help multiple tests so its a nice improvement!

Cheers,

Richard

