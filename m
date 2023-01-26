Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A5C54EAA
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 21:27:26 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
 by mx.groups.io with SMTP id smtpd.web10.86910.1674768436698799078
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 13:27:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Hy7aNzaC;
 spf=pass (domain: gmail.com, ip: 209.85.161.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f52.google.com with SMTP id d16-20020a4a5210000000b004f23d1aea58so404829oob.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZugQZzKn9utmAiR5SbqtreWMI9AkQ/+i6leZBnuyem0=;
        b=Hy7aNzaCMAUUAFbKOh6hn/haN8rhUQT91Jlbii5t+QCPINcjK0Bm5zYkiCYF/Y2Kwp
         FGUnbjdfo3n7/e2Hu/e//l0rPO3pJK8HSu2Y7+PfUGEJBacf6A0QbLOGmkFMzhKEJ+7F
         cD2O48Hm8/DlPQneK144EMsHN1aZFOxutikE3gLSqTf6wwYFCxclISyDonlSSTpbDGCF
         XA/YSg9tgi2mIywsrH7mZX4hz5vFrOD1T6Zp/Rpwg1f4pu5Cwz2UFA4hXFWPcPuLJ4Qd
         n+g/IOj9tVUb1uJfEI3wHR1Hn8jk26sbHt84sHmjQCNOr6oJ+mVieVotTnflMp5VcNgB
         ihMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZugQZzKn9utmAiR5SbqtreWMI9AkQ/+i6leZBnuyem0=;
        b=OzzhbYZUVPjVF8Xeh733clq2t8NRGchZjuqAyCBy3Sd6mXiYe+hgJgTDh8U4UxHBmY
         LwGGn4EuO8Q/CSIcNrawbmNIxK3mcmyaGcqGWqpCOQvchHVJjgHJpwpWXpDDtq6/6AGH
         QfzmRQvMqPFykn9+1Cp6gJdr8p6ENJa9WkPpdc7E29HpcLFwZmseekzwbjWvfd/u7kzk
         t1xm53c6MhlIlHf0HpI1r4c69MqxFAzZHaPYs6sCr0Qu2aV3+w+eQzMDKk2lEklPrv9h
         qw0Q2H1wlMVwxvu+rut++9DHz0V8j787scIrdgcp0RpAlnbeL+MlKfBLZfCrk7n2+S2G
         U6/A==
X-Gm-Message-State: AFqh2kq7OZHSgpWWQSO0UkcUtkBI3sNS1bAB3wu7Qadz3jeNvOb+z+j1
	/jLSZ7d50mqcJGSQqGn4lBxGanR6oqo=
X-Google-Smtp-Source: AMrXdXtOxPKMnd+LzCFK/oy7tAa9xc+3P8R59wZI/WtfcdEUocTM+kXl47eZQVPWJU1F0vmgM+w/Ew==
X-Received: by 2002:a4a:4f95:0:b0:4f1:f375:c240 with SMTP id c143-20020a4a4f95000000b004f1f375c240mr18562358oob.6.1674768432926;
        Thu, 26 Jan 2023 13:27:12 -0800 (PST)
Received: from ?IPV6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id j1-20020a4aa641000000b0049bfbf7c5a8sm954686oom.38.2023.01.26.13.27.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 13:27:09 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <3c606d49-77d9-d89f-4d8d-96cb0a36f620@gmail.com>
Date: Thu, 26 Jan 2023 15:27:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Saving off warnings to a separate file with Python structured logging
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 21:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14355

It has been asked how to configure bitbake to save off WARNING messages (and higher) to a separate file when running bitbake. With python structured logging, this can be done relatively easily without having to modify any code.

First, create the structured config file (we'll call it warn.json for this example). This file should contain:

{

     "version": 1,

     "formatters": {

         "warnlogFormatter": {

             "()": "bb.msg.BBLogFormatter",

             "format": "%(levelname)s: %(message)s"

         }

     },

     "handlers": {

         "warnlog": {

             "class": "logging.FileHandler",

             "formatter": "warnlogFormatter",

             "level": "WARNING",

             "filename": "warn.log"

         }

     },

     "loggers": {

         "BitBake": {

             "handlers": ["warnlog"]

         }

     },

     "@disable_existing_loggers": false

}

After this, you need to point bitbake at this configuration file by adding to the path to it in BB_LOGCONFIG, for example:

BB_LOGCONFIG = "warn.json"


After doing this, bitbake should write all WARNING and higher messages to the file warn.log.

For more information on Python structured logging, see https://docs.python.org/3/howto/logging-cookbook.html.

Note that bitbake implements several helper classes for structured logging in lib/bb/msg.py


