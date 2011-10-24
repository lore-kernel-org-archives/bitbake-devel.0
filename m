Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RIOdD-0006Pp-7m
	for bitbake-devel@lists.openembedded.org;
	Mon, 24 Oct 2011 19:48:15 +0200
Received: by wyg19 with SMTP id 19so6665893wyg.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Oct 2011 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=yM2bW1BtAh+9fxY3/4XI/3rxq6lebGXZMq6ldNj7//U=;
	b=vUs/BSj5OfMcS4Od6IaHBDxw4tHB+GYDM56K9o2ZbvCiJwhdogVeHD/z0BvjnpiC3K
	UnD1ODHe0bW/6aC8cSJav9H5kGaM9949vD9AG4mw5qjAf/S5Ee/gEPt9bcwCy2fSkOu7
	kYSf8F0ZqqLsycs7azLasSC39dK/iIAID8Rx0=
Received: by 10.216.229.101 with SMTP id g79mr4115688weq.9.1319478134896; Mon,
	24 Oct 2011 10:42:14 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.28.138 with HTTP; Mon, 24 Oct 2011 10:40:29 -0700 (PDT)
In-Reply-To: <1319474440.26563.19.camel@ted>
References: <1319474440.26563.19.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 24 Oct 2011 10:40:29 -0700
X-Google-Sender-Auth: dEVfOCOlHaqWIDzx4PgDt04F-0w
Message-ID: <CABcZAN=FeRv8Uo5QF=OkyhG-XKL8WW6uOiuXn0dcBfgKtUyyLQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Time for a release of 1.14.0?
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
X-List-Received-Date: Mon, 24 Oct 2011 17:48:15 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 24, 2011 at 9:40 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> This is just a heads up that I think its time we had a release. Various
> factors (including but not limited to my push access to the repo being
> broken atm) have meant I've run out of time before ELC-E so this will
> likely happen at the start of next week unless there are major
> objections.

Sounds good to me, it's definitely a good time for it.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


