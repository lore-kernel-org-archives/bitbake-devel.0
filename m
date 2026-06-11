Return-Path: <anders.heimer@runbox.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61190CD98D2
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 12:19:10 +0000 (UTC)
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43996.1781180347088038723
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 05:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@runbox.com header.s=selector1 header.b=qNl2CgKP;
 spf=pass (domain: runbox.com, ip: 185.226.149.38, mailfrom: anders.heimer@runbox.com)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <anders.heimer@runbox.com>)
	id 1wXeNE-003ITP-FL
	for bitbake-devel@lists.openembedded.org; Thu, 11 Jun 2026 14:19:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID;
	bh=SUQWQKbAiQI7HDCDoDzPdrBwZ2TRnJbYl2bBhJREw4g=; b=qNl2CgKPN2dnHYHcc4hJEJ+yQT
	eCUz2bBp0VEvYFD3d/72bA+TrFo+bxEfTTikl3DCY41Ovweqd+daL9U//Ip8tv6X2lJYgKT2KtFe6
	Bc/ep0MdXyt/w/6sLprBDIItbLRv4Wpo6t93a6ilxWoKd7WWApdV8+ifyCcXPcgFb/2tipYFFmwR5
	R4L5gUcsEiDYhYyHFnIM8TZUibJVtTy251/lHm2biceuRJ2fP/+fM7MdRfevqREPbd5nQaix7cFal
	oWkoKiHfCzsxXtGTvhJuSIIkFw8lLzvHZgXkSwqrKC7BeI7ztYoemfs5ylWDi6EAKur3EqYebPVJ3
	a+/t8Ewg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <anders.heimer@runbox.com>)
	id 1wXeND-0001BF-UX; Thu, 11 Jun 2026 14:19:04 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (926809)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wXeN7-002t2u-Of;
	Thu, 11 Jun 2026 14:18:57 +0200
Message-ID: <5f2ccafd-269f-4bf3-a6b0-1fd1ee12d574@runbox.com>
Date: Thu, 11 Jun 2026 14:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/2] lib/bb: Further shell=True cleanups
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <20260611110523.322273-1-richard.purdie@linuxfoundation.org>
 <20260611110523.322273-2-richard.purdie@linuxfoundation.org>
Content-Language: en-US
From: Anders Heimer <anders.heimer@runbox.com>
In-Reply-To: <20260611110523.322273-2-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 12:19:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19658

On 6/11/26 13:05, Richard Purdie via lists.openembedded.org wrote:
> @@ -186,12 +188,12 @@ class LocalhostBEController(BuildEnvironmentController):
>               else:
>                   if giturl in cached_layers:
>                       logger.debug("localhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdirname))
> -                    self._shellcmd("git clone \"%s\" \"%s\"" % (cached_layers[giturl], localdirname),env=git_env)
> -                    self._shellcmd("git remote remove origin", localdirname,env=git_env)
> -                    self._shellcmd("git remote add origin \"%s\"" % giturl, localdirname,env=git_env)
> +                    self._shellcmd(['git', 'clone', cached_layers[giturl]], localdirname], env=git_env)
One ] to much.
> diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
> index d2a449627f8..9d2dbc464ec 100644
> --- a/lib/toaster/toastermain/settings.py
> +++ b/lib/toaster/toastermain/settings.py
> @@ -229,8 +229,8 @@ from os.path import dirname as DN
>   SITE_ROOT=DN(DN(os.path.abspath(__file__)))
>   
>   import subprocess
> -TOASTER_BRANCH = subprocess.Popen('git branch | grep "^* " | tr -d "* "', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
> -TOASTER_REVISION = subprocess.Popen('git rev-parse HEAD ', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
> +TOASTER_BRANCH = subprocess.check_output(['git', 'branch', '--show-current'], cwd=SITE_ROOT, text=True).strip()
If I am reading the correct doc version, the minimum Git version 
supported is 1.8.3.1 while --show-current was added in 2.22.0.
> +TOASTER_REVISION = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=SITE_ROOT, text=True).strip()
>   
>   ROOT_URLCONF = 'toastermain.urls'

Best regards,

Anders Heimer


