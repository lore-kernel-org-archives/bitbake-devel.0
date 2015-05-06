Return-Path: <skaluzka@riseup.net>
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	by mail.openembedded.org (Postfix) with ESMTP id D037373D98
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 May 2015 19:22:14 +0000 (UTC)
Received: from berryeater.riseup.net (berryeater-pn.riseup.net [10.0.1.120])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net",
	Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id 7593140E75;
	Wed,  6 May 2015 19:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1430940133; bh=4HkJRw8ANEIwxXWyDWFYmc+mqdQ1JmY1WbA2Pcr3VFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bk6Xo0a5MCVI+vDUU7Wm2//VxjBaSz01z4kHxmoe0/riz9MC4wcZWRR2SXFQk3BG2
	t2Ka6MGA983XAt81Ww9Wifm6bpGJcFBSQ7SNbimDhxWkVfw8/SySOI+BBN40XKRtCo
	zghcf5m9L08a6hS0maEUblYO4zBBOjwLm5MJblOI=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: skaluzka) with ESMTPSA id 4336E400F3
MIME-Version: 1.0
Date: Wed, 06 May 2015 21:22:13 +0200
From: skaluzka <skaluzka@riseup.net>
To: "Burton, Ross" <ross.burton@intel.com>
In-Reply-To: <CAJTo0LZf9g5V_jfOygHmRW4O6vDYXxphMvAmQjd5uVnRwaKfNQ@mail.gmail.com>
References: <ecc3772510e36b5f9a21cdb194fb5c78@riseup.net>
	<CAJTo0LZf9g5V_jfOygHmRW4O6vDYXxphMvAmQjd5uVnRwaKfNQ@mail.gmail.com>
Message-ID: <71cf7b1060ee33bc3bb6267246fdc962@riseup.net>
X-Sender: skaluzka@riseup.net
User-Agent: Riseup mail
X-Virus-Scanned: clamav-milter 0.98.6 at mx1
X-Virus-Status: Clean
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: cannot install bitbake inside virtualenv
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
X-List-Received-Date: Wed, 06 May 2015 19:22:18 -0000
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2015-05-05 12:41, Burton, Ross wrote:
> On 1 May 2015 at 20:48, skaluzka <skaluzka@riseup.net> wrote:
> 
>> I am trying to install bitbake inside virtualenv, but I am not able
>> 
> 
> I'll stop you there - it's not recommended to "install" bitbake so the
> setup.py is probably broken.  Don't use it, just use the source tree
> directly.
> 
> Ross

hi,

ok, understood. actually I did git clone and added bbdev/bin/ path
to PATH variable as it was mentioned somewhere in the docs. also
noticed that dependencies (ply, progressbar) are already there in
bbdev/lib/ dir. it seems to work. thanks

-- 
regards,
S


