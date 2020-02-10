Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 2931B60CF1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 15:17:54 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id m16so8175461wrx.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=QD4MfP9dhvpUO/CgwdYLOZ/vioy42BJ0s9vZP4FuxL8=;
	b=YuSAWPSemrTn0gF0qGgGapoEN8ujSORL7iTt4M/KGAUReFVQxzzpoDjW1xPVgg4/V2
	nPrieDMoJJYkfxVpLA23z9T+eAVJHS8QOjbsR3yIFfroG5ZF+ngUVM7iTGapJwF+mTes
	xbSDJM56stKCYRiHQ9YKAYd3kVItSqhC8GkxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=QD4MfP9dhvpUO/CgwdYLOZ/vioy42BJ0s9vZP4FuxL8=;
	b=YphpiukrZkKTnXk9jNBOx4JR8tx5S35fTstrNCOkvGk+xq0NEp7ejk75rxrur5ho3p
	lyKBDnw33XGQLMoSENNQ0FThUmGJ/JU1NqUL11Hq8HfZ7SmNwKryeuZVTbAN1oQR75rl
	kvQi9ITs/mYF3AO5vkAqeFQHBHSLMdflF/+ZltIjndhmBB4cBiC2UlMzzawfoRsaGbjp
	ixiW+Bl36F/TjhPX2hssarb0XtAxPAzjabSbypSs53pJXn53LN8DVo3mTiI7WlwFF8ll
	hEIzOQ5DoHGPmy0nijVQ/zcL9pxlCS6AvhfUFEJ8jA+Pf8rYUA7GKoK0C+GOOA6j0KbD
	0STA==
X-Gm-Message-State: APjAAAUJJNYDD7sqjuC9Qb2T6AAIvwnnApYiXlfkANPhnx3q4zwaeGA2
	DOgMsUZacIlgaX/PeYFZbq6VC9+dIjU=
X-Google-Smtp-Source: APXvYqwQb0GGbIF8I6IH9HCUn6SLdotWoqlJ/YsNizepPXILNB1A4o5saLU/zDNC8l4e8av+xjHW/w==
X-Received: by 2002:a05:6000:1201:: with SMTP id
	e1mr2547392wrx.386.1581347875724; 
	Mon, 10 Feb 2020 07:17:55 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	h13sm1030829wrw.54.2020.02.10.07.17.52
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 10 Feb 2020 07:17:54 -0800 (PST)
Message-ID: <a65f29e07265027e7a057b450d9009745389d5df.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 10 Feb 2020 15:17:48 +0000
In-Reply-To: <68698044e91d4c4dbaa60d63260ac7f7@XBOX03.axis.com>
References: <20200209085034.16349-1-pkj@axis.com>
	<29677f1ba34d00b61ad1375b38f56b20c3e98d50.camel@linuxfoundation.org>
	<68698044e91d4c4dbaa60d63260ac7f7@XBOX03.axis.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [master][zeus][PATCH] uihelper: Track scene tasks again
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
X-List-Received-Date: Mon, 10 Feb 2020 15:17:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-10 at 15:01 +0000, Peter Kjellerstedt wrote:
> If a setscene task is rerun, won't that just mean that the counters 
> don't change due to this? So in this case there won't be any
> progress  to the total progress bar even if a task is running? That
> should still  be better than the current situation when they are
> never counted.

No, that isn't how the code is written. You'd see "task 1000 of 500".
We got some pretty horrible numbers when testing this originally, I got
lots of complaints and its why it was removed.

The code has changed a bit since and we probably don't rerun as much
but we get complains when we print any invalid info...

Cheers,

Richard


