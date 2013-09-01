Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D21926BD5D
	for <bitbake-devel@openembedded.org>;
	Sun,  1 Sep 2013 07:57:17 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r818A1nw014184; Sun, 1 Sep 2013 09:10:01 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4Ra8JdbZ3foC; Sun,  1 Sep 2013 09:10:00 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8189uOF014179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sun, 1 Sep 2013 09:09:58 +0100
Message-ID: <1378022224.1059.139.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Halstead <michael@yoctoproject.org>
Date: Sun, 01 Sep 2013 08:57:04 +0100
In-Reply-To: <521EAADC.7050807@yoctoproject.org>
References: <521EAADC.7050807@yoctoproject.org>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@openembedded.org
Subject: Re: Protocol versioning for PR server
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
X-List-Received-Date: Sun, 01 Sep 2013 07:57:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-08-28 at 18:58 -0700, Michael Halstead wrote:
> We should have a way to determine protocol version for the PR server in
> http://cgit.openembedded.org/bitbake/tree/lib/prserv/serv.py. We could
> include a new callback to determine version or we could include the
> version with every response. Either way it's a good idea to plan for
> changes going forward.

This is a good point, thanks for raising it. Including a callback is
probably going to be the easiest way to do it at this point.

Cheers,

Richard


