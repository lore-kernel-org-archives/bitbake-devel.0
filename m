Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.19943.1630921306986732009
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Sep 2021 02:41:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Eo0Mk/Ii;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so3471687wmh.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Sep 2021 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gj3Qf+I+ep5XiZ3G6WlYIE6qhRBmfXeOS/yHgmrjbko=;
        b=Eo0Mk/IifiGZmdeH5Ibf8PGNJbICZv6zm3zC7DBt/rqsmIOzZz+0i8y6uSCNQZpstr
         hnA75b7pfQ5t54f9OLTMZHR8WonX1DSXP7i5cT2BpPmIiCgolagmtfcGDzqHVoW731oF
         7lOt2UG6eRYUqwPyeRIMOI643qQtMzyn/2KKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gj3Qf+I+ep5XiZ3G6WlYIE6qhRBmfXeOS/yHgmrjbko=;
        b=nAcd9b0BGfChLu8RH6dtK9q8Oye8D+Axym5dD5s4mLcSIhOb9UDYtds07uyqdad1T8
         AQxOP9lB/IyZGZIJ8V/axMSV8KWNH7VB5LZNTA5d+GYivigv4lDTPsYPLS0w8Qoczs+z
         umjYA4qiWTgrkR89zRZkeCS8Hh1x8jri3hH0WELvvT5KhgM4N1AldtbiTTH9Gy6V54N1
         8ERjYtTimMYmw25wQX9JTAQMnX45icgjW3VbseKoHqapAHWp+hJ6yupgGNlyIs5MuZg7
         rnLbky+fGGhcMu5sFrSBF+841luA3UuH+3myXB01JH14FB8GtZGGL9MdtAkccOaM+21S
         z7Ew==
X-Gm-Message-State: AOAM531wbuIXs/jctRpgIHOt8qFBDB4pMNZhELICBazr2sdvn1meXa/Y
	ilRSdUmbQNmkS49QXEdoF2WB4UeCKISo5w==
X-Google-Smtp-Source: ABdhPJzhKBdo6AZS2iHGZwOzcPERSK1AO2dsanCM7sPCETwg6RwAddbzLNZFkxW3gH527RpYicY14A==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr10714594wme.12.1630921305546;
        Mon, 06 Sep 2021 02:41:45 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:612e:ab48:3553:3f2? ([2001:8b0:aba:5f3c:612e:ab48:3553:3f2])
        by smtp.gmail.com with ESMTPSA id h8sm6647943wmb.35.2021.09.06.02.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:41:45 -0700 (PDT)
Message-ID: <92b1ba20b320376227c3003c53784de67ae01505.camel@linuxfoundation.org>
Subject: Re: [PATCH v2] bitbake/fetch2: Add a new variable 'BB_FETCH_ENV' to export Fetcher env
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "jiladahe1997@gmail.com" <jiladahe1997@gmail.com>, yocto
	 <yocto@lists.yoctoproject.org>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>, poky <poky@lists.yoctoproject.org>
Cc: "ross.burton" <ross.burton@arm.com>
Date: Mon, 06 Sep 2021 10:41:44 +0100
In-Reply-To: <2021082315183802113213@gmail.com>
References: <2021082315183802113213@gmail.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the patch. This isn't ready to be merged yet though as there are some
issues.

On Mon, 2021-08-23 at 15:18 +0800, jiladahe1997@gmail.com wrote:
> From 1b0d7b4bb4a5b39f7ae0ce7d7ae5897a33637972 Mon Sep 17 00:00:00 2001
> From: Mingrui Ren <jiladahe1997@gmail.com>
> Date: Mon, 23 Aug 2021 14:49:03 +0800
> Subject: [PATCH v2] bitbake/fetch2: Add a new variable 'BB_FETCH_ENV' to export Fetcher env
> 
> The environment variables used by Fetcher are hard-coded, and are obtained
> from HOST env instead of bitbake datastore

This isn't true, they are looked at first in bitbake's datastore, then taken
from the original host environment if not in the datastore.

> This patch add a new variable 'BB_FETCH_ENV',and modify the default
> BB_ENV_EXTRAWHITE_OE for backwards compatibility, trying to fix the
> problems above.

Why is this a problem? You need to state what the problem is, not what the code
currently does (or in the above case doesn't do).

> Signed-off-by: Mingrui Ren <jiladahe1997@gmail.com>
> ---
> changes in v2:
>      a.changes the variable name from 'FETCH_ENV_WHITELIST' to 'BB_FETCH_ENV'.
>      b.add 'BB_FETCH_ENV' in local.conf, rather than export it in host
>        enviroment.
>      c.modify existing BB_ENV_EXTRAWHITE_OE for backwards compatibility.
>      d.Two commits recently modified this variable. The commit ID is:
>        348384135272ae7c62a11eeabcc43eddc957811f and 5dce2f3da20a14c0eb5229696561b0c5f6fce54c,
>        So I adjusted the new variables in the patch.
> 
>  bitbake/lib/bb/fetch2/__init__.py | 34 ++++++++-----------------------
>  bitbake/lib/bb/fetch2/wget.py     |  2 +-
>  meta-poky/conf/local.conf.sample  | 12 +++++++++++
>  scripts/oe-buildenv-internal      |  3 ++-
>  4 files changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 914fa5c024..cbbe32d1df 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -808,28 +808,13 @@ def localpath(url, d):
>      fetcher = bb.fetch2.Fetch([url], d)
>      return fetcher.localpath(url)
>  
> -# Need to export PATH as binary could be in metadata paths
> -# rather than host provided
> -# Also include some other variables.
> -FETCH_EXPORT_VARS = ['HOME', 'PATH',
> -                     'HTTP_PROXY', 'http_proxy',
> -                     'HTTPS_PROXY', 'https_proxy',
> -                     'FTP_PROXY', 'ftp_proxy',
> -                     'FTPS_PROXY', 'ftps_proxy',
> -                     'NO_PROXY', 'no_proxy',
> -                     'ALL_PROXY', 'all_proxy',
> -                     'GIT_PROXY_COMMAND',
> -                     'GIT_SSH',
> -                     'GIT_SSL_CAINFO',
> -                     'GIT_SMART_HTTP',
> -                     'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
> -                     'SOCKS5_USER', 'SOCKS5_PASSWD',
> -                     'DBUS_SESSION_BUS_ADDRESS',
> -                     'P4CONFIG',
> -                     'SSL_CERT_FILE',
> -                     'AWS_ACCESS_KEY_ID',
> -                     'AWS_SECRET_ACCESS_KEY',
> -                     'AWS_DEFAULT_REGION']

Firstly, I'd prefer not to move this list out of the fetcher code. Bitbake can
be in theory used standalone without the OE-Core metadata and this data makes
more sense to be maintained in the fetcher.


> +def getfetchenv(d):
> +    # Need to export PATH as binary could be in metadata paths
> +    # rather than host provided
> +    # Also include some other variables.
> +    vars = ['HOME', 'PATH']
> +    vars.extend((d.getVar("BB_FETCH_ENV") or "").split())
> +    return vars
>  
>  def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
>      """
> @@ -839,7 +824,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
>      Optionally remove the files/directories listed in cleanup upon failure
>      """
>  
> -    exportvars = FETCH_EXPORT_VARS
> +    exportvars = getfetchenv(d)
>  
>      if not cleanup:
>          cleanup = []
> @@ -855,9 +840,8 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
>          d.setVar("PV", "fetcheravoidrecurse")
>          d.setVar("PR", "fetcheravoidrecurse")
>  
> -    origenv = d.getVar("BB_ORIGENV", False)
>      for var in exportvars:
> -        val = d.getVar(var) or (origenv and origenv.getVar(var))
> +        val = d.getVar(var)
>          if val:
>              cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
> 

Please don't drop the BB_ORIGENV handling. Why is that being removed?

>  
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
> index 29fcfbb3d1..0ce06ddb4f 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -306,7 +306,7 @@ class Wget(FetchMethod):
>          # to scope the changes to the build_opener request, which is when the
>          # environment lookups happen.
>          newenv = {}
> -        for name in bb.fetch2.FETCH_EXPORT_VARS:
> +        for name in bb.fetch2.getfetchenv(d):
>              value = d.getVar(name)
>              if not value:
>                  origenv = d.getVar("BB_ORIGENV")
> diff --git a/meta-poky/conf/local.conf.sample b/meta-poky/conf/local.conf.sample
> index f1f6d690fb..4e8a6f0c77 100644
> --- a/meta-poky/conf/local.conf.sample
> +++ b/meta-poky/conf/local.conf.sample
> @@ -267,6 +267,18 @@ PACKAGECONFIG:append:pn-qemu-system-native = " sdl"
>  #
>  #BB_SERVER_TIMEOUT = "60"
>  
> +# Bitbake Fetcher Environment Variables
> +#
> +# Specific which environment variables in bitbake datastore used by fetcher when
> +# executing fetch task.
> +# NOTE: You may need to modify BB_ENV_EXTRAWHITE, in order to add environment
> +# variable into bitbake datastore first.
> +BB_FETCH_ENV ?= "HTTP_PROXY http_proxy HTTPS_PROXY https_proxy \
> +FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy NO_PROXY no_proxy ALL_PROXY all_proxy \
> +GIT_PROXY_COMMAND GIT_SSH GIT_SSL_CAINFO GIT_SMART_HTTP SSH_AUTH_SOCK SSH_AGENT_PID \
> +SOCKS5_USER SOCKS5_PASSWD DBUS_SESSION_BUS_ADDRESS P4CONFIG SSL_CERT_FILE AWS_ACCESS_KEY_ID\
> +AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION"
> +

I'd like to see this preserved in bitbake, not in bitbake.conf in OE-Core.

>  # CONF_VERSION is increased each time build/conf/ changes incompatibly and is used to
>  # track the version of this file when it was generated. This can safely be ignored if
>  # this doesn't mean anything to you.
> diff --git a/scripts/oe-buildenv-internal b/scripts/oe-buildenv-internal
> index e0d920f2fc..29cb694790 100755
> --- a/scripts/oe-buildenv-internal
> +++ b/scripts/oe-buildenv-internal
> @@ -111,7 +111,8 @@ HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy ALL_PROXY \
>  all_proxy NO_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY \
>  SDKMACHINE BB_NUMBER_THREADS BB_NO_NETWORK PARALLEL_MAKE GIT_PROXY_COMMAND \
>  SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR BBPATH_EXTRA BB_SETSCENE_ENFORCE \
> -BB_LOGCONFIG"
> +BB_LOGCONFIG HOME PATH GIT_SSH GIT_SSL_CAINFO GIT_SMART_HTTP DBUS_SESSION_BUS_ADDRESS \
> +P4CONFIG SSL_CERT_FILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION"
>  
>  BB_ENV_EXTRAWHITE="$(echo $BB_ENV_EXTRAWHITE $BB_ENV_EXTRAWHITE_OE | tr ' ' '\n' | LC_ALL=C sort --unique | tr '\n' ' ')"

I think if you leave BB_ORIGENV handling in place, these latter changes
shouldn't be needed?

If you need to be able to pass extra variables into the fetcher, I think we
could/should add API for additions rather than allowing the whole list to be
customised. Without stating which problem you're solving, guessing what you
really need is hard though. A better description of the issue you're seeing
would help a lot.

Cheers,

Richard


