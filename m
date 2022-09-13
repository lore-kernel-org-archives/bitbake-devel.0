Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809BC54EE9
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:30 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web09.5465.1663079247735907587
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=cV19OBeJ;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.176,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f176.google.com with SMTP id c24so11470525pgg.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=SQQozrF2B7Si5qVKeRDFjwFn8Av+q4JfnFilhotDfQI=;
        b=cV19OBeJFVPmj5ubKF4dErfljRehye7jdzhYGJYsEeHsFESe8DcXLu3LSpnhIyRalr
         K3y5iIWNOVEqnwDLamA8HYu0fcKi17mQKmyVelrrjBaj8d+Pi6d2IjM97SbHko+djTRP
         ym3AuczkqfXANpprvYp/2beF4rpQ6dxN/f5EN1eZKo0N6LU+PoqtjG5EGZZZvU6QR7H9
         EJJr2I9H7Jl0QUufsUJ0CAqgWoGv+49nQa7y85P5daVML71E5km4Izl3D6pKHVff1kVh
         SzfdSZ1C26a/vcVHWDvpwuL7dk5hR+qu5Z7k/hfAVv4g361Ui14Zq/fl7zwWzziw8FR8
         oeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SQQozrF2B7Si5qVKeRDFjwFn8Av+q4JfnFilhotDfQI=;
        b=II3eP1Oiflc+M96ZFZ7B/iIpPFTYD7rKPb5pbjxGi2gnCRYbO4P59fFn+feHwHRWeG
         6ZB6iHYNjOyj15eirqadqAhog3k4gzhHgUzi/Dvq8PE+1aYQnNcUKlneG+qULNz8foaK
         P52TPNFRJa/yw6xKmxSDu18J9IpNLKLOz8qs0IG/g2WoLcAT3SDX49mByvHXuYgcs0pL
         c59CILb+qkptFh9qpK2NCuzbzZY1cI6vhWqCu9cylVTIZ/0nN/yry7PKNzd3BTRkkqje
         Ub36cAugdm+p1UpguqaXmgxfz5kNh4kZgM8/BBSmBsZa38IggnKxCBewHyA9zY6dW4aB
         ND5A==
X-Gm-Message-State: ACgBeo3dLCh1UP8UEU0b7/uHdCuFhxA5BBFY+p6YnRvC4Q5sD3y0GCHU
	6wK/77242lWJ65cs+iFEJ29fVY5uXjO1S50r
X-Google-Smtp-Source: 
 AA6agR5eEo8W0Y5jS4j8V0TfJU3My72yhrGIEktrP2GPu+HOtd8yJRBGd0E4td4sEJ0akvJseMQ0Dw==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id
 q15-20020a056a00088f00b005300dec81fdmr33517709pfj.64.1663079246556;
        Tue, 13 Sep 2022 07:27:26 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:25 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 11/14] bitbake: bitbake-user-manual:
 hashserv can be accessed on a dedicated domain
Date: Tue, 13 Sep 2022 04:26:41 -1000
Message-Id: 
 <9d27db5320fd9cf8bbed3b5a2b0e84a4f6e5138e.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13972

From: Jose Quaresma <quaresma.jose@gmail.com>

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
(cherry picked from commit b171aa45fb8518dcfbba315b303a4fe9bf2180c6)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index af4ff980..12aef3cb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -401,7 +401,7 @@ overview of their function and contents.
 
       Example usage::
 
-         BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
+         BB_HASHSERVE_UPSTREAM = "hashserv.yocto.io:8687"
 
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
-- 
2.25.1


