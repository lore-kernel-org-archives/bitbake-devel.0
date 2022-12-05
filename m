Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FFC4332F
	for <webhook@archiver.kernel.org>; Mon,  5 Dec 2022 15:58:15 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.19111.1670255893503191098
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Dec 2022 07:58:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=RujVoWXY;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1441d7d40c6so13921289fac.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Dec 2022 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7y/SZwxZjA1fsdBUHU5JDHH5rL8XNefrcWlDO99Luc=;
        b=RujVoWXYmMjM8WfhxNlIsv/f+BQ99Od3hd7CU0kH2Y7vK3L55/0W/Pa7Go7uH49CJi
         miBAjgmLdhBBiqQ6d1c7FDRmbfm4/OeX6/FgOXrsps8SWYll9SjEDQHnTOlJwBkCQ9E0
         8hg/xBicd+XvKIctsZ3/l2p+sMkW4dXR9+nWG650Xzy/u+yBHjCtRCfDj4wrGjR4jm35
         Ui/bYKyofhmWyLaj8VuCO8YA8tIpDC2SXoXk5LaZgx1+1cSqxP0m9d2iOlBzFFOhBThJ
         2W59TjyD2cHrhRBpFFgoahCvwGcsMCY71d2uBMuZXMjeKjX9mVYD09ap1sWvrg/gT8Sc
         Sakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7y/SZwxZjA1fsdBUHU5JDHH5rL8XNefrcWlDO99Luc=;
        b=cVfRD/GcHBA9nq9bWrSOGZifcAOTb9xfiNu+YeXbzNKIEksBs0NI6G9pV6O1d+twrz
         XUDniwFXxlbgKyuhMMAsMXbz+CdpXsWtg0osbKhve4fKLSgNZnZoXepZLjfNZu+WIazM
         3tCj6QNBCVZJNG491uWY13mBQgxnhJDEXUhrCcZTFlHOMoDMedIweKYbFpwK4B+6hIrV
         WNBq03tCM1zeLJk0c0JHpoBC5A8Z6QPFuP19vyQc0EEIg1K/PbWzrpUHSijeWaRhIcYx
         ssZm99403I6brAfE+E/7RRLxsZsSBzAkpJ9vsBdQNHJd9ENBx1ghWUjRTx8r+tmfibQN
         jRlg==
X-Gm-Message-State: ANoB5pm6nTi7rz/kuE3jbipsTu1BrJz1Q2yI937FmuSOq8cQIcHBaXud
	89u6Bt+59vATQbOZJaoJa88=
X-Google-Smtp-Source: AA0mqf4PojuDIjZBbkJkYoOwlX0zz6H6zpERG4syyJDiDuPQjhFyORAyD14wwU/B6CtjObsyiVe/5g==
X-Received: by 2002:a05:6870:6006:b0:13b:ceab:11db with SMTP id t6-20020a056870600600b0013bceab11dbmr35296133oaa.81.1670255892783;
        Mon, 05 Dec 2022 07:58:12 -0800 (PST)
Received: from ?IPV6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id j22-20020a056870169600b001447a2a34dfsm3839319oae.40.2022.12.05.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 07:58:12 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <1a84e6d2-c53c-4d13-926f-ce49d55ee6ef@gmail.com>
Date: Mon, 5 Dec 2022 09:58:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bitbake-devel] [PATCH v2] cache/siggen: Simplify passing
 basehash data into the cache
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20221205151817.1769536-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20221205151817.1769536-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Dec 2022 15:58:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14135


On 12/5/22 09:18, Richard Purdie wrote:
> The basehash data is really internal bitbake data and passing an object
> directly is more efficient than creating and then extracting variables.
>
> This will match the format of other data we may optionally wish to
> store in the cache so more to the more efficient method. Nothing I
> can see is using this data today (and nothing should be).
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/cache.py  | 4 ++--
>   lib/bb/siggen.py | 5 ++++-
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> v2: Add default for the cache entry so selftest works
>
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index cb6cf21727..e117fe56cb 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -28,7 +28,7 @@ import shutil
>   
>   logger = logging.getLogger("BitBake.Cache")
>   
> -__cache_version__ = "154"
> +__cache_version__ = "155"
>   
>   def getCacheFile(path, filename, mc, data_hash):
>       mcspec = ''
> @@ -105,7 +105,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
>   
>           self.tasks = metadata.getVar('__BBTASKS', False)
>   
> -        self.basetaskhashes = self.taskvar('BB_BASEHASH', self.tasks, metadata)
> +        self.basetaskhashes = metadata.getVar('__siggen_basehashes', False) or {}
>           self.hashfilename = self.getvar('BB_HASHFILENAME', metadata)
>   
>           self.task_deps = metadata.getVar('_task_deps', False) or {'tasks': [], 'parents': {}}
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 72b906c153..34b71d596a 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -247,8 +247,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
>           #for task in self.taskdeps[fn]:
>           #    self.dump_sigtask(fn, task, d.getVar("STAMP"), False)
>   
> +        basehashes = {}
>           for task in taskdeps:
> -            d.setVar("BB_BASEHASH:task-%s" % task, self.basehash[fn + ":" + task])
> +            basehashes[task] = self.basehash[fn + ":" + task]

In my testing, dictionary comprehension is the fastest method to 
populate a dictionary, so if this is a critical path, you could optimize 
it as:

  basehash = {task: self.basehash["%s:%s" % (fn, task)] for task in 
taskdeps}

I can't remember if that level of micro optimization helps here though; 
if not feel free to ignore me :)

> +
> +        d.setVar("__siggen_basehashes", basehashes)
>   
>       def postparsing_clean_cache(self):
>           #
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14134): https://lists.openembedded.org/g/bitbake-devel/message/14134
> Mute This Topic: https://lists.openembedded.org/mt/95394525/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

