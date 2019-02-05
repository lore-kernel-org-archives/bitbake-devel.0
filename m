Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7398C7C2AA
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Feb 2019 15:14:19 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z3so4044462wrv.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Feb 2019 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=sgqAfcfdsll4TrjWktQccYjndUVp8iofntlnLOYYscs=;
	b=C8kWsnpnbcjllW0Zf5DSLO/7L84fmn1IiOzufKuMamK9nrcQRm1c2bAEUaCo/8XQvJ
	2IOiAc0BvDBgoRV48WRtSDjaa/7Ro3IxvGtCf8JvTh9NSlG1vlrgc2Jt2Tfnc+nsMV97
	JKfHYX8FZ2+XcTw6v900dSNUryXY7SZOw10kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=sgqAfcfdsll4TrjWktQccYjndUVp8iofntlnLOYYscs=;
	b=Jh9jB14bLmJmEJ/r1wmWQEBXdmMQAiot+Y6LYb2Z1/zsq/gltmkC2pdKsdUnLOeSNP
	IZp1Pc+CBWfVfDdffE8xjcEQr+Y6H6XzMelL/+VHD/z44WpyCnYSb6ZE8tMQ2oPPI4IX
	C74W5bHT8ktQN/19r5fDPqr4LxTB2cCtj0IDyqok65aL5cg6mjqS4qwXXHNTT4q2xOrb
	zGkNd0+WMlKioDSRiRnTDzdStLC/pzBrhYW2vi6FyRszpNjjzIptrpCD11mCWb7DLw7a
	nQ610UuuO+ooMDqKTj4U/X/zrRL6pvw1TPgFRsJh4+7W2YztfS3Wkq8Yaqy53qjnWpmV
	I25w==
X-Gm-Message-State: AHQUAua2YAK7XB5WIs/SDSFEO1A1P9ou+GyRqGP7xO0cQMkt879qrEXx
	cJCmSX9KxAFgjAd7OtdCk6zIJvV+4w8=
X-Google-Smtp-Source: AHgI3IZPPCQqLg6Z18SyDW5FEnxFEwad6STv8fN93ESLWfG+0C+75GdHwOQb79a8yvhJv8lRu2Lz8Q==
X-Received: by 2002:adf:c846:: with SMTP id e6mr3880478wrh.243.1549379660020; 
	Tue, 05 Feb 2019 07:14:20 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	h135sm18802505wmd.21.2019.02.05.07.14.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 05 Feb 2019 07:14:19 -0800 (PST)
Message-ID: <fe63e0bb8c0a5b572dcb038f5af51bbd29fadc72.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 05 Feb 2019 15:14:18 +0000
In-Reply-To: <070002fb5989fd3c629d06ce77d9b33d11982a18.1548400142.git.liezhi.yang@windriver.com>
References: <cover.1548400142.git.liezhi.yang@windriver.com>
	<070002fb5989fd3c629d06ce77d9b33d11982a18.1548400142.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake: cookerdata: Check duplicated BBFILE_COLLECTIONS
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
X-List-Received-Date: Tue, 05 Feb 2019 15:14:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-01-25 at 15:09 +0800, Robert Yang wrote:
> It shouldn't work when there are duplicated BBFILE_COLLECTIONS.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/cookerdata.py | 4 ++++
>  1 file changed, 4 insertions(+)

This caused a load of failures on yocto-check-layer:

https://autobuilder.yoctoproject.org/typhoon/#/builders/39/builds/259

We may need to fix that behaviour of that script?

Not sure if this is highlighting a bug or not...

Cheers,

Richard


