Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4630E7AD77
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 16:35:33 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.112939.1696350928538032225
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 09:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cMZBgNQD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso11879635e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696350927; x=1696955727; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7zgIcn7uDJ1WC5nbgl/gzRduWF1lw49FxGoikTI1SA=;
        b=cMZBgNQDqZOdArMp1JVeD/yiRrXph6fifN274d56spT6ayNk3LRfdxuSNz0X/mVKmu
         QUw4Sy3a0Dxs41uTKA23h99CJthloZdGKbQ5A4awTD516+9QywipGG15pM4r3inlJV5Z
         DnoH0AXionob0tvNO8lVkO5tT4b4MUVOZ1aSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350927; x=1696955727;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7zgIcn7uDJ1WC5nbgl/gzRduWF1lw49FxGoikTI1SA=;
        b=owE9JgBhCTFsuPd1G1Il2IntTpDFG/xiE1tlAKjg0aEdq05ZaMUhn3i8RbDFdGNP5U
         1GY/t9mKkKbBX8siAwfLmXbeLqIaRVmwzqYzMbYtSA7dluFyyxA/ziLJmwRPihK01lMS
         wJmCYqDtoSupyKgPWSD3a8PMl1xc7l5Zr9XaKJAhLzgnVVHh2ftIv0c4KXbOg253iG5A
         /tOlZWjhrUEqGQE2EMostJn9gtscRyPbI7XQHUpTT1T/uNCnIEvziBAC3EuBYkUACJzx
         ZPdGAjJHViJU/l0ReWxTzyz/33Q+dCaLEydiPvEgopUccBVLEHKCyXqKVeJ6qMkLtMIK
         X6GA==
X-Gm-Message-State: AOJu0YwSKx19PhzI3P+5gJneIQIUwQ2bJP2cA0YHKjKL5wd20KVIlXzR
	23TCOlZccrtKGl8GHLuTatFjbA==
X-Google-Smtp-Source: AGHT+IEqa6CmRwzJxgxvdLy7UwSOLuu0b4BIL0YLjWG291GMbGXKZAZ8Ms+W8JJgEUw4vYe/El8jQA==
X-Received: by 2002:a05:600c:20d4:b0:405:40ec:415d with SMTP id y20-20020a05600c20d400b0040540ec415dmr13560092wmm.39.1696350926902;
        Tue, 03 Oct 2023 09:35:26 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9590:242d:879:8d54? ([2001:8b0:aba:5f3c:9590:242d:879:8d54])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d628d000000b0031f34a395e7sm1941750wru.45.2023.10.03.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:35:26 -0700 (PDT)
Message-ID: <0487b3b40205fd375fc981bfe9181034c4cb8e6e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] bitbake-getvar: Add a
 quiet command line argument
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ecordonnier@snap.com, Jose Quaresma <quaresma.jose@gmail.com>, Steve
	Sakoman <steve@sakoman.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
	bitbake-devel@lists.openembedded.org, oss@ew.tq-group.com, Paulo Neves
	 <ptsneves@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 03 Oct 2023 17:35:24 +0100
In-Reply-To: <CAHUKmYZxyNDG2yPQ3-rphzCjCJ=5mV0gA1avwOzdsy60VhtMQQ@mail.gmail.com>
References: <20230824083109.1821425-1-Markus.Niebel@ew.tq-group.com>
	 <CANPvuR=8-BicdWNHsgmyBAZDHg7Phj9b2vhnzbo_xEaEb09b+Q@mail.gmail.com>
	 <CAHUKmYZxyNDG2yPQ3-rphzCjCJ=5mV0gA1avwOzdsy60VhtMQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 16:35:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15176

On Tue, 2023-10-03 at 18:05 +0200, Etienne Cordonnier via
lists.openembedded.org wrote:
> Is there a technical issue preventing a merge of the patch, or is it
> delayed due to the current workload?

There were recent changes in master in this behaviour and it may make
sense to fix things together with the recent changes?

You should also copy Steve on LTS patches (added now).

Cheers,

Richard

