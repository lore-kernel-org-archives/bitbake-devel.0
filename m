Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C55B265C91
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 10:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA4ApBMZ005878; Tue, 4 Nov 2014 10:51:11 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4OftmVVAG3Qk; Tue,  4 Nov 2014 10:51:11 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA4Ap5aW005858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 4 Nov 2014 10:51:06 GMT
Message-ID: <1415098299.23396.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Gary Thomas <gary@mlbassoc.com>
Date: Tue, 04 Nov 2014 10:51:39 +0000
In-Reply-To: <1415090528.23396.4.camel@ted>
References: <1414430843-27307-1-git-send-email-ben.shelton@ni.com>
	<CAJTo0LbVu4NGfLMOPqV1uSfnL3QLS0=cZCcAd-9ScxxxvTY8zw@mail.gmail.com>
	<20141103154726.GA9716@bshelton-desktop> <1415035858.5111.45.camel@ted>
	<5457C903.2030703@mlbassoc.com> <1415090528.23396.4.camel@ted>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] prserv: don't wait until exit to sync
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
X-List-Received-Date: Tue, 04 Nov 2014 10:51:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-11-04 at 08:42 +0000, Richard Purdie wrote:
> We're still figuring out what is going on but it is roughly that:
> 
> a) The build generates a ton of IO
> b) That IO builds up into a queue
> c) The PR service decides it needs to sync to disk
> d) The PR service hits an fsync() of some kind in sqlite whilst writing 
> e) The PR service is blocked for its clients until the sync() finishes
> f) Connections to the PR service timeout.
> 
> It would be nice if we could write the sqlite data in a separate thread
> whilst the readers continue. There is an asynchronous module but its
> deprecated:
> 
> http://www.sqlite.org/asyncvfs.html
> 
> WAL is recommended instead:
> 
> http://www.sqlite.org/wal.html
> 
> so we probably need to look at that.

FWIW,

http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/t222&id=df0dabbf90f3da7153295adb83e51c41ae4d9375

is a patch Ross is kindly testing for me...

Cheers,

Richard


