Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 0F39A7F65C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Nov 2019 13:59:39 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id w30so3214189wra.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Nov 2019 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=6Lkml6GWCpl1lcXh0R4bGXS5SQylvzRi6fkrgaKl/ag=;
	b=GiCLe+Ab4MIJBUCHGPQhN2NeroGoXvgPn6RJfTz/n4vxNwHfmwyAPyl9rYfO8rjDVj
	cCjDzNW1T0mGcdmsbuGWWNgKrCYOO4KKgBIFCUJ7zEVA+PiscCgLAKmB+SFN+Oo3Y9GU
	vgHNMOD6nVWcSQsInFmPSwqfLbi1QYYVKV/Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=6Lkml6GWCpl1lcXh0R4bGXS5SQylvzRi6fkrgaKl/ag=;
	b=dM4z8LF7KPmk7vHT3F2H3Iv1ju9i+1Nx6up4VMEfmTQs1aVyj6FUdCg7ugmvM7e7LJ
	seQ8g1VIxE6pxTj+XjGBrdtmPXCUrrjHYK4dyofyS+wmVfzdMTntq1tJGyWLasvrlkdH
	QE0qEMCoN3S4lykk27D5A0qTkXjfVu/7C74Fe1So1+Wj2azFAINGdMtfnHW9bogUpaFA
	JTrseCtUeXN0vdts4iFvibCTpyL7hqee0UhY4f2OebFQBHpXO9G5GY1LRDQCrbUFPc12
	mzvI/htKJpJLkrXtyAlFTIyJqbv4udc9zSpL9lIh6AISPqcq4hlnSfyvuLSl/uwhKzZx
	iflA==
X-Gm-Message-State: APjAAAUXHJDziGyIpbqnI+q9YLoMa9Uuv+j/BmB6pn6Y4eZOZ6EJlxOL
	W+AA8E6M8Tl0RzITOmmRTVGhzWEhYb8=
X-Google-Smtp-Source: APXvYqz/iSP8ibFVymK+ky3FQTZAbbnxGk/10z8bd26QRNCrcyEabJgDn97OBW0I7wA5zS8diwY58Q==
X-Received: by 2002:adf:f945:: with SMTP id q5mr2972512wrr.33.1573048780640;
	Wed, 06 Nov 2019 05:59:40 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j14sm19247914wrp.16.2019.11.06.05.59.39
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 06 Nov 2019 05:59:40 -0800 (PST)
Message-ID: <a7d2e4d1fc68a814c6b1709ab97c381deb05d4b1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ivan Efimov <i.efimov@inango-systems.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 06 Nov 2019 13:59:38 +0000
In-Reply-To: <20191105140703.29122-1-i.efimov@inango-systems.com>
References: <20191105140703.29122-1-i.efimov@inango-systems.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake-worker child process create group before registering SIGTERM handler
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
X-List-Received-Date: Wed, 06 Nov 2019 13:59:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-11-05 at 19:07 +0500, Ivan Efimov via bitbake-devel wrote:
> The bitbake-worker child on the SIGTERM signal handling send the
> SIGTERM to all
> processes in it's process group. In cases when the bitbake-worker
> child got
> SIGTERM after registering own SIGTERM handler and before the
> os.setsid() call
> it can send SIGTERM to unwanted processes.
> 
> In the worst case during SIGTERM processing the bitbake-worker child
> can be in
> the group of the process that started BitBake itself. As a result it
> can kill
> processes that not related to BitBake at all.
> 
> Signed-off-by: Ivan Efimov <i.efimov@inango-systems.com>
> ---
>  bin/bitbake-worker | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

That could explain a few things, nice catch, thanks!

Cheers,

Richard


