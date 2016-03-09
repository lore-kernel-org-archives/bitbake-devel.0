Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9B8F170101
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 22:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u29MgAbN025758; Wed, 9 Mar 2016 22:42:10 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id s28Mfmq9eQOd; Wed,  9 Mar 2016 22:42:10 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u29Mg6qB025754
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 9 Mar 2016 22:42:07 GMT
Message-ID: <1457563326.2804.192.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Sasha Shashkevich <alex@stunpix.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 09 Mar 2016 22:42:06 +0000
In-Reply-To: <48D48E72-F0D1-4705-BDB2-ED59E44F0354@stunpix.com>
References: <1457540149-94456-1-git-send-email-alex@stunpix.com>
	<48D48E72-F0D1-4705-BDB2-ED59E44F0354@stunpix.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH v2] bb/fetch2: fixes copying of file://dir; subdir=foo, bug 6128 and bug 6129
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
X-List-Received-Date: Wed, 09 Mar 2016 22:42:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-03-09 at 18:54 +0200, Sasha Shashkevich wrote:
> > On Mar 9, 2016, at 18:15, Alexander Shashkevich <alex@stunpix.com>
> > wrote:
> > 
> > When in SRC_URI appears file://dir;subdir=foo unpacker copies 'dir'
> > to ${WORKDIR}, not
> > ${WORKDIR}/foo as it should be.
> > 
> > These changes are fixing following bugs as well:
> > Bug 6128 - Incorrect wildcard unpack behaviour in fetcher
> > Bug 6129 - Local directories unpack to a different location than
> > local files
> > 
> > Signed-off-by: Alexander Shashkevich <alex@stunpix.com>
> > --
> 
> Changes were tested on 1.8 and 2.0 branches for core-image-sato and
> meta-sdk images.
> 
> Additional changes since last sent patch:
> 
>  - New test cases were added to cover absolute paths in SRC_URI for
> local files.
>  - Fixed recipe nativesdk-qemu-helper_1.0.bb: it was based on
> incorrect copying behavior which had been changed by this patch.
> 
> Please review my changes.

Could you have a look at master please? I already took one of your
earlier patches which I followed with a changes to correctly handle
absolute paths:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib?id=2a73181
33bbd64f5dcb2ddf400229d4627925580

I wasn't convinced the behaviour in the qemu-helper recipe was
incorrect. If you still believe it is, I'm happy to consider that.

I'm also very interested in getting some updated test cases in.

Cheers,

Richard



