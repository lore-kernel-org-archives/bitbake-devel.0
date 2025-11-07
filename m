Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F6CCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 13:19:01 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11230.1762521536059871206
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 05:18:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cayAj1lh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47754547a38so6034515e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 05:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762521534; x=1763126334; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5M/INfXL8qMRJqdw4kuiWaLwQ2QYZEwXe5Ejadw9kA=;
        b=cayAj1lhJo8Y0LG2ZvCfL5C3WoHPh/I/0/e8Zsl3hhMEc8irfrKusmTxOzeAgm8mL7
         sgQm/i8R0dkuiqhCQmFiSQhudAJQov5yiDhXHW4Sn2FjFxhy3OCzUFxigzKOn2CC1DlK
         Mz8imhL3AQpmqmXUx30TTIGzx6i3zRMIrAs/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521534; x=1763126334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5M/INfXL8qMRJqdw4kuiWaLwQ2QYZEwXe5Ejadw9kA=;
        b=AfOsbS+WV4GXjZ/4Tgd2oB8wm12qAfBw3tLvQreQbCklghh8SphXfmWgPg/GKuTQx4
         Rt8Z7O8gXi3BBSGnLLY6NA7kvZcmk5w6aRkJizD9o8b5P4eabNdf+vvKWyF0WQUqgojL
         ey8cQB9PVT4UFxFiOHlubiW20ufeYUrgvfpa49W3FxFhfFeOdiZnHvLyAVbIRgwT9FLC
         26u+f9YhxQZkLBzW/PI/hYW/cVuGTHNiQv93fpjEEK3uluC50c88Q8b6ccUXg9lzPW0s
         fsltvTd+axkBvStSOKnd/Pa0IQs1C1l1ELb50HU4l9b8wnK4tAKSVrFo+bp0HVh3HE4X
         EhHg==
X-Forwarded-Encrypted: i=1; AJvYcCVNY7KLBQ2aKIPEsabm+U9tbGxv3FRNyCxlUZBoMxLJzRRJO1HeEfVu2Tk4rIDfFOymhOaLWbJSwzifYcOk@lists.openembedded.org
X-Gm-Message-State: AOJu0YwC/+aG3ez+x9GNoZ5u1FowrLL/EJQzV+XmyYXKM2c+/ihnh7pK
	/VduUXxWms9l9Rod4FwoMsOolTo0DsM4V+YJJdVTsXG93JmYSqPlVPVA65X5FJBdCm4=
X-Gm-Gg: ASbGncu6pVUPd9MDnvCz8rBLKSxA5dp+VezPISuZE3PMUAf92F4P+EQRo568Y99C2dL
	z1LhTjYpy+PFHsp1KQ1l8Q+NEq6e6xQhvS34bZYDFH5/4qRWr7i4DgkKD2PT9VxEbIxZJL14CJZ
	SWAAXIfe1QevCKxz4ifgAOzQh+CRtdLXcpPCXdpSNmRXUoTqj55+HCRE93B21CpC5HTc97EA9e1
	9hWsrzDaPpt6/nQCi58UNiYJs8FHsHcrrWlGJTsBMU0YSFeh7PbB0Vzt/BWkSMe7BIzztr2ebZn
	TB1MxoSFXocC61k1kTKFUd5/yw5Sm+qPyIqYErxWgLZRsGLY+GmMFurregYN44dCS9TubOmBKj0
	5oBaUYMox+iR+hlscqu4u6GtJnHpY/UpvWwKA3xVKLBhLGxlZ3cKk8uRO+9JNy+teBgyh4yMTdf
	BwH7TFGBtlLp3u6/Z3TmtZs40kgvpHKlN81Io/vWndRiVTBCQd+kzDiCnbPMVajyQS
X-Google-Smtp-Source: AGHT+IF5oN9I1EplhQ3vvtfJnEX5aAnIuJ4kOc0syY38jMeMA0ten+vJettzv0Qeph3vxts+U8ZLUA==
X-Received: by 2002:a05:600c:1d19:b0:471:5bf:cd02 with SMTP id 5b1f17b1804b1-4776bc967f9mr28176525e9.11.1762521534407;
        Fri, 07 Nov 2025 05:18:54 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09? ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e73247sm40591195e9.7.2025.11.07.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:18:53 -0800 (PST)
Message-ID: <84e7015f8fdbaeab31fce9cde841ceb7d9882be7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Antonin Godard	
 <antonin.godard@bootlin.com>, "bitbake-devel@lists.openembedded.org"	
 <bitbake-devel@lists.openembedded.org>, Alexander Kanavin
 <alex@linutronix.de>
Date: Fri, 07 Nov 2025 13:18:52 +0000
In-Reply-To: <CANNYZj_dABVkbqu4E-Z-LLyALkpv8pzVdZu=+x9W_MqxfsCqsA@mail.gmail.com>
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
	 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
	 <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
	 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
	 <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <CANNYZj_qwFt6F-LEwMqe0D04dy7t9_FJMWf1tpCUZ0bayfdUZQ@mail.gmail.com>
	 <daa19e97cfc92bdfdfdebc0b344dc11c6462d0fc.camel@linuxfoundation.org>
	 <CANNYZj96A91YLjusG__6Nb0G+5xzsqTXSmPxha_H25J2H6RpVg@mail.gmail.com>
	 <23ceab57be35384282f708b8a0a4f9d0c9f7d338.camel@linuxfoundation.org>
	 <CANNYZj_dABVkbqu4E-Z-LLyALkpv8pzVdZu=+x9W_MqxfsCqsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 13:19:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18311

On Fri, 2025-11-07 at 11:20 +0100, Alexander Kanavin wrote:
> On Fri, 7 Nov 2025 at 11:17, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > No problem, I can make this one based on one of your patches.
>=20
> Thanks! Don't forget the json schema too (I sent patches for it, so
> can be reused too :)

I sorted the scheme too, yes. Thanks for the reminder.

Cheers,

Richard

