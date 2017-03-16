Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A4B3571DF8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Mar 2017 12:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2GCsOv6003748; Thu, 16 Mar 2017 12:54:24 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0_s-YOrJVlso; Thu, 16 Mar 2017 12:54:24 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2GCsKUp003745
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Mar 2017 12:54:21 GMT
Message-ID: <1489668860.13980.106.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 16 Mar 2017 12:54:20 +0000
In-Reply-To: <2c5e1707-851f-5d82-15e8-a4c39bb8af89@windriver.com>
References: <2c5e1707-851f-5d82-15e8-a4c39bb8af89@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Subject: Re: _remove operator -- taskhash issue
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
X-List-Received-Date: Thu, 16 Mar 2017 12:54:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2017-03-15 at 23:14 -0500, Mark Hatle wrote:
> I noticed something today on morty.  (So this might be fixed in
> master.)

It is indeed fixed in master:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/?id=45df694a9f472ac2f684aadac4d864c3dfdc48a7

I've backported that fix to morty since it seems like a reasonably
thing to fix there.

I also wrote a test case for it and added it to bitbake-selftest.

Cheers,

Richard

