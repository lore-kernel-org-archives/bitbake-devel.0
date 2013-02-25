Received: from mail-wg0-f46.google.com ([74.125.82.46])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1UA0AS-0006Fd-79
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 16:40:41 +0100
Received: by mail-wg0-f46.google.com with SMTP id fg15so2465948wgb.25
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Feb 2013 07:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:content-type;
	bh=CdJsnMtbI41ulzAiskdeWGfcSMmdH1bfVw3c2sFyWIc=;
	b=MJZh2/eOtN/Q829oRrBVerWReVtGAG03X4ax8MknqNCjZfyFtKUzNUdYK+euytGLop
	53AonuluQqpobKYwlqNIrVasjF4bcDs7ZP19FDjkuv+IRWw1ZR+LTyJyTiPuptInUZkq
	Bny/iWxvFwRsXqYPiFXYG3vykj+CoCaemx0y++kMQy18XDdCWm75kR5BwtivDJCHzU8W
	T7aHYTqiykQ39aX1gzJu1xR2E7A1CRAUjgsL4ddFbZpJ+Yvi/94tcySz34xEzHU6wqxq
	Us3nwMB0Q7G0vy4Gg6NFzK6rgvlcPKzBHnKLlbyCPczdFadkO4gTHr3bLLVrWUFc1Y5M
	RVBA==
MIME-Version: 1.0
X-Received: by 10.194.58.202 with SMTP id t10mr20064346wjq.4.1361805862341;
	Mon, 25 Feb 2013 07:24:22 -0800 (PST)
Received: by 10.194.45.100 with HTTP; Mon, 25 Feb 2013 07:24:22 -0800 (PST)
In-Reply-To: <512B7034.1030504@mlbassoc.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
	<CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
	<CALbNGRSioFk7F3W9yp_VbHz6sXP-LjUtg0DqJorZmyHt_+J2sw@mail.gmail.com>
	<CABxcv=kdCzvj=Z4GDtYC4P-az9LnT5VhrspRrZq8p568uPo9QA@mail.gmail.com>
	<CALbNGRSZeOC0Tyv1-x6og6g+HOD148PUdCWcONYBE_YUQ7FASA@mail.gmail.com>
	<CAHUNapR3-Z57mPUScW6TnptFbawE3y=+bCcpnTVVfAy-2KjwjA@mail.gmail.com>
	<1361800868.25338.79.camel@ted> <512B7034.1030504@mlbassoc.com>
Date: Mon, 25 Feb 2013 10:24:22 -0500
Message-ID: <CAHUNapSfZZA07Hg_Og+41uRweR-WsXLrkodj8_Dsdj=ZP6c2AQ@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [meta-ti] trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 15:40:42 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Feb 25, 2013 at 9:07 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> Additionally, the problem is that tags can move and the revid
> will change.  Hence the need to probe the source GIT for the answer.

If a tag has moved then a

    $ git fetch --tags

would update your local tag refspecs with the updated information, wouldn't it?


