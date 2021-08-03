Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web08.2684.1627981998351873966
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Aug 2021 02:13:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TMO4Pkx9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id k4so12046043wms.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Aug 2021 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=T/EjWbqo4u13Ym6Yb9LVQ68p3Ox6kZRQIMQhvFzL3N8=;
        b=TMO4Pkx9+nSJJ8Yg0KuVzz3ZroHERdqST7fc3x3GqBCZW8SCzcNj1ps5G8IDte6h9G
         4NQKmqmbi5DxwuPAuV7lpLN4ZBlwRtvZahr+HXtjlr6571dGxbu+4OF4W8YOKokgy3eH
         JzYC3NVwZ1ymGP2rV97MRNnwwTwjeesKwRZXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=T/EjWbqo4u13Ym6Yb9LVQ68p3Ox6kZRQIMQhvFzL3N8=;
        b=LRztl1ujTzRQOuzrRz/J0/kZmgkhm8EMGeoKS6RMIiYgBCXKiDeGnzBeytRpy+7uZ0
         SdmU5piB1KIZ8gFTwQgQY7cj8gsBbYUWWLVXztxsBZo/W3eCiBnFZWQ9JdSM2f//CM3c
         VsXhNqe3z1cY4i4a+gk+7yXAWt44FLl0uNnculrcAyU16meJwDUJGiN7NGxr5e8WWprF
         U0os0VwVVb581cGpFY0Unvyacu751MayxOvx5bYekdTF1EdP0Ak8K72zjRjNKwPlf2XQ
         c5OIko5snzcfsRyM3BlAkZzLQiMeYDs7QIN7cV0deXCGCGbuV+EYJxjZ58LlH0Aq3lME
         tvFA==
X-Gm-Message-State: AOAM533Cef/e35gLPL2zNOJGNW0P7eTBOFNoBa15MMheefaAREiMoFUt
	VdsmcV86GI6XeN9phIWjFKEjvg==
X-Google-Smtp-Source: ABdhPJz1+d7tVtrwveTO+axmnO6BaEOQu8O6QX1DSsaPdGS7W8TPV+IGgNtB4iMyJPDDSEGZ5VtbcA==
X-Received: by 2002:a7b:c00a:: with SMTP id c10mr3222049wmb.100.1627981996781;
        Tue, 03 Aug 2021 02:13:16 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:4fdb:827:88eb:62c7? ([2001:8b0:aba:5f3c:4fdb:827:88eb:62c7])
        by smtp.gmail.com with ESMTPSA id n18sm12660493wrt.78.2021.08.03.02.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 02:13:16 -0700 (PDT)
Message-ID: <fb84716be712e7708d2e45ee14ac62b674b93a48.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Fix inactive overide accidental variable value corruption
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 03 Aug 2021 10:13:15 +0100
In-Reply-To: <4331c60640d446eaba8788dd4fcf3009@axis.com>
References: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
	 <4331c60640d446eaba8788dd4fcf3009@axis.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-08-03 at 08:39 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Richard Purdie
> > Sent: den 2 augusti 2021 17:42
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] data_smart: Fix inactive overide
> > accidental variable value corruption
> > 
> > Setting something like:
> > 
> >   BAR:append:unusedoverride
> > 
> > should cause BAR to be None, not "" which was what the datastore was
> > returning. This caused problems when mixing variables like:
> > 
> >   RDEPENDS:${PN}:inactiveoverride
> >   RDEPENDS:${BPN}
> > 
> > since key expansion would report key overlap when there was none. This
> > is a bug in the datastore. Fix it and add a test too.
> > 
> > [YOCTO #14088]
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/data_smart.py | 8 ++++----
> >  lib/bb/tests/data.py | 5 +++++
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> > index 43e9e78555..65528c6ae6 100644
> > --- a/lib/bb/data_smart.py
> > +++ b/lib/bb/data_smart.py
> > @@ -750,8 +750,6 @@ class DataSmart(MutableMapping):
> > 
> > 
> >          if flag == "_content" and local_var is not None and ":append" in local_var and not parsing:
> > -            if not value:
> > -                value = ""
> >              self.need_overrides()
> >              for (r, o) in local_var[":append"]:
> >                  match = True
> > @@ -760,11 +758,11 @@ class DataSmart(MutableMapping):
> >                          if not o2 in self.overrides:
> >                              match = False
> >                  if match:
> > +                    if value is None:
> > +                        value = ""
> >                      value = value + r
> 
> Minor detail, but at least I find this more readable:

That isn't quite the same thing though as for example what if value was 
False?

You'd hope that we didn't have such situations but I coded it that way so
it would cause an error if it occurred, being explicit about the case we
need to handle.

Cheers,

Richard

