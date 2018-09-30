Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by mail.openembedded.org (Postfix) with ESMTP id A8A2874765
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Sep 2018 17:09:48 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so7483447pfi.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Sep 2018 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=U+27NcLhexhejNfz1tjDRaCZ5Cn/VTcIly963TYWvvk=;
	b=btGozIb5sGp7dyRabB4xwRsDb8yxQqxM6OKJwyN5eRl/VTG4Qrnbz0c5coB98p33Jh
	eOpp8ew1LH9A01tuWu8KPrwNHWLbTVYr0rWrQJUvBd7VFYiiFRpbzSVM52wiBSHeMG00
	Fb2oKCASmGamHfiJSPExnZKj8gCY9cqtTUOmBmaP0VwGyVYuOe1t9CjfpliJLULAgyZx
	YyR++PzYaK0VBSgELLWsl1fJ+RK/NuEnJQ9EjhBV2/TjtiZBsgEIHkcJlq12Zbpg11iH
	25c27MqjEzUUmKxwfivLK+M9OSDLFuhQjXHphW1E6nq10QwvuA9QsoEyLwHXglzCSDVo
	6d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=U+27NcLhexhejNfz1tjDRaCZ5Cn/VTcIly963TYWvvk=;
	b=F2qjASP2b5YpY3v8ZwIuYJqpkbVljc9IAowHeLPnCAARz+UynOpkpgVOWwwW8xJLTq
	IgNpwgtlIg9no9D6zsPNgMauiadfNzBHbfzZv8q8PEqze4PP9a6jNa/4nztqm/Ko5GXd
	N7qao2ZFbH7WQyDluMX+JRsTXy3254kpY+eUORWozuGfKKblocmYy2LVEqGbH55Q59i+
	e4Uc11O6jElMUEejPW6p7Dihf9aSUCRH1IfanwxcRiPb75y2hc5m3QIcNbvEMgIHUZt0
	vNxdwbdwrs57c5zC1W5sLAq48+clNIKEGt9eCucyXG1SKGNW5Bub3BJiuvs43K6oGVqn
	aiiw==
X-Gm-Message-State: ABuFfogdNjw9jIZAQ5vfMcXaR8Q4oNBfLGWlkagt2gt4/h7/2lPve1Pq
	MNp8ieuZAgW3fWEtnHLwomNIZeCu
X-Google-Smtp-Source: ACcGV606F4meaN/rRFT5NjO4q6mD2Hs3s1z9DbIzpCYPLxEE36tDR4rYFPUSvQQ11yzh+/UKTecfXw==
X-Received: by 2002:a17:902:2:: with SMTP id
	2-v6mr8207699pla.178.1538327389566; 
	Sun, 30 Sep 2018 10:09:49 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:d58e:d32:beb0:c4a3?
	([2601:202:4180:c33:d58e:d32:beb0:c4a3])
	by smtp.gmail.com with ESMTPSA id
	c1-v6sm12175243pgp.34.2018.09.30.10.09.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 30 Sep 2018 10:09:48 -0700 (PDT)
To: David Reyna <david.reyna@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <cover.1538292172.git.David.Reyna@windriver.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <bb104247-dc6a-5a1d-6c4d-3f1fef79a9a2@gmail.com>
Date: Sun, 30 Sep 2018 10:09:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1538292172.git.David.Reyna@windriver.com>
Subject: Re: [PATCH 0/1] [SUMO] toaster: fix bitbake flexible path error from Bugzilla #12891
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
X-List-Received-Date: Sun, 30 Sep 2018 17:09:48 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 09/30/2018 12:30 AM, David Reyna wrote:
> From: David Reyna <David.Reyna@windriver.com>
>
> Summary:
> In the previous patch that implemented flexable bitbake paths, a old definition
> of the bitbake path was left in the code, undoing the functionality. This patch
> addresses that error.

yep, this applied cleanly.

thanks,
Armin
>
> The following changes since commit 3b8dc3a88e28546100a6b0b2f2cc37f44e619371:
>
>   glibc: fix CVE-2018-11237 (2018-09-27 12:17:46 +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib dreyna/toaster/fix_bitbake_path_12942
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/toaster/fix_bitbake_path_12942
>
> Awais Belal (1):
>   toaster: [Sumo] fix bitbake flexible path error from Bugzilla #12891
>
>  lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>


