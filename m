Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.8045.1592488575993334608
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2020 06:56:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aEgXK+EV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id l10so6150719wrr.10
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2020 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=R1pFUXwGWqO2DFXlx73NpDmTjHCf46VTqnMCFpHmyMw=;
        b=aEgXK+EVPw8hZL/p0ZOTmhHbaBrfxmyUMqlNCAV80A/YZyYoveO1SMzpKvqlzvcJdD
         dPfG2Dm5tAldYrt7uYIi6300AY3acJJWp6qnij3rQJZ6BZ3dVjZU2zRTBQgUhVPu5Pm8
         SskrMdgZdl5m6uQw6awoVIxdfcBiHnPJSLYvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R1pFUXwGWqO2DFXlx73NpDmTjHCf46VTqnMCFpHmyMw=;
        b=KewQS+Kj9TQJuuIu5qculxfyBLzXrUYlE786j50mZ+O9m3s8fnVBl8fNVwi22OwWiR
         p9C94S9f9AAxsY9UdXINmoeS/VueJWb4LGaTCjZsAwz6x8BiNRDQpvMG9AUj+6fi0dp4
         E/AT/H4i8qrFIIm6eXkazrpKA4U1/0juNpjLdWJXzaopeQGUKtIjMEbLTL5vvYRMJdaD
         Px8gE5vppddZcq7prZ8KCR78jsb4K+07LPxmQOYUWUI+BB31kHc+5I+Qf+37NZ5bCBnF
         XKkBDBJc+3ErfmNumg23JcOIc1V0yes6c/yRGgfR4xGU886Nm8Jo6/Tzzp7YzVJ4YDVB
         Ulhg==
X-Gm-Message-State: AOAM531roATkFkE7N+HVL75Br0VAKzW/3wKqSGDg2URC3csKBg6nrlpt
	/YNxF+UMkzBmw2zxYFc7+x1nwA==
X-Google-Smtp-Source: ABdhPJytOkGb4gRyV4D6Srd1HP5HQeN6IDTckHyXZSWeyb3Xc3INt1JM2dyEWNUAkiD4Qnge8tCxhw==
X-Received: by 2002:adf:8b0c:: with SMTP id n12mr5185983wra.340.1592488574570;
        Thu, 18 Jun 2020 06:56:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id a126sm3628124wme.28.2020.06.18.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:56:13 -0700 (PDT)
Message-ID: <ee1e44d7c61fed40e1b4b8d1c380dadc6532b764.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] BBFILES_DYNAMIC: add inverse mode
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Konrad Weihmann <kweihmann@outlook.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 18 Jun 2020 14:56:12 +0100
In-Reply-To: <AM7PR05MB6881BCFF510297F50FE36E9DA89E0@AM7PR05MB6881.eurprd05.prod.outlook.com>
References: <160AAE7A27E24EAF.22530@lists.openembedded.org>
	 <AM7PR05MB6881BCFF510297F50FE36E9DA89E0@AM7PR05MB6881.eurprd05.prod.outlook.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2020-06-13 at 12:34 +0200, Konrad Weihmann wrote:
> Friendly reminder.
> If the patch isn't applicable for some reason: I'd like to ask how I 
> could 'emulate' the patch.
> 
> If I read the code correctly it isn't possible to do the same as part
> of 
> the layer.conf, as the list is filled one layer.conf after another
> and 
> so the existence of a layer name in BBFILE_COLLECTIONS is dependent
> on 
> the order in BBLAYERS - which makes it prone to errors.
> 
> I currently have some recipes which are provided by some optional
> layer, 
> but as they tend to provide/override more than needed (in this case
> just 
> a single recipe) it would be nice to have that backfill possibility.
> So it's up to the user to choose if the full layer meets his needs
> or 
> the backfill recipe is just enough.
> 
> Looking forward to some feedback.

I wanted to give that patch some thought but it does make sense. Could
you please update the patch or send a followup which updates the manual
with the new syntax though please?

Cheers,

Richard

