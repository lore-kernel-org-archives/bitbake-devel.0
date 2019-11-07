Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 7489C7F7B8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2019 19:50:14 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id z19so3828518wmk.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Nov 2019 11:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=UeKwmBA9zHJI/6wvvCwiGD3eEbkMSsUo2fiSbx3STCk=;
	b=JSMlEQSyMDhiV+YkWKXFzC4beazHjdaggvHmTbTTUOtvJB+jEsYIQ9iXy/CiqWKpeM
	QSruOzUQBD1yxHoJ1KqvNDvntyVs6ETThgPcoDMqq0e5Gxo5pkgngcNRrqggdrdb/1rY
	bxcT1tAx21+8u2sRlS0eYzlyLhCzy9W6Cst0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=UeKwmBA9zHJI/6wvvCwiGD3eEbkMSsUo2fiSbx3STCk=;
	b=rTsuE3dH1+BwbQhMjVnQ9AretSdVmblw3vs+ArWPpI7n/ZmVKFLOEjPo1f8A4PDzqF
	KJgy0eJHTdi2G4UCUrR+Bp8yR9lAL53KeVEecTicKWd4d8Ztz3Hnnpi9h9sBKXCssiC5
	SLpfGhqTVTdJnFm9GmOg5teeT0EoIvlkcqvXI73/LA2JPKtqJOuMw773dz1lL+13P1Do
	rZs/iWQXmiQDP58fgWpQtyOyUTEFea6+zk7Cziiam6vjT7M+rL+TJLIP3hweMMzYqQUE
	ImOAIZsdnPJ8fwiAcb7NysFwuGyDuUuVM3ymqL07AZQ7CPYpYuquxm1wO3aR53Bi4kgU
	o0JA==
X-Gm-Message-State: APjAAAVSQ5EdpmGsbO8Y9aWVsTFULauD2A2ttvlO/zZwbK9ZCStf2cm8
	9FcCYk+Fp1PWHsDg4ws7UM/P0PHAgHc=
X-Google-Smtp-Source: APXvYqwstD9t+gqngvV4OOd8ASS4X9NmhaGEro6fLsA8rJOiQELwmFpSrkcfAG15T76iiKcssXFNrw==
X-Received: by 2002:a1c:1f03:: with SMTP id f3mr4606361wmf.131.1573156215116; 
	Thu, 07 Nov 2019 11:50:15 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	d13sm3299038wrq.51.2019.11.07.11.50.14
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 07 Nov 2019 11:50:14 -0800 (PST)
Message-ID: <be08b56117e97f23007b6984a0a98999f2644063.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ivan Efimov <i.efimov@inango-systems.com>, akuster <akuster@mvista.com>
Date: Thu, 07 Nov 2019 19:50:13 +0000
In-Reply-To: <1370792230.5885.1573108512017.JavaMail.zimbra@inango-systems.com>
References: <20191105140735.8204-1-i.efimov@inango-systems.com>
	<c080c0f1-426e-e40a-c4f5-3e66c6f7fd86@mvista.com>
	<1370792230.5885.1573108512017.JavaMail.zimbra@inango-systems.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler
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
X-List-Received-Date: Thu, 07 Nov 2019 19:50:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-11-07 at 08:35 +0200, Ivan Efimov via bitbake-devel wrote:
> Hi Armin,
> 
> I've rechecked that this issue is relevant to next branches besides
> 1.32 and master:
> 
> 1.26
> 1.28
> 1.30
> 1.34
> 1.36
> 1.38
> 1.40
> 1.42
> 1.44
> 
> Could you please tell me what of them are still supported by BitBake
> community?

I think 1.40 onwards are still supported. I've just applied to patch to
those branches since its a clear/obvious fix and a clean backport. I
think I can do that in my capacity as bitbake maintainer! I also added
it to 1.38 since it helps with some other experiments I'm doing. I'm
reluctant to go further back as we have no testing capacity for the
older releases right now.

Cheers,

Richard


