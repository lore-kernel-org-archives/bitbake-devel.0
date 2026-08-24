Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533BC5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 10:16:12 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13520.1787566564012994188
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 03:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ng3PrptN;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so19381366d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 03:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787566563; cv=none;
        d=google.com; s=arc-20260327;
        b=NbWyAefHSzU7+BPASktZfh+zi4Z0CDC6xf8yxPu0eyw1GY131F4bK/SVirJ/QeSOCp
         tMwURtFy5pTfW7qkqPHX6GOBYCaV6J6sJqBFH+o61NAJbUlcBqlQxlGQJutEhKFKh4Qi
         oM1tA6Zp719Isba0eTPOOdONNusmGCHboe+vuYVrDNHGtVa8+habRLQsu0wU7+LMwbIE
         sZ5iQXJ9lj6pEslkQIS3aVC/ufSV2H8j5AusP/I7LVTfmM0lJJfRS3bkArK9NuEjoFdj
         wgo1uL+jw8GDuQ3qrRq9L/6Fs7E//QiMmTalfl8B40p7fFhI3phxl2It9dW8mnY4wIBj
         1xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fc1UbR7vcDWf8Hj3k6HNdcAqVik5987uImkmKAg3aBk=;
        fh=f49lLjeJkvE2imx8fsyjK2l2IV6/fC9NiYrgSGCPzDs=;
        b=lhES4L89By5ylamDBEkw6duRulwsW9iVW70somwULVgOW6ZhxZQezgHUQ2ljNxQ6dp
         /FLOBvm5hKB3Js+pTvXDPxmJCJKjMpGvyn71IB4b+DyfB75zOm73Ilgr5AlUISi9+tvF
         MAuWcjAhVwFGt5NT6efupfErqco0ywo+Vdyo6jkTneHfNk5Xp5ANdmx4V1RkcDR1HleN
         YhHUorAFSBgHI7LSyJk9FWsgNUlV5Bv9K4Hd2ELRtcTd/lsBRTHBJvf6Hwt5OUZVjLl6
         fbzYQWMolYqwVPxwFPGw+IOplsCGFuHa/c2zRhKrcO5b3mpn1x9j282tyJYIbt87Ejw1
         Ac8w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566563; x=1788171363; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fc1UbR7vcDWf8Hj3k6HNdcAqVik5987uImkmKAg3aBk=;
        b=ng3PrptNIRPB4G6/8YJTvlwl6SyNLMyL7wECroM42ui6VE6JfX1+0nwhEbo0gSuxvP
         K+VK06v8G+4vO/toE2QoUCtUV5Wntbx0LPCRPsJXlXLJfJ0rr25t/C8YgtrJZxCLhY/A
         Ps2AcaxZM42LZpO2+LYa0t0CUKqUnfxDcdayTwqiVX1yq8G/PPVljty5p6YK1ikjjH9A
         cOB6jiI69DvK9cH1BrmvIsABF/BMll3qqyln0aFRTmZYW+40PBGBWmOtGk2mUMCABAFD
         X3I6GPQaE2pjHHXO1myNflgmclZmhjOsYx2O9cdSmv2MvjURTA0AvGsgeoHAPbJzCPYF
         9msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566563; x=1788171363;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fc1UbR7vcDWf8Hj3k6HNdcAqVik5987uImkmKAg3aBk=;
        b=rrusgKn7KhIxXqcJX6dOlS+nvvrnw/WzgaTMpJjH0ueu0474hq8WhldEw0y31r+x9s
         RLvJrK+86jw9aQfhoFycHlLGPcOP8lzRD0dhsdMiK0/AbMf87Cuz2bs9+96T7E1NZQDG
         psLkFsdkpK/MSGGyqRMCHps6r+8gHJ9i1ZPSqJDO3hQ5v/gkgOgU7p4m/h/Z3kTbgyz9
         zHGq1cGGpuyY9w+IYlW8Y1Pxo4cuX1uXgyF8PSZS2GUhRsBktZIZpc4jkUe6mzkzgwSz
         ct3RJniCNMsiA6rlpetZ/gspyXo3fm3NabC8gOF7RsU6r5+8N4lkoNYbE8BCoJQjPRFy
         hrgw==
X-Gm-Message-State: AFuF++kayJX1t/LTXXk4GUKp4JHSuy8JvOO30mgBp3cU1sHGps3fgW0s
	z2Sv0+DgE5xZFPKsaHhE03C1o6cbLc4HZngj5AJxmu65V6QRLu3o4IIFdOLkpGDM0aHRN0/RI5q
	8XHEAKRpKA0t8CuX+2dD5lOF10AbuLxA=
X-Gm-Gg: AR+sD11eHik2qsmBKjiUW41nhS+qIDSoPPmlrgUeW9lsKZw62K2xNNl9qq5kr8fn1QV
	2PzgQxIPFzPpZoCEvn8/vVunZSUY0orkryOx/k9lXkQ/rv2oOVsW5IovtOqn3TnRpqipMIxpl+K
	kkvYq3avsH73DTzNyr0czrOYCfVQWdXdeJiLdcgAVVuLuneZBF+C/eIwXqr6Uq4YeDfdpxLflnw
	VqrQYySR/RnWkKr8C2thWD63+7rqV01QIja0Jt0+py/ljRjRKvlJrYuAl5QSk7eC/2IjJcBHHOW
	DoLNcgkkwC/6/Fg53O9BWF4yL2oBQxqib4sUiKlAYySd34yH8CRmdzrK4xli355RiXS3DMIsvdh
	jc6L/rvOBzRN04Q==
X-Received: by 2002:a05:6214:2608:b0:90c:6948:9191 with SMTP id
 6a1803df08f44-90c6abb7db1mr303902746d6.12.1787566562855; Mon, 24 Aug 2026
 03:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260822012007.189830-1-sh0127.shin@lge.com>
In-Reply-To: <20260822012007.189830-1-sh0127.shin@lge.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 24 Aug 2026 12:15:51 +0200
X-Gm-Features: AcwNN1XeOGMGketCNRDKNRwCxPw342ZolqDGsrNxFpziK4NvdEUZDmr_0pn9LJk
Message-ID: <CANNYZj9w9h-7v9YrC9AY9Vgm9anhpb+U4kyC_UT+Efo=D2zSgQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: add 'fixperms' option for tar
 archives with restrictive permissions
To: sh0127.shin@lge.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 10:16:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20022

On Sat, 22 Aug 2026 at 03:20, sh0127shin via lists.openembedded.org
<sh0127.shin=lge.com@lists.openembedded.org> wrote:
> Some tar archives contain directories with restrictive
> permissions (e.g. drw-r--r--) that can prevent extraction
> or subsequent processing from completing successfully.

Hello,

I think this can be solved by adding unpack=0 to SRC_URI, and then
adding a custom task that runs between unpack and patch that extracts
the tarball with a special procedure. Tarballs can contains all kinds
of esoteric problems like this one, I don't think bitbake should try
to accommodate them.

Alex

