Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 76E3573257;
	Mon, 13 Jun 2016 10:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5DAxiHT009020; Mon, 13 Jun 2016 11:59:44 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U3T9323gqrkE; Mon, 13 Jun 2016 11:59:44 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5DAxdO6009015
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 13 Jun 2016 11:59:40 +0100
Message-ID: <1465575223.13979.188.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Trevor Woerner <twoerner@gmail.com>
In-Reply-To: <20160610160710.GA18625@openSUSE-i7.site>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
Date: Fri, 10 Jun 2016 17:13:43 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Multi-configuration builds
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
X-List-Received-Date: Mon, 13 Jun 2016 10:59:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
> On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
> > A few people have asked about multi-machine builds.
> 
> Do you envision each config also pointing to individual bblayer
> configurations
> too? I.e. if I'm building for 3 different MACHINEs, with 3 different
> configs
> (local.conf?), then there would also be 3 different bblayers.conf's?


No, there is one local.conf and one bblayers.conf file and then three
different multiconfig files, each one of which sets a different
MACHINE.

Would people really want to support different bblayer files? That would
complicate things quite a lot :/.

Cheers,

Richard

