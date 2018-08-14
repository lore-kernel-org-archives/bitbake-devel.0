Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id B1DCA78FD9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 11:03:49 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so32755619oih.11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=p0TH/fVpaOXHRCO/e2zt3xb6Qa/1eephkNku3AzvdwY=;
	b=d1bdNA4XFsn6FZERdppeBLsTVAW4W8VVnLj2LX8kX4NLf3xfvP5QRZxH5KfKiIkouJ
	EyLYJrrRYy3RT7s7iqUOo3X8lc8Ds7Lor6ybhvrl6Vp0Z/AKEKTs9DH2/DO9A93Q8TAw
	EuEJ/IEdxIrps4tqqRVs208HbON+Vuf34LwyGQMZPwtygiQsHuExijtG5wjkqWwaIU8Z
	Giu03uKr7rOkHU4BEw5X0IrxCeOUJ6hQgtr9v2x39wzUqdajXq7xgPSP+uMUKkj2zQsf
	TEC7BomrMD2l3Xk20jPmmsf8AhxeMCa+2k4oIEZF0PEZYlsFUi8GonmT2ZtHZ/vH9WH/
	e/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=p0TH/fVpaOXHRCO/e2zt3xb6Qa/1eephkNku3AzvdwY=;
	b=SqeiDyykPxlyoeDXyXGlEsJt2YWw5X9DEVZilGCoIr8Y1SIT4Ze/uQsFBRUTJG9wnL
	LgMcTC03VxQudoBknp82UPv3eXKzyKE7BdYBiXc9u8R5uJCAO2/voF3uEAO2CvXE3QMq
	Xw1IlOBKPUemarBjmTX3R2AevWQuYIrtg8dBoiDtzdRhM4JpZ0nIZBXdK3DQykKIYqPk
	OroRXvM54IOp7kfpz1HMulV4CiNMkKcK2hzBwq2EJ9Vryv4lDLdbQ50RkWEEvkfQvn3O
	ubje1j4bpyRzyo/qW2mxLB3zwYe3C6SvjDWbDTKquQ0nfXzqpyCtEY17RSWiluVAH1h5
	v0jw==
X-Gm-Message-State: AOUpUlGdVNQB9M5Oo48V/Wlox3yLvMrm9s/xYKcHvW815fdFN1D+C9vB
	Fj3z4yIQUy2mfTlATe22XuDbCuDDcezc5HrvVck=
X-Google-Smtp-Source: AA+uWPzo84xPvZkVvN74LrwQKeXW3tVulcWSMWCHIXblANethLl+NvwEUyD/DxiZMa68/V94PZ+nJMMbtUVWVZ9a55w=
X-Received: by 2002:aca:5754:: with SMTP id
	l81-v6mr23618126oib.100.1534244630747; 
	Tue, 14 Aug 2018 04:03:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 04:03:50
	-0700 (PDT)
In-Reply-To: <98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 14 Aug 2018 13:03:50 +0200
Message-ID: <CANNYZj-WM349ZX_j99upQ6JbopcMs_pA0G_6N7hHRbo-Yo2xoA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Tue, 14 Aug 2018 11:03:49 -0000
Content-Type: text/plain; charset="UTF-8"

2018-08-14 11:43 GMT+02:00 Richard Purdie <richard.purdie@linuxfoundation.org>:
> If people want to play, I did experiment with "proper" thread pooling:
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/wipqueue4&id=d66a327fb6189db5de8bc489859235dcba306237
>
> This implements a make job server within bitbake, then connects make to
> it. The net result is that you can then put a limit on the number of
> processes across all tasks.
>
> I seem to remember there were some bugs with it and not all are listed
> in the commit message, I don't remember what the other issues were...

Both make and ninja have -l option:

      -l [load], --load-average[=load]
            Specifies  that  no  new  jobs (commands) should be
started if there are others jobs running and the load average is at
least load (a floating-point number).  With no argument, removes a
            previous load limit.

       -l N   do not start new jobs if the load average is greater than N

Maybe that could be appended to PARALLEL_MAKE, which is far less
invasive than any other approach?

Alex

