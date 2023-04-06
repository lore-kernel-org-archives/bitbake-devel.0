Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C5C7618D
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 13:44:45 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.158616.1680788684779104942
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 06:44:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hS3KjbZC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so5837975wmb.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680788683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9jinog23W+0baG31QoUDOeOKKU3vhZQAoPE4oaXLM5I=;
        b=hS3KjbZCkPCObLjCs1YQIn4XYzXqW3NM6WucLN0yB9E+9pOXy3+ryJ/vgc4lCmHVi8
         9F975UCWGXyZdMs+Y4wZdeDUWwSRz0adVD8PVDeIu5r3anoLTNn0ft4KSnv1in27uGb4
         FxF121DGupM3q5m7R0ymc72AXr783X11SgiVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jinog23W+0baG31QoUDOeOKKU3vhZQAoPE4oaXLM5I=;
        b=D6FmUUC3X/Zd3Z3j9v4/eXoeBy8NVBa9gIvEKNrlyf1o1SkgdzvibV9K+/kZdEjiaw
         Ep1t/NedLDXsdjPBkSiY7xiwRTyxxnjZxKOUBMzsjgrWJIURwuwbhEY+ZrcHQaUSnn8x
         2kIiCyJT1n7lEkFu4JZwOc67h7o39iS/9QTzHjuuMxc1lVOTtLqKlebGt9wEd7gnRENf
         V5ZWN4suraTm/n+NvnILW40rUEztfyqEQC1CeaQicTQcWvIstnrn2CHxTo2ldmY5WauV
         cMDbgcLsmmpswfVmJ7GVLqcOFNuiXWZMDrVzTlRf7alKWPMYq4hU9Izg6I4kt+dJxQX/
         itVw==
X-Gm-Message-State: AAQBX9fQaPTmO6n3r3L9dS9dyi+IkUHB+3wnjMeGShY6y2yuYbFm40Fn
	DjJK6nn63PPPMYwnNzqmxOCRBg==
X-Google-Smtp-Source: AKy350YQBp85irSp8xsBspq7kxD4Smyn6UO3xQtCIRAnNRB9/z53I7jly2NjXFY9TkRNNwIUWh2txQ==
X-Received: by 2002:a05:600c:cc:b0:3eb:39e7:35fe with SMTP id u12-20020a05600c00cc00b003eb39e735femr7463694wmm.30.1680788683214;
        Thu, 06 Apr 2023 06:44:43 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a84:552d:cd38:8d5? ([2001:8b0:aba:5f3c:6a84:552d:cd38:8d5])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b003ef67848a21sm5359131wmb.13.2023.04.06.06.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:44:42 -0700 (PDT)
Message-ID: <26b296edba075149fb2e4653887ff18f1a41509b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name'
 entries
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Martinsons <frederic.martinsons@gmail.com>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 06 Apr 2023 14:44:41 +0100
In-Reply-To: <CA+cAkeqh2HiHQ8nOKhSUgYgddUxso3gU93ipKazmhnNPQ+nqWw@mail.gmail.com>
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
	 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
	 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
	 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <17530ADB1695B5D1.3977@lists.openembedded.org>
	 <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
	 <ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
	 <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
	 <ly4jptcnwi.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
	 <CA+cAkeqh2HiHQ8nOKhSUgYgddUxso3gU93ipKazmhnNPQ+nqWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 13:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14673

On Thu, 2023-04-06 at 15:00 +0200, Fr=C3=A9d=C3=A9ric Martinsons wrote:
> Oh my, I see a lot of patches going around at the moment, sorry for
> the trouble, I didn't expect the changes I made would be so soon in a
> release=C2=A0

In hindsight I probably shouldn't have taken things so close to the
release but there are pros and cons to taking or not taking. I thought
things were sorted out and it turned out they weren't quite done.

I suspect we'd not have had some of the feedback had I not merged them.

I've merged a few changes so hopefully this resolves things for bitbake
and OE-Core. The other layers should be able to work things out from
there.

Cheers,

Richard

