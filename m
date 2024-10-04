Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAB9CFA758
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 10:04:53 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.18422.1728036289443394278
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Oct 2024 03:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DASppR7i;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso17477985e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Oct 2024 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728036288; x=1728641088; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jj4HeI8yszrua8LlLENbfEkDiaOSwAFSOWwRJkGn6R4=;
        b=DASppR7im771BsdOBwwGVHYB5MkJIZlp21g1/glypsP0pxJACu7w/B8ZdxTWijRE0K
         CnIV/Df6Xja/tW/BVZcjzokfU6byNsOTOPrO/DkI+YRrNTf0yyaDqeffKTYuntOz7YcF
         d2h+VkszmupmRfMw9e1KlvJYuYjgXg4JdjWIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036288; x=1728641088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jj4HeI8yszrua8LlLENbfEkDiaOSwAFSOWwRJkGn6R4=;
        b=KAZtyMcC0PrcjW+Fd6FB7YVjF4UsgKUnWxBUiLRrw1tR5jVum0gJFC5retV7qQ88Y/
         CDbKFnzDp7c+PuuXhzBreH/ODx1pX4VwG9fQl9N9pHmOcb6h9p9UAozI6wGtDbsG7QGH
         q1xJmlf3YiBmO9V32+Odj9nTK8dyTKyGuEsJxLzQjQZGv6AmhpVTySEOQAS0TqPrg075
         tcS9u2I2oM04YaDwMv0ugjo8RFRDnUDdD2Th5ZfKsVlfx8PezcsrgIPyd63Nw4Lgn6w+
         RaO66W6FGwwLm0mPwzm6GWY2XMfif52CNCn2u0hWioNPA2fB6tZJwfrn7YZUxTkHJSpD
         Irwg==
X-Forwarded-Encrypted: i=1; AJvYcCWzQAUcL+jrF+OgObnurh4aDRcxxGyxYt1/saPD082Mb4z401zAfPc9n9EQWYM1Yq2rgpDFDUubkxXkdqF1@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw+fdCBYmOitTw8xY/TiGqrWDHEZaC2Id7BwE/50ffsKZdRJV9e
	vrLS+wkjUd3fpYrs549HXMwecRcM0C2AqmqNQyCDBQErHT0IVVXF4q07s9/qEZ4=
X-Google-Smtp-Source: AGHT+IGCBeF4iU9D0AXnmkPkIksTf9TcA4rfMexoPEHbSpEj5xM3L9AVw1nvOK+uDe9PSF8HBSmyVg==
X-Received: by 2002:a05:600c:19ca:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42f85aef821mr15559785e9.22.1728036287578;
        Fri, 04 Oct 2024 03:04:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:25ac:3f31:db63:541d? ([2001:8b0:aba:5f3c:25ac:3f31:db63:541d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0aa79sm11742705e9.5.2024.10.04.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:04:47 -0700 (PDT)
Message-ID: <011cd813dab22b6cc025fa3d3591b78d1f9805ab.camel@linuxfoundation.org>
Subject: Re: toaster test_create_new_project_kirkstone fails
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Cc: swat@lists.yoctoproject.org
Date: Fri, 04 Oct 2024 11:04:46 +0100
In-Reply-To: <Zv-x_rjngPYSdnGX@bootlin-mathieu>
References: <ZvUvxuOLF6C_KD3F@bootlin-mathieu>
	 <Zv-x_rjngPYSdnGX@bootlin-mathieu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Oct 2024 10:04:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16639

On Fri, 2024-10-04 at 11:14 +0200, Mathieu Dubois-Briand wrote:
> On Thu, Sep 26, 2024 at 11:56:24AM +0200, Mathieu Dubois-Briand
> wrote:
> > Toaster TestCreateNewProject.test_create_new_project_kirkstone test
> > is
> > failing for a few days with following error:
> >=20
> > AssertionError: None is not true : The project release is not
> > defined
> >=20
>=20
> Hi Richard,
>=20
> Any thought about this issue ?
>=20
> I'm not sure what is the exact root cause of the error, it might be
> related to commit d3c84198771b in bitbake:
>=20
> https://git.openembedded.org/bitbake/commit/?id=3Dd3c84198771b7f79aa84dc7=
3061d8ca071fe18f3
>=20
> Anyway, the issue is still present in today builds:
>=20
> https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/437/st=
eps/11/logs/stdio

I definitely broke it with that patch. I'm testing a patch on master-
next to see if that helps.

Cheers,

Richard

