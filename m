Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UQPVE-00058o-Cs; Thu, 11 Apr 2013 23:57:56 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3BLppwq006356; Thu, 11 Apr 2013 22:51:51 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Q56QywOtSYfv; Thu, 11 Apr 2013 22:51:51 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3BLphb0006352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 11 Apr 2013 22:51:46 +0100
Message-ID: <1365716419.16702.63.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 11 Apr 2013 22:40:19 +0100
In-Reply-To: <20130411133031.GF2477@jama>
References: <20130411133031.GF2477@jama>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: Checksum failure encountered with download
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
X-List-Received-Date: Thu, 11 Apr 2013 21:57:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-04-11 at 15:30 +0200, Martin Jansa wrote:
> Hi,
> 
> when fetcher fails with ChecksumError it shows error like in subject and
> tries another MIRRORs
> 
> Would anyone object to keep fetched source with wrong checksum in
> downloads directory (renamed so it does not conflict with file with
> correct checksum downloaded later)?
> 
> Right now it just removes the file:
>                         # Remove any incomplete fetch
>                         m.clean(ud, self.d)
> 
> The problem with this is when upstream repacks some archive I would like
> to be able to compare old tarball and new one.
> 
> My proposal is to add md5sum of downloaded file to ChecksumError and
> rename it to <file>.<md5sum> in "if isinstance(e, ChecksumError):"
> 
> Does it make sense (should I send patch for this)?

I'm fine with that.

Cheers,

Richard




