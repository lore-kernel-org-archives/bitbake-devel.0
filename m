Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 923D77BDF1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jan 2019 07:01:06 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c14so35756937wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 03 Jan 2019 23:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=v9TCXC6OkWaZv1EFwD9AKZnCA770+mh+vMcSfiOP3Bc=;
	b=QWYXFDbZ8JmMFOIjcaHF6oQjw6UoSA+GxKnK1p+O7SEruEYXxg56z0w3APw/3YHCVF
	qG1eVZRswofgi0kD3uxwXkh0+t6EhdBxtDkZbUJdhUU2/Gk/Mmxf1h951iBz8x7C2mLw
	7Lqdyru/g0T9IfzkanpGHy2dP/0wIfJTPCnzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=v9TCXC6OkWaZv1EFwD9AKZnCA770+mh+vMcSfiOP3Bc=;
	b=Kw6nOuLOaxsshV9M+rm3aiHl4IPCxdHSOui6/Jo/aNTi9G67UNo7AW8I3ZyELQQLQ7
	A0KVAVnMEoWgnEz+IUWbtN7gRT4gEyXMuuxb1wNiX+Ix8h8v+rp7bhFk/65wUN1H91xY
	WImwneDQstgqhBEB6ISooilKlZyCuDIBsURKQj6W+k8wrUekK9i4Jm24C9gECK4qUBma
	sfRgqFwkxeuChrgkku2CtkBhlgUGTvW6h6VBlRxAMYIY6lm1uKv2BDPxjOQ9v/uyEWCU
	8DpuL1jNWMVTH4MHP9jWJL2c66SBgIvql41ouPhWRQXXF8ydphihm0S7pCz2hXpUgcsi
	rx3Q==
X-Gm-Message-State: AJcUukfh7O+oYG8eUv2aXVtkUSquQ2Dk9wFmuiWaIOeQpkmabIFqBYD9
	lUE/AL/7HFKjoKrzExDhM61mrA==
X-Google-Smtp-Source: ALg8bN48rfOzbFXBixzpIaF7VNVcBt4kXs+b7rInrZCR+aF7re8+ReQEsAE5ufqmConBn3JRS9kTfQ==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr47118800wrr.285.1546585267274;
	Thu, 03 Jan 2019 23:01:07 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id q9sm63100780wrp.0.2019.01.03.23.01.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Jan 2019 23:01:06 -0800 (PST)
Message-ID: <83f1b423063182e4b6246650f0d7949712fe3e37.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, 
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Fri, 04 Jan 2019 07:01:05 +0000
In-Reply-To: <20190104024217.3316-2-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20190104024217.3316-1-JPEWhacker@gmail.com>
	<20190104024217.3316-2-JPEWhacker@gmail.com>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Subject: Re: [OE-core][PATCH v6 1/3] classes/sstate: Handle unihash in hash check
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
X-List-Received-Date: Fri, 04 Jan 2019 07:01:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-01-03 at 20:42 -0600, Joshua Watt wrote:
> Handles the argument that passes task unique hash in the hash check
> function, as it is now required by bitbake
> 
> [YOCTO #13030]
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  meta/classes/sstate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
> index 0abebce6996..8f3cd083e85 100644
> --- a/meta/classes/sstate.bbclass
> +++ b/meta/classes/sstate.bbclass
> @@ -780,7 +780,7 @@ sstate_unpack_package () {
>  
>  BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
>  
> -def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
> +def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *, sq_unihash):

Sorry for not replying sooner, I've just remembered the question I had
here. Does this "degrade" safely where a old bitbake is used with a new
version of OE-Core with this change?

In the past we'd have done sq_unihash=None or similar and handled that
correctly in the code to ensure it did degrade safely...

Cheers,

Richard




