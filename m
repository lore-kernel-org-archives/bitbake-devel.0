Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F44DE77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 17:14:44 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.17043.1733418880890501993
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 09:14:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vt4hYl8P;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8878ec049so8601646d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418880; x=1734023680; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0oM5/YRMz0gCi4ErCuuEzD7Ku1vr8mT+jx4ujLus73k=;
        b=Vt4hYl8P5rseGiVLOyY6iImdZbmugJDQxNsDnQu7OicKLsm5JKpnKNoFLT8V1WmVmj
         aqyeR3eT+7v8Eg/rMBUfK/grczECMQlJHm9rruB9wp7i098tMGHSifyrGr4frCAN4VZT
         /t7+2WZrnvtMtVxW3l0suyy9dbFN1Kh+729bs8y9JKPlUqsP+hj49wNQ3glcPhZEbuPo
         OHEQY4Bh2QsKtqFMg02r/GnG3zA6bSsoQXDz8msPI/nRU5KKsKnLN1gQ/XkoOORJQYqe
         LoJmPjmDM/RFhBVBrPlAYoVZr9+PWGZ1bWmI7CNYBuFhyAnIi6rqEidQYCHkG53rZzPP
         +5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418880; x=1734023680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oM5/YRMz0gCi4ErCuuEzD7Ku1vr8mT+jx4ujLus73k=;
        b=DjROanRQ9+ysDD2VCfVnQpfLHrhCkvcES9VSr0/8rOtjGXx4Q0wZQczKnB8BrRQpJT
         AOYJu+kgyQj+2t1P0RnQijnaQVvHx9zICCBRB8PH18f4p7SGgfVr3R1yMCyTGz+N5RjQ
         mzLF0BprgHadq8V2ZJGFveJqaJj1Dexvzx12qr7QdyXzLXRh+XZ1QuigkePnykybSxLX
         3EQh3w4zl2a1wuxb/VisuDm7UFKg4cElvImtSxwdXo7sdBRS4hxUvEjo6XVED/DeiMIp
         pkuSTSQ9e+B419bfCyim1qfkvX5v9hCPQNZrGSQqDWXf4fz4rQMlDyr3W1zLZzaURjkS
         a8ZA==
X-Gm-Message-State: AOJu0YyoLP8viAjn2DOq6H6akieSrS2vp/ncTwhTvu4Wqu1pLu4DXp6P
	HktT3SBjlT4SPcgG0bldEPz/FiiGhS3noEgoI1lHbSWkcO3Xl9nFozFhxQYUt66aohzU2yAguEy
	jrabOWT//Ms7JY2w4AXwG8vbqlno=
X-Gm-Gg: ASbGncvu7n5UylCqCaore5/D+pCoOw+XIVSvF/WLnyoeiyOBE23wtyzCLKMonjoKU5M
	PeMd4peDw/Reun1+kq7pouTqfj1LuXgRYHLdW2AGyEzELOXKKlYtN8FXL7Wprs99ZUg==
X-Google-Smtp-Source: AGHT+IE8EKeO1LrE8+PAddZ+Vr+Y8OwuIGHLDEcr8M/EhPIK5RqQfD0keRMbeyKXKg4uBXNiRbQWAsz0c8cwxpPMXCc=
X-Received: by 2002:ad4:5cab:0:b0:6d8:960e:5786 with SMTP id
 6a1803df08f44-6d8b7367996mr147399786d6.17.1733418879980; Thu, 05 Dec 2024
 09:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
 <20241118162610.1423384-3-alex.kanavin@gmail.com> <215a45a05eb2be50b71ad3c044334635239ff0e4.camel@linuxfoundation.org>
 <CANNYZj8hDKYRQ3cCLQGb0ddch3Q4stYyx=o15uF9ohSs8Bh1DA@mail.gmail.com>
 <70cd6dd736551401d88185c060ee45fcc3d02819.camel@linuxfoundation.org>
 <CANNYZj93zQDL_3zOTATNgfh30_Y=SCkaKoqs4NNgHuaYH=-Q7g@mail.gmail.com> <879fd4f6acb6cd6ae5a95261ccc3bb50cbaf38d8.camel@linuxfoundation.org>
In-Reply-To: <879fd4f6acb6cd6ae5a95261ccc3bb50cbaf38d8.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 5 Dec 2024 18:14:29 +0100
Message-ID: <CANNYZj9S4sPVvF5j2aTUu+DAv1o2h=HfsjPFVkoRfxWkP6VRvw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 3/4] parse: add support for
 'addfragments' directive
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 17:14:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16887

On Thu, 5 Dec 2024 at 18:06, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> > I still need to improve variable naming. I'll do that and send v2,
> > but I'm not sure at the moment what can be done about this subtlety.
>
> Probably a comment:
>
> # No need to use mark_dependency since we would only match a fragment
> # from a specific layer and there can only be a single layer with a
> # given namespace.

Variables renamed in v4. This comment added in v5 :)

Alex

