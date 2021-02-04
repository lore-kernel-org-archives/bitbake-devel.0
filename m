Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.5594.1612430718509117264
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Feb 2021 01:25:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E72L4T2w;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id z6so2583697wrq.10
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Feb 2021 01:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Kqt5b8A8scWFqchn/JZdyr6Rn7sWqE1oO1uNwyAU0So=;
        b=E72L4T2wuuIti0hNYkQnFq+oZcnTeS1yKuZ6ec7rqYGTSn7/CdvussbUPPIKhROtQL
         ULTQG9bnEGB6FwvxzgUyD+2bhzhx2wG7HMXv3VjRm+gFnf6v7PfwAXhpSzPUlUJxGXGT
         TSYosqgh/ov5hdtIOk0sgInzHGQ/JNL8z4QmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Kqt5b8A8scWFqchn/JZdyr6Rn7sWqE1oO1uNwyAU0So=;
        b=tgUa8g0jvYn4KUyl2+roUip+sevy9nqYQv4xy6djuxNVdFgid41lT7oOmTUyZPC+Jf
         BlNQFEzMrIoKl3xdmARZGzGkZK8lYPQvsyflv1DEU19gjDCjIkmFv8BOYLXV7ML93Q0P
         mO8jjzZxCUHfJiEpU56NdZe1wjc3ZzB9BMjqAJXiTYn0r+eET7OXpwVntF3wAzWV+f/X
         4ZQ6+RIvKYBsvinxGzXuodcKGgQX2zyfhzKAkkZ3085goLTF3mwAqTvr/qLSRg19anpX
         RxlSHaCrGNGZ2bGuqoFdvPI66PpBfMe7jbp+m9mWkgFBLHgq6cziAKr5snv1nZYApTYz
         1V2A==
X-Gm-Message-State: AOAM531yPh6TXhAycx/uUOIDguBK3EcAljO3m0yG1rhZUJDdWh8CZTB+
	+H4kL6K2z5nALw+y0+l0/yVnFA==
X-Google-Smtp-Source: ABdhPJwfVqE44HkUh28q260u6zkuUA2esLelA9ahdyBMn5/aswtGxC0uOTNqZK8H9X85Va9J+UAcjw==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr8365709wrd.118.1612430716991;
        Thu, 04 Feb 2021 01:25:16 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:62ae:a739:5537:66d9? ([2001:8b0:aba:5f3c:62ae:a739:5537:66d9])
        by smtp.gmail.com with ESMTPSA id b4sm7013661wrn.12.2021.02.04.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 01:25:16 -0800 (PST)
Message-ID: <c4a343366f873c3b1deee2f83bdc38638b98a677.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] event: Prevent bitbake from executing events that don't exist for multiconfig target
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 04 Feb 2021 09:25:12 +0000
In-Reply-To: <20210204010231.1380-1-tomasz.dziendzielski@gmail.com>
References: <20210204010231.1380-1-tomasz.dziendzielski@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2021-02-04 at 02:02 +0100, Tomasz Dziendzielski wrote:
> When multiconfig is used bitbake might try to run events that don't
> exist for specific mc target. In cooker.py we pass
> `self.databuilder.mcdata[mc]` data that contains names of events'
> handlers per mc target, but fire_class_handlers uses global _handlers
> variable that is created during parsing of all the targets.
> 
> See [YOCTO #13071] for detailed bug information.
> 
> I added a condition to check if the handler exists for target using
> __BBHANDLERS variable.
> 
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> 
> --- changed the order of conditions, it should be faster than previous patch, since first condition will give False more often
> ---
>  lib/bb/event.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 694b4705..ad119bbb 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -114,7 +114,7 @@ def fire_class_handlers(event, d):
>      eid = str(event.__class__)[8:-2]
>      evt_hmap = _event_handler_map.get(eid, {})
>      for name, handler in list(_handlers.items()):
> -        if name in _catchall_handlers or name in evt_hmap:
> +        if (name in _catchall_handlers or name in evt_hmap) and name in d.getVar("__BBHANDLERS"):
>              if _eventfilter:
>                  if not _eventfilter(name, handler, event, d):
>                      continue

This looks interesting. It does make me wonder what happens if the
different multiconfigs have a handler with slightly different code but
the same name though?

Cheers,

Richard

