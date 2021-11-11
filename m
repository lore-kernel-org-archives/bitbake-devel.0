Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34615C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 11:16:46 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.9097.1636629403029161984
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:16:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ReViK8Ca;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id c4so9146680wrd.9
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=LkOFXCQ5o/GkpmXMQWQ65yQvIV5wwmuakyb23GT0FrU=;
        b=ReViK8CaO0dCP1DVaL6odiKzZccldcvf1S2L4lxEyJIsRr3jySF53Lwl9s46TXM/4h
         ee8sTibiZpXEt6Zfx+DZc9BCaBQCu/iHSC5eu+1izDIKrTEtKLiz9xJzF4n94wyWbgOM
         x9ewRxHKliIoZtFMXN5WpJFCH8LAMVZ2WXw1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LkOFXCQ5o/GkpmXMQWQ65yQvIV5wwmuakyb23GT0FrU=;
        b=vBjeuQf3/nwelJhc5Kq2qeRsvNzQfnP0erLNdYVyIQPYTEm5xvJEk4mruuj66xOTMT
         uG1bJ3BRGzIzoaZtkYlAATCRRSVq4/30DmnpPLeu8qaRHK5+5CTRFs0fXNI2rphOFmKS
         WgeCB6Yj9cXiPocqbwmYLCLJukmZQ0ADA01Z0qC3aOokpP1KMmVUsM6hUSkCR4R5kN76
         slXNhuAN5eQscXme2uuOpegU9ZAg0Ce9X8bk9qzdBcK1xNW6WsAEt2lNG6m537crgEIw
         Nf6Z0+rg7vTVc9R0IIOTa/qKZtd6p9dLpB1UpfQUoxtdNXtCEQzFOIBP46Z3sO43tZUw
         MCFg==
X-Gm-Message-State: AOAM530PAHGMr5t1Y0suq+PLcaSftCatcrBpywRGCjfKhmeFvB7ou/EZ
	MNO+M3j2bMNZ7FJPc7pRbM5SDQ==
X-Google-Smtp-Source: 
 ABdhPJyFQ0xSHSssh17lCW2e+L9SIEmYO71+lXXTDdm1KcU3BZ2bPemCimKW0TBva/2LnG+LVP2urA==
X-Received: by 2002:a05:6000:1862:: with SMTP id
 d2mr7717617wri.251.1636629401204;
        Thu, 11 Nov 2021 03:16:41 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:b19:11f4:a3d9:cabc?
 ([2001:8b0:aba:5f3c:b19:11f4:a3d9:cabc])
        by smtp.gmail.com with ESMTPSA id
 a1sm3224300wri.89.2021.11.11.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 03:16:40 -0800 (PST)
Message-ID: 
 <1b791d5c581038f715d80a4d47a7c74d0b367a36.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [1.52][PATCH 5/7] cooker: Handle parse threads
 disappearing to avoid hangs
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Anuj Mittal <anuj.mittal@intel.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 11 Nov 2021 11:16:39 +0000
In-Reply-To: 
 <446269bcf62addbe55f6abee3b81a882f2fe2b94.1636469164.git.anuj.mittal@intel.com>
References: <cover.1636469164.git.anuj.mittal@intel.com>
	 <446269bcf62addbe55f6abee3b81a882f2fe2b94.1636469164.git.anuj.mittal@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 11:16:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13009

On Tue, 2021-11-09 at 22:50 +0800, Anuj Mittal wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> If one of the parse threads disappears during parsing for some reason, bitbake
> currently hangs. Avoid this (and zombie threads hanging around) by joining()
> threads which have exited.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit dc86a533d951d13643ce446533370da804782afc)
> Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
> ---
>  lib/bb/cooker.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 06b40c138..8ae8e4ecc 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -2040,6 +2040,7 @@ class Parser(multiprocessing.Process):
>                  result = pending.pop()
>              else:
>                  try:
> +                    time.sleep(0.25)
>                      job = self.jobs.pop()
>                  except IndexError:
>                      self.results.close()
> @@ -2218,7 +2219,7 @@ class CookerParser(object):
>              yield not cached, mc, infos
>  
>      def parse_generator(self):
> -        while True:
> +        while self.processes:
>              if self.parsed >= self.toparse:
>                  break
>  
> @@ -2232,6 +2233,14 @@ class CookerParser(object):
>                      raise value
>                  else:
>                      yield result
> +            for process in self.processes.copy():
> +                if not process.is_alive():
> +                    process.join()
> +                    self.processes.remove(process)
> +
> +        if not (self.parsed >= self.toparse):
> +            raise bb.parse.ParseError("Not all recipes parsed, parser thread killed/died? Exiting.", None)
> +
>  
>      def parse_next(self):
>          result = []

This patch changed a bit in master due to issues being found so we'll see to
include those changes in the backport.

Cheers,

Richard


