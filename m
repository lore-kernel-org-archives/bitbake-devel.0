Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TLc5V-0006Iq-As for bitbake-devel@lists.openembedded.org;
	Tue, 09 Oct 2012 17:51:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q99Fc73g032312;
	Tue, 9 Oct 2012 16:38:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30947-10; Tue,  9 Oct 2012 16:38:03 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q99FbvjS032306
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 9 Oct 2012 16:37:58 +0100
Message-ID: <1349797081.15658.181.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patrick Turley <PatrickTurley@gamestop.com>
Date: Tue, 09 Oct 2012 16:38:01 +0100
In-Reply-To: <B1E9B992-64A8-4AA7-8744-D67835D3F7B0@gamestop.com>
References: <B1E9B992-64A8-4AA7-8744-D67835D3F7B0@gamestop.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: BitBake dies when "stampfile" variable is "None"
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 09 Oct 2012 15:51:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-10-09 at 15:20 +0000, Patrick Turley wrote:
> I've had a problem with the 1.15.2 version of BitBake and I'd like to
> see if a BitBake expert can short-circuit my investigation.

Try setting the STAMP variable...

Cheers,

Richard




