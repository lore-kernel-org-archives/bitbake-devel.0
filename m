Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF0EEB591
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 11:42:22 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.45769.1726141340363739527
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Sep 2024 04:42:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=0eW2kCMZ;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.208.46, mailfrom: sam@liddicott.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so1057897a12.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Sep 2024 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1726141338; x=1726746138; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QeLcTeiFe1wvxuz2jfw12YUnL7djjLSxgoMvGjOwUw=;
        b=0eW2kCMZtJX0f3+GaKsJNjjlxTjEagXotYdZTW3SIluActMiFrw8KVb0MMFajywWft
         X/DemDn9gaEga2jV88fKwdnmpQo8iY+odrU4O9uXZFltH4KuUHLIbXAxFjteUXI/iPxL
         URJFDc3w2Lye0ylC5g6EymXBULEiBjGUdvB7eo/5ngjx0Q5azmBASDQKqhCScxQ3s7nY
         3nvVUtKm4v9iNUPKuDsXOfFvBq074Zt8uNnR3rFI5fGkTurq1tJm5kT5nRSvy7Ou6Rhe
         0PZRYbSjI0Jr4BGBauf3R/yCvRy38eb2yDFcVr7avNlV9wJwqXxHlv7SiSXsCuKNA46c
         b2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141338; x=1726746138;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QeLcTeiFe1wvxuz2jfw12YUnL7djjLSxgoMvGjOwUw=;
        b=CA0Tw/OeQ12s51YVEDQOaDEWldgFZO1rO6RyucO5rIB2HFVGEstnxiyln7e775YF4Y
         lqZOVyuVOXjyUANfx9NpdDoeV9501RFWXdY6vBhWsHLg4DNcaIMsAu87ux49wGe0TuNk
         EDkYbMNk9b7/Y9jIQ2cEV5GUfUK9SJHyRWaC3zDlv9+ZCn/9tgDk7VpzInV0RktVb04P
         kindvjR1pg2GbzmVuw+1bXr7gXjIYwp4IUd31N5ByJD1KldOOZHcx04vPjMhuuwTqKTZ
         LELoLdZtJSLEmEwH0EjWgyEJAz3gW/FdeEakwYLlNZIlwHLP802aYtI6K8UmG/GuAfkS
         a0Ww==
X-Gm-Message-State: AOJu0YwPm84/dPh34NJ8/pXwDH3QxOjbWRsXSRngWtej2un+eqa1Iroz
	5QaNwPgfLaK/pTuU7LDLNj9HF4XPg6IlQC90UFPVGngHUiB/D4UuY3926vBURIGd6V/znkrXKid
	VLIUmt2E0ataXgAeqlz05vgyquX05dci/U7/O49BbFjlou8M=
X-Google-Smtp-Source: AGHT+IFn4F8cplvuLpmtMV4aF04aJrCpX51SlbZLNNjBmu/QtegZzLY2FPPmE2JvMvbgvsf6LJQSilfRi4Owm8N1mCE=
X-Received: by 2002:aa7:da1a:0:b0:5c2:439d:90d4 with SMTP id
 4fb4d7f45d1cf-5c413e5159cmr1668948a12.30.1726141338117; Thu, 12 Sep 2024
 04:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOj-5WA1uD=aTC19Osn4ZHf2-+AyYpXOTWtWxGeK_4O=rv2CAg@mail.gmail.com>
In-Reply-To: <CAOj-5WA1uD=aTC19Osn4ZHf2-+AyYpXOTWtWxGeK_4O=rv2CAg@mail.gmail.com>
From: Sam Liddicott <sam@liddicott.com>
Date: Thu, 12 Sep 2024 12:41:42 +0100
Message-ID: <CAOj-5WAZU9ESpjU4BjkiejF2-edDQabSNobvjF55HZ6Gw4g51A@mail.gmail.com>
Subject: Re: fix kernel menuconfig failure due to shell composition fault in cml1.bbclass
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004a8d020621ea99d2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Sep 2024 11:42:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16556

--0000000000004a8d020621ea99d2
Content-Type: text/plain; charset="UTF-8"

grovelling apologies, this was the wrong mailing list

--0000000000004a8d020621ea99d2
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">grovelling apologies, this was the wrong mailing list</div></div>

--0000000000004a8d020621ea99d2--

