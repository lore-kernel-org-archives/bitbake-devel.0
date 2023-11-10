Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2BC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 18:02:07 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.34336.1699639318550841830
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 10:01:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V0vhgCpY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso16370795e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 10:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699639317; x=1700244117; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3wVegIi44d/5dP6iKqEdBqPoE7L1HNSscGHEnfH2cyc=;
        b=V0vhgCpYm8zzj9D7PrcOJP60BpnV7/KC+r3r+oDQKQyBeZd3eOa3gIbM4x3SIUoT0j
         qWEjtu+SJzAGh618w4Vv+HfssWG5+G5b8G1ucyUoLF8vQ28deoQr9zdV84ui+fCLqCV2
         XYTHPCUGW4sdyWDFQQbLLvD2Muz0XQeAwEld8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639317; x=1700244117;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wVegIi44d/5dP6iKqEdBqPoE7L1HNSscGHEnfH2cyc=;
        b=IRcVnkQ8EV+d8mT9jjr4tAiGMh4Og28zcpirH4N+SxcMLe0whrTAUmbVUU1sOxmEOZ
         AcF7ZIZgwZm2pXz1zKPnJjZvXoADdgnI1ixbLMeworLa6Od4Bx6a36PyhXJV7zP/rODP
         SIN8YoQ2WxRX8vBk/2D6pff06bvkRb2IisfZ7uM/xqe9yd9EbXy6San/IUn9mUHI7F5i
         N+iePBDzowDsM8HcsoVDFdfYlZCC8zUHhEZbtRjNyQktZCKPqegamHh1EL0wV6rcUgHF
         zu4sRsCgqVeKtGVrN9MgKsXX34TwlCIRzFI9IO7Ogt/0z69mKHbMXJx4snmBHR5B3HaU
         cXCA==
X-Gm-Message-State: AOJu0YxCwZzb/bzyp1xGRkg2dsP/PU95bui6B9lRQXDN2ww8VM4GdbCy
	U7D4Qng0whNjR+9LJgsZYU6Nug==
X-Google-Smtp-Source: AGHT+IHaV93fqG3yUgM4gWuSoUNfTrUpQfF+hTKzO3TVhbADa5Kbr8+WdYnTtlolEDm+BKVzeamfIQ==
X-Received: by 2002:a05:600c:4d01:b0:406:8c7a:9520 with SMTP id u1-20020a05600c4d0100b004068c7a9520mr71585wmp.36.1699639316901;
        Fri, 10 Nov 2023 10:01:56 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3703:3761:dd76:7c61? ([2001:8b0:aba:5f3c:3703:3761:dd76:7c61])
        by smtp.gmail.com with ESMTPSA id h3-20020adfa4c3000000b0031980294e9fsm2373928wrb.116.2023.11.10.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 10:01:56 -0800 (PST)
Message-ID: <85003f99a53c415511aa2c3efa54a32ee1303e13.camel@linuxfoundation.org>
Subject: Re: [Toaster] [PATCH] toaster: log ProcessLookupError in
 test_runbuilds
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tim Orling <ticotimo@gmail.com>, bitbake-devel@lists.openembedded.org, 
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Date: Fri, 10 Nov 2023 18:01:55 +0000
In-Reply-To: <20231110153009.3592572-1-tim.orling@konsulko.com>
References: <20231110153009.3592572-1-tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 18:02:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15512

On Fri, 2023-11-10 at 07:30 -0800, Tim Orling wrote:
> This repeatably fails:
>=20
> Exception in thread Thread-2:
> Traceback (most recent call last):
>   File "/usr/lib/python3.10/threading.py", line 1016, in _bootstrap_inner
>     self.run()
>   File ".../poky/bitbake/lib/toaster/tests/commands/test_runbuilds.py", l=
ine 39, in run
>     os.kill(int(pid), signal.SIGTERM)
> ProcessLookupError: [Errno 3] No such process
>=20
> Rather than have a hard error, add logging and output as a warning.
>=20
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  lib/toaster/tests/commands/test_runbuilds.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/t=
ests/commands/test_runbuilds.py
> index c77d6cf4..14b35764 100644
> --- a/lib/toaster/tests/commands/test_runbuilds.py
> +++ b/lib/toaster/tests/commands/test_runbuilds.py
> @@ -19,6 +19,10 @@ import time
>  import subprocess
>  import signal
> =20
> +import logging
> +
> +logger =3D logging.getLogger("toaster")
> +
> =20
>  class KillRunbuilds(threading.Thread):
>      """ Kill the runbuilds process after an amount of time """
> @@ -36,8 +40,11 @@ class KillRunbuilds(threading.Thread):
> =20
>          with open(pidfile_path) as pidfile:
>              pid =3D pidfile.read()
> -            os.kill(int(pid), signal.SIGTERM)
> -
> +            try:
> +                os.kill(int(pid), signal.SIGTERM)
> +            except ProcessLookupError as err:
> +                logger.warning("Failed to kill pid. %s" % err)
> +                pass
> =20

Is this a case of "just ensure bitbake has really exited"? If so we
perhaps don't need the warning as it is quite likely it has exited?

Cheers,

Richard


