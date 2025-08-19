Return-Path: <william.martin@muxen.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAADCA0EF5
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 09:56:52 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.10320.1755597406083601159
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 02:56:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@muxen.fr header.s=gm1 header.b=Mcd48i58;
 spf=pass (domain: muxen.fr, ip: 217.70.183.195, mailfrom: william.martin@muxen.fr)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22DBB205AB
	for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muxen.fr; s=gm1;
	t=1755597404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ud+nPJLpSXrAg8Ur0k1HE2nKbzbs4qt85NiXdg4rU58=;
	b=Mcd48i58NlMj/nMhYyhbJ0wcq+Kl/rnxtcKBXWToL+YYGeJVrq/66MDDlpECdm5nfaNuSI
	3ItUeqV1dEAAY8dWCqHfAprWaiuVkxN7ASho5UAYOqjyTbEWWA9kwpk+GPaWSV5g/GLcsL
	Jl4Z19NyzlvjeoQuDFnM0QXY2gP3HruZaEuVNE6ZLV5K4hVV1ZSVoxVtF8CcdoDkzgzPiG
	HN87uOSvsn0EJnecdoR+5k4FsEEcKcowmNqy/oBhvPGX/Wx8+WyL6nCTYBKpf0Q0l+yAe6
	4nRGdVSOUnm8Mwh+jTqXPDry7yXUrcwU1JevfepjRAP8YkcH1nbKtjtdF9iq9A==
Message-ID: <b937fbb5-f398-414a-a440-7020004d91f8@muxen.fr>
Date: Tue, 19 Aug 2025 11:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: William MARTIN <william.martin@muxen.fr>
Subject: Bitbake and epileptic seizures
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfhffuvfgtgfesthejredttddvjeenucfhrhhomhephghilhhlihgrmhcuofettffvkffpuceofihilhhlihgrmhdrmhgrrhhtihhnsehmuhigvghnrdhfrheqnecuggftrfgrthhtvghrnhepjefhuedugeefhfehudeikeevffetiedvjedvleffgeekkeevgfejiefgkefhhfejnecukfhppeektddruddurdeivddrudefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeektddruddurdeivddrudefhedphhgvlhhopegludelvddrudeikedruddrudeingdpmhgrihhlfhhrohhmpeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
X-GND-Sasl: william.martin@muxen.fr
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 09:56:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17883

Dear developers,

I send you this message today to talk about technical choices that can 
have serious health problems.

Some days ago, we have an external person at our office who have see a 
bitbake terminal building an image.
We discover that he is sensible to epileptic seizures (he is ban from 
traveling by plane for that).
The story finish pretty well for him, but we have to ensure no bitbake 
terminal is open when he is here.

I am not sure that refreshing the task list at very high speed have any 
interest for anyone.
Maybe an update at 1Hz max is enough to ensure the build is working.

Take care,

William




