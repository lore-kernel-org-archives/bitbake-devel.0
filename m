Return-Path: <schnitzeltony@gmail.com>
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
	[209.85.210.51])
	by mail.openembedded.org (Postfix) with ESMTP id 7F96671AB5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Oct 2018 14:35:18 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id r10so1268724otk.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Oct 2018 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Ecx8iBNgsM1z/s8PrUovHd7N3/eWPWkG2PADTb/ddfY=;
	b=Z83Mfmso5jwcno6/qdBgDYOvjgfzSpjInKROANdRnsHIsBmyo98xSXiTZ7OVsKRBYO
	vfp4bR0wcj1miwayDhSg849RBzHjPtGPjuxtZmn1fOty/2JI3HLY07icYNZa/lUPdebI
	MfPkIf3wcyzI7VWMGcD7QS0+8hMpt/hZS1trdiAT5vPgxrilezKyT2WA+tHg92RBLgqt
	xsHDIhsgSFjIIwe9HH00ClLlDCxgHKaLRtxnUADPJHO6XYnXpDqkYNFlzsUa8phg7U8M
	iwdL0H5jlWW8z7dVEIRtHIZTVHAmgwcxfC/zpCMF/j/R+hsfwAWUZa95YyDVzp+zYziE
	phxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Ecx8iBNgsM1z/s8PrUovHd7N3/eWPWkG2PADTb/ddfY=;
	b=d1ApOlImo8Rmptk+YPTnJpwLbDnUqlvixEdaD3lOBTjH4v7Sr/bgYqBCWiL7YvrMp+
	afetGiAduek0mYMy4XYOHQGUOVx3kfPzJgXx81J2idtXVJYjj0AHErJ2zhZSBG6xXDg9
	YzqpUVLXwL5MqbVjAJVfcQABUOCEhRK3iZM6VSTYdGF8Y/Gacb6F2S9Wg83KTDAScYeA
	7B+Pbj0O5uEakTlnsMSXiXvWjFANJGnSBO++AdZEDV/2ERkVLAKPMWPbVh+nzoCilm1f
	DP+U+W5lD7kMtTqPwoyBRpjYNd1gcW/1bkqyuwjyN9QVaymsAKxdDuD9F4mFp48EAZ8+
	7Feg==
X-Gm-Message-State: AGRZ1gITIRHg6zpdWWb930wcwxBodYObbIX2ryR64xZ6VB3fG9kfghpx
	7Ls9wGRucGg5hMW5AUf1vBR5XDziqJKOBaa+eb4=
X-Google-Smtp-Source: AJdET5chMXYbGFFTRoEZkN/UvT/puIZxMejDTyxJ5u79QLHsKWDPiSVY3bxTiI0aBZWTKEgh0L1tvSUOC/Lse/06FQQ=
X-Received: by 2002:a9d:eb7:: with SMTP id 52mr1005431otj.137.1540564519499;
	Fri, 26 Oct 2018 07:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <bfa936254124b13689c89dcee2a4e427@agner.ch>
	<69b4b130-96b1-cea3-f4ec-b22e9777397b@here.com>
	<c84e653d352a71888547e5dd1ac06d5b@agner.ch>
	<4184b6d1-6531-5011-4087-61bf5e0fc761@windriver.com>
	<bbea5568-6173-516a-51e6-842a367f8375@here.com>
	<cee8c886da40cfe78d2e440c995fc5f3@agner.ch>
	<3d35695a-93ea-75ed-41e5-76b2a4738082@windriver.com>
	<a3949ab8722e3391af9717676009a7f1@agner.ch>
In-Reply-To: <a3949ab8722e3391af9717676009a7f1@agner.ch>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Fri, 26 Oct 2018 16:35:06 +0200
Message-ID: <CALbNGRR_E9dEpR+zOLQ5gmJOFk8vdTxfjv_grWSRBfeo0JGPOA@mail.gmail.com>
To: stefan@agner.ch
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: git submodule fetcher regression
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
X-List-Received-Date: Fri, 26 Oct 2018 14:35:18 -0000
Content-Type: text/plain; charset="UTF-8"

Hi,

sorry for being late on this but I think I have a recipe failing 100% [1]

To gather more information I did checkout
7d5af23d560b38fb5558d4ac51c3c9611d6d904f. This is the commit right
before 9c6b39adf9781fa6745f48913a97c859fa37eb5b where gism fetcher
rework started: It works fine without issues so upstream can be
assumed working.

Hope this helps

Andreas

[1] https://github.com/schnitzeltony/meta-qt5-extra/blob/master/recipes-misc/recipes-multimedia/wolf-shaper/wolf-shaper_0.1.6.bb

