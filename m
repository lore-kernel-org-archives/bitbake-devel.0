Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB719C369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 14:29:34 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.16666.1745504965632640222
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Apr 2025 07:29:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e4DtjTNQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39149bccb69so1022755f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745504964; x=1746109764; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ke5JYq1F26/aT98jTSkRXizt/kwVF2BfJZfA6V5G+2o=;
        b=e4DtjTNQJ+07QyK3xdS/2DjRWnEv+qIFm5Nkc8vi4lTrKVvIUnZMm1YtoV0/u4kAzS
         6RvEfkDjCXVBSkaZ/x+ia4AfYZAqwlt2thHeneC7kh04FWFjf016t71WHzNhpU5R/Be9
         Mau4qFVT9uJ0OWt56KQoORWeNStdWgkbzsNbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504964; x=1746109764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ke5JYq1F26/aT98jTSkRXizt/kwVF2BfJZfA6V5G+2o=;
        b=axAHafnZlXTxD8PtB6mRzAJNddqKYZKJ1EMRgoNqLW3jYzOLW9xGLVGq19ACaQoU9Q
         cTTdQ9rP9a8w7pES+iWij9O7xKGSWQy9tKe1xyp0GJu5BnDnyJBcjQR/xBVY7XS5Cak6
         /7ObrYwpTOiRKlsWMHAxCGtctyRyJgyMw4iPMV7ajy8efRVhxZ7994JuakzgrqE9b9Wa
         VZsSU+/XPSctp9IaUSxdv4A2RW5o1GRRiQBOBuT9QOEgXpZVvcIzZmfO5Je+qXGIOQcN
         z+frJCKY5yEzSqh093iYfWX1fMZbwVdGyUHn9eJvT4lZ5pXS3trf9JR3ckKdvnbfnbMV
         A24w==
X-Forwarded-Encrypted: i=1; AJvYcCVwC1JCG29W31nD/9GbnxBu+L8lsTdr2vIdVEpi93iLzi5Blr32hSZz70qZchwIl23q+p+vPDZNMeUdc5Bv@lists.openembedded.org
X-Gm-Message-State: AOJu0YxIJpBc50gpNU3tkOaHwNev0D+uu1LaYgfdTRH63OT3wv19RJHe
	HWvfsLajbhCoMfCv1Bc1/5+duGsW6YHwlKgcow7WUysu1ujumfo4ij8gIEG0nlE=
X-Gm-Gg: ASbGncuRo3EfOEUmxHDHkHhjP1G7ivFzsxEJje/iTFkPNges7FCTp9D9tCgCUp9MgL5
	gK5uV1hDXEHG5Orr04G2F9FQHF4SLZJMYffF/Gb9ls468zMmxVUnNERkCR/NZTv4bvp3uxpdtb6
	NV9+PzRdHpur3HQdLvBF5q9lkAGqJlLuDhVizfa5j7dFIWfSwXXa25ItRJ2pKqmJ8dvsF4uMDGJ
	NcwEXcMgcjyZt+txCTC0p8n+N1KyqVPV2cb6X5HiIqEVgOKoLbFTEGs7GesUlGV+cFfhnbTrGNM
	f/uYctrlyoRynvyZEEpkrJaPxTBSPxd/J6qcGsnjYBmhtzgQKBOQYc/D01o48nUUcPmAP8e3XeT
	nSXEwln7nJZWT5Fo306Z4CKgjaosNIg==
X-Google-Smtp-Source: AGHT+IFrVEIqlQKsNsgLh7OwmgNWAC9jD+ADkg0ZNniipMx770L4Ouwz3UBp71W9TRxorfGKffhk7g==
X-Received: by 2002:a05:6000:22ca:b0:39f:91:4444 with SMTP id ffacd0b85a97d-3a06cf595a1mr2483872f8f.16.1745504963936;
        Thu, 24 Apr 2025 07:29:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:94cb:8780:19ce:62be? ([2001:8b0:aba:5f3c:94cb:8780:19ce:62be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4a8120sm2338605f8f.16.2025.04.24.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:29:23 -0700 (PDT)
Message-ID: <6ad89426cc5c2762ea26abc94e56f4464dfaffa9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/8] fetch2: Check for git-lfs existence
 before using it
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, philip.lorenz@bmw.de
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 24 Apr 2025 15:29:22 +0100
In-Reply-To: <CANNYZj8Sq3KGhrGc=zUzF8Ccp2F-W=v0LQmJsXrFQH5ZA1eJMA@mail.gmail.com>
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
	 <20250423151901.1300944-4-philip.lorenz@bmw.de>
	 <D9EOJ22QSMAC.3LNDP3MSMSGCG@bootlin.com>
	 <404982c1-3b75-48e9-9182-1b66aa3d3b43@bmw.de>
	 <CANNYZj8Sq3KGhrGc=zUzF8Ccp2F-W=v0LQmJsXrFQH5ZA1eJMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 14:29:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17555

On Thu, 2025-04-24 at 13:21 +0200, Alexander Kanavin via
lists.openembedded.org wrote:
> We probably should install git-lfs on the autobuilder workers to
> prevent this from regressing, but keep it as a 'soft' host tool
> dependency otherwise?

I'm a little reluctant. We try to keep the autobuilders "lean" so that
we test our minimal requirements work. Adding this in makes it all too
easy to then have lfs dependencies creep in.

The autobuilders install should in theory match our minimum
requirements as documented in our docs.

Cheers,

Richard

