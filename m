Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id AC03D7D431
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 10:50:12 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id n25so9867722wmk.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Apr 2019 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=/GmInR8grk/oxPYyuTZN9nAyw68olFekOhgqQkDAzkE=;
	b=QBN53QeLspumtvDrOeye/p50SGT0etg/mDZQhC44+lL4nqSp4W2CaUIyRazf+yLfDI
	ujIPpBB8fJ0+Ewd/grrYVdIjmFPWqdukhmST7YJHP+mELb52ZOpHMv4SAD7oMDfHIYqJ
	2H1Ogqbl2laNvS4Qh2b3yjhp938T5asmp2YRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=/GmInR8grk/oxPYyuTZN9nAyw68olFekOhgqQkDAzkE=;
	b=NRbnFwSzDmN1MlPV13OFencqVfOBy4ZzCwnFFYR2QebIbRKfIKrqn1bqSYNw4mQWnu
	8VjZ2pauvXSm5wIX9UizdaQKIqtXJRZh3v73zjs6X7nmoyWNp3FcxscQMwzLN8IySCGy
	ynelA9Ifm8+F/ouUE7RHCJGopyvMtENzclSJ6h6nwAqpAurLLmf+OYKnESk0Y55gShrm
	0Bfi7rblpNBFcTloMv1P+9pilh3F7eOEvJQMj2Ek8AZEqszr8l1h/gx4sX3FCjbdPki+
	e9ozl5QY3sFEATPHmUKM1DJmXPzBHqZ2iGYloCGvOcWXdC5iZqNFj59cpcvXHCmrMHeV
	XcbA==
X-Gm-Message-State: APjAAAVrESUa1b3SFbn4HIccso7VAsLD/IOgv7CxpC8iKb2PSO2K/ZAm
	0uK9a1yHgIfTJldXSlcUNvxsh1eW4tg=
X-Google-Smtp-Source: APXvYqyzqclTTx7CKPXSjJzPxEq/CZxB2nsntV/SxYCyUa650hUuxmUiq1JlkvM9G5G6OyQd4mUM9Q==
X-Received: by 2002:a1c:2ed7:: with SMTP id u206mr2936190wmu.5.1556189413524; 
	Thu, 25 Apr 2019 03:50:13 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	192sm30203785wme.13.2019.04.25.03.50.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 03:50:12 -0700 (PDT)
Message-ID: <9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 25 Apr 2019 11:50:12 +0100
In-Reply-To: <d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Thu, 25 Apr 2019 10:50:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-04-25 at 18:01 +0800, Robert Yang wrote:
> The following command is incorrect, but was ignored silently, that may suprise
> users:
> 
> addtask task after task_not_existed
> 
> This patch can check and warn for it. It would be better to also check "before"
> tasks, but there is no easier way to do it.
> 
> [YOCTO #13282]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/build.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 7571421..861e9a9 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -815,6 +815,9 @@ def add_tasks(tasklist, d):
>          task_deps['parents'][task] = []
>          if 'deps' in flags:
>              for dep in flags['deps']:
> +                # Check and warn for "addtask task after foo" while foo does not exist
> +                if not dep in tasklist:
> +                    bb.warn('%s: dependent task %s does not exist!' % (d.getVar('PN'), dep))
>                  dep = d.expand(dep)
>                  task_deps['parents'][task].append(dep)

I can't help wonder if this change has races, depending on the order of
the addtask and deltask expressions. Do most layers parse cleanly with
this?

At one point bitbake did support "floating" invalid tasks, I can't
remember if we changed that or not though.

Cheers,

Richard


