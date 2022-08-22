Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F24AC28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 10:35:14 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web08.16598.1661164512390028482
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 03:35:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=S2/TABrF;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id DF7E784009;
	Mon, 22 Aug 2022 12:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1661164509;
	bh=JwTWg+Ej4u8uf/qQIYcO1zZFnCe8Cm+EMjqawFtQCps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S2/TABrF4M7dOyJdHDeOYF9XAi7bnukxA4Kdsamp6QoS8KBr/9E3BJU+YWCXIhzAp
	 Teaa2FRU4ojg/2IpKoLtpWeScwURWWm9AnBcr1PfjnsV6p7LqKn72U5hTJk6rFvUUI
	 FGYFzCvA35ZBjBzzQlu1VjPbcd3Zp+uoAWKXFyMcAxKM387D0Hy7/JWmU/4LiPDlQb
	 JB6+LD2FxcCvY8NFj35U7jSfzu9Duj3S5MORC1lC5RAmlZ/w+HgbB+TlQRmx/mXxQe
	 Kew3APqO3u89q72wFBgRCqOofzfoMwN0wsBCJi3ao2K+X+heV0y+jcs0+xp8dKlOds
	 Wy/PfenSDzsgQ==
Message-ID: <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
Date: Mon, 22 Aug 2022 12:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <Mikko.Rapeli@bmw.de>, Martin Jansa
 <Martin.Jansa@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: 
 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 10:35:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13918

On 8/22/22 10:41, Alexander Kanavin wrote:
> On Mon, 22 Aug 2022 at 10:37, Marek Vasut <marex@denx.de> wrote:
> 
>>> So maybe the easy way out is, if nobranch=1 then fetch everything, else
>>> just heads and tags ?
>>
>> No, this won't do, nobranch expects the commit to be in a tag.
> 
> I don't think it expects that.

Documentation says it does:

https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/git.py#n45
"
- nobranch
    Don't check the SHA validation for branch. set this option for the 
recipe
    referring to commit which is valid in tag instead of branch.
    The default is "0", set nobranch=1 if needed.
"

