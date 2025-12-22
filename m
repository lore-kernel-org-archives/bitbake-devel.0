Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD78E67482
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:18:41 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78232.1766402313153016761
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 03:18:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TzTrlf5K;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-888bd3bd639so48128446d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 03:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402312; x=1767007112; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USU5TZYMy2GKID4j9trKwAiDo0QBPS2J4h1mZ/mmhLg=;
        b=TzTrlf5KPbTuxVFWkIkTgugnojsmTwJTwwVmYwxrn80SWT+YLWXNfdKw9ntC2iS4M8
         tZjRydokUagGTTEXJWdSD0EEaY9mSO9JANCVIQfUy59Pn4+Ax5NPa9pvNEcbt8PHq2UN
         eS6RNV0fzBQqOJfAWSCxbSktbtAn9ai3/gWBVHIF1QL4PFlYLCDubKY99K6dtcPq0nGg
         XgIg8KMjvFsWW3O8uc34RCcW93volZlcWeY2CXXgITRcLiOahJXCqiDg9UDk85YBrHHE
         CZzB2evR4jK2xa0PZf0+8MY82VatdvG+yYBO0qZWPkyeGuRoB4ERl4tTEGkxHKihxuax
         7rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402312; x=1767007112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USU5TZYMy2GKID4j9trKwAiDo0QBPS2J4h1mZ/mmhLg=;
        b=UxspSOcgsBwyN/DEOuloV0h22SuMJB2o4SQOmRDJUAit56Vt96uuzVrbkDJhqta1Hz
         oQrXdJY1sQc3+1GCui1kv1WJvb7BkykbPxlzJYmboDKTszuC3S1iMBJ1+7vOFz1gJHIk
         nmEbX8J/sVkPPeq7FU0lj/EY4TC2T5VFP7DgPiB5rbv1lp0cpLzHzxaPWADQONp8xNFW
         WSQ/yZncKRb69KyNBoQl54wbg3gX6y1GbzRZTTt46Hk4BiVeHf40VFJ9+DF8Iwhg1p73
         6bSYX1a7kgM+7MRNLFach8e5QY9vJpC3sVLG7vuVtEz8uWVtivznda5HeXDhc3P4WxA6
         uAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXi6KtXA4Gi5vbR1zNn9rtjR/2dLdRntM3ozE9CBSHbKpi++yUstO+BAWO7oowD4Ywpvy0JjG132uwNMsk@lists.openembedded.org
X-Gm-Message-State: AOJu0YxCPfXJmdAyGJlzoukIRjGKM+6UX/LE8HJ6Ms2UdjgWGO8CYwYG
	3Js5gf5+4cqfy+uuwpER2Phn9cHry0w4qbp8wnHUoW29ct4IyLVXsIWnun5PxG3ZbaYB4qWUmLV
	B/Zft3mgmOTyE4XihBigVqHEI9Gqqo64=
X-Gm-Gg: AY/fxX7Pg5pc2+FU65Kg30i+ieBZbl0LY6A8cAdB+p7gz2ekgE73aQ2JB8w5O9mE3cp
	uzrOfJ7bfgpkkoD2iZmoiDbdY0LPe6bpi54S41xpWtqw0QxCptnsU0GxMDTEDTMkTwG/pLqtxzr
	MD+xGKdE7cDRXu557SA40rAPT0pbLl8TBj2/4BAjmZlob/TPwRBJ0oPcBhu3i1qdyiU3evQQBEc
	wO25zwDcjWA7ArKlFN7l3j4WATqnaw1V9pcF4jBqGQtLCahJSDGPrdNK9F7OqzvDAz5eQmeLBb3
	1p+zwIlimrrJDXRcG8txT+ZQ/2gozw==
X-Google-Smtp-Source: AGHT+IHY2sKiPCak7/g17BeLeDzgQRa24IM3FOxiZ5WB5nGQehqEaSY2U45tAooCBx9O0pzW1CFCfdWNCQFoFmddZ+g=
X-Received: by 2002:a0c:cd91:0:b0:88f:ce0b:a008 with SMTP id
 6a1803df08f44-88fce0ba2dbmr40942236d6.3.1766402312109; Mon, 22 Dec 2025
 03:18:32 -0800 (PST)
MIME-Version: 1.0
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com> <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com>
In-Reply-To: <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Dec 2025 12:18:20 +0100
X-Gm-Features: AQt7F2rq-jC5DKS8EaHGJaTehI5EQlP9ZvcMj7DQd9UDfPOjLPDejTruyrnOCto
Message-ID: <CANNYZj9=QACpr0t_j=rk6NCv_j5GbqcP6Df_MPsg-5H3nozRXw@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: uvv.mail@gmail.com
Cc: Yoann Congal <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 11:18:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18635

On Mon, 22 Dec 2025 at 10:14, Vyacheslav Yurkov via
lists.openembedded.org <uvv.mail=gmail.com@lists.openembedded.org>
wrote:
> Try "git reflog HEAD", you should see every commit HEAD has been on (and, in theory, the commit at the tip of your branch)
>
>
> That's the first thing I'd tried. The whole layer seems to be a fresh clone.

Sadly yes, this is how bitbake's git fetcher performs unpack(). It's a
forced overwrite, with no consideration for whether there have been
local changes. We do need a guard in bb-setup for this, I guess the
good one would check the revision that was previously unpacked (it's
written into config/sources-fixed-revisions.json), and if the revision
in the actual layer doesn't match then it would ask the user in the
same way that it asks about making build/conf/ changes.

Alex

