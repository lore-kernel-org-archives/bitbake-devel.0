Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04BEC433EF
	for <webhook@archiver.kernel.org>; Tue, 22 Feb 2022 11:52:06 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.11864.1645530725583792877
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Feb 2022 03:52:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Axme1/j3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id d28so4918593wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Feb 2022 03:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=34G7du+U4I3ltrwsMIa68oDEjgS0bTh9DjxSI2ZFPhY=;
        b=Axme1/j32OhE8vpRhih+1kePtG2JWFvz6+TSvatdVsFwefGXV5NfNDAMSl3rCSkYL3
         WBjpRYeW/mM0SsbBKXuE+WGCEvayFD4yxLb2C4ITh2fqszToXN0Si9PaBZJClHMb+/OE
         JMQsMpveb85MVONHBgwxTXZf8fhZS8m1gP5/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=34G7du+U4I3ltrwsMIa68oDEjgS0bTh9DjxSI2ZFPhY=;
        b=K5gj51h2kOlRD9gmyllOamzsY3tcWrdFfEefhTQMC9Am33x4Gdm3x4ZcaodWQhrtBc
         hwkpzLTCZvGrbcgrxP3vhaRafoQ8pIJ9tb6t5QMRCJWru5pj/7HF+Gp4D1dBsqzdzdNB
         WJn0NyN0XKYhcaYWO2liQ7UNDsL7iQ60t7iysdSoTxn3ijIvHkuqTewTh8tsLe8psNIn
         XxIUBLteuw+g+jP/pQu5fE7gGW972MCX6Mgx+En7rlFVI06h8AE3r8/hqXYffkVh8zfO
         1NN0rdmFgZ6OifHjZ1XmiqcOhgI5rSGll+2eHaBTvg3ZhEQvE+enAdBFO9ZCsSheP0JE
         6nVA==
X-Gm-Message-State: AOAM533vZTHdsMal2CbiDngGctdJbee9kpOv7TpAhAEG1zpJKHFlpF6R
	C0I3H0Phd8HPTLtYV1nb3+hIuA==
X-Google-Smtp-Source: 
 ABdhPJy+U6sdFul4H25JlvoUKLq2UZ0w1Cza1mn78MLCQO3C7AKgHWfSgkuqBtrTv2h0+ijsM/yKOA==
X-Received: by 2002:adf:ec11:0:b0:1e6:352b:6027 with SMTP id
 x17-20020adfec11000000b001e6352b6027mr19166528wrn.702.1645530723943;
        Tue, 22 Feb 2022 03:52:03 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:26ce:ff82:5c7d:d03e?
 ([2001:8b0:aba:5f3c:26ce:ff82:5c7d:d03e])
        by smtp.gmail.com with ESMTPSA id
 az13sm34147294wrb.39.2022.02.22.03.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:52:03 -0800 (PST)
Message-ID: 
 <284cf7b4c470a91994a506d829a02b226b9b6a46.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Avoid exceptions for non
 string data
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 22 Feb 2022 11:52:01 +0000
In-Reply-To: <67fa258b-14ac-0ade-3851-5c632848a396@theobroma-systems.com>
References: <20220222113813.3213276-1-richard.purdie@linuxfoundation.org>
	 <67fa258b-14ac-0ade-3851-5c632848a396@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Feb 2022 11:52:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13399

On Tue, 2022-02-22 at 12:50 +0100, Quentin Schulz wrote:
> Hi Richard,
> 
> On 2/22/22 12:38, Richard Purdie wrote:
> >    File "scripts/lib/checklayer/__init__.py", line 49, in _get_layer_collections
> >      ldata.expandVarref('LAYERDIR')
> >    File "build/bitbake/lib/bb/data_smart.py", line 1007, in expandVarref
> >      if referrervalue and ref in referrervalue:
> > TypeError: argument of type 'bool' is not iterable
> > 
> > We inject True values as an internal sentinel to the datastore, fix
> > this codepath to handle it.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   lib/bb/data_smart.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> > index e7047d79ca..8d3825f398 100644
> > --- a/lib/bb/data_smart.py
> > +++ b/lib/bb/data_smart.py
> > @@ -1004,7 +1004,7 @@ class DataSmart(MutableMapping):
> >           value = self.getVar(variable, False)
> >           for key in keys:
> >               referrervalue = self.getVar(key, False)
> > -            if referrervalue and ref in referrervalue:
> > +            if referrervalue and isinstance(referrervalue, str) and ref in referrervalue:
> 
> I assume we can remove the referrervalue check? If it was about 
> protecting from None value, isinstance() will return False. If it was 
> about '' string.. it was never needed in the first place since it's ref 
> in '' which would always return false (provided ref is never '' too, but 
> that was not covered by the current condition anyways).

True, we could have done that.

> Otherwise... can't we just have referrervalue = self.getVar(key, False) 
> or '' ? so that it's always a string?

No, since getVar could return a bool or int.

Cheers,

Richard


