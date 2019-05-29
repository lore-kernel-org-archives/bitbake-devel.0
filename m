Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id 1D5A27E25A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2019 15:37:31 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id 9so4277680itf.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2019 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:references:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=Esufd/jPn3fb8pN6Uo/gc6f2nYyoPhCwVURuqfGgR3k=;
	b=AXHcHEa7qaK/YJ/BjrRAH1QnEgedb5Z+AQ80GlaL7xSXBmpprA0FdwKIXPoS2OrakJ
	ZWpIIxUFOmfzAZsZa/PqIWkcwZw1TevdZp7pxmvgFOkoLOFsh36In3+NJtyAiwhp9w6C
	VQp71eXBBW+MJ7kOuRZ2z2r7eoi3Y52u+oK3pVG7vWtmdOwcaEJigEwDabr+NlWMwlrz
	ieqIuxOGHWpEmSoB42ly7bQ6Js54mDkF5iZ+8rlyOo15ATu3Zw+k1Pi6297ZfVbH6cUv
	AjJyZh9RwK5yXKhLdd4GnaWFZC+NAd9K0SbAYYdvMzTo4AGxgig79maIWPSF7T7Zg/LT
	ZWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=Esufd/jPn3fb8pN6Uo/gc6f2nYyoPhCwVURuqfGgR3k=;
	b=VEakqFXHLxyty+WEpZiLYWqm3LfKY7Z0UOd4EQ43o7i2DlTFzeOKfv3/7zabuAnX4B
	Zy5ALgsbzC2x+pCfRKrqDjWE4z4hJpqMzzaHFNn4Say3dQ+pcJMA9IKkWy0N54h8FxAv
	o48J9eF9G7n1ReX4F99i+h6r6AWiAfxU+HSjBY7Hco18O398q/8XNfBa90QO5FqsQ7QY
	Dg7ljpt/6QQLbMelPvMEKFBLU0Om9mEbkU9N84+WjdmW78kcGJTgvq9i7TZq9L995iSY
	E1eE02ErcVnp8htGG23TQCfbUDEWbi+xHVwQ+gPCYsrJ4i2j+hjoOhOJtDhBMQ+ls/Rc
	VVcw==
X-Gm-Message-State: APjAAAW1BixEMyPxQAwGjqBe7EFzG22/UkhtskLJWRKrArkMmm8uVMr8
	4tlKsqalhSRd0KtRoq9DU/fNzTJn
X-Google-Smtp-Source: APXvYqxWiEwo2J+ITzFifeLotbLVB1R8s8pNk0Sh21oiVh+OI105pNtoXDLMuFk+jvkvCWeetO0qsw==
X-Received: by 2002:a24:e9c4:: with SMTP id f187mr7354232ith.50.1559144251923; 
	Wed, 29 May 2019 08:37:31 -0700 (PDT)
Received: from [10.30.197.57] ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id p2sm1126544itb.29.2019.05.29.08.37.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 08:37:31 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
References: <20190522195650.15359-1-JPEWhacker@gmail.com>
Message-ID: <f4edb1e2-ac9b-37eb-ae35-19ddb4612edb@gmail.com>
Date: Wed, 29 May 2019 10:37:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522195650.15359-1-JPEWhacker@gmail.com>
Subject: Re: [PATCH] bitbake: Show base multiconfig environment
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 May 2019 15:37:31 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Ping

On 5/22/19 2:56 PM, Joshua Watt wrote:
> Adds support to the 'bitbake -e' command so that it can display the base
> environment for a multiconfig. It was previously possible to get the
> base environment for the main environment by running "bitbake -e", but
> there was no support for getting the base environment for a multiconfig
> without specifying a recipe. A user can now print the base environment
> for the multiconfig "foo" by running:
>
>   $ bitbake -e multiconfig:foo
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   bitbake/lib/bb/cooker.py | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 33697a71d5e..d183abab6dc 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -495,6 +495,7 @@ class BBCooker:
>           """
>           fn = None
>           envdata = None
> +        mc = ''
>           if not pkgs_to_build:
>               pkgs_to_build = []
>   
> @@ -503,6 +504,12 @@ class BBCooker:
>               self.enableDataTracking()
>               self.reset()
>   
> +        def mc_base(p):
> +            if p.startswith('multiconfig:'):
> +                s = p.split(':')
> +                if len(s) == 2:
> +                    return s[1]
> +            return None
>   
>           if buildfile:
>               # Parse the configuration here. We need to do it explicitly here since
> @@ -513,18 +520,16 @@ class BBCooker:
>               fn = self.matchFile(fn)
>               fn = bb.cache.realfn2virtual(fn, cls, mc)
>           elif len(pkgs_to_build) == 1:
> -            ignore = self.data.getVar("ASSUME_PROVIDED") or ""
> -            if pkgs_to_build[0] in set(ignore.split()):
> -                bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
> +            mc = mc_base(pkgs_to_build[0])
> +            if not mc:
> +                ignore = self.data.getVar("ASSUME_PROVIDED") or ""
> +                if pkgs_to_build[0] in set(ignore.split()):
> +                    bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
>   
> -            taskdata, runlist = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
> +                taskdata, runlist = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
>   
> -            mc = runlist[0][0]
> -            fn = runlist[0][3]
> -        else:
> -            envdata = self.data
> -            data.expandKeys(envdata)
> -            parse.ast.runAnonFuncs(envdata)
> +                mc = runlist[0][0]
> +                fn = runlist[0][3]
>   
>           if fn:
>               try:
> @@ -533,6 +538,12 @@ class BBCooker:
>               except Exception as e:
>                   parselog.exception("Unable to read %s", fn)
>                   raise
> +        else:
> +            if not mc in self.databuilder.mcdata:
> +                bb.fatal('Not multiconfig named "%s" found' % mc)
> +            envdata = self.databuilder.mcdata[mc]
> +            data.expandKeys(envdata)
> +            parse.ast.runAnonFuncs(envdata)
>   
>           # Display history
>           with closing(StringIO()) as env:

