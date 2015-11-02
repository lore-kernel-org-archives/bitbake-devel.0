Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 05A9F60125
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Nov 2015 21:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tA2Lmbjk010538; Mon, 2 Nov 2015 21:49:59 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QaoXlMZJfaww; Mon,  2 Nov 2015 21:49:59 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tA2Lnldm010596
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 2 Nov 2015 21:49:58 GMT
Message-ID: <1446500987.15270.17.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <paul.barker@commagility.com>
Date: Mon, 02 Nov 2015 21:49:47 +0000
In-Reply-To: <20151102172329.6e291d50@centos-7>
References: <20151102172329.6e291d50@centos-7>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Combining bitbake 1.26 with daisy
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
X-List-Received-Date: Mon, 02 Nov 2015 21:50:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-11-02 at 17:23 +0000, Paul Barker wrote:
> Hi all,
> 
> If someone were to pick up bitbake 1.26 and the daisy branch of oe-core and try
> to use these together, what would be likely to go wrong?
> 
> I've got a vendor's BSP which does this and I need to decide whether to use the
> combination they've tested or move back to bitbake 1.22. I sadly don't think
> it's possible to move forward from daisy to fido here. I don't mind fixing up
> the issues myself, just wondering if anyone has an idea of what is likely to
> fail.

Gut instinct says it probably isn't too bad. 1.28 wouldn't work due to
the data store changes but 1.26 probably will with some cleanup to the
metadata for some of the stricter bitbake parsing tweaks at a complete
guess.

Cheers,

Richard


