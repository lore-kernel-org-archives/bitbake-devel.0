Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail.openembedded.org (Postfix) with ESMTP id 58C447F973
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2020 08:45:17 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id a5so1553314wmb.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Jan 2020 00:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=en1scPHkFsR9OWLVufQXUzYv7iRqR1zs6TAPc75TT2A=;
	b=eici71ha/M4+T/K2kWDTgcstOWMptT0LbW3+Dh91CDCK4mKA0GSd5Axhds2Lqz94sj
	2RUOsoy37Ts1ZcnYT+Z3YMIdWCtmdlqwKwYU5YomRQdSCpTY9Gq56xDEbxraFe+7Jdli
	F3h1froEBf0CmlA38mtvM6l5JBm1l3cXSesyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=en1scPHkFsR9OWLVufQXUzYv7iRqR1zs6TAPc75TT2A=;
	b=HGGOzRqtr8ZsuIP1uL8gXtVVGRV0ikYVDbbQ+XYUhARITzj8zr1vEwxtWXkCAvNfi8
	ZDAqmBCGU8vo9ZAzyMl0ibU+kfE1ypNya22Dx9hODXmd0x6Uzs6O/adpBZNCpa2xc5xD
	yxZ8vnwFXMj2oVI865lSxo+bLgR9kMD9NeyPdSQsCn8PqS/NlIxlDvz3FZbqe8DtDzQP
	EU5WZof6GGrq1waAVYwRj2mHTSlvmmycXx8nxf6n7C7ftCSTAaHl83ja4qjGj/VEg6y6
	v80N+nrs43PYFOeEKU5VWRjMUgBHHJzJ+pxg1wPdrFHwnxkbhMbdbFZEtrHU7fBOFQNS
	CsAg==
X-Gm-Message-State: APjAAAWIw9hTeJ6R8jEXf2ZadRn5rqKGG7fPiHZI8WRJaF2a+NtHn3TA
	t/UF5GZbnlDOTgGiyYiwaheaOw==
X-Google-Smtp-Source: APXvYqykcXpnNbqRhl4qrAkUDFRO9LAN8HoGyyjt7ztdpgaduyh48J/BIX+IG1M345OFC0woQExdbA==
X-Received: by 2002:a1c:1b44:: with SMTP id b65mr2288578wmb.11.1578473117931; 
	Wed, 08 Jan 2020 00:45:17 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id c4sm2928673wml.7.2020.01.08.00.45.16
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 08 Jan 2020 00:45:17 -0800 (PST)
Message-ID: <7825085b36a17ad9010339af39d4647f866786cd.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Masahiro Yamada <masahiroy@kernel.org>, 
	bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Wed, 08 Jan 2020 08:45:16 +0000
In-Reply-To: <CAK7LNATpVF28nWZ1NsOhe7btPs5Gu7eAjsFjz9AuYncLu+EUyg@mail.gmail.com>
References: <CAK7LNATpVF28nWZ1NsOhe7btPs5Gu7eAjsFjz9AuYncLu+EUyg@mail.gmail.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: Question about the behavior and intent of recrdeptask
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
X-List-Received-Date: Wed, 08 Jan 2020 08:45:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-01-08 at 12:14 +0900, Masahiro Yamada wrote:
> So, the concept of  "recursive dependency" sounds
> somewhat odd to me.
> 
> I guess I am missing important use-cases.
> I'd like to know the reason why we need recrdeptask.

FWIW your description sounds right. We need this flag for several
reasons. Firstly, it models the behaviour older bitbake had before we
switched to the full task model so it was partly there for
compatibility.

Secondly, it does serve a purpose. For example, if you do "bitbake
core-image-sato" and have PACKAGE_CLASSES = "ipk deb rpm".

In this case the user expects debs, rpms and ipks to all be generated
(the do_package_write_{ipk|deb|rpm} tasks) to be run for all recipes
involved in core-image-sato.

Since we only build the rootfs for ipk, the debs and rpms wouldn't bet
triggered unless we have the do_build[recrdepends] on do_build.

If you really wanted the other behaviour you would run "bitbake core-
image-sato -c image_complete" as in that sense the build task is
otherwise pointless.

It is a weird dependency though, I agree.

Cheers,

Richard




