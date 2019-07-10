Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail.openembedded.org (Postfix) with ESMTP id 347A074813
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 11:33:36 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id n9so2110244wru.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=em9hxurJE0qRlHUmvHVQxXNyddJJAhsEdIsMEttjuIU=;
	b=dCAJthLHTPz/i0rbj0HAhsKJPRt27sX4LgHyf1NYp6puFSPUgvIKC/+maa561IXo5P
	8HZ9H9BwfJV1hgVZCxyUhu0AGp7h01z03bIREdpeTBaDI5pAMUiBFe3fU80LdmhmPDc3
	89bn02FWYrwDypWgPRPB1G/zjx/57Jshxlk6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=em9hxurJE0qRlHUmvHVQxXNyddJJAhsEdIsMEttjuIU=;
	b=qVmBq6/2tmjBX2Qr6nxZDjYcRPM5c1Pa2jRhgjIQJNE8a0ekofA73MvuOQXJqmwEsn
	A4V4F2RoFoNAjL1MRuM57db6TaM/qysbv97u+H6SprRDU0602nx9r693oYQiT01wzAkg
	uWYgxvJ5UbVuh8AY7DHJ19imrCHQsR+9cB1AEXb5usHi4AsWd3fxR1UEsniOAt+niVMd
	iU1uEdsyuZQIswVrix0MQjvICiTG7hstpIIQfzdNsvoXMNjLqtf/8cnDv5JNo0fLlYEV
	JlvCJMpmMbEBWTWr8pYmUz0Nzih7CEvJTEKW9/Y+ZAgALXV7ZPN7m2BoDnBTgSQB2RBb
	9icw==
X-Gm-Message-State: APjAAAU6GMqb84mHlJhf2D6cwIuwxFo2NGAifpFNHR6XwDE/rgVZ4KIr
	/Prg6oKGStN0iOHSChIKelHTZA==
X-Google-Smtp-Source: APXvYqz78AF+URK1VJQTpCBmBZgoYiUwOIyqTjhtEtT0uebPwYK/Ki8qDVQE518PxqfR1CJTT+BxTQ==
X-Received: by 2002:adf:c803:: with SMTP id d3mr31966106wrh.130.1562758416878; 
	Wed, 10 Jul 2019 04:33:36 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x11sm1330457wmi.26.2019.07.10.04.33.35
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 04:33:36 -0700 (PDT)
Message-ID: <9758178e3d22e58c18d4de719933d5957ea23ec2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ankur Tyagi <ankur.tyagi85@gmail.com>, Mark Hatle
	<mark.hatle@windriver.com>
Date: Wed, 10 Jul 2019 12:33:34 +0100
In-Reply-To: <CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
	<CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
	<CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
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
X-List-Received-Date: Wed, 10 Jul 2019 11:33:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:
> Hi,
> 
> Is there something else that needs to be done in this patch? Or
> perhaps there is a better to handle this?
> I am willing to learn and try it out if original patch is not good.

I think Mark is right, we need to figure out where the %20 characters
are being stripped out and preserve them rather than injecting them
back in again.

The question is therefore where they're being stripped out in the code?

Cheers,

Richard


