Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail.openembedded.org (Postfix) with ESMTP id 02AAF6C23A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Mar 2019 19:17:22 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id q206so2209611pgq.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Mar 2019 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=OChg0N6OKB3k8oZGu6vaR21QFQm7rKQzs9ClVAN1yqA=;
	b=JBj/8HJ0b+6ifcNA4aDoiRL1ad8aZ5bG/GJ+Zdq7V4ugEG8+W42pu4Aqh6CrC77oy9
	wCH5Q9RYh+vlEYda4qFj3rKgoQLih+WxUBZJdi3Pnd53Ota4KnI83wGjK0erIO453CiJ
	ssru2N9hwFEFpVusiySfHCd9qMuuFvJKaNlAGMwtL6ihWRWrmuflHY/LBMFc2js9gZOY
	SP0MLcSQ0iVGaxuI1/m5uYkoi68F+XSmnza/Qz9y2K2NhC7Ab/BRLmPFwe4zx5c0jw9P
	2aAqwRTMqIUGeF5I4F/ltDaaf2qKWtpn98/ItgsLFHL4/MrnPoZnedvdeEFkJVr4TKrR
	wkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=OChg0N6OKB3k8oZGu6vaR21QFQm7rKQzs9ClVAN1yqA=;
	b=SGv98CGPe1viJm/JkP0YcQNTVk+Tuw5Km2HY8bNfX7jB+0g9eMi7A6jzmoGZDfQCzZ
	EDgBrxpmrRZbGLFWFuO1OpHZWlz3ovMn8VjrXqpDw05wXlGGOsuCoW2vxbmCGXf1FGrH
	1ExAfCp+OdqGeLuWxeUrblruPhvaBZdo+PwiwW7MugYNGkjeAGKP9VQDHyZWHuLawLSe
	tPi4RuHNdc2K5D3VhOh+uorr9emOVpAOMfb8B/9OTLqki1LdMjH6t91BrR75mT+/JemK
	8SpfIgRoy0wmWkH5iRl3izzQuzy9vPWg2m/nt/OC2GYSkj74RjGM+wb2U9fMilu49DSd
	8qYw==
X-Gm-Message-State: APjAAAX1QLXBD1s0M4gcGVrBz/cOycQjOJEIPeJl6wxKPqckfbYxJrh2
	lJ/8Wk883Poe51puThX/qmOHtOzl
X-Google-Smtp-Source: APXvYqygno/VjAGhA79wpLjVxtUZrOG5OXHjUMm+hkkKHsVMmqBPQMQi8rP+OaJ+45A9wN+1rBU0wA==
X-Received: by 2002:a17:902:45a5:: with SMTP id
	n34mr10202235pld.127.1552504643634; 
	Wed, 13 Mar 2019 12:17:23 -0700 (PDT)
Received: from [192.168.29.242] (c-71-204-143-8.hsd1.ca.comcast.net.
	[71.204.143.8]) by smtp.gmail.com with ESMTPSA id
	u18sm27928351pfa.176.2019.03.13.12.17.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 13 Mar 2019 12:17:23 -0700 (PDT)
To: Scott Murray <scott.murray@konsulko.com>,
	bitbake-devel@lists.openembedded.org
References: <20190312224627.12667-1-scott.murray@konsulko.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <8edf457e-e537-9f9d-435a-e8acdcf2c3eb@gmail.com>
Date: Wed, 13 Mar 2019 12:17:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: Re: [1.40][PATCH 0/10] Backport gitsm fetcher fixes
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
X-List-Received-Date: Wed, 13 Mar 2019 19:17:23 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 3/12/19 3:46 PM, Scott Murray wrote:
> Backport Mark's git submodule fetcher fixes and a related testcase
> change to the 1.40 branch so they can make their way into thud.  All
> changes cherry-picked cleanly, and bitbake-selftest passes successfully=
=2E
> Additional testing has been done with the Automotive Grade Linux (AGL)
> build, which requires these fixes to build against poky thud.

Seeing errors on the AB for fedora, ubuntu, centos and debian hosts.

https://errors.yoctoproject.org/Errors/Details/232884/

Have not triaged it yet.

- armin
>
> Thanks,
>
> Scott
>
>



