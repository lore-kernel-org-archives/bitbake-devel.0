Return-Path: <schnitzeltony@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail.openembedded.org (Postfix) with ESMTP id 20A3E78F61
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 08:43:54 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so806693oie.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=GXNG5GmQHJVQRIkO7xR8vgLHlMsvUAgB3VclTTZAy54=;
	b=PsxTI9kt7z2mHspJlplvUtC8aD/EuN2arDP5gNOLXwPMSUewttpV2nfQRVRZOl3XNk
	ZU4RKsstIoXO4gXEgWAu/e1IVfPgCPJGv5TzcNbj8SGWY6o+FvcOsDg6joHYknnNGabn
	dUgIHffvV2Mh+4QSj8XftSArtPw03c6nSRdPQ6x+eRVTvNhzs732PEI1UI6zwhMU9icB
	S/gPR3VqLHvkuXpE4ld7wVYoq0vvaVB5PHdVvEIg5vKoeWfpKMW6htkuhzfyUkZB0WPG
	8aFAk6wbIuQAP8jhRkBMxhflRJAQknvKg5W7/cNf9KCfng7WQuu+EKMKQyRZU12RqBIu
	XZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=GXNG5GmQHJVQRIkO7xR8vgLHlMsvUAgB3VclTTZAy54=;
	b=L3YocVnsqiKtGxy1nrE40p8AASXGKQom8KknDdlla/g28Mu+/XapXGEaeT43U9MfVB
	QUWP1Ie7LUdpssw5rJTuHcDkHRwZIyKT+jrSivx9bM7o/WjXVSTMi/26MiCWtq/h1wmL
	uZyyjZOEqHVDrIJQOZ8ExkkObPra/x6ax5KgL7lL6sTv+sz0xThfgcROlzDS4hHLMNHU
	R+AoDPcO9J3GhWlZ59QJdcz7C71GbWEtQnkerWEZ2/VFtH+vV8oJ8qB7Q4aI0Xw8oX7D
	CIObpjqxkI/J3jEf7xTZSVulYvLawIbMWPMlOHxyCljDxSRTqLMGwoS4ceYRoKWpHETe
	LxHw==
X-Gm-Message-State: AOUpUlEVu62LGY56V11dNsmPKP2b6JSIkMpFTGes9+fJkrpvR31FpoHh
	8IAQq4falJEjP0R0eQdmcegKdvE7o2xxm5UY/n8=
X-Google-Smtp-Source: AA+uWPwuYNonRTnpfG6XTBkQRPEkEZuHPN2q3odEdB2ZMAZKhVrbXE/lvwriymSrNWN6ebp5RB79uYKlbxdPOd4zQLI=
X-Received: by 2002:aca:4fd1:: with SMTP id
	d200-v6mr27701621oib.224.1534322635930; 
	Wed, 15 Aug 2018 01:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:590c:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 01:43:55
	-0700 (PDT)
In-Reply-To: <6f9b4884358d08f5e4e35ebd9b683218ef0e40f0.camel@linuxfoundation.org>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-2-schnitzeltony@gmail.com>
	<6f9b4884358d08f5e4e35ebd9b683218ef0e40f0.camel@linuxfoundation.org>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Wed, 15 Aug 2018 10:43:55 +0200
Message-ID: <CALbNGRTq-9LUPa2hTYdU7Gtp6+vrFK8YD9O_XTMaofRVtQSN8Q@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] runqueue: Move decision if a task can be started to one common place
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
X-List-Received-Date: Wed, 15 Aug 2018 08:43:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2018 at 10:37 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Mon, 2018-08-13 at 23:04 +0200, Andreas M=C3=BCller wrote:
>> Signed-off-by: Andreas M=C3=BCller <schnitzeltony@gmail.com>
>> ---
>>  lib/bb/runqueue.py | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> I don't think it makes sense to take 2/2 as the gains don't seem worth
> the complexity.
Agreed: Meanwhile I found that importing psutils seems to break wic.
> 1/2 is a good improvement to the code and makes
> experimentation easier so I'll likely take that though.
Thanks
>
> Cheers,
>
> Richard
Andreas

