Return-Path: <akuster808@gmail.com>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
	[209.85.160.65])
	by mail.openembedded.org (Postfix) with ESMTP id 96E51748E7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 May 2018 14:22:36 +0000 (UTC)
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so9049299plo.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 May 2018 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=jAXAm4NFXGU99RWizkx9VwBPBNRQKTS2OKg/PLkoap8=;
	b=RgE1tGVdXROc4swE7Xblf0XR/lEzR71naiH0MgE3WJ93kWNZ1u3ohjerzR406P+sz1
	/0W6mU2kgNzClxU5WM2Zef+3B1RW5sOiie4TGJhEHSSaC4zX5hM+FFHUkwmoA2jDZXfc
	sEft6TRrZ2hR7go0Q1ykPok7FK7zs4kJU17Nu2mpnXFpkn70JmPZtdc1y8U3OpO0uIk2
	EtUK1IlR5q3lppRS++AYzyjuhUF+oh1mMCKbQzLoyI6ADkYy6T/DJTpE74u0AKPOlvr/
	ua+7JmbxM9qMQX5h9gTViYUk+QvQbj5aHcZWbv1WbKTrOTryDJTjHHDfFM/bSv3Xiy9j
	5nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=jAXAm4NFXGU99RWizkx9VwBPBNRQKTS2OKg/PLkoap8=;
	b=nbCs1aW233hWiiaoVNhP5teaF5h9vCiEdiJJRJUVEwGvk3I1+HPcxSJQWtI48eFE6y
	oP+hLBxuFIaRuGMmXP2X013xMmKYLKqlxusifNpg4sYcqS0NCMQPWobdn6Dje3oaDeun
	93kvnhdZhdsvuqlFh9H6yXkP50JoImU5Sgt/nOCYTsz3JqEs1yrTPd4uVPd+aBdks1us
	W9plIQw0ZLKZHV44fLj+MJS1YgHy8qMgjj2xY8+YhOw5mlS5yoKTT9vd41akHDJ8srlw
	IcRsQqQhECbfZyZdcr0o/tVM+OOS0blv6v4j3+huiTYGn7kydMPkHZ3HxxrjvoiF7CcO
	7eTQ==
X-Gm-Message-State: ALKqPwdKrfrrSghM3OCqiUd6io6mX4rq2AfZWeeRD/94Ot6lK7dNlJiF
	bJH9PywrNi3EGy9NzRmuAf689A==
X-Google-Smtp-Source: AB8JxZq3LF8tKFm3EXCcv0W6COwo4hBN0mFEkRtBcEfIrTiohhDjvcQ91+COd8IHzEQUZFy+QNK5Bg==
X-Received: by 2002:a17:902:f83:: with SMTP id
	3-v6mr17735307plz.336.1527603757259; 
	Tue, 29 May 2018 07:22:37 -0700 (PDT)
Received: from ?IPv6:2601:202:4000:1184:f974:961e:eaaf:e53?
	([2601:202:4000:1184:f974:961e:eaaf:e53])
	by smtp.gmail.com with ESMTPSA id
	r130-v6sm33618689pgr.87.2018.05.29.07.22.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 29 May 2018 07:22:36 -0700 (PDT)
To: David Reyna <david.reyna@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <cover.1527564213.git.David.Reyna@windriver.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <3f10d959-5725-cd14-68a6-000263af295d@gmail.com>
Date: Tue, 29 May 2018 07:22:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1527564213.git.David.Reyna@windriver.com>
Subject: Re: [PATCH 0/2] toaster: broken custom.xml and threads patch
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
X-List-Received-Date: Tue, 29 May 2018 14:22:36 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 05/28/2018 08:26 PM, David Reyna wrote:
> From: David Reyna <David.Reyna@windriver.com>
>
> The Toaster for Rocko is broken on HEAD. There are two patches that made it into master and Sumo, but missed Rocko.
>
> The first patch fixes an error that breaks the initialization of Toaster.
> The second patches fixes a change in behaviour for Django that creates an extra thread that blocks Toaster from shutting down.
>
> The following changes since commit 7e7ee662f5dea4d090293045f7498093322802cc:
>
>   build-appliance-image: Update to rocko head revision (2018-05-23 17:46:34 +0100)

thanks for the head up.

- armin
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/broken_customxml_threads_12751_patch
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/broken_customxml_threads_12751_patch
>
> David Reyna (2):
>   bitbake: toaster: do not fail on optional 'custom.xml' file
>   bitbake: Toaster: fix shutdown and extra threads
>
>  bin/toaster                                                 | 4 ++--
>  lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>


