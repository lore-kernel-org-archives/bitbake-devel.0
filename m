Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SSTyp-0005MD-2r
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 May 2012 16:04:31 +0200
Received: by qady23 with SMTP id y23so517252qad.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=zAqvfWDAQEJAlu/WHYUcPkjvuwd2Dk/PuQdRtfyGWnI=;
	b=vxH77YqLXAJFC+TOMryl/Eh91Uu1UFnPmFLxX5/Mq70Q//0vCpgR6Rk+tZGKv7P7ba
	4T7nVz1BBYmSb5rYlryo25dpr41ckZTWl5ynOwpZfWpWrpkdd0cpB4ge8zp+RL3xcVtc
	F//dXQDm1RmgOlBW2AC3iz1W0uNY0hvkQTeWlbqSC2A/zR8Um/C0obnz9pEJGxdx13rH
	xvd1bGGuCjh2htmxBRCXQ1iBnMkOUj5uuHr0IrPZsN/1HNF1KGPgCeVIE7WAI1OI1rkT
	Kv+kku7GdNLWRjluerBuDXblpi4l6RIrHt/Qq89kudfDSOssEBcIHVhkWkwoaQfIGFQv
	O3eg==
Received: by 10.224.97.199 with SMTP id m7mr11820947qan.38.1336658075814; Thu,
	10 May 2012 06:54:35 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.214.81 with HTTP; Thu, 10 May 2012 06:54:00 -0700 (PDT)
In-Reply-To: <1336638101.2494.120.camel@ted>
References: <1336638101.2494.120.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 10 May 2012 06:54:00 -0700
X-Google-Sender-Auth: jAHLlP8BfK9VTZJ3amm_RGty3zc
Message-ID: <CABcZAN=7fHg-+qMyh2_u0YN4mnKLX9DPkC0bqVRdwQE6Fh4UbQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake/runqueue: Fix 'full' stamp checking to be more efficient and cache results
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
X-List-Received-Date: Thu, 10 May 2012 14:04:32 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, May 10, 2012 at 1:21 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> This should fix issues where bitbake would seemingly lock up when checking
> certain configurations of stampfiles.
>
> The cache is kept within the runqueue since that feels like the right
> place to associate this cache data.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Looks good to me.
-- 
Christopher Larson


