Return-Path: <uvv.mail@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EC5E6748D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 08:57:00 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.76745.1766393811205954611
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 00:56:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g4jdWFfh;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: uvv.mail@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64ba1a1ea06so3680800a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 00:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766393809; x=1766998609; darn=lists.openembedded.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBM/SBacVuTK7G8tbxc1hXidxHwGTXq8C987GSOy6zA=;
        b=g4jdWFfhEki4CyWqWsO4jX9Li7YrLk3G6E+hE/KaEEBS1gRpVi/lSI0XAO6XOzRUqw
         7jNcoeKdGBMQGEWzmm0+KeAer+ToF+NVPRiEk+Qe1EnLxQpfQfnHKSaKOWSjEhKd63Du
         7Wy7KWtiT4wgAV/rHUIybPsdy9td4WLyiVdZ2HRwjsLKIu9AhBa3hk4It2Jsxvj79nKQ
         qzATji0H057clxai61vXQdjDaXkDubh4izR8Fy2//Ze/hQIi44a3TOA0pgkeHgx6bS9u
         Q/5Q7zH3W52BSpj4Ud2tbfp9W/NilePM25xjM2wJvF30ZdiZqsxjHqY3W3QuXHAp0Qvg
         GBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766393809; x=1766998609;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBM/SBacVuTK7G8tbxc1hXidxHwGTXq8C987GSOy6zA=;
        b=l2bzSorcsYUbXXBuvG0gFXrimZjjk8XdKEKyybd7Z5OZBTx9Reschcj75cFJXu70nc
         UdyT5Z+bhYaK/N1nG//Z/U7h7CM5pnTeF3lWrIobfdEkLllMG/EWpgt9oYy+HiZF7k0h
         U6mDrLafqBgzZo3sHhLNc4bXqiqvpWoI+RAVrwwn2XELt++72jSjSbfF/4y41+1qJQfN
         qLkJwSBEITA/a0I/Edn3vhjzdvqc7nfiGCePO+rKXWqzQiYt3BuAuEO8tSs+OZKhlxNX
         GL2qKln7VeQpcjMLpg3NGWQVm/OdIUVsiS1OJneQsoasI8E4yR9MdX8KMh9fg4TZZk5K
         fKdw==
X-Gm-Message-State: AOJu0YyfdAdSk1cb1l9MW1jqfexbBMhnNkhO81i2vkppSlC6xJGaBium
	VW298JiX71T9Bszrrw1F5a3R7DPXvWV8uyQEYaaytLmFKHo9Yr+xW6qeVXmiaGL3Y48=
X-Gm-Gg: AY/fxX7EA8MKbjI50BgSjV24TZcC9uQURFQbTYyRFgdddvaU+8TXtDarH4UHUYa9aM/
	34jL6jdsJfzvqNtdYHzA/CIPeikLbx6ZWgPwXIqDdwztQMu48lTYBLa58PP+CQdrnBeiMsg4NGL
	y4dxA8ZLar0J4w9gIpDdaX2s31SDs2PApktKJKFzKlwS4LwOmD5QFqVEaDsi4v8/A7wb2at1zxO
	LAdqt37OZH7kFcqIVbe/P0ne8OM0vtvgFT6jqpSjLp/lOA1qJyuzOk7bSzTRzgaK+2KjrF++OvN
	3nMifPlSiztrB3c9YLNGDSCeZ9z3vBuQ/JkIC67eP59p2cJ0eGP4aAPNXaz3WQbx+9gpH1F+CGj
	y8VrsVvo3vX+V8AuL/c2WnbYkIN9ViscEtBEI9WHawYZWdIApzScmiba7gKHMjLIhyUWu8O0chJ
	WpHSvolK+j3zBi4V9kPNu8IW2qFHQ=
X-Google-Smtp-Source: AGHT+IET3S9OmU5VqgJPiPhzFLsN2+Xqm8aLhGkuO+cFFkKrpPvIZ7GZ4xF6tLsqPOj8ougmXx60kQ==
X-Received: by 2002:a17:906:f58f:b0:b7d:3728:7d11 with SMTP id a640c23a62f3a-b803719967bmr1150571266b.50.1766393808691;
        Mon, 22 Dec 2025 00:56:48 -0800 (PST)
Received: from [10.54.16.211] ([154.47.27.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab69fasm1023467566b.16.2025.12.22.00.56.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 00:56:47 -0800 (PST)
Message-ID: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
Date: Mon, 22 Dec 2025 09:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
From: Vyacheslav Yurkov <uvv.mail@gmail.com>
Subject: bitbake-setup update problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 08:57:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18631

It turned out to be a painful discovery.
I wanted to rebase my custom branch in oe-core on top of latest master 
before publishing a set of patches. But it seems like after running 
'bitbake-setup update' my branch is nowhere to be seen. Is it supposed 
to be like that? Any chance to get it restored?

Regards,
Slava

