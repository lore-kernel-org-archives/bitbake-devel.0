Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
	[209.85.218.50])
	by mail.openembedded.org (Postfix) with ESMTP id BA1DB77BC5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 16:03:40 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id v8-v6so14819682oie.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=mKALz/MHisKHJO+w+n1sp4nnP10K1n7OjpcnqdHVB5E=;
	b=nej/ttS+GUYmfuJJfhg+cmtmr0Ai0shtq5xwwFfyExeu7w3SYkNdj96xGOSzi90TRU
	+puPKuSMqj0+ZVboTOPd0pXNny4NWx9NhX+A4tRJ0GgrMYLDBot15KMIL1P2MuZYHfMv
	4nQALqD3667Jysni+KiEPqa/zj7KyV2aBlORDHCM3Nr2hMaNhD9pfvcyx/FnY69ncZjw
	UAG5TuP12H20ifSDSxpqPLiZOBXrhPX0KUopGKwrbCA1pzCDZfv16FadHBe23ZHc5OWN
	rZdNcg0MZMEo4gTMZA2kWuKw8l740nk4tQNVHYJgtnWUD6WmsoEDIEktWzGVVAM3cPmS
	nRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=mKALz/MHisKHJO+w+n1sp4nnP10K1n7OjpcnqdHVB5E=;
	b=Kq9pkbdk20qdsmZ4LXFbDvF1jEYbHBmeLbWn9mGqqiMvRiRJNtQamx6zDIQtE7y6yx
	nQu6AckatLWH9J5lSvn1H6t7SL83kvlm5Pxjaa21ECZrDFMtGyG/u1HzppG5kJ2k55xA
	7vjZz5kgJ1/eIdSrmBJllz9StpSfeze6+NvJYbAdzk7XmbFgGUnggt0fGKaQEqchMgEt
	ir6T59V/+TAVogj1GkEr1R5lO4g3AQS1oUNNRKz2J4nuYw5ZrZY6fo1KRx6BaXutT/UM
	H4A4DiEmXY5MjCzTrFXTEhXqWjhzkFZqWpAs99W4kcYlnKqLIG5jo+iFVi2exeTGMt6f
	OJSw==
X-Gm-Message-State: AOUpUlH9GQu7/oKpkliUNwpknI29J4aGqQ8wO2S4u1opu5pBXrIbqRP5
	bdRhEZxq1VzD6IizdTDaxTnxWxjjX0RIJfucg/w=
X-Google-Smtp-Source: AAOMgpcfQu+uE4uZh91/RE9i5r2UP7hKLCJ/nTBsM/VmLqZkeeQkZw+3eI3+cgOQGP31C3VWog2XVKC9ERUtKzeypj8=
X-Received: by 2002:aca:560d:: with SMTP id
	k13-v6mr3777561oib.190.1532534621804; 
	Wed, 25 Jul 2018 09:03:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 09:03:41
	-0700 (PDT)
In-Reply-To: <20180725134826.5732-1-richard.purdie@linuxfoundation.org>
References: <20180725134826.5732-1-richard.purdie@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 25 Jul 2018 18:03:41 +0200
Message-ID: <CANNYZj9FTaSLw9Mjx+uLQ6h_nNH7HQwagWHRVv9itQ7kd836HA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] server/process: Always place the server logfile in the build directory
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
X-List-Received-Date: Wed, 25 Jul 2018 16:03:40 -0000
Content-Type: text/plain; charset="UTF-8"

2018-07-25 15:48 GMT+02:00 Richard Purdie <richard.purdie@linuxfoundation.org>:
> Currently the bitbake-cookerdaemon.log is placed into cwd. This seems like a
> bad idea, we can place it in the build directory alongside the lockfile that
> represents the server instead.

Thanks, having these files all over the place was quite annoying actually :)

Alex

