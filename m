Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785DE7716E
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 22:14:06 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.24177.1733436835795710814
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 14:13:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bxg58F79;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43497839b80so9895915e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 14:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733436834; x=1734041634; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ONU1Ih8Ph0LjQy4P4Wqvc/ggkRf25Uux45M3vTC8Yg=;
        b=bxg58F79dpvindmILB8mBFIkwLxFwvRa2s1ldNVw82yD5gU8uiMaDdF3lSn0cu171q
         zo3TwZ+F3tV///22ErOdyRfTpfKyBmx8cQ5Hqnt0lajodd0Qeon6bBcjgjerelNY/5ir
         sUb6Qz1RS3ry27Ud+IQm/xZIK+fO9XJYSQYgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733436834; x=1734041634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ONU1Ih8Ph0LjQy4P4Wqvc/ggkRf25Uux45M3vTC8Yg=;
        b=dCW3Zu4AbYAtvpKgpsR/LbSDRzvdhu8BdRAnEpPCrlelSv/i6omRiFS3w4X1+RTZkg
         UdfexIy0yj5ZJHYML8bKB9Vs8qcFp3Z6RKZYvAtziVSj6h+hIDG54ExTzaCnXTwxoiQo
         dvtULvTGhaqJZqHDtg2YOoQ2M+RQv6eXjmb9laEd+25h5Se30wDBxPfCOcUztBfMgZYM
         ZgoYHZyquBu0eNX7ieaW3jZrDrXEFD6+tPv3tVoQ8uTLO+tZFRq/GQM4vnjXJ9riXGv/
         E6dEdjY5nm66hnxN2hRoY2GxwGmdTY3Qvd9ZuJ2JVNrSd0L3EPHBytnkhhuF8iAbu6rN
         YP6g==
X-Forwarded-Encrypted: i=1; AJvYcCWyPZY2KBxFXQBwjJ7btlMRiVueMZmFu3rte8MEsKQnZL0LuwGA1F2Q2KyN91rogfV11uunNpM5iiXcqW5G@lists.openembedded.org
X-Gm-Message-State: AOJu0YzuKIVKIV0GZ1G5Fs0nSbqhUecKDFXoEVJ/Gu6xPMGwIT2oqXiS
	vBnC7q8PRymfNZ7VfxDaEY/wnLtw7sz0ZFONKcVBpXlONzbYK1W5p8ubI4G8N7w=
X-Gm-Gg: ASbGncvGLutO/6fWPzTRSfSnb+YCiP4eIIkmdLjBTH5UWrlA4T/EeLvUesJgLqFdk1D
	OSnUHuVZl6veSTsBNxjCyoQdocYLXu3/JjbFJpPTpE+IHaSyqpN1ZbbYZb9G8iI6Ar9BeYBIGDi
	OJf+wehv53Bbmi5Sj3J4qCWI9RR8PMdfEjy3K7oSi2ZnT91S2NnVbX1rlrgGGqwnMtPEGVBKehB
	3IXEy27AZ1/Ms1sEykU+ItIA7XkYzkAAnmrT+epFYMy5XBcI5gyGIsfIQOdkvGoJ19XKWEOTMMk
	zRDJgRz4/xDTUJLwEbW0ggut+SvtWe/7GT1sm6c=
X-Google-Smtp-Source: AGHT+IF5RCWncW783mO8gzVWanN9dF4It9pvqO5nQkLZ2mOfUdgmh5vDPKnFBTgo/OZEwho6qnlXvA==
X-Received: by 2002:a05:600c:5799:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-434dded7708mr6814805e9.24.1733436834219;
        Thu, 05 Dec 2024 14:13:54 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:36df:88a6:1bb0:5c1a? ([2001:8b0:aba:5f3c:36df:88a6:1bb0:5c1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4008sm3008464f8f.22.2024.12.05.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:13:53 -0800 (PST)
Message-ID: <ece3d65d6094445cfcb834e18dffd62a472210ba.camel@linuxfoundation.org>
Subject: Re: Bug with SkipRecipe and multiconfig
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>, "JPEWhacker@gmail.com"
	 <JPEWhacker@gmail.com>
Cc: "dave_clouser@agilent.com" <dave_clouser@agilent.com>, 
 "steven_kirk@agilent.com"
	 <steven_kirk@agilent.com>
Date: Thu, 05 Dec 2024 22:13:52 +0000
In-Reply-To: <DM8PR12MB5430DF7192F8D0BF7E6F2BE58B302@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM8PR12MB5430DF7192F8D0BF7E6F2BE58B302@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 22:14:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16889

On Thu, 2024-12-05 at 20:24 +0000, chris.laplante@agilent.com wrote:
> I believe I have tracked down a bug with SkipRecipe and multiconfig.
> Before I submit a patch, I wanted to check my understanding of the
> code and my suggested fix.
>=20
> The issue I observed is that when you have a recipe that is
> incompatible (e.g. due to COMPATIBLE_MACHINE) with more than one
> active multiconfig, including 'default', then BitBake will
> inconsistently report why the recipe is unavailable.
>=20
[..]

>=20
>=20
> Does this sound reasonable?

Short summary is yes, it does. We retrofitted multiconfig to bitbake so
this looks like something we just missed at the time.

Cheers,

Richard

