Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.144853.1598049679509494612
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 15:41:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HIwRuCEB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id w13so2964892wrk.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=V47NTvZiiI0ld8EmHaQsLL2G6EdEXZ47NarG63ztF3o=;
        b=HIwRuCEByqKBr/94Wzv1HiCE3IAJQuCNtNYp8s4ngTzcZp461uI6myw/kXxKoCVCj6
         BOmqVvuh1/ubgHR6Jdt73M2EnmxLdNhj6GbRgDxQY4JF1w5ZlY6wzdM0npVeO07xCVz/
         aIMNPhEibTQpVJ83YYA0xRP06PNzhVysNm5xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=V47NTvZiiI0ld8EmHaQsLL2G6EdEXZ47NarG63ztF3o=;
        b=mi1FL9tJ8hA98kkRTk0Ryztp0o8cT8f6xdivBeeCaXayXj3TjCVCVq7yOA25G3QaWn
         wOk+JNlfEY4R17n0m/mp4DH1c0GP3VA6V3vp1JN89W+4/e8llB4xRfmhXypoimCPl2Hu
         6n+H7BdpWixP8H1wSgW9kYjKljS8ZT7rpEwXgifAqvjhGPcU4XRb1+My+A1tttdUSQfj
         IQIYIphGQYzT6fC19/spvhl9fAHN3qEe2rSpXi8nuD+tzY5FCsKhWwZA937DdoFIX9Uy
         3s71ixAx1l59XGBoDqJ8aoARxn3SZS03cDmcpZ/zZnaezE4u5LPd0iNB599RECXj4uGA
         vjXg==
X-Gm-Message-State: AOAM5337ZIw9LDg6aS557oakHEIZiFEq9CdL2+lx2qfvN1no3WyLbhuZ
	zBOmXw3oOkw0xSr1omfRoPOP7w==
X-Google-Smtp-Source: ABdhPJzuXWZ0VRTdmolHTnfVvxEVAJKPMvUC+tEQzo/iNCZ01FmRBXc3cfHoacPwzjUdySE0qdsDrw==
X-Received: by 2002:adf:e486:: with SMTP id i6mr4454440wrm.258.1598049677842;
        Fri, 21 Aug 2020 15:41:17 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id v8sm4927393wrm.53.2020.08.21.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:41:17 -0700 (PDT)
Message-ID: <c96fadd369237d98c0ffb1f5168e6b4776f2b95c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Maxime
	=?ISO-8859-1?Q?Roussin-B=E9langer?=
	 <maxime.roussinbelanger@gmail.com>, guillaume.champagne@sonatest.com
Date: Fri, 21 Aug 2020 23:41:16 +0100
In-Reply-To: <866732CC-FB4E-4F0F-853B-1225FBAC9749@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
	 <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
	 <29032972-1F01-4FE9-A3BD-13E1FFD43790@gmail.com>
	 <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
	 <866732CC-FB4E-4F0F-853B-1225FBAC9749@gmail.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-08-21 at 13:53 -0400, Jean-Francois Dagenais wrote:
> > On Aug 21, 2020, at 11:10, Richard Purdie <
> > richard.purdie@linuxfoundation.org> wrote:
> > 
> > /path/recipedir/recipe_verison.bb:do_task
> > virtual:A:/path/recipedir/recipe_verison.bb:do_task
> > virtual:A:B:/path/recipedir/recipe_verison.bb:do_task
> > virtual:A:B:C:/path/recipedir/recipe_verison.bb:do_task
> > mc:X:virtual:A:/path/recipedir/recipe_verison.bb:do_task
> > mc:X:virtual:A:B:/path/recipedir/recipe_verison.bb:do_task
> > mc:X:virtual:A:B:C:/path/recipedir/recipe_verison.bb:do_task
> > 
> > and what we care about particularly is that given a list of these,
> > the
> > sorted() result of the return values is consistent, independent of
> > path.
> > 
> > For example, we should get the same value back for:
> > 
> > /short/recipedir/recipe_version.bb
> > and
> > /this/is/a/long/path/recipedir/recipe_version.bb
> > 
> > so perhaps a unittest which tested that, iterating the above
> > formats?
> 
> Would it be true to say then, that the ONLY purpose of
> `clean_basepath()` is to remove the full path of the recipe?

No, although I was struggling to remember why it does this. The answer
is:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib/bb/siggen.py?id=5a3a7e0f746ad5dd160bc297d8c8b0e770630d89

although these days I don't think we use shared work tasks.

> If true, then could we not simply only snip the path itself, and
> leave the rest in the same order?
> 
> So
> 'mc:X:virtual:A:B:C:/this/is/a/long/path/recipedir/recipe_verison.bb:
> do_task'
> would become 'mc:X:virtual:A:B:C:recipedir/recipe_verison.bb:do_task'
> ?
> 
> That would definitely simplify the implementation and be more future
> proof, would it not?

Well, there was a reason it does this. That reason may no longer be
heavily used but there is a bit of work in deprecating and removing
that shared work support which in turn would allow this to be cleaned
up.

Cheers,

Richard


