Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id F3D8F7DAD9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 08:46:43 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id 22so7301745wmg.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=p9+S9LG2FSYG5qibNoCcJF6IfyKpCBV6hhiauJSPfxI=;
	b=AgjyPxgYPuLSB0yQsLht0TTi7WWChAMt0Pqm5qMA7VjTqK30MvkuuSErhqYDaH8DBQ
	SS64VqggYeY5sJl5w8lb50CxpsN5+tfnoXfD8RzECiLaH1sSc7+db4OUslly8TXeY5aq
	ZgIHm3iSD+WbhJ7GRJqDVvIe/LUK1r7ranf00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=p9+S9LG2FSYG5qibNoCcJF6IfyKpCBV6hhiauJSPfxI=;
	b=qyeavWxjAAYE4nGjZhUleiNeobzpvtD4kLNPlj3j9wznWltw/5LZd4C9QChv5DPMee
	nEEftt2bi71aT2pxGPq7t6R+ljXLf0vymv3yCM6BONC1FkWHOphwkMX0cfup3hMPtS38
	3tgKW0YHXoSKl03MD9gKVKH3ZgHzWq6sHtCITNTMRzuJ6JVXXH28YzX/7hxmUzEw3Q71
	IbKmQQHtbJx4HZn91uTmwlNsCwmQpp5F6K5wtXQ0kWIfCRYhyEEgbSDTWnyemRG2Ptw6
	bvIaPy8rH4cEFW524cKitlM8jjZ2vfnSG9NbAOF+HkfSrYQ7xV7j9ds/oAjUEzYGdp90
	hNYQ==
X-Gm-Message-State: APjAAAWgc5ERa3DFxsRScYFwttWg2VcZZfKPU3QuKPBsJR65auQ1+c7Q
	3XZcXQu81Z7Ynsu5R1T4TrU7iA==
X-Google-Smtp-Source: APXvYqx1NBexaLjEtXYApMsCzIrFK7iXXIXnZy4GX2sJIK/TIYzXTfnrcymkcUwQC1jRDek6VkG1Vg==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr13446598wme.167.1560156404733;
	Mon, 10 Jun 2019 01:46:44 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id f21sm9620524wmb.2.2019.06.10.01.46.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 10 Jun 2019 01:46:44 -0700 (PDT)
Message-ID: <8b6337f60aa01cc8e4c940f6fb20f4d8207d2b5c.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: David Reyna <david.reyna@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 10 Jun 2019 09:46:42 +0100
In-Reply-To: <2784075cbd0cc105c8c6ecdced2226de94d4b343.1560127238.git.David.Reyna@windriver.com>
References: <cover.1560127238.git.David.Reyna@windriver.com>
	<2784075cbd0cc105c8c6ecdced2226de94d4b343.1560127238.git.David.Reyna@windriver.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] [THUD] toaster: Fix Thud Bitbake release for YP-2.6
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
X-List-Received-Date: Mon, 10 Jun 2019 08:46:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2019-06-09 at 17:44 -0700, David Reyna wrote:
> From: David Reyna <David.Reyna@windriver.com>
> 
> Fix the Bitbake version ID for Thud (1.40).
> 
> [YOCTO #13356]
> 
> Signed-off-by: David Reyna <David.Reyna@windriver.com>
> ---
>  lib/toaster/orm/fixtures/oe-core.xml | 2 +-
>  lib/toaster/orm/fixtures/poky.xml    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks for these David.

When we fix an issue like this we really need to fix it on master
first, then backport the fix to the warrior and then thud branches.

In this case I've applied the fix to master (with some teaks to the
commit message), then backported it to the 1.42 and 1.40 branches with
a straightforward cherry-pick.

Can you check I've got the right changes in please?

Cheers,

Richard


