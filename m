Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web12.19412.1590692601755822462
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 12:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dFFQvA1r;
 spf=pass (domain: gmail.com, ip: 209.85.214.196, mailfrom: akuster808@gmail.com)
Received: by mail-pl1-f196.google.com with SMTP id t16so11969342plo.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=O/aK0JLmeLHe6aE3UufQy6WxfQK5ahv5foDjSCjhIAc=;
        b=dFFQvA1rzhH2iWqysnq/7yPvGoK6MkaVOJb6/WdutQkpvP5/1XC3V7mVdvVlkPsnjN
         9TMx6GBea9/d6dtL9Fm6wpbWqDTl7kQlbAHGUNGQP7suXGywzju1ehpJq7axlXCoNDq2
         z+BDr3WRBgI1i1I2uxmkGppd72JuBaSEoXrqPuAcXv2P+1zcVChYiZ4fxi34l+D22EWH
         37PGvQKpMfqGBB4OuYYWQsUDi/cFjbXTE4drbFwNTZY1uVYmrbHu4EPQi4ty2Td7QKHp
         wHhfVAKV6ropMogwEOgq0n/XyMILaJg4toX4hYZX9EixKX4tSNWFf3YbSvQIvrWa7YmS
         UFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=O/aK0JLmeLHe6aE3UufQy6WxfQK5ahv5foDjSCjhIAc=;
        b=oZ4/PYroBLKgZzVoCP+ffoKPb87LG5bRP9pAhCZ+bf6B2NY586Vd2V+/X6uXuiBD4U
         gGr7Idj8ALDGkQNXJcNHfe3CCfaFKjhXk2L/CJXV9+GS76qIpjEHzJ3esUxnhJigG64O
         tYZrw20qFsqR23bujZIiAKrUMy4cGjP8VL9wCPzvJqgamgaL/VIDnozDHziZXZxRAgvs
         qr9OpF+JggF1uo6jH3RLkizK7h1j/l1qsuYKcheaIGFnBuKkHskYWQAzA4IoZJAeAjl6
         qWSpoL/Z/9SBqde3MBcIWsEouwADo7HF7lcXKrrbmoh72cLFDj4khluB1Mz1vYihvVUL
         w3Sg==
X-Gm-Message-State: AOAM533lHK1aO4k44iFKyoohQtIJKblZOJA2SrJkmPsdtyinhZ5khHpK
	oXN2uVcsTgbIL+gKybSisO0=
X-Google-Smtp-Source: ABdhPJwVE8obHsnUsx/BsGz2EhV7azdB0K52eRVWM4iJRVNDwQvoQbOLZGrpi1HawTJocQ+YU+Mxtg==
X-Received: by 2002:a17:90a:8989:: with SMTP id v9mr5549489pjn.180.1590692601048;
        Thu, 28 May 2020 12:03:21 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from ?IPv6:2601:202:4180:a5c0:d56d:e1fd:3d63:afa6? ([2601:202:4180:a5c0:d56d:e1fd:3d63:afa6])
        by smtp.gmail.com with ESMTPSA id go1sm5428101pjb.26.2020.05.28.12.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:03:20 -0700 (PDT)
Subject: Re: [bitbake-devel] [dunfell][1.46][PATCH] toaster-requirements.txt: require Django 2.2
To: Tim Orling <timothy.t.orling@linux.intel.com>,
 bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Cc: david.reyna@windriver.com
References: <20200527232512.27409-1-timothy.t.orling@linux.intel.com>
From: "akuster" <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
 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
 8CS2NxU=
Message-ID: <a463f133-7853-f2e6-9124-a98be5322a1f@gmail.com>
Date: Thu, 28 May 2020 12:03:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527232512.27409-1-timothy.t.orling@linux.intel.com>
Content-Type: multipart/alternative;
 boundary="------------F6CA01EA2A40FF3F46C4F217"
Content-Language: en-US

--------------F6CA01EA2A40FF3F46C4F217
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



On 5/27/20 4:25 PM, Tim Orling wrote:
> In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
> Django 2.2 was enabled.
>
> Django 1.11 was EOL on April 1, 2020
>
> Signed-off-by: Tim Orling <timothy.t.orling@linux.intel.com>
> ---
>  toaster-requirements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/toaster-requirements.txt b/toaster-requirements.txt
> index a682b085..735b6145 100644
> --- a/toaster-requirements.txt
> +++ b/toaster-requirements.txt
> @@ -1,3 +1,3 @@
> -Django>1.8,<1.12
> +Django>2.2,<2.3

Is this version supported on all hosts supported by Dunfell?

- armin
>  beautifulsoup4>=4.4.0
>  pytz
>
> 


--------------F6CA01EA2A40FF3F46C4F217
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 5/27/20 4:25 PM, Tim Orling wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200527232512.27409-1-timothy.t.orling@linux.intel.com">
      <pre class="moz-quote-pre" wrap="">In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
Django 2.2 was enabled.

Django 1.11 was EOL on April 1, 2020

Signed-off-by: Tim Orling <a class="moz-txt-link-rfc2396E" href="mailto:timothy.t.orling@linux.intel.com">&lt;timothy.t.orling@linux.intel.com&gt;</a>
---
 toaster-requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index a682b085..735b6145 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django&gt;1.8,&lt;1.12
+Django&gt;2.2,&lt;2.3</pre>
    </blockquote>
    <br>
    Is this version supported on all hosts supported by Dunfell?<br>
    <br>
    - armin<br>
    <blockquote type="cite"
      cite="mid:20200527232512.27409-1-timothy.t.orling@linux.intel.com">
      <pre class="moz-quote-pre" wrap="">
 beautifulsoup4&gt;=4.4.0
 pytz
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------F6CA01EA2A40FF3F46C4F217--
