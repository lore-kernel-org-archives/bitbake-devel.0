Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B0CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 10:05:11 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14435.1762250704248301093
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 02:05:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P4U2qIg2;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8802b66c811so51060776d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 02:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250703; x=1762855503; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfRDazRpVzRp9Oft1Boytn8FAziN39cQ6Xhy7OAb3XE=;
        b=P4U2qIg2Kj5VwE1HSbv1gIV2UYqLTXHukK8X/09gqRoYscfNyln5rcxBWNYaXZZPcd
         caOCH4pL2b93s5POGkO94tvaI3P+BIyfL4vebR+GwkMEf7siPnyLCtI1RzwWSbZ8JqS+
         PfhZOtAJLX8YSOo9Ic7zJFHccxKdUan6M1Y44PDb4GKRnXYLhZ70j+RCrDG3WwqzdPmN
         f0LNTgmgfbkXc7xNHf7wKj6Z32++KRsBQR0nhPPdX1JtBpkplDCkzZKGeYEEINpJfowK
         iZK4ruNBsOeNUX66Ylfa1+2BGYgykk9NYzzceOyhuqjIJTSBUU5Z6PtV2RV7zKwOwLy/
         02YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250703; x=1762855503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfRDazRpVzRp9Oft1Boytn8FAziN39cQ6Xhy7OAb3XE=;
        b=RAFgT2JwjUrJbbpTHbTgk72Pu4E8yCd6d2Ia2zvHHh/2eh/lk9kvCemuJNcYdxge45
         23XH24rJL/mGgo7YatLSfgNv9SplArNVBFYJsN1nL8dJvASFHvBkxY6HXM9dXPTzTCLa
         5QxZct45KaMWq5bIXph+YRxDH3/a1/+XmQpFAK4kVOsby64ZDzndu2rxvCJm09Gwvbx8
         Nq4YicoeiAwY0oaOJPW0KN26K4L7hPLqF9dK3HF6T54DeTXXqjKIDIES/2o18KmOUF8S
         Kh6lQSoOzY6hPBnbva+FP/uqLtSVrML6Ponti1mn0VbihNC7/Ar7ijdMNk2e0bAbLdaa
         IfAg==
X-Gm-Message-State: AOJu0YyiNmDm3BdNjZYILWV9J+hqStdFd/Uxy2n7w7F/8TDtHv7E2Qok
	4J08E6ubQdhCBa/MOeRHHaiZeJpz4INpsmyQtjrqg7KekkejKUos3rRBAsMvduIpj31shNNnhxE
	kJGH17gPDDTTnLl+GO2yZ13RpAmTFoOs=
X-Gm-Gg: ASbGncsx38xSuLg3UuoQE65qU5pPrhahViGL02fh4vt1F8kFzjJc/+8h5J6LyO5P75O
	RwR0WSeLZVRYWXP8NnmL/7/NOP+J7wDTG2M7WUTPVWC1dnzqR0gWgoDEVLXcsNPiakbwq/XtmWa
	h/OMXgmUjksJ8g9LEfkke9k9fxiRZoe1VfO4ZoQqw6Zu8m3YObX0xBmqTqjGQT5JP5S7licNzSK
	/p5TVrZ2wh0b2tb1wmO75zDtYA9CpijFyPWiHaYenOwDNKyMh6NHSf52zArxRvCEgNuS9L/0Tx/
	MRiCTEA/ykHbswCF6Vw=
X-Google-Smtp-Source: AGHT+IHRqL/ebS8xHSo3176kUAMSAegOU39D1oljH582d9pMUzMxLINPIpD6ZCZPkd36CvaYiie3vyYEz4VRD5iQY8E=
X-Received: by 2002:a05:6214:21a3:b0:876:735d:4190 with SMTP id
 6a1803df08f44-8802f2940f8mr57675506d6.13.1762250703209; Tue, 04 Nov 2025
 02:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20251103135759.1129769-1-alex.kanavin@gmail.com> <DDZ6QFANRFEB.4MFIOJHGMQ42@bootlin.com>
In-Reply-To: <DDZ6QFANRFEB.4MFIOJHGMQ42@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Nov 2025 11:04:52 +0100
X-Gm-Features: AWmQ_blFfEJDtVyGktFVa2aomQI1DeyvYom2ELFjMdyPxKroRDEVL_IAMj2s83U
Message-ID: <CANNYZj8PGsV+fEJQEXcvn0gyt3-Oa6GNxhxWdn-pC7+deaFM0A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: rename 'build' -> 'setup'
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 10:05:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18247

On Mon, 3 Nov 2025 at 17:03, Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
> Note, this will break with current configuration on the autobuilder, we
> will have to modify the parameters we pass to bitbake-setup.

I sent a patch to yocto-patches for this just now.

Alex

