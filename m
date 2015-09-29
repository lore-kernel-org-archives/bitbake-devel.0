Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A28FF73CBD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 12:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8TCqFYv002686; Tue, 29 Sep 2015 13:52:15 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fyJYr9XaDVrH; Tue, 29 Sep 2015 13:52:15 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8TCq3UV002683
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Sep 2015 13:52:15 +0100
Message-ID: <1443531123.5162.27.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 29 Sep 2015 13:52:03 +0100
In-Reply-To: <5603B2E7.6060606@windriver.com>
References: <cover.1443082777.git.liezhi.yang@windriver.com>
	<5603B2E7.6060606@windriver.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/1] siggen.py: fix clean_basepath()
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
X-List-Received-Date: Tue, 29 Sep 2015 12:52:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-09-24 at 16:23 +0800, Robert Yang wrote:
> Hi RP,
> 
> I'm not sure what patch causes this problem, this patch can fix it,
> but I'm not sure whether it is a correct fix or not.

The code there is quite deliberately adding this in. The issue is around
shared workdir and shared stamps that we had for gcc in particular.
Without this, we used to get stamp mismatches reported for gcc
unpack/fetch/patch tasks.

That said, I think the shared stamps code was a bad idea, we've stopped
using it for gcc now (gcc-source is there instead) and we should
probably remove all remnants of stamp-base from bitbake as it turned out
to be a bad idea.

I'd probably leave fixing this until we do that.

Cheers,

Richard



