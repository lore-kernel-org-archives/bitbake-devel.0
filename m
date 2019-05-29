Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id B541360069
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2019 15:37:18 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id t184so4606811itf.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2019 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:references:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=o+UYLwWZzPezRFGhKpmqD0qoLLPmwJvfawjNPgiqeQ0=;
	b=bi2VsnYrl8CEVCA15mD3m4ziux7kw3a8WP5NIwTjpjmkovYsqgagxQJe6pDRtE4Unj
	/PKLv/PfT3wYYLJK3BWB9uEHRRtkxMMNlc0wmeIqQPFA10M1JHs3Mp0ciWg+u3EKO/dc
	ftQbzoot/YEYb2RuSmQ1pwb39X+b04v6AISG3D7g4VDq/XjQUEJhGADyiEShlyrjiOLJ
	ivfpA8gX1CkGbd7VsBxiXd/BWDEl/QbCdGydFx7h0Ejf9IWXNokgdBlKylpRnoLqHBMl
	TyiIwFHjY0oRCKl1BYxlQDIsP3fOtF2euTqPJaKwSZGi+60e6j13sLpRY9Eol/p/mUPA
	Rl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=o+UYLwWZzPezRFGhKpmqD0qoLLPmwJvfawjNPgiqeQ0=;
	b=jgXMbs2i0fj27qfvQlFpTOpzUN18dp5JmRyxFhTMnzClsc+DSmUpdUhIvU7YzJE569
	ald7kbShNGi2awmtPYY01C1JJvGV+hRbL+Ukhz9wNo4MQTI3IKacoYEI2N9FkbBOjbMi
	u3fr4S+u5lxQmO5v/BUVs3IJjwc/8V3puFM/cmYl1hHK0g1wf5wneeU05ctuF+dg/5SW
	NiudWjj/eYUAjtNDabDnzkwE/vyrKHrOgDaCHAyL7I79h2vFPJ/0r7mlDVVYeeSJuUK8
	K40GqQn6/0LdGkObGzyZBtpVQ5/pzfc4Idoe89SjBWsr6fPONj2AxUEKQ4T1643LHU1f
	Z3Pg==
X-Gm-Message-State: APjAAAUzSrCVsT+nyXeFJmctwaa6JWZ0Zrz3L7ecalJc5MOpILf0/EjY
	O91OisLdUG3KFKRHuSNZSd2zmuSC
X-Google-Smtp-Source: APXvYqwlyp3kFsUW1qUuwCxJZLP8UK/EAIGmW15arJ/vnUf5PtAHGQ98yfJBRWt56oJuasCkSYZJQg==
X-Received: by 2002:a24:734c:: with SMTP id y73mr7600033itb.72.1559144239025; 
	Wed, 29 May 2019 08:37:19 -0700 (PDT)
Received: from [10.30.197.57] ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	a129sm1093998ith.7.2019.05.29.08.37.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 08:37:18 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
References: <20190521214942.3300-1-JPEWhacker@gmail.com>
	<20190522133503.14212-1-JPEWhacker@gmail.com>
Message-ID: <6c1741b7-eebd-7253-6f7b-852fba966c85@gmail.com>
Date: Wed, 29 May 2019 10:37:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522133503.14212-1-JPEWhacker@gmail.com>
Subject: Re: [PATCH v2] bitbake: cooker: Rename __depends in all multiconfigs
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
X-List-Received-Date: Wed, 29 May 2019 15:37:18 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Ping

On 5/22/19 8:35 AM, Joshua Watt wrote:
> The renaming of the __depends variable to __base_depends and file
> watches needs to occurs for all multiconfigs, not just the base config.
> Failing to do this for all multiconfigs will result in a huge increase
> in the size of the parsing cache (about 5x for a single mulitconfig)
> because all multiconfig caches will still depend on the base config
> files. This will also seen a similar jump in the amount of time required
> to load the parsing cache from memory, both because the cache is larger
> and because of explosion of additional existence checks that must be
> done for the base files.
>
> [YOCTO #13359]
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   bitbake/lib/bb/cooker.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index adc41014e6..78658a1683 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -391,8 +391,9 @@ class BBCooker:
>           if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
>               self.disableDataTracking()
>   
> -        self.data.renameVar("__depends", "__base_depends")
> -        self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
> +        for mc in self.databuilder.mcdata.values():
> +            mc.renameVar("__depends", "__base_depends")
> +            self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
>   
>           self.baseconfig_valid = True
>           self.parsecache_valid = False

