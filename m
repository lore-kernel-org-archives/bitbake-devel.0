Return-Path: <otavio.salvador@ossystems.com.br>
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com
	[209.85.213.54])
	by mail.openembedded.org (Postfix) with ESMTP id 315656FF3D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 13:48:13 +0000 (UTC)
Received: by mail-vk0-f54.google.com with SMTP id t129so51354236vka.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
	h=from:mime-version:in-reply-to:references:date:message-id:subject:to
	:cc; bh=OPqD6h+EmzXh/burSO7xySSFwlIlDE2BcuR8hCFLhE0=;
	b=MdlFaBxZVeOhljvY7l76OqpcTcTQMbXJnLiKwYTln4u5usJiGlYsjF2fUSjmlY08H4
	sLC00XLyAYv+4pUacJ0Mu4dwD9uAyAY04T04WzO0YhktdxyVNgAp+Z76/WzRDt4MBidd
	Upl60nEDbgioBplueeQWKcH+FN6WS9godRtTaMp8h3XY/bhzcXO3QkSrI+1mx9I2hAHw
	qk0TcrBZBYPVNfsskcSqERjjWxVIOix2eB+iGfPUdc3FVhbV6RsJLTPM+DMZQq+TwPJB
	yqTwu8jeLljVwptG80zxdDxJw1H3pnwXLcdsrhY8RY4kpbimU625Q2mKDs1URKeWNsJi
	BDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:mime-version:in-reply-to:references:date
	:message-id:subject:to:cc;
	bh=OPqD6h+EmzXh/burSO7xySSFwlIlDE2BcuR8hCFLhE0=;
	b=eZ+/G2b0KyFzI5HLjK9TEFEWz7WbqEtX8OQAldyXqXYR1gmEXhYhhHFEgjnQ7Gq7Hx
	jyKy0vm6P7CcHrr4HLiuYK63uvMAiKYCvY1x6U+CU8N6MHOUBVZ5+zvavgQUbi8iVaim
	Qqn8LtGKmrZqcwtG8yZPXXNjQmGX1fqBBBBRDAyzfbTj1RrhhfkXdffvKF44pn3MLApP
	bND+MQEeSy+QfI9rYfLmxJJ9iVBFsJWGqnxdUNbqLVQbv9EISkkTFzRKHYzyc7v72Nkm
	KkXeHrkk/q7bkum1Zx1+6gWZbRb1UvIKNPBMgtCfWcoD0fHA6sGErGdCK5ZTqUTIkUMP
	3MLA==
X-Gm-Message-State: ALyK8tItXue2NMXBUZQuXqQyH5ipqIQ1e+kNWfeLBVoF2Wnb4W+5SCmxXc5TdRIGpRKnZg==
X-Received: by 10.159.33.3 with SMTP id 3mr5006486uab.96.1465825693917;
	Mon, 13 Jun 2016 06:48:13 -0700 (PDT)
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com.
	[209.85.213.47])
	by smtp.gmail.com with ESMTPSA id t64sm3992794vka.4.2016.06.13.06.48.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 Jun 2016 06:48:12 -0700 (PDT)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-vk0-f47.google.com with SMTP id u64so67880224vkf.3;
	Mon, 13 Jun 2016 06:48:12 -0700 (PDT)
X-Received: by 10.176.7.102 with SMTP id h93mr5131563uah.70.1465825691961;
	Mon, 13 Jun 2016 06:48:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.189.21 with HTTP; Mon, 13 Jun 2016 06:48:11 -0700 (PDT)
In-Reply-To: <1465575223.13979.188.camel@linuxfoundation.org>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
Date: Mon, 13 Jun 2016 10:48:11 -0300
X-Gmail-Original-Message-ID: <CAP9ODKrXpD1RC2AVxqszvkM3MZsQ-1dU=BNO4DNzGgCg8k+avw@mail.gmail.com>
Message-ID: <CAP9ODKrXpD1RC2AVxqszvkM3MZsQ-1dU=BNO4DNzGgCg8k+avw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Multi-configuration builds
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
X-List-Received-Date: Mon, 13 Jun 2016 13:48:16 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 10, 2016 at 1:13 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Fri, 2016-06-10 at 12:07 -0400, Trevor Woerner wrote:
>> On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
>> > A few people have asked about multi-machine builds.
>>
>> Do you envision each config also pointing to individual bblayer
>> configurations
>> too? I.e. if I'm building for 3 different MACHINEs, with 3 different
>> configs
>> (local.conf?), then there would also be 3 different bblayers.conf's?
>
>
> No, there is one local.conf and one bblayers.conf file and then three
> different multiconfig files, each one of which sets a different
> MACHINE.
>
> Would people really want to support different bblayer files? That would
> complicate things quite a lot :/.

The multi configuration should imply same metadata setup; for
different things people need to use different builddirs.

My $ 0.02c

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

