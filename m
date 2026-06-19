Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F43CD98F6
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 10:50:48 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39712.1781866239355567233
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 03:50:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=D8JrtOUK;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8df26121c88so852676d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 03:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781866238; cv=none;
        d=google.com; s=arc-20240605;
        b=SalagURTTaIs+lDQ+frXLbLxM0n6ipP97ZIefigSbyfN1fQD8ydPVfvS4mynEd4M7J
         Yv6uJ5a74XpyU5lTyikqzLrVmEGEdbyBLSsKYh4Q8HlOCL/RtCoVzP3+cxtns+tkWooj
         yddK1Wt/GJkHtMQVUyIWJgZFSpCjLCrob7qPFHaV9v5EJO+LY8eOM5umtjU0XA5g91wF
         2ecQ2ixpf8/HDumeUTy/Deu6sxK05egBFO84x4lo+BS81bINDOhNXiTQQNXEfY5S1nD4
         9YEQvlkPZO8vtAfATMybMT0iIHlUzF40+dyZ9++aQ3cWcdHtTC2zly1WSIEt/yS8swnT
         5pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ORnGmTCRtf+JaUjxSpaQqAJRqR88cjR8Mi5YSjkhbKk=;
        fh=S70EIw5I6KnwG2JXmyE4WkvLU4aK+s9Srxw9jTjAdcY=;
        b=Zty9qyENZE+6RYATnE6ubg4suajwCIIUlotooJ6+I8gwdnMe1JZkKvZOavb0NIIe7G
         fiDJjdI1q/C8O2ElKuoFpnxtGg1fxjOwTHhNsy7BB3euDt2khbM9PRg7piMifyV+oPIK
         Nk0zCBiMDWtW8dRkijk0WfPVJLDZqSZ0SxnBquR0fSFE1C8xccvJHnvCPk1jBl/3oqO6
         bGvm10FfnWUScWGzNfuvYrL7tzxJnNm+6NhGqCtaG4kPhGxb8VkRHJ/pK1m6s3gKq0NN
         T00TI+33f/GSbCzt8KfMnYWr7QmfV5qRmnnFMhcKRw0lz+9nyhEuUMN6HVdqAVr+o/UM
         1htA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781866238; x=1782471038; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ORnGmTCRtf+JaUjxSpaQqAJRqR88cjR8Mi5YSjkhbKk=;
        b=D8JrtOUKvuZUT0ig8zbBA7i1D9Rn1EeOmmK4v/+7tApmIocsdHocLB8Qaj73QWVNQH
         lep/cSKi2FZBwvUiHFQlV9nMLioUX29w9kUQTwTdXwiwSiQa4++kxye8U/IIITLIqO/y
         6+BXdRE3/4GnVVYKPlgCzBRW6brHl0m97OOsFvyTe2f6R5U4RPeF10tN325cGuF1tABl
         0HpHU3w3FbUEc37/DzfKWWfRI8R9kRJA+ob4HMZb7TPhgoOKemhL4DzM37AX52b8JtMG
         yCbDCIMN3XP654M+xGKj+7iPF31VOvWPz93UCjV1CnolwLAIlDpktsautetfAyZ7rwhh
         9IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866238; x=1782471038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORnGmTCRtf+JaUjxSpaQqAJRqR88cjR8Mi5YSjkhbKk=;
        b=jW9ouhgMTzJ3JrKGlSzSlHPX7SUihGKZEEIIsM5cxBNTB0qCwCnl7q8AhcmaonKWjT
         PKgHnyYZVghZ8s6lNJ6v2Pp7MEB8kurYUB5oIfny/IT9YOXesl0tXHV3FZg9E/hWWC3n
         7vcgqdnzaQtvGSrga9EfJpn+zAA/vRdKJkoN0z+CeXqsweX2twV2dt9ak3OWu8ZLCyea
         QIx22J5SebqgFVnH0aZJvEfmCrzeICJsBtHp0iRUn5VAlf01W/yahGXdtvahQQ44ohH5
         e5IzNEASBd0LqfHOjpuRa9hZs1DoP7W7ypzdBqJ5fsYHaPgRPVf09OSsQ/1MM0vitQLC
         EnMw==
X-Gm-Message-State: AOJu0YxUPne8clBI0amhK76AWjMtPxeKiOKOLX66ygoyfwZvy2qj8EQI
	y6Zy/V177nnvK7KVwvvFYr+/XaDQHfzXNwH7ENSE6dxCv/UyVpEu2Ezo7iqrvNO/zx/vzLxvwmW
	ko4yjovYHVYFlCevg9JEHtMTR9vQkOQY=
X-Gm-Gg: AfdE7cmtBUX3+3Y/K7XJtCAz73AgiuXMLTBUy/RmVWJYZPDToEqD1IqU5yErIVK50/O
	78c0GMRRJZc8Wc2xOjU8voRCYNKnj93vNu7i3+/dpvimHXVzH0lTKNVukNXq8HBkmsQE7IQz/7F
	AUD3jHo608po4POmHa4Tu++3CfGwvKGGF7+7Pkjr2s/ohIoBLXrJsbO9YHRJgoVK49sML0zmtH9
	3yoghC7vMXxYZkgdMBGevNLlW3je/hKVYXaJ0EYL5lHBpjrzCcckJoygDK8Sew1LjFMeKh7KS2v
	D493s60Lcf7YFR0l4NrWrZTAHppS6rO6t1ATVfmWow==
X-Received: by 2002:a05:6214:1bc6:b0:8cc:ed49:bdc9 with SMTP id
 6a1803df08f44-8de3b43e008mr51775416d6.5.1781866238149; Fri, 19 Jun 2026
 03:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
 <20260618-bb-setup-source-choices-integrated-tests-v2-1-66b3b438f073@toradex.com>
In-Reply-To: <20260618-bb-setup-source-choices-integrated-tests-v2-1-66b3b438f073@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 19 Jun 2026 12:50:27 +0200
X-Gm-Features: AVVi8CeWuJTdo9H46RoNBIA55GA0T5hPYeXtdMhNomxE7W_psTQhIfUbC-sS7bI
Message-ID: <CANNYZj-=UpcXUeN_44uumiT67vmAPR-LrYkRvVhgGxHZFFdDSQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] bitbake-setup: add source choices
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 10:50:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19747

On Thu, 18 Jun 2026 at 20:04, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> Allow configuration files to define source-choices instead of sources.
> A source choice is selected before the BitBake configuration and then
> used as the source set for checkout, status and update operations.

Thanks, I think this is more or less what I had in mind. For the other
two emails I'll write separate responses, as I have some notes.

Alex

