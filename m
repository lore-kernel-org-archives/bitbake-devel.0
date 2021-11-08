Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6309DC433F5
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 13:32:19 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web08.44807.1636378338069317952
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 05:32:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VKkhK92W;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id o29so9213306wms.2
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=K7iVR8X51zOXd1LQzktStd0kOO0PvhK7u3fEiT2Sqlc=;
        b=VKkhK92WAqylIndTZviOvp+yGeTKeTbyFS7WV+MZL3b5kmPmhxhpZ8RBlkjt1Hobx4
         rd4nhfrJi8CRf2laBSyMZKX5LVCzMbngrg1LTdG+O7PgeDeaCMK1eyQlqJC6vlwK0ecc
         eDkAvhzUenqg8IPBIj+jxFR7EGrDmgM4pBYz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K7iVR8X51zOXd1LQzktStd0kOO0PvhK7u3fEiT2Sqlc=;
        b=HG5vSYCwzg3/TN3+TerwTC7QQCxsJc0eUKVUhOJOG/GNhA68IgA+LbTyjeV4JGBde6
         btP8Ft201UFcYaKVOdsvJMNh6ATTXso2FwpHTyaotQVfYVVfy7gN36h+Omz2ztKOfKH0
         oa1OxYA3Z7f9XTYMFVaRdkR6Fr1E629pOfGSVE2ZqeI2+gwEIdZGFOqrLbK0FRfH1klk
         O2KuOgMjfPtW1n5EHgAfY4+bQLTSy/NNnK3H4hDs/emecz5gJSLUo+q2f6Rd3f3UCNa3
         ELDU2lA7E6d3OQyshwvlBRn4gwTQv24Lyki4SpWgG2wg9cx3+fxDSct8GA5FToGivL/2
         82Vg==
X-Gm-Message-State: AOAM531xESKISST7l/dI8+7cPwl26UfILOdjAJDlQ9Pw/Cynh2JRpjga
	dE0IMT9KSw8UaJ+7jge98JtPnw==
X-Google-Smtp-Source: 
 ABdhPJx7z1RvAaj2l4CRBanZuCqWP0pDKZgBbjt3cmnLf2zas2w82wIb9lO95fy9VBbK+5a6Dbfanw==
X-Received: by 2002:a05:600c:a45:: with SMTP id
 c5mr52501533wmq.79.1636378336372;
        Mon, 08 Nov 2021 05:32:16 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:5c39:dba0:779a:3673?
 ([2001:8b0:aba:5f3c:5c39:dba0:779a:3673])
        by smtp.gmail.com with ESMTPSA id
 x13sm17054050wrr.47.2021.11.08.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:32:15 -0800 (PST)
Message-ID: 
 <357b3cba89e7fa3f1ba9bd300520c69e33b69f76.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bitbake: a cooker is stuck for a long
 time
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: n.papenkov@inango-systems.com, bitbake-devel@lists.openembedded.org
Cc: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
Date: Mon, 08 Nov 2021 13:32:14 +0000
In-Reply-To: <20211026074217.1637-1-n.papenkov@inango-systems.com>
References: <20211026074217.1637-1-n.papenkov@inango-systems.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 13:32:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12942

On Tue, 2021-10-26 at 07:42 +0000, Nikolay Papenkov via lists.openembedded.org
wrote:
> From: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
> 
> bitbake process has a deadlock in cooker.py, function parse_generator.
> The loop expects that all threads will increment self.parsed variable until it
> reaches self.toparse. When a random parse thread(s) are killed, the procedure
> is not finished and as a result self.parsed never reaches self.toparse.
> 
> The fix breaks the loop after 25 seconds of no updates in self.parsed
> number.
> 
> Signed-off-by: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
> ---
>  bitbake/lib/bb/cooker.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index af794b4c42..0c07a073fa 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -2208,10 +2208,19 @@ class CookerParser(object):
>              yield not cached, mc, infos
>  
>      def parse_generator(self):
> +        current_parsed = -1
> +        no_updates_iter = 0
>          while True:
> +            if current_parsed == self.parsed:
> +                no_updates_iter += 1
> +                # Give up after 2 minutes
> +                if no_updates_iter > 480:
> +                    raise bb.parse.ParseError("No updates of parsed items for 2 minutes. Probably parsing thread was killed. Exiting.", None)
> +            else:
> +                no_updates_iter = 0
> +                current_parsed = self.parsed
>              if self.parsed >= self.toparse:
>                  break
> -
>              try:
>                  result = self.result_queue.get(timeout=0.25)
>              except queue.Empty:

Thanks for reporting this, it does explain a few strange situations we've seen
bitbake hung in and gives us something to fix.

I wasn't sure the timeout was the best way to handle this so I had a further
look at the code and I think we can use the is_alive() test to see when all
parse threads have exited. I've sent out a patch, see what you think and if that
resolves the issue you were seeing?

Cheers,

Richard



