Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
 by mx.groups.io with SMTP id smtpd.web10.26128.1585484476520998413
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2020 05:21:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@madison-systems.20150623.gappssmtp.com header.s=20150623 header.b=zPFX/Hdu;
 spf=none, err=SPF record not found (domain: madison.systems, ip: 209.85.167.66, mailfrom: matt@madison.systems)
Received: by mail-lf1-f66.google.com with SMTP id n20so11551209lfl.10
        for <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2020 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madison-systems.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naSCTY3HN0lhBKyZiK9IcKT0+aoTJ3Pan8fH79i0+oc=;
        b=zPFX/Hdu4t3be5ygCT5u4m/v2JUn5ZBpMz0vxH5vJNC1ZW5/pN8KM3ijghuR6AjszO
         XusIe77HvLSw4ip7rMl5DInrv1zjI35u4BY8TFSTvA4K75XEsUXxUEAsmJ1zueHWdjCn
         U5yivIwpjHpsids7eE61ieTZOnljEndi5qBRaUORSlIcrttvThyMLxnqVaW8A0d0pIl3
         DHz52iz+SX7tgzxx9KzY+UDcqy1rkyT7EB5kBvKDgdZvrHN8F1B2fgVJzNwYt+On2wCf
         2ae44eImHY3eyw4w+/3Tljls/1fDbm9votR+Sz0I7OT6zvQ4dFYtrOqcZU9x8aGN0VZ1
         wPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naSCTY3HN0lhBKyZiK9IcKT0+aoTJ3Pan8fH79i0+oc=;
        b=mu4IU+be5crJXbrronv+YfO+ns7j86VyPt9m5QCE81a3gP3YbyXWg8TY4AWmA0cWJc
         v6EBKiT3Rp0naaZOOIYMMj2Pn6uN5Q6oING2Oi9Fbqbk/5IRLeIXzBf7d7vUejU4lLIZ
         fPce5zDh2qjKcLWuLqVVybBDvRC1E9o6ve4gJl9JfNo4KUFzAXWw8Bc35UmXSPuMxJGK
         DcBWuK3Qu6lwXmW857juKcWSa9Jsi1FwHLytMiWj6cW9NXJS1EFDJAplGeiL5sgmm8m4
         QsRmyXR5wveKAin7QdorjhRBv+2fPk7ZFeubNfcpRTwI/8mWrsAOR8U7MP4oPUjHCKvv
         s+SA==
X-Gm-Message-State: AGi0PubXLKttZmkWcNAp7/Vl6u+Kk+/bELDTeioiMWB+WbqIOaKhns4w
	Qy/GrY1bOZqOcO5Ukjw7uanmttbhtM111zWQVIBOLw==
X-Google-Smtp-Source: APiQypIZamT3u+7DqdlvxpFSmSew/NbJFqZbAXIQyJNSwb4PgLXd+BGCZX/D3mZ9XUiIGMdQlVL11SKs3mN97oeIzps=
X-Received: by 2002:ac2:5497:: with SMTP id t23mr1720653lfk.211.1585484474554;
 Sun, 29 Mar 2020 05:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200327144825.562857-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20200327144825.562857-1-richard.purdie@linuxfoundation.org>
From: "Matt Madison" <matt@madison.systems>
Date: Sun, 29 Mar 2020 05:21:03 -0700
Message-ID: <CAGgRHJoTW30z6gQwCJByEB8xOQ62K-ecuYEE7ZKyd1GZgYehHw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Fix urldata_cache key issues
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 27, 2020 at 7:48 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> Upon inspection its clear the way the keys for this cache were being handled
> would break it and cause the cache to never be used. Fix this.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/__init__.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index d8ad19b59b..813f5eb773 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1631,8 +1631,11 @@ class Fetch(object):
>
>          fn = d.getVar('FILE')
>          mc = d.getVar('__BBMULTICONFIG') or ""
> -        if cache and fn and mc + fn in urldata_cache:
> -            self.ud = urldata_cache[mc + fn + str(id(d))]
> +        key = None
> +        if cache and fn:
> +            key = mc + fn in urldata_cache
This doesn't look right.  Did you really mean to have the 'in
urldata_cache' here?

-Matt

> +        if key in urldata_cache:
> +            self.ud = urldata_cache[key]
>
>          for url in urls:
>              if url not in self.ud:
> @@ -1643,8 +1646,8 @@ class Fetch(object):
>                          self.ud[url] = None
>                          pass
>
> -        if fn and cache:
> -            urldata_cache[mc + fn + str(id(d))] = self.ud
> +        if key:
> +            urldata_cache[key] = self.ud
>
>      def localpath(self, url):
>          if url not in self.urls:
> --
> 2.25.1
>
> 
