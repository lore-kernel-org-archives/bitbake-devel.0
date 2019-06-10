Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 4E4247E58B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 13:51:29 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id b17so9261171wrq.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Jun 2019 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=oIajlEGrHdUoW465bQj6WMLpP84FZ8ABw+wzPNi8uls=;
	b=CqjMn0QpCeC3dv03BiJoeDeNkZWG0uqhJyhnZRYpJIb4/mKIPByWeD0Jmp2MQVjE5o
	X/K71okzWesI8Qe5CA+De4N75aA/MKDZv10AqYkjN3tLkmE+ECknZBm/63EwWp7UYMGZ
	mm8LTUjIz2JHaqJCEQfJNXekFKG6lE1h8iVKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=oIajlEGrHdUoW465bQj6WMLpP84FZ8ABw+wzPNi8uls=;
	b=nU/Pse0/R0YMI5IKWExggAAWPvW5GMKbO4ueALPy1bwmeVf3fCONRYxA9aMiLGQ+3O
	TgiRNjRg7PK+T9B7VvmmmT/as2bsRUtxmFVM2+IBxbNFZe9962YsSTAOrkmo5emVPkZj
	q+gCd1epUlf2f8UPpTdxmsRKvbil1YzH5ckuTJkgjjeFcXrybG9n4CMaUwsSFIGC2mgy
	qGOzexb5Ib7LIepQ/8j69RZ4KSVBfItXyeCNLQ9xyvaYlGc0YbLbu6T/tWBdcubXScPR
	bxsi85XdYetA5ZelX2kkD5zvzksEGRWa4EnFuBnogkGhn+8OdaftvzzzKYne0aRVHqx5
	rOeA==
X-Gm-Message-State: APjAAAVB2TiMJaeuoFtUkHt3XkA2VVigqdnAYhcLLaAu99Nhh9j0tmyC
	VGBoOzTGG75D2zVrE/rXouAp8Rv3FBA=
X-Google-Smtp-Source: APXvYqzMnTFIvOZtoQFa61lil0AbA/0c7Op7y6LCeF4K16yCmQTNrdDcJ6uZOEa+mo+wdtwplZHQyw==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr31739969wrp.277.1560174690114; 
	Mon, 10 Jun 2019 06:51:30 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t15sm3199267wrx.84.2019.06.10.06.51.28
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 10 Jun 2019 06:51:29 -0700 (PDT)
Message-ID: <074214af47d0baf080b35dc30d69f76295a864fa.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Laplante <chris.laplante@agilent.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 10 Jun 2019 14:51:28 +0100
In-Reply-To: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
References: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Progress handling enhancements
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
X-List-Received-Date: Mon, 10 Jun 2019 13:51:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-06-07 at 14:24 -0400, Chris Laplante via bitbake-devel
wrote:
> This series of patches supersedes a couple of individual patches I
> had submitted in the past but that were not merged (either because of
> feedback or because people forgot about them, I guess).
> 
> For simplicity and to consolidate my work, I have prepared this patch
> set.
> 
> An additional change to poky is necessary (I will submit it soon) for
> functionality in the last commit to be fully usable. But no harm will
> come from merging this patch set before the poky change.
> 
> Chris Laplante (4):
>   bitbake: knotty: allow progress rate for indeterminate bars
>   bitbake: build: extract progress handler creation logic into its
> own
>     method
>   bitbake: build/progress: use context managers for progress handlers
>   bitbake: build: implement custom progress handlers injected via
>     OE_EXTRA_IMPORTS

Could you resend at least the first patch please? For some reason I
have the other three in my mail but not the first one.

Alternatively a pointer to a git repo with the patches in would be
good, or cc me on the patches please?

We're about to change the mailing list infrastructure and one reason is
some of these kinds of issues so trying to figure out what happened to
it isn't top of the list of priorities...

Cheers,

Richard




