Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B25D6554F
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 11:08:26 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11901.1765969700071040450
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Dec 2025 03:08:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i5UMuwsv;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ba0d6c68a8so612570385a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765969699; x=1766574499; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q47Ao8ZknizFRT7n1MstPCYktxo/5yw2up4KJbNDqEE=;
        b=i5UMuwsvDHlxGj47KY7LlLOR9A99GfGls6+dljpD6bBFByqQ9Y5wVmH3EGQ6yWaPki
         x76f8J4SIbV/vmIWFQI95Fg25EI5Zkxrdh+vJUEhyDaZA9gzAX8/0zl9BnARmSfURlvG
         hKV22mfy/Oy1GuejQNujiglINeI2jLTlOHY3EznB46sBc//2+7TTJ+5PPx8wu3fe7gZt
         rn+oNUtj8nQGi8y5NcgfTKRcshgBCd4gxJGqV7KbL1lGmle2KcWcrr8Lphxcp7WMNJON
         Q2DOaHg6WRh4Bt8v2Qv3fEaVReLpbnuU0Ag++aeXE9QC6bq/XVp6DaJ1qXiLOW85Vpcq
         BBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969699; x=1766574499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q47Ao8ZknizFRT7n1MstPCYktxo/5yw2up4KJbNDqEE=;
        b=j/wDtU3/3JViOkOq2d/hwITXNL/yCpRMlplJfJn14sEQklrjGpAaQMDFJnEYEsYbdX
         w0pGc39hi7UFa0LSUfDFTyQunuTli0jCqHO8Yg/Yhz3fuCbRcv4DKz4jp7dDJ1PQsSM8
         irC496FltxL7GWzJOrFxj8QCvLLjGvBeihR75yvOGOoAop4E/iaVZnGIEcYKy5u//QmK
         YJoEbYy/GNiMlFOpa+g+5YoDEuM89vykSJut+n2fI3wKhUZlPVQFx2ppOXGmHovnM4dD
         BE7Eq7hqdE6vSifc+g5uPAySZA+iKW4kcFWHNldVRWCpT1vEG3YgqabkxH5pqIkbU/u1
         YC3Q==
X-Gm-Message-State: AOJu0Yz7CgGdWay2+PJdVkrn6J19hsuK3Xoxv9jpoDfmfuzZkn2iTGTL
	wOi9Z4mYz6kCwyWYeid27j2pz7emop0LT4miA+b7/nJXujTKZdmnEEY+Ne1lJbmbs2xetTgSBY6
	fxMtz04Xjq94IQRDbEo2uMO0Kuqep+DtS+Q==
X-Gm-Gg: AY/fxX5WPIFaLCPXyYq5GCXtpBdHaUt/cEKlDgzPi/VZX+8V49m+Yx85BlQkXOv+B/O
	Ibbth6BVjjM9Rw5DXuhuMbjkvdO58pMEDdu3UhGpMdDV4tKdlgxBHRphJIkZzNmosP8Ii9+cyJv
	FFGjDYlXgBeQ940eNSwPPwoxFM6xYcTkNPVA2SklydoQ467fKaEtDSNF5FUVBIkBFWFDETUrY+A
	67KvUsTv2Zso2DEdA1RF/ww/UzMlhdPdUtdODXo18g0B8fMev+LqcOK63auSuM29M/FpmDVP39C
	epkYP+HAQ3+ojTtfJXbfzHRwraM0hw==
X-Google-Smtp-Source: AGHT+IGTZE28CBjR54mibKshccW/aOEXbBDaMxluIXUYHDYymceR+phN3wnujY/pB7fto9o2jkQVuNf+0ZxiBPt438M=
X-Received: by 2002:ad4:5f45:0:b0:88a:306b:8204 with SMTP id
 6a1803df08f44-88a306b8295mr174581696d6.40.1765969698936; Wed, 17 Dec 2025
 03:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20251217-bbsetup-logger-v1-0-6bc7d02c11c6@bootlin.com>
In-Reply-To: <20251217-bbsetup-logger-v1-0-6bc7d02c11c6@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 17 Dec 2025 12:08:08 +0100
X-Gm-Features: AQt7F2oFpCkjYh3jvKmv8Fa6sTZprNxIQ2oqxQ2sgmsrEvWZ959sOvY9lshGDAk
Message-ID: <CANNYZj9VbZ1hNHuD4fVgpQqDy5V=zy7umoFwkfQB6+TyKJPN7w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/2] bitbake-setup: convert print calls to logger
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 11:08:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18607

Thanks, this lgtm.

Alex

On Wed, 17 Dec 2025 at 09:48, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Antonin Godard (2):
>       bitbake-setup: remove logging stream configuration
>       bitbake-setup: convert print calls to logger
>
>  bin/bitbake-setup | 155 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 78 insertions(+), 77 deletions(-)
> ---
> base-commit: 0dde1a3ff852be057be40d17f233ecca19e7b389
> change-id: 20251217-bbsetup-logger-8b0984046ca0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18603): https://lists.openembedded.org/g/bitbake-devel/message/18603
> Mute This Topic: https://lists.openembedded.org/mt/116823858/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

