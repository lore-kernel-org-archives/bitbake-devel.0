Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 8C7347F4FE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 21:57:00 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z11so341978wro.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=nzbpVSUXStTRqQBseGA10G/uqPtJ/QLXe5JYIvBrgR8=;
	b=ShGRAEOB69gyKiQmrAvvJ/9yeSToWsFaKwefTI2OAMKIYIOhs2ZJ8AvRMemuBsOVC6
	Df0AOH3mp+ffmVZILJygL2tQ52QChQOncqvgqjRbUnr6XcQ9hgdaPQ/FSjjGwYmVt756
	LNQsJVFFiCbKwt551Lc6GXjYWFwTKiKk0V1pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=nzbpVSUXStTRqQBseGA10G/uqPtJ/QLXe5JYIvBrgR8=;
	b=fhN4K7tIT35qklDedDoEjddTgugrbx8XQqGr55yOb4LD5Uu4Y7JVrzOESP+rtX0zuH
	WieJCMELx6CbJRr1Buyjfk6JHXa6oEuPsvTiklinatnhJQmeBAzbA+uoSXZT5m1uDhMW
	JP5fpZbBTMz+ozRfgHqG51IAlo2KQTS4Leqp16q7Xvcsjd/6g78iBZyH21W8XQnxzCai
	9dGc0lFfXlwYJt0RnwFxCgl0vBCZWlSMXW2AtOucwbKeC2rg54DRjObc+4Uu5/bYdbas
	QPBRFX2abXswPUxfE7AypdOEkI9OqqSuJO85x83EYarI+Rf/EVayR5qHzSf2cgcx1POJ
	6Jzw==
X-Gm-Message-State: APjAAAUzgLS/aSCAwzqPd57XMwzCHuRXwSqHUGnnW9k1qYa/5yZYIhjT
	DjoWLuRrRXoQzFiK81TiwpuuXw==
X-Google-Smtp-Source: APXvYqxmRJSiyI6NNDw/A5r9IDoNnxSYvN830T2R9QCJ0l2FqSGIIJVVljCH9VNRECXTM17KXH4fMg==
X-Received: by 2002:adf:e381:: with SMTP id e1mr726100wrm.94.1571867821211;
	Wed, 23 Oct 2019 14:57:01 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id w7sm412317wmd.22.2019.10.23.14.57.00
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 23 Oct 2019 14:57:00 -0700 (PDT)
Message-ID: <cc6a5a34f9ed218f61d1ac6f147a621bea4aacef.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, Ross Burton
	<ross.burton@intel.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 23 Oct 2019 22:56:59 +0100
In-Reply-To: <359289f7-5c0a-1a8f-3584-1b0914fef1a2@kernel.crashing.org>
References: <20191023153339.2313-1-ross.burton@intel.com>
	<359289f7-5c0a-1a8f-3584-1b0914fef1a2@kernel.crashing.org>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake/runqueue: don't shout about hash updates
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
X-List-Received-Date: Wed, 23 Oct 2019 21:57:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-10-23 at 10:37 -0500, Mark Hatle wrote:
> This was from a patch the other day:
> 
> -                bb.warn("Deferring %s after %s" % (tid,
> sqdata.hashes[h]))
> +                bb.note("Deferring %s after %s" % (tid,
> sqdata.hashes[h]))
> 
> Is that also debug, or is it really something to be displayed?  (Same
> file.)

The more of this we hide on the console, the harder debugging any
failures will be. Debugging this code is a total nightmare so if people
want help with sorting failures we will have to put up with some
verbosity for now.

I merged the above since it is useful to know you have an overlapping
build and the code is working.

I agree that bitbake is too chatty about the other message Ross has
posted about but I want to ensure we are printing the useful event info
we need before I merge that or something similar.

Cheers,

Richard


