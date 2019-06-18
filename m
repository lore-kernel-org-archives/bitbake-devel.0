Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id F14797E95B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 16:17:27 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id n65so3503234pga.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=nbPfI4gBZYRXx4+4n3zE2d4G7wsTanWDnOIIgDDJjRA=;
	b=fk2DPulIO4qPpcMA1OO01JftOQjBY4dMxSMn8RzrynSNtEHa7zN9bnvrvDL0gDBkOq
	t+5lpTYSFEenNn33ye0J4+4pUEUY7ceWnkuasSiewsbK4c3gYg8gTuap4dClQ5JwWc52
	seTqgARcp/RiFv9a42bt5USQifiwkqxVE6x1Q1KvmRsNWcs+1iIAW9Ci4JKhw99aQyxy
	M0uadDqNI+bfMFBPwiFAPoAXJHqRxr6sA6oSE53KqNuNEdiF5I7HFQ3U2wGLISrLmZyF
	fm+tvTb66g6C1VNTBGSJv1luBs7Vjoi7mUSW2UOEZxOLCTyvTkmmS6Lje4pBA+sLGzus
	O9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=nbPfI4gBZYRXx4+4n3zE2d4G7wsTanWDnOIIgDDJjRA=;
	b=ApQx14CB5s6SnDKvt616p3EIW8I+YnZ2jVGnf05slG9aMdwmyTLTnaJJ43DQxvTeO6
	Dd73/wCK18MNUxXkVGA20MGEQ433gQFImyK9PUZ3PIUu0vRhdwQn7cWDhrXGI/B8x5/O
	gwASMmZ7vGfZCYV3J27nhj2CZMf8bmSDNJbL/Xku6CuEYzLMgPfV4yeLT7F3J3LpAalB
	uj00QufICWqO3PbZ31UBM/QapcdecrCizZRUoI6+uITNXuc9yxPQwqsmAqFHUmg9v56O
	X+O6M1yFvjDYkyjTjygStLwWw4zEIiYs1heIU3t3s4/F85Dj2h8MGAUFUhoOKHldpQUp
	Ebhw==
X-Gm-Message-State: APjAAAU8V699RKzl46g90YmclUdVHegIL7imHthZKqoTMmwM1yv4VocE
	MmBNI5K0vhgwY/NRKwr4CTbqw8K3aQk=
X-Google-Smtp-Source: APXvYqy36cBKieK//dIE/khv9MGac9C5/7LoBIE0b0BSMl/XI2GCatR6fnaHeXySGVmj2iI1GOE3XA==
X-Received: by 2002:a63:490d:: with SMTP id w13mr3430658pga.355.1560874648800; 
	Tue, 18 Jun 2019 09:17:28 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:748c:5242:a62f:a00e?
	([2601:202:4180:c33:748c:5242:a62f:a00e])
	by smtp.gmail.com with ESMTPSA id
	c11sm14652261pgg.2.2019.06.18.09.17.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 18 Jun 2019 09:17:28 -0700 (PDT)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <cover.1560872271.git.akuster808@gmail.com>
	<21e75add4a5c58632ef8817d9c9c0a94d88fbd1c.camel@linuxfoundation.org>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <8b47a2b7-a927-ab29-5371-e303653a66b6@gmail.com>
Date: Tue, 18 Jun 2019 09:17:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <21e75add4a5c58632ef8817d9c9c0a94d88fbd1c.camel@linuxfoundation.org>
Subject: Re: [PATCH 0/3] 1.42 next pull reqest
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
X-List-Received-Date: Tue, 18 Jun 2019 16:17:28 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 6/18/19 8:59 AM, Richard Purdie wrote:
> On Tue, 2019-06-18 at 08:41 -0700, Armin Kuster wrote:
>> Please consider these for 1.42
>> The following changes since commit
>> 2a823584a5dbc2427060352f3b4798dbb2640cfd:
>>
>>   gitsm: Fix a bug where the wrong path was used for the submodule
>> init (2019-06-18 11:43:03 +0100)
>>
>> are available in the git repository at:
>>
>>   git://git.openembedded.org/bitbake-contrib stable/1.42-next
>>  =20
>> http://cgit.openembedded.org/bitbake-contrib/log/?h=3Dstable/1.42-next=

>>
>> Matthias Schiffer (1):
>>   fetch2: runfetchcmd(): unset _PYTHON_SYSCONFIGDATA_NAME
>>
>> Richard Purdie (2):
>>   bitbake: Add initial pass of SPDX license headers to source code
>>   bitbake: Drop duplicate license boilerplace text
> Do we really want to backport the SPDX header changes? I'm not sure
> that is particularly desirable for the stable series...
=C2=A0I believe the kernel has back ported these kinds of changes.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dv4.19.52&id=3D4a559dfe660378507ccda1aeb556cb89a47be7eb

=C2=A0With so many files affected, it should help in future back ports to=
 go
smoother.

For those two reasons, it seemed like a reasonable thing to do.

- armin
>
> Cheers,
>
> Richard
>



