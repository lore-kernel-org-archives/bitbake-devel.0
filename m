Return-Path: <akuster808@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
	by mail.openembedded.org (Postfix) with ESMTP id 938D571957
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Nov 2017 17:00:34 +0000 (UTC)
Received: by mail-pg0-f68.google.com with SMTP id v78so4992984pgb.5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 04 Nov 2017 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=2vJW/qE509CPAdwkuwYwlOI4ZsqI2DOthai0CaXyZVo=;
	b=fkUq+on45vv88A/XQpNuWJc31XQ1aONEJvcU2rSo9hsgRb2Dze6r1rz0KQU6bip/8i
	fWRSwd3NBqL2DQ84999VDWqwPSqo5gZTplUpboe/o29f+LnFBdcP4ly5Qzq4OwpKpMG0
	TPhlHgzgyz+rnkgUznD40DHXanh0vLtJZZmEUU4ws8JHUlbNsaze6+0XacEG1eP3wMTN
	cRoTF3hmWWLTS0bGiAlMNliBelIYUAg/1uiq0F9fpiQ21mFXaatX59/f69zp2tOrdUKY
	YVyZsMrs2zqHDXacve4ty8DUeMCEhVMiN0b6t6m/+E49F9bCI70kGX9dgGTeyp9OV/Sj
	EzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=2vJW/qE509CPAdwkuwYwlOI4ZsqI2DOthai0CaXyZVo=;
	b=SE2rjie8KG8kBEj+DGTZ5b/OrsC1C/MVkY3m7aWZ9pULVlbqpQnESaymks6899rCzI
	05Jw0vgalaZspgjAUWI8/JjYvIbrNeWsHmePiaFRgAEds4syGqAL/UwsDPaX+UKa+0b9
	yTPMSjGVpj8IjExtUN8Bheca13Kb7Hya5jsEqYyP/VyCIoqMLqPaT98UvKzy82mcRP04
	bySCzqMDOonZr4TlQsFGMEZr6rPwnplAvdpXJ1AZ3FX3FXrjXh2a+Y/38+8UuYBu7L4S
	HMVmhRqdvkULbKFCNSWlQo7oDu/q4zzxZF+dkXdYx740ZU2UT97m6MgAni7agpCc/dCb
	SHYw==
X-Gm-Message-State: AMCzsaVA5d9IF5gD3VZjoqt72VgqhPnUxz15Vwa8Ech7YgsFdYX5+Hu0
	7D86yu76YaO/2ICnWBJz+doyQA==
X-Google-Smtp-Source: ABhQp+SmSk3Ob4nA+InQhpJGOgXqFT5B72C1oHBUfzO4TfUrLK0dxwAZA3DsGGUmqDhTvctXIDCiqQ==
X-Received: by 10.84.163.75 with SMTP id n11mr10028232plg.287.1509814835136;
	Sat, 04 Nov 2017 10:00:35 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:3432:9512:99a6:da36?
	([2601:202:4001:9ea0:3432:9512:99a6:da36])
	by smtp.gmail.com with ESMTPSA id
	v14sm13445112pgc.78.2017.11.04.10.00.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 Nov 2017 10:00:34 -0700 (PDT)
To: "Viguera, Javier" <Javier.Viguera@digi.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <20171017133121.19524-1-git@andred.net>
	<20171018065135.22771-1-git@andred.net>
	<DA8287CC96892A4EB4FCF4FB3FBDA1AB016B4688@dor-sms-xch01.digi.com>
From: akuster808 <akuster808@gmail.com>
Message-ID: <644a8ad8-d2aa-a44f-b666-e1a2dcee72e3@gmail.com>
Date: Sat, 4 Nov 2017 10:00:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <DA8287CC96892A4EB4FCF4FB3FBDA1AB016B4688@dor-sms-xch01.digi.com>
Subject: Re: [1.34][PATCH] Replace deprecated git branch parameter "--set-upstream"
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
X-List-Received-Date: Sat, 04 Nov 2017 17:00:34 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US



On 11/03/2017 04:16 AM, Viguera, Javier wrote:
> Hi all,
>
> Last night Ubuntu 16 updated git to version 2.15, and now this is biting us (and I guess many other people in the wild) on releases based on Morty and Jethro.
>
> I did a basic test and for bitbake 1.32 (Poky Morty) and 1.34 (Poky Pyro)  a simple cherry-pick works just fine without conflicts:
>
> git cherry-pick -x 2ab50074c1a6c56a8a178755de108447d7b7acaf
>
> So could someone do those cherry-picks in bitbake and then move those fixes to Poky Pyro and Morty stable braches?
These are in my pyro and morty stagging branches.

thanks,
Armin
>
> For previous versions the cherry-pick does not apply cleanly. I'll try to find the time and send a proper patch for 1.30 (Krogoth) and 1.28 (Jethro).
>
> Thanks in advance.
>
> --
> Javier Viguera
> Software Engineer
> Digi International® Spain S.A.U.
>
>
> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of André Draszik
> Sent: Wednesday, October 18, 2017 8:52 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [1.34][PATCH] Replace deprecated git branch parameter "--set-upstream"
>
> From: Andre Rosa <andre.rosa@lge.com>
>
> Since 2017-08-17 (git version 2.14.1.473.g3ec7d702a) using deprecated git branch parameter "--set-upstream" causes a fetcher error. Replace it by "--set-upstream-to".
>
> https://git.kernel.org/pub/scm/git/git.git/commit/?id=52668846ea2d41ffbd87cda7cb8e492dea9f2c4d
> says, it's deprecated since 2012-08-30 so hopefully all still supported host distributions have new enough git to support "--set-upstream-to".
>
> ERROR: PACKAGE do_unpack: Fetcher failure: ...; git -c core.fsyncobjectfiles=0 branch --set-upstream master origin/master failed with exit code 128, output:
> fatal: the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead.
>
> ERROR: PACKAGE do_unpack: Function failed: base_do_unpack
>
> Signed-off-by: Andre Rosa <andre.rosa@lge.com>
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> (cherry picked from commit 2ab50074c1a6c56a8a178755de108447d7b7acaf)
> Signed-off-by: André Draszik <adraszik@tycoint.com>
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py index 2550bde8..7442f844 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -326,7 +326,7 @@ class Git(FetchMethod):
>                  branchname =  ud.branches[ud.names[0]]
>                  runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
>                              ud.revisions[ud.names[0]]), d, workdir=destdir)
> -                runfetchcmd("%s branch --set-upstream %s origin/%s" % (ud.basecmd, branchname, \
> +                runfetchcmd("%s branch %s --set-upstream-to origin/%s" 
> + % (ud.basecmd, branchname, \
>                              branchname), d, workdir=destdir)
>              else:
>                  runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=destdir)
> --
> 2.15.0.rc1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


