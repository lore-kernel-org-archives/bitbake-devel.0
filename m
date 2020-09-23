Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.16207.1600873621953138683
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2020 08:07:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IzlWeAnS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f65.google.com with SMTP id l15so4740792wmh.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2020 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=THO5xlUZRo0CJjR4DlS3WbzI1gBeh5Wsw3UszDZr/0M=;
        b=IzlWeAnSoLVQv/EYkERQGcrhunPgRrsgCZfwFhheOt/Hantjnzmgi2BGmmj+kNCQL5
         t4gdzX/lfgeAxvSTIGZJAGvGLeGvgdZYBNb0hV1XXNCT5dKibuWuZcEIwVojCc11OskR
         1X09YwB8SapfU8I2xzUqKRSe9F5JheMQiyiXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=THO5xlUZRo0CJjR4DlS3WbzI1gBeh5Wsw3UszDZr/0M=;
        b=g2X5Wq9mxgY13daZ/tclZRosMo4sF6hEDtPShVnNRWjwRPCJ6BvnieX1k6+gHdO1/D
         1ahWZDR42mgXzQUMupD+VJbYg1zo8W9rPd3/dcnJjayJWGe7I3ZkMeyI8UfHvHIZqang
         E38ZeWaIcb2OLIOfcB9GOtp10bwSsS4SfN4WU9ShOKy6mAIpxxh9O5/O/i6HhOjcpCVj
         mknySm7lit6HgmymhkWJoSWy8Ge/tjCytf3bAtovZGv0fnxZOhbgwkS1h36VbbcJDhj7
         iTWXUfIOsVsfcg03sQguKvhejHSwiKICnopMXyifDOwoFTOm7oXScvLEKeEgrr6ASeKM
         KC2Q==
X-Gm-Message-State: AOAM532tfmOVS7Is6w/3Me1RQcucouRidkmf4sbzqPp0ak8xTBfsDtPm
	h6alMoSuchtqyvZME07V4oY7sMfE5Pg0vA==
X-Google-Smtp-Source: ABdhPJwriTi9Woo8tIdpG9ppAASJagLFID23uCYXOKhPYVTlO17qwsiH9fm7zGhly1KSfyFzQgzcSg==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr22081wmc.142.1600873620451;
        Wed, 23 Sep 2020 08:07:00 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 3.5.b.6.d.4.1.e.4.a.2.6.1.0.d.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (3.5.b.6.d.4.1.e.4.a.2.6.1.0.d.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:4d01:62a4:e14d:6b53])
        by smtp.gmail.com with ESMTPSA id u126sm142838wmu.9.2020.09.23.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:06:56 -0700 (PDT)
Message-ID: <ed36fb9b7d921afaeee3f83e84d2a521e028dc09.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: fix handling of `\` in file:// SRC_URI
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Leif Middelschulte <leif.middelschulte@klsmartin.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2020 16:06:54 +0100
In-Reply-To: <20200923133253.187115-1-leif.middelschulte@klsmartin.com>
References: <20200923133253.187115-1-leif.middelschulte@klsmartin.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-09-23 at 15:32 +0200, Leif Middelschulte wrote:
> Using backslashes in file:// URIs was broken.
> Either the resolver would fail or the subsequent `cp` command.
> Try to avoid this by putting the filenames into quotes.
> 
> Fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=8161
> 
> Signed-off-by: Leif Middelschulte <leif.middelschulte@klsmartin.com>
> ---
>  lib/bb/fetch2/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 7ec1fea5..1911ecd3 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1520,7 +1520,7 @@ class FetchMethod(object):
>                      if urlpath.find("/") != -1:
>                          destdir = urlpath.rsplit("/", 1)[0] + '/'
>                          bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
> -                cmd = 'cp -fpPRH %s %s' % (file, destdir)
> +                cmd = "cp -fpPRH '%s' '%s'" % (file, destdir)
>  
>          if not cmd:
>              return

Thanks for the fix. Would you mind adding a test to
lib/bb/tests/fetch.py (run with bitbake-selftest) so we can catch this
issue in future please?

Cheers,

Richard

