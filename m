Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8B49273B6A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 16:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2CGUUR4011666; Thu, 12 Mar 2015 16:30:30 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Lfr9SensI_a4; Thu, 12 Mar 2015 16:30:30 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2CGUEQF011637
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Mar 2015 16:30:26 GMT
Message-ID: <1426177814.9114.119.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rob Woolley <rob.woolley@windriver.com>
Date: Thu, 12 Mar 2015 16:30:14 +0000
In-Reply-To: <5501AFD7.40906@windriver.com>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
	<5501AFD7.40906@windriver.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] knotty: Add automatic pager support
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
X-List-Received-Date: Thu, 12 Mar 2015 16:30:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-03-12 at 11:25 -0400, Rob Woolley wrote:
> Hi,
> 
> Just wanted to send out a ping to see if this enhancement is desired.
> 
> It scratches an itch for me, but not sure how others feel about it.
> 
> If there are any changes I can make or extra tests I can run, please let 
> me know.

Patches 1/2 look good, I've run into the EPIPE issue myself and I have
noticed the crazy logfile so those can likely be merged.

I'm less sure about 3, letting the user pipe the output to less when
needed would seem to be the better way to have this rather than adding
in specific pagination support?

Cheers,

Richard


