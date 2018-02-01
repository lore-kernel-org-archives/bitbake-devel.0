Return-Path: <nathan@nathanrossi.com>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
	[209.85.220.175])
	by mail.openembedded.org (Postfix) with ESMTP id 6C8C678698
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 13:29:21 +0000 (UTC)
Received: by mail-qk0-f175.google.com with SMTP id d18so19313354qke.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Feb 2018 05:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=nathanrossi.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=dOGHRDPM4He+TH3cSqDOR93+FSCDxEoL1S3PxRS+e+k=;
	b=JjM6qNo5cTwlzVYdgSVw/hg5Sgs9GntdMBnqSWJf0/QovVkLcQKO9IyAslz87JWEZ5
	KXRjuDti1yfBA+sdm7FrjDgLcp6dG4ANEUTT1MK5HrmUNsN3CTEfZGSC/YRRaxXTsdXq
	+lZR322wW+LPHalkvmncjhI2IhJlJ8/H09v+g6VFq/4m1Lh5WZrvJowmIDFjzv8Qe0r1
	XgvZR94zMHTv6l5A5ej+X7QmO/+pLS2eY7DihN6mSM5S9QXYsk8b6p2/pza2l6UIVed+
	iifcA71QitYYLtqgpVXSGTxVEHAZsipa0xRwXEMOmrKAg/Qd18EdKJlnEkVNTMxstnho
	AQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=dOGHRDPM4He+TH3cSqDOR93+FSCDxEoL1S3PxRS+e+k=;
	b=JiQyHH4W3SLQwBkXXQJDdFGs8SwcLz0G5Duv+jf6RsuegjWaHmYTzv1DoAJbSqvRFF
	mjgp0CSpBvG9E+P+D8YDwxWZcq/xVecLUnbovi0eq5yTQ/pWHN++e/+VvzyKZAtrtw3e
	LZlMC6aGVVmWcPl6PiXwumrLhekr28EL7IFRm6fIUfm6TzIrOeRgpzwfpVaQTQcV+06L
	VLhQTRqQpJhPrgqbNR03lJ3fv2dX5OVhL4AiQ7Cxqtm1vqsygKWH0ZZPJ/NfwULfGwq1
	quUgoXQPGh/KLH9AgLXQPD3+kRZy5sAdc8FH2D8+ZIodh7dm9d+fI685xA6w4xr6rfS6
	hoUw==
X-Gm-Message-State: APf1xPAjnQVgP14YqdNXVilAyOzfWn2150lJ4nJG8NtYMTg6odrRGGUm
	u2pFm32Fh1648HlZUNAAtjtSxK+uy1g8NEtPrGnZvw==
X-Google-Smtp-Source: AH8x224eaMJLeQoAJPTjqnASMg4MOEVjhD8vI2ABad4WVYNVMHEZL4HNFh34a3htXeAYiGTICUZUaANAG83xP2+cJLQ=
X-Received: by 10.55.130.134 with SMTP id e128mr2365744qkd.333.1517491762353; 
	Thu, 01 Feb 2018 05:29:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.176.51 with HTTP; Thu, 1 Feb 2018 05:29:21 -0800 (PST)
In-Reply-To: <1517490758.3090.44.camel@linuxfoundation.org>
References: <20180131150728.20962-1-nathan@nathanrossi.com>
	<1517490758.3090.44.camel@linuxfoundation.org>
From: Nathan Rossi <nathan@nathanrossi.com>
Date: Thu, 1 Feb 2018 23:29:21 +1000
Message-ID: <CA+aJhH2Ls6Cuk30ROM3K3Y8BpijyNWu5Vn85XMeHwdbQCVwEDg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: Handle missing donestamp file when content is valid
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
X-List-Received-Date: Thu, 01 Feb 2018 13:29:21 -0000
Content-Type: text/plain; charset="UTF-8"

On 1 February 2018 at 23:12, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Thu, 2018-02-01 at 01:07 +1000, Nathan Rossi wrote:
>> In order to allow users to manually populate the download directory
>> with
>> valid content change the assumption that missing the donestamp file
>> means unfetched content.
>>
>> This allows users to populate the download dir without needing to
>> create
>> dummy .done files such that a user does not need a PREMIRROR when
>> using
>> BB_NO_NETWORK to provide valid content files in the download
>> directory.
>>
>> Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
>> ---
>>  lib/bb/fetch2/__init__.py | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> Could I persuade you into adding a test of this in
> lib/bb/tests/fetch.py?
>
> The advantage is that then we hopefully don't break this again!

Sure, I'll sort out a v2 with some tests.

Regards,
Nathan

