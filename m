Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
 by mx.groups.io with SMTP id smtpd.web12.13013.1594115584141379842
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2020 02:53:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=O1QX9xnF;
 spf=pass (domain: gmail.com, ip: 209.85.167.65, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f65.google.com with SMTP id y18so24352070lfh.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2020 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Yq79AvJrj/PjJcgrxtNeTZXWx1m/bYrxi+H3CAig8fo=;
        b=O1QX9xnFTrIdbUVaCWt1VueQ9y7vZaG0vJ91lEE0fiVKXIxoYs6mAj9tklyw7mP/kU
         g88oXQKkyR+xLISifWwA3lzTRLWEmi4OmRThnY7J/jpmcLcIdO38XynyFCqnVF+bEzQE
         y/RnDH7e7kV8ukIntsZrKkYV7ucpBnBLTxA5AvGYgE9I7wYM0iJTwlkbS2dO2zBXDw0E
         hgmYQe54b25zKZDu/FoKLywVFxt4X+UaVTOapsLXajQrEZ+9+DaZDiKsv7IELTiZkgWa
         6+TdZUZ9lZcw83Ca5qF1xJlVI9MUAvuKJvnlP7LzWeij611WWuPw7UMpAJjPqiADNiEo
         62dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yq79AvJrj/PjJcgrxtNeTZXWx1m/bYrxi+H3CAig8fo=;
        b=Skaohh9rnmf7HTlOEDBKmRJc5c7AWS3ehNuz3KKcInB3UjXM2rswhyeYlytTCKJV0T
         rjfbXprRj1BhKS5pg9fqZazRm+4//VGAeLr8Yyr8S6R5u4IS9Gy0dTGRrFZ4QxUXBjXN
         b7gj7cNwmIGGx9XXAT9LnizAYR63xBsI2/vagKB9EMK65UyguAkAbCea7e80bkdsi7pd
         cTmTFA2Ob4KrxZ7OYDitK4G8Hb/1KLNruprHmV4i1XYrzvjd/CMAdTLhlySvKUq1IdbS
         wa1ey9uwmxWhNpbhn3PpeWn4CJ1rk2o2w6E+ud/H0PV20X9+CGwNnrlzFub5dzQ3EM1J
         yirg==
X-Gm-Message-State: AOAM532wTdEsEHBPVrOmtzlVXUgW59YADSaR/3ZmADIMlwB3QyJiw1Py
	gN10y+rJCXL0WpbpB5L/xzTkxGUb
X-Google-Smtp-Source: ABdhPJyKSxlNEsJt+UGpSEx6wT06Bpz/7Fv2EF3i7z7U9W3K1uIj/FQn0COGnCI6HeDwkuMp8EioHg==
X-Received: by 2002:a19:6a14:: with SMTP id u20mr30753731lfu.172.1594115581710;
        Tue, 07 Jul 2020 02:53:01 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id k14sm55360ljc.48.2020.07.07.02.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 02:53:00 -0700 (PDT)
Subject: Re: [bitbake-devel] [bitbake][PATCH] lib/ui/taskexp: Validate gi import
To: David Khouya <dakhouya@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20200701162740.258157-1-dakhouya@gmail.com>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <d679c275-a191-eed0-a5bb-54f6d5a499c0@gmail.com>
Date: Tue, 7 Jul 2020 11:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701162740.258157-1-dakhouya@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 7/1/20 6:27 PM, David Khouya wrote:
> When running bitbake -g -u taskexp without having gi python module or
> and invalid gtk version, bitbake fails with a stack trace.
> 
> In case of import or version error, bitbake should exit with an error
> message instead of a stack trace.
> 
> Signed-off-by: David Khouya <dakhouya@gmail.com>
> ---
>   lib/bb/ui/taskexp.py | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
> index 8fff2442..336d197d 100644
> --- a/lib/bb/ui/taskexp.py
> +++ b/lib/bb/ui/taskexp.py
> @@ -8,9 +8,15 @@
>   #
>   
>   import sys
> -import gi
> -gi.require_version('Gtk', '3.0')
> -from gi.repository import Gtk, Gdk, GObject
> +
> +try:
> +    import gi
> +    gi.require_version('Gtk', '3.0')
> +except ValueError:
> +    sys.exit("FATAL: Gtk version needs to be 3.0")
> +except ImportError:
> +    sys.exit("FATAL: Gtk ui could not load the required gi python module")
> +
>   import threading
>   from xmlrpc import client
>   import bb
> 
> 

With this patch applied I get:

Traceback (most recent call last):
   File "/home/jkroon/Projects/foo-linux/bitbake/bin/bitbake", line 35, 
in <module>
     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
   File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line 
366, in bitbake_main
     server_connection, ui_module = setup_bitbake(configParams, 
configuration)
   File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line 
404, in setup_bitbake
     ui_module = import_extension_module(bb.ui, configParams.ui, 'main')
   File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/main.py", line 
96, in import_extension_module
     module = __import__(pkg.__name__, fromlist=[modulename])
   File "/home/jkroon/Projects/foo-linux/bitbake/lib/bb/ui/taskexp.py", 
line 33, in <module>
     class PackageDepView(Gtk.TreeView):
NameError: name 'Gtk' is not defined

Reverting the patch allows me to run

  bitbake -g -u taskexp core-image-minimal

and browsing via the Gtk UI works fine.

Jacob
