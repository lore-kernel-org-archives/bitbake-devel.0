Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.4969.1592911995093238615
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2020 04:33:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iZFsjrqK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id y20so2841472wmi.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2020 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ZG3MplxDmobcXxLFz6O75Zu5OTr3Rgkzxpdt9NIt+2M=;
        b=iZFsjrqKvYcZbA3NMR9+ZUGijzaWVYl9mPAD3qHZFg9gDnMPVt5ONTGhUqodAPbNV8
         agxpk/tkXSl3D7A8yNEISPVqO8GwZMz1Ib3lpTKEf1cTT2m5CuFk6fDF3QwaLXuhwfpQ
         O/DwPQKuT2pyKt+vpRlYw2AxMcgiQVoB2q/I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZG3MplxDmobcXxLFz6O75Zu5OTr3Rgkzxpdt9NIt+2M=;
        b=DwR1/fPpwU4lCXgR19pIQG4PTs16NPnCWCFF4JS4jJSw5mo6bD8y8QdXagHZCp09v9
         nMZHVUWbgjJET2jiXGrtyoPUQGyVtrWAs534TnBlmCSAytjXDkdXKSS/nPCVbapCFQJQ
         uJa10R2NMAxG+fuTpYohqOusWNJBE3/C3/w+e1phBjCXjLWkNq1i+QWW3nMCiqIkPgTa
         sVGZwUa1fUCtpZnP+zuHdq61uJsqaOIvDL5LcnF7Y3CAPepJ7FZcbOrQT0pUBWJCF/uF
         DFaMGG/IOvE1UV0NmFOY0J51Luu6y9DKN2cms+PiFl3e9JnqjLIuTRqoixnzvQwMXkDj
         a0Dw==
X-Gm-Message-State: AOAM530sv0gj3whe2MafQarbNYmzQY4ct0LxnAHoKkn976K1EqYyUhro
	n+Pfp1zzLrcTiBMuGNRH4/GaVLrqtbrLxg==
X-Google-Smtp-Source: ABdhPJzBLRG7s7qyxxwHPJgB+ChOG8GBlsRQBkv49pFDw7bvQHVByDuETF9/2meSzd6mOjIRZ4uw6g==
X-Received: by 2002:a1c:55c4:: with SMTP id j187mr21775032wmb.120.1592911993451;
        Tue, 23 Jun 2020 04:33:13 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id a126sm3306580wme.28.2020.06.23.04.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 04:33:12 -0700 (PDT)
Message-ID: <261388b816dc096efaf49329597f8a6c52c73685.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] SSTATE_MIRRORS uri format
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Phil Reid <preid-l@electromag.com.au>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 23 Jun 2020 12:33:11 +0100
In-Reply-To: <85456da9-ddd5-7054-32c7-93b9b7467020@electromag.com.au>
References: <85456da9-ddd5-7054-32c7-93b9b7467020@electromag.com.au>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-23 at 12:37 +0800, Phil Reid wrote:
> When setting up a SSTATE_MIRRORS with a https basic auth I had to
> use:
> SSTATE_MIRRORS ?= "file://.* 
> https://<ip>/sstate-${DISTRO_VERSION}/PATH;user=<USER>;pswd=<PSWD>;"
> 
> Instead of what seemed to be the documented format:
> SSTATE_MIRRORS ?= "file://.* 
> https://<USER>:<PSWD>@<ip>/sstate-${DISTRO_VERSION}/PATH"
> 
> I run bitbake with -DDD and it locked to parsing the user / pswd
> fields with the second option.
> But it never actually connected to the server.
> 
> ie this debug message was showing the user/pswd being decoded.
>      logger.debug(2, "For url %s comparing %s to %s" % (uri_decoded,
> uri_find_decoded, uri_replace_decoded))
> 
> This is using tag 2019-10.3-zeus, so may already be fixed, or I'm
> reading the wrong docs.

I suspect most people don't use sstate mirrors with basic auth so its
not something we have much experience of. I'm not aware of any changes
which would fix it unfortunately so its probably a case of looking into
the code and debugging it.

Cheers,

Richard

