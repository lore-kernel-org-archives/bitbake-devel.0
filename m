Return-Path: <msm-oss@mcclintock.net>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
	by mail.openembedded.org (Postfix) with ESMTP id ABED8780FA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jun 2017 14:30:05 +0000 (UTC)
Received: by mail-pg0-f66.google.com with SMTP id e187so6326947pgc.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jun 2017 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=ctwhuUeEDx7w0lO3A0r3kL5yE7FA5Vs8qiAi8oLAEn8=;
	b=fKJrzs2StDKNTjkFwRQ4UKuecP9YIOGPBE17RCd7pj/VWDZjFhdq2sSt8YgHD2R5/Z
	1MtHWWI5cp0cbuhz5q5uremsGueoINkLCHASkPKZ1dnjDWATa8j6JK+v7fS2RWjOJXjv
	zOLjW4SSQNWE72cCDb5mBPrvXl54W5wF1mFbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=ctwhuUeEDx7w0lO3A0r3kL5yE7FA5Vs8qiAi8oLAEn8=;
	b=rgZwER+JJbTYHXqa9FYY46VCis5YNTAgSJ3G96Y8iJobWh4W+djEJg+DiG3CQvSnGl
	pwxSdMimV2/7QV1WF/RdREmttm0MynQw1g6ILXtO4uZ6QfWTc110XKt9XzRCZYQLBDPK
	mQ0BoqQNfN+gaBg1VBuh+SLWMkw+p/c/N8RAF7EG0VvocHgn/+frBjoQDf1xgi5fJxyP
	km6wAN8XeOlDUpKKS3+OMuVMK40+1U4Ig5ndHL2tAfJ0BQgUT9GSqnzG5lz6BcwahEQS
	YINWqqWPkTP8h2lgPU3IEIf34DqlLj7fMsCbAmXUeWZXyxomQBYRFQsFqLsG9KGphkJe
	QXFw==
X-Gm-Message-State: AKS2vOxTChXgeurTd2XIlALXggfu51Aq9uGFgxEeLSSW1QHVWkuxzRWW
	WdgHPWzVB3iQf82orlqfsmCUrPW1hPBi
X-Received: by 10.84.197.129 with SMTP id n1mr9314474pld.179.1498228206686;
	Fri, 23 Jun 2017 07:30:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.130.73 with HTTP; Fri, 23 Jun 2017 07:29:45 -0700 (PDT)
In-Reply-To: <7c5e6653-c5a4-6622-b40f-58f80a238c07@gmail.com>
References: <1496408567-18673-1-git-send-email-richard.purdie@linuxfoundation.org>
	<CAEsOVNfCAwNkq=dnBWgX=0XXbP7510GRx4Ga=EbYf5yr34vdGw@mail.gmail.com>
	<7c5e6653-c5a4-6622-b40f-58f80a238c07@gmail.com>
From: Matthew McClintock <msm-oss@mcclintock.net>
Date: Fri, 23 Jun 2017 09:29:45 -0500
Message-ID: <CAEsOVNcKduRtHRP9rd4TjDcy3zw5hqe-FtHHEqvMaW4BmOMLgg@mail.gmail.com>
To: akuster808 <akuster808@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen: Make calc_taskhash match get_taskhash for file checksums
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
X-List-Received-Date: Fri, 23 Jun 2017 14:30:07 -0000
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 22, 2017 at 5:29 PM, akuster808 <akuster808@gmail.com> wrote:
>
>
> On 06/22/2017 02:10 PM, Matthew McClintock wrote:
>>
>> Seeing this issue on some older (err, really olderrrr) versions of
>> bitbake. How far back could we backport?
>
> Technically 1.34, 1.32 and 1.30 (krogoth). How far back is "olderrrr' ?

I guess I'm seeing this on krogoth so that would be good.

-M

