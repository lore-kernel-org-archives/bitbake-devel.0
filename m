Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 67CA77DB52
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 19 Jan 2020 13:17:38 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id d73so11743111wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 19 Jan 2020 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=4s9W9nmcfq0QE14qirA+tkjlVOU/wbzu4nOcmU141NU=;
	b=GzI/YqDiMN2lPOxxNBQ4jmn20biFHQLBRHiNmRUALWVlsbXq2rShb/Bdw2PxagRSr6
	CbvNONITP5H0yOP0YhhTfJb9U5R39kQPd9Bm2EdqrEHCCGlS91obZ1uD+nkryMIXy8AO
	HA7e81rPErXiq5Ik6HPamWKkBiUqQEtedbrn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=4s9W9nmcfq0QE14qirA+tkjlVOU/wbzu4nOcmU141NU=;
	b=HMmkIwosBRrpl7jI2DLxme2Qk52ZevalcwOHZ1sswfoVwkeSuj6CMNCx5lMHG90ABw
	onpLfA//aH0OJcfun7vdbuvpDGujy/2Od9XndfkOwefokj+D4O9wZRcOWFkqNsgc7YSG
	oGY3SD9/SW2Ryuy2TWIC1ZcYtL+QRoww2/Hgz2kuMx1uz9CHpjB9QDNcC1NKBzCjI6Uo
	T+KTdBfDomnhetQXJJlfuRDVTwaNlBOuSJSiO0RHBSIwVq/JZYKX0pzpSud1M0/Si3Dw
	nnVccDSJEfuUZsO2MtzyXwE3tSyL4T2oWid+jRxhlHw1ob7dRBdiqmjuS6872imiCioI
	EJDg==
X-Gm-Message-State: APjAAAUra/2d0MGXLd/7TtBGCQVmxAK0MBx9xXkLO8hA5XA/7Asu9FB4
	7gya/6I9pQYvELb9UJeXg+KZuRtWYNc=
X-Google-Smtp-Source: APXvYqy6fiG+B//h+1+uuzRqHYeSbs5hO4IUJJyPtEAv1dMDoEyPWAE+qf4s+Gtp0wz+jMfsn7Tdrg==
X-Received: by 2002:a05:600c:290f:: with SMTP id
	i15mr13802005wmd.115.1579439859255; 
	Sun, 19 Jan 2020 05:17:39 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r6sm44391283wrq.92.2020.01.19.05.17.37
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 19 Jan 2020 05:17:38 -0800 (PST)
Message-ID: <6df3aa1dbea9cf5318482d25cbe3c26a134e3ef1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Sun, 19 Jan 2020 13:17:36 +0000
In-Reply-To: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
References: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] build.py: record time spent executing each function
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
X-List-Received-Date: Sun, 19 Jan 2020 13:17:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2020-01-18 at 22:37 +0000, Rasmus Villemoes wrote:
> In order to have a quick way to see if optimizing some task function
> actually has an effect, add a single line to the log file for each
> function executed listing the wallclock, system and user time
> spent. That can also help figure out which parts of a recipe is
> taking
> the longest and hence find places that might be worth looking at.
> 
> bitbake already has the --profile/-P option, but that produces an
> enourmous amount of output, and AFAICT only concerns python code, so
> won't help finding suboptimal shell functions.

Shell code is executed by exec_func_shell() so it shows up on the
profiles as executed there. The main shell code is in end task
execution.

I'm torn on the patch, its clearly useful for debugging but I'm not
sure we'd want it for general use. This patch will generate a large
amount of data too, its just spread over a lot of places.

As Chris mentions, using self as a variable name is bad practise too.

Cheers,

Richard


