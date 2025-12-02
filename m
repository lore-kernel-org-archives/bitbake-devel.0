Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD951D12663
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 18:28:11 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.244.1764700087801349394
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 10:28:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gB35z4Zc;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b1bfd4b3deso436081885a.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764700087; x=1765304887; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nCjBZmeOfVsfFA17S9XfqGGP3MeAmtH7NcQWGMlxoO0=;
        b=gB35z4ZcBD0NFnkG0dVDdg5wmtCx8k8V2C+HZIZySew2Z9NInEJfZGgKmw64KPCRiJ
         2rJGcEysIukg5mKjU+8livT3Oc2PuxXspGyBDo4QkbQUHwH2fVeCO6Kmup2tH8hvSxyy
         WeNXsyzzTz9CATSfP+3GTHkgygr3V9l8v7nJK5zXp+XerT+mCGxkeDRUFJsRDuee0tJn
         S6nQYCJfVyhh5DwKkRU/yr0V1/WHPxOpuKRdwO+cYzida/JdYixCELu8Y+9Fii/bn0eZ
         tQnArfuS/sZv/DGNxKzSWKo5jCtZ+cBB9ZGevX/SVyxz7G0JlgWanj4PozUodxSJwegt
         HVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764700087; x=1765304887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCjBZmeOfVsfFA17S9XfqGGP3MeAmtH7NcQWGMlxoO0=;
        b=Rc89xtWUHcyUjRSUYF/SC8A98doRdRiclKANlFPiqNtVYt7OtpUzjAPzX/2D7BPzGJ
         tPRHIgKNV4ZCFtV4Q2QEceYE9eOluwVzrHqcxIwvlAE535ZQP/rIllqf5Pr/UB0q1s9S
         6VN4MfDRoKz9S5BVjZv+F1HRov2yls63TuuYpZwt3n45Jx0RyntC7gujOiR9WEw9pe6l
         DOjocYiLyHhLWu3AtCdYu/DCKMOCXmWoeyvq5mKZ0c8LR2rvNDNKS8341altfiHbJ367
         hD+FEkkurPQMOzUMlZKJOQlosISFgVhPDJnGWcz9mTzqJQrGquWbyCUig39piIP3+e+L
         Qoaw==
X-Forwarded-Encrypted: i=1; AJvYcCXdoLT3AEAEhG++OVz26JehOAmW0CGoXndRwWumuAOhLNEVa03IuqPxieXJtQ8arjx3wz/X13PHDvy1Z/gd@lists.openembedded.org
X-Gm-Message-State: AOJu0YzuRciZ7pz/sRXusnt/FYql4u31xb943Gpq57RutbDZDooXDr9N
	lFkZN3S1beA4EAK/+RpJSye8VTFhwDrEvJQACjZZIpNMUlQslnIqQja+VTf/tYI6gefr22I5VDQ
	WdS7mBVT8COEEil1h/HgH1bIRSQhNNSo=
X-Gm-Gg: ASbGncuaMQu8Oa8G+zv/U7GgLVFaftwba0VlRqMBrDKmANkWLy7L+2VpospevZovmSh
	bqiqkFy6eNDievuJmeWB66Wy+hPpxPf81L3c59aAlpQOYsBl4uRySuENmY0XPUTPA2F3JZzlNUB
	66tQSUhlpy4wIaCDMHcXibPeEAJZ0kdmJQQhbiA/3ZJ+ugXXbqtSkMBUERuUomjQf7Dysl0vP7x
	hVMPo8S+G+G1/WLnx/HbVXTsEkB6zQEz4bRZ+ufRB/tZyNbGhaBcEVXgYa0nIf7uXkdF1kKFcCu
	qomjucW0/Nn9T8lnpj+v5i3dlqctOw==
X-Google-Smtp-Source: AGHT+IEoAXtRe9Y4+V5FuO9CUQ8NK2uatfHlCVdAbYWLichnj8ygjhg39+1V0yvrG/W3l+ksnX2YLjxPY71oBBws0m0=
X-Received: by 2002:a05:620a:294f:b0:8a2:2e2b:2c72 with SMTP id
 af79cd13be357-8b33d1d11c5mr6210276385a.25.1764700086792; Tue, 02 Dec 2025
 10:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20251202160402.819060-1-corentin.guillevic@smile.fr>
 <20251202160402.819060-2-corentin.guillevic@smile.fr> <CANNYZj-dNDhzchZU02w6-Q-CLkU2MiFaZ-z-=n7JxsmGdDsgxQ@mail.gmail.com>
 <CAMSfU+6JeaWFAah4AH_N7Ewpzw8g-WCq=we4-kTVfaNF63MdaQ@mail.gmail.com>
In-Reply-To: <CAMSfU+6JeaWFAah4AH_N7Ewpzw8g-WCq=we4-kTVfaNF63MdaQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Dec 2025 19:27:55 +0100
X-Gm-Features: AWmQ_blPv4tgAtsL3MHjNqA6nOxaceIhXUgBl1K8vJnYDeXDbPyJq660JuYSRXI
Message-ID: <CANNYZj91Q5GxUVmMoOrZg17tdY=TCsAmF8SEM+Mtriu1VQNTOQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] layers.schema.json: support 'uri',
 make this and 'remotes' mutually exclusive
To: Yoann Congal <yoann.congal@smile.fr>
Cc: corentin.guillevic@smile.fr, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 18:28:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18516

On Tue, 2 Dec 2025 at 18:53, Yoann Congal <yoann.congal@smile.fr> wrote:

> That was to avoid weird behavior on "origin" being defined twice: once in "uri" and once in remotes/origin.
> How do you suggest to handle this case, throw an error?

If a config defines the same fetch uri twice, regardless of which
syntax is used, that's a mistake in the config. Not the reason to make
the two ways mutually exclusive.

Or did I misunderstand you? Can you show an example?

Alex

