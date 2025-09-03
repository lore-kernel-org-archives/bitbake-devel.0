Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92538CA0FF2
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 13:05:32 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.11854.1756904724023958393
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Sep 2025 06:05:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XyvOzIuB;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: skandigraun@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso31785795e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756904722; x=1757509522; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlHEQ0cfWzjmJmGijCeNyaBCMN1AiQnqlp+p6tssZfQ=;
        b=XyvOzIuBEFySFy99KzP6dTAct5U7lbZk9/UWTKFk8Pzg/1YU1tWT1UKnzl0itJ8iv9
         /RiFpW96HO4BOsEE68qHq96ilTwWfNTYCCC57JHRogQDbuiyGydkN39FRjYuLmmJ0CDY
         5zLD9ZBQhMiXjF5gdY43PuCTZ+L+AEN5MNxQKi1kehNGLhuKhf7diLP+obNk/TqkqUFP
         rVpVyQDE+nOovMbbFKfVKBmjcPMJblwUzWM9chafKF1o2NUc2zs8jeAE9GJQcaw8eM2M
         woG9igyZCV2j0t1X/UqS1XVLAC2wgp9I+hPv2ZCUINIUDZIlvrAQ3zLO3fVat6TO+bBi
         w+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904722; x=1757509522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlHEQ0cfWzjmJmGijCeNyaBCMN1AiQnqlp+p6tssZfQ=;
        b=JQNzix+pU9FQXWpgGbDrP1R7Kps5rRq3NmEzT6MewPr4KiLowXnUCa4UCxQ3acBRQ2
         lzCelTAvS26YsYso3h7gqZZ40StSszV92J2jIs4tcMfFaUyK17QNVeocyoFCicpS4aFO
         pm8/br/6CFTvTlI1Icv4GcbJDqATwiFymPhe2o3fzlO37TPLT69eJ+L1gtOdD9PQWTgf
         GP6tg3dtrYSvKX/CWqxs05MX8avV/a9+fXHgSXCtJItELmZWVQmYRPoR85XraTK2kCEk
         B+uRfH0SUgq1TM9ZtQZOHpi/+0eZKI0THdVasKk3IBzMh1WrcRZYp7qNQf0qzU6Jy4VC
         r7+g==
X-Forwarded-Encrypted: i=1; AJvYcCVvTMZ3mKeMdDjcXgIX7H+zwp3qKuwLTlSxmsxH5PZ05Fsy5pjcBw94DNnK+UfYIxhjBLIJq4p9TKk7ThgR@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz3G0rKKUUTiQPWzy60Zk2753Z5zPGh72Qy95TRiN57RnLXSiAF
	IoFtrzYhp1cdF0Onc57Fmj1OvY1Y/0tp1RXgDg82XIDpGd+TDTrfU6q5
X-Gm-Gg: ASbGnctXqtdUdQLvUzgB/+5tMi9T92mq8oRLOPq2B4JXY5Ytw5rVKwyQnBh1LMnF24Z
	n5Gv4Eq0kcjHArlFdbr4EpVoVQMsMIcjTllHN5hLeDDAn5KJt68eWjuhZLMQcMEKxY5u2K8RlaF
	JqoxOzR1BTQ+wO7nSeFffrhDfSDvFzJ7TrH/n5EYiFIJ8ot0XAZymuf5JipWY6pDm8wBQ4NMZmc
	XS44Y10Ug6MEkHpMKl17tePxvIuekvALBnKDIErLOhWoZAm+rCn8oxZ6t+sDQLw4hQedqXRUgGa
	rnsMd+/BpQvrhvgWt+OBdL3N0QSqyYaOjeLSgLtmNnai46e2VhlrLprcwYMuFXMNWe24G6PcBQk
	68JLtMXC0+qHpleRsdRmZelHcxXVvpbfQsCrO+I9Oxg==
X-Google-Smtp-Source: AGHT+IGz7PZz/gopC6oV1j6HF78dys8hGFjULKwTwbyrxM+bgGi4Oe4unkfF4z2fm6F6cwtzeYVlNg==
X-Received: by 2002:a05:600c:8b41:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-45b8557d72amr114393345e9.32.1756904722128;
        Wed, 03 Sep 2025 06:05:22 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8a980011sm88917975e9.0.2025.09.03.06.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:05:21 -0700 (PDT)
Message-ID: <a8b57517-343e-4284-856d-108835d20302@gmail.com>
Date: Wed, 3 Sep 2025 15:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] bitbake-setup: make sure git user is always
 configured
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 bitbake-devel@lists.openembedded.org
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
 <20250901135836.2927686-6-alex.kanavin@gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250901135836.2927686-6-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 13:05:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17951

On 9/1/25 15:58, Alexander Kanavin wrote:
> Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
> ---
>

As an more or less unrelated comment: you are free to squash my patches
into your ones. It will help readability and I don't insist on having my
name there (not because I disown the patches, rather they are just not
as significant to warrant my name plastered on half of the patches).

