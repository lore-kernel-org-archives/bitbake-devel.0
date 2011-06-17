Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1QXOPO-0001WI-F5
	for bitbake-devel@lists.openembedded.org;
	Fri, 17 Jun 2011 04:03:42 +0200
Received: by pzk36 with SMTP id 36so1596670pzk.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jun 2011 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=AXLU3P5GGuL4MvnOqavJykIeG1SjJeIcIWbySdtwTmI=;
	b=btW5lKeOmoZgpjoAJGHeOJ3P646lZB9rYA4ogIT8fgK46K2ZKbxM8FjAMtZ3pIR8/p
	4I7K/KrGrcVLsFSu4kDdmoNrWK0uOIXd/+HoU+4Rw01lIu8lOTLChMBAq49Br0ehsOVr
	ZAqoFHzOiOpAMbnQ45zx0Vuq6jlvdPF4DKhmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	b=DS3BOSHba5wX40LEQRmcGVC1o8es/XimU7fPtmt/asXG49d8J62mDJdnbMi39RuaVA
	FM1AIyHxVxhuKteFUAtoJ0aFtylqqUk6EzzPkVf7ZTB7C4Fo1o+R3U2BtFVZg1J5x2/x
	K0xI+94U9fO0azntK0hmiYJKF9MJ9gNeexQkg=
Received: by 10.68.51.2 with SMTP id g2mr885873pbo.495.1308276013359; Thu, 16
	Jun 2011 19:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.55.195 with HTTP; Thu, 16 Jun 2011 18:59:43 -0700 (PDT)
In-Reply-To: <1308232450.15712.436.camel@rex>
References: <1308232450.15712.436.camel@rex>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 16 Jun 2011 18:59:43 -0700
Message-ID: <BANLkTi=E3enTWWdqH8v12Zf4v4HcymtKwA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Couple of nasty bitbake issues
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
X-List-Received-Date: Fri, 17 Jun 2011 02:03:42 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 16, 2011 at 6:54 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> I like the none server as its simple to debug. At present its looking
> like it might be too ugly to fix this though. My hacks are:
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/ml&id=a3a130b3c6ca760066ca830eb46fa472ecb84c88
>

FWIW I was seeing a weird behaviour on one of my machines that  Iwas
discussing on IRC today where bitbake was freezing my system and that
issue seems
to be gone with this patch too now I can bitbake can happily run two
jobs simultaneously


> Cheers,
>
> Richard
>


